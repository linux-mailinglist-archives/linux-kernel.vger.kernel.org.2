Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D531684D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBJNud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhBJNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:50:06 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F84DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:49:26 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 189so1296646pfy.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZrp4ey3BLAuikGmGMr830Mf2wtqhA+AHoRLyP6gKQs=;
        b=PaKY+EhKniZKlDeiVMZv+asvcmN7P42K0OiT3yqACEIrl03eiCa6VIPl7usNhjaBzF
         qawdpWrDEY4HzbgoXt8EVEjpAbREGJtFkqe7V3yU6PoJCAN8kLR2x7Kk23kKScaTK3rk
         PVnuye2KdbbN+76b3m1FyOVobD9ZTvXMey6N4GIJk10lypbbkShdZYZqWZfsPYhlA+Um
         t2iYehpnXQ3DZSmqLy7WV7mohbekspQSsZaZhUXK0osK+CqpJBta4HVKcPV+LIDd0eoB
         JiAeppW17e25keF3X0meyf6quXtciYNKKU6vIk5XOEFcxS/SrEMe99TG0MRft/zZQzh8
         e3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZrp4ey3BLAuikGmGMr830Mf2wtqhA+AHoRLyP6gKQs=;
        b=blS0UckvRv+5odSfPVQk8/1114X4fn3lTcnujOx1xL3K4EKrbni3wrYMePgKW34GCo
         9xrH8g42HydQLjR+HmdV5VU1smX+MLk+3FKgEqMCKdmji+g9QeCK/xnjonCtROG+dYND
         YtVukWmTOOTHlEOThgEr9CCcXuJUf9T6D/k6mO9DLA/pH/FBBRlqsHH/PiZaAxieqILa
         KwZW3FrTTblZ2Zm7gHXsfexZJzR2leO/hrVjVPZ5FkFyPOEDvwy33n3rhMNufdVIbeeM
         Es1Kz5LWobQTjIslvRP5xF72oG6b8EedzLc5SnwXMs+Y2b4TqxGyvT3X1r6ACvSVmGvs
         jk7w==
X-Gm-Message-State: AOAM533SiIVjoaFhAl6mOOHkb/vBL3dmU666jPvsyP9yvznyZa1krb9X
        KNLpm8dqDfCQDN7NoVmmsR/N7uo0b9E=
X-Google-Smtp-Source: ABdhPJzg/PokLBBBrKHvdHrLyfL3J93DZ94REQOQmgaRYbmXRatdEyvXkrjHOrmP6yNgM4WufXxgvw==
X-Received: by 2002:a62:6d06:0:b029:1d0:f7ca:59d0 with SMTP id i6-20020a626d060000b02901d0f7ca59d0mr3266631pfc.75.1612964965472;
        Wed, 10 Feb 2021 05:49:25 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:48d8:4083:5be:90d7])
        by smtp.gmail.com with ESMTPSA id x190sm2620116pfx.166.2021.02.10.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 05:49:24 -0800 (PST)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH linux-next] vpda: correctly size vdpa_nl_policy
Date:   Wed, 10 Feb 2021 05:49:11 -0800
Message-Id: <20210210134911.4119555-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

We need to ensure last entry of vdpa_nl_policy[]
is zero, otherwise out-of-bounds access is hurting us.

BUG: KASAN: global-out-of-bounds in netlink_policy_dump_add_policy+0x3b6/0x440   net/netlink/policy.c:160
Read of size 1 at addr ffffffff89cc61d0 by task syz-executor181/8413

CPU: 0 PID: 8413 Comm: syz-executor181 Not tainted 5.11.0-rc6-next-20210205-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack   lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163   lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5/0x2f8   mm/kasan/report.c:232
 __kasan_report   mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8   mm/kasan/report.c:416
 netlink_policy_dump_add_policy+0x3b6/0x440   net/netlink/policy.c:160
 ctrl_dumppolicy_start+0x3e1/0x760   net/netlink/genetlink.c:1181
 genl_start+0x3cc/0x670   net/netlink/genetlink.c:604
 __netlink_dump_start+0x584/0x900   net/netlink/af_netlink.c:2363
 genl_family_rcv_msg_dumpit+0x2af/0x310   net/netlink/genetlink.c:686
 genl_family_rcv_msg   net/netlink/genetlink.c:780 [inline]
 genl_rcv_msg+0x434/0x580   net/netlink/genetlink.c:800
 netlink_rcv_skb+0x153/0x420   net/netlink/af_netlink.c:2494
 genl_rcv+0x24/0x40   net/netlink/genetlink.c:811
 netlink_unicast_kernel   net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0   net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90   net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec   net/socket.c:654 [inline]
 sock_sendmsg+0xcf/0x120   net/socket.c:674
 ____sys_sendmsg+0x6e8/0x810   net/socket.c:2350
 ___sys_sendmsg+0xf3/0x170   net/socket.c:2404
 __sys_sendmsg+0xe5/0x1b0   net/socket.c:2437
 do_syscall_64+0x2d/0x70   arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43ef29
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc75c06108 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043ef29
RDX: 0000000000000000 RSI: 00000000200029c0 RDI: 0000000000000003
RBP: 0000000000402f10 R08: 00000000004ac018 R09: 0000000000400488
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402fa0
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488

The buggy address belongs to the variable:
 vdpa_nl_policy+0x90/0x3a00

Memory state around the buggy address:
 ffffffff89cc6080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff89cc6100: 00 00 00 00 f9 f9 f9 f9 00 00 00 00 00 00 00 00
>ffffffff89cc6180: 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
                                                 ^
 ffffffff89cc6200: 05 f9 f9 f9 f9 f9 f9 f9 00 00 07 f9 f9 f9 f9 f9
 ffffffff89cc6280: 00 00 00 01 f9 f9 f9 f9 00 07 f9 f9 f9 f9 f9 f9

Fixes: be7f5be9e84a ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Parav Pandit <parav@nvidia.com>
Cc: Eli Cohen <elic@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9700a0adcca089fe9abb0b211fada314fa4a04ef..3d997b3893452f4da6a6800e128c57a9a024c0ad 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -603,7 +603,7 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
 	return msg->len;
 }
 
-static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX] = {
+static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
-- 
2.30.0.478.g8a0d178c01-goog

