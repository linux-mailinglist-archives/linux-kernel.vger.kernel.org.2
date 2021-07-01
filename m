Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E590D3B9380
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhGAOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhGAOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:43:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64122C061762;
        Thu,  1 Jul 2021 07:41:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l24so8762971edr.11;
        Thu, 01 Jul 2021 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T3GLhCsap0BUzc6paVqHLBwR4VLRpdgqVCUNWRfuD2U=;
        b=ogi7mio7y2TSxI/Hg2XCaWp7SVTtS6XIGftJzFKTtXA6yvkN2HYgt6PDAbDtukReuj
         84WwNepjogw5hQSIyC1hKVx9kdYsAtHkKNOuK/Qh/l9mHlv+4jOBGiNAsUkv5X8sOTBN
         bp5x68CCGIkCyjW8GR+VG807pKg4rZaD9wvqc/IElICU/2TRasOERpL+I7ckONLWZ9PQ
         nCD3E+WO3N2+J4GQUy027m/E+k+5PgMjcR21Bki/ykQ2NShtCeQEt+4aI0w4/6GCMBOg
         iOcptA9EszbCjzdFiI862YW+pB817agUuc404JyVPVui7Sv+QD9JrFYLNojRUOAV/QwJ
         G3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T3GLhCsap0BUzc6paVqHLBwR4VLRpdgqVCUNWRfuD2U=;
        b=etyaI093jzKJjZsUK8cHIY6A+iWUYeQAYfLUaDOwwRLT8zSeP6sCHpqPrivPCtvlvL
         GMkxd1FLdVylEpJhUOaR1UFdEHjiR3qTD8XoXeGJt4SEPKoIzqToSrstDidLprFWzeAV
         JcQaMgGliZ82D9zBixm/PVI5T4xyGdrAVEBBf3JD1rP+YP1DcQFV9ZclkJ+GadHx4PWJ
         WcCzPIERAoOS2icI91iSMTQzdLYUPN7+9F6IMZTeOQkxpe4aW9sqG8XlHAjPB5Y/tg4S
         bSa97AN8CJrHCWhzs/ayjyznoEHGMlr/DNNAx9/fMSin/Ca+YOlgOZUnZklQTkVI6PL6
         ECvw==
X-Gm-Message-State: AOAM530pMxqdFZ1jA3wlflxVk3U2aWJNbt04EcWjPs6XF0Nf9PrpTkP4
        e/NS1cYGrs1MXuYc14wnRnmhcE5odvwVDA==
X-Google-Smtp-Source: ABdhPJw66fAiNBJHazuNQgB9F0NZpfrVEg++UK5mV8IPGX+OCm40VYiiM0EvzzHHCNExdHu5Qm7ulg==
X-Received: by 2002:a05:6402:42d2:: with SMTP id i18mr247472edc.168.1625150478611;
        Thu, 01 Jul 2021 07:41:18 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a8sm2239ejx.99.2021.07.01.07.41.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jul 2021 07:41:17 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: remove clock_in_out from gmac2phy node in rk3318-a95x-z2.dts
Date:   Thu,  1 Jul 2021 16:41:09 +0200
Message-Id: <20210701144110.12333-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently a clock_in_out property was added to the gmac2phy node
in rk3328.dtsi, so now the clock_in_out in rk3318-a95x-z2.dts
can be removed.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index 763cf9b46..d41f786b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -185,7 +185,6 @@
 	assigned-clock-parents = <&cru SCLK_MAC2PHY_SRC>;
 	assigned-clock-rate = <50000000>;
 	assigned-clocks = <&cru SCLK_MAC2PHY>;
-	clock_in_out = "output";
 	status = "okay";
 };
 
-- 
2.11.0

