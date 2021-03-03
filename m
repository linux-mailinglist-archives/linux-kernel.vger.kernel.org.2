Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F1932BB98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446792AbhCCMik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842514AbhCCIGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:06:08 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2B4C0617A9;
        Wed,  3 Mar 2021 00:05:23 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q20so15699257pfu.8;
        Wed, 03 Mar 2021 00:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eEHmW1L8oXnw1xKZQFNIdptSZuFAiD16Fplx3COkLXQ=;
        b=cubLM2Xr2VUGBMoGOmJ3YozVd9/DT6cNXEFWWgdvooUPrxGaim0M81JVFgQrkcyaEb
         0vbJpLxVVvIMZyHKLNF26/vVubtXIg5iZAwQuzYtP9kKJf/kN/IF+8alBS6Ks0P39LuB
         K6yNrrKSNYV1qyyS04MsQAky/UrZ/hCVXnhQylDIVE9XSX+lCnzgBg25FJvNTW2yT/sp
         cPGbn2xxCHxqiEVlh/GtG+eFTudSWSyxKYpr4yCa6vg29uYKoqekKEi19QJqQu55mjAI
         A9dh+ZKNslsI6IuESgtBKVs/Os0geMt7E0nzcVfmLCnm5sI6MFj1Vy/gxKPi68+PB1OH
         xATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eEHmW1L8oXnw1xKZQFNIdptSZuFAiD16Fplx3COkLXQ=;
        b=gRJRx+MC/Xu2saoct7vMcxadT2MYO8WgKHJhrMzFTAMFJ4uxpBfLjrSJ0417j61cQA
         8zCu0S/xG/udqFVFCLHdhSpH14Wbxg5sqZ2CKoWeHuEr9qCAsC2zUtwOXusKxxplnrP8
         Nj+gbtNuLFd2+blVBG2rtkULypqCD5isNGhqIpeXWLAkA8TrfFI4LiJBqA/SmMX5XL4y
         qUbeQcebNV4rnMTmEg1dTDlMMz+CZzBA0J5JH4IstQVQr0s31HmCny1JyAdo5YNDyMag
         8vmRPxcIuJrwCQqGj5aE3pp21WsHwt7iaTnlsxQeJbvKZxK6IHZ0iYktap0+JGfInNK3
         QbCA==
X-Gm-Message-State: AOAM530PKaOHlDsZ/DwRuNVqpw1gJzyWLGZr768+jMnfQ81KgC5iUj2w
        gZ8ou7cvI2mxhjHtnQ2iG2w=
X-Google-Smtp-Source: ABdhPJzZQAK2wGLpeLTSbFC08npR8WI/FNiq3sq4tFPV9XT7xMDHICu2/zZNReZRDvXWluYb/4AR2w==
X-Received: by 2002:a63:e045:: with SMTP id n5mr21779245pgj.220.1614758722912;
        Wed, 03 Mar 2021 00:05:22 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm22260887pfv.84.2021.03.03.00.05.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:05:22 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH 0/8] ARM: STM32: add art-pi(stm32h750xbh6) board support
Date:   Wed,  3 Mar 2021 16:05:09 +0800
Message-Id: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset intend to add art-pi board support, this board developed
by rt-thread(https://www.rt-thread.org/).

Board resources:

8MiB QSPI flash
16MiB SPI flash
32MiB SDRAM
AP6212 wifi,bt,fm comb

sw context:
- as stm32h750 just has 128k bytes internal flash, so running a fw on
  internal flash to download u-boot/kernel to qspi flash, boot
  u-boot/kernel from qspi flash. this fw is based on rt-thread.
- kernel can be xip on qspi flash or load to sdram
- root filesystem is jffs2(created by buildroot), stored on spi flash

to support the boad, add following changes.
- fix r0-r3, r12 register restore failed after svc call, 
- add dts binding
- update yaml doc

dillon min (8):
  ARM: ARMv7-M: Fix register restore corrupt after svc call
  Documentation: arm: stm32: Add stm32h750 value line
  dt-bindings: arm: stm32: Add compatible strings for ART-PI board
  dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
  ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h75x
  ARM: dts: stm32: add stm32h750-pinctrl.dtsi
  ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
  ARM: stm32: add initial support for stm32h750

 Documentation/arm/index.rst                        |   1 +
 Documentation/arm/stm32/stm32h750-overview.rst     |  33 ++
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   4 +
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/stm32h7-pinctrl.dtsi             | 392 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           | 307 +---------------
 arch/arm/boot/dts/stm32h743.dtsi                   |  30 ++
 arch/arm/boot/dts/stm32h750-pinctrl.dtsi           |  11 +
 arch/arm/boot/dts/stm32h750.dtsi                   |   5 +
 arch/arm/boot/dts/stm32h750i-art-pi.dts            | 227 ++++++++++++
 arch/arm/mach-stm32/board-dt.c                     |   1 +
 arch/arm/mm/proc-v7m.S                             |   5 +-
 13 files changed, 716 insertions(+), 302 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst
 create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts

-- 
2.7.4

