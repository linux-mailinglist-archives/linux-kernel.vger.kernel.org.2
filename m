Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBC1308646
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhA2HL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:11:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:17137 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232221AbhA2HLS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:11:18 -0500
IronPort-SDR: 7ZlMAf4w4EfW5vNrF4VO+yy2xJmOZSG2LhCvpObGUOL2KMrEWP3Q/NPkFPDPAAq+nPuc0b6PM3
 5VDCcUyPaHTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="180456127"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="180456127"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 23:09:32 -0800
IronPort-SDR: kDBHCa3BW24+zXRrSbPiPTk04NyIFmnItfrrtxSr1iNkXMJdnAfyJXMsQ59XGVs0hNEOlcXHNI
 1UOAY1v/WBZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="474428981"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2021 23:09:29 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/2] perf script: Support filtering by hex address
Date:   Fri, 29 Jan 2021 15:08:54 +0800
Message-Id: <20210129070854.29312-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129070854.29312-1-yao.jin@linux.intel.com>
References: <20210129070854.29312-1-yao.jin@linux.intel.com>
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

Let's see some examples:

root@kbl-ppc:~# ./perf script -S 0xffffffff9ca77308
            perf 18123 [000] 6142863.075104:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075107:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075108:         10   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075156:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075158:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075159:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075202:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075204:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075205:         16   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075250:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075252:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075253:         16   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])

Filter the traced records by hex address 0xffffffff9ca77308.

Easy to use, we support the hex address without '0x' prefix,
e.g.
./perf script -S ffffffff9ca77308

It has the same effect.

We also support to filter trace records by a address range.

root@kbl-ppc:~# ./perf script -S ffffffff9ca77304 --addr-range 16
            perf 18123 [000] 6142863.075104:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075107:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075108:         10   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [000] 6142863.075109:        273   cycles:  ffffffff9ca7730a native_write_msr+0xa ([kernel.kallsyms])
            perf 18123 [001] 6142863.075156:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075158:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075159:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [001] 6142863.075160:        456   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [002] 6142863.075202:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075204:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075205:         16   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [002] 6142863.075206:        436   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [003] 6142863.075250:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075252:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075253:         16   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [003] 6142863.075254:        436   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [004] 6142863.075299:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [004] 6142863.075301:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [004] 6142863.075302:         16   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [004] 6142863.075303:        431   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [005] 6142863.075348:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [005] 6142863.075349:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [005] 6142863.075351:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [005] 6142863.075352:        454   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [006] 6142863.075390:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [006] 6142863.075392:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [006] 6142863.075393:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [006] 6142863.075394:        459   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])
            perf 18123 [007] 6142863.075438:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [007] 6142863.075440:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [007] 6142863.075441:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
            perf 18123 [007] 6142863.075442:        466   cycles:  ffffffff9ca7730f native_write_msr+0xf ([kernel.kallsyms])

Filter the traced records from address range [0xffffffff9ca77304, 0xffffffff9ca77304 + 15].

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v2:
   Use intlist for address list.

 tools/perf/Documentation/perf-script.txt | 19 ++++++++++++
 tools/perf/builtin-script.c              |  2 ++
 tools/perf/util/event.c                  | 24 +++++++++++++++
 tools/perf/util/symbol.c                 | 39 ++++++++++++++++++++++++
 tools/perf/util/symbol_conf.h            |  4 ++-
 5 files changed, 87 insertions(+), 1 deletion(-)

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
index 64a039cbba1b..2c13f6acda7f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2406,6 +2406,39 @@ int setup_intlist(struct intlist **list, const char *list_str,
 	return 0;
 }
 
+static int setup_addrlist(struct intlist **addr_list, struct strlist *sym_list)
+{
+	struct str_node *pos, *tmp;
+	unsigned long val;
+	char *sep;
+	int err = 0, i = 0;
+
+	*addr_list = intlist__new(NULL);
+	if (!*addr_list)
+		return -1;
+
+	strlist__for_each_entry_safe(pos, tmp, sym_list) {
+		val = strtoul(pos->s, &sep, 16);
+		if (*sep != ',' && *sep != '\0')
+			continue;
+
+		err = intlist__add(*addr_list, val);
+		if (err)
+			break;
+
+		strlist__remove(sym_list, pos);
+		i++;
+	}
+
+	if (err || (i == 0)) {
+		intlist__delete(*addr_list);
+		*addr_list = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
 static bool symbol__read_kptr_restrict(void)
 {
 	bool value = false;
@@ -2489,6 +2522,10 @@ int symbol__init(struct perf_env *env)
 		       symbol_conf.sym_list_str, "symbol") < 0)
 		goto out_free_tid_list;
 
+	if (symbol_conf.sym_list &&
+	    setup_addrlist(&symbol_conf.addr_list, symbol_conf.sym_list) < 0)
+		goto out_free_sym_list;
+
 	if (setup_list(&symbol_conf.bt_stop_list,
 		       symbol_conf.bt_stop_list_str, "symbol") < 0)
 		goto out_free_sym_list;
@@ -2512,6 +2549,7 @@ int symbol__init(struct perf_env *env)
 
 out_free_sym_list:
 	strlist__delete(symbol_conf.sym_list);
+	intlist__delete(symbol_conf.addr_list);
 out_free_tid_list:
 	intlist__delete(symbol_conf.tid_list);
 out_free_pid_list:
@@ -2533,6 +2571,7 @@ void symbol__exit(void)
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

