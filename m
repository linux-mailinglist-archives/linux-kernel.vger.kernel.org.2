Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98960353860
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhDDOKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhDDOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397A2C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso6418653wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vXCLvI8TEyAmbBcLdMXgq4ObYns8B8WMiEotpUKpaLI=;
        b=h09SrG+r+5CWjgigGT0BYGHjCzEwKi9mzCR2/48D2LF+znv236NDVYDzokxR7YrGwZ
         YSpEIcDzYxtR3XMR62416DflGpVuxe0aphmwNYjVoOYyTpPiLetpYjW0tm1aTw9eRNBD
         1HVKba+p5cHJ7/b/r6+e1UE55uP+m9aJo70jNpvZiIOB/TjP/7SvckO6ObEIRrwwipHH
         czPibnUzdxlLX+n//pyom/p+h5rXkotiqGqGm0mEnmjimYRjzlivkQ3k3Lu/eL3JQ0pB
         ZtILhv0HvNx1906e97kyvEyrbfJw7IaWdHbBKTmv0bgUn273l3MrVeP4+1V+cvoBkO5b
         Vc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXCLvI8TEyAmbBcLdMXgq4ObYns8B8WMiEotpUKpaLI=;
        b=f+xx6v5xJHMXxns7h24lC2vNZTiP4H/upRjq1jM3EbKZPN+qHPS2bnswFZ1hKHQyUp
         gK+lgvuotaney3fBFM/eXgu0WmykCnoI68P6KADyo3G2yEWqA978yX5AUY1Gpa1hTHti
         zJAKfwrm3ri8sQJIFv4lxyvkm44igN1P117P8dkMGzzR53tV8GbnAuJ9d6+mNaOmyp9r
         3nr7gfguVHhnd3cFazFC2rIZh685PtQN2BzP8GUlSbArtDqIX5e9NO3bS5i9+mJNCa5O
         4Kx4wABHYp8na8KqILbltzWSWEO1C4poJ20+sopJMkli4yZ+lrwA+7ua3jxLcVId9lG3
         qlGA==
X-Gm-Message-State: AOAM532/TL0INjR/t5EVtxuxAVYVm4z7GgPGzu35bTuYaYH7F6sNGnnG
        +hQCRGqPuDbIdGjhfyyVG6Q=
X-Google-Smtp-Source: ABdhPJwpr3wIitZZJ4lIhFVwC/axsTBKKp2IXt1abjIudRj2qB48XB6qJs2ZNtaZh7tbTyUz5e9WXQ==
X-Received: by 2002:a1c:bd55:: with SMTP id n82mr21034711wmf.3.1617545411881;
        Sun, 04 Apr 2021 07:10:11 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id k16sm11319725wro.11.2021.04.04.07.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:11 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 13/30] staging: rtl8723bs: remove unnecessary parentheses in if condition in core/rtw_cmd.c
Date:   Sun,  4 Apr 2021 16:09:29 +0200
Message-Id: <04aa9d68d6d28d295001dde7cc14f33ef83f8046.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issue:

WARNING: Unnecessary parentheses
166: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:2000:
+	if ((pcmd->res != H2C_SUCCESS))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 840b9da9f2d9..77c583c60343 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1997,7 +1997,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	if (pcmd->parmbuf == NULL)
 		goto exit;
 
-	if ((pcmd->res != H2C_SUCCESS))
+	if (pcmd->res != H2C_SUCCESS)
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 
 	del_timer_sync(&pmlmepriv->assoc_timer);
-- 
2.20.1

