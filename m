Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6448341D16
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCSMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCSMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:41:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41831C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 05:41:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so8323264wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52uJTPLMjBsJcmCf/oAVxpcTU08/bsdOPAh5yKHJI4A=;
        b=mu+0N+aKZTMn+unJ9qDzPaBHWKcm3WW0XczXCvyDE/d8aCGdNo2FXqhw4jT9iKHxr/
         vEWUxHPA0bE2AfsbRoIyRNSk8DWvuMoA/oUS2TNFzCOanWcVbVVnDwZWklI+66FCEt1L
         9x7jcrZdju27W57gPxPucsABaPYvGS+KIdrpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52uJTPLMjBsJcmCf/oAVxpcTU08/bsdOPAh5yKHJI4A=;
        b=pWY5/bndLmY32AiTGp8JsXktB9h/gSiy5g0aey1X5FyS4Pby1NG/+0i3BQW7/DmUgS
         6WZhThSNVRPUz004Y/gZlHQgq+2vnRlv8BoonUNc8IhHuhsJxoZ42mPVqerOLm4NOSOH
         yt0UMPmkZK90JJ6UkPeLwL0GZE3Tcj/KiwgnEXL1hNDOmtvbgfw5JDCR2+cNhN4T4rLj
         DUpT1AKtgfVbW2zZRBrhcc7QFdqq05lrWoBZl/RhPKmSVsyIYIp1WTkx8XiSobLcy49O
         zCehXOvU1SUSFKBvqLMyfNB9P4OeStg7u/L1z14eMPouZErkLLyldTIc92VIShhi3xtw
         BnYg==
X-Gm-Message-State: AOAM533BXss2Icbutm3ONk0UPmUz/L+KwYweKnJHMNfPqpN8NB8YxOXe
        gHcXQQ+thZXqaugyKtFVF9e2uQ==
X-Google-Smtp-Source: ABdhPJwtwM/8T22qPuDdf26ciPvJCUGe3kLTILOjvd11vNWZSSGB+eUzVafZoFHlyH48Xv2cfDkt/Q==
X-Received: by 2002:a05:600c:19ce:: with SMTP id u14mr3519212wmq.109.1616157704981;
        Fri, 19 Mar 2021 05:41:44 -0700 (PDT)
Received: from vpa2.c.googlers.com.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id p10sm8223278wrw.33.2021.03.19.05.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 05:41:44 -0700 (PDT)
From:   Vincent Palatin <vpalatin@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Vincent Palatin <vpalatin@chromium.org>
Subject: [PATCH] USB: quirks: ignore remote wake-up on Fibocom L850-GL LTE modem
Date:   Fri, 19 Mar 2021 13:41:40 +0100
Message-Id: <20210319124140.2314640-1-vpalatin@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This LTE modem (M.2 card) has a bug in its power managment:
there is some kind of race condition for U3 wake-up between the host and
the device. The modem firmware sometimes crashes/locks when both events
happen at the same time and the modem fully drops off the USB bus (and
sometimes re-enumerates, sometimes just gets stuck until the next
reboot).

Tested with the modem wired to the XHCI controller on an AMD 3015Ce
platform. Without the patch, the modem dropped of the USB bus 5 times in
3 days. With the quirk, it stayed connected for a week while the
'runtime_suspended_time' counter incremented as excepted.
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 6ade3daf7858..76ac5d6555ae 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -498,6 +498,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* DJI CineSSD */
 	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* Fibocom L850-GL LTE Modem */
+	{ USB_DEVICE(0x2cb7, 0x0007), .driver_info =
+			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
+
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
 
-- 
2.31.0.rc2.261.g7f71774620-goog

