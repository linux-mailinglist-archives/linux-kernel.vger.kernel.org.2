Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074163454A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhCWBHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhCWBGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:06:25 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626C4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:06:22 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g24so13829098qts.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5t/jCtSLeHZoOOMhMV4BFYY7qCyPGvwggJUnBiFthlE=;
        b=BpEY9QZrUQZpHCC98cVeTwkh80XOSYKbXQDE+cSgBkc9LiOWKm69pmnOeuZdqqHSG0
         KJNqKkR80p2F9dNrQ15Afq2gA6oSHYF+gnLJK3tQlbScKYq7cuucmkB/sTxrg22vu9Mx
         wn5rU+kEC1EHLIcPE1VAIQAwYX0rCd/r9uDPZ0ZJG4+ihfls3jEFXRRsCsl48guIjGh5
         OZBNM2Lqf6U+CYcs6rfi5h0leG8AWIZGLQjei4iAtezfZRYb6uwwffJI3gDiJbbH7+hz
         /jUEWeTtZ00i4fgCwNw9HYDv359kQYXs60xb0su+O6QRbvzKYi1/5bdIS5XrIWZtj5oT
         Dj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5t/jCtSLeHZoOOMhMV4BFYY7qCyPGvwggJUnBiFthlE=;
        b=QgGRgZTifcRoJ775qPcOpqj7fANdlGQBSFDh/AmCBOroDPSHDsYjcFYoIM2OGg+SG0
         TjjzeIaZdOMjj66i8YyJWwjPWJWaQGTQot7W2+dG04gTrz6DCuX0wCjyGfFPQNqXZwme
         6VSf0SIdXNZ6pzGyh7i10eYBSmT5VKYYc/wOm2FpGcxakcAuK8NtvlY6dusHZRTmlrIO
         BEK4EVeJGrq/5nQQKZ06EcFROOwBYsBj0nyCAPEeEP3PChYF0J3NO1cO2aoEdTz+bQx3
         AiLG2JoiogMoWdv0fcCFYImL2uGngNu3k7QOqx2LmjtuL9wtXrgS8IurZLuTLyA0Y86i
         R8Qw==
X-Gm-Message-State: AOAM531XKMusJkcjSGx2ZTWLC3sF5dWN4Lw0Iugrk3Tx5OB9efJNiMAc
        t6MhEBuvH7wHytoeMAy1+j0=
X-Google-Smtp-Source: ABdhPJwkQDN/Fo6TpY8sEm0rxqv+f/tjLOnca8zDgVzCCdSzmQGs4kXJRSBCxwKHEV15eB3xHCf0mw==
X-Received: by 2002:ac8:5bcd:: with SMTP id b13mr2411847qtb.122.1616461581620;
        Mon, 22 Mar 2021 18:06:21 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.117])
        by smtp.gmail.com with ESMTPSA id v66sm11523338qkd.113.2021.03.22.18.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 18:06:21 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, colin.king@canonical.com,
        unixbhaskar@gmail.com, davem@davemloft.net, lee.jones@linaro.org,
        arnd@arndb.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] staging: wimax: Mundane typo fixes
Date:   Tue, 23 Mar 2021 06:36:07 +0530
Message-Id: <20210323010607.3918516-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/procesing/processing/
s/comunication/communication/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/staging/wimax/i2400m/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wimax/i2400m/driver.c b/drivers/staging/wimax/i2400m/driver.c
index f5186458bb3d..162a92682977 100644
--- a/drivers/staging/wimax/i2400m/driver.c
+++ b/drivers/staging/wimax/i2400m/driver.c
@@ -96,7 +96,7 @@ MODULE_PARM_DESC(barkers,
  *
  * This function just verifies that the header declaration and the
  * payload are consistent and then deals with it, either forwarding it
- * to the device or procesing it locally.
+ * to the device or processing it locally.
  *
  * In the i2400m, messages are basically commands that will carry an
  * ack, so we use i2400m_msg_to_dev() and then deliver the ack back to
@@ -835,7 +835,7 @@ EXPORT_SYMBOL_GPL(i2400m_reset);
  *
  * Returns: 0 if ok, < 0 errno code on error.
  *
- * Sets up basic device comunication infrastructure, boots the ROM to
+ * Sets up basic device communication infrastructure, boots the ROM to
  * read the MAC address, registers with the WiMAX and network stacks
  * and then brings up the device.
  */
--
2.31.0

