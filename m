Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B045030FB2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbhBDSS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbhBDRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:20:28 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CA0C06178B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 09:19:47 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id t13so2603537plg.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GkV/UHW40ojQINSJGLSD5pRuP03bJ/Yv3/kf3sMMqUY=;
        b=cO/etlrrEAzH/g1dbDSHauc4EzO7fZ2R+6UmMcdpjUQej4vTfKrqsHKiRkmb4iK3ZW
         GtQk37rbrYe46Cdbulsuekq+yF2V0ZCBgqq+USJ4prDmtt2w5mJqItMEst8FW+U6cJom
         NBgsvmwUFUntRGhS+4iNmG6cgHvxhb43Ic6+jOr2AqQFfNriCikLrwXnFdrQmyYA2Rao
         Cl/BcoImBY71li6bW5mqQcY9CNEIOxbGPl1yqTXYsL0NmARWtAohBoiQ7MNSMMeaqxvR
         h09dSOPBRJ0LArGSc/u3oD59FIhQ07ZkmYvYqWajGzfICETSyVEMFxFoCL//DxvONIfJ
         Q0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GkV/UHW40ojQINSJGLSD5pRuP03bJ/Yv3/kf3sMMqUY=;
        b=ag2+Hiez616v4gU6PKA7PVidvfd9RyEJsIK1qLNApSOXSs4Wsakw8i0O4rRxopJUhr
         UtOCHJsqWP2tMNntREQgdjL+b9N0jFeUqZpn5TrAvPcwUmI3INFbv3obQv3N/vkQDh3l
         0zOBr05wZ5W6CnZJhdw4RfEC7cpm1p871z5BClC3cQ+2h4sWnXNGmzowYkiOd4GV1AZO
         IxXW84yWLAoRyOxDx6DQ7zMoEpmdN6rtEzsabAoYmTSgij5/QP41TOKHQ8DqmERIrEcr
         KIp30NxpCNc083Jn3894ZrKMohM+mv9kZB23HUe7+NR4iSwnFI+ih1Adyo6Bf5X6usa/
         R3mA==
X-Gm-Message-State: AOAM531qumtaG8RQldAdkzwUSmn9LmdT9Z09h28b/yWDHDQd0nrJBFGb
        kZnOysoMSb2+LZKjqZObgNBS4v4hBUlv
X-Google-Smtp-Source: ABdhPJwZaUPMg1NyBgDgtgmMlUvddCN80MhfXCBqI3DFZkywijVbuzNalDMOpxzEr6D7+EXxD41EvAbqHBiR
Sender: "brianvv via sendgmr" <brianvv@brianvv.c.googlers.com>
X-Received: from brianvv.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:348])
 (user=brianvv job=sendgmr) by 2002:a17:90a:6288:: with SMTP id
 d8mr494508pjj.49.1612459186925; Thu, 04 Feb 2021 09:19:46 -0800 (PST)
Date:   Thu,  4 Feb 2021 17:19:42 +0000
In-Reply-To: <20210204171942.469883-1-brianvv@google.com>
Message-Id: <20210204171942.469883-2-brianvv@google.com>
Mime-Version: 1.0
References: <20210204171942.469883-1-brianvv@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH net-next 2/2] net: fix building errors on powerpc when
 CONFIG_RETPOLINE is not set
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the errores reported when building for powerpc:

 ERROR: modpost: "ip6_dst_check" [vmlinux] is a static EXPORT_SYMBOL
 ERROR: modpost: "ipv4_dst_check" [vmlinux] is a static EXPORT_SYMBOL
 ERROR: modpost: "ipv4_mtu" [vmlinux] is a static EXPORT_SYMBOL
 ERROR: modpost: "ip6_mtu" [vmlinux] is a static EXPORT_SYMBOL

Fixes: f67fbeaebdc0 ("net: use indirect call helpers for dst_mtu")
Fixes: bbd807dfbf20 ("net: indirect call helpers for ipv4/ipv6 dst_check functions")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 net/ipv4/route.c | 4 ++--
 net/ipv6/route.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 9e6537709794..be31e2446470 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1206,7 +1206,7 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ipv4_dst_check(struct dst_entry *dst,
 		return NULL;
 	return dst;
 }
-EXPORT_SYMBOL(ipv4_dst_check);
+EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
@@ -1337,7 +1337,7 @@ INDIRECT_CALLABLE_SCOPE unsigned int ipv4_mtu(const struct dst_entry *dst)
 
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
-EXPORT_SYMBOL(ipv4_mtu);
+EXPORT_INDIRECT_CALLABLE(ipv4_mtu);
 
 static void ip_del_fnhe(struct fib_nh_common *nhc, __be32 daddr)
 {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 8d9e053dc071..0d1784b0d65d 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2644,7 +2644,7 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 
 	return dst_ret;
 }
-EXPORT_SYMBOL(ip6_dst_check);
+EXPORT_INDIRECT_CALLABLE(ip6_dst_check);
 
 static struct dst_entry *ip6_negative_advice(struct dst_entry *dst)
 {
@@ -3115,7 +3115,7 @@ INDIRECT_CALLABLE_SCOPE unsigned int ip6_mtu(const struct dst_entry *dst)
 
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
-EXPORT_SYMBOL(ip6_mtu);
+EXPORT_INDIRECT_CALLABLE(ip6_mtu);
 
 /* MTU selection:
  * 1. mtu on route is locked - use it
-- 
2.30.0.365.g02bc693789-goog

