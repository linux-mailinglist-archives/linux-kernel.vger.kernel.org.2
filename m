Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73793071CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhA1IlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhA1Ikz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:40:55 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627DFC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:40:15 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id g15so3821256pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0LasHSBnsU3ALa272OyzYW+m4IQeUHlxwjuI1lE7wc=;
        b=Zrmhu5hT+3e5st92w+RiwsaBhEAkiZTGj1WgY5C1syeX9h/iX7vi8xReimk9m02PUY
         P5BoWp3k9KgLm4YRzyhB6GCNEFYdPLht5OMysh7FNMHr06l85PrPvnSR4acJKz/kP7FZ
         9QjA/9TwCn6lyJf1e6BMK6BxkeOMjw6j4tlIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0LasHSBnsU3ALa272OyzYW+m4IQeUHlxwjuI1lE7wc=;
        b=ib99z6S5Q1RttqAnKK6E4GexIMy7Sgq46rFFLwvEIF88gBleMTPAESHq7/Pvns7jsp
         x074aMNVHHwucD8CakgJty+FHt+MA6x2i85MogHhcEGmPpUtTkFU/uxMd3pUiuWUmGlN
         xAerxgWnRalWJj506sNsQ+O7v1JRCJpdbT1iyBgw8BsEeIZV8fVfHTRzdavpC/hyTxUj
         Prsmdr58bzqDQ0ndDezSV0gzp4UJKaTMweNVqTRbJ5Hn7Kp7DJHkAaw8g5APUp+K51vW
         NSHuGCHlbKusPJ8JfSgSwAEhyitN8Rxjn0BnQvTW8AuXIN+LjGsQsBfen6iZbWD/6Jgi
         lTPQ==
X-Gm-Message-State: AOAM530w6EIZTGRoNFPuu/hPT4xuvDcVTfomImAzC9dLO4qEbV2S5xJd
        ANkIfitY8i7n+F5K7CVIQ6vVqA==
X-Google-Smtp-Source: ABdhPJwmFS3k/VeN+TR1fKw2hjQTki+gDtHvcVk3Cm6HE7VaMP97ybSrUS9WGLjJ7y8pi+rP50FrXw==
X-Received: by 2002:a63:5014:: with SMTP id e20mr15431948pgb.152.1611823215001;
        Thu, 28 Jan 2021 00:40:15 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:304c:5453:303a:8268])
        by smtp.gmail.com with ESMTPSA id y22sm4951757pfr.163.2021.01.28.00.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 00:40:14 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 1/3] platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
Date:   Thu, 28 Jan 2021 00:40:09 -0800
Message-Id: <20210128084011.3270281-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210128084011.3270281-1-swboyd@chromium.org>
References: <20210128084011.3270281-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cros ECs support a front proximity MKBP event via
'EC_MKBP_FRONT_PROXIMITY'. Add this define so it can be used in a
future patch.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/platform_data/cros_ec_commands.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 86376779ab31..776e0b2be0e9 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -3457,6 +3457,7 @@ struct ec_response_get_next_event_v1 {
 #define EC_MKBP_LID_OPEN	0
 #define EC_MKBP_TABLET_MODE	1
 #define EC_MKBP_BASE_ATTACHED	2
+#define EC_MKBP_FRONT_PROXIMITY	3
 
 /* Run keyboard factory test scanning */
 #define EC_CMD_KEYBOARD_FACTORY_TEST 0x0068
-- 
https://chromeos.dev

