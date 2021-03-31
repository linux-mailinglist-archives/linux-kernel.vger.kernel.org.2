Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA495347AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhCXObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:31:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:34034 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236194AbhCXOax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:30:53 -0400
IronPort-SDR: HCrT4R+bVHMq43IkgIA5sEhiRuGxWUad0hbE7U69iCOuspIgPYbq3C8u/PuD1liEFB0jvmsO2K
 MQxwY3VBB80Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="188412901"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="188412901"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:30:52 -0700
IronPort-SDR: AQGxa42H4oPkERetQnl6P1+B96esQP0F8l5bE/0QHcIh18+rex4z27OldS0UB0MS3k5eKGZAxY
 YIM2BreYEVWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="391319519"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2021 07:30:49 -0700
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH v5 3/4] perf stat: Enable iostat mode for x86 platforms
Date:   Wed, 24 Mar 2021 17:30:36 +0300
Message-Id: <20210324143037.3810-4-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210324143037.3810-1-alexander.antonov@linux.intel.com>
References: <20210324143037.3810-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This functionality is based on recently introduced sysfs attributes
for Intel® Xeon® Scalable processor family (code name Skylake-SP):
Commit bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to
IIO PMON mapping")

Mode is intended to provide four I/O performance metrics in MB per each
PCIe root port:
 - Inbound Read: I/O devices below root port read from the host memory
 - Inbound Write: I/O devices below root port write to the host memory
 - Outbound Read: CPU reads from I/O devices below root port
 - Outbound Write: CPU writes to I/O devices below root port

Each metric requiries only one uncore event which increments at every 4B
transfer in corresponding direction. The formulas to compute metrics
are generic:
    #EventCount * 4B / (1024 * 1024)

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/Documentation/perf-iostat.txt |  88 ++++++
 tools/perf/Makefile.perf                 |   5 +-
 tools/perf/arch/x86/util/Build           |   1 +
 tools/perf/arch/x86/util/iostat.c        | 360 +++++++++++++++++++++++
 tools/perf/command-list.txt              |   1 +
 tools/perf/perf-iostat.sh                |  12 +
 6 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/Documentation/perf-iostat.txt
 create mode 100644 tools/perf/perf-iostat.sh

diff --git a/tools/perf/Documentation/perf-iostat.txt b/tools/perf/Documentation/perf-iostat.txt
new file mode 100644
index 000000000000..165176944031
--- /dev/null
+++ b/tools/perf/Documentation/perf-iostat.txt
@@ -0,0 +1,88 @@
+perf-iostat(1)
+===============
+
+NAME
+----
+perf-iostat - Show I/O performance metrics
+
+SYNOPSIS
+--------
+[verse]
+'perf iostat' list
+'perf iostat' <ports> -- <command> [<options>]
+
+DESCRIPTION
+-----------
+Mode is intended to provide four I/O performance metrics per each PCIe root port:
+
+- Inbound Read   - I/O devices below root port read from the host memory, in MB
+
+- Inbound Write  - I/O devices below root port write to the host memory, in MB
+
+- Outbound Read  - CPU reads from I/O devices below root port, in MB
+
+- Outbound Write - CPU writes to I/O devices below root port, in MB
+
+OPTIONS
+-------
+<command>...::
+	Any command you can specify in a shell.
+
+list::
+	List all PCIe root ports.
+
+<ports>::
+	Select the root ports for monitoring. Comma-separated list is supported.
+
+EXAMPLES
+--------
+
+1. List all PCIe root ports (example for 2-S platform):
+
+   $ perf iostat list
+   S0-uncore_iio_0<0000:00>
+   S1-uncore_iio_0<0000:80>
+   S0-uncore_iio_1<0000:17>
+   S1-uncore_iio_1<0000:85>
+   S0-uncore_iio_2<0000:3a>
+   S1-uncore_iio_2<0000:ae>
+   S0-uncore_iio_3<0000:5d>
+   S1-uncore_iio_3<0000:d7>
+
+2. Collect metrics for all PCIe root ports:
+
+   $ perf iostat -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
+   357708+0 records in
+   357707+0 records out
+   375083606016 bytes (375 GB, 349 GiB) copied, 215.974 s, 1.7 GB/s
+
+    Performance counter stats for 'system wide':
+
+      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
+   0000:00                    1                    0                    2                    3
+   0000:80                    0                    0                    0                    0
+   0000:17               352552                   43                    0                   21
+   0000:85                    0                    0                    0                    0
+   0000:3a                    3                    0                    0                    0
+   0000:ae                    0                    0                    0                    0
+   0000:5d                    0                    0                    0                    0
+   0000:d7                    0                    0                    0                    0
+
+3. Collect metrics for comma-separated list of PCIe root ports:
+
+   $ perf iostat 0000:17,0:3a -- dd if=/dev/zero of=/dev/nvme0n1 bs=1M oflag=direct
+   357708+0 records in
+   357707+0 records out
+   375083606016 bytes (375 GB, 349 GiB) copied, 197.08 s, 1.9 GB/s
+
+    Performance counter stats for 'system wide':
+
+      port             Inbound Read(MB)    Inbound Write(MB)    Outbound Read(MB)   Outbound Write(MB)
+   0000:17               358559                   44                    0                   22
+   0000:3a                    3                    2                    0                    0
+
+        197.081983474 seconds time elapsed
+
+SEE ALSO
+--------
+linkperf:perf-stat[1]
\ No newline at end of file
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a7d768fdc8a1..3b3a452f4862 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -283,6 +283,7 @@ SCRIPT_SH =
 
 SCRIPT_SH += perf-archive.sh
 SCRIPT_SH += perf-with-kcore.sh
