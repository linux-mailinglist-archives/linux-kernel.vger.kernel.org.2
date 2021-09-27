Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6963419496
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbhI0Mwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:52:34 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46066
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234436AbhI0Mw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:52:29 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A3C614079D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747050;
        bh=fg5AL23aTrFGgdddnLfZwpvVHS8H57YnvdUfy7tZi0s=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LU8opipw0oFRXrF7ujUYUfXWp/tG3hxHE/krscOVPQwhgbCAHWo7r3ZSk8HUUWybN
         Jwc4CkjMnn2nJVLme9HUIJReuLurmYdfKHGM5IxznE6a/6LYtvJvUoveLpwr5UF8ZZ
         0I3CHIOqhtqE2WtRz5n1TZezQM21bxvnM/uWnRupmZXGWOnn+oJIztRkdYSt+WzOj7
         PxpdgpZmhkbI2km3S00lj8+6qtWs2bj9LH4c/fgaTwVNPLx0Q76f/W/b5j6hp9r5Ca
         5lLhTXAyzPjXnjssUryiAbUw7oh15fAMJgyxou74u55Pn3T/K3HuLi9TZtYd1wqObH
         eqFjiEbqiCsAQ==
Received: by mail-lf1-f71.google.com with SMTP id s28-20020a056512203c00b003f42015e912so15751115lfs.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fg5AL23aTrFGgdddnLfZwpvVHS8H57YnvdUfy7tZi0s=;
        b=0wK9Hg888Yfl6DuitSlT3uF3Me9Lvn4LLx8ERuwU/X1IIN1hKuzLvRE1V0IFgtpdLp
         cL4XZoISaSQWxnJU0I5Oq9U/NiXtgioArLjec/HRvjyVkbMoM/8TQSIGXbp9K3zNnx1v
         Ukj5Dxj8YVVl+bxEIFLQg1+qEma7xHdoxHQ5Mp6jAnEpoz+yjzPjeSHIrD0ZXhWtCtZ9
         m83GzhVayuPRVHHcqehfw3iYiKQzCzicYNaqtwvOyV6sTyoyDTKEhSZoyro2ckBmDf58
         uIdNif6t5Kyu+Y7xXIo4FYfMtIL3AfEMZjLdOhWnV8Ljf0O1+oGQsDyIleXDj65NzlE9
         upEA==
X-Gm-Message-State: AOAM530ZByqIJ3lYgLv8yIzcgMnpOvF3v4ulmgbn0I/8+4bh1yqVpxn7
        B/FyiHWoLSt3yiknXHnzM+W/kkwaS9jv35JpP0rl9tV9kwZdZmTjNFD3kVRx3Ml2R97IyRplXt7
        WJUSPoOLrUvgl3qp5h/g2nA/6j0XARqd8CJmbUmy3VA==
X-Received: by 2002:a05:651c:290:: with SMTP id b16mr29935201ljo.178.1632747050066;
        Mon, 27 Sep 2021 05:50:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/5dTX/1Af1ajiS9j9gLC6Bz4Td8g8uT1FEsyWbZSka03MXx5jiPjSYFk+SSYjibvpBFNOdQ==
X-Received: by 2002:a05:651c:290:: with SMTP id b16mr29935186ljo.178.1632747049901;
        Mon, 27 Sep 2021 05:50:49 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 2/6] riscv: dts: microchip: drop duplicated nodes
Date:   Mon, 27 Sep 2021 14:50:40 +0200
Message-Id: <20210927125044.20046-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTSI file defines soc node and address/size cells, so there is no
point in duplicating it in DTS file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
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

