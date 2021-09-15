Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68D840C24B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhIOJDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbhIOJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:03:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B71C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso4172040wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoJvBnKBOpOjZqtzLlm6r3dvhs4vOZnc+8JZoV4fMA0=;
        b=I63nVdJbqIeW35Xp8HmPvz9AMRl+ZEwPP5gMxbLve4Ttlhafe9uZqFSTn7dXEVDyFb
         QVSXeeY9dKCcIuQdwQX5rOcy+CVUWoK2URKPgEnPyYKrWOPG2QmjfScQmprH5QKtHat+
         5rmPfZCSHOZMll6pxN+etWEmbEDcZHoVnNQv0yOVCKQh5CtLi5hEvH2OSfgo+CTtstCh
         wfV4/OcaRT3/CXwXJgkusUEh+Qz0tPV/jgEnCXu8lll87rmQMY+lR8MlE2hC9Qy6t23s
         5PUJWNgOdWLXhpRzY1a5/3JgMviA3iGxqGIHiH4/jyij0TP0AxIn+p6xgC5CFYBpEMV/
         bK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoJvBnKBOpOjZqtzLlm6r3dvhs4vOZnc+8JZoV4fMA0=;
        b=3f5ncfgH+mcWzJZRFNF0Jufi3HXz0CH5CZL9gj5NUHTcozU4o4mApHKZS0vFK0RGEI
         uFwtsQ7mZKgZEO8YWI20/p2x+3C1qL+XN/FyMNAArtr9PDg+phAY5I/hguLg03qpBC24
         CMTB7PRZxeiju4lOULcJFtfC+VCc8f8pGQQzyyML9vXTDlflx62uuHE5/dhdRQh6zjPs
         kuuCoGr3xbPV9D/iQo07kyJddOgimjdS2NoKHEYI7zrz4tVkII1ZKD6W28Khg+j4qK+o
         9mFuUZpgybNkiEfEGhCLw384an1ab7c0l4m2K8S1wfm3DAq9IqeLIUECJUM7VM9wxyNN
         /nQA==
X-Gm-Message-State: AOAM531iGLjQanTeXT+1S7youv/cwW+n7YjKnACUVj/e8PW2uM+NN43z
        WKFUF/OgALXf7FGU+EFHQxo=
X-Google-Smtp-Source: ABdhPJy2Bz8F2C4FesebsFH93lNrGkQr998ZqovXUNIerDVXj2GTTX+MsIJdkH6wPK5/2GmOIf/Umg==
X-Received: by 2002:a1c:9dd2:: with SMTP id g201mr3283992wme.46.1631696538266;
        Wed, 15 Sep 2021 02:02:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id n186sm3565530wme.31.2021.09.15.02.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:02:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/4] staging: r8188eu: remove unused macros from rtl8188e_hal.h
Date:   Wed, 15 Sep 2021 11:01:53 +0200
Message-Id: <20210915090156.4169-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915090156.4169-1-straube.linux@gmail.com>
References: <20210915090156.4169-1-straube.linux@gmail.com>
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

