Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E728338928
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhCLJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhCLJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:48:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2184C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 61so1405096wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xPFThlMI/y/qW18pAnI543DROCiFDU71wLqLjBXMJAs=;
        b=vWEqgTD6oQYZpNz4Hu1OvSSZxt00P0xGD9TIfy49FIbvAkqx8vRrKch/at62za/YT6
         4V4KRKTExIvkMZmZYIS3QtI4C4dhGcI1THNQI0SOMB5DowheGfsLWehHmPdmqOOLFjVa
         9O07v3hRnNM8HijKAURKU7M52PiNWZgWEOWh3f6HJT2E3ypVayJeGPRqTQm6qgCMtkyq
         iYni+LSLtMPnTuYa+XE1+PjRfO4DO7MJgFSksEyP6030iVWvsIijj2CW/wzRk/rPluGO
         zwBxJa+wj8pDmEJsrdHPcP/PU5XtGX22Kbdi8FM5kvEKXIAiS/LncOzyK9cDyYSf/Obg
         Lw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xPFThlMI/y/qW18pAnI543DROCiFDU71wLqLjBXMJAs=;
        b=EF9vNi8/k9gIyRvlKK9WL1onpPl2A1st6SgwD6CNiifUD7HSDaufyJ0JRvbJ+CHuLF
         HCbJNO56bmiR2xfobEo/xKnKb7cHWWXK0a71uWPIhNvHPZPfTvNDrv9fVniKBFL8tjSq
         fWMvcsoQINqV+oI0SU0j5iVrPZssxD6bgWOodYqLMgkp/1HBciwRYakA5VPIVIf8ISce
         1s8MlCLHnkOYJL4Na++xezpvFpe3LYVwD9r5q+WeTw0MtyMejxSoO+ojQZ0AvXI/hj+P
         BrDQMmIFiw2U0dW0WIHHS3h1/JeYWmBhWz60d+uvEaiZ+m4HQmpHzGUlMoZrhJdo6OTd
         mubw==
X-Gm-Message-State: AOAM533zlEeENjrTsjyDd9jRL+gU9lG0FiT3xZ06VaK887uiBdRLHCKV
        GP0TbZg6BKxUK6brtYmlyeTnDg==
X-Google-Smtp-Source: ABdhPJzshM/m3B1yoxb1O5Wp3hm0MJi/SrIcPq8v19/2Od7pFzDJa/Q/tmVdDZQf9HK6DIIkGVSE2w==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr12961301wre.386.1615542494728;
        Fri, 12 Mar 2021 01:48:14 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f7sm1539536wmq.11.2021.03.12.01.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:48:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 26/30] scsi: atp870u: Fix naming and demote incorrect and non-conformant kernel-doc header
Date:   Fri, 12 Mar 2021 09:47:34 +0000
Message-Id: <20210312094738.2207817-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312094738.2207817-1-lee.jones@linaro.org>
References: <20210312094738.2207817-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/atp870u.c:623: warning: expecting prototype for atp870u_queuecommand(). Prototype was for atp870u_queuecommand_lck() instead
 drivers/scsi/atp870u.c:724: warning: Function parameter or member 'dev' not described in 'send_s870'
 drivers/scsi/atp870u.c:724: warning: Function parameter or member 'c' not described in 'send_s870'
 drivers/scsi/atp870u.c:724: warning: Excess function parameter 'host' description in 'send_s870'

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/atp870u.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
index da6ca2b153d85..9d179cd15bb84 100644
--- a/drivers/scsi/atp870u.c
+++ b/drivers/scsi/atp870u.c
@@ -612,7 +612,7 @@ static irqreturn_t atp870u_intr_handle(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 /**
- *	atp870u_queuecommand	-	Queue SCSI command
+ *	atp870u_queuecommand_lck -	Queue SCSI command
  *	@req_p: request block
  *	@done: completion function
  *
@@ -711,16 +711,15 @@ static int atp870u_queuecommand_lck(struct scsi_cmnd *req_p,
 
 static DEF_SCSI_QCMD(atp870u_queuecommand)
 
-/**
+/*
  *	send_s870	-	send a command to the controller
- *	@host: host
  *
  *	On entry there is work queued to be done. We move some of that work to the
  *	controller itself.
  *
  *	Caller holds the host lock.
  */
-static void send_s870(struct atp_unit *dev,unsigned char c)
+static void send_s870(struct atp_unit *dev, unsigned char c)
 {
 	struct scsi_cmnd *workreq = NULL;
 	unsigned int i;//,k;
-- 
2.27.0

