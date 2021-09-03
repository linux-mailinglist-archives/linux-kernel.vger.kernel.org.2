Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1644006E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350736AbhICUpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbhICUps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:45:48 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D3C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 13:44:48 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j2so253183pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 13:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7Soqz5cW/00eP1GkgcHkpgPgIGWBo3IzFFwPZchx6KQ=;
        b=CISziLYPqVzwgfLTvVsuKKdfJ9hy5tNnaNph9Bpl4PfcYEbklJlKIHxoeCCu4+7gEW
         E6XazgNfS5sfxxdTG/G1dOXLw0njmM4PaeYQz1VvOeV06qDVOmIQbgbJ7PGeRPEpWdZZ
         EovYRaemlN4JUmDqLPVFq47UKu6do3nbkob/gYVDkmn1TuNATlltTrQpSVz1tXuO8tLi
         tnRttrNT6E7904iXCZMUcFN7ojNht+ZLwm9YR6push5FXAGovh1ZfpQH+UYKbaoLOKQq
         r0PW5d8+V6QX9pO6iWnejFSmuRBXjFYL4KZmJoZbAYZxJv9fvmI+LSgRHwKYFnLlnqR6
         gXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7Soqz5cW/00eP1GkgcHkpgPgIGWBo3IzFFwPZchx6KQ=;
        b=lBHAonMraVjrV5nTqvuzsoM07bXEIUTl1kALmxzhFxbcV8rL7WULZ47UlL7W0Rzggd
         DSdgtSputhUwJoisvxLEz4Nbyite0uN4wEiHoIxdGbO7FR00KV/Rm13iHxbXJ/S4Fv3c
         Xrq9MewmayZQA7HHX/xsHqkIoQrMD5iqUbLgwS7tEI156DAsvFW4VTNe87uXQYy8Uf2k
         P4tTFzoXWKwPWNgdUf10ZS9J/DKIDSHkgY16I5lRvyN/h/fwfD8fI5ud9qSK2bUdrk9n
         /3EiEIQivgjezW1KsUHgw3vUIG4gNi+MFX7/yImOXUzIwaDRRAvKSqpALpNJB6VMwKtx
         4LTA==
X-Gm-Message-State: AOAM5312q/lry9sox6xvBsXrfsx9GX0xzRw5clHGuxpvJCQeRwa4Tzwz
        NmtZIMs19xuwN3+2V3wUEshFjlqekWc=
X-Google-Smtp-Source: ABdhPJySivOT6wOtd/iY5DS3hZX+LSH1bxYuZz7S5VeFzaUVY2Vshj7ZKgXlspG2qDyX4fKz9aSbqw==
X-Received: by 2002:a17:90b:1bce:: with SMTP id oa14mr760329pjb.237.1630701887820;
        Fri, 03 Sep 2021 13:44:47 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id d5sm127456pjs.53.2021.09.03.13.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 13:44:47 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Subject: dozens of sysbot reports
Message-ID: <acdf065c-256d-47b0-5c20-203ff4b213d6@gmail.com>
Date:   Fri, 3 Sep 2021 13:44:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

I have a pile of (still under triage) sysbot reports coming after one of your patch

Typical stack trace:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 24889 at mm/util.c:597 kvmalloc_node+0x111/0x120 mm/util.c:597
Modules linked in:
CPU: 1 PID: 24889 Comm: syz-executor.5 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kvmalloc_node+0x111/0x120 mm/util.c:597
Code: 01 00 00 00 4c 89 e7 e8 8d 12 0d 00 49 89 c5 e9 69 ff ff ff e8 f0 21 d1 ff 41 89 ed 41 81 cd 00 20 01 00 eb 95 e8 df 21 d1 ff <0f> 0b e9 4c ff ff ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 e8 c6
RSP: 0018:ffffc90002abf268 EFLAGS: 00010216
RAX: 0000000000000431 RBX: ffffc90002abf380 RCX: ffffc90014157000
RDX: 0000000000040000 RSI: ffffffff81a4f621 RDI: 0000000000000003
RBP: 0000000000400dc0 R08: 000000007fffffff R09: 00000000ffffffff
R10: ffffffff81a4f5de R11: 000000000000001f R12: 0000000200000018
R13: 0000000000000000 R14: 00000000ffffffff R15: ffff8880121f0a00
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0063) knlGS:00000000f5562b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000561d64b67478 CR3: 00000000196e8000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 hash_ipport_create+0x3dd/0x1220 net/netfilter/ipset/ip_set_hash_gen.h:1524
 ip_set_create+0x782/0x15a0 net/netfilter/ipset/ip_set_core.c:1100
 nfnetlink_rcv_msg+0xbc9/0x13f0 net/netfilter/nfnetlink.c:296
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 nfnetlink_rcv+0x1ac/0x420 net/netfilter/nfnetlink.c:654
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f68549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f55625fc EFLAGS: 00000296 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000020000100
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
----------------


Caused by 

commit 7661809d493b426e979f39ab512e3adf41fbcc69
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jul 14 09:45:49 2021 -0700

    mm: don't allow oversized kvmalloc() calls


Do we want to fix all problematic callers, with ad-hoc patches like

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 16ae92054baa80b232995661ef72f5c8e6866663..ed14af7761166aebffcd1d98597d9023b147ddf3 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -250,6 +250,8 @@ EXPORT_SYMBOL_GPL(ip_set_type_unregister);
 void *
 ip_set_alloc(size_t size)
 {
+       if (size > INT_MAX)
+               return NULL;
        return kvzalloc(size, GFP_KERNEL_ACCOUNT);
 }
 EXPORT_SYMBOL_GPL(ip_set_alloc);


Thanks !

