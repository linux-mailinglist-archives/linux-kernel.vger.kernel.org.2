Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0F640C251
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhIOJDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbhIOJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:03:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149ABC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so1428202wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSOSsriq+ikZA4mrzrbiyfyFu2Bj3tXb4d5edmqNKB4=;
        b=BsQk5m21j2misJqF/GKeuIt6tbAX366ctFPEqmK0ynxh/LlC7hozkCFoBYP7lFicIB
         EJNb6SvhRJfREFgSB4aN4Qid8P+V+dgp6M79seSU0YdAgfMPgw0zghKyoDYNexU1zUri
         6HQdazENt9XTsQ+wr22CmnA6TXNOkYg/4vP82fUdrl8sk/dlIgFcSZHQyrT7TcCtkkSr
         plS+Ju90/cJCxc71W4DV/SDAI4scqXYebW32/L4m1CNpbtI9MRcrMbtyTlgul70xThiK
         h7IgjvM5/4iI4QHwLN2Im8cosP+VgFR0D0WIg0NDMEAZvH8FLuHGVxPp5iKKEXXAtr9t
         rMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSOSsriq+ikZA4mrzrbiyfyFu2Bj3tXb4d5edmqNKB4=;
        b=t0lcw/A9B81fex0eJ5B7SYKOGST3WOPNSBgpxm00tI9s5i0sGdOZ0KuzGFTXPEP/lm
         qHAtquCd0Xp/pK2JG5pBw3oW5Zq3Vn7rr026g/suhjtRWN+T7AJ8CAXMM4OvW1pt9yAM
         xIf/qKp6V6FO4KF450fNbvrCbkODHADhkkT7QZ01I3IzZZdeVBlkBzATUG0TKZn8QeiR
         cJiUWvBa1iicJyGFssaOnHcF6FEPvDDR6CyrQqyvleOMqw3YrVsVs0W0tF1ET7eZ/dfC
         Cj4SlzIuDtw3m4uziL8Ea0VIngSKJs9+ALYIN0O4+WDwmyEsVWVI7cgfkguqoCe7/Mie
         9pdQ==
X-Gm-Message-State: AOAM530H1yLXjFKXyJbgJRhcGkJfi9oRcx+Rygq2iLl1hfcEk1YlFk03
        2wpMwqd2Il98WCsFQeSnx3tuuAl8WtYsQA==
X-Google-Smtp-Source: ABdhPJxUCe9xdchxwi1Avh3jaJ3oPD+ebF7vl0C0+V6AyCX1T7IIkHRKhornkYVYeNW47auKPqtOow==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr3263162wml.55.1631696540721;
        Wed, 15 Sep 2021 02:02:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id n186sm3565530wme.31.2021.09.15.02.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:02:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/4] staging: r8188eu: remove unused field from struct hal_data_8188e
Date:   Wed, 15 Sep 2021 11:01:56 +0200
Message-Id: <20210915090156.4169-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915090156.4169-1-straube.linux@gmail.com>
References: <20210915090156.4169-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Field BluetoothCoexist of struct hal_data_8188e is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 17913dcc9fbe..e7e7064dd356 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -289,7 +289,6 @@ struct hal_data_8188e {
 	u8	CrystalCap;
 	u32	AntennaTxPath;			/*  Antenna path Tx */
 	u32	AntennaRxPath;			/*  Antenna path Rx */
-	u8	BluetoothCoexist;
 	u8	ExternalPA;
 
 	u8	bLedOpenDrain; /* Open-drain support for controlling the LED.*/
-- 
2.33.0

