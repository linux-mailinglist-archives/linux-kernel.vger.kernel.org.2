Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB40033C133
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCOQFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhCOQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:05:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDE6C06174A;
        Mon, 15 Mar 2021 09:05:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dx17so67201886ejb.2;
        Mon, 15 Mar 2021 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6ePeF+4PyW890XpTxJnphJxtRk+IjNsESDaKxXPW5s=;
        b=lO5loa7V6ZroZLNK4SKOJKfcW+HgxKE3j6gyywacuaxwbJkZ/CwgplNJK04NnEjA18
         nrlJKnK1f87LuzSr7HztjpnRfOVnoQGaA9Ly5FG0Txg8Z/lrdoposj+K11k8zpiXdG40
         2Fqhq1saW4pKjjJ82BQcintbJFYWAPHQBVOvtJbGGT2kjs2RNqY5W7uM4rs3uMieMpR1
         QOzJCtv9kimOU/1ALoCnMSWqRICcoBLE4HeUtMdTEF7yKauCRwYZc0ntelO44BdBFCMm
         Ay0WIN7xhWNaK9T8CgapLEzY8IA4+yvJFfinRlkc5VzFuFyFKG4YMdsyMa64dC5LSjdR
         RtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6ePeF+4PyW890XpTxJnphJxtRk+IjNsESDaKxXPW5s=;
        b=fJon6yvjVFuXXs2i5JqIhA2gj6kSVApFdUtH6HCXFMVRRtvX9lY+cFeZyaRtVKnxab
         kiycygnByLW5gcBxnZSM545Kq0LeqlWuVCCEDUt3F6VUmxsjkx25/We+s3rSXiqzWpWY
         0swBBTFPZN+KHp/JAKBKFECLfaUzrl9FhXYrhzXnjw1kGohxKEAF/lwO8Zz6AT//LxZ9
         HNTFyVstUUfmUOecQ00o0wtWHAXLWDiMIdRMdzGU3JCYb+YUrEfj9xccca28EOqSwj0x
         GqIiI1Lbh7irbYU2Jo4I2cpuk5CygaygrLKjGlLWkXn2bOmBTlUPIP4GlVBnnU+fKxT1
         99cA==
X-Gm-Message-State: AOAM530oAvuDdLTOiBGPp8xl5dX9g9j7RjE5cQdErrO83V/xgBzQAVL0
        wqAtVo8PygBwcwZk1wEXEHI=
X-Google-Smtp-Source: ABdhPJx+AxVnAXRz21Tph4MvTJ+G4q73eMjwKLhuFa1VSayHHa9evEFac1FhP++pk3FhMHzlabpoOw==
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr24929485eja.178.1615824305184;
        Mon, 15 Mar 2021 09:05:05 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d28:c000:5c39:c910:15c8:a935])
        by smtp.gmail.com with ESMTPSA id z17sm7748510eju.27.2021.03.15.09.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:05:04 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/5] MAINTAINERS: rectify some references automatically
Date:   Mon, 15 Mar 2021 17:04:47 +0100
Message-Id: <20210315160451.7469-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210315160451.7469-1-lukas.bulwahn@gmail.com>
References: <20210315160451.7469-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some references in MAINTAINERS can be automatically rectified with
./scripts/documentation-file-ref-check --fix.

Adjust those file entries with this script.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cf10cb2b858..251e205b5444 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5794,7 +5794,7 @@ DRM DRIVER FOR ST-ERICSSON MCDE
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/display/ste,mcde.txt
+F:	Documentation/devicetree/bindings/display/ste,mcde.yaml
 F:	drivers/gpu/drm/mcde/
 
 DRM DRIVER FOR TDFX VIDEO CARDS
@@ -6069,7 +6069,7 @@ DRM DRIVERS FOR V3D
 M:	Eric Anholt <eric@anholt.net>
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.txt
+F:	Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
 F:	drivers/gpu/drm/v3d/
 F:	include/uapi/drm/v3d_drm.h
 
@@ -7211,7 +7211,7 @@ M:	Li Yang <leoyang.li@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.txt
+F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
 F:	Documentation/devicetree/bindings/soc/fsl/
 F:	drivers/soc/fsl/
 F:	include/linux/fsl/
@@ -8691,7 +8691,7 @@ M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
-F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
+F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
 F:	drivers/iio/dac/dpot-dac.c
 
 IIO ENVELOPE DETECTOR
@@ -8699,7 +8699,7 @@ M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
-F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
+F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
 F:	drivers/iio/adc/envelope-detector.c
 
 IIO MULTIPLEXER
@@ -8728,9 +8728,9 @@ IIO UNIT CONVERTER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
-F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
-F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
+F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
+F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
 F:	drivers/iio/afe/iio-rescale.c
 
 IKANOS/ADI EAGLE ADSL USB DRIVER
@@ -9329,7 +9329,7 @@ INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
+F:	Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
 F:	drivers/iio/gyro/mpu3050*
 
 IOC3 ETHERNET DRIVER
@@ -11306,7 +11306,7 @@ F:	drivers/media/platform/mtk-vpu/
 MEDIATEK MMC/SD/SDIO DRIVER
 M:	Chaotian Jing <chaotian.jing@mediatek.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/mmc/mtk-sd.txt
+F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
 F:	drivers/mmc/host/mtk-sd.c
 
 MEDIATEK MT76 WIRELESS LAN DRIVER
@@ -13222,7 +13222,7 @@ M:	Rui Miguel Silva <rmfrfs@gmail.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/i2c/ov2680.yaml
+F:	Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
 F:	drivers/media/i2c/ov2680.c
 
 OMNIVISION OV2685 SENSOR DRIVER
@@ -14317,7 +14317,7 @@ PNI RM3100 IIO DRIVER
 M:	Song Qiang <songqiang1304521@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
+F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml
 F:	drivers/iio/magnetometer/rm3100*
 
 PNP SUPPORT
@@ -15116,7 +15116,7 @@ M:	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
 M:	Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/i2c/rdacm2x-gmsl.yaml
+F:	Documentation/devicetree/bindings/media/i2c/imi,rdacm2x-gmsl.yaml
 F:	drivers/media/i2c/max9271.c
 F:	drivers/media/i2c/max9271.h
 F:	drivers/media/i2c/rdacm21.c
@@ -17324,7 +17324,7 @@ F:	drivers/spi/spi-dw*
 SYNOPSYS DESIGNWARE AXI DMAC DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
+F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
 F:	drivers/dma/dw-axi-dmac/
 
 SYNOPSYS DESIGNWARE DMAC DRIVER
@@ -17740,7 +17740,7 @@ TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
 M:	Ricardo Ribalda <ribalda@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
+F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
 F:	drivers/iio/dac/ti-dac7612.c
 
 TEXAS INSTRUMENTS DMA DRIVERS
-- 
2.17.1

