Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4F43AD1E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhFRSPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhFRSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:15:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2004CC061574;
        Fri, 18 Jun 2021 11:13:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso6270531wms.1;
        Fri, 18 Jun 2021 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K98EYWEUrUiQZaYXU/th664Hrf+PPLxMaWShDbXXluI=;
        b=MagQyTCH6HKucF9M5MPjQOtjWLH5BVKOy3z+P6fS8qm/GxQkX1sdrEJfjjCTsPb7mk
         Wo6W+qwF+/gPPDBAHXFtYBZgygw4Oxk4b3ZmLQggQh6HLvlaX0yHfSeETlmDIRxXb+4N
         q9GaC3Hcs2q7yXQFSv8f/VoDdX1m+bSX/BLwXotMwPxD5dMPv/SRXA2cI7SHGnXDr9Wr
         FGjsc1c4DwVDXWxTDWOmwT4LuyhIRVqHgYPutZ+nU/3foiKwxL3wCCBdkARAS5TsFKHs
         5WRJe0bXrdLAY2wfChXOCH5mFjMRZM27ZpJEi0EePdUOSheOv+x6AsDfH81L9IqMoJK9
         Jc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K98EYWEUrUiQZaYXU/th664Hrf+PPLxMaWShDbXXluI=;
        b=snFL2FsjiagXLr4H5humygTG4mEeoxoBIcawwXmaXcaL6Tr21HddgI71WSU/XkMZk/
         h7YeNeZ/5nQ3B6DfX8CuoZyMb+VOq+Fjm56BJp7sFFvYPZEpRpBZ6g3923CO81m4LLJ4
         mj8a45G1G/qRpFJDECtjmaJBwCNlPsalr4Tt5cATAjUIk3tbAIBvtfEbUfHBEW6/tyz5
         ptqTr0R5X92MxvlCdwSwQc8SVgPGZtvXhrp0FToJSQ452llntaGLi52ICoZ9MtVBsM8m
         n1nY6aWXqkj1kbm4hQ3tP7jvjhl8haLPCcijt1m4Qx4jsndo5JPRTyqQf0E+f52TYdA/
         Bu0w==
X-Gm-Message-State: AOAM530gOWj7X5ccFarJWW80osOeRoh04sNosMTfF/ni8e8eRiX7q58+
        cYuCeAHOCuO2MsS0ITqM8w==
X-Google-Smtp-Source: ABdhPJyy8iHBbsu57j9eptw73dfQDpL/8ILy4+jW+ngV7ZBRnAfUd4HJTMW6O3/lPCP+LW2Hxq9nCg==
X-Received: by 2002:a05:600c:410c:: with SMTP id j12mr12895602wmi.117.1624039981706;
        Fri, 18 Jun 2021 11:13:01 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id l10sm9306782wrv.82.2021.06.18.11.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:13:01 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 0/5] Updates for Radxa ROCK Pi 4
Date:   Fri, 18 Jun 2021 20:12:51 +0200
Message-Id: <20210618181256.27992-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

This series adds support for 2 new revisions of Radxa's ROCK Pi 4,
namely ROCK Pi 4A+ and ROCK Pi 4B+. While most things are in common
with the previous 4A and 4B revisions, they have OP1 revision of
the SoC and eMMC soldered on board.
Patch 4 and 5 add SPDIF and anlog Codec to the common device tree,
since they are in place in previous revisions as well.
It superseeds
https://lore.kernel.org/linux-rockchip/d4e4e06e-6ddd-4707-232d-b829c1d646e6@gmail.com/

There is no example (which I could find) for Rockchip on how to
deal with "+" revisions - so I looked up other SoCs and the rule
seems to be to use the "+" for the model name (which is the "offical"
name), but use "-plus" for compatible name and device tree files names
(see "Raspberry Pi Model A+", for instance).

A short node for testing ES8316 codec:
The driver disables the headphone jack by default - for testing
one would have to enable it via amixer with:
amixer [card index] 'Right Headphone Mixer Right DAC' on
amixer [card index] 'Left Headphone Mixer Left DAC' on

Alex

Changes in v2:
- added additional compatibles for the new revisions (Heiko)
- renamed ES8316 audio card name to "Analog" (Johan)
- added patch for SPDIF
- aligned spelling of board name(s)

Alex Bee (5):
  dt-bindings: Add doc for ROCK Pi 4 A+ and B+
  arm64: dts: rockchip: Add RK3399 ROCK Pi 4A+ board
  arm64: dts: rockchip: Add RK3399 ROCK Pi 4B+ board
  arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4
  arm64: dts: rockchip: add SPDIF node for ROCK Pi 4

 .../devicetree/bindings/arm/rockchip.yaml     |  4 +-
 arch/arm64/boot/dts/rockchip/Makefile         |  2 +
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 54 +++++++++++++++++++
 .../dts/rockchip/rk3399-rock-pi-4a-plus.dts   | 14 +++++
 .../dts/rockchip/rk3399-rock-pi-4b-plus.dts   | 47 ++++++++++++++++
 5 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a-plus.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts


base-commit: 009c9aa5be652675a06d5211e1640e02bbb1c33d
-- 
2.27.0

