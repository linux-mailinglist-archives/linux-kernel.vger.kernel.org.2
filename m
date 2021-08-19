Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A293F1C53
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhHSPMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbhHSPMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:12:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046FCC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:12:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r7so9731313wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5fuKx796Elw77gjwAl8zSUCyFS8ubJYZz/EESfgpkks=;
        b=yJO+jMFUHCHJyCh9Zu40TaUlUDaMmBDwvj6GBQ5q50P79oWOYEdyNpawb3tXW2vj/z
         DNDwKA1kERRV4sFALw7q4B+eIHB9W0uAUI4UQT4nKyHTJ4HxggF05nBG32WgnRHI4hHz
         GSZuIy1M61HsgU1IZwAkH78cpaMLJEcjOAm02QVu+HScUOkVgDIhfMfJdeDHeyzFtpth
         8uWrVpmv004XMwHmWy0zyJOVKGSK3WXMx3a8wgsP0avywV5rNzXDAaT0O3yM3+sakDNb
         ifH07P/3cHXavrfVgGWJ4pH4oYS8NlWeypmvN4syL1o0U6/c1x9c3jItYf3jTMQWNAyv
         FBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5fuKx796Elw77gjwAl8zSUCyFS8ubJYZz/EESfgpkks=;
        b=HePRQiG949Ida6Qk6XiZY4qaHiq/ztssS2BteYkWImjYyJJ3CLzL+L4bDccd/4ZvSw
         pR1DUCmOlQfxAW2+/ag2kzDrLjmiPU4FwcgANjyP9LlQQor0G0P0owpsEEE6Uvcg8pFf
         d2cuvlAEx7pk1v1lwukbQ71YOqi9P5vYWLZ+deuXO5/uWpfzOI+tR7MqXw0OWFECpkZQ
         HcPO8Mf8YLL2SjxfnlHLqsfFvBdMhFBIgQAcsubPKutlcGTFxAYxUgyI7/AsdVCZp7rO
         SxQ9BrpJFPtOLf/EyM5msXAvGGGo8CUmx72JQ1Og/VOZyLMeQiG7XABx6KnD/fhVZkSM
         DQ2Q==
X-Gm-Message-State: AOAM531Y2X4Otdg1H/iwL3ql5hy1GvYuHCd9CFkUAc+wuti3PVTp9opf
        hJc/JVr539wq5Tf2AJNOd0O1nw==
X-Google-Smtp-Source: ABdhPJz4GjMnmtkXigDTLZBtL+MRkj19w1VdlfTSBix8abrDJ1TrXre8hr9XFACVNZy95wL68RZRmA==
X-Received: by 2002:adf:d085:: with SMTP id y5mr4549112wrh.209.1629385922579;
        Thu, 19 Aug 2021 08:12:02 -0700 (PDT)
Received: from alex-xps13.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j37sm1556962wms.39.2021.08.19.08.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:12:01 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org
Cc:     matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, gpain@baylibre.com,
        khilman@baylibre.com, Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 0/4]  Add support of mt8183 APU
Date:   Thu, 19 Aug 2021 17:13:36 +0200
Message-Id: <20210819151340.741565-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Mediatek's SoC have an Accelerated Processing Unit.
This adds support of the one available in the mt8183
(aswell some derivative SoC).

This v3 attempt to handle memory differently.
In the v2, the memory was reserved in dts and all dma allocation made by
remoteproc was using it. Since we may load many firmwares with different size,
this could lead to a memory waste or out of memory issues.
In addition, the APU itself expect the memory to mapped at a specific address.
The firmware, because of many hardware / software limitations use hardcoded
address.
To simplify memory management of userspace application, kernel and firmware,
and to rmeove a couple of hacks, we changed the way to manage the memory.
With the v3, only the virtio memory (that won't never change) is reserved
in the dts. The firmware declare resource similar to the CARVOUT_RSC 
that used by this driver to allocate and map the memory using the IOMMU.
I am not sure that the best solution but the simplest one I found so far.

Changes in v3:
- Remove IOMMU hack. Instead, manage the IOMMU directly from the driver
- Update the device tree bindings: only use reserved memory for virtio.
  All the other memory allocation will be done using DMA API.
  This sould simplify the memory management.
- Add more comments
Changes in v2:
- Drop the workarounds needed to load bad firmwares
- There are many name for the APU (most common one is VPU).
  Rename many functions and dts nodes to be more consistent.
- Use the bulk clock API, and enable / disable clock at a better place
- add few comments explaining how to start the APU
- update the way to use pinctl for JTAG
- fix some minors issues
- fix device tree bindings

Alexandre Bailon (4):
  dt bindings: remoteproc: Add bindings for MT8183 APU
  remoteproc: Add a remoteproc driver for the MT8183's APU
  remoteproc: mtk_vpu_rproc: Add support of JTAG
  ARM64: mt8183: Add support of APU to mt8183

 .../bindings/remoteproc/mtk,apu.yaml          | 118 ++++
 .../boot/dts/mediatek/mt8183-pumpkin.dts      |  48 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  40 ++
 drivers/remoteproc/Kconfig                    |  19 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_apu.c                  | 590 ++++++++++++++++++
 6 files changed, 816 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
 create mode 100644 drivers/remoteproc/mtk_apu.c

-- 
2.31.1

