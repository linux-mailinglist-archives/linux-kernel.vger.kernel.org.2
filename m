Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC441C06E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbhI2IPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:15:52 -0400
Received: from egress-ip33b.ess.de.barracuda.com ([18.185.115.237]:54144 "EHLO
        egress-ip33b.ess.de.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244708AbhI2IPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:15:46 -0400
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69]) by mx-outbound23-192.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 Sep 2021 08:14:04 +0000
Received: by mail-qv1-f69.google.com with SMTP id dk6-20020a056214092600b0038289c1fc44so6786689qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fh8BHUuInQoe2F9epgF7MvMEhb7N+5ayCx0fHuFmNm8=;
        b=NZ9XqcdFjN/ho7Ut6woyOgRGX0X0ogrVLw9xsyuCo6MNyPPQw6BjEf6q4atZEFYSYi
         Pgw+rrQymMHHMYDWYdrznj3OzmxFLReFFIo08j1v0nSnwBQHoYYCJP6DMLvWzIn/bOjT
         hcDszxm/XNroap7vpygWZ2zI4V9Ejc1tFe9Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fh8BHUuInQoe2F9epgF7MvMEhb7N+5ayCx0fHuFmNm8=;
        b=DdBkBmC9F5Qg3XY5EqO8ljc7s9dMHYB9mxCxlr7bv+jydB4+UN4DluZ+ykNsDN+EeA
         ARkuNL2zAjTxZ1Vh7UeSsn8zvpjeF2vYoaxx3w1StOllQR3ctiAAq5GjcveHeLYgQJZT
         f1AGwUPvq2S+E5RvwliFmJsqgOa9/sxVV9NwVJ9g+kg9qNmosSOcU8VRK+XjRDcUYIn+
         nKcwyOefa6STGpfSHelyY5a8/CFAtRpOaJmfyP4Aei4AtqpK6PuIndisrdTff8KuYG4A
         Dcvh6gaoO3eFDplpjP/iuUxw5j7mc04da0fMq4c5+HSc2Atq5TrVfjvHPfJFtRonG3dN
         n1Qw==
X-Gm-Message-State: AOAM5319ap+GHiliRAFk1WefP8+YDW7MyH/dotzgu+ZDFO/aGMfKZ2Zb
        D1p6CB4dqpBKkB1EpppzC6Kuj1Snep7ot+QHefTwRn2keAdSmigsX6gOyryMjfcoR9slFT7qVSI
        TYTsUORr1DGSxNhVNgnULHcwW+MpbKaJqujV/hV6tLyH4Y8b1pb0l9QSut5nJ
X-Received: by 2002:a62:5e05:0:b0:44b:34af:af0d with SMTP id s5-20020a625e05000000b0044b34afaf0dmr10007804pfb.54.1632903232284;
        Wed, 29 Sep 2021 01:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+hOv2B6BbiuZ6iZaaqbuPwaOq6prHXjkKQEI/bgInuAZKqFJ5byuiC5HbTcvOxpEYibf6pQ==
X-Received: by 2002:a62:5e05:0:b0:44b:34af:af0d with SMTP id s5-20020a625e05000000b0044b34afaf0dmr10007785pfb.54.1632903232054;
        Wed, 29 Sep 2021 01:13:52 -0700 (PDT)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id k14sm1152026pji.45.2021.09.29.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 01:13:51 -0700 (PDT)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 3/4] arm64: dts: ti: k3-j721e-sk: Add IPC sub-mailbox nodes
Date:   Wed, 29 Sep 2021 13:43:32 +0530
Message-Id: <20210929081333.26454-4-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929081333.26454-1-sinthu.raja@ti.com>
References: <20210929081333.26454-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1632903243-306080-1426-21520-1
X-BESS-VER: 2019.1_20210928.1746
X-BESS-Apparent-Source-IP: 209.85.219.69
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.234800 [from 
        cloudscan12-37.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Add the sub-mailbox nodes that are used to communicate between MPU and
various remote processors present in the J721E SoCs to the J721E EAIK
board. These include the R5F remote processors in the dual-R5F cluster
(MCU_R5FSS0) in the MCU domain and the two dual-R5F clusters
(MAIN_R5FSS0 & MAIN_R5FSS1) in the MAIN domain; the two C66x DSP remote
processors and the single C71x DSP remote processor in the MAIN domain.
These sub-mailbox nodes utilize the System Mailbox clusters 0 through 4.
All the remaining mailbox clusters are currently not used on A72 core,
and are hence disabled.

The sub-mailbox nodes added match the hard-coded mailbox configuration
used within the TI RTOS IPC software packages. The R5F processor
sub-systems are assumed to be running in Split mode, so a sub-mailbox
node is used by each of the R5F cores. Only the sub-mailbox node for
the first R5F core in each cluster is used in case of a Lockstep mode
for that R5F cluster.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 129 +++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 2ca92ed12f03..7816aa9b06f0 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -727,3 +727,132 @@ &icssg1_mdio {
 &ufs_wrapper {
 	status = "disabled";
 };
+
+&mailbox0_cluster0 {
+	interrupts = <436>;
+
+	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	interrupts = <432>;
+
+	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster2 {
+	interrupts = <428>;
+
+	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster3 {
+	interrupts = <424>;
+
+	mbox_c66_0: mbox-c66-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+
+	mbox_c66_1: mbox-c66-1 {
+		ti,mbox-rx = <2 0 0>;
+		ti,mbox-tx = <3 0 0>;
+	};
+};
+
+&mailbox0_cluster4 {
+	interrupts = <420>;
+
+	mbox_c71_0: mbox-c71-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster5 {
+	status = "disabled";
+};
+
+&mailbox0_cluster6 {
+	status = "disabled";
+};
+
+&mailbox0_cluster7 {
+	status = "disabled";
+};
+
+&mailbox0_cluster8 {
+	status = "disabled";
+};
+
+&mailbox0_cluster9 {
+	status = "disabled";
+};
+
+&mailbox0_cluster10 {
+	status = "disabled";
+};
+
+&mailbox0_cluster11 {
+	status = "disabled";
+};
+
+&mcu_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+};
+
+&mcu_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
+};
+
+&main_r5fss0_core0 {
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
+};
+
+&main_r5fss0_core1 {
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
+};
+
+&main_r5fss1_core0 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
+};
+
+&main_r5fss1_core1 {
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
+};
+
+&c66_0 {
+	mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
+};
+
+&c66_1 {
+	mboxes = <&mailbox0_cluster3 &mbox_c66_1>;
+};
+
+&c71_0 {
+	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
+};
-- 
2.31.1

