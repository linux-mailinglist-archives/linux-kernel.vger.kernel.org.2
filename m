Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7E8326DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 17:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhB0Qjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 11:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhB0QiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 11:38:23 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA55AC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 08:37:37 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y12so1329180ljj.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kJ+akVZdN0RZerG3cR+FK9vS9Cr6lCvITb5oXS64J4=;
        b=fPC02Kq35e/J7JRhNeEX/kO4FeLGB5X3MuEYAHzuDzB7pKmHWsAO/Lmu0Ovypd/hzY
         0VCrqTUWIS+3lvEuBaj8sTtL4aLSGsFjMIQWM8K2dYqjus5t38jykw2Ij1jDiic9vgKh
         ZgSPd6LKTymKLwui4UfQoPTLBMTal4wS65DaHPMYaLqpX8CZz7c4lCVY8FekV3oodGOF
         tNCu2JsNSq+z7m79lj/c/lQoDEkamvIkQtK2sY6GyDNULUeRu2g/tO54LrpKJoO3qB0A
         mID0UpaTNqvYqs4w9Bj7LTuObwJTyQybomqixHpxlTiB9Dr8OTaz1N6kSz7lP14VeWvy
         ltMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kJ+akVZdN0RZerG3cR+FK9vS9Cr6lCvITb5oXS64J4=;
        b=ObOynHlgOnWO1Ca6w8NTCRZiI6pVr6dl8OZLvGsbk2VpWfWuOyuflUrjEx7IXImtVR
         yAfTeDd+INjmu8ux1Xb2rU0yA1M908scZBSzJScoxpYLJfOiC/jCD+MF6oBSiY+FwFRR
         S0GH0fYsApRsvH18tBz4Ihb1+pn0q+9AtojnydqTmbxHVFZgA44mL/XOaLWQqUmhS9nb
         yLM2ZjU7q0v0NTV5K94aO3UKvURhEAIVLeCym2OKjtE6TV23fM35y/rQ9FkhxEekD88v
         QTQsYDJM7Kh/7CWlJaGkclj20pnH8gd4niGOaFWb1f/MG41J8239HSPfFujbxRj9PYnW
         BF/A==
X-Gm-Message-State: AOAM532iQNIRF2R6DjvjPTAJHGyl0Fle6PX5+qgWRmAgt2if2S+1wFPM
        Vsw1AThCB56zDyd/xWglh+tzCFfuR+RJ1zrG1W8=
X-Google-Smtp-Source: ABdhPJzopzD6I8JNOzZrBvGXbsHaTcPjgQUeh8KBRiKlw9oaXfsXjdj0nJqZB4FFc8tna0qI+LzsHw==
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr4606350ljb.81.1614443856122;
        Sat, 27 Feb 2021 08:37:36 -0800 (PST)
Received: from localhost.localdomain ([94.103.235.59])
        by smtp.gmail.com with ESMTPSA id c19sm1421401ljk.60.2021.02.27.08.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 08:37:35 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+80dccaee7c6630fa9dcf@syzkaller.appspotmail.com
Subject: [PATCH v2] net/core/skbuff: fix passing wrong size to __alloc_skb
Date:   Sat, 27 Feb 2021 19:35:19 +0300
Message-Id: <20210227163519.18229-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210227110306.13360-1-alobakin@pm.me>
References: <20210227110306.13360-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found WARNING in __alloc_pages_nodemask()[1] when order >= MAX_ORDER.
It was caused by __netdev_alloc_skb(), which doesn't check len value after adding NET_SKB_PAD.
Order will be >= MAX_ORDER and passed to __alloc_pages_nodemask() if size > KMALLOC_MAX_SIZE.
Same happens in __napi_alloc_skb.

static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
{
	struct page *page;
	void *ptr = NULL;
	unsigned int order = get_order(size);
...
	page = alloc_pages_node(node, flags, order);
...

[1] WARNING in __alloc_pages_nodemask+0x5f8/0x730 mm/page_alloc.c:5014
Call Trace:
 __alloc_pages include/linux/gfp.h:511 [inline]
 __alloc_pages_node include/linux/gfp.h:524 [inline]
 alloc_pages_node include/linux/gfp.h:538 [inline]
 kmalloc_large_node+0x60/0x110 mm/slub.c:3999
 __kmalloc_node_track_caller+0x319/0x3f0 mm/slub.c:4496
 __kmalloc_reserve net/core/skbuff.c:150 [inline]
 __alloc_skb+0x4e4/0x5a0 net/core/skbuff.c:210
 __netdev_alloc_skb+0x70/0x400 net/core/skbuff.c:446
 netdev_alloc_skb include/linux/skbuff.h:2832 [inline]
 qrtr_endpoint_post+0x84/0x11b0 net/qrtr/qrtr.c:442
 qrtr_tun_write_iter+0x11f/0x1a0 net/qrtr/tun.c:98
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x791/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported-by: syzbot+80dccaee7c6630fa9dcf@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Change-Id: I480a6d6f818a4c0a387db0cd3f230b68a7daeb16
---
 net/core/skbuff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 785daff48030..a35ba145a060 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -443,6 +443,9 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	if (len <= SKB_WITH_OVERHEAD(1024) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
+		if (unlikely(len > KMALLOC_MAX_SIZE))
+			return NULL;
+
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
 		if (!skb)
 			goto skb_fail;
@@ -517,6 +520,9 @@ struct sk_buff *__napi_alloc_skb(struct napi_struct *napi, unsigned int len,
 	if (len <= SKB_WITH_OVERHEAD(1024) ||
 	    len > SKB_WITH_OVERHEAD(PAGE_SIZE) ||
 	    (gfp_mask & (__GFP_DIRECT_RECLAIM | GFP_DMA))) {
+		if (unlikely(len > KMALLOC_MAX_SIZE))
+			return NULL;
+		
 		skb = __alloc_skb(len, gfp_mask, SKB_ALLOC_RX, NUMA_NO_NODE);
 		if (!skb)
 			goto skb_fail;
-- 
2.25.1

