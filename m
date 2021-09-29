Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B309441C068
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244615AbhI2IPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:15:46 -0400
Received: from egress-ip33a.ess.de.barracuda.com ([18.185.115.192]:38100 "EHLO
        egress-ip33a.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244524AbhI2IPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:15:40 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197]) by mx-outbound11-76.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 Sep 2021 08:13:56 +0000
Received: by mail-pl1-f197.google.com with SMTP id n2-20020a1709026a8200b0013e2253d774so883146plk.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 01:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCkhqC8f/n95orai+QOQsJrJloASjkEjLiHcFYdwic8=;
        b=kpAPS/ZNjeK/yA48lLJ4G1i05D3HawQXqyejH3gQi1Yqa/ab9j/rf/ja+yRbiyUWTf
         vN3kXj4J6tG4rcvFSw6L7Kg5hP8BUwfmLkLcP0ITDbaOVP+QJT9wlmzADh1WKSxvaWJj
         V/hs0qhfQol0CQ/hlqJgWoGkddIyxsI8AdC00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GCkhqC8f/n95orai+QOQsJrJloASjkEjLiHcFYdwic8=;
        b=hWHI5rD7BWZLDAaZxemN6iBUvLRHZKQ1D20uTPUOQduNgcytiX9NHZa51Gov4Wt8Xc
         WSthW4aSaC/DoiqRogkFnHE+9zVO+dIvj+Z9PwxJjUmKyo9oM3sCLMxEbq2mzLnSItma
         qaqAOkLNLRliLF1IREb8BUvqsahfhuJSDsJ1Qz8iV7V/mJzQcTQk4/qp+JMqsg9xSchw
         7jPqDXu2nuvmkwqfvUNLKob7bxkurELbCm8xLVC2/y9wOi1a1SkVN3mITv4OvJGdQ7t/
         OKgEzReT11C7s0yrPEuwH905ZekgKit9NmVSp/oacgiIU31zuQklcP7rqhdnqKQ67TBc
         qftw==
X-Gm-Message-State: AOAM532JZ7oJ4D0u+PjgLmieB1mqkQVMXiW/oQKh8/SHRU8M4iodTsAg
        xt/09CJrnJ6vz/L7MwX1h72s34wBZBgWhV2ZmnqBy2FcwC1geoIfQUuY1prNB0ELA6zqii3pS2J
        90SY2MNgpb4tR5rc3WCHg29Xtj52xwAtRtrFgVWU6WkjJvaPOWQYpLm1IjH3U
X-Received: by 2002:aa7:82ce:0:b0:44b:436b:b171 with SMTP id f14-20020aa782ce000000b0044b436bb171mr2103575pfn.21.1632903235238;
        Wed, 29 Sep 2021 01:13:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4yfWXtVv9xyy4yPj06w0kfeDerpfVwhmc185e1yBjxC5hDPb11qWVmKk7cyTidjrjsX5m+g==
X-Received: by 2002:aa7:82ce:0:b0:44b:436b:b171 with SMTP id f14-20020aa782ce000000b0044b436bb171mr2103563pfn.21.1632903234994;
        Wed, 29 Sep 2021 01:13:54 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id k14sm1152026pji.45.2021.09.29.01.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 01:13:54 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 4/4] arm64: dts: ti: k3-j721e-sk: Add DDR carveout memory nodes
