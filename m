Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D8334D10E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhC2NU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhC2NUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:20:25 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F1CC061574;
        Mon, 29 Mar 2021 06:20:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i6so2229355pgs.1;
        Mon, 29 Mar 2021 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JwsYQU1DFQ2M+ekJ6ppgtzSpS7I0JHxVUkdRYp5wdEg=;
        b=XrH8dfshMyX3xL7fehAPt61ew87yhjSA+3XOfDhGCmPYqYTG+B6siovezQEera41Rh
         YLFDFRlh0pVuIel2T/QwtWCKJD2HY40sletmWA4s1G1eWegtef0eJP8oWUCLlB7yFMVF
         am9P49fbvso4/FfPywZEpF2xsOFPOVRIEbRgQhIzmGM8cbQ7bgO2a8/NtbbSdE/Nstc3
         AJQTxdGobE7vYDfEQQ/T9Wc7aIwRh57KPUCjBt3cdU6+JS9GKM7WCnqz6r9V1p993QeE
         rOMTsilZDlkSRjZ7auF2p8mb+RYK0Q7Dbbf9mtarvgbBCRrW0b0Cnb6KP5B0hZr76fwq
         GsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JwsYQU1DFQ2M+ekJ6ppgtzSpS7I0JHxVUkdRYp5wdEg=;
        b=csPtoujHfkWPSoo/jrUL7/pa5PJnYtwqwdZRlA/fh/EMVns+0HeQeNCcJldDN3AV7f
         f1GKIbd3VEYwYI7Q74isw5frlRmmaKfYcWiuOUT1AGccbUbCUTzjSnozWmhfsAdQFVbk
         vqi3QKm6Z9zLD4/JjQASQF4WpYoTaEt9FDhvR7MFJt/PDvhNpzeVEuWQP4DK97VzHYdI
         1zLokwvCS40YquSY309cGPeBLqjmeku0JtCfToK2is+/XpFhgnijuDS22dRr1lkQ6JsW
         1JehnOWXLZzv9NiYeX0BsZpCzGmQTYmvm2HMcm8TBx78mNB4vJ9dbn5XJ21o5ZAXglcc
         wHGA==
X-Gm-Message-State: AOAM533Mj1bdtPawX8QFN5m4eEYd75tHSVChX3muH0QtuEC5giTwURYf
        zURhw+ZYycEo939yu2X2YKeh2p02pqh+M4hf
X-Google-Smtp-Source: ABdhPJwEbRC9afY9WoMpQsBmFY1j/sgDu3pgz3Ebhpc/xBpfP+Rog+bmY7uNbzsOyaz66u3kiBjsYg==
X-Received: by 2002:a63:3585:: with SMTP id c127mr18073691pga.92.1617024024333;
        Mon, 29 Mar 2021 06:20:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:4ed:8f53:adc7:b574])
        by smtp.googlemail.com with ESMTPSA id t12sm16415838pga.85.2021.03.29.06.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:20:24 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     patrice.chotard@foss.st.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: st: fix incorrect kernel-doc comment syntax in file
Date:   Mon, 29 Mar 2021 18:50:14 +0530
Message-Id: <20210329132014.24304-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for drivers/usb/dwc3/dwc3-st.c follows this syntax, but the
content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warning from kernel-doc:
"warning: expecting prototype for dwc3(). Prototype was for CLKRST_CTRL() instead"

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210326

 drivers/usb/dwc3/dwc3-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
index b06b7092b1a2..166b5bde45cb 100644
--- a/drivers/usb/dwc3/dwc3-st.c
+++ b/drivers/usb/dwc3/dwc3-st.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
-/**
+/*
  * dwc3-st.c Support for dwc3 platform devices on ST Microelectronics platforms
  *
  * This is a small driver for the dwc3 to provide the glue logic
-- 
2.17.1

