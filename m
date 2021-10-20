Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1B43461F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJTHsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:48:21 -0400
Received: from mail.devloop.org.uk ([78.129.163.13]:37216 "EHLO
        mail.nagafix.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJTHsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:48:20 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Oct 2021 03:48:20 EDT
Received: (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: antoine@nagafix.co.uk)
        by mail.nagafix.co.uk (Postfix) with ESMTPSA id 3EBB7C026F;
        Wed, 20 Oct 2021 08:39:35 +0100 (BST)
Message-ID: <f9743892-d19b-7df9-504c-9c05e7d83800@nagafix.co.uk>
Date:   Wed, 20 Oct 2021 14:39:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     ebiederm@xmission.com, gladkov.alexey@gmail.com, hdanton@sina.com,
        legion@kernel.org, linux-kernel@vger.kernel.org
From:   Antoine Martin <antoine@nagafix.co.uk>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm also hitting this issue fairly reliably with the Fedora 33 kernel.
This is on a CD system and it usually takes less than an hour to crash.

This buildbot repeatedly spawns containers via buildah.
I can test patches if you can send them my way.

Cheers,
Antoine

PS: I am not subscribed to LKML, so I scraped some of the email 
addresses from the archived posts.


Here's a backtrace sample:


[11812.552033] WARNING: CPU: 0 PID: 189 at kernel/ucount.c:253 
dec_ucount+0x49/0x50
[11812.552043] Modules linked in: rfcomm xt_CHECKSUM xt_MASQUERADE 
xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp tun bridge stp llc 
nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet 
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat 
ebtable_broute ip6table_nat ip6table_mangle ip6table_raw 
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set 
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables 
iptable_filter bnep sunrpc vfat fat intel_rapl_msr intel_rapl_common 
raid1 snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio 
snd_hda_codec_hdmi edac_mce_amd iwlmvm snd_hda_intel snd_intel_dspcfg 
snd_intel_sdw_acpi kvm_amd snd_hda_codec mac80211 kvm snd_hda_core btusb 
irqbypass snd_hwdep btrtl rapl btbcm snd_seq libarc4 btintel 
snd_seq_device pcspkr wmi_bmof k10temp iwlwifi i2c_piix4 snd_pcm
[11812.552115]  bluetooth snd_timer cfg80211 snd joydev soundcore 
ecdh_generic rfkill gpio_amdpt gpio_generic acpi_cpufreq binfmt_misc 
zram ip_tables amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched 
drm_kms_helper cec crct10dif_pclmul crc32_pclmul crc32c_intel drm igb 
ghash_clmulni_intel nvme sp5100_tco ccp dca nvme_core i2c_algo_bit wmi 
video fuse
[11812.552147] CPU: 0 PID: 189 Comm: kworker/0:3 Not tainted 
5.14.12-100.fc33.x86_64 #1
[11812.552152] Hardware name: To Be Filled By O.E.M. To Be Filled By 
O.E.M./AB350 Gaming-ITX/ac, BIOS P4.60 04/19/2018
[11812.552154] Workqueue: events free_user_ns
[11812.552159] RIP: 0010:dec_ucount+0x49/0x50
[11812.552164] Code: 8b 02 48 89 c6 48 83 ee 01 78 1f f0 48 0f b1 32 75 
f0 48 8b 41 10 48 8b 88 e8 01 00 00 48 85 c9 75 d9 4c 89 c7 e9 f7 fc ff 
ff <0f> 0b eb e4 0f 1f 00 0f 1f 44 00 00 49 89 f8 48 89 d1 48 85 ff 74
[11812.552168] RSP: 0018:ffffa3f5c1d4fe60 EFLAGS: 00010292
[11812.552172] RAX: ffff90f3df941fc0 RBX: ffff90f449bfebe0 RCX: 
ffff90f4d1ad90c0
[11812.552174] RDX: ffff90f4d1ad90e0 RSI: ffff90f3df941fbf RDI: 
0000000000000020
[11812.552177] RBP: ffff90f486c849c0 R08: ffff90f4d1ad90c0 R09: 
0000000000000000
[11812.552179] R10: ffff90f486c84900 R11: 0000000000000001 R12: 
ffff90f4d1ad90c0
[11812.552181] R13: 00000000ffffffff R14: 0000000000000000 R15: 
0000000000000000
[11812.552183] FS:  0000000000000000(0000) GS:ffff90f54fa00000(0000) 
knlGS:0000000000000000
[11812.552186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11812.552189] CR2: 000000c000cdd000 CR3: 0000000306828000 CR4: 
00000000003506f0
[11812.552191] Call Trace:
[11812.552194]  free_user_ns+0x73/0x110
[11812.552200]  process_one_work+0x1ec/0x390
[11812.552206]  worker_thread+0x53/0x3e0
[11812.552210]  ? process_one_work+0x390/0x390
[11812.552214]  kthread+0x127/0x150
[11812.552218]  ? set_kthread_struct+0x40/0x40
[11812.552222]  ret_from_fork+0x22/0x30
[11812.552229] ---[ end trace 2fe782c0be778ded ]---
[11812.552234] BUG: unable to handle page fault for address: 
0000001f00000020
[11812.552238] #PF: supervisor read access in kernel mode
[11812.552242] #PF: error_code(0x0000) - not-present page
[11812.552245] PGD 0 P4D 0
[11812.552249] Oops: 0000 [#1] SMP NOPTI
[11812.552253] CPU: 0 PID: 189 Comm: kworker/0:3 Tainted: G        W 
     5.14.12-100.fc33.x86_64 #1
[11812.552257] Hardware name: To Be Filled By O.E.M. To Be Filled By 
O.E.M./AB350 Gaming-ITX/ac, BIOS P4.60 04/19/2018
[11812.552259] Workqueue: events free_user_ns
[11812.552263] RIP: 0010:dec_ucount+0x1e/0x50
[11812.552267] Code: 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00 
49 89 f8 48 85 ff 74 34 89 f6 4c 89 c1 48 8d 3c f5 20 00 00 00 48 8d 14 
39 <48> 8b 02 48 89 c6 48 83 ee 01 78 1f f0 48 0f b1 32 75 f0 48 8b 41
[11812.552271] RSP: 0018:ffffa3f5c1d4fe60 EFLAGS: 00010206
[11812.552274] RAX: ffff90f3df941fc0 RBX: ffff90f449bfebe0 RCX: 
0000001f00000000
[11812.552277] RDX: 0000001f00000020 RSI: ffff90f3df941fbf RDI: 
0000000000000020
[11812.552279] RBP: ffff90f486c849c0 R08: ffff90f4d1ad90c0 R09: 
0000000000000000
[11812.552282] R10: ffff90f486c84900 R11: 0000000000000001 R12: 
ffff90f4d1ad90c0
[11812.552284] R13: 00000000ffffffff R14: 0000000000000000 R15: 
0000000000000000
[11812.552287] FS:  0000000000000000(0000) GS:ffff90f54fa00000(0000) 
knlGS:0000000000000000
[11812.552290] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11812.552293] CR2: 0000001f00000020 CR3: 0000000306828000 CR4: 
00000000003506f0
[11812.552295] Call Trace:
[11812.552297]  free_user_ns+0x73/0x110
[11812.552301]  process_one_work+0x1ec/0x390
[11812.552306]  worker_thread+0x53/0x3e0
[11812.552310]  ? process_one_work+0x390/0x390
[11812.552315]  kthread+0x127/0x150
[11812.552318]  ? set_kthread_struct+0x40/0x40
[11812.552323]  ret_from_fork+0x22/0x30
[11812.552329] Modules linked in: rfcomm xt_CHECKSUM xt_MASQUERADE 
xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp tun bridge stp llc 
nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet 
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat 
ebtable_broute ip6table_nat ip6table_mangle ip6table_raw 
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ip_set 
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables 
iptable_filter bnep sunrpc vfat fat intel_rapl_msr intel_rapl_common 
raid1 snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio 
snd_hda_codec_hdmi edac_mce_amd iwlmvm snd_hda_intel snd_intel_dspcfg 
snd_intel_sdw_acpi kvm_amd snd_hda_codec mac80211 kvm snd_hda_core btusb 
irqbypass snd_hwdep btrtl rapl btbcm snd_seq libarc4 btintel 
snd_seq_device pcspkr wmi_bmof k10temp iwlwifi i2c_piix4 snd_pcm
[11812.552384]  bluetooth snd_timer cfg80211 snd joydev soundcore 
ecdh_generic rfkill gpio_amdpt gpio_generic acpi_cpufreq binfmt_misc 
zram ip_tables amdgpu drm_ttm_helper ttm iommu_v2 gpu_sched 
drm_kms_helper cec crct10dif_pclmul crc32_pclmul crc32c_intel drm igb 
ghash_clmulni_intel nvme sp5100_tco ccp dca nvme_core i2c_algo_bit wmi 
video fuse
[11812.552412] CR2: 0000001f00000020
[11812.552415] ---[ end trace 2fe782c0be778dee ]---
[11812.552417] RIP: 0010:dec_ucount+0x1e/0x50
[11812.552421] Code: 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f 1f 44 00 00 
49 89 f8 48 85 ff 74 34 89 f6 4c 89 c1 48 8d 3c f5 20 00 00 00 48 8d 14 
39 <48> 8b 02 48 89 c6 48 83 ee 01 78 1f f0 48 0f b1 32 75 f0 48 8b 41
[11812.552425] RSP: 0018:ffffa3f5c1d4fe60 EFLAGS: 00010206
[11812.552428] RAX: ffff90f3df941fc0 RBX: ffff90f449bfebe0 RCX: 
0000001f00000000
[11812.552430] RDX: 0000001f00000020 RSI: ffff90f3df941fbf RDI: 
0000000000000020
[11812.552433] RBP: ffff90f486c849c0 R08: ffff90f4d1ad90c0 R09: 
0000000000000000
[11812.552435] R10: ffff90f486c84900 R11: 0000000000000001 R12: 
ffff90f4d1ad90c0
[11812.552437] R13: 00000000ffffffff R14: 0000000000000000 R15: 
0000000000000000
[11812.552440] FS:  0000000000000000(0000) GS:ffff90f54fa00000(0000) 
knlGS:0000000000000000
[11812.552443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11812.552445] CR2: 0000001f00000020 CR3: 0000000306828000 CR4: 
00000000003506f0

