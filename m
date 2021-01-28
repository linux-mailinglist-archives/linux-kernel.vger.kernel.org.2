Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F206C307F05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhA1UBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhA1T7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 14:59:51 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E01C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 11:49:56 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e15so4985118qte.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=12qE9loVGPeJL5QEE5bLNGrv4WjkZ7v5J5PS1Vw7DoM=;
        b=IMh5OqB66TuSqPDFs0MDLXa+f4vLNAEBSUXPkbtzJA92ByIRl/uXmTjwkxAqQoe4pD
         rXEfcD4ZaFpDHu+uOaj1CIrf6/6JKYOslntg0WNX1nGnZbRsxaeLFN5bkgd2L3o3MSvD
         pbpICNwVct9M0/3ZN6oao82hQ9K/eYkTz/JTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=12qE9loVGPeJL5QEE5bLNGrv4WjkZ7v5J5PS1Vw7DoM=;
        b=cTEUpA0cB9N7qoae6mSVCTVxD07+KCBYSSCmUXOTjU7A3ZGCbnJkwXJemd01+MV4zu
         GtUoOL5TPgxQU8Zf+M7OjmTQOCPoV6tLtTBpmc/m1dlZqSWLrGrU3wWQrrhkc3b0QoOA
         XQJ5IUF/unUky5jCpxcegw+5iqiu2g87ecY1RxO0dbs0OxQ/yVmjxQoR8ImL3kHYZCBp
         dnQQXTimuco1KpOzZxmetiVjGurcBG69n3u7uK0s8unxUio39ZhhFEDL0wh7RUM7OtZe
         iIbq9SIM0+ybCyoeLVMkdgITp/kALVxNCmFNtUnWGL+Pxb02Xb3kaZ/kIXIAozol7ydo
         PtQg==
X-Gm-Message-State: AOAM530F0Igg4e8r5/NLESUXbShSY7R3Dupb9T46OOEVo7TWRaFHFR5w
        c1PLY1CKaB8mQe6I6GOYC+XvQw==
X-Google-Smtp-Source: ABdhPJwKS9VjHGXyUMVOidDG/AX3un0kQrRAwJ8Nta9Qy0SkSoAgthIEk91+dwl+LaSuOsl90fTZwQ==
X-Received: by 2002:ac8:ecc:: with SMTP id w12mr1104748qti.371.1611863395395;
        Thu, 28 Jan 2021 11:49:55 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id s136sm4017665qka.106.2021.01.28.11.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 11:49:54 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 28 Jan 2021 14:49:47 -0500 (EST)
To:     Vince Weaver <vincent.weaver@maine.edu>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        kan.liang@linux.intel.com
Subject: Re: [perf] perf_fuzzer causes crash in intel_pmu_drain_pebs_nhm()
In-Reply-To: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu>
Message-ID: <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu>
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021, Vince Weaver wrote:

> the perf_fuzzer has turned up a repeatable crash on my haswell system.
> 
> addr2line is not being very helpful, it points to DECLARE_PER_CPU_FIRST.
> I'll investigate more when I have the chance.

so I poked around some more.

This seems to be caused in

   __intel_pmu_pebs_event()
	get_next_pebs_record_by_bit()		ds.c line 1639
		get_pebs_status(at)		ds.c line 1317
			return ((struct pebs_record_nhm *)n)->status;

where "n" has the value of 0xc0 rather than a proper pointer.

this does seem to be repetable, but fairly deep in a fuzzing run so I 
don't have a quick reproducer.

Vince


