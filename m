Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9FC309066
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 00:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhA2XAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 18:00:07 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45314 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhA2W77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:59:59 -0500
Received: by mail-oi1-f177.google.com with SMTP id g69so11667608oib.12;
        Fri, 29 Jan 2021 14:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4I4cmOEDH9UFoIk1hHOuNx2NOGNnRRaA80O3qHTznLE=;
        b=Gpnetv9e2FIcdKCfciE50i/dwKyDeMjuEPMNmzB4I5MvgFkwmrCTbM6fL7+PevwxHB
         kcVSSb+EOCy7S7gsPkYlQj+PLqAOINXfotLZrHmfhOpMhDJpb+S2JpUKpzFi7rvqwqYt
         SU+nh+REaOhCD1Bvb7/uWBEfCdJrMmsBa/5Bqv+ddL/MQDlyOGbwP5W7iPoZ8j2l6K59
         M0kFRUQw8OxD8/YKN6wYe4yPqLwm5AmrPmjOSff5/fc4Oy6891Hvi1BEGyEao4etOOPG
         nvQJAMaNp9uTwKc+x4aVDhVIYuqhbVGjvofGqtWQs3Y4uKdXbD7ph0ABWG/K+xilN4hl
         +w6g==
X-Gm-Message-State: AOAM532dZwHSTaUr+M1r1G7KAQOHA72wfY9m0nEGKKZxmrWYu9ZXl8lb
        aIRfs4XZVZYTeWe7H1JnLQ==
X-Google-Smtp-Source: ABdhPJz+oVuqlk6ihtgLH0TGVJON/Ivg9BnpdFMfc+JyzcJHBU2sPwxbZWyAwtJzMh2GtTCv4BKCiQ==
X-Received: by 2002:aca:3606:: with SMTP id d6mr3959592oia.59.1611961158240;
        Fri, 29 Jan 2021 14:59:18 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o98sm2489687ota.0.2021.01.29.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:59:17 -0800 (PST)
Received: (nullmailer pid 3879724 invoked by uid 1000);
        Fri, 29 Jan 2021 22:59:15 -0000
Date:   Fri, 29 Jan 2021 16:59:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for 5.11, take 2
Message-ID: <20210129225915.GA3859663@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull some more DT fixes for 5.11.

Rob


The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.11-2

for you to fetch changes up to 32ada6b0980d86133d080d62371a5787ea2ec5ed:

  dt-bindings: Cleanup standard unit properties (2021-01-29 16:36:06 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.11, take 2:

- Cleanups on properties with standard unit suffixes

- Fix overwriting dma_range_map if there's no 'dma-ranges' property

- Fix a bug when creating a /chosen node from ARM ATAGs

- Add missing properties for TI j721e USB binding

- Several doc reference updates due to DT schema conversions

----------------------------------------------------------------
Grygorii Strashko (1):
      dt-bindings: usb: j721e: add ranges and dma-coherent props

Mauro Carvalho Chehab (4):
      ASoC: audio-graph-card: update audio-graph-card.yaml reference
      dt-bindings: display: mediatek: update mediatek,dpi.yaml reference
      dt-bindings: memory: mediatek: update mediatek,smi-larb.yaml references
      dt-bindings:iio:adc: update adc.yaml reference

Rob Herring (2):
      ARM: zImage: atags_to_fdt: Fix node names on added root nodes
      dt-bindings: Cleanup standard unit properties

Yong Wu (1):
      of/device: Update dma_range_map only when dev has valid dma-ranges

 Documentation/devicetree/bindings/arm/cpus.yaml    |  1 -
 .../devicetree/bindings/display/bridge/sii902x.txt |  2 +-
 .../bindings/display/mediatek/mediatek,disp.txt    |  4 +--
 .../devicetree/bindings/extcon/wlf,arizona.yaml    |  1 -
 .../devicetree/bindings/hwmon/adi,ltc2947.yaml     |  1 -
 .../devicetree/bindings/hwmon/baikal,bt1-pvt.yaml  |  8 ++---
 .../devicetree/bindings/hwmon/ti,tmp513.yaml       |  1 -
 .../devicetree/bindings/i2c/i2c-gpio.yaml          |  2 --
 .../bindings/i2c/snps,designware-i2c.yaml          |  3 --
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |  2 +-
 .../devicetree/bindings/iio/adc/maxim,max9611.yaml |  1 -
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |  1 -
 .../bindings/iio/adc/ti,palmas-gpadc.yaml          |  2 --
 .../devicetree/bindings/iio/dac/adi,ad5758.yaml    | 41 ++++++++++++++--------
 .../bindings/iio/health/maxim,max30100.yaml        |  1 -
 .../bindings/input/touchscreen/touchscreen.yaml    |  2 --
 .../bindings/media/mediatek-jpeg-decoder.txt       |  2 +-
 .../bindings/media/mediatek-jpeg-encoder.txt       |  2 +-
 .../devicetree/bindings/media/mediatek-mdp.txt     |  2 +-
 .../devicetree/bindings/mmc/mmc-controller.yaml    |  1 -
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.yaml |  2 --
 .../bindings/net/ethernet-controller.yaml          |  2 --
 .../devicetree/bindings/net/snps,dwmac.yaml        |  1 -
 .../devicetree/bindings/power/supply/battery.yaml  |  3 --
 .../devicetree/bindings/power/supply/bq2515x.yaml  |  1 -
 .../devicetree/bindings/regulator/dlg,da9121.yaml  |  1 -
 .../bindings/regulator/fixed-regulator.yaml        |  2 --
 Documentation/devicetree/bindings/rtc/rtc.yaml     |  2 --
 .../devicetree/bindings/serial/pl011.yaml          |  2 --
 .../devicetree/bindings/sound/sgtl5000.yaml        |  2 --
 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |  4 +++
 .../devicetree/bindings/watchdog/watchdog.yaml     |  1 -
 arch/arm/boot/compressed/atags_to_fdt.c            |  3 +-
 drivers/of/device.c                                | 10 ++++--
 34 files changed, 49 insertions(+), 67 deletions(-)
