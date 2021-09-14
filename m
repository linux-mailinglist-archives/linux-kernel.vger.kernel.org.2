Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E229040AD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhINMPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhINMPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:15:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82DCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:14:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t18so19886047wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoJvBnKBOpOjZqtzLlm6r3dvhs4vOZnc+8JZoV4fMA0=;
        b=B+CDqLAoKa4kJVCfKVFIjkvZH4MoHyqTAkLYmWNdaAEhskI1RxiLaY0LLVZVuUZBZd
         x1VssxCNRhlqmzcIqVGRhdO4SrhFO0vDFbBx+qbP4fIqTiJhVNbJnZ726dAZHBA+vU4m
         dN/2agRyClv2L43gpMyb0W7sUTkRn1bCsnyprvnXtbY4etSaZ7zc8FTGAeNWuU853z3a
         PVt5fFzS5gXXDZzrUCk4xgpS1v8Vtws6TkVrS/3RXD1OohopGK5LcOiKFsLW7phFswb4
         lTa0y2CVWcmPJuK9XEUl7V0A7FllDF3pJ5drU29BWdohVg/Hk45injR2defgsa1z9H9h
         2aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoJvBnKBOpOjZqtzLlm6r3dvhs4vOZnc+8JZoV4fMA0=;
        b=t7HDl3woKU2I//2YYOfwktAaubsSBTCeZCJVWiyJNGHRGZmJ5M1UHXCxUXj7N4cdLP
         xqRSSMrr9H/v+oerc6EY36Y5bSqrs1Zm6KCPZ/aNW9XEIetMkVjlWrci1YRF7mp3qGnd
         aZ7OwjfaEE0I5Fo6/rjqXV9P39aoQbr39f6xCNu0UXO5XSu1Ur2T4QCHzenJacrvItyb
         ntLu/UFcuLSZCLt+BGc8CEVQXzXhISc15UPwJUvQp/eVjiKM1rk+Loji+pkkYEvWXfWF
         anXfq1yd4KiJ//ENwe6jZLIHcr12yeXG8WOfMPZmxlhbTKnZuVgg56MW6xGUNgiAYOrg
         yVPQ==
X-Gm-Message-State: AOAM530QVhd5LKXr54cPtr2VG4hn0LL+R7QdM0qTj/EWeSaDRhp9U/Df
        J59AgY7sLijyEaQnx8ti2o8=
X-Google-Smtp-Source: ABdhPJzwt7sL/X15JIuK/UP65hzOWrQazW+J3Y0qUhw8dcKMaf67VyXTuR7cHHbiUeKjCpOzJ7I67A==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr18261260wrj.270.1631621643254;
        Tue, 14 Sep 2021 05:14:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id j19sm10028100wra.92.2021.09.14.05.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:14:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: remove unused macros from rtl8188e_hal.h
Date:   Tue, 14 Sep 2021 14:13:49 +0200
Message-Id: <20210914121352.26052-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914121352.26052-1-straube.linux@gmail.com>
References: <20210914121352.26052-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros INCLUDE_MULTI_FUNC_BT and INCLUDE_MULTI_FUNC_GPS are not
used in the driver, remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 537a8d17642c..f16ffd952215 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -394,11 +394,6 @@ struct hal_data_8188e {
 	((struct hal_data_8188e *)((__pAdapter)->HalData))
 #define GET_RF_TYPE(priv)		(GET_HAL_DATA(priv)->rf_type)
 
-#define INCLUDE_MULTI_FUNC_BT(_Adapter)				\
-	(GET_HAL_DATA(_Adapter)->MultiFunc & RT_MULTI_FUNC_BT)
-#define INCLUDE_MULTI_FUNC_GPS(_Adapter)			\
-	(GET_HAL_DATA(_Adapter)->MultiFunc & RT_MULTI_FUNC_GPS)
-
 /*  rtl8188e_hal_init.c */
 s32 rtl8188e_FirmwareDownload(struct adapter *padapter);
 void _8051Reset88E(struct adapter *padapter);
-- 
2.33.0

