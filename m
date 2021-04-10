Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFDB35AE30
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhDJOWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbhDJOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACC9C061346
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h10so9753862edt.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xoKptjN/Za3XCKnMQ3wvZT/Nd+Wkd5RNXWkMpHcIZ+w=;
        b=YZExNgbwoso7Bp2/1mQB1Tz2shjDe2Rn/aGNjYz66jyQuog08QQ3SvE1t884UrHuCX
         LIxducPDVfFjdayb+IBMwYEWUh5P2LLOKsxiO8JWcVU4rOWt7z/1FqP4WLfttVB2qVp9
         q5RMhNjpaS5PNx46u3HTUKcM8a+gNN28Cj8AbUzYw1LLaYbFFgF2VyE7WcA+b5fqmBMG
         7qKDIyI2+ZDiZT8J3v02C/1gJo/x9lHU3VfsvsLz+nytW6ls2ZzL63J0qxm4YYLtIOfc
         2Ev09/aYgTUywHk23OkoACZNxBGxLG3AxhQZ2TZxymOo6TA6e0pprRhLLxqiPscztkU4
         lYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xoKptjN/Za3XCKnMQ3wvZT/Nd+Wkd5RNXWkMpHcIZ+w=;
        b=DdDlGUGfd6tZlOsQeOiXlIm7pslYygSuMhwjGjAjUf6ABBMcIIYg5flEykOGrOGGxl
         Y5K3Z26sP9RE+7bnHYIc1QaYc3OHPvFWqZ0hMTYtkyFQBkIKQmSu52TiZGEzpEXXm8Ta
         hoBCx7QAt/W+Z9ppAEr3L0ZUOmvSCTf2kzEDRxlmKwxh0NJ+sx6pRSkhiHroZQH+6OHK
         +0P4qZIJnChfYeGDlM+XdzvRuWjFygAyOw9u7v8paxjzP+jvoQTSXEITwFQZu/CIn6De
         Jdv9GKgkXkUG0xJsFarDoQrWiytwXD4obWjs6/FdydzR4n3yOQ80LIGcyF3uh8/cB/1N
         gBNA==
X-Gm-Message-State: AOAM531NbTSQ0nv43HI4ZQ5lPNimmTJMsnaAD45B9x8qdHUQ+cGY2DVe
        alCuwoYOmX3VROjS2soKF6BbmPOlL9rNWQ==
X-Google-Smtp-Source: ABdhPJyOgubwmg8SV/6/RhhVIhx9lXF2zGvuasrzaa50+idIH+PCGmnOfzDwSOHJT0nUkIBj055S0A==
X-Received: by 2002:a05:6402:549:: with SMTP id i9mr22547270edx.379.1618064468862;
        Sat, 10 Apr 2021 07:21:08 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id lj21sm629253ejb.74.2021.04.10.07.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 18/25] staging: rtl8723bs: put constant on the right side of the test
Date:   Sat, 10 Apr 2021 16:20:31 +0200
Message-Id: <e19cff736413714dea4265c17b512882d051a311.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checpatch issues:

WARNING: Comparisons should place the constant on the right side of the test
287: FILE: drivers/staging/rtl8723bs/hal/sdio_halinit.c:738:
+	if (_SUCCESS != ret)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index d0606267d947..049112a08776 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -735,7 +735,7 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 
 	/*  init LLT after tx buffer boundary is defined */
 	ret = rtl8723b_InitLLTTable(padapter);
-	if (_SUCCESS != ret)
+	if (ret != _SUCCESS)
 		return _FAIL;
 
 	/*  */
-- 
2.20.1

