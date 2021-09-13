Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EDE4087C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238429AbhIMJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbhIMJKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:10:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763D5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:08:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g16so13522136wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IgAUD2VjJg2nvbCicGOdMS4iB4Wo+TqXGNDvnbqlit0=;
        b=hHOEQqwSo450EVV84izOmzTmz+EVP+i07KHfLtvWFvVoef+64TGIhyjogEmZcCE3lC
         seYlEIFV/iWkteNZMZ4vSbAcf8phZgfTb/wRaFmVPFoKxQo5g6AOAdf/ES3gEsvPTPd8
         DPNH3kucm5xVyy6W/78fc6sxQJ0kmtXh5jG0U69bvFfeSmqowp5Tql6u6vj4xB0ek6Qy
         ioPmG43VhQ8B9A79MBMmKQPuMChYYfKa7fnG8EkQEgnRpWJUjDApUvRf/+opzO+3eNNf
         PMP+8acKTjhqKGoDSfkhFk4MxOexcDWTV2uNJGVT2gRcctZHogwy1tvxTKErgeW6fQq4
         mKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgAUD2VjJg2nvbCicGOdMS4iB4Wo+TqXGNDvnbqlit0=;
        b=IuFQZd3jRVKYy5rmT0dfkpw1WrBj0sO3PugxwtfFFVvqh1BveLfrm5ZYFrt508e7Aa
         F6UMMgRTS7IBpp15mejhImopdAf5nLAptJiqDxsody7oImZmgtbccDv668ELlswxrlnM
         tj4wBPQLjY4App0iFLwyrGknZH64yk2ruucTZkN1y+oCewio7MeffGaMOzIAGDvkPpP5
         4PiSKfTgCr/2kRYS84pEoLmk29qWM4KIwhtZYBA17QjfSlGjVJzSwks2qJjM++vStaLE
         uYKsmwbZX8sOShrwP1yqJH6ahk/ElZFytqsW03fw7Lpqnj+uhFhjbrlpADNKktrWGxFT
         pOxw==
X-Gm-Message-State: AOAM532AhLlr+njMvZH1DxXxxmDbZwSaNeN+0A+9KyWEXiQs0j3iiOap
        TF2iex5JD4+rvnnWx4W0XbE=
X-Google-Smtp-Source: ABdhPJyoWsmA5M+0E+Of5rth/d/zJj6B3jDZsagoj5Av4F7krPkk1MyFIFE8LfJeABjsBzcwXwUhCw==
X-Received: by 2002:adf:e643:: with SMTP id b3mr11556084wrn.67.1631524126112;
        Mon, 13 Sep 2021 02:08:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id j19sm6702276wra.92.2021.09.13.02.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 02:08:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove header file odm_reg.h
Date:   Mon, 13 Sep 2021 11:08:31 +0200
Message-Id: <20210913090831.13803-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913090831.13803-1-straube.linux@gmail.com>
References: <20210913090831.13803-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removing unused register definitions from odm_reg.h there are
only two definitions left. Move them into odm.h and remove odm_reg.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h         |  6 ++++++
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 drivers/staging/r8188eu/include/odm_reg.h     | 15 ---------------
 3 files changed, 6 insertions(+), 16 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_reg.h

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index c76161b3d98a..c6e876f5d470 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -71,6 +71,12 @@
 #define ANTTESTA		0x01	/* Ant A will be Testing */
 #define ANTTESTB		0x02	/* Ant B will be testing */
 
+/* RF REG */
+#define ODM_CHANNEL	0x18
+
+/* Ant Detect Reg */
+#define ODM_DPDT	0x300
+
 /*  structure and define */
 
 /*  Add for AP/ADSLpseudo DM structuer requirement. */
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index a1d6d674bda6..ffc6f8ecafc0 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -26,7 +26,6 @@
 #include "rtl8188e_hal.h"
 
 #include "odm_interface.h"
-#include "odm_reg.h"
 
 #include "HalHWImg8188E_MAC.h"
 #include "HalHWImg8188E_RF.h"
diff --git a/drivers/staging/r8188eu/include/odm_reg.h b/drivers/staging/r8188eu/include/odm_reg.h
deleted file mode 100644
index 914326865a64..000000000000
--- a/drivers/staging/r8188eu/include/odm_reg.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. i*/
-
-#ifndef	__HAL_ODM_REG_H__
-#define __HAL_ODM_REG_H__
-
-/*  Register Definition */
-
-/* RF REG */
-#define	ODM_CHANNEL					0x18
-
-/* Ant Detect Reg */
-#define	ODM_DPDT						0x300
-
-#endif
-- 
2.33.0

