Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478AE3E2851
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbhHFKMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244798AbhHFKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:12:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD0C061799
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:12:11 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x14so12294682edr.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=maEr7GgR6cSiBFVlKBozSqDVYrZqVGSThMPhE+brgU0=;
        b=NDCPY08xIjErW+6krceuHXAub3Wqk1f1DEYpZ4sCUFv0oz/xIN/ruEDFueVB7B4+kM
         tMOHsWaesd0sRirmkp6hfRKQmc8V3sAblEvEgakVbEp2F/lPoQEYhCxAyFGQ4QidFBDU
         EW7VP5apQPXQagfzOujWpIK8GpTqorl1WfgZEhhHBNtRvzE7WVAlN2in5/C+gXOrzdV+
         enJ7l7ahNx3RvC0bYvvFn30E6oKW/XrVPxPsbIUjbz9FfqyxS22quqr3NcrglmvA0Zxx
         8LyvmN7iODHrgidXueyAvgp9BZBpMtU/MSJ7jwKwRnMu59JBnm4TMwJbW6JnZwV/kSRX
         Pzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=maEr7GgR6cSiBFVlKBozSqDVYrZqVGSThMPhE+brgU0=;
        b=TTRhz4cQ8cW9AnCeKeI7iDo5cK63s7Muy8yqr8r60byYKdSt3gTk1ivSTZ2vXnKzKP
         5j7lTvYjPPTT23jMXsj27qOTTnrR+vc8TMzTYjmbjCigf2UgR9TyVMIZKRK3H1rbbHYv
         RSCBkPW0XnK5R9w5g4qZhYAb46DEHFqD5K8IVaco559uaaRU8vEcbfUdHJ0yrWXh5WnD
         DkabWoR+REtwcb7JrIslTaDL455Km6ULJigo/MYqUhRC5CIuOpHiFzOGjaU0aBJ9HAZS
         DI+05BCbEGIdHOU12V9i9S2HqTT5JP8JIllciSnvLuax9hXFM1bXpQFobIydhq0viA6F
         iQOw==
X-Gm-Message-State: AOAM530KAO0CoTccVrsRrDgMVisvwLmF6h2wc8n8A2v8oMYrEfwAj5Hk
        MmLINc88jBQsY/HfpTpweDtW8EbRbXYeO8cx
X-Google-Smtp-Source: ABdhPJyk27Tr8jM9KuHDtmOgXZb6SB8YwaS/1sE6FWInUmr2/ciWyqD62EQbgAkeyZXPwbzEph+s+A==
X-Received: by 2002:aa7:dbc8:: with SMTP id v8mr11654973edt.242.1628244730103;
        Fri, 06 Aug 2021 03:12:10 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id b25sm3707545edv.9.2021.08.06.03.12.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Aug 2021 03:12:09 -0700 (PDT)
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
Subject: [PATCH v3 0/2] arm64: zynqmp: Extend board description
Date:   Fri,  6 Aug 2021 12:12:06 +0200
Message-Id: <cover.1628244703.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

over years couple of drivers were upstream and it is time to sync it up.
On the top of it also adding new Kria boards which are using new overlay
infrastructure which check if that overlays can be applied to base DT file.

These two patches weren't applied the part of v2 series.
https://lore.kernel.org/linux-devicetree/cover.1623684253.git.michal.simek@xilinx.com/

Thanks,
Michal

Changes in v3:
- usb node name fix, remove undocumented properties reported by Michael Tretter
- Also remove status property from dwc3_0/1 nodes reported by Michael
  Tretter
- Move USB3 PHY properties from DWC3 node to USB node - reported by Manish
  Narani
- Fix led node name
- Fix compatible string for xlnx,zynqmp-sk-kv260-revA/Y/Z
- Fix headers alignment
- Move USB3 PHY properties from DWC3 node to USB node - reported by Manish
  Narani
- Change dtb names generated with dtbo
- Fix emmc comment style
-

Changes in v2:
- New patch in the series
- Use sugar syntax - reported by Geert
- Update copyright years
- Fix SD3.0 comment alignment
- Remove one newline from Makefile

Michal Simek (2):
  arm64: zynqmp: Enable xlnx,zynqmp-dwc3 driver for xilinx boards
  arm64: zynqmp: Add support for Xilinx Kria SOM board

 .../devicetree/bindings/arm/xilinx.yaml       |  31 ++
 arch/arm64/boot/dts/xilinx/Makefile           |  13 +
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts  | 335 ++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts  | 318 +++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 289 +++++++++++++++
 .../boot/dts/xilinx/zynqmp-smk-k26-revA.dts   |  21 ++
 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |   8 +-
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |   7 +
 .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  14 +
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  14 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |   8 +-
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |   8 +-
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |   8 +-
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |   8 +-
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |   8 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  60 +++-
 16 files changed, 1129 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts

-- 
2.32.0

