Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4BD3ABD03
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhFQToq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhFQTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:44:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7EAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:42:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso6752147pjb.0;
        Thu, 17 Jun 2021 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=da00ZN+RLuSXdFw+Cx3yDmIBQSfROsLCEVIOIeO609g=;
        b=r5KIycO/y5V1xvjDdhknZKPhmXG0J4r2uoGdS9ISm2AlTMVsGVw/sqoCrlaDqY4Ol/
         om7m5WK9M/R6GJV9KSGgL7pW67YioAvxGrbZC0y3wWoFiGrM6s0j6HWaIPBeno+wRd0h
         2VRNQm+4T4wTCKeF0dBlqAQjPXDOlbMSwBxhW9nra4VnhVqqP+PdXgEBNtJ7rmr0fd/3
         9nXgFrohQATVKF8H85DWNC12wmddYALpM1lmAhgBwr86RXB7e3OP2D7ci9SPNSWPXQPk
         j/ddPjRJowBoJBJMwYGfOadL4T9Vmz3ZcNGpBQHSYa83IFF+vHus75KHscC0xvvNzncu
         RK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=da00ZN+RLuSXdFw+Cx3yDmIBQSfROsLCEVIOIeO609g=;
        b=IPIjNqtI8PXberJrmYObejSSVbHZrbWzc5TNlQHzT9CY4RbY1s67Cn9N2DiZgyRI1R
         5Bb3tOLKTQBN/bGpCYSGN07D7XAtO9PyY1o5B9gCUa0oLS9LYyyN7SAPRY5kl5zsb0F6
         LvFnWjEdIU5GjPVZDooXsnIQbpg5sxSlvpyvGlmE57qfB5zBhqIT/uRqcCZ7zAX4/8l2
         eaXdbi6Jl2hpdy05JG6yti09SRijL50oFAzZY49xc0Sn0rICOvIVJ9YyQOrqJYKzI90J
         k8C/FCmqf6q1Ryy5NQnYVYMN+jROGjhh4D+vBvQ7ryoNMugC8NC2BnO6DUpDMdUU+x4n
         5YUA==
X-Gm-Message-State: AOAM531QErC36z70+QfBpnTL+boYsFUlYHT1C+hKghwv3QfE0K+H+wvO
        1hakbH4unwrbuSYo12H0dUs=
X-Google-Smtp-Source: ABdhPJwW9q6oBVxAsW32fu7Y2lPktocoo8W4MTKRbk3gM8togfzrbQCQWsps1BCqnVjlRXcZ3xOTHQ==
X-Received: by 2002:a17:902:7c94:b029:fc:5e8b:e645 with SMTP id y20-20020a1709027c94b02900fc5e8be645mr1413344pll.18.1623958956442;
        Thu, 17 Jun 2021 12:42:36 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.75.27])
        by smtp.gmail.com with ESMTPSA id z9sm5987187pfa.2.2021.06.17.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:42:35 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     --to=linux-phy@lists.infradead.org,
        --to=linux-arm-kernel@lists.infradead.org,
        --to=linux-amlogic@lists.infradead.org,
        --to=linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 0/8] Meson-8b and Meson-gxbb USB phy code re-structure
Date:   Thu, 17 Jun 2021 19:41:35 +0000
Message-Id: <20210617194154.2397-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid C1+ and Odroid C2 USB feature is broken
this code changes are just re-structure the code so that
proper callback function execute in proper order.

Code changes losely based on phy-meson-gxl-usb2.c

Initially if we connect USB HDD at initial boot it get detected.
but after that usb hotplug of USB HDD is broken.
I did not observe and USB debug events messages to trace the root cause.

Another issue I observed is increase of USB interrupts event
even if there is not much activity on USB ports.
I tried some clk changes but it did not workout for me.

$ cat /proc/interrupts | grep usb
 45:          0          0          0          0     GICv2  62 Level     c9000000.usb, dwc2_hsotg:usb1
 46:   17488032          0          0          0     GICv2  63 Level     c9100000.usb, dwc2_hsotg:usb2

Thanks
-Anand

Anand Moon (8):
  phy: amlogic: meson8b-usb2: Use clock bulk to get clocks for phy
  phy: amlogic: meson8b-usb2: Use phy init callback function
  phy: amlogic: meson8b-usb2: Use phy exit callback function
  phy: amlogic: meson8b-usb2: Use phy set_mode callback function
  phy: amlogic: meson8b-usb2: Reorder phy poweroff callback function
  phy: amlogic: meson8b-usb2: Use phy reset callback function
  phy: amlogic: meson8b-usb2: Power off the PHY by putting it into reset
    mode.
  phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER

 drivers/phy/amlogic/phy-meson8b-usb2.c | 159 +++++++++++++++++--------
 1 file changed, 109 insertions(+), 50 deletions(-)

-- 
2.31.1

