Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417FB3EE575
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbhHQESp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 00:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhHQESo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 00:18:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39D2C061764;
        Mon, 16 Aug 2021 21:18:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bo18so30084294pjb.0;
        Mon, 16 Aug 2021 21:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmVeyhKiZb0zIqPGmwLOmayId0eC03bF22fmrGDOy0E=;
        b=jmymeSrHo7vr4RSmMpg+BEmhKUQli6sFp0rFo9D3+E89ww7eYY+HbdlJrUxWxftooa
         BFTOAVErFz90/swbCz5EBMx8JO63ei9tsXSZpZ8KiWT9Msp96N1CwKJ6V9v0NspRpX4v
         x2zRy0eZ1AZ2EZoNgGTQsnVVpjtMU8qkAasHRWpADvgiRj+KxQMW1ex0eEoYR2E7Cf/c
         ejupe1OeSlL73y7DCERI7g0OApZ9mJrizuwBmlLKj657fC4qxsYwGxuxhPnNZb1g3M9I
         UL/YkduJuvzi5nZSLfq6DUir/v8ABjrpKHo4Y21l7i2064zRNicPImwRrGrIGhqR64ah
         m0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmVeyhKiZb0zIqPGmwLOmayId0eC03bF22fmrGDOy0E=;
        b=Mw7SbUw+HPCHhCnqbyzBjkhLZDByEp1YYdU9SnMUl2OpQEUNqy5/4mmfPwRCMgc18K
         gKQ9fMX5u5Vxo7vtpetOFKfwhanI08m6nFXHMxn0STmRDYNWp+l49mpglEI/mD9RttZV
         t5n7FC0KBpT/cmqvSLrAk+CedsLHhJv4HP5MLDf6v0ykMJPsyQO/oxfeqSYcH/P0wTj6
         An4Pa9avt+t2/QGDLAnrCLg5dJOmh9gE50wJsKy5c+A341bwX1CnRh0/ECeZ7SnQN6j7
         KIxMS4NrjeiL9YAmVKfGLN9GuhFnWRDSVgVP4okZ1+x+8L8S80IqUTN/PC5w5OY4SWuU
         7IYQ==
X-Gm-Message-State: AOAM530EZHag3zjnsMSTFZF02+zmnSTYnfea3GfhnMmhTGU2U2wOo3Nf
        GnNiHNF6Cs2G0KyW2fd8xqA=
X-Google-Smtp-Source: ABdhPJzJKgheXvAVNXiCHRktmaDbDCjw9+UQXMmXIXMck1UzOs34Ekk2v5ohhN6ywg/uss/MLZ55fw==
X-Received: by 2002:a17:90a:ce0a:: with SMTP id f10mr1461562pju.71.1629173891353;
        Mon, 16 Aug 2021 21:18:11 -0700 (PDT)
Received: from archl-on1.. ([103.51.72.143])
        by smtp.gmail.com with ESMTPSA id g11sm705676pfo.166.2021.08.16.21.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 21:18:11 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Subject: [PATCHv3 4/6] arm64: dts: amlogic: odroidc2: use vbus-supply for power source for usb nodes
Date:   Tue, 17 Aug 2021 09:45:38 +0530
Message-Id: <20210817041548.1276-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817041548.1276-1-linux.amoon@gmail.com>
References: <20210817041548.1276-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vbus-supply instead of phy-supply as power source for dwc2
nodes. Drop vbus-supply for usb0 node, as it will handle later.

Fixes: e841ec956e53 ("ARM64: dts: meson-gxbb-odroidc2:
       fix usb1 power supply")

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch in this series.
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 3f4f16a5dedd..01bbfc4c091e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -400,12 +400,10 @@ &uart_AO {
 
 &usb0_phy {
 	status = "disabled";
-	phy-supply = <&usb_otg_pwr>;
 };
 
 &usb1_phy {
 	status = "okay";
-	phy-supply = <&usb_otg_pwr>;
 };
 
 &usb0 {
@@ -414,4 +412,5 @@ &usb0 {
 
 &usb1 {
 	status = "okay";
+	vbus-supply = <&usb_otg_pwr>;
 };
-- 
2.32.0

