Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CC132290D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhBWKvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:51:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231414AbhBWKum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614077353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZIAwNUkYihjlq8pJR90ewHu5uHpkP1D9IOZ1jYpoiYI=;
        b=LPeY370rTQ39zpgv/TwrO411lv7RjB4/XWXoBICsfETfDQVS9pMrAPsVCnzNK2zghRXJri
        jjnxxOQ45CAE54Q9wVY2iS/OKnhLh73I3Ojj5XgSuQvRv8YSAAGUsAGRiuteHPSPcWZ0x5
        aQAldr64EwAkaG5wL5sPzAfm2SPav4U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-isOi60bXOMWur3-0kciGeA-1; Tue, 23 Feb 2021 05:49:11 -0500
X-MC-Unique: isOi60bXOMWur3-0kciGeA-1
Received: by mail-wr1-f71.google.com with SMTP id d10so7132522wrq.17
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 02:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZIAwNUkYihjlq8pJR90ewHu5uHpkP1D9IOZ1jYpoiYI=;
        b=KxRVwCIWeArDOdXvXK+2dY9lQpyqhqhEu1XD+U/jchJANr+XJ0+QNyqUm0Mpkh1Djh
         kNAafUepl+s6xvkEJIp8U682Iq6+qQ7+6tVJ0xmcAtyvYaQYUD5bL8RAEktKnqKLsU4/
         8pMIKpPnnbStxHH3BN8uiNfHmvDzIwZu3Ku/cRPLhiUGNaQuJuQkV7iZ0DtXZVh1y4tO
         GHEbYAh5rL64oB9UuALb1AMwmAgKZ7J7+VEiahJqtFMa3axouaTpC11Q65/0TmKxGgyh
         1tms5qu6aNAM/P5C33Bcm6NCI9R6Vgt4keJNPqprF2/6IUfUTTQOz7YQm4Wy0lLdoRAU
         zgsQ==
X-Gm-Message-State: AOAM532VC7K81W2YK2/VgKHHzXfW7hV2Nz5GpfqofFIIce7c/h1qHDR8
        xMx/3L9KfKzIREpSJEkeb6cxsxUBysK3WJPNulkXLtPe06VkhwRP1iyAFRIY4ZBDJMcmdHukngD
        H+bXPBZd3edb1koFKFZtbG6Qh
X-Received: by 2002:adf:d1ce:: with SMTP id b14mr10791126wrd.126.1614077349737;
        Tue, 23 Feb 2021 02:49:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvT+hIO4kKkLM6XOCti7hmCGJOQ3BayTDR28UcVLwt6FXo8TD9xGBkVBCYXcRQW5kCAxIr4g==
X-Received: by 2002:adf:d1ce:: with SMTP id b14mr10791103wrd.126.1614077349494;
        Tue, 23 Feb 2021 02:49:09 -0800 (PST)
Received: from localhost.localdomain ([151.29.106.174])
        by smtp.gmail.com with ESMTPSA id d15sm17449284wrb.43.2021.02.23.02.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 02:49:09 -0800 (PST)
Date:   Tue, 23 Feb 2021 11:49:07 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RT v5.11-rt7] WARNING at include/linux/seqlock.h:271
 nft_counter_eval
Message-ID: <YDTdo+jETVr983t6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing the following splat right after boot (or during late boot
phases) with v5.11-rt7 (LOCKDEP enabled).

