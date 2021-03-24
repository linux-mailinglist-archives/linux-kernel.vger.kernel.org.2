Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7936B347F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbhCXRew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbhCXReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85790C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e7so28505091edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7/N3FVykAR22YhzUhZ15csg3vPH/3PyPAZDl2mJTyE=;
        b=VxIkrCxesyL14UeRs78vWlRa0oQXxXoxEI3HDGKMmeRkyUyy62wrRUC0w+4rynV6NY
         Ll5Rif5st8hCJyM8cC5Uk2fs4HmA72rZFok6HzR70YSH2FDLHt+9VQ2xQh/Nys9MlSxC
         P+PkpKSImwmZzOg3gBSgTPm8tYQidd6bJoT35BpgZHxu1t89/h/jNmRuH8LGfqALRXNj
         GuXNxRk90IrloCGke9ercsKjjKupoV7R3RawwgaIqClYUTfdx3wdABc4Zi84J1zQ6ErP
         QsDWP1QchO8lm4ioxgoQdnPwCcYH+TXz+vrXYv8VDQtcFiTAUShLkUZ8cg1+EXS+5uj2
         Lhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7/N3FVykAR22YhzUhZ15csg3vPH/3PyPAZDl2mJTyE=;
        b=aedCb2uznLpCa98QsatxYWjEmtOaQEgl6ghvmPMiArJeR36bCfeNWpSCq8pdrBpZFX
         PdGg0aEJ0e7PYqcYXzdyo3b6dCMwaQgCCW0R9Jy6r55QguJC+uH2LiBsHvoxCqzq1vYV
         +lGR0DMNSEE1QcHS9sXg9nmKXwHvp5c9z6nBqS4I5VE3VztBmrJUSnTGZ1oG2iV2UrCn
         DizoCa2Pygn0mhMzm4Sg4gFsZ9X8jZ4g/JgyYrgwhbjdC67PlRsk56exZGqd9BI9FIxg
         yNBamdEmd+thzWsXOvEVWzUJ/3KP2CTp9kLhXiSDiMFUZI39utBhfPPvRYFClKnsCJD+
         Pl6Q==
X-Gm-Message-State: AOAM530Ld6OkIjs9HSWAr9rNVU6nXgQcAIRtRG6ILhfvBxaJ/qYOR/zJ
        SUB++MmgX9CX0/trDFJfInuwWg==
X-Google-Smtp-Source: ABdhPJylv30JqRZMzBDUUnpDl1vh1UfuC6zxexY7SFcPJS3j7MrLyWiG3W7ZVfKXIThRWIH3JDu2mA==
X-Received: by 2002:a50:fc94:: with SMTP id f20mr4711938edq.370.1616607256236;
        Wed, 24 Mar 2021 10:34:16 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Anssi Hannula <anssi.hannula@gmail.com>,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH 08/25] HID: usbhid: hid-pidff: Demote a couple kernel-doc abuses
Date:   Wed, 24 Mar 2021 17:33:47 +0000
Message-Id: <20210324173404.66340-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/usbhid/hid-pidff.c:512: warning: Function parameter or member 'dev' not described in 'pidff_playback'
 drivers/hid/usbhid/hid-pidff.c:512: warning: Function parameter or member 'effect_id' not described in 'pidff_playback'
 drivers/hid/usbhid/hid-pidff.c:512: warning: Function parameter or member 'value' not described in 'pidff_playback'
 drivers/hid/usbhid/hid-pidff.c:512: warning: expecting prototype for value times(). Prototype was for pidff_playback() instead
 drivers/hid/usbhid/hid-pidff.c:1005: warning: Function parameter or member 'pidff' not described in 'pidff_find_effects'
 drivers/hid/usbhid/hid-pidff.c:1005: warning: Function parameter or member 'dev' not described in 'pidff_find_effects'
 drivers/hid/usbhid/hid-pidff.c:1005: warning: expecting prototype for Find the implemented effect types(). Prototype was for pidff_find_effects() instead

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/usbhid/hid-pidff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index fddac7c72f645..ea126c50acc3b 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -505,7 +505,7 @@ static void pidff_playback_pid(struct pidff_device *pidff, int pid_id, int n)
 			HID_REQ_SET_REPORT);
 }
 
-/**
+/*
  * Play the effect with effect id @effect_id for @value times
  */
 static int pidff_playback(struct input_dev *dev, int effect_id, int value)
@@ -997,7 +997,7 @@ static int pidff_find_special_fields(struct pidff_device *pidff)
 	return 0;
 }
 
-/**
+/*
  * Find the implemented effect types
  */
 static int pidff_find_effects(struct pidff_device *pidff,
-- 
2.27.0

