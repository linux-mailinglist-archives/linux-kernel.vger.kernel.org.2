Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCFF3EE56D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhHQERz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 00:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHQERy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 00:17:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA3C061764;
        Mon, 16 Aug 2021 21:17:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so2898465pjz.0;
        Mon, 16 Aug 2021 21:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bqqKFEqy6bW/3jaVqfILOBhErn5KinwFdoaG08aeYTU=;
        b=GegebCJ5kKpRuiPtzMuG/9/Oizma9N2aGsdKhuGiQdC7wUiRVR1it6CtyNIc96rUr7
         1Lrv7n2SoUcRo+zrgud1QzHI/S0+BM9EKdV1dWmlrq1uwJxcwfeJQxvy3pLlsNSIMcTG
         xg1oWpegNMAoB7YYtWTgVXZHUg58hyrj4IZ4iY5mpZ0bZazAz4eFsNooZjOo7iBAbThg
         7HpAbMBXtv2CXfVxxOs9YmRuPOxFRdU3q3o6KZ0QeHqAwg7StwEI9lEiUFGlI3fRDuwi
         MjhP+iXf+gIGtZ0TtT8KVdW9vLUEtDDgiyhLwaYRs+TliqPSl2yFJRNKE5nDb3Blnm/d
         nLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bqqKFEqy6bW/3jaVqfILOBhErn5KinwFdoaG08aeYTU=;
        b=p86dpLmgWe7zvcBUtl3WzWHEyMdHZaftV7mQfNF/6mXm4o1aQs8FAlKi7mdiKHFggG
         vkXndP69bK8AGIxMjtodQd6mAc8aqQPuVdboE0CMXv5SaukmJEWhPvhZJhlD8h7vfRsI
         1Z0BeKOKQN1N8dzbWcR1zXyb0WSDHkSsV6E8Y35TxJ2fEH4qmm6FatTQEFFAxA6EPGdZ
         CJnXI0lpqJ7S7svdBSMk5tut6TllB4qzShP0xLO7ruKDgvxVKy+jpRqAMBCYp9X0E5wj
         c90cu5R53kUs5ZRBM/3/lLWKsHthJlVRIVmj0iaGwCdJrUmdthXB+2yP/a8wYpnxWO7m
         tg2Q==
X-Gm-Message-State: AOAM533Wl1L07bCu5bkKg2mTBgm2BnPg+XFhtgLVlXlmtsoTZ3XrJPC+
        Dhg0OWT2LYG8OJ7o0veGUvk=
X-Google-Smtp-Source: ABdhPJxghMRfCc22t7YGDNctHOJGp0NKyTLbKYqjB+T8eXlM0tsqvm0YCsdT7rjc0rp9Hu3gT+3axA==
X-Received: by 2002:aa7:8116:0:b029:346:8678:ce26 with SMTP id b22-20020aa781160000b02903468678ce26mr1646306pfi.15.1629173841355;
        Mon, 16 Aug 2021 21:17:21 -0700 (PDT)
Received: from archl-on1.. ([103.51.72.143])
        by smtp.gmail.com with ESMTPSA id g11sm705676pfo.166.2021.08.16.21.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 21:17:20 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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
        Brian Kim <brian.kim@hardkernel.com>
Subject: [PATCHv3 0/6] Meson-8b and Meson-gxbb Fix some missing code
Date:   Tue, 17 Aug 2021 09:45:34 +0530
Message-Id: <20210817041548.1276-1-linux.amoon@gmail.com>
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
8
Changes added power node to usb phy and small code cleanup
in usb phy.


Previous version RFC.
[0] https://patchwork.kernel.org/project/linux-amlogic/cover/20210617194154.2397-1-linux.amoon@gmail.com/
Dopped the reorder of code changes as of now.

V1 > changes Fixed the GPIO input signal on Odroid C1+/C2
     New patch added to fix Odroid C2.

[1] https://lore.kernel.org/linux-devicetree/20210716103651.1455-1-linux.amoon@gmail.com/

V2 > changes Fixed the GPIO polarity for Odroid C1
     fix the power source from phy-supply to vbus-supply 
     added new patches to fix resolve some issues.

Thanks
-Anand

Anand Moon (6):
  ARM: dts: meson8b: odroidc1: Add usb phy power node
  ARM: dts: meson8b: odroidc1: Set usb power source to always on
  arm64: dts: amlogic: odroidc2: Fix the chip enable signal for usb
    power
  arm64: dts: amlogic: odroidc2: use vbus-supply for power source for
    usb nodes
  phy: amlogic: meson8b-usb2: Power off the PHY by putting it into reset
    mode
  phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER

 arch/arm/boot/dts/meson8b-odroidc1.dts        | 21 ++++++++++++++++++-
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 10 ++++-----
 drivers/phy/amlogic/phy-meson8b-usb2.c        |  8 +++++--
 3 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.32.0

