Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246243827DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhEQJLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbhEQJKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3BFC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q6so3313014pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAxFTtOHd8hl2SI+h7EbDRZvq5HefD54cpPSZjznt/I=;
        b=lzzYGBCEKLDtZEaOUbfqvKXJGDntimcbL8L9haKh2EfPqOznTu9caIMyelSfqTnk7z
         KAUuaqpCbrX1I/1g4vK/p/a7iVNh9KKCrr0UvSVr6Oe4IxHue2ItcrIZ21ftzRRikhcW
         An0c/WKD39kyFUZw+1BE2RhK5lA2DkkP2CK9/Y5zFUZMKzYfeLunlFALJ8gZd/OxrfSg
         zVogEJBWbp2uOY2m9rlRwFx2gbhWQsiG0rBZzBZ1ghGY4UdFsQJAm//I/EUBGIgVU/S8
         JvKzUKF06bIMGjWRA3JubQMyHN97h6wrOdwpyUS1ta7MvcEt1OJ3y0s8hEaAi06t/tmw
         xEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAxFTtOHd8hl2SI+h7EbDRZvq5HefD54cpPSZjznt/I=;
        b=pvs9YLhWmH2Bbc4PkBslNEMEP6+nOHZdrZJ7L1COR7UGJTB7Mf/2UT0yfnL3wNq4xy
         ALYO6CT+l65+kyCfoRBfxbQ2aeDyUd1lOTnuNA01h0v1sz/xM3sSnth20r7ADm4KV6rH
         z4RPlCiK2Ia3IUX0CrKiZlKr0mILGSG+qC+ruJbbPF5B6ujittLTMPLHKyeOBZD1DodP
         ZRDvAjaWYrP6kJ/iiA8nlK2JM5Vfz86shkEm1wm6wz1IayHGT+UuDY6lc20lGFCdG73M
         kV6FTtAoGmpbMYij0drwv3Wff5l0tr3jxsGRixnH18Geuf2VsRmD8IVCIi7BLoe40VnV
         ASKA==
X-Gm-Message-State: AOAM531p8I+pvMHp16Q6d8+d0At6GxfYqTkhKaXxL7RwlyzdUNFrtyFD
        TaypabEGfukaToh+lGui60wc
X-Google-Smtp-Source: ABdhPJyvx+FiuQ4n2zgPDT6AHSjoYbPZYAf2oepl/gWx1e8Fr84Kuxf19eiEpMphivMTbwKatFxjIg==
X-Received: by 2002:a17:90a:3948:: with SMTP id n8mr68511142pjf.32.1621242563462;
        Mon, 17 May 2021 02:09:23 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id g6sm9462843pfr.213.2021.05.17.02.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:23 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/17] caif_virtio: Remove unused used length
Date:   Mon, 17 May 2021 17:08:25 +0800
Message-Id: <20210517090836.533-7-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The used length is not used. Let's drop it and
pass NULL to virtqueue_get_buf() instead.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/net/caif/caif_virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 106f089eb2a8..020ce35c2d65 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -165,12 +165,11 @@ static void cfv_release_used_buf(struct virtqueue *vq_tx)
 	BUG_ON(vq_tx != cfv->vq_tx);
 
 	for (;;) {
-		unsigned int len;
 		struct buf_info *buf_info;
 
 		/* Get used buffer from used ring to recycle used descriptors */
 		spin_lock_irqsave(&cfv->tx_lock, flags);
-		buf_info = virtqueue_get_buf(vq_tx, &len);
+		buf_info = virtqueue_get_buf(vq_tx, NULL);
 		spin_unlock_irqrestore(&cfv->tx_lock, flags);
 
 		/* Stop looping if there are no more buffers to free */
-- 
2.11.0

