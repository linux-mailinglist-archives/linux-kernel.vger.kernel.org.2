Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5094409CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbhIMTWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbhIMTW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:22:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8DEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:21:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso173596wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vZ8jAUCs6rj3NiyzP7WPgKnLWOxsjYG6LIzs7abVHU=;
        b=BcgqRicZMRbKv1AhtG8S7MwOkvoJWuba1cD8fCFat6oJP8b7abeT80FCriiXYbHymf
         IvOh8TTqouyNkiHxFBIOg82FRMx0WkJG6Z8TeoFS3tLjhf1f0l4az2hra3OJugHUlSeN
         X7u6adFjlQ5kwHA6wUc5qvHwZM5ro4ssnhzwxJu74AypRPO1lYt+izfNRRyk5YhSnxgK
         cmklt6Uf7RBRJz9+NHOtCC4R6TzfXHrLMc/+pT+qbPLbfIoFLi//XzNobmgrADqp8fE1
         9jfjhBzz+I/LEMInEOY8CcmGIXyhSQVVOeKZCms6O+FLrtKmebNwKzbRoqL/Z4oEwa2u
         /Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8vZ8jAUCs6rj3NiyzP7WPgKnLWOxsjYG6LIzs7abVHU=;
        b=gLgFBS+4C0IlnvdvVO9qDI7loV8Buv1cNQwLX8oUu+/HsXBdd+aJR5NwPfJsFnC6Lg
         f/Hn+wEEyJoO0HeXizEUneYar1bSP19PppdtNy6KC2aQmfqUGR2xE6pC1fu3mECqNnsr
         vcbNzPfm0/5AL74kRQ915Grkj07QMn3lPsc0zkmbxxn0hqpBbrxuWY87NGk+k+HJwYzV
         a++IbMgv8Xu3188b+wZ9+zx51tZ+yEWRW3kG13nTMGIS2J9lhl8/thuBRiszb3pb2IRf
         FmiwsvAsLhMjtj5qUJyqFolvCV61d9p5rz11lqfKPti1cHlz+wWBOFl4fk99ZIr2kLs0
         AbUA==
X-Gm-Message-State: AOAM5325IPI6dnJHy1zva9SNURedLmMe9J/ExbsrbIqZHh9CXvI906PH
        jWzYt4ix7/iHljcBWzKxXSo=
X-Google-Smtp-Source: ABdhPJwcCzHgJmUbrS84pRpZsjGhvaigXnrFxSMIhoACpnUWSo34fC2QoTbxAkoSOFZPe3slTTlMzQ==
X-Received: by 2002:a7b:c009:: with SMTP id c9mr12855088wmb.106.1631560870394;
        Mon, 13 Sep 2021 12:21:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id m2sm475021wmm.3.2021.09.13.12.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:21:10 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: remove unused enum RT_SPINLOCK_TYPE
Date:   Mon, 13 Sep 2021 21:20:41 +0200
Message-Id: <20210913192043.26527-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913192043.26527-1-straube.linux@gmail.com>
References: <20210913192043.26527-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum RT_SPINLOCK_TYPE is not used in the driver, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm_types.h b/drivers/staging/r8188eu/include/odm_types.h
index 6f4a4bd37ec1..ecb2bef38351 100644
--- a/drivers/staging/r8188eu/include/odm_types.h
+++ b/drivers/staging/r8188eu/include/odm_types.h
@@ -21,10 +21,6 @@ enum HAL_STATUS {
 	HAL_STATUS_FAILURE,
 };
 
-enum RT_SPINLOCK_TYPE {
-	RT_TEMP = 1,
-};
-
 #include "basic_types.h"
 
 #define DEV_BUS_TYPE	RT_USB_INTERFACE
-- 
2.33.0

