Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA143DF04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhJ1Kib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhJ1Ki0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:38:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2149C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:35:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so535150wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ccxJHQnZxwCRL5ALIeLwb3BTgkZUnkc6gC/ao5xjt48=;
        b=gV7VI4mX3pwtcf/Alsr8MQkZKI8NXZeWkwWgiHPJklFk1is8HdzPxEN5JWEgGffT72
         904acUeHt5rUn9cTaf1eq6++7wGJ+0HcKg6pDDUm6Z3ViTxlfokPTn+hz3CUIpB5VfcY
         GCqbTi473jBvB3CuhzlEG//TlQt7YN6DXD1y2myGUX8ZH6yG9ueCCqzc4uxcj2IDTpsP
         pxIf7I6lg1CxZM7uscQbd6SGaeW6c2g4FOYbfA5tLz1VC6Xc+v3BfFuEOXhWIkZF4iNB
         neVXtnWEPHYm7FC/mi/VrPyu+dPK35V2GpgPGlLdjrapXeMGhXV74UG+7/u0nBx6v+K7
         4bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccxJHQnZxwCRL5ALIeLwb3BTgkZUnkc6gC/ao5xjt48=;
        b=1lATO+A7qgGssPpBCkzBCSikDCVnu3oObF3Bj159fL7aXKcEEHzzVPdYSG4mwAkmI8
         1NVas6dyH6PfAlzBqC4GmLE9a6gGfnLcZc45yTp6s0Nw3KNeF96wLh8ubbhLZI4e8BW+
         g9qMvfT4kwm6rrQNP0HdiPpF/Ir4EAzfR5U5ZbVcrh/tiUigpRNejSfkeBxdpY2rTBsD
         0X+a4kkjGN5lPe1u2zYnthe2LvGjGUjZB/Htz8VlKKnKCfJP28VEYyWs/67ltVmAaPcd
         zVz8EtZKbMP20GDtuqhwnguJzMfLUl0I/25y7hXriUprKYKZcBD2pFIFv2m6X4vuhfLE
         a8nA==
X-Gm-Message-State: AOAM530wabSQNYr7vkOJyUJS5Pz9HgpNBfw2yJaqYf3FNadQHD2ZSSmF
        tUBtnLLjc4tvdfLj6TZsGjc=
X-Google-Smtp-Source: ABdhPJx44nRJDXX//9FTvonuvJfg3H56W1xivwDLJQMgsetriJw6XNHTXTolN6qEk63mFajNcAZCvw==
X-Received: by 2002:a1c:3bd5:: with SMTP id i204mr3569575wma.46.1635417358324;
        Thu, 28 Oct 2021 03:35:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id 13sm3768083wrz.38.2021.10.28.03.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:35:57 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 3/7] staging: vt6655: Remove unused `i` increments
Date:   Thu, 28 Oct 2021 11:35:33 +0100
Message-Id: <79a4f03c8f2bfa555ea149ddd1c0f938dd431a0b.1635415820.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1635415820.git.karolinadrobnik@gmail.com>
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c569952d92ba ("staging: vt6655: Use incrementation in `idx`")
rendered the incrementation of `i` outside of the loop unnecessary
so it can be deleted.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index c07653566d17..ea74701917e5 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -703,7 +703,6 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);
 
 		MACvSetMISCFifo(priv, idx++, al2230_channel_table0[channel - 1]);
-		i++;
 		MACvSetMISCFifo(priv, idx++, al2230_channel_table1[channel - 1]);
 		break;
 
@@ -724,9 +723,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 		}
 
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table0[channel - 1]);
-		i++;
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table1[channel - 1]);
-		i++;
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table2[channel - 1]);
 		break;
 
-- 
2.30.2

