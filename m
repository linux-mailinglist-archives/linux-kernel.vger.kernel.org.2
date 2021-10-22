Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77F64374E1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhJVJkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbhJVJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:40:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F044BC061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r17-20020a7bc091000000b0032ca1d30b30so553562wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7RhWPpiRn/6eZuKuWb4Qykp0WF6NU3VTuWhWe9FJ/U=;
        b=aEiwYxvHkMqgB/wRsY+LIGPnCe88NCRnXH9E+51HXkCDsYrk6Tzg9YiFqae1LplibJ
         YEYKKydIb3hqz0IFnemc/4jAd8mzTfXJ+tNtLA3uS60oF3SVxx2jvWPY5aEgWRgWo4Pu
         n1XJZVeeQfUs5WMoloq8gvNir2osPFl1hj9oBwVPfSN9/LMSy9RF/gv8wjxesYrw+Jix
         nvz/KJFvIXtYuOBLBRHECnu4PpU9uwf9iY0K73LjhXfe3E0JDEqd33aNzBB21KwFv8+F
         va6QqlVcmsfLrE8VXPUc0XGzPp5TD8k914RcMn2Zw60ZF9cLUWgv7HIIozUDiITt3+SB
         Bcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7RhWPpiRn/6eZuKuWb4Qykp0WF6NU3VTuWhWe9FJ/U=;
        b=bTKPRJBbebXHLRJQhZcbpUDiK65MGXRVkJ85TWVY+g64T7T2//5eyUdlIwypIil3zn
         MoHcC0ryvPKMK2Q54iZIOVbw/nkW1OJdEjgfnNSA5cr4pQwMQ+nYYwRdyjINYk/IMPF2
         Xnm95OpSfPpQnZE5luMupnutZfp+jUwcDSVmDuHjACdu8J8GyYBrhyEkhV27jh3QzuGf
         +mgV0gyqicMMbLJkHpzGRla5Ei102rfBzc7m+8nXFue8vldgJ1mb6cgRDxcVmVo7k4hp
         VpW23h4Onfjl7l1T24ng3T8SB1aii7z3XniRJV8MVmtU1+wqNE+Ht8sz0bVv26A91dNc
         htTQ==
X-Gm-Message-State: AOAM530EWJ9O0IUyfoj/y71dtsy78kLjU5bVJEkRx8kc7fVKmALggDXL
        cDq4uYiSgTphXjk5GRV79y4=
X-Google-Smtp-Source: ABdhPJz9G2VqTbk75Af5yZurK7wFd4k3dntxX793Ol0qZVDbUCxikNYu9AL0NIWBey6vAZ8CCAJZBQ==
X-Received: by 2002:a05:600c:1990:: with SMTP id t16mr13231229wmq.124.1634895476586;
        Fri, 22 Oct 2021 02:37:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id r15sm1643602wru.9.2021.10.22.02.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:37:56 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 5/5] staging: vt6655: Rename `byRFType` variable
Date:   Fri, 22 Oct 2021 10:37:18 +0100
Message-Id: <f0b6818d2b15982081bebaf14f830f4646f61fe2.1634826774.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1634826774.git.karolinadrobnik@gmail.com>
References: <cover.1634826774.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop Hungarian notation in `byRFType` variable in
`RFvWriteWakeProgSyn` function. Change it to use snake case.

Fix issue detected by checkpatch.pl:
  CHECK: Avoid CamelCase: <byRFType>

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 drivers/staging/vt6655/rf.c | 4 ++--
 drivers/staging/vt6655/rf.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 0dd91b0433f6..3f57834901a6 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -676,7 +676,7 @@ bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType,
  * Return Value: None.
  *
  */
-bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
+bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
 			 u16 channel)
 {
 	void __iomem *iobase = priv->port_offset;
@@ -685,7 +685,7 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType,
 	unsigned char sleep_count = 0;
 
 	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
-	switch (byRFType) {
+	switch (rf_type) {
 	case RF_AIROHA:
 	case RF_AL2230S:
 
diff --git a/drivers/staging/vt6655/rf.h b/drivers/staging/vt6655/rf.h
index d3f2b8dd6afc..0939937d47a8 100644
--- a/drivers/staging/vt6655/rf.h
+++ b/drivers/staging/vt6655/rf.h
@@ -60,7 +60,7 @@
 bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData);
 bool RFbSelectChannel(struct vnt_private *priv, unsigned char byRFType, u16 byChannel);
 bool RFbInit(struct vnt_private *priv);
-bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char byRFType, u16 channel);
+bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type, u16 channel);
 bool RFbSetPower(struct vnt_private *priv, unsigned int rate, u16 uCH);
 bool RFbRawSetPower(struct vnt_private *priv, unsigned char byPwr,
 		    unsigned int rate);
-- 
2.30.2

