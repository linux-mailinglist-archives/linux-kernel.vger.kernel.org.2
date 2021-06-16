Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADCE3A9459
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhFPHsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbhFPHsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:48:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01135C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:46:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i13so1391211edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5L4gySf/L9PwI1gVXMV7HFUJk3EHJfZ+w+oYJkyg4OM=;
        b=gqhbflAdQcmJa6ZSrCDkBSTYltcrYeQpeWLspvfsmrGET+sob/HU5gZanF0PpRiiVp
         MrBEAocHAtTVAbBWcVVrBiw/fvBkjye7MEul/hQzQcVfNhOjC+TpsS3FMwClOzLUiyhG
         3zKmqIavgKtaDVHfVBBXt0zv5YGx7lDXv7dAnWfQpOCse6wNQBdv0rPei8aYbOMXUXnV
         vwGDJzD0FAn+P7/Ba+JILb2fgX2GfSxQaTcMwNLXJB3nLEqs6kiiuhfR2WHQVrBmkYTi
         H8rnl7EdjwC2lIPuoN89BVCC+TfgKCkFKUcUvG0G/KWlWAJ2+y6VmnbiY46pSsup4h4L
         fkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5L4gySf/L9PwI1gVXMV7HFUJk3EHJfZ+w+oYJkyg4OM=;
        b=ftt7F4bVMbwKoc1gcX+vUhQQFnMAfJ6gXI1RtUj/LUva5owYFeW/KZaLbHTWkhfglk
         fHogI7Bf9fOJ7p5ZUuV4ZEOjzgkgeEhNRCe9TZDkaU2t+v3lQsnZiEEfvKEsJqRWNq5i
         jCM3g1j3mPTci81r2wz3L+TFLmxoY1khSP59UBM+z+Y4uKafHxuJpRjphjmFfVhcgAwD
         l6vPMCIaQdo0hkEQBTU+pmxLEx8zxqzRxmISnlI7Olkgw65v9LK2HP33EAmYKZZstYKS
         gh+Ht+mZp6uvhkeVGsOrV+4Rtyp7QjUS5v69yA/RGaCpQF9PnjOc6jGg63biJD8E8XHZ
         H+Pg==
X-Gm-Message-State: AOAM530xsieps5cCV0gGCtzMW/GzXZmBUb14tG8b0tH7fKGHe0bkygRb
        +n0y42PbUldtZfDipuBFOe8=
X-Google-Smtp-Source: ABdhPJx2UjJgJCh2cipWEpjVeW69fhMWkGCwPu0xWgFNLOfBvumZPGV5OCZlQZXI6WD6/pyaAuo/Bg==
X-Received: by 2002:a05:6402:368:: with SMTP id s8mr2600499edw.129.1623829591669;
        Wed, 16 Jun 2021 00:46:31 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (ec2-44-242-66-180.us-west-2.compute.amazonaws.com. [44.242.66.180])
        by smtp.gmail.com with ESMTPSA id yd25sm657840ejb.114.2021.06.16.00.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:46:31 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 2/2] riscv: dts: unmatched: Add gpio card detect to mmc-spi-slot
Date:   Wed, 16 Jun 2021 15:46:45 +0800
Message-Id: <20210616074645.429578-2-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616074645.429578-1-bmeng.cn@gmail.com>
References: <20210616074645.429578-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

Per HiFive Unmatched schematics, the card detect signal of the
micro SD card is connected to gpio pin #15, which should be
reflected in the DT via the <gpios> property, as described in
Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt.

[1] https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index b1c3c596578f..214794363c6a 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -2,6 +2,7 @@
 /* Copyright (c) 2020 SiFive, Inc */
 
 #include "fu740-c000.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 /* Clock frequency (in Hz) of the PCB crystal for rtcclk */
@@ -228,6 +229,7 @@ mmc@0 {
 		spi-max-frequency = <20000000>;
 		voltage-ranges = <3300 3300>;
 		disable-wp;
+		gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.25.1

