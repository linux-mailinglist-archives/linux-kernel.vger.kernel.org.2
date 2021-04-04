Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6C935385F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhDDOKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbhDDOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD96C061794
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso344268wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwdqSVIbe15EmqulmndVdLGM1V+ZcYJqDXqI1hmDV28=;
        b=VBer9f3DAOxB1cCPffZZLO2RR3/J0z3qlkX43eJRedsZ6IrEH3y7gUYjVZ8wVi3Oj7
         EZ6JTqhBbi54cr+hgBDo8E1ewiDTUdZKMI/K+w4xVxowXXPFUdcuTXXX0AejKrSqbWdT
         FeVULcbxNuAL1HrsdPUKW3ttgyfA3qAEj3WLGmKHSR29ZH6HWID6t7nBDfIQV77pEKwB
         qN9I2HGHI2Pqiye6MFpGp5MynKHpcGiJc32YWtnrHsz6lHGVgxg9Wd0PzTbNcobPFNud
         Gtplx+8tkaSU0BpSezhUVkcAS2Mg/QbaggDuP4MzisWy67LKMM7eDOImRFhmv4QUlWCp
         ieAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwdqSVIbe15EmqulmndVdLGM1V+ZcYJqDXqI1hmDV28=;
        b=fwTtLE2nLwpQCx7udW4UucX1mP/lg1fHZlWRsW1LCqL9bvrbqdlmFDDtJu/8RXnxvN
         CjU2tx2Tze/HKPplUAbRTFC7/naOjUnQGQ3PKFYfFrdfEgFJ9VOdzhKwp9Xb8QeiHmgu
         pQrtATPAh2L60X/Y/JBs1aWw2HBE1jy3xKvHN43TBSE5trBIpio2zk+elXWbwu7eKxh6
         J7ZKLOcf/f/1nNOkrdupCktSkUjSaO32hRuJuGXMm2iMd4SmmpR1pQjy7c8Zsz/wXm+G
         w5zF/Vkafh7aeiAOtkO0w17F06Rv/V4RNmdCDkOSd2lad7rWWhm3vkFGmI11kdRfopPU
         ZSBg==
X-Gm-Message-State: AOAM532grU+8PHm1GWS5WP7uDDVeUm94JWfuyFLeDiSbXTMeLHxHs26e
        bHUzIVmReE66MPBKAamNdgE=
X-Google-Smtp-Source: ABdhPJzF+Yig3TAyX1vKL9bvoUUusKxnfp833KBbej5ymuHrpgUeVKSri3ZLwa4t9OPGonmYJSUR1A==
X-Received: by 2002:a05:600c:4d13:: with SMTP id u19mr5400406wmp.16.1617545410337;
        Sun, 04 Apr 2021 07:10:10 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id l9sm18106041wmq.2.2021.04.04.07.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 12/30] staging: rtl8723bs: fix null check conditions in core/rtw_cmd.c
Date:   Sun,  4 Apr 2021 16:09:28 +0200
Message-Id: <03e36e1710ea4dfd07c3753d9a8df5746e59bc18.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issues:

CHECK: Comparison to NULL could be written "!psta"
178: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:2012:
+			if (psta == NULL)

CHECK: Comparison to NULL could be written "!psta"
198: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:2066:
+	if (psta == NULL)

CHECK: Comparison to NULL could be written "!psta"
211: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:2081:
+	if (psta == NULL)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 2086df056c44..840b9da9f2d9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -2009,7 +2009,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 		if (!psta) {
 			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
-			if (psta == NULL)
+			if (!psta)
 				goto createbss_cmd_fail;
 		}
 
@@ -2063,7 +2063,7 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
 	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *) (pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
 
-	if (psta == NULL)
+	if (!psta)
 		goto exit;
 
 exit:
@@ -2078,7 +2078,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *) (pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
 
-	if (psta == NULL)
+	if (!psta)
 		goto exit;
 
 	psta->aid = passocsta_rsp->cam_id;
-- 
2.20.1

