Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F043A443B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhFKOls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:41:48 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:33717 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhFKOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:41:43 -0400
Received: by mail-ej1-f44.google.com with SMTP id g20so4993724ejt.0;
        Fri, 11 Jun 2021 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XBRHI4+WYHmQJKlvWWX3TLpIW3BFtZ2+OX11eMACGnk=;
        b=UFM1trJ8yeAcqxOgBw5feSfI9sIKPV3AYDxSLNipVu/78czQK1euUWGsSurNQbORni
         IU/j/uoXlQmcL9BIQX0si8LDv87Nyk9vdp7HXJfGr2UTiBCfDyC0cmjeAnGy+GCd1d1h
         mA0Z6Wm4WozamSRv3ATvjCdxp/ZeRiqhd0+9MKXg1wIaRJ6dIx7WaXj74872SMkfm5IO
         cg2/lR4qMAuaE/f0W2pYMGXrnjXSnVQH1Fv3NyNPLXJCZshFQ5MFtgFztDj9Y8pBlask
         Djdy8eUuGZp+PX6D8C+jgck0/Afjlz3I/54Knp6dbJ5/Ca8Bq7urWQ6mk4+Jbse/sieF
         x61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XBRHI4+WYHmQJKlvWWX3TLpIW3BFtZ2+OX11eMACGnk=;
        b=mTm7cYT49AoxOqW6LICIguBdCBSTGuFRuO2NkG6nj+7HIswVONFkZvu90V+PLmwKo7
         MUIc3XHbyLwz9Qx/jmR1GQnjbRJN8c6OsN/71ugp7ukRWHEsLjAamgXoqnXEMU9Y458z
         IhIV1kN8elwOCsdwraMX+rNUtF8eTUJDqEqo346gkqih54yfTrGbtbLhg99cGP/IL9Yb
         b6JwRukXouUJNBeKW4xvaSM4kD3EkdJNEWe6ligB1zlawX/XsdOIm7UPWESxOUUAQ+7u
         +EBB0WPLIuk5b3S1YV6uNhILoyrPpbLWKpV376bTIdyxLWdzprC0npziSqgDv5JVsspM
         /ybw==
X-Gm-Message-State: AOAM532Q6haAuTYEZD3ZwQ1xcIaFkcPYBCpa8aqOZOGdmxvusb/i6yMb
        G8s+cwczfF/tQtwDQ9z2u+Y=
X-Google-Smtp-Source: ABdhPJyqScTR2284kAikALC1nJ97K51aH3EX1zPsYdCG6oLiLVDJzM3gcWpADKsOMJKgpwTKzwtomw==
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr3879999ejj.16.1623422314043;
        Fri, 11 Jun 2021 07:38:34 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id p14sm2671008eds.19.2021.06.11.07.38.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 07:38:33 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/3] ARM: dts: rockchip: add io-domains nodes to rk3188.dtsi
Date:   Fri, 11 Jun 2021 16:38:21 +0200
Message-Id: <20210611143821.13057-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210611143821.13057-1-jbx6244@gmail.com>
References: <20210611143821.13057-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible strings below where added to
rockchip-io-domain.txt, but never added to the device tree.

"rockchip,rk3188-io-voltage-domain"

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index b36fcdd9a..2721b7285 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -641,6 +641,11 @@
 &grf{
 	compatible = "rockchip,rk3188-grf", "syscon", "simple-mfd";
 
+	io_domains: io-domains {
+		compatible = "rockchip,rk3188-io-voltage-domain";
+		status = "disabled";
+	};
+
 	usbphy: usbphy {
 		compatible = "rockchip,rk3188-usb-phy",
 			     "rockchip,rk3288-usb-phy";
-- 
2.11.0

