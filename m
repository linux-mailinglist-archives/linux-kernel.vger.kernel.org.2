Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62F312268
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBGIMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:12:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:18019 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGIL7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:11:59 -0500
IronPort-SDR: adJ6OIu2r4n1RjiE3iG8sx/CYmfVv1W7FnD4/zgEBHVXIdyXudENfnSKLOM2tqkyYC+Lctuu0I
 bu6hMLQ3EOQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="266423839"
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="266423839"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 00:10:13 -0800
IronPort-SDR: Da0NcMwp5Rgo/3k/4sIjvjUPKKJQ5R4bnZjDZEqNqpHE19LFjP0Fl6KqrFYWB8AZ8lhsu/ybOP
 /9OjKOYaySnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="486538939"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2021 00:10:10 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 2/2] perf script: Support filtering by hex address
Date:   Sun,  7 Feb 2021 16:09:35 +0800
Message-Id: <20210207080935.31784-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210207080935.31784-1-yao.jin@linux.intel.com>
References: <20210207080935.31784-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf-script supports '-S' or '--symbol' options to only list the
trace records in given symbols. Symbol is typically a name
or hex address. If it's hex address, it is the start address of
one symbol.

While it would be useful if we can filter trace records by any hex
address (not only the start address of symbol). So now we support
filtering trace records by more conditions, such as:
- symbol name
- start address of symbol
- any hexadecimal address
- address range

The comparison order is defined as:

1. symbol name comparison
2. symbol start address comparison.
3. any hexadecimal address comparison.
4. address range comparison.

The idea is if we can get a valid address from -S list, we add the
address to addr_list for address comparison otherwise we still leave
it to sym_list for symbol comparison.

Some examples:

root@kbl-ppc:~# ./perf script -S ffffffff9a477308
            perf  8562 [000] 347303.578858:          1   cycles:  ffffffff9a477308 native_write_msr+0x8 ([kernel.kallsyms])
            perf  8562 [000] 347303.578860:          1   cycles:  ffffffff9a477308 native_write_msr+0x8 ([kernel.kallsyms])
            perf  8562 [000] 347303.578861:         11   cycles:  ffffffff9a477308 native_write_msr+0x8 ([kernel.kallsyms])
            perf  8562 [001] 347303.578903:          1   cycles:  ffffffff9a477308 native_write_msr+0x8 ([kernel.kallsyms])
            perf  8562 [001] 347303.578905:          1   cycles:  ffffffff9a477308 native_write_msr+0x8 ([kernel.kallsyms])
            perf  8562 [001] 347303.578906:         15   cycles:  ffffffff9a477308 native_write_msr+0x8 ([kernel.kallsyms])
            perf  8562 [002] 347303.578952:          1   cycles:  ffffffff9a477308 native_write_msr+0x8 ([kernel.kallsyms])
            perf  8562 [002] 347303.578953:          1   cycles:  ffffffff9a477308 native_write_msr+0x8 ([kernel.kallsyms])

Filter the traced records by hex address ffffffff9a477308.

root@kbl-ppc:~# ./perf script -S ffffffff9a4dd4ce,ffffffff9a4d2de9,ffffffff9a6bf9f4
            perf  8562 [001] 347303.578911:     311706   cycles:  ffffffff9a6bf9f4 __kmalloc_node+0x204 ([kernel.kallsyms])
            perf  8562 [002] 347303.578960:     354477   cycles:  ffffffff9a4d2de9 sched_setaffinity+0x49 ([kernel.kallsyms])
            perf  8562 [003] 347303.579015:     450958   cycles:  ffffffff9a4dd4ce dequeue_task_fair+0x1ae ([kernel.kallsyms])

Filter the traced records by hex address ffffffff9a4dd4ce, ffffffff9a4d2de9, ffffffff9a6bf9f4.

