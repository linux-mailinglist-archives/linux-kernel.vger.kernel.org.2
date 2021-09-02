Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5C73FEE79
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345280AbhIBNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345116AbhIBNNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:47 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288DCC0611F9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:12:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEDECD3640;
        Thu,  2 Sep 2021 13:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1630587934; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=t8TneaoYCHTNIRmLtxHMXnuiqhp7/czEBn5tMAa0iNk=;
        b=pW3fbxiTg/4bASMKuTRq/D0WRanSjPholF8emyOhXz+3LSgGuSL9kQH9s0yuRyzPkX32zg
        n8z05IU1VUROCrReJgz84Z45FwUYDGfxfg9LoxBo0XbIrNekOAt1i7llZtk1ibKwkD5CWB
        i2xkKAxe9WEKzLvtgQn8+PULIKcPwF+Df3+bliyHKLn8EAjQVB5LSNfhE4RngqGW659puY
        9glgZXHmFG7Q6z/uvI8fewrJG4WhZE58/NLDQkIq4FcHAMZo3XFecXljwbhjMOOxGASG5w
        HZevzmOuxpLCD+7kZnHL6bD2mKismesMtQEZaZeGMXNF4hX00yhs7sIqVgM9MQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: meson-axg: meson-gxl: add support for JetHub D1/H1
Date:   Thu,  2 Sep 2021 16:05:13 +0300
Message-Id: <20210902130516.3892452-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I want to add support for new home automation devices.

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

Vyacheslav Bocharov (3):
  arm64: dts: meson-gxl: add support for JetHub H1
  arm64: dts: meson-axg: add support for JetHub D1
  dt-bindings: arm: amlogic: add bindings for JetHome Jethud D1/H1

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../amlogic/meson-axg-jethome-jethub-j100.dts | 439 ++++++++++++++++++
 .../meson-gxl-s905w-jethome-jethub-j80.dts    | 325 +++++++++++++
 4 files changed, 768 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts

-- 
2.30.2

