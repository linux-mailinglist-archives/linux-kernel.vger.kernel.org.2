Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31581314E6C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBILrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhBILch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:32:37 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EBEC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 03:30:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lg21so30714100ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Cc/NxXbi0ROQmi6zjbqfj7rO7MXw50b30zClq/e2GI=;
        b=mMN8XnaALvkLObFNgyWZfPvtdpEyjnFILfDnQIu9xicD/I86YNjJz0SWh2jExSPLIg
         B9/qrXDcRLxwRIpHSzmJ3MaC28lmd3GRQAQYk2WfLKa+28KNhmlEyENjgRl4ZSMon++f
         n8cYW+cICwnCJ1jIq3HZKTK6AyZfSNL/2hfChDdu/HFT05f9361/V7I7iW7hRXUgokNn
         Lgcw8tZcg3wCDn6Axg6Knyf91+YMFmPo8FE2i4DH3YIYYxL0QmZEjEEEPp9xm66S5P+m
         DIEf68Wtu7aqgSMHg4EGoi3+eBPSE/2WQuwMVbf7TAkp1HibYQOmCC7xOoqsrwvO6rFO
         q/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4Cc/NxXbi0ROQmi6zjbqfj7rO7MXw50b30zClq/e2GI=;
        b=hHc1aXjyVLMSNY73fZzCAD7AVWz+YqHa7UljEA4faxJ49K9maTq3H6Vw2Ou1MIzpsK
         4pI99mne3R/cZC/PEUWkbq/kyFX83kEi341jnnx4erDRQTmM7wiSGJ1XpMdK3ROyP3W9
         PI2iZNDf2eZ5zfeIWKot2E1ALMg+lfVJSEKCrRgARho/mBoswr70ZJ2oxuq6appZHUPo
         /WrXT2ykr0Mxu0C7bQdCyPv08c3WhHQVGQvwrPnQQehhCnSEf/wX/vboDD+pKZbz/uwE
         wu1I58XnuuovAy3yBoS6ew5gxcsF5IEfwFjhZoik/lyhUj6NBSsGis1sfpV/ziAUH8fB
         iRzg==
X-Gm-Message-State: AOAM5320qV3H4qnY4PpZpQnCqCZzdjGPz/QTlPZyib6NsoEH2BOAaaIZ
        gEVR80SP63z8JsWs2hEw3FNJPr4Qw95HEg==
X-Google-Smtp-Source: ABdhPJy2JdgHnVkveR0dqLGR3SGkdU3jnwwK4J4XdPiF5OX5qIuu3Rj8X9+8MloUvIYO/+xYjJciTA==
X-Received: by 2002:a17:906:8159:: with SMTP id z25mr21824242ejw.270.1612870244214;
        Tue, 09 Feb 2021 03:30:44 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f6sm7382871edm.15.2021.02.09.03.30.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 03:30:43 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org
Subject: [PATCH] usb: misc: usb3503: Fix logic in usb3503_init()
Date:   Tue,  9 Feb 2021 12:30:42 +0100
Message-Id: <4ae929dc31c170252154352d04e89c8456d91ca3.1612870239.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on
https://lore.kernel.org/linux-arm-kernel/YCJv59g3Tq2haDSa@kroah.com/
initialization should fail if any registration fails.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/usb/misc/usb3503.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index 48099c6bf04c..3aae83fbebae 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -409,13 +409,17 @@ static int __init usb3503_init(void)
 	int err;
 
 	err = i2c_add_driver(&usb3503_i2c_driver);
-	if (err != 0)
+	if (err) {
 		pr_err("usb3503: Failed to register I2C driver: %d\n", err);
+		return err;
+	}
 
 	err = platform_driver_register(&usb3503_platform_driver);
-	if (err != 0)
+	if (err) {
 		pr_err("usb3503: Failed to register platform driver: %d\n",
 		       err);
+		return err;
+	}
 
 	return 0;
 }
-- 
2.30.0

