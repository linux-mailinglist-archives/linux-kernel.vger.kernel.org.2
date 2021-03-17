Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B3733EC52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCQJL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCQJLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:11:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E9C061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g8so1011039wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHS0YjWdwFJSN1VWVbYNsptYDs5Fwc3UmjtJJxuBnoI=;
        b=MjWxRv6k5hwZ7z+yy2GEto8m0k1ZTUoQHP4n+U62lGEzb55ZY8hmVQdepdlLI8bOCS
         vqOfFQpyywjCJk49Dt2+D0lFqtkpSvO44Po84uDduEu2INKSYC9hkniJsmSObBtinMi8
         IHtWrXlK0LGbg+hDra/UnyBbhh9yCHwF4V133NENV0Tvi9xY5OKTeE6wrlP1bHtfuKGX
         7P3LRKNeAkzJzpthui5wmwBWpLuKauVWmtg291gSkziJMTbFUah+20zXjeZXsgpazPAS
         oSjVRW59brJkF13KhMcfNg1qiIDNad4hl2belSbdcRhrs8H1pMFq2/pE9CHFw+kh2+Aq
         TxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHS0YjWdwFJSN1VWVbYNsptYDs5Fwc3UmjtJJxuBnoI=;
        b=Dl72yprf670MAYSPMJaF88sF/r6bfCVFjorZZSQs68DfGoUA4rRQP74o3Jo2FbKWdf
         /8awXZpxIF1eYu+HskW8+UAQYKb5llkzEAaYqGb6c2oaKXM/sgQMH+VdTf8+3vC40XPO
         P6CxD3R/VwYISGuk/1n/N1BPfRi8zJY//Bl1yYj5XkFcXtCr+R08tkR9onl2N9AUGv7u
         7YOImMQdFFe/ipN7cqwCXsvntMp+AarHH6t7u5yKob8ueKvZIYp9lW15+wdAJ5T9gxi8
         VrqWsjm8vLRm5LNDbyWyEkeRbJUskgC+cgi7QJYTKqJioD9vm/4osdWdZQg2KZC2eJIb
         f0MQ==
X-Gm-Message-State: AOAM531BJSie0o4HYEHB5ATbFmPkTxflv9VUsN0J2UD+irrDwc/MW+al
        4OXvvXEzqgeF41003b5bQRUXKA==
X-Google-Smtp-Source: ABdhPJzmRudb3r2YxFsn4gf3SfTw9ZYImzroHS1YjbgsqyqNqSNfYauD1RL9/MKHGVWgFWjyqqpMSg==
X-Received: by 2002:a1c:2857:: with SMTP id o84mr2675735wmo.181.1615972292529;
        Wed, 17 Mar 2021 02:11:32 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id s83sm1709279wms.16.2021.03.17.02.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:11:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 4/8] scsi: FlashPoint: Remove unused variable 'TID' from 'FlashPoint_AbortCCB()'
Date:   Wed, 17 Mar 2021 09:11:21 +0000
Message-Id: <20210317091125.2910058-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091125.2910058-1-lee.jones@linaro.org>
References: <20210317091125.2910058-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/FlashPoint.c: In function ‘FlashPoint_AbortCCB’:
 drivers/scsi/FlashPoint.c:1618:16: warning: variable ‘TID’ set but not used [-Wunused-but-set-variable]

Cc: Khalid Aziz <khalid@gonehiking.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/FlashPoint.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
index f479c542e787c..0464e37c806a4 100644
--- a/drivers/scsi/FlashPoint.c
+++ b/drivers/scsi/FlashPoint.c
@@ -1615,7 +1615,6 @@ static int FlashPoint_AbortCCB(void *pCurrCard, struct sccb *p_Sccb)
 
 	unsigned char thisCard;
 	CALL_BK_FN callback;
-	unsigned char TID;
 	struct sccb *pSaveSCCB;
 	struct sccb_mgr_tar_info *currTar_Info;
 
@@ -1652,9 +1651,6 @@ static int FlashPoint_AbortCCB(void *pCurrCard, struct sccb *p_Sccb)
 			}
 
 			else {
-
-				TID = p_Sccb->TargID;
-
 				if (p_Sccb->Sccb_tag) {
 					MDISABLE_INT(ioport);
 					if (((struct sccb_card *)pCurrCard)->
-- 
2.27.0