[   85.273583] ------------[ cut here ]------------
[   85.273588] WARNING: CPU: 5 PID: 1416 at include/linux/seqlock.h:271 nft_counter_eval+0x95/0x130 [nft_counter]
[   85.273600] Modules linked in: nft_counter tun bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6_tables nft_compat ip_set nf_tables nfnetlink cmac bnep sunrpc iwlmvm mac80211 intel_rapl_msr intel_rapl_common rtsx_usb_ms memstick sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp libarc4 crct10dif_pclmul crc32_pclmul joydev ghash_clmulni_intel iwlwifi rapl intel_cstate snd_hda_codec_realtek snd_hda_codec_generic intel_uncore cfg80211 ledtrig_audio wmi_bmof intel_wmi_thunderbolt btusb mei_wdt btrtl snd_hda_codec_hdmi pcspkr btbcm btintel bluetooth iTCO_wdt snd_hda_intel iTCO_vendor_support snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core ecdh_generic ecc rfkill snd_seq snd_seq_device snd_pcm snd_timer mei_me snd mei i2c_i801 i2c_smbus lpc_ich soundcore acpi_cpufreq ip_tables xfs libcrc32c nouveau sr_mod sd_mod cdrom t10_pi
[   85.273678]  hid_logitech_hidpp sg drm_ttm_helper ttm video drm_kms_helper rtsx_usb_sdmmc mmc_core syscopyarea sysfillrect sysimgblt fb_sys_fops hid_logitech_dj drm crc32c_intel mxm_wmi rtsx_usb igb ahci libahci ata_generic r8169 e1000e libata dca i2c_algo_bit realtek wmi dm_mirror dm_region_hash dm_log dm_mod fuse
[   85.273707] CPU: 5 PID: 1416 Comm: irq/44-eno1 Tainted: G S                5.11.0-rt7 #4
[   85.273711] Hardware name: LENOVO 30B6S2F900/1030, BIOS S01KT65A 08/06/2019
[   85.273713] RIP: 0010:nft_counter_eval+0x95/0x130 [nft_counter]
[   85.273718] Code: 6c f6 85 c0 74 26 65 8b 05 28 0f bf 3e 85 c0 75 1b 65 8b 05 1d fb a2 3e a9 ff ff ff 7f 75 0d 65 8b 05 03 0c a3 3e 85 c0 74 02 <0f> 0b 83 45 00 01 ff 74 24 28 4c 8d 6d 08 45 31 c9 31 c9 41 b8 01
[   85.273722] RSP: 0018:ffffb1ec0d1cf7d0 EFLAGS: 00010202
[   85.273725] RAX: 0000000000000001 RBX: ffffd1e3ffc173d0 RCX: 0000000000000001
[   85.273726] RDX: ffff95c488d23580 RSI: ffffffffb6f8df42 RDI: ffffffffb6f5cafe
[   85.273728] RBP: ffff95cbdfdee020 R08: 0000000000000002 R09: 0000000000000001
[   85.273730] R10: 0000000000000100 R11: 0000000000000001 R12: ffffb1ec0d1cf9f8
[   85.273732] R13: ffff95cc3acc6500 R14: ffff95cc3ad30ee8 R15: ffff95cc3ad30eb8
[   85.273734] FS:  0000000000000000(0000) GS:ffff95cbdfc00000(0000) knlGS:0000000000000000
[   85.273736] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   85.273738] CR2: 000056404f3b3300 CR3: 000000028833e001 CR4: 00000000001706e0
[   85.273740] Call Trace:
[   85.273752]  nft_do_chain+0x17e/0x6a0 [nf_tables]
[   85.273771]  ? call_rcu+0x319/0x5e0
[   85.273806]  ? rt_cache_route+0x88/0xa0
[   85.273817]  ? ip_route_input_slow+0x9ea/0x11b0
[   85.273832]  ? sched_clock+0x5/0x10
[   85.273847]  ? __lock_acquire+0x3cb/0x15e0
[   85.273910]  nft_do_chain_ipv4+0x66/0x80 [nf_tables]
[   85.273936]  nf_hook_slow+0x44/0xc0
[   85.273948]  ip_local_deliver+0x10e/0x240
[   85.273959]  ? ip_protocol_deliver_rcu+0x2d0/0x2d0
[   85.273972]  ip_rcv+0x142/0x220
[   85.273982]  ? ip_rcv_finish_core.isra.22+0x5e0/0x5e0
[   85.273995]  __netif_receive_skb_core+0x5ee/0x1420
[   85.274033]  ? __netif_receive_skb_list_core+0x13b/0x2c0
[   85.274036]  __netif_receive_skb_list_core+0x13b/0x2c0
[   85.274059]  netif_receive_skb_list_internal+0x260/0x420
[   85.274066]  ? e1000_clean_rx_irq+0x31c/0x420 [e1000e]
[   85.274100]  napi_complete_done+0x6e/0x1b0
[   85.274109]  e1000e_poll+0xc9/0x290 [e1000e]
[   85.274136]  net_rx_action+0x112/0x550
[   85.274161]  __do_softirq+0xb8/0x5f4
[   85.274188]  __local_bh_enable_ip+0x13d/0x170
[   85.274200]  ? irq_finalize_oneshot.part.45+0xe0/0xe0
[   85.274204]  ? irq_thread+0xa7/0x1d0
[   85.274205]  irq_forced_thread_fn+0x6a/0x80
[   85.274213]  irq_thread+0x111/0x1d0
[   85.274220]  ? wake_threads_waitq+0x30/0x30
[   85.274229]  ? irq_thread_check_affinity+0xd0/0xd0
[   85.274233]  kthread+0x194/0x1b0
[   85.274239]  ? kthread_park+0x80/0x80
[   85.274250]  ret_from_fork+0x22/0x30
[   85.274286] irq event stamp: 7056
[   85.274288] hardirqs last  enabled at (7058): [<ffffffffb5d8263b>] vprintk_store+0x45b/0x580
[   85.274294] hardirqs last disabled at (7059): [<ffffffffb5d824ea>] vprintk_store+0x30a/0x580
[   85.274298] softirqs last  enabled at (6634): [<ffffffffb5cf5250>] __local_bh_enable_ip+0xc0/0x170
[   85.274302] softirqs last disabled at (6644): [<ffffffffb5d87775>] irq_forced_thread_fn+0x5/0x80
[   85.274304] ---[ end trace 0000000000000002 ]---

Please let me know if this is known already and/or if you need more
info (configs/etc).

Best,
Juri

