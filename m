Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3EB3C2243
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhGIKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhGIKeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:34:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA91C0613DD;
        Fri,  9 Jul 2021 03:31:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id he13so15263448ejc.11;
        Fri, 09 Jul 2021 03:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AV0itCy7+VSBd3Vis/NNTVsow+Jfw/GotJ/dIEDBhVY=;
        b=anZ1nB7jMfSF/BbJg/7OUb7JRZa+f+T42NmPKrSux5SApcRiWTOl0wBIx0GPyPI7vu
         u9KfAcLV5QoM390qW2EjDO12itATk6FybnFX+ZhyFo60CrP0+snLP5r02bBeTNdWu0q1
         YkAktOcdzlJaoEfWu/1yiXZTgmGF3b1iWP2KoupKkJfBfyGxSJ2OooD5YK02fVK+0+RR
         /jbPPRtw7EIV6xizwA73xKvlHU2aRxX53pcKZwVtalwsMq11iAc7kMa5U28NRWsv0KX6
         8yrj/MlnmtHU/+n8ETvJycRDtfZ8IoZjsjwUwjb23aceU81TakIjAIyR/dmuxspREmQN
         FMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AV0itCy7+VSBd3Vis/NNTVsow+Jfw/GotJ/dIEDBhVY=;
        b=eKrT51sGlce6zjJyyWuTBuNQ/IwxwErTFUoKCny/UAkyy2wjxe6UYntGW31hAIWjEx
         zAMG+qqKIcR+UW8behJ3vO29POb04kp1GXbA6jeNYl7eSAensh0sKUpMvSGfFrOek1g6
         n0J3w2y50GU6QXxZi+OrEPbpitAtSKKQKtpBfyfUGk5L5xqK09+5u5fOgxflcg1mGGHz
         /E43+PNMHMf6CT4P9r4Y4jXOvwd98W4SGbX5guzcbOvOTvHcEER1v6Zx9NgjahXsfbla
         Sm4Vc9kt+4ChdjFqZa0N5dT9VCp1p0gM04uBYnCoVDEioHb1J3K7Y1AT6eC9ckcR001x
         w6iA==
X-Gm-Message-State: AOAM533AcHdyfTnaiOPoiR2/dtPr6Egqh75N9AR8fUnDjq2hTUXrIOae
        ODKCFaHKkfCOJa6qwd7IarM=
X-Google-Smtp-Source: ABdhPJy2WkJz4UO1xDyhUCmcuIp8rOMlK4AzxuR9rvZrefzpo11yy+9cnOmhMOhgzWDCxlQ6Lrc48Q==
X-Received: by 2002:a17:907:a04e:: with SMTP id gz14mr3062361ejc.24.1625826700118;
        Fri, 09 Jul 2021 03:31:40 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c2sm2180978ejz.73.2021.07.09.03.31.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jul 2021 03:31:39 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: rk3188: add space after &grf
Date:   Fri,  9 Jul 2021 12:31:34 +0200
Message-Id: <20210709103134.1750-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix layout by adding a space after &grf.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 793a1b911..6764776cc 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -638,7 +638,7 @@
 	power-domains = <&power RK3188_PD_GPU>;
 };
 
-&grf{
+&grf {
 	compatible = "rockchip,rk3188-grf", "syscon", "simple-mfd";
 
 	usbphy: usbphy {
-- 
2.11.0

