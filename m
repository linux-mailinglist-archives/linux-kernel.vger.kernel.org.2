Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C8F3183B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhBKCrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhBKCqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:46:45 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B145C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:46:05 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o63so2739848pgo.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fcZ1R2Cs5It07ydhR+GP1wIlvAE/kw9u2Y/CgRT66lc=;
        b=HknY8FTP3y3jVvqn6UoszlhPs9w32uzOIDWfOW+KOJpY/pElDLhc0aHjjkLNONT2Uc
         h7jPps8AP5BtbSFxkplTxNVabAaXGF3LOYe+DE4cRfRusnKPnIZ9/GrzGoOQRuXPwDnP
         uvdMFifwz92NLSFU/K9dZX1G46h2NvfmmOQ1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fcZ1R2Cs5It07ydhR+GP1wIlvAE/kw9u2Y/CgRT66lc=;
        b=ibmeaFXg4om7pBucl4xut0avjHn1HYPwKcRCD0WU8FDW6OLyfEkuRxpPv7hOCpg+TM
         d/QzS1kpt+CW7HmBWGitmcS8Ys8BT9Ce9bTrVOV23QFLOKDhbFePWk0KBLG0KjJCfUcL
         lQgYseHfdR6e78eBLUFxCoJldsjfIUKR8uXL5jh4474A5U5ip7Dv1NxEeOgLtIyBbjcA
         sMYjzAo+xTuoCAiHVNU25/44+WFSXjJ/5kZsw0zBGqgZ9nsjoXH1C9Y8m4d+otivRyp8
         MprEERVUjZk/59ohgiruzEjWpcPm8pjuUZkcCFAf6XxUmQnj4BWfVeaOkG8XtZT/eNvy
         0ePA==
X-Gm-Message-State: AOAM530gdpiFn52MJ84nZpp2ERIgJEwev/8lH5lLA1ERIZBHlR07y9Ef
        MgFLV3YH7cvdofLThAz9rz2f4CfRPQa/aw==
X-Google-Smtp-Source: ABdhPJyF2y60ilyDWvj5GQI3WiVnx82mRymBgQgXYnAfHzaorvP6xOUq6twCLMmw0P7ahKqAY3hGMw==
X-Received: by 2002:a63:1e1e:: with SMTP id e30mr6043875pge.156.1613011565204;
        Wed, 10 Feb 2021 18:46:05 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:5533:1106:2710:3ce])
        by smtp.gmail.com with ESMTPSA id o185sm2615920pfb.196.2021.02.10.18.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 18:46:04 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v6 1/3] platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
Date:   Wed, 10 Feb 2021 18:45:59 -0800
Message-Id: <20210211024601.1963379-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210211024601.1963379-1-swboyd@chromium.org>
References: <20210211024601.1963379-1-swboyd@chromium.org>
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
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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