root@kbl-ppc:~# ./perf script -S ffffffff9a477309 --addr-range 16
            perf  8562 [000] 347303.578863:        291   cycles:  ffffffff9a47730a native_write_msr+0xa ([kernel.kallsyms])
            perf  8562 [001] 347303.578907:        411   cycles:  ffffffff9a47730a native_write_msr+0xa ([kernel.kallsyms])
            perf  8562 [002] 347303.578956:        462   cycles:  ffffffff9a47730f native_write_msr+0xf ([kernel.kallsyms])
            perf  8562 [003] 347303.579010:        497   cycles:  ffffffff9a47730f native_write_msr+0xf ([kernel.kallsyms])
            perf  8562 [004] 347303.579059:        429   cycles:  ffffffff9a47730f native_write_msr+0xf ([kernel.kallsyms])
            perf  8562 [005] 347303.579109:        408   cycles:  ffffffff9a47730a native_write_msr+0xa ([kernel.kallsyms])
            perf  8562 [006] 347303.579159:        460   cycles:  ffffffff9a47730f native_write_msr+0xf ([kernel.kallsyms])
            perf  8562 [007] 347303.579213:        436   cycles:  ffffffff9a47730f native_write_msr+0xf ([kernel.kallsyms])

Filter the traced records from address range [ffffffff9a477309, ffffffff9a477309 + 15].

root@kbl-ppc:~# ./perf script -S "ffffffff9b163046,rcu_nmi_exit"
            perf  8562 [004] 347303.579060:      12013   cycles:  ffffffff9b163046 exc_nmi+0x166 ([kernel.kallsyms])
            perf  8562 [007] 347303.579214:      12138   cycles:  ffffffff9b165944 rcu_nmi_exit+0x34 ([kernel.kallsyms])

Filter by address + symbol

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v3:
   Update setup_addrlist:
   1. Add more checks for strtoul (errno, space and etc). 
   2. Don't break when detect an invalid address, just save the
      valid address to addr_list. 

 v2:
   Use intlist for address list.

 tools/perf/Documentation/perf-script.txt | 19 +++++++++
 tools/perf/builtin-script.c              |  2 +
 tools/perf/util/event.c                  | 24 ++++++++++++
 tools/perf/util/symbol.c                 | 49 ++++++++++++++++++++++++
 tools/perf/util/symbol_conf.h            |  4 +-
 5 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 60dae302db27..4c37f193a231 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -422,9 +422,28 @@ include::itrace.txt[]
 	Only consider the listed symbols. Symbols are typically a name
 	but they may also be hexadecimal address.
 
+	The hexadecimal address may be the start address of a symbol or
+	any other address to filter the trace records.
+
 	For example, to select the symbol noploop or the address 0x4007a0:
 	perf script --symbols=noploop,0x4007a0
 
+	Support filtering trace records by symbol name, start address of
+	symbol, any hexadecimal address and address range.
+
+	The comparison order is:
+	1. symbol name comparison
+	2. symbol start address comparison.
+	3. any hexadecimal address comparison.
+	4. address range comparison (see --addr-range).
+
+--addr-range::
+	Use with -S or --symbols to list traced records within address range.
+
+	For example, to list the traced records within the address range
+	[0x4007a0, 0x0x4007a9]:
+	perf script -S 0x4007a0 --addr-range 10
+
 --call-trace::
 	Show call stream for intel_pt traces. The CPUs are interleaved, but
 	can be filtered with -C.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9e995311a9b8..3d9e70e19196 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3534,6 +3534,8 @@ int cmd_script(int argc, const char **argv)
 		    "system-wide collection from all CPUs"),
 	OPT_STRING('S', "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]",
 		   "only consider these symbols"),
+	OPT_INTEGER(0, "addr-range", &symbol_conf.addr_range,
+		    "Use with -S to list traced records within address range"),
 	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
 			"Decode instructions from itrace", parse_insn_trace),
 	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fbe8578e4c47..8cc70aa630cc 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -645,6 +645,19 @@ struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
 	return al->sym;
 }
 
