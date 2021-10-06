Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63F7423998
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbhJFIVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237767AbhJFIU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633508345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1Z0CwTA88HvE8adgUt/zUodBHZgqWXZQjx5UW4xVmQg=;
        b=DRwv0HWytNlnxd6W/Ti+vF74/ymi3qWElRcwuCPH5XYiy0mJ0IIrAK+y7pmiKxo8mZAZuh
        2v+0Uoau/wsTw1ay92AyCYYH0UTz7UKClOagywHtXAnHwYYVZ+9D9Y49xJFLeqfXxvlFS3
        w2C6XHh1hPvG4Ea9AD0Z+FSRMWxRidM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-h_M06npJOoGVQUpULHi6iA-1; Wed, 06 Oct 2021 04:19:04 -0400
X-MC-Unique: h_M06npJOoGVQUpULHi6iA-1
Received: by mail-wr1-f71.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso1374695wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Z0CwTA88HvE8adgUt/zUodBHZgqWXZQjx5UW4xVmQg=;
        b=RrebE4LYOYqzfaJYT8LVqP95K9xQykTOYhRLIZcfdgwTx1JUfpEoC9crwmUFp8ZeFB
         tYYrRkFAdmjY1iImArm0p+FdLkeeOutZyBaJzyLLNcKO6IzQ1HZXYZlCLPGR8oENVmUn
         ctRYGHpPWUN4iyohcGQdrN3f2BxzcZdl3KSEtsaDeElRi2Y41GF9z2Iqcg2gJXmbCkP2
         OoUcqeLcb/5WCKPiaDWSTM5UeVOpsJbdbQJoEa5ubBhdAjqgY4mEUCnUNW5yVGMW/tt2
         GAn7F0G7JvTnvFiUpSh+ALe/j09bXmzd7P3lhJKLRus96SHjOEmTZIRLIZEn9LqaNeiR
         OQJQ==
X-Gm-Message-State: AOAM533C9LZGOcGapfLKRdknWqGAhn/vjOJYIkIcM+zp2WVwVyZMM8Rb
        sAUGTT/ef+HNq3wDYZLUBBJ58dr4CvV7caqtT3GEleNybe6LHH3QABwyl/HrSI86umphENbyUBe
        SODYhnSuHeEwqGTvZ5kO3ThHg
X-Received: by 2002:adf:a152:: with SMTP id r18mr27466217wrr.317.1633508342986;
        Wed, 06 Oct 2021 01:19:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlZcBjI3xoW62KQcu7lJsxwySyCBdR50GMsBtQBL1H0SH9HmDySRrb0zSrMW3nsswdC+lfAA==
X-Received: by 2002:adf:a152:: with SMTP id r18mr27466203wrr.317.1633508342744;
        Wed, 06 Oct 2021 01:19:02 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id y23sm4686717wmi.16.2021.10.06.01.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:19:02 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/2] bcm2835-dt-next-2021-10-06
Date:   Wed,  6 Oct 2021 10:18:48 +0200
Message-Id: <20211006081849.1434867-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2021-10-06

for you to fetch changes up to 1d71d543469cebed0c278b9b31c7a88306142121:

  arm64: dts: broadcom: Add reference to RPi CM4 IO Board (2021-10-06 09:53:36 +0200)

----------------------------------------------------------------
Stefan Wahren adds devicetree support for the Raspbery Pi Compute Module
4 and its IO board

----------------------------------------------------------------
Stefan Wahren (6):
      dt-bindings: display: bcm2835: add optional property power-domains
      ARM: dts: bcm283x-rpi: Move Wifi/BT into separate dtsi
      dt-bindings: arm: bcm2835: Add Raspberry Pi Compute Module 4
      ARM: dts: Add Raspberry Pi Compute Module 4
      ARM: dts: Add Raspberry Pi Compute Module 4 IO Board
      arm64: dts: broadcom: Add reference to RPi CM4 IO Board

 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |   1 +
 .../bindings/display/brcm,bcm2835-dsi0.yaml        |   3 +
 .../bindings/display/brcm,bcm2835-hdmi.yaml        |   3 +
 .../bindings/display/brcm,bcm2835-v3d.yaml         |   3 +
 .../bindings/display/brcm,bcm2835-vec.yaml         |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              |  38 ++----
 arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts           | 138 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi             | 113 +++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |  31 ++---
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         |  36 ++----
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  36 ++----
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  36 ++----
 arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi         |  34 +++++
 arch/arm64/boot/dts/broadcom/Makefile              |   1 +
 .../arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts |   2 +
 16 files changed, 342 insertions(+), 137 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts

