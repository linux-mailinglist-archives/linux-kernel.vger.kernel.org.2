Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3502630860E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhA2Gw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhA2GwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:52:24 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA9C061574;
        Thu, 28 Jan 2021 22:51:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g10so7738869wrx.1;
        Thu, 28 Jan 2021 22:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/LBcU80K6cUJRkfMZX4P42tI8HDwdViTAGmLyJsVozY=;
        b=LIg1qOAd1DbXlN2H3kuO0mmCBSqiZ67+kff6yZiAK+Thlv7cpxxt+Y4w5riibMERUL
         ZZrcH5ntjPXlSiWEnr3XeZMR5fIrwprJlei1OANh/bTWk/ApoEuc7BTcmtzUCZzFc+9+
         z+Q+KMTjuCWSdtkRptS7VpOav1bYynFIZLBixK3x/0lrk4gEFzfjmA+1TmiUrxPfGily
         bqo7DzSAxIyifaj05CyuuiZ18oCchevFp32jthtYbtF06IjGo4CLpoYW4HCWt/edaVxw
         bR8jRGJohxgHyKtDxGzAXken+lWd3H2UgF/rYL8lIlFkHs1YZRCU/gyfeDI923qh2dPp
         CiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/LBcU80K6cUJRkfMZX4P42tI8HDwdViTAGmLyJsVozY=;
        b=VvFO2AbOyTloM2jWIUPY/47mA/cgzX7GX65jJ64G9vG+2bjAwwvjfQ37uWUxXyGIYJ
         qM1bnpJYrV48Rb8sCRKYdl7lBZCnzeAWmyLfwkS5a9Zw61HfXtY+UlmI66YtbQFln4PJ
         vw+psd/oKhnRyJlmcdK+5KzILvM+Wx7g8eV6vNAFNJ1URD3Jrz5/WiikCgmWb+a7/xwj
         boOdQkaTZsMUhMszKj0wQaDMJt5fojfI/r71OjQtUKXxXZ1Ikn+L3h1W5vPOgLKooSJa
         PBELEfNKdJlpMfhLsbU3OEDAOxVx7tKKjIQbl194JPvJx3dISxguPIV7t/55hrU15hpF
         xkzA==
X-Gm-Message-State: AOAM531ozaLzs6eecFxg9osypegbGECkp2tk4qCf8LESvW3GquciSPlK
        9VuBC1h3OY7BflsEOzXMiYI=
X-Google-Smtp-Source: ABdhPJzQPQhHtxZspEQvTWw43z80nenAty8qZY0wOnoGwEdtkh52kqTk357K9cdhep6o8BQK/y4wzQ==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr2546333wrp.110.1611903102351;
        Thu, 28 Jan 2021 22:51:42 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b7sm11501236wrs.50.2021.01.28.22.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 22:51:41 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Subject: [PATCH 0/5] arm64: dts: meson: add support for ODROID-HC4
Date:   Fri, 29 Jan 2021 06:51:32 +0000
Message-Id: <20210129065137.5473-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes minor sort-order issues in the Amlogic bindings yaml and
dtb Makefile, then converts the existing ODROID-C2 dts into dtsi so we can
support its new sister product the ODROID-HC4.

I've also given the devices different audio card names. This is partly
cosmetic, but also because HC4 is HDMI-only while C4 can be used with
other i2c audio devices via an expansion connector so users may want to
use different alsa configs.

Patches to support the spifc chip are still being upstreamed [0] so this
will be addressed in a follow up. A WIP patch for the dts change can be
found in my amlogic-5.11.y dev branch [1].

For reference, here's dmesg from LibreELEC on 5.11-rc5 [2].

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
 .../boot/dts/amlogic/meson-sm1-odroid.dtsi    | 441 ++++++++++++++++++
 5 files changed, 543 insertions(+), 429 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi

-- 
2.17.1

