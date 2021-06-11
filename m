Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB43A4431
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhFKOkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhFKOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:40:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FFBC061574;
        Fri, 11 Jun 2021 07:38:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h24so4936867ejy.2;
        Fri, 11 Jun 2021 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N4ihkj1Omvm17QpjwktGEKecRjJXJDw8GrzMNkb435A=;
        b=l3lSfoYVptC7mVRVSdI+ePCvmnj3PEMgJDMkS/LqOUUMC4V7916wi9PFr8HNuwZipV
         vO8kuOfQBjqfLOjlU2z2HgTgrDic8h89sU9JabJnMJQ3Qp9CVJJjFod8sYrwOuuXUDOY
         g9Xys5VJzo6nC9kEUJ/kPnb0Bhjn+FAFDxduqr5HhJJGPTWG8H1Z8YTdRJcBMPNhGvTu
         hDa948ulrWnAFaZKmOiy2DAypuMY2srBwgybTz9zliJorIlERup5YX4qeXpyDF49Bpku
         PyDIXqHqcVOtgiLMMN/ldCAEOVypMGJ4Mzbk2fVU7m7n+bkYtlK3R+yq+pekW8yZR0N3
         5sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N4ihkj1Omvm17QpjwktGEKecRjJXJDw8GrzMNkb435A=;
        b=B1O7VadKb6Itw0Hos2Ohp5AAPYsnrrintw/kPuLI6X/fVh9in1Iq4ZAiWaK/UuO1eH
         Vuc/EfxBfqPBVGADXo5l/27d41dHuHLka34uq/6B2TZhlC3nJP3Mr/BKrWKRLGz5A1iv
         7Az8jEi/yvabYx9hJwi/t3/csaf3ZvGo6Ic1LH9TGyVwIBYqd4w+z47Vgguy/qbTtCOh
         bs1VRbSNqnOctasVVTWaud3bcDW4ffWD1NecX3A3j3KLCOZOyk8tco34nR+ReTJnl2I+
         9gGuDAdzEug7PXWEczzwcl77hiyP92xgtvsghcY7vCVhq7kegS+ChATnKaTkwM1ziHfY
         J7sg==
X-Gm-Message-State: AOAM530Gouyn8SmJCrmQmB6m2OU2QQTHRcF1Vq7WbKQ1r+8AMQ8pOx8B
        zlVfhphfqLa+13ocK4gcOwo=
X-Google-Smtp-Source: ABdhPJwIZFic3caAilARhIEd7H2HfaOUHTtAVzv+rSXbDXagmwMDKVs7WG/NEwZ9qwboIieRS8OFDA==
X-Received: by 2002:a17:906:e01:: with SMTP id l1mr4073984eji.280.1623422313238;
        Fri, 11 Jun 2021 07:38:33 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p14sm2671008eds.19.2021.06.11.07.38.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 07:38:32 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/3] ARM: dts: rockchip: add io-domains nodes to rv1108.dtsi
Date:   Fri, 11 Jun 2021 16:38:20 +0200
Message-Id: <20210611143821.13057-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210611143821.13057-1-jbx6244@gmail.com>
References: <20210611143821.13057-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible strings below where added to
rockchip-io-domain.txt, but never added to the device tree.

"rockchip,rv1108-io-voltage-domain"
"rockchip,rv1108-pmu-io-voltage-domain"

Add io-domains nodes to rv1108.dtsi

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Due to the lack of a rv1108 TRM changes
to grf.yaml or rv1108.dtsi not verified.
---
 arch/arm/boot/dts/rv1108.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 9bd0acf3b..1a61a6a68 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -265,6 +265,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		io_domains: io-domains {
+			compatible = "rockchip,rv1108-io-voltage-domain";
+			status = "disabled";
+		};
+
 		u2phy: usb2phy@100 {
 			compatible = "rockchip,rv1108-usb2phy";
 			reg = <0x100 0x0c>;
@@ -434,8 +439,13 @@
 	};
 
 	pmugrf: syscon@20060000 {
-		compatible = "rockchip,rv1108-pmugrf", "syscon";
+		compatible = "rockchip,rv1108-pmugrf", "syscon", "simple-mfd";
 		reg = <0x20060000 0x1000>;
+
+		pmu_io_domains: io-domains {
+			compatible = "rockchip,rv1108-pmu-io-voltage-domain";
+			status = "disabled";
+		};
 	};
 
 	usbgrf: syscon@202a0000 {
-- 
2.11.0

