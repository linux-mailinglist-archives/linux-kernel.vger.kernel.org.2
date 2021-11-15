Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0693E4502F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhKOLBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhKOK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:59:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDAAC061207
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r8so29707188wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3m1ZcrPeitMRiq9GZNf+n5I5iliMi+d5wYw/rsR5qI=;
        b=dQ/HBlrMCGEUoTFBJc5ipCvUXuGcDMmzQSKMxSEFphc2QHj/uftOln0BBnusCMUFOc
         nYwgPPQXKsVm0gSDooWD8KCYHmbqDlIxYlnSLv1k2avlPGczvBbncksbaE/vx2rt+UOO
         Ed6Ra+YET9weQHyFeGhzBhC88Se4caYeg0SUWCi29Mp58Z2nhhGwvxYXGBRiZ4+xzhKJ
         63pndRCb/+sTIxnRSD+0ieDbHg9izG4qXnYnf3nh79DqCTlczz6Jycf2Cpn2emG05hsg
         uWkx9AE0R8jhbJdhsY2vd8+lSGormrzuFpIeQk8et7wTof9eOIwrMp0XtLlZD0IpBUI+
         uxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3m1ZcrPeitMRiq9GZNf+n5I5iliMi+d5wYw/rsR5qI=;
        b=QJu3Cb4BmGK5QiBdCFF3s21qYBeQu0+CSlkbZmqyxna1VEeZYRR4FwYifvhPuqotqK
         4RFPwsKgp/SOuqYOVAPFb/w4tTuTM2E9GmoVBihiOlB2RiWWYdcyR6oAqkLyL1esMJaZ
         2+yp6jgFUlMDAMuqHnRECJ2aP6Gt0Q/S9zRLv3ROsf8gun95LysD/e5Rrnb8I2AelV6N
         HC8CEORiCrH6UjlpONU0HJeBRnr8RWAT2sv3QQBZzVzud47ixSkmAqWoph0FFJU59aEu
         7p9pEZ45VEyatlBJYMppGxLWi17fWBbxu0rDXl1kcbt6+gApsQ7YojJLafTar96YxzVV
         XU/g==
X-Gm-Message-State: AOAM531g3rIDdBumIsCR71S0OuGaOIiZ1/SXE6d5VbOLUUcU4CZW2Vi+
        JHCaD66CLVeUAqaVcPtJxig=
X-Google-Smtp-Source: ABdhPJz8NnSLF+xJKqQBvvaos6lPoNm0OFYF5SqL4alMh2ge+cNsO16slF4Vcan/pXpHE2MHlWnkvA==
X-Received: by 2002:a05:6000:1564:: with SMTP id 4mr46513965wrz.9.1636973783540;
        Mon, 15 Nov 2021 02:56:23 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id d1sm13516532wrz.92.2021.11.15.02.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:56:23 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v3 4/8] staging: vt6655: Rewrite conditional in AL7320 initialization
Date:   Mon, 15 Nov 2021 10:55:45 +0000
Message-Id: <28169210bc26d5fcc1080ed18dc8e043bc3ef30b.1636729147.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1636729147.git.karolinadrobnik@gmail.com>
References: <cover.1636729147.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use conditional operator to determine which table for AL7320
initialization should be used. Introduce `init_table` variable
to store this value.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index ce91a03eb58f..5246ba211ffb 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -684,6 +684,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 	unsigned char init_count = 0;
 	unsigned char sleep_count = 0;
 	unsigned short idx = MISCFIFO_SYNDATA_IDX;
+	const unsigned long *init_table;
 
 	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
 	switch (rf_type) {
@@ -714,13 +715,10 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 		if (init_count > (MISCFIFO_SYNDATASIZE - sleep_count))
 			return false;
 
-		if (channel <= CB_MAX_CHANNEL_24G) {
-			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, idx++, al7230_init_table[i]);
-		} else {
-			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
-				MACvSetMISCFifo(priv, idx++, al7230_init_table_a_mode[i]);
-		}
+		init_table = (channel <= CB_MAX_CHANNEL_24G) ?
+			al7230_init_table : al7230_init_table_a_mode;
+		for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
+			MACvSetMISCFifo(priv, idx++, init_table[i]);
 
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table0[channel - 1]);
 		MACvSetMISCFifo(priv, idx++, al7230_channel_table1[channel - 1]);
-- 
2.30.2

