Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE203FAEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhH2WjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbhH2WjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:39:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61074C061575;
        Sun, 29 Aug 2021 15:38:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso13387636wmc.5;
        Sun, 29 Aug 2021 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXR6tz1kIhdsfIeDhmj+PX41l/HRmlpM6kjntPVEGrw=;
        b=R8GZNZyBXwOrj7ZHPA19MPpFfBNLzUfXQsbar2tNZqwudJfnXqICRB3aLi0opMCfSb
         saVrtcK03bvRqflZVzo4d/hNI2BiZFzW5Gz0rG8b5GUozwJiXj/DmhPqYTLB+CKlIRHg
         /Rek3ctjVxtQWU2JjmJ5vN6rMy1YbNw+I6ufvzTfFnF3iTjpra+m3xPA8EjPsq2Ieqd8
         eAvbkN1n9C8OZYnUR5BHdZhKnb7w4Ahz8rsyZMBXUdVwPl9u1bO5UOBAFEdpSB+G5SJl
         L/CN4XtIShTFIzZAchhsTmUrA3bEGZkMs/wGPh6ACdX758aIwgueWhCgf3wGzI2/iJg/
         juWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXR6tz1kIhdsfIeDhmj+PX41l/HRmlpM6kjntPVEGrw=;
        b=tYsLaubyrrTAJc6Emp3OTT9RTSn+z1uc9IUOjvhjd3edTBEW0th1Jtia1Zug10p6Kd
         4zhtSh7HZKUktE7jMVTSyE2T710Q/nLwxhN9kfLR17FMOmK9jgIengVhFHLX8VQ15ssK
         NY0t1E3KUhzHQr7K8CkCRMf4HAlf99RSH5wn2Gu+p8zs3duyA7HCylpUj9XL+qVBUUK5
         N0QHCCl6/8svnI/SZocMaGfOHc16HRfInFxBKIbmLo44ujAFAa/odj4VA9saUjD/D+G0
         6ny2BfH40kuazH7p9K0d/bV0tpJdgV4Sy3D+cQ/4ivbt9f7Q/TtqfGKcW7NVqQQy4BRU
         Xstw==
X-Gm-Message-State: AOAM532z4ipuH2KZ41nXMKxLSk6iKmExZi6jtKSQy1uDJhOAepJiwe4K
        FPJObpn7daAnCMWn79gHE34=
X-Google-Smtp-Source: ABdhPJxjK1bgSYGfi9gvOdevboOi60/tRhE2zbjonBQNP+Q45Bb6Tt0lySbVd4FuynEp7wQZ6kLYiA==
X-Received: by 2002:a05:600c:1ca7:: with SMTP id k39mr31143629wms.115.1630276696974;
        Sun, 29 Aug 2021 15:38:16 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id s7sm13603878wra.75.2021.08.29.15.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 15:38:16 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] ARM: dts: NSP: Fix mpcore, mmc node names
Date:   Sun, 29 Aug 2021 22:37:48 +0000
Message-Id: <20210829223752.2748091-2-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210829223752.2748091-1-mnhagan88@gmail.com>
References: <20210829223752.2748091-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running dtbs_check yielded the issues with bcm-nsp.dtsi.

Firstly this patch fixes the following message by appending "-bus" to
the mpcore node name:
mpcore@19000000: $nodename:0: 'mpcore@19000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Secondly mmc node name. The label name can remain as is.
sdhci@21000: $nodename:0: 'sdhci@21000' does not match '^mmc(@.*)?$'

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 745d1d9d7414..6f2ccd059e73 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -77,7 +77,7 @@ pmu {
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
-	mpcore@19000000 {
+	mpcore-bus@19000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x19000000 0x00023000>;
 		#address-cells = <1>;
@@ -219,7 +219,7 @@ dma: dma@20000 {
 			status = "disabled";
 		};
 
-		sdio: sdhci@21000 {
+		sdio: mmc@21000 {
 			compatible = "brcm,sdhci-iproc-cygnus";
 			reg = <0x21000 0x100>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.27.0

