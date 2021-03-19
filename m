Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C12341B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCSLGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCSLFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:05:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFE2C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:05:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so8658927wrc.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4/chfQtIv4nkYAhw823ZDxPsTY3OzuaLkKHNmOeT7jY=;
        b=Vzo9kEvKSFjCgF3u/xU/KHGfVl2K/vlYFQAD38/teB0a4LANjjXp/zZWeg7HEyfnRP
         2ncamnZAptv1u18sshdQmfkpLO70SorzlfQDcqlImCIqdvuUKjpki69jFQKUkq/H9sCo
         pfvNvOA+ldgHbgyJEEnIillJNT2t6yXp4zGDc/Os9Nsp/hj7cgvsRs7adqZQkamIjUg3
         J2kaIwVvyJnBrL15jO218e6JV5Wah0VB1XdF1n1Wr+nuBd0rIHNktYgVkQ+IByzGRhUQ
         AP/wxv5fiysZ7PTGzmP4gSTkJQS50hDGcjiL3sdLbkFWkroJfz4r9bcfWwgwTbITO/Va
         hhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4/chfQtIv4nkYAhw823ZDxPsTY3OzuaLkKHNmOeT7jY=;
        b=DBkrCy4PT7R0/FO1htlfVem9qjhjh13vbJ1qUwa1H+PD7GlMCsErp4fJkxvY9/piRm
         GM7NTWBbETtYhA5vZBy/l6QC4AUsG+CZbiGrDPpdkYQNugCSkCKG0CnTI534oYYQaWCs
         39DJWfcnTUPY4lxc59RBr9wUSdMpdUu3B/AoXInBceidJ7HjNxUZT/L3oKgtprb6bvk4
         b+SZ4lyess6rz0EF3SjSJ2BEEy11jEnWo+3BdQszDRPLSI3AkbS50fKHg/RzwQffOiGP
         nWSS8gUxn+a+YYpP+V6wTGrHDlbb8q4yqlNxNGSRgIslAVjJQdvrdAPuN6o9vsdlX940
         23PA==
X-Gm-Message-State: AOAM531QGTB3CLi3DKcmOAqI2UYEi59TBNy90Zb86qUkvO3LJghPFsMf
        M56msIy7Xf+bzrCHH8plaGK3Aw==
X-Google-Smtp-Source: ABdhPJxjEFbBmaa3JKCf17wA3LZKsE8ujdZs700Nr3q83zpiD4R/NgKRFxXRqcSK3AVITKnZ1R0B/g==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr3886879wru.357.1616151939819;
        Fri, 19 Mar 2021 04:05:39 -0700 (PDT)
Received: from localhost.localdomain ([82.142.18.100])
        by smtp.gmail.com with ESMTPSA id y205sm7232314wmc.18.2021.03.19.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:05:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     heiko@sntech.de
Cc:     Rob Herring <robh+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dt: rockchip: rk3399: Add dynamic power coefficient for GPU
Date:   Fri, 19 Mar 2021 12:05:09 +0100
Message-Id: <20210319110511.24787-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTPM framework is looking for upstream SoC candidates to share the
power numbers.

We can see around different numbers but the one which seems to be
consistent with the initial post for the values on the CPUs can be
found in the patch https://lore.kernel.org/patchwork/patch/810159/

I don't know the precision of this value but it is better than
nothing.

Hopefully, one day SoC vendors will be more generous with the power
numbers at least for the SoC which are from the previous generation
and give the community the opportunity to develop power based
frameworks.
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index edbbf35fe19e..1ab1d293d2e9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1933,6 +1933,7 @@
 		interrupt-names = "job", "mmu", "gpu";
 		clocks = <&cru ACLK_GPU>;
 		#cooling-cells = <2>;
+		dynamic-power-coefficient = <977>;
 		power-domains = <&power RK3399_PD_GPU>;
 		status = "disabled";
 	};
-- 
2.17.1

