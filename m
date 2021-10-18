Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D3A432953
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 23:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhJRVyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 17:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJRVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 17:54:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098E5C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:52:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e65so15066298pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EWLOc8/hfNY9oAs9EE0iuyf6SIeHv8bSlieQBFSOAOY=;
        b=h21olQ5pkxOvAuyDiL6+lQnbDoSYtfdw97cCVojeFtilLvyejrpzmnVRi11+TWq0WE
         c1LPHf1/J8CHhq/uBC+C0+eUo5dLZGlo2RAxBfbIvP3otk0X+9JUrORGvOjL9I4Hj2+W
         NjgnQtL2E3+lsP/Z6yf2TlyawFC6VhQ9RFxKhBLke63j+4chIJHJsI5tIV0HXQxfnyxI
         lXYdt9WUavsPS5ZvrEzI3izIK0KgHgkD9jKxtRv0KvPGQMe2ppin82+wY1fMbfPt+sFx
         qEevOKsG2//YrAVlDIyRHMfxGsTVgIRygHCGOqHWE534Sa6VmQWu+Yp2QMwCp67sqsLk
         anhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EWLOc8/hfNY9oAs9EE0iuyf6SIeHv8bSlieQBFSOAOY=;
        b=E6tfUClN7Q5+H8e4xMeBKA28BW3L+ARzBAUPbM8CqZxKEGdgYfMLkF0eGH0V6zwFM4
         uwPfY/GLW0g7vD0VJEODh877tEFxSR7RN5xyFKcsyrpsOLIDEd4TSFCTPzfF1brV1IOT
         u3hyMG/6/Gxb6ibZ9olcgnn0+PvRT5JLoOBsXXhwQRiqnoH5sY3p5DnuR5ahCmkWSfWi
         jUJz3ULSoAbki+ab7PbOkJU/3ZzxDDqGaUAvpM+vhyg6JVjAztYBtoO5/WsO9dHBL5XF
         AxB7fCs9J1Y8I/y2hGJsGhP/NWCxPx4G/2JJXiD9BvGTbfjgMybpFgdjgRgr263cSyJs
         W52Q==
X-Gm-Message-State: AOAM533YNZ+SWamgk4fGulLKu7ZebTliOcEy78s80bTgTXXfMJFKMD+Q
        vRLDFOnOQp25rWh0P1RbT2cUzA==
X-Google-Smtp-Source: ABdhPJxnoKfy7cQGgbm9Qj9dvU1D0JpfsXSBXHhrsKy6hBHS1bJJgr7nnXJZlcI9G4typEdTt5nZpA==
X-Received: by 2002:a62:5a41:0:b0:448:152d:78bf with SMTP id o62-20020a625a41000000b00448152d78bfmr31100259pfb.77.1634593940518;
        Mon, 18 Oct 2021 14:52:20 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1080:1950:c418:eaf5:1edc:3f9c])
        by smtp.gmail.com with ESMTPSA id a30sm14409079pfr.64.2021.10.18.14.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 14:52:20 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Benoit Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Drew Fustini <dfustini@baylibre.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] ARM: dts: am335x: add rtc system-power-controller
Date:   Mon, 18 Oct 2021 14:50:16 -0700
Message-Id: <20211018215015.1435289-1-dfustini@baylibre.com>
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

