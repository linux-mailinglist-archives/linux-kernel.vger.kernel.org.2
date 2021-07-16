Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6A83CB626
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbhGPKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbhGPKkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:40:12 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC234C06175F;
        Fri, 16 Jul 2021 03:37:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g24so6209204pji.4;
        Fri, 16 Jul 2021 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8G+M3Pw6x7gYnZSkh4aaoUmFg7SaF7iRIrkpxTHDQbs=;
        b=VNwmVnNALzHJttybOSu9O4QJ6IvIeATmuH7H39D4n0I7+wLVes021heN6eS+xJHtUl
         YhfMIQN7Y7nrtpnD++hkvPBxt+ahBh8bbFJ8SnBKR4BAZQpBjsK+3yd50Ltw4KKp74kw
         D/+bzUVvpQ+nr6KE+zVBG6c3kNBSYRwTe9biArR0KcKuT5A/tLdEPgs7BKBa//r1uAfR
         47ISCzQgVruYpRcNDvrB39+Jg/dw6njT4gk/hjjKDLROY6YECMASaDYzmv4SQZnIHWSP
         BNTE03w1Dnc6rdKYLeqjDOFCV6vNdm0RCqKp7Sk0YBf0K6EGyAJdmc7Y5Q4MaVoX+6Fb
         R8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8G+M3Pw6x7gYnZSkh4aaoUmFg7SaF7iRIrkpxTHDQbs=;
        b=pShsV/woEbJCLduQGNPR6Rm7bNDaYT0mb+ZMmEcggMlR/g7/Dfm8wI9CBaQ//m1v02
         PIoUv+vhxdp1QhtMcq98wV40YtwkUexQCl88bp9NuZyEDjuI7L6fyb3S/zTkYUTfflbM
         oX1e4JlXV/eKQLnod+P9WpgDJZAPo4HeIGSaDDliJ1+lLCFscfbTTzX+WHv0jC2OCfK0
         v1IcG1CgjvBtZVwIwSGsi+fVQOW6vwlJOkmB9LMZ+D8an+1znq6ZjIru+HhlP88bg5aw
         r7R+h+vTqEvU6d9Uuli2cF4QY1SLheEMzzaIOHuSTthrMtQFHNL8b8wdr/rg+KMJnqGK
         5OIA==
X-Gm-Message-State: AOAM532YP4c9FIxunskNsG+yek+Mzj95hqiGWHNZaWUZ3oTr2YwI3qq8
        NQGyFfJzBX6zGDdZNlMAwzs=
X-Google-Smtp-Source: ABdhPJzAO3AEXflzapXSJAOdvXJDpcbPoXXSMAFsuA1F9e87YTfPkmufyOz0AGRqHTGlQSf3SyjVHg==
X-Received: by 2002:a17:90a:f698:: with SMTP id cl24mr14779412pjb.79.1626431836205;
        Fri, 16 Jul 2021 03:37:16 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id d29sm10070111pfq.193.2021.07.16.03.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:37:15 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv2 0/4] Meson-8b and Meson-gxbb Fix some missing code
Date:   Fri, 16 Jul 2021 10:36:32 +0000
Message-Id: <20210716103651.1455-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid C1+ and Odroid C2 USB feature is broken

It's being observed the after initiation of USB phy
the USB port goes in to suspend state, If we pass usbcore.autosuspend=-1
via command line USB hotplug seen to be working.

Another issue I observed is increase of USB interrupts event
even if there is not much activity on USB ports.

$ cat /proc/interrupts | grep usb
 35:   26462800          0          0          0     GIC-0  63 Level
			c90c0000.usb, dwc2_hsotg:usb1

Changes added power node to usb phy and small code cleanup
in usb phy.

Previous version RFC.
[0] https://patchwork.kernel.org/project/linux-amlogic/cover/20210617194154.2397-1-linux.amoon@gmail.com/
Dopped the reoder of code changes as of now.

V1 > changes Fixed the GPIO input signal on Odroid C1+/C2
     New patch added to fix Odroid C2.

Thanks
-Anand

Anand Moon (4):
  ARM: dts: meson8b: odroidc1: Add usb phy power node
  arm64: dts: amlogic: odroidc2: Fix the chip enable signal for usb
    power
  phy: amlogic: meson8b-usb2: Power off the PHY by putting it into reset
    mode
  phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER

 arch/arm/boot/dts/meson8b-odroidc1.dts        | 19 +++++++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  |  7 +++----
 drivers/phy/amlogic/phy-meson8b-usb2.c        |  8 ++++++--
 3 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.32.0

