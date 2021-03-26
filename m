Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F834AA0D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhCZOgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhCZOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:35:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F849C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so5871049wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GplnaeoWUVj8YBA4hvKiO7ws+s2Csp6NEYWiX1mt5gw=;
        b=gVdY+BmiCv/le2JaAaXRNqHZOQ8FZPr77309AVj8qiOYOzB9wwc47ATRvKul6T1NMP
         sMaB3udcySV2cCjdqJ+8S5gvcJc3cwMtvek2Yk+zte3A4Y5Aaj/ttoXO3Qr21eXHsXJA
         +KdCKUwMY0faf8nInYF4e1kbRs4brqRmeIOnZlnjfKkG/qyrE6QM9dnZzCyN9HBJgWJN
         FJXL/foszoatEtn2KABcnNNi7sO/40iEDJyYspDOT49dQK7vkAARyAa/cmJ1OOu5nL3n
         uD9m3g8oT8AP+dNSMQqA2EpjCgMPx6HrRIzZn0KNGPvstVJZBts/2fvzmcDZc0zKfAI5
         O4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GplnaeoWUVj8YBA4hvKiO7ws+s2Csp6NEYWiX1mt5gw=;
        b=PFv1YrL5V4nBXUHbHSz0qIjA+gyZILm4MIYjSgtA5L0AQ5vAoGqqD6IfhyLqz+XRXk
         mlnpnPyqW6tmLDgaKNVha6cOB14C6yiQOq6KNbhcPznsL+5npQsSc5i4R5ZuUhp+7EAV
         PPsCMFYiXopbE3YLEIHkpK4UZ30K0ybKrdb5Ii7wbJBcOHRMoRo0J41Hoc97QRLwdFfp
         8wcmSeQWyKxrw84hHpdgWvx+4SUsp/CaU9qhpZ79ChF6/Tj0IST+/FNdj3SnrUzIfZi/
         mdI4WpKrOKgwtrEet0HidZGU02cDnK2J4Rr9/NXDS8LlTBWfNjN+It6bz0HWTgv+O0bi
         qo9A==
X-Gm-Message-State: AOAM533RiaIQbxNoB0M00VvC1pAQ47EgwhKYnSc9e7egax4UDghvjluh
        1g+08Ts5ZatVmIewrIdtoeaSMJggqa168w==
X-Google-Smtp-Source: ABdhPJxrW/9zfhqyJX4I2dQcZ7VFapl1sAqOLChKrPCi63yz44kL11ViapqAsr1hJOmqk6421X27uw==
X-Received: by 2002:adf:fa8d:: with SMTP id h13mr14798114wrr.331.1616769317753;
        Fri, 26 Mar 2021 07:35:17 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j26sm12878225wrh.57.2021.03.26.07.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:35:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 16/25] HID: hid-logitech-hidpp: Fix conformant kernel-doc header and demote abuses
Date:   Fri, 26 Mar 2021 14:34:49 +0000
Message-Id: <20210326143458.508959-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326143458.508959-1-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
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

