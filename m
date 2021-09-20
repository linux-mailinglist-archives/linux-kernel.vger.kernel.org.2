Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7874141153B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbhITNFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:05:55 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37632
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239062AbhITNFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:05:43 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 486D840197
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632143056;
        bh=0ATfDdcwsrHvOMt7UcUsCUZb24XVeT4uIjZC4PxjuPM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VNM9nSn84DUxsbPw8KPvsn3Ycro1jz/Amakls8NDwCw39O0DTnnOFECx8UxyQ6MXN
         46taKoMVlOr66xlGpaAsZ3N/9VvAlfG8v+/c9Yn5BZrfbb56hfc1TNyxsdjBw4A+LB
         FoDLvDAaTK1WII7Tx4FW75Ijdod2rofeZ/lBlVIhq+hUynHrc7ZIIrJ3T1mxd6gWt3
         hNJTvnpDKLtKiYchX9b0q+SqLoRu9hgSQI2sZw8+z8T7dm7ER4oz4BzmLq+CiTVCcX
         DRnpK695UHH6WRyOUbECfYeJnrCeSDCBk8tp1inwWi6r2KzPZIqEWWTj78pbv31+/W
         eWEYmJVRSB89w==
Received: by mail-wr1-f71.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so6007479wrp.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ATfDdcwsrHvOMt7UcUsCUZb24XVeT4uIjZC4PxjuPM=;
        b=ERFZyD5NVNc/80+R3OCx18IzqAckzT+gebHnB0kXj9GWRUXiXhYQGkWmsppxF+4MX/
         EdGIdTnRT7IJhPwXfz0oUwcnJ1K4mWtY3I71jWPOIk0b8KdtY6mevkxCWnLouMkspQPL
         TqXbPPXY90O5px3EnASwJbTMFJm5HedTEVMliLwhvtTpS0JZ4ujRzF4BUnWrzf99V/p4
         GTqFkxZkoayV57i624pzwXdHc6eciaWDErDmcdnov64XJ/YWJ4fS2FK0gi3dhvOC/cK3
         cZylrvU+KCZYZ+Z0SDHQaCoXBwgytt/+5ykakU3zxeV22egRxhSJtu7u9FDst/dIODvQ
         oH7w==
X-Gm-Message-State: AOAM531xirzg0xVtGrIW4+BRl06/lKRep2NuqwmFot1hS007VBWb/Em0
        0ccrSQYymEZ+YXxZQ57lJf2f3ifVVn6qMSl77mdchXDNez1zYCaw+GzKl6KaqwQVe6w0KFxvpD0
        eH5X8OYY+jNx0ZiHHgRB59vqo9UXMdIjfKkyPz1zaeQ==
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr29418520wmg.19.1632143055970;
        Mon, 20 Sep 2021 06:04:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcqxuu711f17EArSGcqHrFTFt+IrQxhxwvK11lX7/O4LWkLse5Xc9k93FZpJKe13HKkvmLbA==
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr29418508wmg.19.1632143055827;
        Mon, 20 Sep 2021 06:04:15 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id 25sm22965108wmo.9.2021.09.20.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:04:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND PATCH v2 4/5] riscv: dts: microchip: add missing compatibles for clint and plic
Date:   Mon, 20 Sep 2021 15:04:11 +0200
Message-Id: <20210920130412.145231-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
References: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip Icicle kit uses SiFive E51 and U54 cores, so it looks that
also Core Local Interruptor and Platform-Level Interrupt Controller are
coming from SiFive.  Add proper compatibles to silence dtbs_check
warnings:

  clint@2000000: compatible:0: 'sifive,clint0' is not one of ['sifive,fu540-c000-clint', 'canaan,k210-clint']
  interrupt-controller@c000000: compatible:0: 'sifive,plic-1.0.0' is not one of ['sifive,fu540-c000-plic', 'canaan,k210-plic']

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---

Changes since v1:
1. None
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index b14275a9a59d..eb8b475b8611 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -161,7 +161,7 @@ cache-controller@2010000 {
 		};
 
 		clint@2000000 {
-			compatible = "sifive,clint0";
+			compatible = "sifive,fu540-c000-clint", "sifive,clint0";
 			reg = <0x0 0x2000000 0x0 0xC000>;
 			interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
 						&cpu1_intc 3 &cpu1_intc 7
@@ -172,7 +172,7 @@ &cpu3_intc 3 &cpu3_intc 7
 
 		plic: interrupt-controller@c000000 {
 			#interrupt-cells = <1>;
-			compatible = "sifive,plic-1.0.0";
+			compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xc000000 0x0 0x4000000>;
 			riscv,ndev = <186>;
 			interrupt-controller;
-- 
2.30.2

