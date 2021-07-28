Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAA23D94D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhG1SBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG1SBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:01:00 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43509C061764;
        Wed, 28 Jul 2021 11:00:58 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id g6so1983059qvj.8;
        Wed, 28 Jul 2021 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vXk/J4q5mPEjnLuepFqEKq93BJsZukmkkBYD3V+Z3Tk=;
        b=beFhaZVHfk7mxGVzvlrm0rAr2p1O/09MWnJmT0ut7HVMm6/cAi3kDjr9g+wxOuPF/w
         59io64vS64AzA+1oeggt0h6Ua18feX03yXJj0NeUQlhAND2wrGoAqAaTsYoY6L9Udi3t
         6u0Z//Phpn/Y9eC+AcrxmAiZvK2d39nkFcwoXMoH1+yE13kD0GdzyCU/21wTNchokQH8
         2Kjn3hrmPGYQE0ah/xwM2u+yCSKCxXIFz4fCQjM3N5lkC+TdEfqDjsB5t/w2NqdkZjp3
         6aQF8d45sVRRAWYJ7+qUXy26mY2vadhl3SV6kOnaHs+Se2R367o5v+B68PB0wOg15qo5
         ZQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXk/J4q5mPEjnLuepFqEKq93BJsZukmkkBYD3V+Z3Tk=;
        b=aG8D7qZVT3/QcJ2NDxb156/MlH/82RLeM0k8njEs62KXsC5789rL5KzIB8UYqVjLFi
         1dTntKSiwWlx/QuSqz7aMEr4V1Olghigl6sezHB1xaPyXfMwHGJ3ih0IVZ8BCxUsA5uV
         Au95sSbJFS50cZEUtypYJ6mZle3m8mjlCbcK88HSJFS/gF5RpXkX3jXP6aPdFxmXlYHL
         3OPDyjUtpqm6vd2dDvbwZUqRyJdPBywyL+oe7sZ5hOKwkwySPvp6bSD/yVgIqhGvOCwR
         nzcJVQY1K/jpkRkSJUR7HOyAlVmztgKuRUI6y7yAtcireOiL59jxGCUoQc9TLCoCNIyn
         kU9A==
X-Gm-Message-State: AOAM5327CzqDeTL/hmaNEBLysptgnW08YvoCQC6GkOTI1Ymw8Kgn6XUe
        r838yzApdMgx/qMkBXiwfxE=
X-Google-Smtp-Source: ABdhPJxR95vQmYlTzhJ3BscYKr/cpb85sYBj4WPecIGS8wdPNanrwNCUsJga5A8c4jDPranJBAoFAw==
X-Received: by 2002:ad4:5bee:: with SMTP id k14mr1411561qvc.10.1627495257347;
        Wed, 28 Jul 2021 11:00:57 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id r5sm223341qtm.75.2021.07.28.11.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:00:57 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] arm64: dts: rockchip: fix rk3568 mbi-alias
Date:   Wed, 28 Jul 2021 14:00:27 -0400
Message-Id: <20210728180034.717953-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728180034.717953-1-pgwipeout@gmail.com>
References: <20210728180034.717953-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mbi-alias incorrectly points to 0xfd100000 when it should point to
0xfd410000.
This fixes MSIs on rk3568.

Fixes: a3adc0b9071d ("arm64: dts: rockchip: add core dtsi for RK3568
SoC")

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 322971318d5a..f7ecdfd66f86 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -195,7 +195,7 @@ gic: interrupt-controller@fd400000 {
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-controller;
 		#interrupt-cells = <3>;
-		mbi-alias = <0x0 0xfd100000>;
+		mbi-alias = <0x0 0xfd410000>;
 		mbi-ranges = <296 24>;
 		msi-controller;
 	};
-- 
2.25.1

