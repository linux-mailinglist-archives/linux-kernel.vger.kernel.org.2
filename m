Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C0E3906FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhEYQ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhEYQ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:57:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6769FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:55:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j14so31222236wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56nDPhFIj8bYnpdmgf2D5pufG3atbZiNiJawhVqj3ks=;
        b=bCjBiw1k+xFMqPf4nex6kscsLYlhaIHMRIYgmoLAPAYShq9qTUzpF3W5fPN+obY8Wc
         vtsguGfPBszH7fOHD+387HersGfn3O2yVc+emyPzERdGXK8zQTp26lI2Xd25+KzMc6gm
         QR9NAUJ2uX0Bk0AJDArhg2TKp7lL4tHFSvv1BMHSzNkEzOQqcWGu5EkB/Y8W7yOWmb0S
         sIBylF0934BiTKctU9EmPhSnbl+vuED5mG6lxF2L9dKN7/UUyZfxhRo9bhIUj1rxAbw8
         7+HvMcr7+cbQG8cBjt0MC8aKvOY7htL9P8VeqIsAwLCbws69uC0qW88wG40Q0a7ITM/p
         tfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56nDPhFIj8bYnpdmgf2D5pufG3atbZiNiJawhVqj3ks=;
        b=tGM87CTbGQR1titEx/R1WB5snDQgerD3uJOw526fxy3bwXOfp2LBAzI541+qbAaKZP
         Pyxu1+0ZnGax/xOOA/3DhB7Y6eUpeBbq6IwNIkYCYBryKexx0lJ/IQZwGpnX5b5gBMnp
         3L11zUwFJ9FQI0s6txcDpCi6tSOlwuQ6CnYRAhHpRNgJ3/2VbE1goAwK5j/Ln11yjrML
         oHmoBsdBzy+A7377kWBjusQX44MFXX6kQ7kA9c0VS7k30Pl77Ddz3MM5xcZ3Z9fK6G4e
         LBwp+CvkRLuNSI0UCGGDleRdXJ8BUSO1IeiczKtGdptWEn0yxyEacbFlX55zi1tplEFE
         9zuA==
X-Gm-Message-State: AOAM533xyw7tju2TSR+TEoNjun83vMuI/QYhTQE/y9ukjYINPNIiU97R
        1drR2JOjuRCI/CoeHV8zB9hZcw==
X-Google-Smtp-Source: ABdhPJyEnBrUpX71recZ5Cz9ghtNvZv2axCQifVKUy04RpPOy0rEInHPbsrS2pzA/OHJF5g5of8r0A==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr27794223wru.186.1621961748918;
        Tue, 25 May 2021 09:55:48 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id l3sm11571447wmh.2.2021.05.25.09.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:55:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, amit.pundir@linaro.org,
        bjorn.andersson@linaro.org, andy.shevchenko@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v2] gpio: wcd934x: Fix shift-out-of-bounds error
Date:   Tue, 25 May 2021 17:55:39 +0100
Message-Id: <20210525165539.25330-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bit-mask for pins 0 to 4 is BIT(0) to BIT(4) however we ended up with BIT(n - 1)
which is not right, and this was caught by below usban check

UBSAN: shift-out-of-bounds in drivers/gpio/gpio-wcd934x.c:34:14

Fixes: 59c324683400 ("gpio: wcd934x: Add support to wcd934x gpio controller")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
changes since v1:
	- removed unnecessary dump stack from log

 drivers/gpio/gpio-wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
index 1cbce5990855..97e6caedf1f3 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -7,7 +7,7 @@
 #include <linux/slab.h>
 #include <linux/of_device.h>
 
-#define WCD_PIN_MASK(p) BIT(p - 1)
+#define WCD_PIN_MASK(p) BIT(p)
 #define WCD_REG_DIR_CTL_OFFSET 0x42
 #define WCD_REG_VAL_CTL_OFFSET 0x43
 #define WCD934X_NPINS		5
-- 
2.21.0

