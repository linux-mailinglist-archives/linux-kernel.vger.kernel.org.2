Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCBC3A9194
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhFPGEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhFPGEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:04:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E35C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 23:02:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id nd37so1839831ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 23:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmUZFQiKZAjt3d7qJZzBsR6hutNnEwcefr5tWqFFkuo=;
        b=cNBdmWxkePEVOxU4GERyfW7MCTkzvtfBJblvz+kQkALBJRfbl1uPPBrUdTX+iDyxyd
         d0nEMtstHBL39SbNSkLBPyRqWKSrbX/LbSimF8p7LO3fHbcWip7YHWwiPLxeY1meqfl0
         klcq6W4c/WR/KmTfIRON+T6MOvtCdveG+NTukNx14XbQV3cOZCAtUD3RGhnrimzxdaey
         NrjpMOuYQbg7Y2a6Xj+LgK707xT3ClTGnuMAvi5iTHkQSmOVHOOHjtzZZ+PI5cvr9HZ/
         +RUpkxV/itCKp5LykdWdZgt+bp4pz0kVboyeVMkycs5CuUs7Gt0WuSt5bjj7hHJP70VO
         vpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmUZFQiKZAjt3d7qJZzBsR6hutNnEwcefr5tWqFFkuo=;
        b=mJRKXkZbiK/0kt5iZ4yC61qqjQZ2WH96JADaDieCkE2FANA0jeBW3H461Rsgg/2j2n
         fwno/fyw4Gs9OMKYa5AOKWStgWm7JRBhTCJlILIe0wbtdMCFpZKtn8GZxT+aO1e1/fNY
         r3Bm8rgTVvH9sskKorvxdRxxY8IDXJko/qijAYtHKL4XkpkzNNV7Be/NILBbwPaumuCy
         H2qW9uTb3hxWllx3PhlO35r1iJFLLuzl1ggFOxzY2HjxkEgE3z9SKtuqMiCxyfXe5YZn
         9iEoaAUKL2gqIhSLgqDFhHN9d/MgEoYNhFHpNz4Qj6g6hjTY+4Bn7FlvZ8fqbmp7RpQ/
         zQMg==
X-Gm-Message-State: AOAM533oZF2X54TQfb+noYUme/vy+8aLmxkHUi7fAGeTO9lliF6a8Gkk
        p4TtimTaKj+k3EvvGvTjGE8=
X-Google-Smtp-Source: ABdhPJz8f65f1DFxLdRl6kc6uEgMgLBoCFxF66MEh/Tj3iwnV3NUK5Azu7L4uj5Uj8IcYog8SKNDkw==
X-Received: by 2002:a17:906:2e81:: with SMTP id o1mr3530816eji.446.1623823358242;
        Tue, 15 Jun 2021 23:02:38 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (ec2-44-242-66-180.us-west-2.compute.amazonaws.com. [44.242.66.180])
        by smtp.gmail.com with ESMTPSA id ot30sm810474ejb.61.2021.06.15.23.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:02:37 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 2/2] riscv: dts: microchip: Fix wrong interrupt numbers of DMA
Date:   Wed, 16 Jun 2021 14:02:51 +0800
Message-Id: <20210616060251.398444-2-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616060251.398444-1-bmeng.cn@gmail.com>
References: <20210616060251.398444-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

Per chapter 5.2.2, interrupt sources in the PolarFire MSS doc [1],
the correct interrupt numbers for DMA are <5,6,...,12>.

[1] https://www.microsemi.com/document-portal/doc_download/
    1245725-polarfire-soc-fpga-mss-technical-reference-manual

Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index ee54878b3f89..a00d9dc560d3 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -182,7 +182,7 @@ dma@3000000 {
 			compatible = "sifive,fu540-c000-pdma";
 			reg = <0x0 0x3000000 0x0 0x8000>;
 			interrupt-parent = <&plic>;
-			interrupts = <23 24 25 26 27 28 29 30>;
+			interrupts = <5 6 7 8 9 10 11 12>;
 			#dma-cells = <1>;
 		};
 
-- 
2.25.1

