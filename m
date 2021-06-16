Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FFA3A923F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFPG32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhFPG3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:25 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 23:27:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ce15so1922831ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 23:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kowIMZQ6qVgiuTZOJNVb1LHky3tzdkwgBTNUCmfeCA=;
        b=IVQy9+VurB3pTo0F55g+gDZYGtgRnY3cZ9LtWQV6vuC1p0C+W7d3alWq5abY7+9x8f
         uJ5MNjY4skEqMtS4/Z+waHETfRZlhmbop9Dq7dq/BLnZOxTUcTC91XwcWC/nW4GGjrxN
         0+ksRhprEoYZ5VgZdVYYn1oaPGwIVo7jVHwkpkxICm6O6xGYYSMmwxY14aGgoisHkx+k
         qzIccUmDkpiM7QINTiDgOf3bDdzuY4217hBeQIV19RTKnLp/HVufzLvc2J61u2eN03DJ
         CcVHkVICdYMWNkixVRpke2hjddt/0gM5WgnDTS/Z9Iy6rgXFwObiulPThV5uVIm7MWtH
         n8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+kowIMZQ6qVgiuTZOJNVb1LHky3tzdkwgBTNUCmfeCA=;
        b=pg9OjBTL428Yi6bd4KjNJSEUWyp/Al8mef8jiF37iUXXxdzp2AJqe3YGplGvtgkXcu
         Zt0KesjFiIYzpXO3byF2eNifoGiCnPdmWUTH9L9+JoFCiA/1MjD5rNpQk7DzzgpMbvDg
         oGvDdvo+RImSdFe7mb7pCOgbFRxzJNJC7Pipsoij5VnGtu+I4YfUFG+rbbrVfziuIvIE
         FXzPp149q/u5AlUD659WHfx14uehtuj/irCcl4DgSUeQ3Rop2Wt90oq2Y4IjF96dqVt+
         zDWniP5F+l32k9CofgKKUkE1MYmlIYSLhUK9xp/WNXWnntKKKlvWJHqGpnckxtmUJPcw
         IZOg==
X-Gm-Message-State: AOAM5307OU3jCDwPm6WoiVVqR4iJhCYsiSfws3bz9L0MV2iyjNy+eLfd
        iYs5EoKIN0OuMgWm/o7UDRw=
X-Google-Smtp-Source: ABdhPJwW5j3oBNhV/+UvzHR9Xrvr6sMshJZwuZCmm0479skkF9wfS1sgALCiSJ8J02rU3EDVUoAo5g==
X-Received: by 2002:a17:906:7950:: with SMTP id l16mr3594476ejo.120.1623824838006;
        Tue, 15 Jun 2021 23:27:18 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (ec2-44-242-66-180.us-west-2.compute.amazonaws.com. [44.242.66.180])
        by smtp.gmail.com with ESMTPSA id dn7sm428872edb.29.2021.06.15.23.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:27:17 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH] riscv: dts: microchip: Define hart clocks
Date:   Wed, 16 Jun 2021 14:27:39 +0800
Message-Id: <20210616062739.398790-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

Declare that each hart in the DT is clocked by <&clkcfg 0>.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---
Similar to https://patchwork.kernel.org/project/linux-riscv/patch/1592308864-30205-3-git-send-email-yash.shah@sifive.com/,
this adds the same <clock> property to PolarFire SoC CPU nodes so that we can
calculate the running frequency of the hart.

 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index a00d9dc560d3..0659068b62f7 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -24,6 +24,7 @@ cpu@0 {
 			i-cache-size = <16384>;
 			reg = <0>;
 			riscv,isa = "rv64imac";
+			clocks = <&clkcfg 0>;
 			status = "disabled";
 
 			cpu0_intc: interrupt-controller {
@@ -50,6 +51,7 @@ cpu@1 {
 			reg = <1>;
 			riscv,isa = "rv64imafdc";
 			tlb-split;
+			clocks = <&clkcfg 0>;
 			status = "okay";
 
 			cpu1_intc: interrupt-controller {
@@ -76,6 +78,7 @@ cpu@2 {
 			reg = <2>;
 			riscv,isa = "rv64imafdc";
 			tlb-split;
+			clocks = <&clkcfg 0>;
 			status = "okay";
 
 			cpu2_intc: interrupt-controller {
@@ -102,6 +105,7 @@ cpu@3 {
 			reg = <3>;
 			riscv,isa = "rv64imafdc";
 			tlb-split;
+			clocks = <&clkcfg 0>;
 			status = "okay";
 
 			cpu3_intc: interrupt-controller {
@@ -128,6 +132,7 @@ cpu@4 {
 			reg = <4>;
 			riscv,isa = "rv64imafdc";
 			tlb-split;
+			clocks = <&clkcfg 0>;
 			status = "okay";
 			cpu4_intc: interrupt-controller {
 				#interrupt-cells = <1>;
-- 
2.25.1

