Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE9245F09D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378159AbhKZP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346814AbhKZPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:24:45 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690A3C0613F8;
        Fri, 26 Nov 2021 07:17:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso7011442wmr.5;
        Fri, 26 Nov 2021 07:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ro5SqmCGondsXlAprqzMwpniqGQJH9OZ58tKVX0KLtE=;
        b=phTINQX2amsyXW3CSkOyU0ikEKZ1p+s37IA3fythVMHfQIvFhW4vW3he6e9xInurOM
         6aRO8GJ2ZIFVZam7U8SoYhDpQAboFoZo14KjkTmB7SOT4VlXJAkYMX6YhjSp1ssg5st5
         bQO7i0JHnLFQRGfZoxFaAGWBwf4FDAmZ0fDWOrhEWMddP46l5Ld15yRkQ7pWdHWzwLrR
         EjKmWvO0/r9AWyU2+o20qZXOIDByWQepheEReIfQQv1Si4kb7h/WKtmMsoaBNaf+ni5p
         gLpvAwRjMf2yukOs5aP42UkRd5CTgEPBP8htzG2yfv6KtET5bGdlVSswLJYLpz8VtAWm
         vPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ro5SqmCGondsXlAprqzMwpniqGQJH9OZ58tKVX0KLtE=;
        b=EjxwlK69LgaMmPvYlWlUI2Poder8L8mmJzlprsUc34MhJy+QaTvprcqrygUMMhRB5g
         taeRtqn8rZejnhLVdZfBjo6Uk5s3Cm9ZfQHlvK54CdhMIXgisSkxEQSlnkl0AKVS96r5
         CY7LU2tTceHj0vF+X7qV1I80xmM9yp84QPhq9Im0IXlCuTBSr8NBQPtQ62kDRiQjJbTd
         c4/IL5C6p+sMaQ/qkx9UHXmMFXuz2LvkVE4Z7HOB/KzY4Es+Lo+40ka9fO1jaz8vWeev
         bu/LnI+/L+Zw0GvOUx3tjzruwPxNWR5iMVCA7Wbmvjg24sBALqyFBDW2x/b5GJlp6LkY
         p3nQ==
X-Gm-Message-State: AOAM5309UjF7dY3IF0oIbvooxIdww+sb4xemkgGOXS/jR12qDrmP21wO
        7jk6KykF4d0PgE3nBJgKyGK7NkRw0uLt
X-Google-Smtp-Source: ABdhPJyLUFmAZh7GZuQQShSOigym12Jf1vfsK/sn4ByDN84S+7wHs3MocHGrnG4VPil7PieiRBiDig==
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr15928669wmk.172.1637939861058;
        Fri, 26 Nov 2021 07:17:41 -0800 (PST)
Received: from alex-ThinkPad-E480.. (ip5b435a69.dynamic.kabel-deutschland.de. [91.67.90.105])
        by smtp.googlemail.com with ESMTPSA id k187sm12323496wme.0.2021.11.26.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 07:17:40 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 3/4] arm64: dts: rockchip: Add cooling map / trip points for RK356x' GPU
Date:   Fri, 26 Nov 2021 16:17:28 +0100
Message-Id: <20211126151729.1026566-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126151729.1026566-1-knaerzche@gmail.com>
References: <20211126151729.1026566-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK356x SoCs have a second thermal sensor for the GPU:
This adds the cooling map / trip points for it to make use of it's
contribution as a cooling device.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 3b314ccd6c94..a67c279c164d 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -960,6 +960,33 @@ gpu_thermal: gpu-thermal {
 			polling-delay = <1000>; /* milliseconds */
 
 			thermal-sensors = <&tsadc 1>;
+
+			trips {
+				gpu_threshold: gpu-threshold {
+					temperature = <70000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				gpu_target: gpu-target {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				gpu_crit: gpu-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_target>;
+					cooling-device =
+						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 		};
 	};
 
-- 
2.30.2

