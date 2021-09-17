Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5127240F3C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245364AbhIQIJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245116AbhIQIIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:08:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D5C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:06:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso9290849wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hB7whJFC0X8jOEkpS+/j+QNCR9hvpVa/Awmx8A0MRmU=;
        b=OPrvSKkFZvhwm193cSIbqQHx/eo2pw87C/6h038Kz70XHnA65ySfjnFsPM8lLGvqwR
         dIDm/fwcYtNzjJArfbwvk7ZoBO3s2vUN1Ygcjus0tMnjInGiYUQlF+P4uvui3MLXxxnl
         0WN0Pc2zT+9/8ofknBFPogV/fAVUkgNVHlCJh6LRrnk98912M+IxzZQ8wXXRgA8TyT3S
         WA1xVJbFuxxBe7SJ08ttsbWsWIZAYJmH/GQdfOq8UBpdjEx2GSyQsrIXTIoci1qx385W
         CyMGQQ53OF/9K/T5WNmHnq9N6rPDpgewl7jPtVCpx5VzhOH8Qm0BCj21TaoG800WHSoo
         +BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hB7whJFC0X8jOEkpS+/j+QNCR9hvpVa/Awmx8A0MRmU=;
        b=bmmyYj7YwZKnPtinDDjVOwqFz9xXSjmhCCe2JmEEL2XWBJxk7/H63ai232A8y9wLIT
         cZNHI+DvC+r1PL62dfsipx99gJAlynApKq2iHWXWlNbi+iQMw24GDN+1rBZmVJ8v6L8W
         OiolX8VIZqFSQkEQP5pSSSgamhCyX+zpAfigB1HS4900bDdNU/bQ/Ewv3d8tEEDRtrpy
         EfIoFyWcPFvVbanIQ/F7K6OzlNFPXSlyfeLAdo9W235Eq8OCtKUeYJSrSd5JLNjd6KpX
         i3dIEOSYF6atb0lTUJsUJE4ZW/aSMIwVJaixWs5uwgDls7fU7AQkJAmg9v3rJeE7SFlH
         4YTQ==
X-Gm-Message-State: AOAM531A2dJav3DzQ+T9U+m+MdrMrFeOb6p6IaIyfnEtNf0Cb9iYU2t+
        iwhWiEC3Rv69LPXFxcM1U+Q=
X-Google-Smtp-Source: ABdhPJwaa6pAbo6VGnY6WtTnQy1Cm+8Lky1p3WA3OxSVLh6+rJVDyoFLMn3tEAsGk+pOyjUKlUCIeg==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr8988699wmj.114.1631865993358;
        Fri, 17 Sep 2021 01:06:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id r129sm5690890wmr.7.2021.09.17.01.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 01:06:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: remove if test that is always true
Date:   Fri, 17 Sep 2021 10:06:13 +0200
Message-Id: <20210917080615.25819-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917080615.25819-1-straube.linux@gmail.com>
References: <20210917080615.25819-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test "if (pHalData->rf_type == RF_1T1R)" is always true in this
driver. Remove the test and the dead else arm.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
index ad0782259654..03b68b3e3550 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -533,14 +533,7 @@ int PHY_RF6052_Config8188E(struct adapter *Adapter)
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
 	int rtStatus = _SUCCESS;
 
-	/*  */
-	/*  Initialize general global value */
-	/*  */
-	/*  TODO: Extend RF_PATH_C and RF_PATH_D in the future */
-	if (pHalData->rf_type == RF_1T1R)
-		pHalData->NumTotalRFPath = 1;
-	else
-		pHalData->NumTotalRFPath = 2;
+	pHalData->NumTotalRFPath = 1;
 
 	/*  */
 	/*  Config BB and RF */
-- 
2.33.0

