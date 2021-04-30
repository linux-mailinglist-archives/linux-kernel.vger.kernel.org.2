Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33AA36F622
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhD3HES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:04:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:34066 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhD3HEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:04:02 -0400
IronPort-SDR: EccQZ1J4TpsZl+FfVECsIuhJiVoEpvSd/UNG7XIEi5X/CeJ9Ck97DXIP38nwJqr25XDVZyho74
 8HiIBWVMfucg==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197312467"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="197312467"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:03:14 -0700
IronPort-SDR: yzVkM/I2iq86cY8fKHRYb9qPKZh2821lKMj08HAg2VmaHkuQLDqodhH0qxbIbspiLlGdXyiG7J
 29AXamhNtyYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404492364"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2021 00:03:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 12/12] perf intel-pt: Parse VM Time Correlation options and set up decoding
Date:   Fri, 30 Apr 2021 10:03:09 +0300
Message-Id: <20210430070309.17624-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430070309.17624-1-adrian.hunter@intel.com>
References: <20210430070309.17624-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parsing and validation of VM Time Correlation options, and pass
parameters to the decoder. Also update the Intel PT documentation
accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 108 ++++++++++++++++++++-
 tools/perf/util/intel-pt.c                 |  98 ++++++++++++++++++-
 2 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 33df7898c378..8d6cce062a5f 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -1155,8 +1155,9 @@ include::build-xed.txt[]
 Tracing Virtual Machines
 ------------------------
 
-Currently, only kernel tracing is supported and only with "timeless" decoding
-i.e. no TSC timestamps
+Currently, only kernel tracing is supported and only with either "timeless" decoding
+(i.e. no TSC timestamps) or VM Time Correlation. VM Time Correlation is an extra step
+using 'perf inject' and requires unchanging VMX TSC Offset and no VMX TSC Scaling.
 
 Other limitations and caveats
 
@@ -1167,7 +1168,7 @@ Other limitations and caveats
  Guest VCPU is unknown but may be able to be inferred from the host thread
  Callchains are not supported
 
-Example
+Example using "timeless" decoding
 
 Start VM
 
@@ -1231,6 +1232,107 @@ perf script can be used to provide an instruction trace
            :1440  1440  ffffffffbb74603c clockevents_program_event+0x4c ([guest.kernel.kallsyms])               popq  %rbx
            :1440  1440  ffffffffbb74603d clockevents_program_event+0x4d ([guest.kernel.kallsyms])               popq  %r12
 
