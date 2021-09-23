Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577DC4158A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239398AbhIWG5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239575AbhIWG5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:57:37 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92473C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:56:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w8so5385560pgf.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XIKVEVR9ngOApxIauMcedMo5bAKnEat3dJvEEYTYX9E=;
        b=oTLHTBmGe8Uq4dRTXPjbF/iUqseitufL4LrPPCXdfzXv++lW6GKAdm/qXJSu9PhR/4
         vxGkf/bYtL/L44u27DGWl/0J/zMrTVHkRPgEhBdmraSqbSEzSiWRHPyVRHFtinGMjd7m
         Y49lvHEt4Fam5KNDhUHcHBhUjU2V7CWqpMdx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIKVEVR9ngOApxIauMcedMo5bAKnEat3dJvEEYTYX9E=;
        b=UVRhSVszBHb0bWsJG6SSEatlx5yyuxzUNTTmvPuRNTfd+WWkzAh+j3XzBgTEM4AOlN
         JrMdI/U8kRI+T6GAm3f0EaJmNSAzu6lIZTJNJ0MaLOw2Hf7S10+xkkx4V92KmrPGywco
         EEs7MsnqqTkBWsvybM5fcbcHFr1jOZ2knkb6/O5WZGC05VFpomscRohKTK22mNurTuSz
         uxtd6eSp5YLzA5fZlnYezxY6p6C//SyOjL1YgwHEaxnh0ccGqIvRH0oLfmVC6stkqG/X
         uddOFXn44vyWa/EomWyCYCLgXu0eN2kayVWZOwP9kV6Ifzu3OfSKyIjjv3MnGTcT9XkY
         KCgw==
X-Gm-Message-State: AOAM533OduCPmSu7PoMk5/mAA9uIPd4wfBwHwbXqoQFmZX0XyK+TiMoP
        3OidBpEyt1HsE8hNj/EoY8fZXR88lTNhCA==
X-Google-Smtp-Source: ABdhPJxpBVJRnSaWCmyE1GjYOSk0GxxBgW528b7UpNdPs8PIJls8zDyNi1GrKtuNgu4UjSob6ux3vA==
X-Received: by 2002:a63:8f06:: with SMTP id n6mr2752602pgd.315.1632380166119;
        Wed, 22 Sep 2021 23:56:06 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id e12sm1581888pgv.82.2021.09.22.23.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 23:56:05 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, pavel@ucw.cz,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 10/11] ARM: dts: mstar: unitv2: Add DRAM regulator
Date:   Thu, 23 Sep 2021 15:54:59 +0900
Message-Id: <20210923065500.2284347-11-daniel@0x0f.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923065500.2284347-1-daniel@0x0f.com>
References: <20210923065500.2284347-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a fixed regulator for the DRAM voltage.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
index 19289d5b2a9b..ec8da9cc8cb2 100644
--- a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
@@ -48,6 +48,14 @@ reg_vcc_io: regulator-vcc-io {
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 	};
+
+	reg_vcc_dram: regulator-vcc-dram {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_dram";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-boot-on;
+	};
 };
 
 &pm_uart {
-- 
2.33.0

