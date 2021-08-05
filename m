Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D003E1EA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbhHEW2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240144AbhHEW2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:28:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCABC0613D5;
        Thu,  5 Aug 2021 15:28:31 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mt6so12487905pjb.1;
        Thu, 05 Aug 2021 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l9GKlJXENJ+NEavpSz/rpIPnYrBdVQY2pEFyg+IrfTI=;
        b=YqmtBVNokX+oXdyXQ2LyXpjGfk56n7Wniukfoi6MKU30C4kiXU6GDU7M1SDPfL3HBq
         MI8OBrFBCwiWUkH/IE4r0WpcfklvaPeniYVkSFqshowg2ngwRmbh/bIi5iDfAE8CNK61
         2Xm6RNqcH9efaFf7L7RIBGluXE/IgXpgUzXjP6WJA4OtJ14+PwwRsKzXkr6TGc0Ej433
         Hnh84NEB8gewUXSN/+Ifai2pjp+uJ+8adeqlUGjlTFMkvgs251gkLfTTy2JB9uZBa1QD
         TAt+F2e943VmMcmVBIpCEHF9fhE1GnfyvcdmfE+FsNsv1bHOdA7kAUn6iJEc3eBO93JU
         VdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l9GKlJXENJ+NEavpSz/rpIPnYrBdVQY2pEFyg+IrfTI=;
        b=JhcSZgsF1K/cZwOaqYoeQk2W5RBZAyqZW53bIAV3R24Kin6hZmOMIEfheyyI5JeI7U
         UuA2NMdYXu+G3ZoHuS+Yn/48ehzQTWozqNq3+wofqHWiRqBtIrZwU8UH28YhAafEQPaE
         dlq87mTWwjRAdyeCVrlJqnL1z6ioK0URy937aLMAlEsUpGgrHlPcGZOzyi6m9aTs/7Xj
         62ANKUwkWDx0hG524sohd8665EzHIoD/vfNzLS3fHjs/RtFi2DkRivvf+4aDbhdonbpP
         1e8k2huKZq/+qteAhDFV9CGeSRqg2Kz91TohRiIHt63mO394jbqKXXeky46/9x/G9CQ0
         JQ8A==
X-Gm-Message-State: AOAM5332XUgMSfJhjIWfLKRrJ7vbeCxPTRG8xbaLe38MD32wEgiXLXi6
        54lUaC2aO475txZXDCGQ5R0=
X-Google-Smtp-Source: ABdhPJzQJp51jXanZDAwkUbCB9TjOsTXFSFj+xqsyn+Y10RvKJSFBk9BehdJOkgqmaLp/2H3ZcufnQ==
X-Received: by 2002:aa7:9f06:0:b029:3c6:c469:9135 with SMTP id g6-20020aa79f060000b02903c6c4699135mr6137357pfr.27.1628202511172;
        Thu, 05 Aug 2021 15:28:31 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id b26sm8082292pfo.47.2021.08.05.15.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:28:30 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 2/6] ARM: dts: aspeed: wedge400: Use common flash layout
Date:   Thu,  5 Aug 2021 15:28:14 -0700
Message-Id: <20210805222818.8391-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805222818.8391-1-rentao.bupt@gmail.com>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Simplify wedge400 flash layout by using the common layout defined in
"facebook-bmc-flash-layout-128.dtsi".

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
  - None.

 .../boot/dts/aspeed-bmc-facebook-wedge400.dts | 48 +------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
index 63a3dd548f30..a901c8be49b9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
@@ -91,53 +91,7 @@
  * Both firmware flashes are 128MB on Wedge400 BMC.
  */
 &fmc_flash0 {
-	partitions {
-		compatible = "fixed-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		/*
-		 * u-boot partition: 384KB.
-		 */
-		u-boot@0 {
-			reg = <0x0 0x60000>;
-			label = "u-boot";
-		};
-
-		/*
-		 * u-boot environment variables: 128KB.
-		 */
-		u-boot-env@60000 {
-			reg = <0x60000 0x20000>;
-			label = "env";
-		};
-
-		/*
-		 * FIT image: 123.5 MB.
-		 */
-		fit@80000 {
-			reg = <0x80000 0x7b80000>;
-			label = "fit";
-		};
-
-		/*
-		 * "data0" partition (4MB) is reserved for persistent
-		 * data store.
-		 */
-		data0@7c00000 {
-			reg = <0x7c00000 0x400000>;
-			label = "data0";
-		};
-
-		/*
-		 * "flash0" partition (covering the entire flash) is
-		 * explicitly created to avoid breaking legacy applications.
-		 */
-		flash0@0 {
-			reg = <0x0 0x8000000>;
-			label = "flash0";
-		};
-	};
+#include "facebook-bmc-flash-layout-128.dtsi"
 };
 
 &fmc_flash1 {
-- 
2.17.1