+Example using VM Time Correlation
+
+Start VM
+
+ $ sudo virsh start kubuntu20.04
+ Domain kubuntu20.04 started
+
+Mount the guest file system.  Note sshfs needs -o direct_io to enable reading of proc files.  root access is needed to read /proc/kcore.
+
+ $ mkdir -p vm0
+ $ sshfs -o direct_io root@vm0:/ vm0
+
+Copy the guest /proc/kallsyms, /proc/modules and /proc/kcore
+
+ $ perf buildid-cache -v --kcore vm0/proc/kcore
+ same kcore found in /home/user/.debug/[kernel.kcore]/cc9c55a98c5e4ec0aeda69302554aabed5cd6491/2021021312450777
+ $ KALLSYMS=/home/user/.debug/\[kernel.kcore\]/cc9c55a98c5e4ec0aeda69302554aabed5cd6491/2021021312450777/kallsyms
+
+Find the VM process
+
+ $ ps -eLl | grep 'KVM\|PID'
+ F S   UID     PID    PPID     LWP  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
+ 3 S 64055   16998       1   17005 13  80   0 - 1818189 -    ?        00:00:16 CPU 0/KVM
+ 3 S 64055   16998       1   17006  4  80   0 - 1818189 -    ?        00:00:05 CPU 1/KVM
+ 3 S 64055   16998       1   17007  3  80   0 - 1818189 -    ?        00:00:04 CPU 2/KVM
+ 3 S 64055   16998       1   17008  4  80   0 - 1818189 -    ?        00:00:05 CPU 3/KVM
+
+Start an open-ended perf record, tracing the VM process, do something on the VM, and then ctrl-C to stop.
+IPC can be determined, hence cyc=1 can be added.
+Only kernel decoding is supported, so 'k' must be specified.
+Intel PT traces both the host and the guest so --guest and --host need to be specified.
+
+ $ sudo perf kvm --guest --host --guestkallsyms $KALLSYMS record --kcore -e intel_pt/cyc=1/k -p 16998
+ ^C[ perf record: Woken up 1 times to write data ]
+ [ perf record: Captured and wrote 9.041 MB perf.data.kvm ]
+
+Now 'perf inject' can be used to determine the VMX TCS Offset. Note, Intel PT TSC packets are
+only 7-bytes, so the TSC Offset might differ from the actual value in the 8th byte. That will
+have no effect i.e. the resulting timestamps will be correct anyway.
+
+ $ perf inject -i perf.data.kvm --vm-time-correlation=dry-run
+ ERROR: Unknown TSC Offset for VMCS 0x1bff6a
+ VMCS: 0x1bff6a  TSC Offset 0xffffe42722c64c41
+ ERROR: Unknown TSC Offset for VMCS 0x1cbc08
+ VMCS: 0x1cbc08  TSC Offset 0xffffe42722c64c41
+ ERROR: Unknown TSC Offset for VMCS 0x1c3ce8
+ VMCS: 0x1c3ce8  TSC Offset 0xffffe42722c64c41
+ ERROR: Unknown TSC Offset for VMCS 0x1cbce9
+ VMCS: 0x1cbce9  TSC Offset 0xffffe42722c64c41
+
+Each virtual CPU has a different Virtual Machine Control Structure (VMCS)
+shown above with the calculated TSC Offset. For an unchanging TSC Offset
+they should all be the same for the same virtual machine.
+
+Now that the TSC Offset is known, it can be provided to 'perf inject'
+
+ $ perf inject -i perf.data.kvm --vm-time-correlation="dry-run 0xffffe42722c64c41"
+
+Note the options for 'perf inject' --vm-time-correlation are:
+
+ [ dry-run ] [ <TSC Offset> [ : <VMCS> [ , <VMCS> ]... ]  ]...
+
+So it is possible to specify different TSC Offsets for different VMCS.
+The option "dry-run" will cause the file to be processed but without updating it.
+Note it is also possible to get a intel_pt.log file by adding option --itrace=d
+
+There were no errors so, do it for real
+
+ $ perf inject -i perf.data.kvm --vm-time-correlation=0xffffe42722c64c41 --force
+
+'perf script' can be used to see if there are any decoder errors
+
+ $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --itrace=e-o
+
+There were none.
+
+'perf script' can be used to provide an instruction trace showing timestamps
+
+ $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
+       CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                 movq  0x48(%rax), %r9
+       CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                 movq  0x50(%rax), %r10
+       CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                 movq  0x58(%rax), %r11
+       CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce9 __vmx_vcpu_run+0x49 ([kernel.kallsyms])                 movq  0x60(%rax), %r12
+       CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ced __vmx_vcpu_run+0x4d ([kernel.kallsyms])                 movq  0x68(%rax), %r13
+       CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cf1 __vmx_vcpu_run+0x51 ([kernel.kallsyms])                 movq  0x70(%rax), %r14
+       CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cf5 __vmx_vcpu_run+0x55 ([kernel.kallsyms])                 movq  0x78(%rax), %r15
+       CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cf9 __vmx_vcpu_run+0x59 ([kernel.kallsyms])                 movq  (%rax), %rax
+       CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cfc __vmx_vcpu_run+0x5c ([kernel.kallsyms])                 callq  0xffffffff82133c40
+       CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133c40 vmx_vmenter+0x0 ([kernel.kallsyms])             jz 0xffffffff82133c46
+       CPU 1/KVM 17006 [001] 11500.262866075:  ffffffff82133c42 vmx_vmenter+0x2 ([kernel.kallsyms])             vmresume         IPC: 0.05 (40/769)
+          :17006 17006 [001] 11500.262869216:  ffffffff82200cb0 asm_sysvec_apic_timer_interrupt+0x0 ([guest.kernel.kallsyms])           clac
+          :17006 17006 [001] 11500.262869216:  ffffffff82200cb3 asm_sysvec_apic_timer_interrupt+0x3 ([guest.kernel.kallsyms])           pushq  $0xffffffffffffffff
+          :17006 17006 [001] 11500.262869216:  ffffffff82200cb5 asm_sysvec_apic_timer_interrupt+0x5 ([guest.kernel.kallsyms])           callq  0xffffffff82201160
+          :17006 17006 [001] 11500.262869216:  ffffffff82201160 error_entry+0x0 ([guest.kernel.kallsyms])               cld
+          :17006 17006 [001] 11500.262869216:  ffffffff82201161 error_entry+0x1 ([guest.kernel.kallsyms])               pushq  %rsi
+          :17006 17006 [001] 11500.262869216:  ffffffff82201162 error_entry+0x2 ([guest.kernel.kallsyms])               movq  0x8(%rsp), %rsi
+          :17006 17006 [001] 11500.262869216:  ffffffff82201167 error_entry+0x7 ([guest.kernel.kallsyms])               movq  %rdi, 0x8(%rsp)
+          :17006 17006 [001] 11500.262869216:  ffffffff8220116c error_entry+0xc ([guest.kernel.kallsyms])               pushq  %rdx
+          :17006 17006 [001] 11500.262869216:  ffffffff8220116d error_entry+0xd ([guest.kernel.kallsyms])               pushq  %rcx
+          :17006 17006 [001] 11500.262869216:  ffffffff8220116e error_entry+0xe ([guest.kernel.kallsyms])               pushq  %rax
+
 
 
 SEE ALSO
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 858b679d00be..2a5fe1514e65 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1018,6 +1018,19 @@ static bool intel_pt_have_tsc(struct intel_pt *pt)
 	return have_tsc;
 }
 
