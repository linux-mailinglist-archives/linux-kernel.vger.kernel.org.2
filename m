Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9A2305A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhA0LtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbhA0L2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:28:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989FC06178A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u14so1220199wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqKIorWT4gXh/otNkPIF0uCkC/OA7zuZgaSdIUKa4VQ=;
        b=aENfasNI0ky/TTcKZj0RBlkmPCXTD05TgexoPZIddRhq2koMze0DuPLrwkMae41+Hp
         c4o6F6D3wsQBlrVlCmZ7aUQdCCtmmo1Zy/78VoBb3SeSGekBmMxa85XjSaL4+Z5W0ASW
         frcfDqvGEiRbLqe7mqxqfEYadOGB40lkBdpuV0z/FjpwvW2yJL5Pwh2NNPym0lQPP6q7
         pVSQBXlr8NMYn89mIrrXheymk2bzoxqMB3pRsyc2GhVhJsPvPEnrPk6YOe4MBLgROBt8
         xFOHtLnV/n+gPs2Qyi3kw1aR/PrbGWVqpF4DWAU84kXuY0JrWyd6GPdZQd3BqmzT/enI
         8/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqKIorWT4gXh/otNkPIF0uCkC/OA7zuZgaSdIUKa4VQ=;
        b=aKYJ3CEswaW9SC2dnOedL8zYltxMMDiXC1ud4M9M5WTcRfrReyfibj7eYIbKn3L8pr
         5hxkqALZ0NUA1JwDcTMcVy+t2Gf+Y45b/RYzlY5X7T6EHvkdNiKtVn7jxNT+ABpUrLRZ
         zOIzq7v19EWTENjmQScF3Q1uB3mckopRmnxXvI2IFEkqkn9xnhI77MSdGEgkNHlo4Hpr
         mps7fNVehc2OVRNFvmw4bu0dtjAQRg1FgfkP1VQqpJXel3xdApQN+fAOlly+/DGrupjW
         r3LG1MRu1KYqAgQaA9t3NdSYST5B+5LF9yTKdwzu2LwzJjHY5xeHaDGz9Re6ax6opSpT
         G4FA==
X-Gm-Message-State: AOAM533YSGCNTN/QaU4FfcR0VCYA2jrao2ZRn4/T/dLjRau+s6NbxdF4
        Hffoyh70VPKSeRJztVm8s3DKXX88xTGh3OD/
X-Google-Smtp-Source: ABdhPJzD79rhcX17fcmbNib/cgUuSVbYrVZ1wACd3viDqTyTSWbDLxZfJHt8w81Z9WiY7cPeOnh/jg==
X-Received: by 2002:a1c:4483:: with SMTP id r125mr3710279wma.80.1611746760177;
        Wed, 27 Jan 2021 03:26:00 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id m2sm2040065wml.34.2021.01.27.03.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 03:25:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 01/12] thunderbolt: dma_port: Remove unused variable 'ret'
Date:   Wed, 27 Jan 2021 11:25:43 +0000
Message-Id: <20210127112554.3770172-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127112554.3770172-1-lee.jones@linaro.org>
References: <20210127112554.3770172-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/thunderbolt/dma_port.c: In function ‘dma_port_flash_write_block’:
 drivers/thunderbolt/dma_port.c:331:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/thunderbolt/dma_port.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/dma_port.c b/drivers/thunderbolt/dma_port.c
index 847dd07a7b172..5aced91e17dc4 100644
--- a/drivers/thunderbolt/dma_port.c
+++ b/drivers/thunderbolt/dma_port.c
@@ -328,13 +328,12 @@ static int dma_port_flash_write_block(struct tb_dma_port *dma, u32 address,
 {
 	struct tb_switch *sw = dma->sw;
 	u32 in, dwaddress, dwords;
-	int ret;
 
 	dwords = size / 4;
 
 	/* Write the block to MAIL_DATA registers */
-	ret = dma_port_write(sw->tb->ctl, buf, tb_route(sw), dma->port,
-			    dma->base + MAIL_DATA, dwords, DMA_PORT_TIMEOUT);
+	dma_port_write(sw->tb->ctl, buf, tb_route(sw), dma->port,
+		       dma->base + MAIL_DATA, dwords, DMA_PORT_TIMEOUT);
 
 	in = MAIL_IN_CMD_FLASH_WRITE << MAIL_IN_CMD_SHIFT;
 
-- 
2.25.1