+SCRIPT_SH += perf-iostat.sh
 
 grep-libs = $(filter -l%,$(1))
 strip-libs = $(filter-out -l%,$(1))
@@ -948,6 +949,8 @@ endif
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 	$(call QUIET_INSTALL, perf-with-kcore) \
 		$(INSTALL) $(OUTPUT)perf-with-kcore -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
+	$(call QUIET_INSTALL, perf-iostat) \
+		$(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 ifndef NO_LIBAUDIT
 	$(call QUIET_INSTALL, strace/groups) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'; \
@@ -1041,7 +1044,7 @@ bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
 clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
-	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
+	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
 	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)pmu-events/jevents $(OUTPUT)$(LIBJVMTI).so
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 0c72d418932e..dbeb04cb336e 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -9,6 +9,7 @@ perf-y += event.o
 perf-y += evlist.o
 perf-y += mem-events.o
 perf-y += evsel.o
+perf-y += iostat.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index c4471f8efa5e..d63acb782b63 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -27,6 +27,36 @@
 #include "util/counts.h"
 #include "path.h"
 
+#ifndef MAX_PATH
+#define MAX_PATH 1024
+#endif
+
+#define UNCORE_IIO_PMU_PATH	"devices/uncore_iio_%d"
+#define SYSFS_UNCORE_PMU_PATH	"%s/"UNCORE_IIO_PMU_PATH
+#define PLATFORM_MAPPING_PATH	UNCORE_IIO_PMU_PATH"/die%d"
+
+/*
+ * Each metric requiries one IIO event which increments at every 4B transfer
+ * in corresponding direction. The formulas to compute metrics are generic:
+ *     #EventCount * 4B / (1024 * 1024)
+ */
+static const char * const iostat_metrics[] = {
+	"Inbound Read(MB)",
+	"Inbound Write(MB)",
+	"Outbound Read(MB)",
+	"Outbound Write(MB)",
+};
+
+static inline int iostat_metrics_count(void)
+{
+	return sizeof(iostat_metrics) / sizeof(char *);
+}
+
+static const char *iostat_metric_by_idx(int idx)
+{
+	return *(iostat_metrics + idx % iostat_metrics_count());
+}
+
 struct iio_root_port {
 	u32 domain;
 	u8 bus;
@@ -40,6 +70,8 @@ struct iio_root_ports_list {
 	int nr_entries;
 };
 
+static struct iio_root_ports_list *root_ports;
+
 static void iio_root_port_show(FILE *output,
 			       const struct iio_root_port * const rp)
 {
@@ -108,3 +140,331 @@ static int iio_root_ports_list_insert(struct iio_root_ports_list *list,
 	}
 	return 0;
 }
+
+static int iio_mapping(u8 pmu_idx, struct iio_root_ports_list * const list)
+{
+	char *buf;
+	char path[MAX_PATH];
+	u32 domain;
+	u8 bus;
+	struct iio_root_port *rp;
+	size_t size;
+	int ret;
+
+	for (int die = 0; die < cpu__max_node(); die++) {
+		scnprintf(path, MAX_PATH, PLATFORM_MAPPING_PATH, pmu_idx, die);
+		if (sysfs__read_str(path, &buf, &size) < 0) {
+			if (pmu_idx)
+				goto out;
+			pr_err("Mode iostat is not supported\n");
+			return -1;
+		}
+		ret = sscanf(buf, "%04x:%02hhx", &domain, &bus);
+		free(buf);
+		if (ret != 2) {
+			pr_err("Invalid mapping data: iio_%d; die%d\n",
+			       pmu_idx, die);
+			return -1;
+		}
+		rp = iio_root_port_new(domain, bus, die, pmu_idx);
+		if (!rp || iio_root_ports_list_insert(list, rp)) {
+			free(rp);
+			return -ENOMEM;
+		}
+	}
+out:
+	return 0;
+}
+
+static u8 iio_pmu_count(void)
+{
+	u8 pmu_idx = 0;
+	char path[MAX_PATH];
+	const char *sysfs = sysfs__mountpoint();
+
+	if (sysfs) {
+		for (;; pmu_idx++) {
+			snprintf(path, sizeof(path), SYSFS_UNCORE_PMU_PATH,
+				 sysfs, pmu_idx);
+			if (access(path, F_OK) != 0)
+				break;
+		}
+	}
+	return pmu_idx;
+}
+
+static int iio_root_ports_scan(struct iio_root_ports_list **list)
+{
+	int ret = -ENOMEM;
+	struct iio_root_ports_list *tmp_list;
+	u8 pmu_count = iio_pmu_count();
+
+	if (!pmu_count) {
+		pr_err("Unsupported uncore pmu configuration\n");
+		return -1;
+	}
+
+	tmp_list = calloc(1, sizeof(*tmp_list));
+	if (!tmp_list)
+		goto err;
+
+	for (u8 pmu_idx = 0; pmu_idx < pmu_count; pmu_idx++) {
+		ret = iio_mapping(pmu_idx, tmp_list);
+		if (ret)
+			break;
+	}
+err:
+	if (!ret)
+		*list = tmp_list;
+	else
+		iio_root_ports_list_free(tmp_list);
+
+	return ret;
+}
+
+static int iio_root_port_parse_str(u32 *domain, u8 *bus, char *str)
+{
+	int ret;
+	regex_t regex;
+	/*
+	 * Expected format domain:bus:
+	 * Valid domain range [0:ffff]
+	 * Valid bus range [0:ff]
+	 * Example: 0000:af, 0:3d, 01:7
+	 */
+	regcomp(&regex, "^([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})", REG_EXTENDED);
+	ret = regexec(&regex, str, 0, NULL, 0);
+	if (ret || sscanf(str, "%08x:%02hhx", domain, bus) != 2)
+		pr_warning("Unrecognized root port format: %s\n"
+			   "Please use the following format:\n"
+			   "\t [domain]:[bus]\n"
+			   "\t for example: 0000:3d\n", str);
+
+	regfree(&regex);
+	return ret;
+}
+
+static int iio_root_ports_list_filter(struct iio_root_ports_list **list,
+				      const char *filter)
+{
+	char *tok, *tmp, *filter_copy = NULL;
+	struct iio_root_port *rp;
+	u32 domain;
+	u8 bus;
+	int ret = -ENOMEM;
+	struct iio_root_ports_list *tmp_list = calloc(1, sizeof(*tmp_list));
+
+	if (!tmp_list)
+		goto err;
+
+	filter_copy = strdup(filter);
+	if (!filter_copy)
+		goto err;
+
+	for (tok = strtok_r(filter_copy, ",", &tmp); tok;
+	     tok = strtok_r(NULL, ",", &tmp)) {
+		if (!iio_root_port_parse_str(&domain, &bus, tok)) {
+			rp = iio_root_port_find_by_notation(*list, domain, bus);
+			if (rp) {
+				(*list)->rps[rp->idx] = NULL;
+				ret = iio_root_ports_list_insert(tmp_list, rp);
+				if (ret) {
+					free(rp);
+					goto err;
+				}
+			} else if (!iio_root_port_find_by_notation(tmp_list,
+								   domain, bus))
+				pr_warning("Root port %04x:%02x were not found\n",
+					   domain, bus);
+		}
+	}
+
+	if (tmp_list->nr_entries == 0) {
+		pr_err("Requested root ports were not found\n");
+		ret = -EINVAL;
+	}
+err:
+	iio_root_ports_list_free(*list);
+	if (ret)
+		iio_root_ports_list_free(tmp_list);
+	else
+		*list = tmp_list;
+
+	free(filter_copy);
+	return ret;
+}
+
+static int iostat_event_group(struct evlist *evl,
+			      struct iio_root_ports_list *list)
+{
+	int ret;
+	int idx;
+	const char *iostat_cmd_template =
+	"{uncore_iio_%x/event=0x83,umask=0x04,ch_mask=0xF,fc_mask=0x07/,\
+	  uncore_iio_%x/event=0x83,umask=0x01,ch_mask=0xF,fc_mask=0x07/,\
+	  uncore_iio_%x/event=0xc0,umask=0x04,ch_mask=0xF,fc_mask=0x07/,\
+	  uncore_iio_%x/event=0xc0,umask=0x01,ch_mask=0xF,fc_mask=0x07/}";
+	const int len_template = strlen(iostat_cmd_template) + 1;
+	struct evsel *evsel = NULL;
+	int metrics_count = iostat_metrics_count();
+	char *iostat_cmd = calloc(len_template, 1);
+
+	if (!iostat_cmd)
+		return -ENOMEM;
+
+	for (idx = 0; idx < list->nr_entries; idx++) {
+		sprintf(iostat_cmd, iostat_cmd_template,
+			list->rps[idx]->pmu_idx, list->rps[idx]->pmu_idx,
+			list->rps[idx]->pmu_idx, list->rps[idx]->pmu_idx);
+		ret = parse_events(evl, iostat_cmd, NULL);
+		if (ret)
+			goto err;
+	}
+
+	evlist__for_each_entry(evl, evsel) {
+		evsel->priv = list->rps[evsel->idx / metrics_count];
+	}
+	list->nr_entries = 0;
+err:
+	iio_root_ports_list_free(list);
+	free(iostat_cmd);
+	return ret;
+}
+
+int iostat_prepare(struct evlist *evlist, struct perf_stat_config *config)
+{
+	if (evlist->core.nr_entries > 0) {
+		pr_warning("The -e and -M options are not supported."
+			   "All chosen events/metrics will be dropped\n");
+		evlist__delete(evlist);
+		evlist = evlist__new();
+		if (!evlist)
+			return -ENOMEM;
+	}
+
+	config->metric_only = true;
+	config->aggr_mode = AGGR_GLOBAL;
+
+	return iostat_event_group(evlist, root_ports);
+}
+
+int iostat_parse(const struct option *opt, const char *str,
+		 int unset __maybe_unused)
+{
+	int ret;
+	struct perf_stat_config *config = (struct perf_stat_config *)opt->data;
+
+	ret = iio_root_ports_scan(&root_ports);
+	if (!ret) {
+		config->iostat_run = true;
+		if (!str)
+			iostat_mode = IOSTAT_RUN;
+		else if (!strcmp(str, "list"))
+			iostat_mode = IOSTAT_LIST;
+		else {
+			iostat_mode = IOSTAT_RUN;
+			ret = iio_root_ports_list_filter(&root_ports, str);
+		}
+	}
+	return ret;
+}
+
+void iostat_list(struct evlist *evlist, struct perf_stat_config *config)
+{
+	struct evsel *evsel;
+	struct iio_root_port *rp = NULL;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (rp != evsel->priv) {
+			rp = evsel->priv;
+			iio_root_port_show(config->output, rp);
+		}
+	}
+}
+
+void iostat_release(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	struct iio_root_port *rp = NULL;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (rp != evsel->priv) {
+			rp = evsel->priv;
+			free(evsel->priv);
+		}
+	}
+}
+
+void iostat_prefix(struct evlist *evlist,
+		   struct perf_stat_config *config,
+		   char *prefix, struct timespec *ts)
+{
+	struct iio_root_port *rp = evlist->selected->priv;
+
+	if (rp) {
+		if (ts)
+			sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
+				ts->tv_sec, ts->tv_nsec,
+				config->csv_sep, rp->domain, rp->bus,
+				config->csv_sep);
+		else
+			sprintf(prefix, "%04x:%02x%s", rp->domain, rp->bus,
+				config->csv_sep);
+	}
+}
+
+void iostat_print_header_prefix(struct perf_stat_config *config)
+{
+	if (config->csv_output)
+		fputs("port,", config->output);
+	else if (config->interval)
+		fprintf(config->output, "#          time    port         ");
+	else
+		fprintf(config->output, "   port         ");
+}
+
+void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
+			 struct perf_stat_output_ctx *out)
+{
+	double iostat_value = 0;
+	u64 prev_count_val = 0;
+	const char *iostat_metric = iostat_metric_by_idx(evsel->idx);
+	u8 die = ((struct iio_root_port *)evsel->priv)->die;
+	struct perf_counts_values *count = perf_counts(evsel->counts, die, 0);
+
+	if (count->run && count->ena) {
+		if (evsel->prev_raw_counts && !out->force_header) {
+			struct perf_counts_values *prev_count =
+				perf_counts(evsel->prev_raw_counts, die, 0);
+
+			prev_count_val = prev_count->val;
+			prev_count->val = count->val;
+		}
+		iostat_value = (count->val - prev_count_val) /
+			       ((double) count->run / count->ena);
+	}
+	out->print_metric(config, out->ctx, NULL, "%8.0f", iostat_metric,
+			  iostat_value / (256 * 1024));
+}
+
+void iostat_print_counters(struct evlist *evlist,
+			   struct perf_stat_config *config, struct timespec *ts,
+			   char *prefix, iostat_print_counter_t print_cnt_cb)
+{
+	void *perf_device = NULL;
+	struct evsel *counter = evlist__first(evlist);
+
+	evlist__set_selected(evlist, counter);
+	iostat_prefix(evlist, config, prefix, ts);
+	fprintf(config->output, "%s", prefix);
+	evlist__for_each_entry(evlist, counter) {
+		perf_device = evlist->selected->priv;
+		if (perf_device && perf_device != counter->priv) {
+			evlist__set_selected(evlist, counter);
+			iostat_prefix(evlist, config, prefix, ts);
+			fprintf(config->output, "\n%s", prefix);
+		}
+		print_cnt_cb(config, counter, prefix);
+	}
+	fputc('\n', config->output);
+}
diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index 825a12e8d694..4aa034aefa33 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -14,6 +14,7 @@ perf-config			mainporcelain common
 perf-evlist			mainporcelain common
 perf-ftrace			mainporcelain common
 perf-inject			mainporcelain common
+perf-iostat			mainporcelain common
 perf-kallsyms			mainporcelain common
 perf-kmem			mainporcelain common
 perf-kvm			mainporcelain common
diff --git a/tools/perf/perf-iostat.sh b/tools/perf/perf-iostat.sh
new file mode 100644
index 000000000000..e562f252d56f
--- /dev/null
+++ b/tools/perf/perf-iostat.sh
@@ -0,0 +1,12 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf iostat
+# Alexander Antonov <alexander.antonov@linux.intel.com>
+
+if [[ "$1" == "list" ]] || [[ "$1" =~ ([a-f0-9A-F]{1,}):([a-f0-9A-F]{1,2})(,)? ]]; then
+        DELIMITER="="
+else
+        DELIMITER=" "
+fi
+
+perf stat --iostat$DELIMITER$*
-- 
2.19.1