+static bool check_address_range(struct intlist *addr_list, int addr_range,
+				unsigned long addr)
+{
+	struct int_node *pos;
+
+	intlist__for_each_entry(pos, addr_list) {
+		if (addr >= pos->i && addr < pos->i + addr_range)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Callers need to drop the reference to al->thread, obtained in
  * machine__findnew_thread()
@@ -709,6 +722,17 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 			ret = strlist__has_entry(symbol_conf.sym_list,
 						al_addr_str);
 		}
+		if (!ret && symbol_conf.addr_list && al->map) {
+			unsigned long addr = al->map->unmap_ip(al->map, al->addr);
+
+			ret = intlist__has_entry(symbol_conf.addr_list, addr);
+			if (!ret && symbol_conf.addr_range) {
+				ret = check_address_range(symbol_conf.addr_list,
+							  symbol_conf.addr_range,
+							  addr);
+			}
+		}
+
 		if (!ret)
 			al->filtered |= (1 << HIST_FILTER__SYMBOL);
 	}
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 64a039cbba1b..40844d0ef6cc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2406,6 +2406,49 @@ int setup_intlist(struct intlist **list, const char *list_str,
 	return 0;
 }
 
+static int setup_addrlist(struct intlist **addr_list, struct strlist *sym_list)
+{
+	struct str_node *pos, *tmp;
+	unsigned long val;
+	char *sep;
+	const char *end;
+	int i = 0, err;
+
+	*addr_list = intlist__new(NULL);
+	if (!*addr_list)
+		return -1;
+
+	strlist__for_each_entry_safe(pos, tmp, sym_list) {
+		errno = 0;
+		val = strtoul(pos->s, &sep, 16);
+		if (errno || (sep == pos->s))
+			continue;
+
+		if (*sep != '\0') {
+			end = pos->s + strlen(pos->s) - 1;
+			while (end >= sep && isspace(*end))
+				end--;
+
+			if (end >= sep)
+				continue;
+		}
+
+		err = intlist__add(*addr_list, val);
+		if (err)
+			break;
+
+		strlist__remove(sym_list, pos);
+		i++;
+	}
+
+	if (i == 0) {
+		intlist__delete(*addr_list);
+		*addr_list = NULL;
+	}
+
+	return 0;
+}
+
 static bool symbol__read_kptr_restrict(void)
 {
 	bool value = false;
@@ -2489,6 +2532,10 @@ int symbol__init(struct perf_env *env)
 		       symbol_conf.sym_list_str, "symbol") < 0)
 		goto out_free_tid_list;
 
+	if (symbol_conf.sym_list &&
+	    setup_addrlist(&symbol_conf.addr_list, symbol_conf.sym_list) < 0)
+		goto out_free_sym_list;
+
 	if (setup_list(&symbol_conf.bt_stop_list,
 		       symbol_conf.bt_stop_list_str, "symbol") < 0)
 		goto out_free_sym_list;
@@ -2512,6 +2559,7 @@ int symbol__init(struct perf_env *env)
 
 out_free_sym_list:
 	strlist__delete(symbol_conf.sym_list);
+	intlist__delete(symbol_conf.addr_list);
 out_free_tid_list:
 	intlist__delete(symbol_conf.tid_list);
 out_free_pid_list:
@@ -2533,6 +2581,7 @@ void symbol__exit(void)
 	strlist__delete(symbol_conf.comm_list);
 	intlist__delete(symbol_conf.tid_list);
 	intlist__delete(symbol_conf.pid_list);
+	intlist__delete(symbol_conf.addr_list);
 	vmlinux_path__exit();
 	symbol_conf.sym_list = symbol_conf.dso_list = symbol_conf.comm_list = NULL;
 	symbol_conf.bt_stop_list = NULL;
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index b18f9c8dbb75..a70b3ec09dac 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -70,11 +70,13 @@ struct symbol_conf {
 			*sym_to_list,
 			*bt_stop_list;
 	struct intlist	*pid_list,
-			*tid_list;
+			*tid_list,
+			*addr_list;
 	const char	*symfs;
 	int		res_sample;
 	int		pad_output_len_dso;
 	int		group_sort_idx;
+	int		addr_range;
 };
 
 extern struct symbol_conf symbol_conf;
-- 
2.17.1

