Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C00E432982
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhJRWGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhJRWGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:06:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBBCC061765
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:03:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ls18so13175431pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EWLOc8/hfNY9oAs9EE0iuyf6SIeHv8bSlieQBFSOAOY=;
        b=kjeS4CRP3HqOok9cHASbD8OP2Rk+FZtDj2dK3MPYTeuxKxNfgivsdx04Gk1h+fpZUr
         xuqFpOZpnsTtlcooONuW0qfYwLy8xzqovlH3362rtDHZq8EXGCTowxVZg47lZYRlI/Sk
         3wrB54xgVnrwNbDbb41K+Ro2Dto124F+vb1knnYBkghJP63yUcpHt1SAmOZbyMVZ/WU2
         Eye0HGAd3ZhWNK/SJtsMNqt5KBrWEekab7XEaYfCLnHTJLX1SHsynL3M88ojYKPXUE7C
         wty8zKbdSpvEG2KyXQqnh57zX2zVGhlu6nfLjSlMv3X0DiAoE+2uWtSBO+5gc8YVR56u
         pH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EWLOc8/hfNY9oAs9EE0iuyf6SIeHv8bSlieQBFSOAOY=;
        b=Du1mircf15ne1LKZ6sW1XljTEwFBD3/7+66cbgk1TCOTkeLIsLT0D6FiZ29OBadXYP
         uw838VOqBbICYEAIkfpBIKObU8N7SDlf8VNWrbzz4nsJNVNNDuahu13sK9IV4S3UBUI4
         NUQBiBMLUQX2iujBoeUG7zItPtET2/nAHottE59DFa+88QZdPJSxw0lvpak5F/sGcLPY
         6smKcAS3kBaAMgvtJruCEtDKixLrDXGVMgAWEbNX1CUwlKHj57Vyxnoxs2TJIufMzGC3
         PnJQILbiuixjte9GnNqZzJ6HNYUFP8g3xUj7ctJWYq8hsq7Y55tK7Q2rnla8NHCYMeLq
         9Q2g==
X-Gm-Message-State: AOAM533mZdNtQ7EsiBcudx6tF2oxo0pPC7xkLC9c8wCcBZCU3z1MgU3i
        l9MmUT785d4122oAkZOzBCAF34rm3aiHVcsU
X-Google-Smtp-Source: ABdhPJxf95LjSvvxphK4iCsAo9dgNJ1DZmUuLtM2CwL3Xh5sF77F8T232vNVIz6Lk6Scu8cdr2lO5g==
X-Received: by 2002:a17:90b:1196:: with SMTP id gk22mr1812237pjb.126.1634594638734;
        Mon, 18 Oct 2021 15:03:58 -0700 (PDT)
Received: from x1.lan ([2607:fb90:3273:95f2:c715:2287:eaad:f905])
        by smtp.gmail.com with ESMTPSA id f33sm386796pjk.42.2021.10.18.15.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 15:03:58 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Benoit Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH 0/2] ARM: dts: am335x: add rtc system-power-controller
Date:   Mon, 18 Oct 2021 15:00:18 -0700
Message-Id: <20211018220018.1514652-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan pointed out when I submitted "ARM: dts: am335x: Add rtc node as
system-power-controller" [1] that mentioning am335x-evm and boneblack
in the commit message was incorrect. system-power-controller is already
present in am335x-boneblack-common.dtsi and am335x-evm would need the
property added directly to the dts file.

These are the dts files that currently include either
am335x-bone-common.dtsi or am335x-boneblack-common.dtsi:

    am335x-bone.dts
	am335x-bone-common.dtsi

    am335x-boneblack.dts
        am335x-bone-common.dtsi
	am335x-boneblack-common.dtsi

    am335x-boneblack-wireless.dts
	am335x-bone-common.dtsi
	am335x-boneblack-common.dtsi

    am335x-bonegreen.dts
	am335x-bone-common.dtsi

    am335x-bonegreen-wireless.dts
	am335x-bone-common.dtsi

    am335x-sancloud-bbe.dts
	am335x-bone-common.dtsi
	am335x-boneblack-common.dtsi

    am335x-sancloud-bbe-lite.dts
	am335x-bone-common.dtsi
	am335x-boneblack-common.dtsi

am335x-boneblack, am335x-boneblack-wireless, am335x-sancloud-bbe and
am335x-sancloud-bbe-lite currently get the system-power-controller
property from am335x-boneblack-common.dtsi. Moving that property to
am335x-bone-common.dtsi would have no change for these boards as they
include that dtsi file too.

This change would result in the addition of system-power-controller
to bone, bonegreen and bonegreen-wireless. These boards all have
PMIC_POWR_EN (ZCZ ball C6) connected to PWR_EN on the TPS65217B PMIC.
Thus system-power-controller is a valid property for them too.

In addition to BeagleBone, I have reviewed the TI AM335x eval boards:

am335x-evm.dts should _not_ have the system-power-controller property as
the PMIC_POWER_EN is not connected on the TMDXEVM3358 board [2]. The
ball would be connected to SLEEP (pin 37) on the TPS65910A3 PMIC but R65
is marked as do not populate.

am335x-evmsk.dts should _not_ have system-power-controller property as
PMIC_POWER_EN is not connected on the TMDSSK3358 board [3].

am335x-icev2.dts should have the system-power-controller property as the
PMIC_POWER_EN (ZCZ ball C6) is connected to PWRHOLD (pin 1) of the
TPS65910A3 PMIC on the TMDSICE3359 board [4].

Cc: Jason Kridner <jkridner@beagleboard.org>
Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Johan Hovold <johan@kernel.org>

[1] https://lore.kernel.org/linux-omap/20211012191311.879838-1-dfustini@baylibre.com/
[2] https://www.ti.com/tool/TMDXEVM3358
[3] https://www.ti.com/tool/TMDSSK3358
[4] https://www.ti.com/tool/TMDSICE3359


Drew Fustini (2):
  ARM: dts: am335x-boneblack-common: move system-power-controller
  ARM: dts: am335x-icev2: Add system-power-controller to RTC node

 arch/arm/boot/dts/am335x-bone-common.dtsi      | 1 +
 arch/arm/boot/dts/am335x-boneblack-common.dtsi | 4 ----
 arch/arm/boot/dts/am335x-icev2.dts             | 4 ++++
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.27.0

