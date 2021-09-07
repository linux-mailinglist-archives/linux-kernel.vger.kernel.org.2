Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A35402697
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbhIGJ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhIGJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:57:44 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404A5C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 02:56:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57352DDABF;
        Tue,  7 Sep 2021 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1631008594; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=8Qdhec2HP5e1kbDrVuNHeouRztb+b5XkYB2iQ283/Bc=;
        b=duPXLB5gEQLiMxAmjdg8Doi3UOzjtjKAcsss0Xe850LM5exQLGQ+5+foR2LMmJHrdoWW+r
        tY9h9sTuGgGrj6wAVAbCjmzeES/vfFDJOaqnG9MQEeVZ8kcoYb18lkPAQtevtYH9wLhV/e
        CPNmmXW3QnZp21PRN5oP+6h0Qt345QRipV6qCFo7O7wiZdbw2IrvaZO453QMtHoiiKQJ8S
        s9TVXxHATXxJPs01kEYtwPKZxcpPbJRL5bgRtrcYjTd7J4xY7FzKxNaEgmkd6ELZBXuFhY
        il00KXGRNqMo/GDG2/cEdAEJJbOET+OJeDX2LYbOHuavDdxi1G8PS73/L5Sohg==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] arm64: meson: add support for JetHub D1/H1
Date:   Tue,  7 Sep 2021 12:56:00 +0300
Message-Id: <20210907095603.1520109-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new home automation devices.

JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation controller with the following features:
- DIN Rail Mounting
- Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz
- no video out
- 512Mb/1GB LPDDR4
- 8/16GB eMMC flash
- 1 x USB 2.0
- 1 x 10/100Mbps ethernet
- WiFi / Bluetooth AMPAK AP6255 (Broadcom BCM43455) IEEE 802.11a/b/g/n/ac, Bluetooth 4.2.
- TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power and Zigbee 3.0 support.
- 2 x gpio LEDS
- GPIO user Button
- 1 x 1-Wire
- 2 x RS-485
- 4 x dry contact digital GPIO inputs
- 3 x relay GPIO outputs
- DC source with a voltage of 9 to 56 V / Passive POE

JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation controller with the following features:
- square plastic case
- Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz
- no video out
- 1GB LPDDR4
- 8/16GB eMMC flash
- 2 x USB 2.0
- 1 x 10/100Mbps ethernet
- WiFi / Bluetooth RTL8822CS IEEE 802.11a/b/g/n/ac, Bluetooth 5.0.
- TI CC2538 + CC2592 Zigbee Wireless Module with up to 20dBm output power and Zigbee 3.0 support.
- MicroSD 2.x/3.x/4.x DS/HS cards.      
- 1 x gpio LED
- ADC user Button
- DC source 5V microUSB

Changes from v3:
- add pinctrl for spicc1 in meson-axg-jethome-jethub-j100.dts

Changes from v2:
- add new vendor to vendor-prefixes
- sync board compatible dt-bindings to jethome,jethub-*
- fix efuse fields
- fix gpio-line-names
- fix spaces and blank lines
- recheck via checkpatch
 
Changes from v1:
- rearrange patches
- add SPDX license and copyright header
- remove attributes without bindings
- small fixes with spaces

Vyacheslav Bocharov (4):
  dt-bindings: arm: amlogic: add bindings for Jethub D1/H1
  dt-bindings: vendor-prefixes: add jethome prefix
  arm64: dts: meson-gxl: add support for JetHub H1
  arm64: dts: meson-axg: add support for JetHub D1

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../amlogic/meson-axg-jethome-jethub-j100.dts | 356 ++++++++++++++++++
 .../meson-gxl-s905w-jethome-jethub-j80.dts    | 241 ++++++++++++
 5 files changed, 603 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts

-- 
2.30.2

