Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32D53A9193
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFPGEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhFPGEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:04:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07C4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 23:02:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u24so1038623edy.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 23:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CMUSU6K99n6eMM6v4FzWd/f27lBpf54QdzrLJZNzXWQ=;
        b=eDN7IcteeBW4ejR5DRBrsgYhQOoiuJ445WSsziNHLbmBVvdC4qCg2bt2/k5YK60zMj
         b4Wa7iPsDjhQTII9rx36auunzXxRLRvHgADrKjQOKo+RikCRxoQYJSm6V6e/i2Jc5/rV
         b0UCGqJgiI6enMqfOXw5kA20Ye45mVpQ0mGUvkrBQEEdGIge3sILbdxX0Yv1Q+zWcgBh
         0rKE6LbO3vexIRNGGiRgmFd45IpCgow3Y+YOWZ0bYEZDg7bY36cjsEmsJXe2R/6CHO2o
         Z7WgaTswPIpc5xsiAThSNuRZvoLr+6RmEN2dOgt8EducoCIaOEPO4Ff6R2fRtbngu7f8
         tH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CMUSU6K99n6eMM6v4FzWd/f27lBpf54QdzrLJZNzXWQ=;
        b=L6g87iop4EdtBmjHlscgzesjB7GPmBBzrT5PFr83G/i1+t+kCPkIVK9mNnA67hn1pm
         YE/IuOO36bsZCj7MUmArG6bBsAaWbrQtjda3XBw1AlYbDmB+po7jAng9bG70SQIC9TVC
         7E99wLC5ba8eQsv4Y0tLX6ApZxRV2uLoxqE/3qB3xszg4p9MwpG8kYiSny5raG+OM+2Q
         tdN5f0DG3xTRT0/SpvXesCsfZIKMioRNx4prODqDTiSn7EqFQtgKNVtxoupOSV+V8VMN
         nG8S/hX8Iyjb7AxaFoE0WZ7nvK5wv+NhYBI4HohPPMI+fqFgmDByW087GdFGKkwTKWmA
         nFEg==
X-Gm-Message-State: AOAM531f77//Q3mHDYRTJ8H2J6BfvTcL0+7/j1iWU7eg8+EqXPV/DX1n
        hWS8HKxZ1GTc90ZE4kTylcUWtKPyXe8=
X-Google-Smtp-Source: ABdhPJxIvbVJTmCEKtkq24sb9u/ZYB59aYl7KgDmjRTDadndL9icBjx+ZhbJBmaqMhFR1S2RZfTQwg==
X-Received: by 2002:a05:6402:49:: with SMTP id f9mr2113932edu.178.1623823353666;
        Tue, 15 Jun 2021 23:02:33 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (ec2-44-242-66-180.us-west-2.compute.amazonaws.com. [44.242.66.180])
        by smtp.gmail.com with ESMTPSA id ot30sm810474ejb.61.2021.06.15.23.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:02:33 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 1/2] riscv: dts: microchip: Drop "clock-frequency" property of cpu nodes
Date:   Wed, 16 Jun 2021 14:02:50 +0800
Message-Id: <20210616060251.398444-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

The "clock-frequency" property of cpu nodes isn't required. Drop it.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index b9819570a7d1..ee54878b3f89 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -17,7 +17,6 @@ cpus {
 		#size-cells = <0>;
 
 		cpu@0 {
-			clock-frequency = <0>;
 			compatible = "sifive,e51", "sifive,rocket0", "riscv";
 			device_type = "cpu";
 			i-cache-block-size = <64>;
@@ -35,7 +34,6 @@ cpu0_intc: interrupt-controller {
 		};
 
 		cpu@1 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -62,7 +60,6 @@ cpu1_intc: interrupt-controller {
 		};
 
 		cpu@2 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -89,7 +86,6 @@ cpu2_intc: interrupt-controller {
 		};
 
 		cpu@3 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
@@ -116,7 +112,6 @@ cpu3_intc: interrupt-controller {
 		};
 
 		cpu@4 {
-			clock-frequency = <0>;
 			compatible = "sifive,u54-mc", "sifive,rocket0", "riscv";
 			d-cache-block-size = <64>;
 			d-cache-sets = <64>;
-- 
2.25.1