Date:   Wed, 29 Sep 2021 13:43:33 +0530
Message-Id: <20210929081333.26454-5-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929081333.26454-1-sinthu.raja@ti.com>
References: <20210929081333.26454-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1632903235-302892-1133-19177-1
X-BESS-VER: 2019.1_20210928.1746
X-BESS-Apparent-Source-IP: 209.85.214.197
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234800 [from 
        cloudscan11-115.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Two carveout reserved memory nodes each have been added for each of the
other remote processors devices within the MAIN domain on the TI J721E
SK boards. These nodes are assigned to the respective rproc device nodes
as well. The first region will be used as the DMA pool for the rproc
devices, and the second region will furnish the static carveout regions
for the firmware memory.

An additional reserved memory node is also added to reserve a portion of
the DDR memory to be used for performing inter-processor communication
between all the remote processors running RTOS or baremetal firmwares.
8 MB of memory is reserved for this purpose, and this accounts for all
the vrings and vring buffers between all the possible pairs of remote
processors.

The current carveout addresses and sizes are defined statically for each
rproc device. The R5F processors do not have an MMU, and as such require
the exact memory used by the firmwares to be set-aside. The C71x DSP
processor does support a MMU called CMMU, but is not currently supported
and as such requires the exact memory used by the firmware to be
set-aside. The firmware images do not require any RSC_CARVEOUT entries
in their resource tables to allocate the memory for firmware memory
segments

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---

The following new warnings are introduced. Please refer to the ongoing discussion [1]

arch/arm64/boot/dts/ti/k3-j721e-sk.dt.yaml:0:0:
/reserved-memory/r5f-dma-memory@a0000000: failed to match any schema
with compatible: ['shared-dma-pool']
arch/arm64/boot/dts/ti/k3-j721e-sk.dt.yaml:0:0:
/reserved-memory/r5f-memory@a0100000: failed to match any schema with
compatible: ['shared-dma-pool']
arch/arm64/boot/dts/ti/k3-j721e-sk.dt.yaml:0:0:
/reserved-memory/r5f-dma-memory@a1000000: failed to match any schema
with compatible: ['shared-dma-pool']
arch/arm64/boot/dts/ti/k3-j721e-sk.dt.yaml:0:0:
/reserved-memory/r5f-memory@a1100000: failed to match any schema with
compatible: ['shared-dma-pool']
arch/arm64/boot/dts/ti/k3-j721e-sk.dt.yaml:0:0:
/reserved-memory/r5f-dma-memory@a2000000: failed to match any schema
with compatible: ['shared-dma-pool']

[1] https://lore.kernel.org/linux-devicetree/20210423163234.3651547-2-thierry.reding@gmail.com/

 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 144 +++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 7816aa9b06f0..b726310d867c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -28,6 +28,132 @@ memory@80000000 {
 		      <0x00000008 0x80000000 0x00000000 0x80000000>;
 	};
 
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0000000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa0100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1000000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa1100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_dma_memory_region: r5f-dma-memory@a2000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core0_memory_region: r5f-memory@a2100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa2100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_dma_memory_region: r5f-dma-memory@a3000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss0_core1_memory_region: r5f-memory@a3100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa3100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_dma_memory_region: r5f-dma-memory@a4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core0_memory_region: r5f-memory@a4100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa4100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_dma_memory_region: r5f-dma-memory@a5000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa5000000 0x00 0x100000>;
+			no-map;
+		};
+
+		main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa5100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa6000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c66_0_memory_region: c66-memory@a6100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa6100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa7000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c66_1_memory_region: c66-memory@a7100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa7100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		c71_0_dma_memory_region: c71-dma-memory@a8000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa8000000 0x00 0x100000>;
+			no-map;
+		};
+
+		c71_0_memory_region: c71-memory@a8100000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0xa8100000 0x00 0xf00000>;
+			no-map;
+		};
+
+		rtos_ipc_memory_region: ipc-memories@aa000000 {
+			reg = <0x00 0xaa000000 0x00 0x01c00000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+
 	vusb_main: fixedregulator-vusb-main5v0 {
 		/* USB MAIN INPUT 5V DC */
 		compatible = "regulator-fixed";
@@ -823,36 +949,54 @@ &mailbox0_cluster11 {
 
 &mcu_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
 };
 
 &mcu_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
+	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
+			<&mcu_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
+	memory-region = <&main_r5fss0_core0_dma_memory_region>,
+			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
+	memory-region = <&main_r5fss0_core1_dma_memory_region>,
+			<&main_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss1_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
+	memory-region = <&main_r5fss1_core0_dma_memory_region>,
+			<&main_r5fss1_core0_memory_region>;
 };
 
 &main_r5fss1_core1 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
+	memory-region = <&main_r5fss1_core1_dma_memory_region>,
+			<&main_r5fss1_core1_memory_region>;
 };
 
 &c66_0 {
 	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
+	memory-region = <&c66_0_dma_memory_region>,
+			<&c66_0_memory_region>;
 };
 
 &c66_1 {
 	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
+	memory-region = <&c66_1_dma_memory_region>,
+			<&c66_1_memory_region>;
 };
 
 &c71_0 {
 	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+	memory-region = <&c71_0_dma_memory_region>,
+			<&c71_0_memory_region>;
 };
-- 
2.31.1

