Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516944115C8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbhITNaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:30:17 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39144
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239441AbhITNaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:30:10 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2A02640192
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632144523;
        bh=xU11jaLpUDnoKTVDhNl4Nnz5+4KkmeAKnf0UgxOYDK0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=qpLyJV7Y0LSL5eudECtLW4MNYCGwrihUPQDBdZzGXMPK2cbE93Jm3mC4Uriu9v8zp
         INKVkl29hARV0ZbmF8mdPrSRX35SHhxt543t1ooj9E60WCz3JT/Px94ZJwOztq3CkV
         v9hXY1sKcSSU22fPqQby64XhDnzWPHxRs+qBmdgCnovM9hHP0RB61HxxAypBwIs9yY
         Ud0tKFGS52FjKm4c/s8v3dekKCPFSPdS0dzFdRmGUdiaUQpxCUF7uUsMhnqiVG8URf
         AFI93K+nyfPE8VcuuaAXE1DT4xc0UEYhet/ZG/M6kY+4EROwPZCrgZa9Cq/+N8rnpe
         Q79kPZ1j5q24w==
Received: by mail-wr1-f69.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso6081527wra.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xU11jaLpUDnoKTVDhNl4Nnz5+4KkmeAKnf0UgxOYDK0=;
        b=lfYf/35ytivbf+40i6hdc8uWccoef3mxtRfuQRWo72JaPeCsMuyzilc9txSC419nmk
         rQe/2WF2q/iLYyq3HfbUboJjuKfa4+JSiVvQeZmikT3mGNkD3f9Dnu536PtGHJnooaw6
         axgRBBdAZ/P3GVAUmerOsURwuIElqVYTjX5LUDGqiepAZRxtTRElIi5WOB/OFeZDiqmI
         vcS5Wl23Be9QYQ8kX9xmvOnZ2DZgaqbT1TE2dLzmcUJdC1EUpJDkamwShJ+mvKoX7M37
         7+vwObrT4BPBO2XJzGz2Wx+oh8CutguYr3cy4zMHqXJfDDCG+TXUoDBg6zP9YtV6dQ7q
         clrg==
X-Gm-Message-State: AOAM5301LRtaIgtM5bumzseBCJaRyC9s+QIQojKKOVEBPuynK5RoaSLr
        Bqq5wgVUYMqBHey6+vc5B9JnduFTy99aFmbeayS79v6kuRntgUSY4yeBUIHmX3NIwVtx6Jja5oJ
        lOme+0QUyTHZLXT6XJpweBkqZzIsc2d8meUM6jJbOAA==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr28083260wrw.174.1632144522869;
        Mon, 20 Sep 2021 06:28:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+pvMcumgoT0ttERKgbkMAho4kf5IhwJqGeJAFaoWilhZCuHSEktQza8Pbu9In5bxiX7pNmg==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr28083236wrw.174.1632144522688;
        Mon, 20 Sep 2021 06:28:42 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id g1sm45429wmk.2.2021.09.20.06.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:28:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 5/5] riscv: dts: microchip: use vendor compatible for Cadence SD4HC
Date:   Mon, 20 Sep 2021 15:28:30 +0200
Message-Id: <20210920132830.152802-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920132830.152802-1-krzysztof.kozlowski@canonical.com>
References: <20210920132830.152802-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Licensed IP blocks should have their own vendor compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. New patch
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 55d86b078c53..7948c4249de5 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -263,7 +263,7 @@ serial3: serial@20104000 {
 		};
 
 		mmc: mmc@20008000 {
-			compatible = "cdns,sd4hc";
+			compatible = "microchip,mpfs-sd4hc", "cdns,sd4hc";
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88>;
-- 
2.30.2

