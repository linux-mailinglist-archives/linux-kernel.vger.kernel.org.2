Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C900F347F90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbhCXRfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbhCXRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96780C0613F0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u21so16273962ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GplnaeoWUVj8YBA4hvKiO7ws+s2Csp6NEYWiX1mt5gw=;
        b=VHClLwAUzIb8iYeiAyEWXQru4R64ocooDxkmzS9YKD4aB311JjvITE3MmWSogieYag
         hRpDGdiOkCUTx9cPzBhC71za1sKvJ7t0ZphkRRsFrIjQPPaXz7x5AlZmRSGy1c5vhqGs
         kaAsZP4fqtKbuLLH7gYc83Gm+IZ7M5Icp7D/QqJrr2CmnfNtFAyyDskXEmRLAiADqw6i
         FqRP/52eFpkYV9FFFh/TmOdbiWypa6c/8hWLjXWw1nIlDamHHxkvrCCphAs0qnSmJfOu
         UPklZqyk98vshn1njj+OyITrLhuR8MTMYRWM/Kngvkc+s2vNrrPqtSzCmfZeyyI/oW8H
         y6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GplnaeoWUVj8YBA4hvKiO7ws+s2Csp6NEYWiX1mt5gw=;
        b=aLF2ec0LJSfFRmTCCq7TAs0eMBPsOAdfZ0FzDtD93Fr4Y5cHrsvdUBlocpg0vai3et
         oUbMNnu8++eyFy66EYCiTZ56oC0rbyyOx96M0XMpgUcN/2j4I9QrjH/fzT/hQt5AjFBU
         pWPqIcHEAvRHnlhDZX0J5vSj6IZqrsTmgpFweerY4X7vjsDbLHNOM9VQ/6/auxY3H6cu
         WxV4Pwg0qZaHuEUnpDAfio11UA7FgDSIqxZSYH44HSFjCviyfLUYPm50IIH7//TCSN/Q
         3ScMLPm32r39InVyDtjYwb2tCafhL1WGgzfllulBiGLvrYPROitbwj2DJ2bOrzQh1/74
         GbSg==
X-Gm-Message-State: AOAM532POdsQx+5tjKJ2zd600+Fc5egmLZofpbcs9lZosDp+V925NyWg
        bIxSZvKB+pcvoLJ5vBl6h3gq88E7lO22ww==
X-Google-Smtp-Source: ABdhPJyYu4OfJkDB02jrt02iTBQ1rdz4gwaiw4naFpRztIkA+MXS3Kxc9cXKU1EuXCk8F2b2bXzHmw==
X-Received: by 2002:a17:906:b297:: with SMTP id q23mr4986590ejz.315.1616607264319;
        Wed, 24 Mar 2021 10:34:24 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 16/25] HID: hid-logitech-hidpp: Fix conformant kernel-doc header and demote abuses
Date:   Wed, 24 Mar 2021 17:33:55 +0000
Message-Id: <20210324173404.66340-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/hid-logitech-hidpp.c:275: warning: Function parameter or member 'hidpp' not described in 'hidpp_send_message_sync'
 drivers/hid/hid-logitech-hidpp.c:275: warning: Function parameter or member 'message' not described in 'hidpp_send_message_sync'
 drivers/hid/hid-logitech-hidpp.c:275: warning: Function parameter or member 'response' not described in 'hidpp_send_message_sync'
 drivers/hid/hid-logitech-hidpp.c:275: warning: expecting prototype for and something else(). Prototype was for hidpp_send_message_sync() instead
 drivers/hid/hid-logitech-hidpp.c:427: warning: wrong kernel-doc identifier on line:
 drivers/hid/hid-logitech-hidpp.c:470: warning: Function parameter or member 'input_dev' not described in 'hidpp_scroll_counter_handle_scroll'
 drivers/hid/hid-logitech-hidpp.c:1894: warning: Function parameter or member 'hidpp' not described in 'hidpp_touchpad_fw_items_set'
 drivers/hid/hid-logitech-hidpp.c:1894: warning: Function parameter or member 'feature_index' not described in 'hidpp_touchpad_fw_items_set'
 drivers/hid/hid-logitech-hidpp.c:1894: warning: Function parameter or member 'items' not described in 'hidpp_touchpad_fw_items_set'
 drivers/hid/hid-logitech-hidpp.c:1894: warning: expecting prototype for send a set state command to the device by reading the current items(). Prototype was for hidpp_touchpad_fw_items_set() instead

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: Lopez Casado <nlopezcasad@logitech.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-logitech-hidpp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d459e2dbe6474..d598094dadd0c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -261,7 +261,7 @@ static int __hidpp_send_report(struct hid_device *hdev,
 	return ret == fields_count ? 0 : -1;
 }
 
-/**
+/*
  * hidpp_send_message_sync() returns 0 in case of success, and something else
  * in case of a failure.
  * - If ' something else' is positive, that means that an error has been raised
@@ -423,7 +423,7 @@ static inline bool hidpp_report_is_connect_event(struct hidpp_device *hidpp,
 		(report->rap.sub_id == 0x41));
 }
 
-/**
+/*
  * hidpp_prefix_name() prefixes the current given name with "Logitech ".
  */
 static void hidpp_prefix_name(char **name, int name_length)
@@ -454,6 +454,7 @@ static void hidpp_prefix_name(char **name, int name_length)
  * hidpp_scroll_counter_handle_scroll() - Send high- and low-resolution scroll
  *                                        events given a high-resolution wheel
  *                                        movement.
+ * @input_dev: Pointer to the input device
  * @counter: a hid_scroll_counter struct describing the wheel.
  * @hi_res_value: the movement of the wheel, in the mouse's high-resolution
  *                units.
@@ -1884,7 +1885,7 @@ struct hidpp_touchpad_fw_items {
 	uint8_t persistent;
 };
 
-/**
+/*
  * send a set state command to the device by reading the current items->state
  * field. items is then filled with the current state.
  */
-- 
2.27.0

