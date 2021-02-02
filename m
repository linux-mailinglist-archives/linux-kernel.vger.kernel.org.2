Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8605D30B510
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBBCLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBBCLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:11:07 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB7C061573;
        Mon,  1 Feb 2021 18:10:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f16so975372wmq.5;
        Mon, 01 Feb 2021 18:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f6cfnJUj3ixleZugMsurt3GK+ClAIDiuD3TFRsp/gNU=;
        b=Q9OC1V7F6GU8kJh9uHNzuxKQqYMM1FZeo+XTauphZ+SKM7lhrU7J9Bd4oY7DUbK2hV
         qpt9ok+hSk+WQANPFlZ4p4NERncSIT3IxqHTc45Eb6eFNMI1qKhuaOrD9c0AbeDG1xWo
         LX93WAeEKBH4NPQhyl93p9dS6GPqXQJjVMvOLL4YSGUCvuR6WwXOqlbhJPQfwshLAV5I
         ZYBbaR9rPmrlYqNHjhLaYkhUrVzRugJBOzqkz1RTYg9zBG4isZYT9+VL4LZYO4IX8zK5
         Dvy2lsH1yXg9DiXKrxRE2/vMwHLGHHd06Yzcs1r8bRdmUihDy421KB+/BxmXSKZXpl9+
         qtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f6cfnJUj3ixleZugMsurt3GK+ClAIDiuD3TFRsp/gNU=;
        b=XCfbcUQr9rc/TTcsZ29E03tgyb+VGjowB/Zi5d3PobwX7eJ8ET1mrQI2GMl5bOXb94
         G88pcED0dhIkmrg1oIeActXg5ns+PvsCFaBU7qrRkWVWrIn4p+5WGdoarISzig2GqGSw
         6HbB4/u1eFGXRgbzneZukYBjiD2JHott0iYVUB3O5BLdE8VaT9baTrZ+6NAZXWv1AG6v
         YNZBoSsJscypxSGAanyK2ew+Po7TUSIJlc0td9nvkFuXtgaI/nOgSSmWWikQYV2dBCrZ
         5RpeoXDlKKcZpT4/ALMcVVopDVOlqneIo9dKzcky1TO/leDOE+trjNawlBzV1v5sS+IC
         y/6Q==
X-Gm-Message-State: AOAM5315Etwnu+kDnlNx+E3jR6jHxbw3BYOQYkQjLgD4nGNXrkAGuATF
        bAK4r4ANqq5/dFRHL2QZ7No=
X-Google-Smtp-Source: ABdhPJz4VUGoRhko+s6ShlvQwvw4Gmm/ELgj+i1+EG9swV576yp4d79mLLd+eAuI2kulUScKk9uwUQ==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr1350553wmc.35.1612231825785;
        Mon, 01 Feb 2021 18:10:25 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u14sm990570wmq.45.2021.02.01.18.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:10:25 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH v3 0/5] arm64: dts: meson: add support for ODROID-HC4
Date:   Tue,  2 Feb 2021 02:10:16 +0000
Message-Id: <20210202021021.11068-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes minor sort-order issues in the Amlogic bindings yaml and
dtb Makefile, then converts the existing ODROID-C4 dts into dtsi so we can
support its new sister product the ODROID-HC4.

I've also given the devices different audio card names. This is partly
cosmetic, but also because HC4 is HDMI-only while C4 can be used with
other i2c audio devices via an expansion connector so users may want to
use different alsa configs.

Patches to support the spifc chip are still being upstreamed [0] so this
will be addressed in a follow up. A WIP patch for the dts change can be
found in my amlogic-5.11.y dev branch [1].

For reference, here's dmesg from LibreELEC on 5.11-rc5 [2].

Changes since v2:
- rebase on khilman v5.12/dt64 branch

Changes since v1:
- fix ODRIOD typo in patch 3
- fix SPI-NOT size in patch 5
- add Neil's Acks/Reviews

[0] https://patchwork.ozlabs.org/project/linux-mtd/patch/20201220224314.2659-1-andreas@rammhold.de/
[1] https://github.com/chewitt/linux/commits/amlogic-5.11.y
[2] http://ix.io/2NCi

Christian Hewitt (5):
  dt-bindings: arm: amlogic: sort SM1 bindings
  arm64: dts: meson: sort Amlogic dtb Makefile
  arm64: dts: meson: convert meson-sm1-odroid-c4 to dtsi
  dt-bindings: arm: amlogic: add ODROID-HC4 bindings
  arm64: dts: meson: add initial device-tree for ODROID-HC4

 .../devicetree/bindings/arm/amlogic.yaml      |   5 +-
 arch/arm64/boot/dts/amlogic/Makefile          |   3 +-
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 427 +----------------
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts |  96 ++++
 .../boot/dts/amlogic/meson-sm1-odroid.dtsi    | 442 ++++++++++++++++++
 5 files changed, 544 insertions(+), 429 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi

-- 
2.17.1