> [96289.009646] BUG: kernel NULL pointer dereference, address: 0000000000000150
> [96289.017094] #PF: supervisor read access in kernel mode
> [96289.022588] #PF: error_code(0x0000) - not-present page
> [96289.028069] PGD 0 P4D 0 
> [96289.030796] Oops: 0000 [#1] SMP PTI
> [96289.034549] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.11.0-rc5+ #151
> [96289.043059] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
> [96289.050946] RIP: 0010:intel_pmu_drain_pebs_nhm+0x464/0x5f0
> [96289.056817] Code: 09 00 00 0f b6 c0 49 39 c4 74 2a 48 63 82 78 09 00 00 48 01 c5 48 39 6c 24 08 76 17 0f b6 05 14 70 3f 01 83 e0 0f 3c 03 77 a4 <48> 8b 85 90 00 00 00 eb 9f 31 ed 83 eb 01 83 fb 01 0f 85 30 ff ff
> [96289.076876] RSP: 0000:ffffffff822039e0 EFLAGS: 00010097
> [96289.082468] RAX: 0000000000000002 RBX: 0000000000000155 RCX: 0000000000000008
> [96289.090095] RDX: ffff88811ac118a0 RSI: ffffffff82203980 RDI: ffffffff82203980
> [96289.097746] RBP: 00000000000000c0 R08: 0000000000000000 R09: 0000000000000000
> [96289.105376] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [96289.113008] R13: ffffffff82203bc0 R14: ffff88801c3cf800 R15: ffffffff829814a0
> [96289.120671] FS:  0000000000000000(0000) GS:ffff88811ac00000(0000) knlGS:0000000000000000
> [96289.129346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [96289.135526] CR2: 0000000000000150 CR3: 000000000220c003 CR4: 00000000001706f0
> [96289.143159] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [96289.150803] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> [96289.158414] Call Trace:
> [96289.161041]  ? update_blocked_averages+0x532/0x620
> [96289.166152]  ? update_group_capacity+0x25/0x1d0
> [96289.171025]  ? cpumask_next_and+0x19/0x20
> [96289.175339]  ? update_sd_lb_stats.constprop.0+0x702/0x820
> [96289.181105]  intel_pmu_drain_pebs_buffer+0x33/0x50
> [96289.186259]  ? x86_pmu_commit_txn+0xbc/0xf0
> [96289.190749]  ? _raw_spin_lock_irqsave+0x1d/0x30
> [96289.195603]  ? timerqueue_add+0x64/0xb0
> [96289.199720]  ? update_load_avg+0x6c/0x5e0
> [96289.204001]  ? enqueue_task_fair+0x98/0x5a0
> [96289.208464]  ? timerqueue_del+0x1e/0x40
> [96289.212556]  ? uncore_msr_read_counter+0x10/0x20
> [96289.217513]  intel_pmu_pebs_disable+0x12a/0x130
> [96289.222324]  x86_pmu_stop+0x48/0xa0
> [96289.226076]  x86_pmu_del+0x40/0x160
> [96289.229813]  event_sched_out.isra.0+0x81/0x1e0
> [96289.234602]  group_sched_out.part.0+0x4f/0xc0
> [96289.239257]  __perf_event_disable+0xef/0x1d0
> [96289.243831]  event_function+0x8c/0xd0
> [96289.247785]  remote_function+0x3e/0x50
> [96289.251797]  flush_smp_call_function_queue+0x11b/0x1a0
> [96289.257268]  flush_smp_call_function_from_idle+0x38/0x60
> [96289.262944]  do_idle+0x15f/0x240
> [96289.266421]  cpu_startup_entry+0x19/0x20
> [96289.270639]  start_kernel+0x7df/0x804
> [96289.274558]  ? apply_microcode_early.cold+0xc/0x27
> [96289.279678]  secondary_startup_64_no_verify+0xb0/0xbb
> [96289.285078] Modules linked in: nf_tables libcrc32c nfnetlink intel_rapl_msr intel_rapl_common snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi x86_pkg_temp_thermal ledtrig_audio intel_powerclamp snd_hda_intel coretemp snd_intel_dspcfg snd_hda_codec snd_hda_core kvm_intel kvm snd_hwdep irqbypass at24 snd_pcm tpm_tis crct10dif_pclmul snd_timer crc32_pclmul regmap_i2c wmi_bmof sg tpm_tis_core snd ghash_clmulni_intel tpm iTCO_wdt aesni_intel soundcore rng_core iTCO_vendor_support crypto_simd mei_me mei cryptd pcspkr evdev glue_helper binfmt_misc ip_tables x_tables autofs4 sr_mod sd_mod t10_pi cdrom i915 iosf_mbi ahci i2c_algo_bit libahci drm_kms_helper xhci_pci ehci_pci ehci_hcd libata xhci_hcd lpc_ich usbcore i2c_i801 drm crc32c_intel e1000e mfd_core scsi_mod usb_common i2c_smbus wmi fan thermal video button
> [96289.362498] CR2: 0000000000000150
> [96289.366070] ---[ end trace 80c577f99562015f ]---
> [96289.371007] RIP: 0010:intel_pmu_drain_pebs_nhm+0x464/0x5f0
> [96289.376868] Code: 09 00 00 0f b6 c0 49 39 c4 74 2a 48 63 82 78 09 00 00 48 01 c5 48 39 6c 24 08 76 17 0f b6 05 14 70 3f 01 83 e0 0f 3c 03 77 a4 <48> 8b 85 90 00 00 00 eb 9f 31 ed 83 eb 01 83 fb 01 0f 85 30 ff ff
> [96289.396981] RSP: 0000:ffffffff822039e0 EFLAGS: 00010097
> [96289.402573] RAX: 0000000000000002 RBX: 0000000000000155 RCX: 0000000000000008
> [96289.410226] RDX: ffff88811ac118a0 RSI: ffffffff82203980 RDI: ffffffff82203980
> [96289.417841] RBP: 00000000000000c0 R08: 0000000000000000 R09: 0000000000000000
> [96289.425461] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [96289.433122] R13: ffffffff82203bc0 R14: ffff88801c3cf800 R15: ffffffff829814a0
> [96289.440774] FS:  0000000000000000(0000) GS:ffff88811ac00000(0000) knlGS:0000000000000000
> [96289.449374] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [96289.455507] CR2: 0000000000000150 CR3: 000000000220c003 CR4: 00000000001706f0
> [96289.463119] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [96289.470764] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> [96289.478408] Kernel panic - not syncing: Attempted to kill the idle task!
> [96289.485598] Kernel Offset: disabled
> [96289.489355] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> 
> 

