Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675F7316626
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhBJMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhBJMIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:08:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5924C0617AB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:04:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v15so2209161wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJ/fTja9mKD4KGroCmj04WxehP7kOKRd+7I/05Mbq4M=;
        b=eJNnrdbROY/AGjV55wNNaknvjSt8hJpicfMFtrcXgdTyFJmqpIaHusDBb6lLW31/CZ
         ZmxfvmYvy/ApYALBZnb4vj4x2QRgYoJXpl/v/cBecrscBqCs3RkqaM06Bqfvap61XIvk
         T8Ce8CL68S4E71Oi6EpucQ/oNuWHaeNJHzf7yzo+aZUOzIS2oYIujpS3u9TWHRKX3wtV
         ilh5fn9C40JBv1O7sklmbN5iRBTrvdoHAK5qSGvYuvr/avyhTXQ45hQevJXK5cJ8dEXi
         y3uweFvSazUr3ynpR6vPjAgNqpx+Un2eNco96FBxNTKmAMq1Xv6u7FkmDgsAt7ToOSPl
         8OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rJ/fTja9mKD4KGroCmj04WxehP7kOKRd+7I/05Mbq4M=;
        b=sG+N/4hCb6a+POBDEawa0IKGhwWGeHRGASWs8HY28bIyW5xFyP5PF/NZ9Am99sDLeJ
         TpKBnVUR0EDoJnV7FInkZzQRuHeC+sZqKls1F9x7BiawNyWAKLTJPWOtwT1CV+dlZu4r
         7r2N5BtY3e0IqqJfvRNSwcSp0Wt0n1v/cFo4KWggdGImxaesEH5zSx/xziUhJt2L0lzX
         7rVOMtj4E69w4noZNuRUk+Vx6XFjYGO8bg5Ojjkyfb/AjWwuilZW75LlMTeN7sE+3SvW
         fyOjaoJHn3/nZ4JM4oZ2psTK2g8Bs7JmLmOBLQDtEtj4l0oczWZUw+dwd4a/UrkSsHDg
         ykgQ==
X-Gm-Message-State: AOAM533i/oNUlQ3nhZa4o35aFfE6V/HDhWl2odSPHkRBsNl/yumamzO7
        oioZhkpqaup2wfDmIR8Y1X3AIxqrf6umeXy8
X-Google-Smtp-Source: ABdhPJwIkpRJMNidPY7E8t77YNkSjglI/0+vLjMQRtxMoAor2nPGNhM0AYpSxXSb6En7s3W2Jn8oGA==
X-Received: by 2002:adf:97d3:: with SMTP id t19mr2308218wrb.164.1612958657043;
        Wed, 10 Feb 2021 04:04:17 -0800 (PST)
Received: from xps.yggdrail ([2409:4072:301:1438:3689:6d67:ef18:b9a7])
        by smtp.gmail.com with ESMTPSA id f7sm2822529wre.78.2021.02.10.04.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:04:16 -0800 (PST)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ralink-gdma: Fix checkpatch.pl CHECK
Date:   Wed, 10 Feb 2021 17:33:48 +0530
Message-Id: <20210210120348.262328-1-aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CHECK: Lines should not end with a '('

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---

 drivers/staging/ralink-gdma/ralink-gdma.c | 28 ++++++++++++-----------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 655df317d0ee..a11f915f3308 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -135,8 +135,7 @@ struct gdma_data {
 	int (*start_transfer)(struct gdma_dmaengine_chan *chan);
 };

-static struct gdma_dma_dev *gdma_dma_chan_get_dev(
-	struct gdma_dmaengine_chan *chan)
+static struct gdma_dma_dev *gdma_dma_chan_get_dev(struct gdma_dmaengine_chan *chan)
 {
 	return container_of(chan->vchan.chan.device, struct gdma_dma_dev,
 		ddev);
@@ -510,10 +509,11 @@ static void gdma_dma_issue_pending(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 }

-static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg(
-		struct dma_chan *c, struct scatterlist *sgl,
-		unsigned int sg_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
+static struct dma_async_tx_descriptor
+	*gdma_dma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
+				unsigned int sg_len,
+				enum dma_transfer_direction direction,
+				unsigned long flags, void *context)
 {
 	struct gdma_dmaengine_chan *chan = to_gdma_dma_chan(c);
 	struct gdma_dma_desc *desc;
@@ -558,9 +558,10 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg(
 	return NULL;
 }

-static struct dma_async_tx_descriptor *gdma_dma_prep_dma_memcpy(
-		struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
-		size_t len, unsigned long flags)
+static struct dma_async_tx_descriptor
+	*gdma_dma_prep_dma_memcpy(struct dma_chan *c,
+				  dma_addr_t dest, dma_addr_t src,
+				  size_t len, unsigned long flags)
 {
 	struct gdma_dmaengine_chan *chan = to_gdma_dma_chan(c);
 	struct gdma_dma_desc *desc;
@@ -601,10 +602,11 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_dma_memcpy(
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }

-static struct dma_async_tx_descriptor *gdma_dma_prep_dma_cyclic(
-	struct dma_chan *c, dma_addr_t buf_addr, size_t buf_len,
-	size_t period_len, enum dma_transfer_direction direction,
-	unsigned long flags)
+static struct dma_async_tx_descriptor
+	*gdma_dma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
+				  size_t buf_len, size_t period_len,
+				  enum dma_transfer_direction direction,
+				  unsigned long flags)
 {
 	struct gdma_dmaengine_chan *chan = to_gdma_dma_chan(c);
 	struct gdma_dma_desc *desc;
--
2.30.0