+static bool intel_pt_have_mtc(struct intel_pt *pt)
+{
+	struct evsel *evsel;
+	u64 config;
+
+	evlist__for_each_entry(pt->session->evlist, evsel) {
+		if (intel_pt_get_config(pt, &evsel->core.attr, &config) &&
+		    (config & pt->mtc_bit))
+			return true;
+	}
+	return false;
+}
+
 static bool intel_pt_sampling_mode(struct intel_pt *pt)
 {
 	struct evsel *evsel;
@@ -1182,6 +1195,8 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	params.tsc_ctc_ratio_n = pt->tsc_ctc_ratio_n;
 	params.tsc_ctc_ratio_d = pt->tsc_ctc_ratio_d;
 	params.quick = pt->synth_opts.quick;
+	params.vm_time_correlation = pt->synth_opts.vm_time_correlation;
+	params.vm_tm_corr_dry_run = pt->synth_opts.vm_tm_corr_dry_run;
 	params.first_timestamp = pt->first_timestamp;
 
 	if (pt->filts.cnt > 0)
@@ -2465,7 +2480,7 @@ static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 		if (pt->per_cpu_mmaps &&
 		    (pt->have_sched_switch == 1 || pt->have_sched_switch == 3) &&
 		    !pt->timeless_decoding && intel_pt_tracing_kernel(pt) &&
-		    !pt->sampling_mode) {
+		    !pt->sampling_mode && !pt->synth_opts.vm_time_correlation) {
 			pt->switch_ip = intel_pt_switch_ip(pt, &pt->ptss_ip);
 			if (pt->switch_ip) {
 				intel_pt_log("switch_ip: %"PRIx64" ptss_ip: %"PRIx64"\n",
@@ -3496,6 +3511,65 @@ static int intel_pt_setup_time_ranges(struct intel_pt *pt,
 	return 0;
 }
 
+static int intel_pt_parse_vm_tm_corr_arg(struct intel_pt *pt, char **args)
+{
+	struct intel_pt_vmcs_info *vmcs_info;
+	u64 tsc_offset, vmcs;
+	char *p = *args;
+
+	errno = 0;
+
+	p = skip_spaces(p);
+	if (!*p)
+		return 1;
+
+	tsc_offset = strtoull(p, &p, 0);
+	if (errno)
+		return -errno;
+	p = skip_spaces(p);
+	if (*p != ':') {
+		pt->dflt_tsc_offset = tsc_offset;
+		*args = p;
+		return 0;
+	}
+	while (1) {
+		vmcs = strtoull(p, &p, 0);
+		if (errno)
+			return -errno;
+		if (!vmcs)
+			return -EINVAL;
+		vmcs_info = intel_pt_findnew_vmcs(&pt->vmcs_info, vmcs, tsc_offset);
+		if (!vmcs_info)
+			return -ENOMEM;
+		p = skip_spaces(p);
+		if (*p != ',')
+			break;
+		p += 1;
+	}
+	*args = p;
+	return 0;
+}
+
+static int intel_pt_parse_vm_tm_corr_args(struct intel_pt *pt)
+{
+	char *args = pt->synth_opts.vm_tm_corr_args;
+	int ret;
+
+	if (!args)
+		return 0;
+
+	do {
+		ret = intel_pt_parse_vm_tm_corr_arg(pt, &args);
+	} while (!ret);
+
+	if (ret < 0) {
+		pr_err("Failed to parse VM Time Correlation options\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static const char * const intel_pt_info_fmts[] = {
 	[INTEL_PT_PMU_TYPE]		= "  PMU Type            %"PRId64"\n",
 	[INTEL_PT_TIME_SHIFT]		= "  Time Shift          %"PRIu64"\n",
@@ -3667,6 +3741,28 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	pt->sampling_mode = intel_pt_sampling_mode(pt);
 	pt->est_tsc = !pt->timeless_decoding;
 
+	if (pt->synth_opts.vm_time_correlation) {
+		if (pt->timeless_decoding) {
+			pr_err("Intel PT has no time information for VM Time Correlation\n");
+			err = -EINVAL;
+			goto err_free_queues;
+		}
+		if (session->itrace_synth_opts->ptime_range) {
+			pr_err("Time ranges cannot be specified with VM Time Correlation\n");
+			err = -EINVAL;
+			goto err_free_queues;
+		}
+		/* Currently TSC Offset is calculated using MTC packets */
+		if (!intel_pt_have_mtc(pt)) {
+			pr_err("MTC packets must have been enabled for VM Time Correlation\n");
+			err = -EINVAL;
+			goto err_free_queues;
+		}
+		err = intel_pt_parse_vm_tm_corr_args(pt);
+		if (err)
+			goto err_free_queues;
+	}
+
 	pt->unknown_thread = thread__new(999999999, 999999999);
 	if (!pt->unknown_thread) {
 		err = -ENOMEM;
-- 
2.25.1

