Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1193CBC43
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhGPTUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbhGPTUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626463064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dh9TP4UQfqmrs3ZL1M5afaofaGCDHoww5GnNH6A6qVI=;
        b=S7VM/nQjv/hCDPZxt4of3F1wpXB7gATK8c7kqz9rDhFQ8wvCYvIXt1lGdfpCaEpV8H5iO/
        MYQA3NWr6+rxqxcH2uDbT66Vq3kU3x4nquSnv9JckORDe+mi3zv5YlLjJDLmWwmi2NwtGL
        zhurJ4BVGryIrk/DSq+E+07y0DmywLg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-yUSWT_qSNLisp70lH00OcQ-1; Fri, 16 Jul 2021 15:17:41 -0400
X-MC-Unique: yUSWT_qSNLisp70lH00OcQ-1
Received: by mail-qt1-f199.google.com with SMTP id g4-20020ac80ac40000b029024ead0ebb62so6936576qti.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 12:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dh9TP4UQfqmrs3ZL1M5afaofaGCDHoww5GnNH6A6qVI=;
        b=Mtxc4xs+hZXSXgf1qaV5goTqQUUG0s3iFVqilsyzP5jYoPh9OWFzJukqtIfB4L49qW
         ydBxRN11hnuL3SYOTmt0yODwbMl1gZT+KYcqSc2s2hYiIPiaOBeFYV9tFOHUugsWXSua
         HpCO08WOzNZmy+rcySz0ZHTESEIPRnIkcHS9BfKxptPsVRZXxQbP+F8ph1fTu+nA1K9m
         OZMdBz0u63kggwHnUM/SpkcmXdjJdzSxeHWmpcEHZVuZOOsam+jxdHyvPCfirmCYPeFe
         MvCfb9vjipuCa3C1gy2fr4YfzPaQNdbOMLeBVWMgE692rbfE+Qh1jfPQYnWzwfZwhEda
         HTOQ==
X-Gm-Message-State: AOAM533YF2oRCR+I3xIa6BbOU/OYuC0m2joMRtKGl0+pC227Z5Sff3oJ
        bB4peMDzrzMxs12RGYs5ayQj+JyYrPBpckoo9CPpl45BO1RSjair1G8jIUKmwmAVikPj00VSed0
        L71WY/69aVvKh9sLCsL8zswR7
X-Received: by 2002:a05:620a:38f:: with SMTP id q15mr11493404qkm.116.1626463060841;
        Fri, 16 Jul 2021 12:17:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxojxgjssz6s5hi5XBH2Se8WN32bm3yv16fSMX286naPzmFZ35jHl0F2qL6jCa2aHw6/EBhXA==
X-Received: by 2002:a05:620a:38f:: with SMTP id q15mr11493386qkm.116.1626463060658;
        Fri, 16 Jul 2021 12:17:40 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i123sm2659785qkf.60.2021.07.16.12.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:17:40 -0700 (PDT)
From:   trix@redhat.com
To:     bparrot@ti.com, mchehab@kernel.org,
        tomi.valkeinen@ideasonboard.com, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: ti-vpe: cal: fix indexing of cal->ctx[] in cal_probe()
Date:   Fri, 16 Jul 2021 12:17:33 -0700
Message-Id: <20210716191733.2976039-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

cal->ctx[i] is allocated with this loop
	for (i = 0; i < cal->data->num_csi2_phy; ++i) {
and accessed in the error handler and else where with this loop
	for (i = 0; i < cal->num_contexts; i++)
Because the first loop contains a continue statement
before cal->num_contexts is incremented, using i as the
indexer will leave gaps in the cal->ctx[].

So use cal->num_contexts as the indexer.

Fixes: 75e7e58bfac1 ("media: ti-vpe: cal: support 8 DMA contexts")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/platform/ti-vpe/cal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti-vpe/cal.c
index 05bdc6d126d82..8e469d518a742 100644
--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -1148,9 +1148,9 @@ static int cal_probe(struct platform_device *pdev)
 		if (!cal->phy[i]->source_node)
 			continue;
 
-		cal->ctx[i] = cal_ctx_create(cal, i);
-		if (!cal->ctx[i]) {
-			cal_err(cal, "Failed to create context %u\n", i);
+		cal->ctx[cal->num_contexts] = cal_ctx_create(cal, i);
+		if (!cal->ctx[cal->num_contexts]) {
+			cal_err(cal, "Failed to create context %u\n", cal->num_contexts);
 			ret = -ENODEV;
 			goto error_context;
 		}
-- 
2.26.3

