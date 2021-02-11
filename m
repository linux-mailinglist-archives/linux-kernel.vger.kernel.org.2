Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FBE319542
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhBKViv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:38:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:24591 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhBKVin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:38:43 -0500
IronPort-SDR: OwYzJ2eTg4XpusfM2I3yIf1BqbSF+AB+UfaeL1Eq7cTWcrJ3MatyZljX6iBK8lIqX1DGxwOtVy
 6UJ3aLNPvdJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="169451545"
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="169451545"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 13:37:15 -0800
IronPort-SDR: ipoiKMxkej04teHeXai/SuWbQ+zCdI61FZ+57P6yJ+W+kE4eX7RmibY5pdFtzCQUWGdMpcrr8b
 M2AZFAUyT6Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="399657322"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2021 13:37:15 -0800
Received: from [10.254.79.250] (kliang2-MOBL.ccr.corp.intel.com [10.254.79.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 99DC55808AB;
        Thu, 11 Feb 2021 13:37:13 -0800 (PST)
Subject: Re: [perf] perf_fuzzer causes crash in intel_pmu_drain_pebs_nhm()
To:     Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu>
 <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu>
 <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d2005608-4214-ec01-d6b1-a7d19fab7bf9@linux.intel.com>
Date:   Thu, 11 Feb 2021 16:37:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2021 9:53 AM, Peter Zijlstra wrote:
> 
> Kan, do you have time to look at this?
> 
> On Thu, Jan 28, 2021 at 02:49:47PM -0500, Vince Weaver wrote:
>> On Thu, 28 Jan 2021, Vince Weaver wrote:
>>
>>> the perf_fuzzer has turned up a repeatable crash on my haswell system.
>>>
>>> addr2line is not being very helpful, it points to DECLARE_PER_CPU_FIRST.
>>> I'll investigate more when I have the chance.
>>
>> so I poked around some more.
>>
>> This seems to be caused in
>>
>>     __intel_pmu_pebs_event()
>> 	get_next_pebs_record_by_bit()		ds.c line 1639
>> 		get_pebs_status(at)		ds.c line 1317
>> 			return ((struct pebs_record_nhm *)n)->status;
>>
>> where "n" has the value of 0xc0 rather than a proper pointer.
>>

The issue is pretty strange. I haven't found the root cause yet.

The base->status (aka "n") was just used in the intel_pmu_drain_pebs_nhm().
	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
		struct pebs_record_nhm *p = at;
		u64 pebs_status;

		pebs_status = p->status & cpuc->pebs_enabled;
		pebs_status &= mask;
Then it seems to be modified to 0xc0, and crash at get_pebs_status() 
based on your investigation.
The "base" is a local variable. The ds->pebs_buffer_base is assigned to 
"base" at the beginning of the function. After that, no one change it.


>> this does seem to be repetable,

I'd like to reproduce it on my machine.
Is this issue only found in a Haswell client machine?

To reproduce the issue, can I use ./perf_fuzzer under 
perf_event_tests/fuzzer?
Do I need to apply any parameters with ./perf_fuzzer?

Usually how long does it take to reproduce the issue?

Thanks,
Kan

>> but fairly deep in a fuzzing run so I
>> don't have a quick reproducer. >> Vince
>>
>>
>>> [96289.009646] BUG: kernel NULL pointer dereference, address: 0000000000000150
>>> [96289.017094] #PF: supervisor read access in kernel mode
>>> [96289.022588] #PF: error_code(0x0000) - not-present page
>>> [96289.028069] PGD 0 P4D 0
>>> [96289.030796] Oops: 0000 [#1] SMP PTI
>>> [96289.034549] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.11.0-rc5+ #151
>>> [96289.043059] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
>>> [96289.050946] RIP: 0010:intel_pmu_drain_pebs_nhm+0x464/0x5f0
>>> [96289.056817] Code: 09 00 00 0f b6 c0 49 39 c4 74 2a 48 63 82 78 09 00 00 48 01 c5 48 39 6c 24 08 76 17 0f b6 05 14 70 3f 01 83 e0 0f 3c 03 77 a4 <48> 8b 85 90 00 00 00 eb 9f 31 ed 83 eb 01 83 fb 01 0f 85 30 ff ff
>>> [96289.076876] RSP: 0000:ffffffff822039e0 EFLAGS: 00010097
>>> [96289.082468] RAX: 0000000000000002 RBX: 0000000000000155 RCX: 0000000000000008
>>> [96289.090095] RDX: ffff88811ac118a0 RSI: ffffffff82203980 RDI: ffffffff82203980
>>> [96289.097746] RBP: 00000000000000c0 R08: 0000000000000000 R09: 0000000000000000
>>> [96289.105376] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
>>> [96289.113008] R13: ffffffff82203bc0 R14: ffff88801c3cf800 R15: ffffffff829814a0
>>> [96289.120671] FS:  0000000000000000(0000) GS:ffff88811ac00000(0000) knlGS:0000000000000000
>>> [96289.129346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [96289.135526] CR2: 0000000000000150 CR3: 000000000220c003 CR4: 00000000001706f0
>>> [96289.143159] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [96289.150803] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
>>> [96289.158414] Call Trace:
>>> [96289.161041]  ? update_blocked_averages+0x532/0x620
>>> [96289.166152]  ? update_group_capacity+0x25/0x1d0
>>> [96289.171025]  ? cpumask_next_and+0x19/0x20
>>> [96289.175339]  ? update_sd_lb_stats.constprop.0+0x702/0x820
>>> [96289.181105]  intel_pmu_drain_pebs_buffer+0x33/0x50
>>> [96289.186259]  ? x86_pmu_commit_txn+0xbc/0xf0
>>> [96289.190749]  ? _raw_spin_lock_irqsave+0x1d/0x30
>>> [96289.195603]  ? timerqueue_add+0x64/0xb0
>>> [96289.199720]  ? update_load_avg+0x6c/0x5e0
>>> [96289.204001]  ? enqueue_task_fair+0x98/0x5a0
>>> [96289.208464]  ? timerqueue_del+0x1e/0x40
>>> [96289.212556]  ? uncore_msr_read_counter+0x10/0x20
>>> [96289.217513]  intel_pmu_pebs_disable+0x12a/0x130
>>> [96289.222324]  x86_pmu_stop+0x48/0xa0
>>> [96289.226076]  x86_pmu_del+0x40/0x160
>>> [96289.229813]  event_sched_out.isra.0+0x81/0x1e0
>>> [96289.234602]  group_sched_out.part.0+0x4f/0xc0
>>> [96289.239257]  __perf_event_disable+0xef/0x1d0
>>> [96289.243831]  event_function+0x8c/0xd0
>>> [96289.247785]  remote_function+0x3e/0x50
>>> [96289.251797]  flush_smp_call_function_queue+0x11b/0x1a0
>>> [96289.257268]  flush_smp_call_function_from_idle+0x38/0x60
>>> [96289.262944]  do_idle+0x15f/0x240
>>> [96289.266421]  cpu_startup_entry+0x19/0x20
>>> [96289.270639]  start_kernel+0x7df/0x804
>>> [96289.274558]  ? apply_microcode_early.cold+0xc/0x27
>>> [96289.279678]  secondary_startup_64_no_verify+0xb0/0xbb
>>> [96289.285078] Modules linked in: nf_tables libcrc32c nfnetlink intel_rapl_msr intel_rapl_common snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi x86_pkg_temp_thermal ledtrig_audio intel_powerclamp snd_hda_intel coretemp snd_intel_dspcfg snd_hda_codec snd_hda_core kvm_intel kvm snd_hwdep irqbypass at24 snd_pcm tpm_tis crct10dif_pclmul snd_timer crc32_pclmul regmap_i2c wmi_bmof sg tpm_tis_core snd ghash_clmulni_intel tpm iTCO_wdt aesni_intel soundcore rng_core iTCO_vendor_support crypto_simd mei_me mei cryptd pcspkr evdev glue_helper binfmt_misc ip_tables x_tables autofs4 sr_mod sd_mod t10_pi cdrom i915 iosf_mbi ahci i2c_algo_bit libahci drm_kms_helper xhci_pci ehci_pci ehci_hcd libata xhci_hcd lpc_ich usbcore i2c_i801 drm crc32c_intel e1000e mfd_core scsi_mod usb_common i2c_smbus wmi fan thermal video button
>>> [96289.362498] CR2: 0000000000000150
>>> [96289.366070] ---[ end trace 80c577f99562015f ]---
>>> [96289.371007] RIP: 0010:intel_pmu_drain_pebs_nhm+0x464/0x5f0
>>> [96289.376868] Code: 09 00 00 0f b6 c0 49 39 c4 74 2a 48 63 82 78 09 00 00 48 01 c5 48 39 6c 24 08 76 17 0f b6 05 14 70 3f 01 83 e0 0f 3c 03 77 a4 <48> 8b 85 90 00 00 00 eb 9f 31 ed 83 eb 01 83 fb 01 0f 85 30 ff ff
>>> [96289.396981] RSP: 0000:ffffffff822039e0 EFLAGS: 00010097
>>> [96289.402573] RAX: 0000000000000002 RBX: 0000000000000155 RCX: 0000000000000008
>>> [96289.410226] RDX: ffff88811ac118a0 RSI: ffffffff82203980 RDI: ffffffff82203980
>>> [96289.417841] RBP: 00000000000000c0 R08: 0000000000000000 R09: 0000000000000000
>>> [96289.425461] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
>>> [96289.433122] R13: ffffffff82203bc0 R14: ffff88801c3cf800 R15: ffffffff829814a0
>>> [96289.440774] FS:  0000000000000000(0000) GS:ffff88811ac00000(0000) knlGS:0000000000000000
>>> [96289.449374] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [96289.455507] CR2: 0000000000000150 CR3: 000000000220c003 CR4: 00000000001706f0
>>> [96289.463119] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> [96289.470764] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
>>> [96289.478408] Kernel panic - not syncing: Attempted to kill the idle task!
>>> [96289.485598] Kernel Offset: disabled
>>> [96289.489355] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
>>>
>>>
>>
