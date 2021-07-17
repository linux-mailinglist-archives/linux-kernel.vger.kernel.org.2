Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4EE3CC14C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 06:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhGQFA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 01:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhGQFAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 01:00:00 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04BDC061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:57:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 70so8675407pgh.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aku1qg6OU3VkZACTqq4vmZlt3chbHGMWW4QZeLwZZSg=;
        b=LcLL+C8eYZbYhw3JvlqOoeJEnqeODIylf+XTnwmmiZoBUYvnSsDWXCGLbG0S8ObCJB
         qfLNtHF2CbsYJ81RQdU8FyMlXysFfOk4C5KC33Mymo8n3gymMXdVbL50yX4WQBYRbcqC
         lKM1L5C6k3aNQm21Rj45+e4tVfLNCVQcRiFuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aku1qg6OU3VkZACTqq4vmZlt3chbHGMWW4QZeLwZZSg=;
        b=NuG6VlNp1yeRfOgIjW/rBxnWK24xHYzKc2JgUJTVNbbk9aMPgTw8ca1c4lEeStlAoC
         gZwUkqY+3MsT/M1QnGRY13POgGy2gFS6RXjeqnFj85IXN4j/7L/j5RsgBm9ZQKCcVBER
         5bJ6/oKT6ctGj1H8v+ZzPRZ6zGWoSaVj7wZiL9e8GhcOLIVW5it2A3/G6gaVemnK2l/e
         ekaWjfYFMgeNzvWMJ/T3k3czKdoHs7uqPvxjO70o9gQTwaMjVxMK2lr18oMQEt5a4/gV
         J6HV81xOGWmgaTiBRTfaD5oYBy9P/X667VZRVeQykUz5gu6B9xiLjwW0N8tFWHGIJsjD
         NF7w==
X-Gm-Message-State: AOAM530jnWR6TE5LzPpX4hWaU9nkQCCa6s8U+n/NnvbC6jdvCRbcLYwD
        DaL64NtBNraTgBYbt+CpuDCmHg==
X-Google-Smtp-Source: ABdhPJzLNjYppEScm4RrRKehVCzQIjY8SJ+2kzxPrP/Ozjyy/0VsyL0iMuEFoVBYVGerEj9wOF8R0g==
X-Received: by 2002:a63:f64d:: with SMTP id u13mr13502036pgj.156.1626497823375;
        Fri, 16 Jul 2021 21:57:03 -0700 (PDT)
Received: from shiro.work (p866038-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.60.38])
        by smtp.googlemail.com with ESMTPSA id w2sm12522885pjf.2.2021.07.16.21.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 21:57:03 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 09/10] ARM: dts: mstar: unitv2: Add DRAM regulator
Date:   Sat, 17 Jul 2021 13:56:26 +0900
Message-Id: <20210717045627.1739959-10-daniel@0x0f.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717045627.1739959-1-daniel@0x0f.com>
References: <20210717045627.1739959-1-daniel@0x0f.com>
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
index 314eb37d3be4..648751a1b27e 100644
--- a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
@@ -48,6 +48,14 @@ vcc_io: regulator@1 {
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 	};
+
+	vcc_dram: regulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_dram";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-boot-on;
+	};
 };
 
 &pm_uart {
-- 
2.32.0

