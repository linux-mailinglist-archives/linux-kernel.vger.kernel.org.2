Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07690373CE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 16:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhEEODO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 10:03:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54831 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhEEODI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 10:03:08 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1leI6N-0008S0-Hd
        for linux-kernel@vger.kernel.org; Wed, 05 May 2021 14:02:11 +0000
Received: by mail-qk1-f198.google.com with SMTP id g2-20020a37b6020000b02902ea40e87ecbso1175317qkf.14
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uG3IhWnYJ6fyYsVocuySQ5JKR2LBx5PqBbvNRl2SVd0=;
        b=FySNEt7cFuc0IoTMy2MHXZ+BlCdx+1n54oFRXcz7mxRgegtbm2f669eN/KtIBkE9QL
         KrasT68hTBfluLvoCxnIJG4Ot3oALC0Bwt3dmAvIddZ2yc+U/dZj1HLIIh6jjWmOjGQZ
         pRTNK9Jrs6EgTFWFyWHeUSnZgZufIvRLqeSLeo+0+A5ULAXeyAB4mwGB0LJJKD8JCPOo
         dgH9PojT0NzBB/vD2h1ZIveQYwu1tBnIBnVyuHzzq1CywPaeD+NY5LLlHgrKq+SPmKdj
         6nllaej/SrFkJvRWDifT58Q2T4HYO3NBM49/r6gXybjE+TfB0vUCz+D0LeKeyGc+sAu8
         66fQ==
X-Gm-Message-State: AOAM533MUQH7sZ9FIvg1YBmuFJ6sAWpKJiVutjIoVLYJde5Qwc10yZJK
        ONv3n56e5uP+p7rxIHAxAkMTgUQdwJEVuJ+0cnLXKVx0u7wuPEyQTgJF4ac6D5vamjgmdstzaOP
        fDiydl6F9NXPh6vMIOhwoVtbj5ETtu16x8qe9G9cZpA==
X-Received: by 2002:a0c:bdae:: with SMTP id n46mr19634793qvg.8.1620223330119;
        Wed, 05 May 2021 07:02:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvpwKt32Tux6lMKuRokRqen9fF9Fsl6hXDXet9MjMQiWuxT9uXSD7+Nhiu/bsn0sJalz7Xxw==
X-Received: by 2002:a0c:bdae:: with SMTP id n46mr19634777qvg.8.1620223329987;
        Wed, 05 May 2021 07:02:09 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id 97sm5016632qte.20.2021.05.05.07.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 07:02:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ARM: dts: exynos: replace legacy MMS114 touchscreen x/y properties in GT-N7100
Date:   Wed,  5 May 2021 09:59:38 -0400
Message-Id: <20210505135941.59898-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
References: <20210505135941.59898-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace legacy MMS114 touchscreen properties to fix dtschema warnings:

  arch/arm/boot/dts/exynos4412-n710x.dt.yaml: touchscreen@48:
    'x-size', 'y-size' do not match any of the regexes: 'pinctrl-[0-9]+'
  arch/arm/boot/dts/exynos4412-n710x.dt.yaml: touchscreen@48:
    'touchscreen-size-x' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos4412-n710x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-n710x.dts b/arch/arm/boot/dts/exynos4412-n710x.dts
index c49dbb7847b8..2c792142605c 100644
--- a/arch/arm/boot/dts/exynos4412-n710x.dts
+++ b/arch/arm/boot/dts/exynos4412-n710x.dts
@@ -50,8 +50,8 @@ touchscreen@48 {
 		reg = <0x48>;
 		interrupt-parent = <&gpm2>;
 		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		x-size = <720>;
-		y-size = <1280>;
+		touchscreen-size-x = <720>;
+		touchscreen-size-y = <1280>;
 		avdd-supply = <&ldo23_reg>;
 		vdd-supply = <&ldo24_reg>;
 	};
-- 
2.25.1

