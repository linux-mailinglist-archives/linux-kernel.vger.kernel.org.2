Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C8E3A133F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbhFILsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:35 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45938 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbhFILsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:16 -0400
Received: by mail-wr1-f50.google.com with SMTP id z8so25086295wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QgOUMBoD2zHHBI9ZOziOCGCk3PiF9PAVdOusqqA2H5c=;
        b=MxwbXvLfJeQeadiihQsxpj6gB1PQ5Eg//HJbzovHCbK8Y6jN6ip5aqY4t9UECx//q2
         +GSTD1+dJMA7Qb9KKI41Ka1tfrZPrPMB973rW7LdPYddB5KryDnd6EN17WWzpZqAIPL2
         nwimvXZooimkCCyrEBYxEqmWhhTPwKn5FVyhTmCU4CNvu2EgWw2AXuT+72t1FISYuFN/
         OpFlEvDyeeeqNwIHYz2DwcumzDb8adYq88eO5ew5E8X7T5QNZ3ZUErOzRhrZStgSIPto
         orh1GQ/d04Kn3zJYh5jsQEarcIkcHlUcjUPFZ9/lq4enIOqzheA+9zfEq8FLPgBVdGHP
         Owgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QgOUMBoD2zHHBI9ZOziOCGCk3PiF9PAVdOusqqA2H5c=;
        b=oijvQe3BZZRNxT4F8TK+AJ2AKPkIBPcif8eSsMIgn7JK4Fz2HqQekDrUHvqY0kPGp2
         almX/3MMFEl3T0D6G9pUwLDlGpMNZLwXNnP+mQKDICqTSyZbdO3QktZqyCtFy5raehz4
         aInAcbo3DsXNtcje+YiNpBauUzTtyvdX3kuwSAjQtFgAhZcBc4MX4UOeoz7gHqV10l/l
         tYpIC5EAB3lGtPt7sitACcJS6F1G7F5ZUKnfyP9TxHI4LKQv4PKssxlFXaj4GAKKvCWO
         Ck9lNvKCn+KHfdb7QnlHwQ5Ksric2kqvBuqiOUKymInICo/8aB6GTJgTxqbQQGazLBii
         3Wvg==
X-Gm-Message-State: AOAM532ySqJxlRW/pZKd3nH4aMAL2oulfKTSrC6nTjumW0goaYWdZ33Z
        ne15q25VEJdUTxJFzLDlMP2fS6eD/DMkWo+E
X-Google-Smtp-Source: ABdhPJx2mxpQJsVKZeBKQmDWMjZMpTZPoyRgggkbBlMzDAJm0EbuveUBAeE4YPv80pNerWTmg7eAIw==
X-Received: by 2002:a5d:5984:: with SMTP id n4mr13887948wri.294.1623239120594;
        Wed, 09 Jun 2021 04:45:20 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id f14sm4953696wri.16.2021.06.09.04.45.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:19 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Walle <michael@walle.cc>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/31] arm64: zynqmp: Extend board description
Date:   Wed,  9 Jun 2021 13:44:36 +0200
Message-Id: <cover.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

over years couple of drivers were upstream and it is time to sync it up.
On the top of it also adding new Kria boards which are using new overlay
infrastructure which check if that overlays can be applied to base DT file.

Thanks,
Michal


Amit Kumar Mahapatra (1):
  arm64: zynqmp: Do not duplicate flash partition label property

Michal Simek (27):
  arm64: zynqmp: Disable CCI by default
  arm64: zynqmp: Enable fpd_dma for zcu104 platforms
  arm64: zynqmp: Fix irps5401 device nodes
  arm64: zynqmp: Add pinctrl description for all boards
  arm64: zynqmp: Correct zcu111 psgtr description
  arm64: zynqmp: Wire psgtr for zc1751-xm015
  arm64: zynqmp: Correct psgtr description for zcu100-revC
  arm64: zynqmp: Add phy description for usb3.0
  arm64: zynqmp: Disable WP on zcu111
  arm64: zynqmp: Add missing mio-bank properties to dc1 and dc5
  arm64: zynqmp: Wire DP and DPDMA for dc1/dc4
  arm64: zynqmp: Enable nand driver for dc2 and dc3
  arm64: zynqmp: Remove additional newline
  arm64: zynqmp: Move clock node to zynqmp-clk-ccf.dtsi
  arm64: zynqmp: Add nvmem alises for eeproms
  arm64: zynqmp: List reset property for ethernet phy
  arm64: zynqmp: Remove can aliases from zc1751
  arm64: zynqmp: Move DP nodes to the end of file on zcu106
  arm64: zynqmp: Add note about UHS mode on some boards
  arm64: zynqmp: Remove information about dma clock on zcu106
  arm64: zynqmp: Wire qspi on multiple boards
  arm64: zynqmp: Move rtc to different location on zcu104-revA
  arm64: zynqmp: Add reset description for sata
  arm64: zynqmp: Sync psgtr node location with zcu104-revA
  arm64: zynqmp: Remove description for 8T49N287 and si5382 chips
  arm64: zynqmp: Add support for zcu102-rev1.1 board
  arm64: zynqmp: Add support for Xilinx Kria SOM board

Mounika Grace Akula (1):
  arm64: zynqmp: Add reset-on-timeout to all boards and modify default
    timeout value

Srinivas Neeli (1):
  arm64: zynqmp: Update rtc calibration value

Stefano Stabellini (1):
  arm64: zynqmp: Add missing SMID for pcie to zynqmp.dtsi

 .../devicetree/bindings/arm/xilinx.yaml       |  32 ++
 arch/arm64/boot/dts/xilinx/Makefile           |  12 +
 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  13 +-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts  | 371 ++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts  | 351 +++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 289 ++++++++++++++
 .../boot/dts/xilinx/zynqmp-smk-k26-revA.dts   |  21 +
 .../boot/dts/xilinx/zynqmp-zc1232-revA.dts    |  16 +-
 .../boot/dts/xilinx/zynqmp-zc1254-revA.dts    |  16 +-
 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    | 289 +++++++++++++-
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 335 +++++++++++++++-
 .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |   9 +-
 .../dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |  24 +-
 .../dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    | 330 +++++++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 254 +++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts  |  15 +
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 315 ++++++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    |   3 +-
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 286 +++++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 244 +++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 335 +++++++++++++++-
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 269 ++++++++++++-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  29 +-
 23 files changed, 3776 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts

-- 
2.31.1

