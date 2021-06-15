Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174E13A7D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFOLsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFOLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:47:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEAAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dj8so50661996edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2r5MNcCSbm0M6BZ8kNpV7bxrB7TQ/PA1iHkO8WPawOM=;
        b=YXxcedOLIO/hw5poO7LMC6vK0V9sVwCIJImbhzOaBkl618H5EbC/+wN+H5BPRqgj61
         ZOcNLI3rbW/EyfWUvW5OGcF3w1pp/hzAT55tpSCB/Kw0V3cBeUcAO1UipwD6wGnrkOaz
         1gnVibeEXssGCWAiQ0cjzqxxAJSa4v1y4FwRzaZn7BrShd0nlHmhCa/djdOggJ/++uT+
         BS0jOuFcXA5mxn+6P5E+vEQEz5Z7ALxk2L70YU1L4wlpydEiNh5a6bqIJr7x9HT5mK8C
         gOJyjJBVq4FSwrawpHY6aAo/fJLpIcC+ZR+sic8DdvuVNo+6XuzrEppZeTqmqEKJ/TjN
         hRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2r5MNcCSbm0M6BZ8kNpV7bxrB7TQ/PA1iHkO8WPawOM=;
        b=Fg06XPKv4DiRVuxyRa8GEdaQYnwR1TcV3edO6WGqWh7/PAbqmSI7f5+v6o2VhhgA2c
         6fJT1Zld9GMHMGCTbpd3C0C1aY2JvcWOHdw6vUwQ3YEussVYcetmP8I7dXhLs1YPqq5/
         +RDTkL76eyFKf5IHYoipNMHMC5PEmYEjHKv6mBzG7OThOQ0FKgfXqTfXALhGBRoo2kU1
         FLV3PgrC3qyLOSn2KZ+s0kGPwusdMVYShy87l7XZ7+f4bxGW82WeRkNoPgob2QvlGJQn
         VxTC8RiICETqaIwm+F7p3P6I1fw5luCSzLDpiDwfJ8ge4ts2QIJnI4QIjWFa5FaaTkNR
         Th9Q==
X-Gm-Message-State: AOAM5305On+CHjai6y7YP3uJsIOYHUEqcreSJWjK3684B5E7qJzUUHFQ
        WoB9yegnT6DyNbuONcZLgH9+8uLlaAFrSA==
X-Google-Smtp-Source: ABdhPJyO0r3I8iLDoKYOiJzcLTeDciKM2YMmT0H4HQ7pMQEmodR/gzsoB/hXgofpif64nCpBWvc5wg==
X-Received: by 2002:aa7:dc4c:: with SMTP id g12mr23331736edu.258.1623757550186;
        Tue, 15 Jun 2021 04:45:50 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id m19sm3980355eji.53.2021.06.15.04.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:45:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: rtl8723bs: remove include/autoconf.h header file from tree
Date:   Tue, 15 Jun 2021 13:45:37 +0200
Message-Id: <9317fa8fd41da4668a41775207b5e6dad33e7447.1623756906.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1623756906.git.fabioaiuto83@gmail.com>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove include/autoconf.h header file from tree.
It just contains a compiler configuration check
which is not needed.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/autoconf.h      | 14 --------------
 drivers/staging/rtl8723bs/include/drv_conf.h      |  1 -
 drivers/staging/rtl8723bs/include/drv_types.h     |  1 -
 drivers/staging/rtl8723bs/include/rtl8723b_spec.h |  2 --
 4 files changed, 18 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/autoconf.h

diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
deleted file mode 100644
index 8587b746c720..000000000000
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef CONFIG_WIRELESS_EXT
-#error CONFIG_WIRELESS_EXT needs to be enabled for this driver to work
-#endif
-
-/*
- * Auto Config Section
- */
-#define LPS_RPWM_WAIT_MS 300
diff --git a/drivers/staging/rtl8723bs/include/drv_conf.h b/drivers/staging/rtl8723bs/include/drv_conf.h
index 9cef9ce589a1..9e8c37b29a7f 100644
--- a/drivers/staging/rtl8723bs/include/drv_conf.h
+++ b/drivers/staging/rtl8723bs/include/drv_conf.h
@@ -6,7 +6,6 @@
  ******************************************************************************/
 #ifndef __DRV_CONF_H__
 #define __DRV_CONF_H__
-#include "autoconf.h"
 
 #define DYNAMIC_CAMID_ALLOC
 
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 49b404e5cfaf..cc0dac355589 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -15,7 +15,6 @@
 #define __DRV_TYPES_H__
 
 #include <linux/sched/signal.h>
-#include <autoconf.h>
 #include <basic_types.h>
 #include <osdep_service.h>
 #include <rtw_byteorder.h>
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_spec.h b/drivers/staging/rtl8723bs/include/rtl8723b_spec.h
index 999555476ebc..6816040a6aff 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_spec.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_spec.h
@@ -7,8 +7,6 @@
 #ifndef __RTL8723B_SPEC_H__
 #define __RTL8723B_SPEC_H__
 
-#include <autoconf.h>
-
 #define HAL_NAV_UPPER_UNIT_8723B		128		/*  micro-second */
 
 /*  */
-- 
2.20.1

