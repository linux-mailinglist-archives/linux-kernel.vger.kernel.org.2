Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9532D66A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhCDPSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:18:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234214AbhCDPSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614871037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=54FLfLttcqTPJdBKqLXBMQ2gzXdn4duuZWnQ9vUit9g=;
        b=Rp0dDd2WRchwakGXe8k+sI7FknKUwKwHO97cUcM9NiSR3bbMSgbRQj/HIkoot7MVNx7hV1
        BcmnKFjNIdXbjW3Mw3NATp3y7bfpCCxX0Y3eyGu4/WOmCporOQzIXRexiGphGN8KU6bsel
        4p3LLFtuPrmYXWOZDIgRse/s4Uj5BYY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-a01Bei3mM3y4BcRY2jyz8w-1; Thu, 04 Mar 2021 10:17:14 -0500
X-MC-Unique: a01Bei3mM3y4BcRY2jyz8w-1
Received: by mail-qt1-f199.google.com with SMTP id p32so12999179qtd.14
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 07:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=54FLfLttcqTPJdBKqLXBMQ2gzXdn4duuZWnQ9vUit9g=;
        b=QDXtWSMO226nZkGGEts8/Qy0BskU9HqGw3fB1xhQGMXR17L2TCCPd6YiPMzrZ0zpDq
         xpB/LUIHiGRRt+PYC/p2u0m+M3AxvKI9u4mEjQHXXT1g0ScJXqipBzCGo82Sod/tqjLN
         280954Ov5Ri0aetc0EEyvMrxX685WV+28gFPETB7ArTthRP7lmPZpgknrHSbe1XWOhca
         +IafLz3nsZ7F0gZMoZVn4G/FbMi6svzNV0+/SUuMwx0Ig2KtnfgpZCPDykJlSp8yrXbX
         fWiTR5HAuxEKZEUJHGiJMeZ5uHVfWWrrEdww2Zt/M30WyPuSelEh50Yo9X4YjSwdlJG8
         +Hmw==
X-Gm-Message-State: AOAM530vba9fRZFpImDyXaKgK0Yd10l4kwkr4ghy6io5F8aJo/qDIuOd
        DOGPXe+u4RleKCf9r+wtYTrXeMY28K3UG7rOoe9U+GAz3nDIUflzLp++YNmyFdCik3KnKlyq85v
        JCqUmn0mHcuULY3IT8GuOAK1A
X-Received: by 2002:a37:a390:: with SMTP id m138mr4197948qke.59.1614871034138;
        Thu, 04 Mar 2021 07:17:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqtV88erkKXf4r2R64HpnrWRf0NrW0TgJqwzsrJBunpTMWzDSz9jcJwrQ+f4OqhFGZ9b7c7Q==
X-Received: by 2002:a37:a390:: with SMTP id m138mr4197929qke.59.1614871033904;
        Thu, 04 Mar 2021 07:17:13 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id i6sm9030141qtd.93.2021.03.04.07.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:17:13 -0800 (PST)
Message-ID: <f7c456548b7161c33b207ec6960fe28b5bc1f2b6.camel@redhat.com>
Subject: WARNING: CPU: 5 PID: 69 at drivers/gpu/drm/ttm/ttm_bo.c:139
 ttm_bo_move_to_lru_tail+0x376/0x500 [ttm]
From:   Jeff Layton <jlayton@redhat.com>
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>
Date:   Thu, 04 Mar 2021 10:17:12 -0500
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was doing some testing in a KVM with a kernel based on this commit:

    f69d02e37a85 (origin/master, dhowells/master, master) Merge tag 'misc-5.12-2021-03-02' of git://git.kernel.dk/linux-block

...with some ceph+fscache patches on top, and am getting a ton of warnings
popping that look like this:

