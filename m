Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB536F6A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhD3Hq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhD3Hpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558D8C061354
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r9so103825725ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ge3P0WNdYY2EQIE5X7at+1ZyKJ0Q7vBILrEN41L9FQE=;
        b=jYlUZsZ5o9jdFL1AtrTq+qlzPyXbh4K0D99y8p0lBTv0o+ENx1rkr0zb/xe03S53u+
         oL/sJT1b0ggYPj7ILj97RlfVEJyxWYy60MNbmk1MxoMzdP0UuTW5BPWsW2G9QSqN8U5X
         HqTtG0BmYI7VYx4Rwd9aNxS63y6UqIw03JqWNqVMF66WWUpuqhH3q/qtlnz/kw9W25ur
         Gn0zamLxlaJuddk/jDbLebtaGMJumilK1PzoUxKcPwKH0G1pjp881YHfFM5I9hmYr0CQ
         SCF/SJEyMxWwJH+oLqol3aP0E9OzQPsU/kqj/Bc6+kXjxSQPOgk9Zg/EhHPy+HBAJydO
         vxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ge3P0WNdYY2EQIE5X7at+1ZyKJ0Q7vBILrEN41L9FQE=;
        b=UhT5f62U2Y8uh/PSIQrGL4yl7H7dtv0RKAdTjmyMGEmRdtDFy/MP2WEPE4r5EnrHVr
         Sgz55DQEwZ7IvWwzOqar66pNnUAaljOD4MaeV+8R/YrKTuTxXlKbAC45+mrZ+X4Z/r1g
         MVCM2DzKeQaMpnRZkXmOsZX8s83/WC5UPcyTikAlGkLKVi6+sJIZRXu7cTM6W/Eea+nz
         75UMjugApsSMkQLK80KkUjBWqVTirQRo5JN3MTvrTtCeOYZRtpUNRq4MdVgpki1tJb+a
         LWXWAXvOP7FeebfhI9fV2j/jOV5cJtu3O5N8xuSJprXwsw76/2tQMsSn8Aj00foRMXP+
         Hdew==
X-Gm-Message-State: AOAM532Uhd3CPzOJhxhLNeczzkb9nGgRWIpz96LTHm1ocRUs+UFSg07E
        1WDqRRBsfLhV9Oq41COoEw4AsoS7rWXlHQ==
X-Google-Smtp-Source: ABdhPJzmajSPbzr4UKNIAU/QXa68J+Vr/Qh5TG+GvdWHkOdQEVb/8GUQQ/uWMWFBFucZGU4a598OyA==
X-Received: by 2002:a17:906:74c6:: with SMTP id z6mr2863943ejl.13.1619768701925;
        Fri, 30 Apr 2021 00:45:01 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id hc43sm1457195ejc.97.2021.04.30.00.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:45:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 34/43] staging: rtl8723bs: remove obsolete debug macros
Date:   Fri, 30 Apr 2021 09:43:52 +0200
Message-Id: <c090830a8b6dc855a11ef3b336b6873c8c64e641.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete debug macros.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index c4616a69425d..db9d8a529877 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -78,22 +78,6 @@ enum {
 	BTC_CHIP_MAX
 };
 
-/*  following is for BTC_MSG_INTERFACE */
-#define INTF_INIT	BIT0
-#define INTF_NOTIFY	BIT2
-
-/*  following is for BTC_ALGORITHM */
-#define ALGO_BT_RSSI_STATE				BIT0
-#define ALGO_WIFI_RSSI_STATE			BIT1
-#define ALGO_BT_MONITOR					BIT2
-#define ALGO_TRACE						BIT3
-#define ALGO_TRACE_FW					BIT4
-#define ALGO_TRACE_FW_DETAIL			BIT5
-#define ALGO_TRACE_FW_EXEC				BIT6
-#define ALGO_TRACE_SW					BIT7
-#define ALGO_TRACE_SW_DETAIL			BIT8
-#define ALGO_TRACE_SW_EXEC				BIT9
-
 /*  following is for wifi link status */
 #define WIFI_STA_CONNECTED				BIT0
 #define WIFI_AP_CONNECTED				BIT1
-- 
2.20.1

