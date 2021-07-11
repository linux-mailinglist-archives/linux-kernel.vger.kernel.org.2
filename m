Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293F73C401A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 01:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhGKXrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhGKXrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 19:47:37 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BA7C0613DD;
        Sun, 11 Jul 2021 16:44:50 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id d2so7669156qvh.2;
        Sun, 11 Jul 2021 16:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+n6L5LnjkR3JjMOorSuNebIWgL0pmMvWc1cKkkewqM=;
        b=WlCPGARS3kVzY38WuLIECrBptA5EPSr8qet57xYQ4Zf5lsBmmQUCZoIa12PKoj9sNh
         hnGb/wW5zZVIlF4/07ZsviXgIb1QK2vlJrVgn6874ma2PTQ6Ut23cmvBwr+N3U7s6Hkg
         t4y0eEwV6AYyf6wqMZg4DRHc4S4cozcGT1gYgHG4q2mCMG+xGINSmVh6R3Q9L7Qwwa5q
         Qc+19rSAyS1Wx22fVdN9BkHRIvdMWSQnMGsUylqdpY5mPrcKbP4gNjJBpwoYiSDeaqtV
         BWsxYlkGcBz5k7j8+2zLoVDFSxBNVvsTdJtj34uUHiTqvC+Ucz7M61mQXaLIMgwvoUtn
         zF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+n6L5LnjkR3JjMOorSuNebIWgL0pmMvWc1cKkkewqM=;
        b=iBrNTLU6VFXVNIdtMkVGM0wqCqjbdUNksMJxH4SxnrtG7BwdmHrQbZM3V6lpP4VStw
         n/N2WB94xEgM/qNLDPNEYse/nz4HGcQIgCXBPHhJXg1hpa+pcO9LPhzSDCquWjN7Twf4
         RqV+lM2UygXm5PpGa1ki0ZTrOh4hyJUvggCZwmVNCnQM5ZqzkjFVlFVtQfpE92Lys1P+
         9SeocTUQeP1kRftldDoY7R5Bv9BhnVM0igO67WH9p87J0ph2vaDcoACrZ8iI7urIBsHg
         EZARxTRKs9BTgtorp6N2u+adqgxZp5tvlKZqt/gNBNZpl2YRdaokxxgVXQznsOshm8e0
         mg6w==
X-Gm-Message-State: AOAM530T/Z/k2evXMNuu6pbm7kh8Yeem8goIhlaWOJx0NxQzhm2GU5oi
        Fv4FdBsSrZQYGUQLbya2TSE=
X-Google-Smtp-Source: ABdhPJyBniIbRxSmH0zC//mwYMq57+X5rs8mQBMW5AfgHBQ2aJeaJNroWbx+Fht+2iiZy8QRNi935A==
X-Received: by 2002:ad4:57ac:: with SMTP id g12mr11621567qvx.32.1626047089184;
        Sun, 11 Jul 2021 16:44:49 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id e123sm2146507qkf.103.2021.07.11.16.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 16:44:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 08/13] ARM: tegra: cardhu: Correct interrupt trigger type of temperature sensor
Date:   Mon, 12 Jul 2021 02:43:58 +0300
Message-Id: <20210711234403.24691-9-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210711234403.24691-1-digetx@gmail.com>
References: <20210711234403.24691-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LM90 temperature sensor should use edge-triggered interrupt because
LM90 hardware doesn't deassert interrupt line until temperature is back
to normal state, which results in interrupt storm. Correct the interrupt
trigger type.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-cardhu.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index d9dd11569d4b..448f1397e64a 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -348,7 +348,7 @@ nct1008: temperature-sensor@4c {
 			reg = <0x4c>;
 			vcc-supply = <&sys_3v3_reg>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(CC, 2) IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <TEGRA_GPIO(CC, 2) IRQ_TYPE_EDGE_FALLING>;
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.32.0

