Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CD04374DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhJVJkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhJVJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:40:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF221C061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d13so3770674wrf.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHPc3N37Jxt/ha1mRXWgFzhusdcNwFGBiIe67sBVlN8=;
        b=FeEQdVMlkj1f+mgd3LmPprz60U9As8acN3sZRT3ZCY9dzNTv7zL2uA/Youp08xl6T0
         3cYHQADkjWAlH9buYpdGfr7TKnkKG0yACywB4EzXaJ163xKF1+9pcpz3JDSGv0LphDCy
         V/uyrTXNk1VXVHIfY+f+HKtlepT34gJrVnSjIGs7u1bkKv5ikuJgewS9oA0pJKmBZTLY
         7EQpGxatqZcOBkB8SZJiRzfw3VufwAlX7tyEmVyyZJuOFDBnyoRSQYf8Q0KDMEuMheLc
         4/xdWK3Xc7Cg0HeB4txEiguNcZEzzQns5w6d54htqWUCJrol5AzIfElHqoDljVIqkcG3
         GaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHPc3N37Jxt/ha1mRXWgFzhusdcNwFGBiIe67sBVlN8=;
        b=jKqvFAXDI/gqfvq6Td5GjsZcQGLeu01i4eTB7kx9d/StnJbWFB3PN63/j0A2vgGJjE
         BohuVUtuuqbCP13OEsSiV+WO1SNi8Z5sUE85iTPBad1+XTTPatw0nfFHDZQtrdv7M76N
         SBTJMQu/6yyhXAhRzfXPTGUJ46KYycF7Y2NA7mn9ZjkC3i8Zr420qJi+XwYcIXirrTgW
         yKQDFtVUHrhLmjtUX7Z1DWniKIy42wUxLYabjp0TjSL880nlchmOZItntwtolIJKex+c
         BBSgzmwSlM3EsOSK5ReOeFZGoDu/H/8SQTrCVN7bjuFB9/gY3zz3FWIUXJnPm/4FQHWk
         iAsA==
X-Gm-Message-State: AOAM532HOQh7Tz7QJWLkYr0MaZHJPDg9wJKqENlXMV7SxOMtzHDUiUbH
        3IKvSxUZx+N8MeIJujpSwfc=
X-Google-Smtp-Source: ABdhPJxwCFCJhAGeGCVzv9iMhmbwegiDgaFJCdCYMM3Y/IodHpS1+RkyE/fyFHqPfw2YL1TmTue3QA==
X-Received: by 2002:adf:d218:: with SMTP id j24mr14679201wrh.50.1634895469456;
        Fri, 22 Oct 2021 02:37:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id r15sm1643602wru.9.2021.10.22.02.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:37:48 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 2/5] staging: vt6655: Rename `byInitCount` variable
Date:   Fri, 22 Oct 2021 10:37:15 +0100
Message-Id: <53430b1183324f6a715999792a15df2ea6a3e206.1634826774.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1634826774.git.karolinadrobnik@gmail.com>
References: <cover.1634826774.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop Hungarian notation in `byInitCount` variable in
`RFvWriteWakeProgSyn` function. Change it to use snake case.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <byInitCount>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 7e441309dd9c..36708af7d612 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -681,7 +681,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 {
 	void __iomem *iobase = priv->port_offset;
 	int i;
-	unsigned char byInitCount = 0;
+	unsigned char init_count = 0;
 	unsigned char bySleepCount = 0;
 
 	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
@@ -693,9 +693,9 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 			return false;
 
 		 /* Init Reg + Channel Reg (2) */
-		byInitCount = CB_AL2230_INIT_SEQ + 2;
+		init_count = CB_AL2230_INIT_SEQ + 2;
 		bySleepCount = 0;
-		if (byInitCount > (MISCFIFO_SYNDATASIZE - bySleepCount))
+		if (init_count > (MISCFIFO_SYNDATASIZE - bySleepCount))
 			return false;
 
 		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
@@ -709,9 +709,9 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 		/* Need to check, PLLON need to be low for channel setting */
 	case RF_AIROHA7230:
 		 /* Init Reg + Channel Reg (3) */
-		byInitCount = CB_AL7230_INIT_SEQ + 3;
+		init_count = CB_AL7230_INIT_SEQ + 3;
 		bySleepCount = 0;
-		if (byInitCount > (MISCFIFO_SYNDATASIZE - bySleepCount))
+		if (init_count > (MISCFIFO_SYNDATASIZE - bySleepCount))
 			return false;
 
 		if (uChannel <= CB_MAX_CHANNEL_24G) {
@@ -736,7 +736,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 		return false;
 	}
 
-	MACvSetMISCFifo(priv, MISCFIFO_SYNINFO_IDX, (unsigned long)MAKEWORD(bySleepCount, byInitCount));
+	MACvSetMISCFifo(priv, MISCFIFO_SYNINFO_IDX, (unsigned long)MAKEWORD(bySleepCount, init_count));
 
 	return true;
 }
-- 
2.30.2

