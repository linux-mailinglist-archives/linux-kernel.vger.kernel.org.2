Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D223708F0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 22:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhEAUgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhEAUgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 16:36:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DE6C06138B;
        Sat,  1 May 2021 13:35:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a4so2177328ejk.1;
        Sat, 01 May 2021 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lihGSNM/MK5Li+Q6R5o1M4YyP4+yQiLVtLIt/qjFJZU=;
        b=ej1YiTxIsXvvThZwJuqr06opWozes8XB1/NByI6RR22UWOOVRGjqifemJ6ZkZ6OrqW
         CnwSbQZ2ylaCgsUOh77Mo2Xg80pYQMM5RSRHp8g90hhSGqKj9A3CDBjFnS9kTtA6NUpz
         PGFoWfOhquZajkxt6cqbPwfw3GPSoO0KU+R4OdEttjRKi6RIlcLcXXEkjerpibKzUoBY
         4sT8Y7AHq0IrKBy2S8ylhwGDyoAXonIT8ORpwNNHByMb/QsdhTlwqNrWcy4eo3Cm2z0W
         kLQqh/FUvHxtNHcUUg3rJw1ppoSZHcP1uudIR/uU4E7dRhZ9WGsN7r/132yCCmtdk3Aq
         lfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lihGSNM/MK5Li+Q6R5o1M4YyP4+yQiLVtLIt/qjFJZU=;
        b=qtmyRabdC3YOJ6R/eNtvM+VNaJcvP9Hf6dItJNtSj7ETOre6aYGDFC4Awzta8Yx10R
         SAxrsT1nXQiqBJcxI8gPRgJ0ibnJYJ9nmp2ucCYc6/xXhyBJzbg1e8xbpVhK/zCkTzC8
         dgo6bwiiTbQKM25AH/jxMPbd5fkDUV5T3FhKzPWRxQOUzEayDCjJhXS7rNOp6UyRmiAx
         03/jQl3ObIk8uXamAVOGogphWVaVjZ9VWEEEqaPea1kxJy1wq0GjsUPxtccYjSDZSiBK
         Y7tCBOW6lSRKPPRX5CUByATSVjWYdDIOVeq+2VasX7AVbsDyc3qtZ6QLNgyC+ikpuS5y
         hWIA==
X-Gm-Message-State: AOAM531jwOC8eam1earoXbVzUnUHRccUJ8PiOcvdwHE5PH2MUgCx6xW1
        jRT77wRRHulI8m31/vycxHg=
X-Google-Smtp-Source: ABdhPJxH69sLzo2KS4iHxStQmHaYmLrWsQBPfikpwxpVjaAYl0ljwzCmShI0ddrv5Lt/zD/SBpYANg==
X-Received: by 2002:a17:906:994f:: with SMTP id zm15mr8213057ejb.24.1619901331279;
        Sat, 01 May 2021 13:35:31 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 9sm6607544ejv.73.2021.05.01.13.35.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 May 2021 13:35:31 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     cl@rock-chips.com, jay.xu@rock-chips.com, david.wu@rock-chips.com,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        shawn.lin@rock-chips.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: dts: rockchip: add grf register compatible for rk3066/rk3188
Date:   Sat,  1 May 2021 22:35:20 +0200
Message-Id: <20210501203520.5465-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210501203520.5465-1-jbx6244@gmail.com>
References: <20210501203520.5465-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of syscon.yaml minItems for compatibles
was set to 2. Current Rockchip rk3xxx.dtsi file only uses "syscon"
for the grf registers. Add "rockchip,rk3066-grf", "syscon"
compatible for rk3066/rk3188 to reduce notifications produced with:

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 755c946f1..c34bc59c9 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -256,7 +256,7 @@
 	};
 
 	grf: grf@20008000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-grf", "syscon";
 		reg = <0x20008000 0x200>;
 	};
 
-- 
2.11.0

