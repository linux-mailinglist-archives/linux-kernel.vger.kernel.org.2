Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD02D3F9760
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244893AbhH0Jmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244817AbhH0Jmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:42:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AACC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:41:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q11so9433480wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=49hQMNle9dACVaZdfdNQ2gB9ofJNp4uzzkJzv4Ua50o=;
        b=Ed4Q+lnX4tSmxgrQDB9h7k/ltDqxAlizvCzZVNgbPMYsFfqivctbOMT+nC0EsTId9/
         6pYgxFm/haN9aTb43SyroOcfls8w67n9J9s4tJwef/aZ8oM+HM6s3LnszNT4jNyYJ6kA
         vxRgQnpzX9wPjbQ05d+7kWuOBBm9oRgBT8BMi7QKXr2UnMpx6/7QfW0nacCcFD0IylXa
         2iQ+G4NHz4EzwnFLlnRZI3gDrZTmS2N12o0rd5mOOO23v2AB68Wdrmz6tBz0pNWBkMAH
         cqEiIOiECr2Rn6W2lTIeT9iNRraKLkVRGdzDcQmBntE8U7WDqCvTvv9oMCX6X4mF652B
         SRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=49hQMNle9dACVaZdfdNQ2gB9ofJNp4uzzkJzv4Ua50o=;
        b=NaCgvv9y3A/SW0D1z+ALa1+oT1yLJNLAsKrZ2jg8xTxRxkkDW1hm9L9CMAUTXFT8XU
         YjwEy11u+D0l2ljf8klBVqBRU+EtHT+jlwLYD1wpgln7xlFOCBL7v/IBcVCQ5HkN1/aH
         o3HTJ7621qzZ9poUXtNa5/EdBcilHLKz9JMGiFEpXzbzEdv3+SEq8OFdlo/qimTnZymi
         LRTwYLmVrz+kJqsOnKAOGNWlSLsth4FkXDY4QcTlAHgRXKMJfpSFxiGZVkMH4gMlghP7
         blTb/Ak4/Mdz2GxyrBxMLDn8+AkhiMmlXyjjrhszO/e94DJRCD2fowq2nm/tyo6xLAJf
         YO/A==
X-Gm-Message-State: AOAM530847lB6CIzZsrh0KRMvQ6SztNA+PfLwjPTF/qKJ4MHfoJmdOBJ
        gsdtblJBWqlRMYZiaJYBEbE=
X-Google-Smtp-Source: ABdhPJztegC/vpNYym+j7OUvPm1XwfPJJ4uwJyBls7PnnG328OGuiGIIEXcpN9whDQ1kCiW6d2BVwQ==
X-Received: by 2002:a05:6000:1a86:: with SMTP id f6mr9207231wry.345.1630057314892;
        Fri, 27 Aug 2021 02:41:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with ESMTPSA id b15sm6500034wru.1.2021.08.27.02.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 02:41:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: remove ODM_DynamicPrimaryCCA_DupRTS()
Date:   Fri, 27 Aug 2021 11:41:43 +0200
Message-Id: <20210827094144.13290-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210827094144.13290-1-straube.linux@gmail.com>
References: <20210827094144.13290-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_DynamicPrimaryCCA_DupRTS() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c     | 7 -------
 drivers/staging/r8188eu/include/odm_RTL8188E.h | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 70afa0a21bf4..c64a291f9966 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -335,10 +335,3 @@ void odm_PrimaryCCA_Init(struct odm_dm_struct *dm_odm)
 	PrimaryCCA->monitor_flag = 0;
 	PrimaryCCA->pri_cca_flag = 0;
 }
-
-bool ODM_DynamicPrimaryCCA_DupRTS(struct odm_dm_struct *dm_odm)
-{
-	struct dyn_primary_cca *PrimaryCCA = &dm_odm->DM_PriCCA;
-
-	return PrimaryCCA->dup_rts_flag;
-}
diff --git a/drivers/staging/r8188eu/include/odm_RTL8188E.h b/drivers/staging/r8188eu/include/odm_RTL8188E.h
index 776a8a6dab68..00d2678532f8 100644
--- a/drivers/staging/r8188eu/include/odm_RTL8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RTL8188E.h
@@ -33,6 +33,4 @@ void odm_FastAntTrainingWorkItemCallback(struct odm_dm_struct *pDM_Odm);
 
 void odm_PrimaryCCA_Init(struct odm_dm_struct *pDM_Odm);
 
-bool ODM_DynamicPrimaryCCA_DupRTS(struct odm_dm_struct *pDM_Odm);
-
 #endif
-- 
2.32.0

