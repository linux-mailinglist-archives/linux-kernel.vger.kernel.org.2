Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661E63FC201
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 06:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhHaEpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 00:45:08 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:33864 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230244AbhHaEpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 00:45:05 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Aug 2021 00:45:05 EDT
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 8B257340C24
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 04:44:10 +0000 (UTC)
Received: (qmail 7004 invoked by uid 129); 31 Aug 2021 04:37:29 -0000
X-HELO: thorne.orbis-terrarum.net
Authentication-Results: orbis-terrarum.net; auth=pass (cram-md5) smtp.auth=robbat2-thorne@orbis-terrarum.net; iprev=pass
Received: from d108-172-209-11.bchsia.telus.net (HELO thorne.orbis-terrarum.net) (108.172.209.11)
 by orbis-terrarum.net (qpsmtpd/0.95) with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted); Tue, 31 Aug 2021 04:37:29 +0000
Received: by thorne.orbis-terrarum.net (Postfix, from userid 0)
        id 206BC1982B2; Tue, 31 Aug 2021 04:37:27 +0000 (UTC)
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, rjohnson@digitalocean.com,
        "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 2/2] tracing: increase PERF_MAX_TRACE_SIZE to handle Sentinel1 and docker together
Date:   Mon, 30 Aug 2021 21:37:23 -0700
Message-Id: <20210831043723.13481-2-robbat2@gentoo.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210831043723.13481-1-robbat2@gentoo.org>
References: <20210831043723.13481-1-robbat2@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Checked: Checked by ClamAV on orbis-terrarum.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running endpoint security solutions like Sentinel1 that use perf-based
tracing heavily lead to this repeated dump complaining about dockerd.
The default value of 2048 is nowhere near not large enough.

Using the prior patch "tracing: show size of requested buffer", we get
"perf buffer not large enough, wanted 6644, have 6144", after repeated
up-sizing (I did 2/4/6/8K). With 8K, the problem doesn't occur at all,
so below is the trace for 6K.

I'm wondering if this value should be selectable at boot time, but this
is a good starting point.

```
------------[ cut here ]------------
perf buffer not large enough, wanted 6644, have 6144
WARNING: CPU: 1 PID: 4997 at kernel/trace/trace_event_perf.c:402 perf_trace_buf_alloc+0x8c/0xa0
Modules linked in: veth rfcomm dm_integrity async_xor async_tx hid_logitech_hidpp hid_logitech_dj hid_lg_g15 nf_conntrack_netlink nfnetlink br_netfilter bridge stp llc overlay sctp ip6_udp_tunnel udp_tunnel cachefiles fscache netfs bnep ip6table_raw ip6table_security ip6table_mangle ip6table_nat ip6table_filter ip6_tables iptable_raw iptable_security xt_CHECKSUM iptable_mangle xt_nat xt_MASQUERADE xt_addrtype iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter ip_tables bpfilter xfs vfat fat typec_displayport btusb btrtl btbcm btintel bluetooth snd_usb_audio uvcvideo joydev snd_usbmidi_lib snd_rawmidi ecdh_generic ecc snd_seq_device hid_multitouch rmi_smbus rmi_core videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev mc iTCO_wdt intel_pmc_bxt iTCO_vendor_support mei_hdcp mei_wdt intel_pmc_core_pltdrv intel_pmc_core wmi_bmof intel_wmi_thunderbolt tcp_bbr binfmt_misc intel_tcc_cooling
 x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm dm_crypt trusted irqbypass iwlmvm asn1_encoder snd_hda_codec_hdmi crct10dif_pclmul ghash_clmulni_intel rapl intel_cstate snd_ctl_led mac80211 intel_uncore snd_hda_codec_realtek tun psmouse snd_hda_codec_generic libarc4 pkcs8_key_parser pcspkr serio_raw snd_hda_intel snd_intel_dspcfg iwlwifi snd_hda_codec i2c_i801 coretemp snd_hwdep i2c_smbus snd_hda_core snd_pcm snd_timer thunderbolt cfg80211 mei_me mei intel_pch_thermal intel_xhci_usb_role_switch processor_thermal_device processor_thermal_rfim processor_thermal_mbox processor_thermal_rapl intel_soc_dts_iosf ucsi_acpi typec_ucsi typec thinkpad_acpi wmi platform_profile ledtrig_audio snd soundcore rfkill int3403_thermal int340x_thermal_zone i2c_hid_acpi i2c_hid int3400_thermal acpi_thermal_rel acpi_pad uas usb_storage e1000e crc32_pclmul nvme crc32c_intel nvme_core ptp hwmon
CPU: 1 PID: 4997 Comm: sh Tainted: G                T 5.13.13-x86_64-00039-gb3959163488e #63
Hardware name: LENOVO 20KH002JUS/20KH002JUS, BIOS N23ET66W (1.41 ) 09/02/2019
RIP: 0010:perf_trace_buf_alloc+0x8c/0xa0
Code: 80 3d 43 97 d0 01 00 74 07 31 c0 5b 5d 41 5c c3 ba 00 18 00 00 89 ee 48 c7 c7 00 82 7d 91 c6 05 25 97 d0 01 01 e8 22 ee bc 00 <0f> 0b 31 c0 eb db 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 55 89
RSP: 0018:ffffb922026b7d58 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff9da5ee012000 RCX: 0000000000000027
RDX: ffff9da881657828 RSI: 0000000000000001 RDI: ffff9da881657820
RBP: 00000000000019f4 R08: 0000000000000000 R09: ffffb922026b7b80
R10: ffffb922026b7b78 R11: ffffffff91dda688 R12: 000000000000000f
R13: ffff9da5ee012108 R14: ffff9da8816570a0 R15: ffffb922026b7e30
FS:  00007f420db1a080(0000) GS:ffff9da881640000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000060 CR3: 00000002504a8006 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kprobe_perf_func+0x11e/0x270
 ? do_execveat_common.isra.0+0x1/0x1c0
 ? do_execveat_common.isra.0+0x5/0x1c0
 kprobe_ftrace_handler+0x10e/0x1d0
 0xffffffffc03aa0c8
 ? do_execveat_common.isra.0+0x1/0x1c0
 do_execveat_common.isra.0+0x5/0x1c0
 __x64_sys_execve+0x33/0x40
 do_syscall_64+0x6b/0xc0
 ? do_syscall_64+0x11/0xc0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f420dc1db37
Code: ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00 00 f7 d8 64 41 89 00 eb dc 0f 1f 84 00 00 00 00 00 b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 01 43 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd4e8b4e38 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f420dc1db37
RDX: 0000564338d1e740 RSI: 0000564338d32d50 RDI: 0000564338d28f00
RBP: 0000564338d28f00 R08: 0000564338d32d50 R09: 0000000000000020
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000564338d28f00
R13: 0000564338d32d50 R14: 0000564338d1e740 R15: 0000564338d28c60
---[ end trace 83ab3e8e16275e49 ]---
```

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 include/linux/trace_events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index ad413b382a3c..0f5e177ec5cb 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -622,7 +622,7 @@ struct trace_event_file {
 	}								\
 	early_initcall(trace_init_perf_perm_##name);
 
-#define PERF_MAX_TRACE_SIZE	2048
+#define PERF_MAX_TRACE_SIZE	8192
 
 #define MAX_FILTER_STR_VAL	256	/* Should handle KSYM_SYMBOL_LEN */
 
-- 
2.33.0

