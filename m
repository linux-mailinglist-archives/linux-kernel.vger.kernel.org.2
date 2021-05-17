Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA73827DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhEQJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbhEQJKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C876C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 10so4517340pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tC4Yit2SbJjztAAvm5FRO8SPt4WnJt05HNckOpA/Ce4=;
        b=mNX9z2w1b0od1UGqHzd57fw48FT9ZtzqDCVLXDrR+D4u/mnRAMkUcqIUQrekex91Py
         5q00yKWARWdtaTL2sXFPZzFHCk6xz2509GZZ1XRcB2KaDieaiDOd5gOYn0uO7D3TtYid
         lFaGQZJ5I3OTULNfss7VchBgXVOJnvXVAlAlQAv4DRrAJ/fgnAZq1AEyV+hP9Wk0JdcW
         U1hASuTrQUqKLgM081JhNRhtjzgkgzs7KWWqxgjuUDzRLoDq2Xe3AooT15ZUrOosr+za
         SKg9jgEQq9BtGO5Y84NtE7c6mMXs+lVpElAmQ/fh7jLQo8UOiohAgXOB9xMKg6mkxtqa
         rv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tC4Yit2SbJjztAAvm5FRO8SPt4WnJt05HNckOpA/Ce4=;
        b=Ji6BTsU5dc6EpUelI2gIVTdLUjZLBZ/5c9J8Edl1NM3ksSD699XGUYlNjaGI7bp+xM
         Vivl64mvFa7mBhKupEIo7mRfxJr7eKfwmZ/TSpA+RjtsxS/auUelh3jLhQ6Yg2yDd2RJ
         wF8ir66mZHFPJCYNDqQSnNuelWgv36HTy8llSc5pgoHFOJGMwL5/I8aNwYDZLWPMWw0B
         Www8D40xNnHMCkUKiz2aeI4bXgc9QIbv5w1uoRF6Kd7lNue/WPU6jUJiozscW2oWCjCa
         2h9TXe9SPLyj4IaxXCCQ4Mdg4kxyEZAju2/fvYiZGbmeHdLouQFeX4Kr4tGr6i+h7wwC
         NKJA==
X-Gm-Message-State: AOAM532U4Al0c7ybfJZLtBmvo5zfRsawtuRxSv91lzOS856OykETtKye
        sFvTVgWkw4ECrHknjHRum2fN
X-Google-Smtp-Source: ABdhPJxFNuB01DHVcLdx6l3Uu7uI8SeE3QtlrdAoSrluIEG+W3KePiiyGNbLVjn89/lsa/8rT4o51w==
X-Received: by 2002:a63:ed41:: with SMTP id m1mr41110757pgk.252.1621242570661;
        Mon, 17 May 2021 02:09:30 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id l10sm9307448pfc.125.2021.05.17.02.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:30 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/17] mac80211_hwsim: Remove unused used length
Date:   Mon, 17 May 2021 17:08:27 +0800
Message-Id: <20210517090836.533-9-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The used length is not used in some cases. Let's drop it
and pass NULL to virtqueue_get_buf() instead.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index fa7d4c20dc13..56d1484e7efa 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -4210,12 +4210,11 @@ static void hwsim_exit_netlink(void)
 #if IS_REACHABLE(CONFIG_VIRTIO)
 static void hwsim_virtio_tx_done(struct virtqueue *vq)
 {
-	unsigned int len;
 	struct sk_buff *skb;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hwsim_virtio_lock, flags);
-	while ((skb = virtqueue_get_buf(vq, &len)))
+	while ((skb = virtqueue_get_buf(vq, NULL)))
 		nlmsg_free(skb);
 	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
 }
-- 
2.11.0

