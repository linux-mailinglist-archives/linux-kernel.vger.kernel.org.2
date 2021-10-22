Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFBF4374DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhJVJkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhJVJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:40:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392D7C061348
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e12so3008638wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4Vf8zU6lM4dAIRlmzW2kKVym7mK5P5jeMxIM0GYiAU=;
        b=aswhWG6qqkOneHofy3tcYGkagM26dASqaxYw2EqCbTG/dqnk6On9oKM9gLXpK2SeBT
         4Xci9k1Nxv+P9Nuu2+Nn1y7kfCrSOabeukPNDc1IrrIRtENls8EI0ioqWzKUjDp8Q8pt
         wKJlGnHXXEMg4qPWcvcthF8h0et+hWbf4UzJTuvbX3sMBnWnuZjsUwtvmn+D7io9AvRL
         HzI2n7kg78TzvuRfQLaZX/FoS1XZX76qT9CSjJ4aksOctrqhmrrXtVsLGs671mweyN9t
         fz3ZtmW07muWBKeSiXkg+wTBQLY1NrAY/fZt3Xi/N6V+yKf5EsSLmOVUxfSTdenIUH/n
         lzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4Vf8zU6lM4dAIRlmzW2kKVym7mK5P5jeMxIM0GYiAU=;
        b=F+pMM0vMui7hpuWoSIEvkUHgKmZalyroVhTGSyzZocyU8b4mV5EY/S4DKJ3f/vxxYK
         /i9N8oP2w7jwrAWDnnphrk+Yv9uNB1RlwzGEsgoEE5GWX/yJ0WPBa9Rjv+tLFyIlzW3g
         SaX53KWWpcb9XfK0EEJlOTDxmazPNvpx5xui9qhf2AQ6yAbLm9BOiNyGxRrP3A3PWQZi
         H8rpTIj8zSgO1TIyT9HpQPNyleuzLhnfnfszf121isSXkT4tbUipyIe04ehVcNV3IE72
         Ux4la5XfN1iubd2N2rNnCOneNHlBSHtQm9NptQL3RelibxeXq2PDUQUsCAzQ85TV431D
         QZOg==
X-Gm-Message-State: AOAM5322a96VspjoTIS1ug6GX7nZdsTU+5SaeahMGHwDzLAeCFaW57X3
        0xV3++UXjEDS0ktSo8zOUUk=
X-Google-Smtp-Source: ABdhPJzU79r4omGoWAzUWWlL+gdBhidW1dkzSfbXngnlxoM7Lef+MNdS7vhvB9d4LxZglfh26QP4kw==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr14712574wrd.63.1634895471865;
        Fri, 22 Oct 2021 02:37:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id r15sm1643602wru.9.2021.10.22.02.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:37:51 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 3/5] staging: vt6655: Rename `bySleepCount` variable
Date:   Fri, 22 Oct 2021 10:37:16 +0100
Message-Id: <70ee3b7d9797d546bab311840da5f8709397ce08.1634826774.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1634826774.git.karolinadrobnik@gmail.com>
References: <cover.1634826774.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop Hungarian notation in `bySleepCount` variable in
`RFvWriteWakeProgSyn` function. Change it to use snake case.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <bySleepCount>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 36708af7d612..a30ffacf720a 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -682,7 +682,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 	void __iomem *iobase = priv->port_offset;
 	int i;
 	unsigned char init_count = 0;
-	unsigned char bySleepCount = 0;
+	unsigned char sleep_count = 0;
 
 	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
 	switch (byRFType) {
@@ -694,8 +694,8 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 
 		 /* Init Reg + Channel Reg (2) */
 		init_count = CB_AL2230_INIT_SEQ + 2;
-		bySleepCount = 0;
-		if (init_count > (MISCFIFO_SYNDATASIZE - bySleepCount))
+		sleep_count = 0;
+		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
 			return false;
 
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
@@ -710,8 +710,8 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 	case RF_AIROHA7230:
 		 /* Init Reg + Channel Reg (3) */
 		init_count = CB_AL7230_INIT_SEQ + 3;
-		bySleepCount = 0;
-		if (init_count > (MISCFIFO_SYNDATASIZE - bySleepCount))
+		sleep_count = 0;
+		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
 			return false;
 
 		if (uChannel <= CB_MAX_CHANNEL_24G) {
@@ -736,7 +736,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 		return false;
 	}
 
-	MACvSetMISCFifo(priv, MISCFIFO_SYNINFO_IDX, (unsigned long)MAKEWORD(bySleepCount, init_count));
+	MACvSetMISCFifo(priv, MISCFIFO_SYNINFO_IDX, (unsigned long)MAKEWORD(sleep_count, init_count));
 
 	return true;
 }
-- 
2.30.2

