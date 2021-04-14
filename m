Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D965435ED74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349294AbhDNGqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhDNGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:45:59 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:45:39 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b17so13715438pgh.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYWXHC0m5snw7fdzJwmyok00ub1oisU0fjZXojNhnAk=;
        b=AzYak0j0aSFu8UGn3rt7LYpmKrIurxFN3WId1nFmsSU6CYjzf0KAHDwSJB1QkbQJuI
         V6Rtg6P9DYjbPyLtcjh52zxPoDVt7bQ9cQAbGejHPRByOFBp7qPyS7ezEcWGzZ/w/s64
         wkJ2mRiJQ7QA0Dd6DNN4sxaXdQPE4RPavKG4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYWXHC0m5snw7fdzJwmyok00ub1oisU0fjZXojNhnAk=;
        b=hGJdmz9KrTdTx/n+F09nRTqCy5M5xyqCetFnHTniFE3ZMb+cv828wolMJzcVHQws4X
         25kT1fl21lOhQQeLJKnWlaaPVa54jKxhnszZNSHxZrRdiH0WNp4r3QHlJBXoukuoiquG
         sfxAqZhAuNr3NLVfMBjF+Uzz+mABwZ0vxY23HVDdI+O8ntOzQ9+WchvNXvyQsjIIJNSG
         0CqZVChZEISrp8rLF0ScZRJnMS62L0Z31QbQ52JhDDmKnP2RwmP/g521FN7Dkf/jOje0
         oOWCBaea+O2F0EIdIt5WCFJYBTNTiwmVANQP4bKAMSDdNCh4LCHNDFkMPqdGuc/si+Sv
         L3Og==
X-Gm-Message-State: AOAM530vM9c3LE5czLYA765Sm1UYj4RzrXl2gSOZICwowc4zGaBmiD7o
        H3BoqtzNadriohKi/PL6eM5tfQ==
X-Google-Smtp-Source: ABdhPJy0jZ57Sly9/h7luIJOSL53N7qcqiGEuWfja/tblfBLkd09pVOJ3uPa+gbsldhYvBKX9uWVaQ==
X-Received: by 2002:a63:530d:: with SMTP id h13mr35844072pgb.120.1618382738828;
        Tue, 13 Apr 2021 23:45:38 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id j20sm4051027pji.3.2021.04.13.23.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:45:38 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] platform/chrome: cros_usbpd_notify: Listen to EC_HOST_EVENT_USB_MUX host event
Date:   Wed, 14 Apr 2021 14:45:24 +0800
Message-Id: <20210414064524.2450908-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On system that use ACPI, cros_usbpd_notify gets notifications of USB MUX
host event same as PD host events [1]. But currently on system that use
DT, the driver only listen on EC_HOST_EVENT_PD_MCU.

Add EC_HOST_EVENT_USB_MUX to the list of host events, so we have same
behavior on all platforms.

[1]: https://chromium.googlesource.com/chromiumos/third_party/coreboot/+/refs/heads/chromeos-2016.05/src/ec/google/chromeec/acpi/ec.asl#382

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/platform/chrome/cros_usbpd_notify.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 7f36142ab12a..48a6617aa12f 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -220,7 +220,8 @@ static int cros_usbpd_notify_plat(struct notifier_block *nb,
 	if (!host_event)
 		return NOTIFY_DONE;
 
-	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
+	if (host_event & (EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU) |
+			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_USB_MUX))) {
 		cros_usbpd_get_event_and_notify(pdnotify->dev, ec_dev);
 		return NOTIFY_OK;
 	}

base-commit: 50987beca096a7ed4f453a6da245fd6a2fadedeb
-- 
2.31.1.295.g9ea45b61b8-goog

