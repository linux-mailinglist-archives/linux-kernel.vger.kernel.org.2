Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D284115BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbhITNaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:30:07 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39046
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239441AbhITNaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:30:03 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 24FE540192
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632144516;
        bh=405kNu3dtB0zJ30yHuYcgVnAp+AYJ1QTK0vyYlLZaqY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=kEv/NaLwTXk8F6dfCb+oKmfosaBfM3vaSTCWnkMkLEPvT1BBPMufgoANP/1UVlPvu
         I/XRFm2IGhdT5ZPdgGlE5sVPspi3IaDayu9FA+ajWlet4LdahjRQu9ALzYoGyDliQu
         gV7hvjJ2jpfkd6vBE4v7rqH6RRd3RvpNWIA/TUztvsBYQDQm1nU/DWcnybpNXE2vkE
         rEG3DQkqwOaCZ1x2h62jHBuADywb05RARuiKDdCmdQoYwN7MKUzQEM+PciA3ZrgUF1
         StOfT9nv+qSO82CLvxzzGIdYwRSUBElygTJZYzMYbZuik+13Gv+PNkBWd1sHWv9pHN
         S8xR5qP4g0DsQ==
Received: by mail-wr1-f69.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so6075783wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=405kNu3dtB0zJ30yHuYcgVnAp+AYJ1QTK0vyYlLZaqY=;
        b=ixNZoBRs0r4SDXzt8++35Gs3kHFfn0/fLT0a+b61R93/D9HmoUItEUYEe9fbyn7tN5
         Pm5uXibc9s5FBD4k9YWAZC8taP4NVH91HSRQlwJ4uKadQ2+oHtGZ2NnhH2m0qzzPsvXN
         mMpX8TwstVU69KB20j0uOYVfAusvJFdEiYRiHx/e631cWKoMD0DqLbjW2SCbkm/kxya4
         zNe88W5o2Ypd7bT0Ch949RXyTSAyDGcbCJCa+XWofH6dJYEty2UOn7eFFpSWEUYFCFRl
         drFnZYt85gIepYAMXZB3hbmjIvL/xNnkm0CnHMtI2VtU9gmy2p/SNzJpX+iDzD6rh3zl
         6o1Q==
X-Gm-Message-State: AOAM5334uJvScut/YQK2q3hzIIga6WjuhTesUZ6DMGGTkh/a7L0Hw561
        juut1yFTaKU1o86rO8xfAs5Tv1voVx92Ab1piGJGliDPlfglGUuEz5ljGx+ueAs40qOmgfgIVD9
        /KHzXq84xwIw5h/ugrKI8DqinLs0Up/Ph14bv5xhPFQ==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr24134477wmc.19.1632144515398;
        Mon, 20 Sep 2021 06:28:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyn/S9tRY6RVjn6ynl0DulA8/tnIBG0wKbhfeCztIh58oZTCS+xiYF7PbLFUUBnXpyQ/mByIQ==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr24134462wmc.19.1632144515253;
        Mon, 20 Sep 2021 06:28:35 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id g1sm45429wmk.2.2021.09.20.06.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:28:34 -0700 (PDT)
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
Subject: [PATCH v2 1/5] riscv: dts: microchip: drop duplicated nodes
Date:   Mon, 20 Sep 2021 15:28:26 +0200
Message-Id: <20210920132830.152802-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTSI file defines soc node and address/size cells, so there is no
point in duplicating it in DTS file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index b254c60589a1..3b04ef17e8da 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -9,8 +9,6 @@
 #define RTCCLK_FREQ		1000000
 
 / {
-	#address-cells = <2>;
-	#size-cells = <2>;
 	model = "Microchip PolarFire-SoC Icicle Kit";
 	compatible = "microchip,mpfs-icicle-kit";
 
@@ -35,9 +33,6 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x40000000>;
 		clocks = <&clkcfg 26>;
 	};
-
-	soc {
-	};
 };
 
 &serial0 {
-- 
2.30.2

