Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832C731E922
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhBRL1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:27:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:58030 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230403AbhBRKLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:11:32 -0500
IronPort-SDR: IvVVFjqTUcB6PNSR6YMaXvKL1L9h5p/I0WX8f/vpxVVBs/d/YANgxXgLs6S1XhJa6ZMQpfa0vu
 2z6eagdUHQ6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127961"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127961"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:27 -0800
IronPort-SDR: vs9Ob5OknnSij7h0y7DqybofzNaur8PZRc/yKrSDev8rOuYo1HYcWaAsm0KyFzPMORkiJWSTnn
 j7Dzr78n+5Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427744"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:25 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] perf intel-pt: Add documentation for tracing virtual machines
Date:   Thu, 18 Feb 2021 11:58:01 +0200
Message-Id: <20210218095801.19576-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to the perf-intel-pt man page for tracing virtual
machines.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 0b8a339803cb..18c91b7cd937 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -1146,6 +1146,88 @@ XED
 
 include::build-xed.txt[]
 
+
+Tracing Virtual Machines
+------------------------
+
+Currently, only kernel tracing is supported and only with "timeless" decoding
+i.e. no TSC timestamps
+
+Other limitations and caveats
+
+ VMX controls may suppress packets needed for decoding resulting in decoding errors
+ VMX controls may block the perf NMI to the host potentially resulting in lost trace data
+ Guest kernel self-modifying code (e.g. jump labels or JIT-compiled eBPF) will result in decoding errors
+ Guest thread information is unknown
+ Guest VCPU is unknown but may be able to be inferred from the host thread
+ Callchains are not supported
+
+Example
+
+Start VM
+
+ $ sudo virsh start kubuntu20.04
+ Domain kubuntu20.04 started
+
+Mount the guest file system.  Note sshfs needs -o direct_io to enable reading of proc files.  root access is needed to read /proc/kcore.
+
+ $ mkdir vm0
+ $ sshfs -o direct_io root@vm0:/ vm0
+
+Copy the guest /proc/kallsyms, /proc/modules and /proc/kcore
+
+ $ perf buildid-cache -v --kcore vm0/proc/kcore
+ kcore added to build-id cache directory /home/user/.debug/[kernel.kcore]/9600f316a53a0f54278885e8d9710538ec5f6a08/2021021807494306
+ $ KALLSYMS=/home/user/.debug/[kernel.kcore]/9600f316a53a0f54278885e8d9710538ec5f6a08/2021021807494306/kallsyms
+
+Find the VM process
+
+ $ ps -eLl | grep 'KVM\|PID'
+ F S   UID     PID    PPID     LWP  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
+ 3 S 64055    1430       1    1440  1  80   0 - 1921718 -    ?        00:02:47 CPU 0/KVM
+ 3 S 64055    1430       1    1441  1  80   0 - 1921718 -    ?        00:02:41 CPU 1/KVM
+ 3 S 64055    1430       1    1442  1  80   0 - 1921718 -    ?        00:02:38 CPU 2/KVM
+ 3 S 64055    1430       1    1443  2  80   0 - 1921718 -    ?        00:03:18 CPU 3/KVM
+
+Start an open-ended perf record, tracing the VM process, do something on the VM, and then ctrl-C to stop.
+TSC is not supported and tsc=0 must be specified.  That means mtc is useless, so add mtc=0.
+However, IPC can still be determined, hence cyc=1 can be added.
+Only kernel decoding is supported, so 'k' must be specified.
+Intel PT traces both the host and the guest so --guest and --host need to be specified.
+Without timestamps, --per-thread must be specified to distinguish threads.
+
+ $ sudo perf kvm --guest --host --guestkallsyms $KALLSYMS record --kcore -e intel_pt/tsc=0,mtc=0,cyc=1/k -p 1430 --per-thread
+ ^C
+ [ perf record: Woken up 1 times to write data ]
+ [ perf record: Captured and wrote 5.829 MB ]
+
+perf script can be used to provide an instruction trace
+
+ $ perf script --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
+       CPU 0/KVM  1440  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                movq  0x48(%rax), %r9
+       CPU 0/KVM  1440  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                movq  0x50(%rax), %r10
+       CPU 0/KVM  1440  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                movq  0x58(%rax), %r11
+       CPU 0/KVM  1440  ffffffff82133ce9 __vmx_vcpu_run+0x49 ([kernel.kallsyms])                movq  0x60(%rax), %r12
+       CPU 0/KVM  1440  ffffffff82133ced __vmx_vcpu_run+0x4d ([kernel.kallsyms])                movq  0x68(%rax), %r13
+       CPU 0/KVM  1440  ffffffff82133cf1 __vmx_vcpu_run+0x51 ([kernel.kallsyms])                movq  0x70(%rax), %r14
+       CPU 0/KVM  1440  ffffffff82133cf5 __vmx_vcpu_run+0x55 ([kernel.kallsyms])                movq  0x78(%rax), %r15
+       CPU 0/KVM  1440  ffffffff82133cf9 __vmx_vcpu_run+0x59 ([kernel.kallsyms])                movq  (%rax), %rax
+       CPU 0/KVM  1440  ffffffff82133cfc __vmx_vcpu_run+0x5c ([kernel.kallsyms])                callq  0xffffffff82133c40
+       CPU 0/KVM  1440  ffffffff82133c40 vmx_vmenter+0x0 ([kernel.kallsyms])            jz 0xffffffff82133c46
+       CPU 0/KVM  1440  ffffffff82133c42 vmx_vmenter+0x2 ([kernel.kallsyms])            vmresume         IPC: 0.11 (50/445)
+           :1440  1440  ffffffffbb678b06 native_write_msr+0x6 ([guest.kernel.kallsyms])                 nopl  %eax, (%rax,%rax,1)
+           :1440  1440  ffffffffbb678b0b native_write_msr+0xb ([guest.kernel.kallsyms])                 retq     IPC: 0.04 (2/41)
+           :1440  1440  ffffffffbb666646 lapic_next_deadline+0x26 ([guest.kernel.kallsyms])             data16 nop
+           :1440  1440  ffffffffbb666648 lapic_next_deadline+0x28 ([guest.kernel.kallsyms])             xor %eax, %eax
+           :1440  1440  ffffffffbb66664a lapic_next_deadline+0x2a ([guest.kernel.kallsyms])             popq  %rbp
+           :1440  1440  ffffffffbb66664b lapic_next_deadline+0x2b ([guest.kernel.kallsyms])             retq     IPC: 0.16 (4/25)
+           :1440  1440  ffffffffbb74607f clockevents_program_event+0x8f ([guest.kernel.kallsyms])               test %eax, %eax
+           :1440  1440  ffffffffbb746081 clockevents_program_event+0x91 ([guest.kernel.kallsyms])               jz 0xffffffffbb74603c    IPC: 0.06 (2/30)
+           :1440  1440  ffffffffbb74603c clockevents_program_event+0x4c ([guest.kernel.kallsyms])               popq  %rbx
+           :1440  1440  ffffffffbb74603d clockevents_program_event+0x4d ([guest.kernel.kallsyms])               popq  %r12
+
+
+
 SEE ALSO
 --------
 
-- 
2.17.1