[  147.601271] ------------[ cut here ]------------
[  147.606720] WARNING: CPU: 5 PID: 69 at drivers/gpu/drm/ttm/ttm_bo.c:139 ttm_bo_move_to_lru_tail+0x376/0x500 [ttm]
[  147.613224] Modules linked in: nft_ct(E) nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) ip_set(E) rfkill(E) nf_tables(E) nfnetlink(E) cachefiles(E) fscache(E) netfs(E) sunrpc(E) intel_rapl_msr(E) intel_rapl_common(E) iTCO_wdt(E) intel_pmc_bxt(E) iTCO_vendor_support(E) joydev(E) virtio_balloon(E) pcspkr(E) i2c_i801(E) lpc_ich(E) i2c_smbus(E) fuse(E) zram(E) xfs(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E) virtio_blk(E) virtio_console(E) ghash_clmulni_intel(E) serio_raw(E) virtio_net(E) net_failover(E) failover(E) qxl(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) cec(E) qemu_fw_cfg(E) drm(E) [last unloaded: ip_tables]
[  147.651585] CPU: 5 PID: 69 Comm: kworker/5:1 Tainted: G        W   E     5.12.0-rc1+ #62
[  147.657667] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
[  147.663860] Workqueue: events qxl_gc_work [qxl]
[  147.669451] RIP: 0010:ttm_bo_move_to_lru_tail+0x376/0x500 [ttm]
[  147.675241] Code: ff 48 8d bd 38 01 00 00 e8 b7 cd 00 c7 48 8b 85 38 01 00 00 be ff ff ff ff 48 8d 78 70 e8 42 8a fa c7 85 c0 0f 85 d4 fc ff ff <0f> 0b e9 cd fc ff ff 48 8b 7c 24 20 e8 49 cc 00 c7 44 8b a5 f8 02
[  147.687933] RSP: 0018:ffff888100e4fb60 EFLAGS: 00010246
[  147.693596] RAX: 0000000000000000 RBX: ffff88812666a270 RCX: 0000000000000001
[  147.699529] RDX: 0000000000000002 RSI: ffff88812666a1b0 RDI: ffff888100e3c418
[  147.705425] RBP: ffff88812666a000 R08: 0000000000000000 R09: ffffffff8b7e7b4f
[  147.711335] R10: fffffbfff16fcf69 R11: 0000000000000001 R12: ffff88812bd49000
[  147.717216] R13: ffff88812bd4bc00 R14: ffff88812196ce90 R15: ffffffffc0561920
[  147.723104] FS:  0000000000000000(0000) GS:ffff88841dc00000(0000) knlGS:0000000000000000
[  147.729160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  147.734859] CR2: 000055d11e6120b0 CR3: 000000006ba2c000 CR4: 00000000003506e0
[  147.740764] Call Trace:
[  147.745942]  ttm_bo_release+0x78f/0x850 [ttm]
[  147.751393]  qxl_bo_unref+0x51/0x70 [qxl]
[  147.756761]  qxl_release_free_list+0xa1/0x160 [qxl]
[  147.762287]  ? qxl_get_timeline_name+0x10/0x10 [qxl]
[  147.767856]  qxl_release_free+0xbb/0x140 [qxl]
[  147.773300]  qxl_garbage_collect+0x18a/0x280 [qxl]
[  147.778788]  ? qxl_queue_garbage_collect+0xd0/0xd0 [qxl]
[  147.784375]  ? lockdep_hardirqs_on_prepare+0x178/0x220
[  147.789931]  process_one_work+0x525/0x9b0
[  147.795314]  ? pwq_dec_nr_in_flight+0x110/0x110
[  147.800744]  ? lock_acquired+0x2fe/0x560
[  147.806137]  worker_thread+0x2ea/0x6e0
[  147.811511]  ? __kthread_parkme+0xc0/0xe0
[  147.816916]  ? process_one_work+0x9b0/0x9b0
[  147.822326]  kthread+0x1fb/0x220
[  147.827570]  ? __kthread_bind_mask+0x70/0x70
[  147.832964]  ret_from_fork+0x22/0x30
[  147.838296] irq event stamp: 194523
[  147.843565] hardirqs last  enabled at (194533): [<ffffffff87203641>] console_unlock+0x631/0x740
[  147.849649] hardirqs last disabled at (194542): [<ffffffff8720358e>] console_unlock+0x57e/0x740
[  147.855777] softirqs last  enabled at (193620): [<ffffffff8713a38e>] __irq_exit_rcu+0x13e/0x190
[  147.861908] softirqs last disabled at (193615): [<ffffffff8713a38e>] __irq_exit_rcu+0x13e/0x190
[  147.868011] ---[ end trace 595bd7e9298cfe26 ]---

Is this a known bug? Is there a patch that fixes it? I'd be happy to
test it since it's making testing in VMs difficult right now.

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>

