Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7E43CC14B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 06:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhGQFAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 01:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhGQE76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 00:59:58 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BDEC061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:57:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d12so12023859pgd.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ui/R1U5l18hTCdlid6Ebs6NC2kv3Eus6s2OeRFbkggQ=;
        b=M3Job59J4FMxogVCzqxuA9l7bcCRG88yvg7g84YKnqUdBepNOkTn4a6BBNd3iE6gPl
         AIYATL5ep6ERsyMTBwQ+8/MiSv1qlwDl+XgnifDeB4XweAIosjb3Njc1IgMhTuLwTaX2
         DjWwNH8X75Aai0HBj8L4iIW+czdj/qDipUaHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ui/R1U5l18hTCdlid6Ebs6NC2kv3Eus6s2OeRFbkggQ=;
        b=p6SbgFRWljM339Txr8NlSsBvLtLW6HL8WNd2albYrn1FhWlyto+UfcqDiU0EQPENaU
         rF/DNxMIjfXuifDlNzNPx78NC65YH76CJwQ5Tp2blv3nzfQVEUJl6RHYqvpt3I+TkHhL
         IEoXt5pYGIMkJuzDGJWNFmAgdnVn27JO/DBxEENmdO0auVtGpXSMSq2Ols/UCX/Smji7
         Vm7BrHBb2twcTHD/PAo8GHIPDHtkAhj1z3CTLq7h86aiG+W0eF7i772XjNnZ0pGyM5pc
         GI1+nhi0bfLTpQJFHQT9h4AKIScOhwntie6GaoIjGVOcs3w8CLXsO1YhTkSm1MlCYD9e
         aKcQ==
X-Gm-Message-State: AOAM531j2H7aeBHmjgqIuQzNx+r7iXorMzy+clKqZH87L7RfqZ/ljgxO
        yp1u17ywe0pDKzQQwGdQvaB8WQ==
X-Google-Smtp-Source: ABdhPJygKPBQmyujuMeB5sbOzlu/tuUJQXYPb+lFjw7HhEPaF8ZO+94Mqw/NeeciMC9BVKaKsC6HUQ==
X-Received: by 2002:a65:6243:: with SMTP id q3mr13446911pgv.297.1626497821027;
        Fri, 16 Jul 2021 21:57:01 -0700 (PDT)
Received: from shiro.work (p866038-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.60.38])
        by smtp.googlemail.com with ESMTPSA id w2sm12522885pjf.2.2021.07.16.21.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 21:57:00 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 08/10] ARM: dts: mstar: unitv2: Add io regulator
Date:   Sat, 17 Jul 2021 13:56:25 +0900
Message-Id: <20210717045627.1739959-9-daniel@0x0f.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717045627.1739959-1-daniel@0x0f.com>
References: <20210717045627.1739959-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a fixed regulator for the io voltage.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
index 4a22b82afbfd..314eb37d3be4 100644
--- a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
@@ -40,6 +40,14 @@ vcc_core: regulator@0 {
 		regulator-max-microvolt = <900000>;
 		regulator-boot-on;
 	};
+
+	vcc_io: regulator@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_io";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
 };
 
 &pm_uart {
-- 
2.32.0

