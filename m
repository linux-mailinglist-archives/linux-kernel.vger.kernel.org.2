Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365B6326B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 03:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhB0CKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 21:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhB0CJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 21:09:59 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD80C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 18:09:19 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u4so12786294ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 18:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SdhBUs8s/vk8K5/jttDtb/HVOMX+CdlvGz3nQ/5mSgs=;
        b=MUPoSTAW74MseDRamsA2vaOO6eGNm3bhI6qBImU+B9CdPi79236XcLLLydjvVmLZIY
         HDMycn0a2Q/lFppoPvVgRjrBi/CPiM4cvQkrgII9xfcZXhbGtZ7BHgSqvgqEVeCllZuA
         PKKYhBYxvjlqmEZ95Y7185m0vqQdx3akNYuY3PpRLSvWFVSKwhZYeXAXAEVcZyTzX8p3
         V+Lk+RtpT4vy6j7RboQ8muIXRYvG4eu7T/4XXxuMu7ceAP0CtCWMfPLk2E0I/ws5JvCk
         SbSTp3wr7CoQHsa1WgnP24Aw5LhyI/GyzDcActFFquSviyScj+7KIhO1JIJ/8tF26WB+
         zcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SdhBUs8s/vk8K5/jttDtb/HVOMX+CdlvGz3nQ/5mSgs=;
        b=hIL7KwBPlSLEFTwjt2hTL8veTYSC7k4nyhuyuHgebaB4CvZJOjLU2aAF1wo+Mr0kOK
         fTK5dyiznmc18M2LYfEe8cAodMrPH4NzOdy/ZZMfEloenA6BP5gfaBeqjjojKp5lMEyq
         sGhxauU4yDTTRJXmQIptrUZC+n1dARG49OXwkmmnZ271naXDecejkWj+v6a3kvkIhNGe
         hrO3tu9xC08cooS9Ps8eDMMuF2n4drA8vxc9VGejrMUpSFp6OHvPhVAIplf8EisWk+V+
         sbxT+nopCGCn1/v4GLqcACsHVJfNFFSc7J8gzt0jeCLP5TLi0+rC9tttSpRSGJ4edSa8
         IO9w==
X-Gm-Message-State: AOAM533FsaydunzRqn2VlHb7QsXbpCgKTB+sozHHy7FL4aQXEZUIQ+vk
        g9iDUtYA47+p9qOceSiLnVURsY3xz8HrgQe9KABXZHx1TVf85g==
X-Google-Smtp-Source: ABdhPJy3zACds+6g/HXzTTkgC+e6i6msxSlvZMVlfgI8CUL972qTQfvcPHDbcO29d9V13qk/WY0ZRq4gkVM32BW080g=
X-Received: by 2002:a2e:9617:: with SMTP id v23mr3225002ljh.406.1614391757217;
 Fri, 26 Feb 2021 18:09:17 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 26 Feb 2021 20:09:06 -0600
Message-ID: <CAH2r5mvy_T6Hb6vCyQiBmY5tKUMgEG8sb6E4CFMnbF7FwG7oaw@mail.gmail.com>
Subject: Current mainline
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone seen this?  I was running some xfstests today on current
mainline (ran same tests yesterday and multiple times last week on
5.11 and did not see this) and hit this multiple times

[  287.702292] ------------[ cut here ]------------
[  287.702296] WARNING: CPU: 5 PID: 8223 at
drivers/gpu/drm/ttm/ttm_bo.c:512 ttm_bo_release+0x2f7/0x350 [ttm]
[  287.702309] Modules linked in: cifs ccm md4 cmac nls_utf8 libarc4
libdes rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace
fscache nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT
ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4
xt_conntrack ebtable_nat ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw
iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter sunrpc crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel virtio_balloon ip_tables xfs qxl drm_ttm_helper
ttm drm_kms_helper cec drm virtio_net net_failover floppy failover
virtio_blk virtio_console crc32c_intel qemu_fw_cfg [last unloaded:
cifs]
[  287.702352] CPU: 5 PID: 8223 Comm: kworker/5:50 Tainted: G        W
        5.11.0 #1
[  287.702355] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  287.702357] Workqueue: events qxl_gc_work [qxl]
[  287.702362] RIP: 0010:ttm_bo_release+0x2f7/0x350 [ttm]
[  287.702367] Code: e9 6a fd ff ff e8 c9 e7 46 eb e9 92 fd ff ff 49
8b 7f 90 b9 30 75 00 00 31 d2 be 01 00 00 00 e8 1f 0b 47 eb 49 8b 47
e0 eb a1 <0f> 0b 49 8d 77 08 41 c7 87 94 00 00 00 00 00 00 00 31 d2 4c
89 f7
[  287.702370] RSP: 0018:ffffb2c2c877fda8 EFLAGS: 00010202
[  287.702372] RAX: 0000000000000001 RBX: 000000000000000c RCX: 000000000000000d
[  287.702373] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffffffffc035a0e8
[  287.702374] RBP: ffff922102e4c688 R08: ffff92210f996050 R09: ffff922110ac5938
[  287.702376] R10: 0000000000000000 R11: ffff922100469240 R12: ffff922110ac5e80
[  287.702377] R13: ffff92210b5509d0 R14: ffff92210b550800 R15: ffff92210b550968
[  287.702383] FS:  0000000000000000(0000) GS:ffff92252bd40000(0000)
knlGS:0000000000000000
[  287.702385] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  287.702386] CR2: 000055617142e5d0 CR3: 0000000334610005 CR4: 00000000003706e0
[  287.702400] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  287.702401] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  287.702403] Call Trace:
[  287.702408]  qxl_bo_unref+0x3a/0x50 [qxl]
[  287.702414]  qxl_release_free_list+0x49/0x90 [qxl]
[  287.702419]  qxl_release_free+0x72/0xe0 [qxl]
[  287.702423]  qxl_garbage_collect+0xd1/0x180 [qxl]
[  287.702427]  process_one_work+0x1c0/0x390
[  287.702438]  worker_thread+0x30/0x390
[  287.702441]  ? process_one_work+0x390/0x390
[  287.702444]  kthread+0x117/0x130
[  287.702448]  ? kthread_park+0x90/0x90
[  287.702450]  ret_from_fork+0x22/0x30
[  287.702457] ---[ end trace 03e19399d00180a1 ]---
[  287.702539] ------------[ cut here ]------------

-- 
Thanks,

Steve
