Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8330EE3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhBDITK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbhBDITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:19:08 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E9C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 00:18:28 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o21so174710pgn.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8SDePCP2k7/D0/1LaEKZCiCgjAw7SpIfFnhKEoussk=;
        b=TW/Cyk6NllRtHj0dqazdLipT6kZ6QCQlJtfJWUyRgrZNQDVeev/kIxKaKjA86NnPLd
         JRINzKJv7CY6UzvAp6aLmFXxpZ5jrsFUC2+KJt9ggZhBnY4PHmR5h4SsBx5ndifcOyra
         XKy9b4Ay6NYN4PfbM9EuvrOAJa0jBhy3MK5UAELeE8p0++HuzNwpZ/cnX90zdNaNBOcx
         SJ8aXklCyD9ecW8TXBwfpFFIsKokM9wJthkRMuMFDO8QcQypj3cs4WjAOZ7edZO93L3V
         y0OoGMYoGgZKZnwy2QebBTzlCRQTkA5McjXC3mk1hRUBUfasUpYGnWPWzkHziyaDR0o5
         TBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8SDePCP2k7/D0/1LaEKZCiCgjAw7SpIfFnhKEoussk=;
        b=Vpa93DlXjJTFHUhcDuQ1BxQw3Ex/1WvukVi3FK9DAJxAgHoUtkeB3QZwXB620R7Cjz
         Jt7Zfphql0aqxRpGD9OjR38JcSlCONdDurn/68E9oAj6g+eyD5PBxfTZkHdWu1QUBSrZ
         QU/+E/FWBSFEVHJ9vvn+Cw5MAUldArINb1Dho5kZPgqeQFEjOTjuQ4TV/ZYTZwNylDNn
         g975/zzHja9idE5IcQtEorPkvID3yVuemkUs6llDstSBT3GBPAa055+ESNKTDeUeWkAr
         xBd8O2TtlQpn9QyisgKfhEPL2I+aNof+oJgnCG9p8MlPKtl1uk1moCSWWTqWXut5VJli
         im8Q==
X-Gm-Message-State: AOAM531zsdlvjo+uPfpWcqCC6Kj9qCPoZgVAyXtK6iiFnyZKN9uzchuU
        hCUx3Yi8s/WW3WErPb/pk0k=
X-Google-Smtp-Source: ABdhPJwJ1UsDG2L/tVwGCqWrE7+GwAgfBMnWzVjl17x4e+DA3u2XvIPVoDwPRqvndoD2DZ5jlfc6rA==
X-Received: by 2002:a63:570c:: with SMTP id l12mr8006448pgb.194.1612426707809;
        Thu, 04 Feb 2021 00:18:27 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 194sm2800304pfu.165.2021.02.04.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 00:18:26 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Magnum Shan <magnum.shan@unisoc.com>,
        Haidong Yao <haidong.yao@unisoc.com>
Subject: [PATCH] mailbox: sprd: correct definition of SPRD_OUTBOX_FIFO_FULL
Date:   Thu,  4 Feb 2021 16:18:19 +0800
Message-Id: <20210204081819.892660-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnum Shan <magnum.shan@unisoc.com>

According to the specification, bit[2] represents SPRD_OUTBOX_FIFO_FULL,
not bit[0], so correct it.

Fixes: ca27fc26cd22 ("mailbox: sprd: Add Spreadtrum mailbox driver")
Signed-off-by: Magnum Shan <magnum.shan@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/mailbox/sprd-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/sprd-mailbox.c b/drivers/mailbox/sprd-mailbox.c
index f6fab24ae8a9..4c325301a2fe 100644
--- a/drivers/mailbox/sprd-mailbox.c
+++ b/drivers/mailbox/sprd-mailbox.c
@@ -35,7 +35,7 @@
 #define SPRD_MBOX_IRQ_CLR			BIT(0)
 
 /* Bit and mask definiation for outbox's SPRD_MBOX_FIFO_STS register */
-#define SPRD_OUTBOX_FIFO_FULL			BIT(0)
+#define SPRD_OUTBOX_FIFO_FULL			BIT(2)
 #define SPRD_OUTBOX_FIFO_WR_SHIFT		16
 #define SPRD_OUTBOX_FIFO_RD_SHIFT		24
 #define SPRD_OUTBOX_FIFO_POS_MASK		GENMASK(7, 0)
-- 
2.25.1

