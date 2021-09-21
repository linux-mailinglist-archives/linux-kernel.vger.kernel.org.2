Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63A41356B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhIUOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhIUOgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:36:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03772C061574;
        Tue, 21 Sep 2021 07:35:07 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so38083801wrg.5;
        Tue, 21 Sep 2021 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMlPZNVElGI73LahLPi1WKVzExr05HIB4HFIcx18ilA=;
        b=nUhoiZoPrQyF6nfVh7mxB9N8Ds4tO7Hc6KM87xmyhCQblobht1FXS61xJlSJ1AsLuT
         oUeQcTNdMK4NCFsggWFuNQM+qdCUtnQI69MqC2OLkEusKztdoLYip/HQa0lz6bK/EQbP
         9I0x1ALK9WFRbP/z3NZxFQM1IuvAwEkugrsH6LLZIdGG4wOtKBBEyR9DuviqlaIoU8uj
         AEXY/icW7pXaduLacg00huFDWNkbfhmSYCcpgtPHRtiZJDdNlt6az5so+uThdUxSfJCa
         nvNddROVLoDSihs4ld4E8Ip6d2gUdIGYE8AI+U29W9fcyXR+ExoG5o7FY8nIz1uwGY3q
         GBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FMlPZNVElGI73LahLPi1WKVzExr05HIB4HFIcx18ilA=;
        b=jcQ4fhh8N0lhxGlbScJYYBoyXKuUx/TQJReUXba9tK8nyF0yhaVw9JzC2fNnsOy8QR
         yqfa5yKz2I/DWGVJi/vHHc+dkrqujgQmLngcMYi8e8jYTbo9AcCAV/TqmSssYid3cxDu
         ktqVQUV465RyvRqoVMb7aMiYfZmrpGHcnswe+rSa4XVHdXNxAlNYMwosstjEodxAxKwb
         Y6MCYa1AY2AD4wJIlAt1kL7NuFDMF1oN/wIQmKi8jNVnoSeAoUVmfRg1JU3OhvJ5u/B7
         y+CCnlJrMmQR0/0P4Wk16gNUIVvAt/viaVbktHLSqkj1SbEEXhvW9qUEhziUHdwhyQRn
         iqmQ==
X-Gm-Message-State: AOAM530A51YVL4uFqZJrZU0PXaJKaZnm4jUBgTfSBycs8aiU2VdK2+S4
        1yHug6sMjxfEwLHdoi4wgbA=
X-Google-Smtp-Source: ABdhPJyGeqUnwCxI43174J4rxuE71o0vbgM7P0x1pjodsvB3weTAxQ64kaqV4dIaWqnl4zlK1U40cw==
X-Received: by 2002:a1c:a505:: with SMTP id o5mr5075831wme.32.1632234905553;
        Tue, 21 Sep 2021 07:35:05 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id v21sm14648574wrv.3.2021.09.21.07.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 07:35:05 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] Partially revert "usb: Kconfig: using select for USB_COMMON dependency"
Date:   Tue, 21 Sep 2021 16:34:42 +0200
Message-Id: <20210921143442.340087-1-carnil@debian.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

This reverts commit cb9c1cfc86926d0e86d19c8e34f6c23458cd3478 for
USB_LED_TRIG.  This config symbol has bool type and enables extra code
in usb_common itself, not a separate driver.  Enabling it should not
force usb_common to be built-in!

Fixes: cb9c1cfc8692 ("usb: Kconfig: using select for USB_COMMON dependency")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 drivers/usb/common/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
index 5e8a04e3dd3c..b856622431a7 100644
--- a/drivers/usb/common/Kconfig
+++ b/drivers/usb/common/Kconfig
@@ -6,8 +6,7 @@ config USB_COMMON
 
 config USB_LED_TRIG
 	bool "USB LED Triggers"
-	depends on LEDS_CLASS && LEDS_TRIGGERS
-	select USB_COMMON
+	depends on LEDS_CLASS && USB_COMMON && LEDS_TRIGGERS
 	help
 	  This option adds LED triggers for USB host and/or gadget activity.
 
-- 
2.33.0

