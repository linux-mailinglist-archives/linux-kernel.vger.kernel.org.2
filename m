Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87AD39F4E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhFHL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhFHL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:28:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B017C061574;
        Tue,  8 Jun 2021 04:27:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r11so24032257edt.13;
        Tue, 08 Jun 2021 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzJh8k2+3CTA9TUNfYHIxwiKINZGjgGPWk31gQg1rds=;
        b=nH3qy9rM/J+wpkErwX10lYjmhw9907fpaMkdI56aqiJlWb0nP605BDa5e9+iF01vFw
         YWG881aAhNnrfORJ5/ZanR9G8R+ywOrwWno+N0qE3WNzF2Jr7HoUpa+gioDOXerMH7sg
         QM/Rd2doN06kjQzZ7OY/zf2n0uQXPTSjPEv/FAFQilh8r4b2sAPEdk64L679FAiypRgw
         grN/Il7ZfAIx43lHh6T/it3WHkCI3MUbd9Cn7IOmDHrxOFoDzH9XKgeMv5TxtNBwxbng
         8kBYIVVPt3ympzuDOxdw/Re9wvVH2SANpbcLTAyj9wBDht5Xf2zEeAXHaPFAStl14hF5
         pg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzJh8k2+3CTA9TUNfYHIxwiKINZGjgGPWk31gQg1rds=;
        b=bYZIRINx82o5PoNVaQhuIRUrDbWE2jmYtFgijTm2goXlJOcVobJ8R6YjGyQf+Ec9RR
         xemmT7KQLiOrBb/1aO9xx6Y6E4iSHuUQYuLzxUbZVsRWE7FUrWyYiWJkJqRd0QQ7lEjk
         Z830gSedo8Eodd6i7Cn6dRi73QqezyS9FouudgxZ4twx04nWnLgVc/IE8RcxpRFkOnQK
         CIiE377t1avHiwSZV/RTv5IEumI3EB9MdxKdxVCvG6i0WTC2Ctxfty4HpagI84ES9ajP
         4ZTMfmUKAMjPmCGNrSoYFNn/sMglWrVjaH/ME1hz5rLv+Y9ybcXOGZculDsiDqV4zHR6
         9gqw==
X-Gm-Message-State: AOAM531GtRblRr4j/HSaeOBAl5uSSxgNQe+kzFbLufJnl5fdI7qKDHRZ
        SPmqMSGT9+MtJS5gz2Jt5I0=
X-Google-Smtp-Source: ABdhPJzCIJWJ3xOXptipDnrgmThoiTdibZBPeBm6AFow4RtsUjo44kJ4ciJFxDEoKq/1BBg1uUic2A==
X-Received: by 2002:a05:6402:1c83:: with SMTP id cy3mr24440653edb.108.1623151625070;
        Tue, 08 Jun 2021 04:27:05 -0700 (PDT)
Received: from localhost.localdomain ([188.26.52.84])
        by smtp.gmail.com with ESMTPSA id u21sm7468846ejm.89.2021.06.08.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:27:04 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH] arm64: dts: fix node name for the sysclk
Date:   Tue,  8 Jun 2021 14:26:58 +0300
Message-Id: <20210608112658.4087235-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

U-Boot attempts to fix up the "clock-frequency" property of the "/sysclk" node:
https://elixir.bootlin.com/u-boot/v2021.04/source/arch/arm/cpu/armv8/fsl-layerscape/fdt.c#L512

but fails to do so:

  ## Booting kernel from Legacy Image at a1000000 ...
     Image Name:
     Created:      2021-06-08  10:31:38 UTC
     Image Type:   AArch64 Linux Kernel Image (gzip compressed)
     Data Size:    15431370 Bytes = 14.7 MiB
     Load Address: 80080000
     Entry Point:  80080000
     Verifying Checksum ... OK
  ## Flattened Device Tree blob at a0000000
     Booting using the fdt blob at 0xa0000000
     Uncompressing Kernel Image
     Loading Device Tree to 00000000fbb19000, end 00000000fbb22717 ... OK
  Unable to update property /sysclk:clock-frequency, err=FDT_ERR_NOTFOUND

  Starting kernel ...

All Layerscape SoCs except LS1028A use "sysclk" as the node name, and
not "clock-sysclk". So change the node name of LS1028A accordingly.

Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index d0dddf19578a..03e1ca7fea9a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -66,7 +66,7 @@ CPU_PW20: cpu-pw20 {
 		};
 	};
 
-	sysclk: clock-sysclk {
+	sysclk: sysclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <100000000>;
-- 
2.25.1

