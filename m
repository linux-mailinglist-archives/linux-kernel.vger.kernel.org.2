Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB840719B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhIJTE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIJTEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:04:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E50C061574;
        Fri, 10 Sep 2021 12:03:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z4so4013098wrr.6;
        Fri, 10 Sep 2021 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2HzZynKdGrV44/xOe+zaSu5/JFHGIIV4Z7i2+Mxb4So=;
        b=PXcww5kI0R813yeiWBw2wE4F/LSk9naoPzC626Wd5/POsg2wsFYMcT//IXfTy19CQI
         Gha1nqoD/VHFDpvh0jeItrnd9P6z7CcCDWD9xnT/2YKZEWsIrX8IhYcmhgJVLnNa3/Fj
         OeDJFxaV/gxkzivmzrYbRVWWz57oMllNVY/8+Qw3yBK43FVePed6xV2aeSynZawpFRER
         cDkljf2NbfKPw/Ov+cPc751QgEvaJ+x1K28Z0ZeaSl5EfngyvN17c7bzAT53coI3BNUT
         r0f2pKV5ssHkDXTIpRAZik9SfNsIy2n7QcWN03UqXL4MNKkKXnOsKC8YPxGLkOKEh2Us
         O5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2HzZynKdGrV44/xOe+zaSu5/JFHGIIV4Z7i2+Mxb4So=;
        b=gT/turbwXbs42UL+S2S6/C+vcnH2FiayRBH939bPoedPswNZ4gk41r/kYvYRJ+KwNE
         81mXNBRpTVbo58YBjcVernlY1HNwwi7ZPaucXuVpH0nMaExU14nuamR/8DGIE5N2LUKi
         iqM6hfP/8mjjW8jMnGimlBv6jAz/AwpeMKTSeox+vEV+pcGLE9TT6tC46gTawe3wro8x
         UxXqDkCfOrT+tEFk82dIJZXjW8/hAqc4F87MW+kBkgDT/Lv0zctfzkQAt5QJ6R4zeLLl
         xxVk4H2Y1MJxbLfz2EyDHgxC1somaB6jMX+qB32680wbsFUnDOf/ZUh7qBiqbFeN/s1r
         WWow==
X-Gm-Message-State: AOAM5335yp/PMRFaofiPneP+R3isbWpqGoOpkYrGGnr6HLUCN/R31/hj
        rDD3Aa3aDz01y5beC1yRTFP8v+5ddnY=
X-Google-Smtp-Source: ABdhPJzSGwRdaLj6Q0psVF7VMzyjHnXUukEu7xXHgUWoXVMnooA6oL29OqEyljYzK6eEpDeRL8ebYQ==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr11558258wrb.329.1631300622777;
        Fri, 10 Sep 2021 12:03:42 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id e8sm156734wrj.48.2021.09.10.12.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:03:41 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add support for IDO-SBC2D06-V1B-22W
Date:   Fri, 10 Sep 2021 21:03:18 +0200
Message-Id: <20210910190322.27058-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDO-SOM2D01 is an ultra-small SOM module based on SigmaStar SSD201/SSD202
SoC (ARM Cortex A7 core). The module integrates WIFI, NAND and PM
circuits on a PCB area of 2.95CM x 2.95CM. The SoC integrates 128 MB of
DDR3 on-chip.

IDO-SBC2D06-V1B-22W is an dual-ethernet SBC powered by a IDO-SOM2D01,
that embeds a MicroSD card slot, 4-lane MIPI DSI connector for 4-inch
RGB565 display or 7-inch RGB888 display, Dual 10/100M Ethernet ports,
and more.

This series adds support for this SOM and this boards.

Romain Perier (4):
  ARM: mstar: Mark timer with arm,cpu-registers-not-fw-configured
  ARM: dts: mstar: Add the Wireless Tag IDO-SBC2D06-V1B-22W
  dt-bindings: add vendor prefix for Wireless Tag
  MAINTAINERS: Add myself as MStar/Sigmastar Armv7 SoC maintainers

 .../devicetree/bindings/arm/mstar/mstar.yaml  |  2 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 MAINTAINERS                                   |  1 +
 arch/arm/boot/dts/Makefile                    |  1 +
 ...star-infinity2m-ssd201-som2d01-common.dtsi | 21 ++++++++++++++
 ...sd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts | 23 +++++++++++++++
 ...ity2m-ssd202d-wirelesstag-ido-som2d01.dtsi | 28 +++++++++++++++++++
 arch/arm/boot/dts/mstar-v7.dtsi               |  1 +
 8 files changed, 79 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01-common.dtsi
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi

-- 
2.33.0

