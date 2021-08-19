Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B23F12EC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhHSFuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhHSFt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:49:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77766C061756
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:49:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k19so4469379pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IF17aolAlURwpUnWUph8bUVhuWbBF2d6WJwX4WbnNTg=;
        b=fhVU3TVK4EAJzDg0y7JBPMoHqfMgacKk7BaEeiEhp2P/1OtoeYnQW73MiUhPEINzfd
         W1EErwSVTem6Zw3ereTktMLp0iQVdpRKMvijGloX4eD0fL9Mgl8nww1Y1yQ726jlw9lV
         x1fmbNM/gLKUsbyv+nHt+oABX4NRv5mHHX+qw+QMRoRlBPglQewt4dW3664GY2GLH5Dh
         zHOvHI/+uPAxMz6069Bm+9sPOfw16LjITtUkwaLzIsK/5jQldKpaxS8HOLjLZyysR5tw
         SyUjPxqoU5oDotEqWU7U0srYvabEBBIMn3QE/hQKOogngAn+ozVLhMpo1jQ98t2Omz/F
         pbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IF17aolAlURwpUnWUph8bUVhuWbBF2d6WJwX4WbnNTg=;
        b=nL/p7npGTGhUt04BAd5FeTreXVa8PkEAZUkuEZUHQJwmUsYLyxphkHqZMRXLYyzCCd
         jCLlxOPpwlSNSAavG2F5GTka4/6HuzYLAa+ZB8mLF+bqna23r50NnQo8PKRDob4lziB1
         bOSk2pL2uUju0HDnWgl8gZ1ObaaQFrmtbEvOCRTh0FgWc9D+hEiNCMMRe1UN1m7Z69ZS
         qVgfR1bhmnCMosH7MXLI4Az1o9/rtoXpzx41oSpbmAETZzRPZ+WtciAn7OlPDCW12OoE
         DkOZzco5hltT/oJh2RV0iafdxpd/vUprcUECKwkPdDqwlpepqPayuO68FYnhMsCqCe0v
         tuDw==
X-Gm-Message-State: AOAM532oFfSoxc2bTuNN6VpR1dn61otndAzklID6sBPhEEc+X+LsTv65
        sQF6V4IhY86z3ZPw79n/GnoV9WgokMM=
X-Google-Smtp-Source: ABdhPJwhUxuij/OaFSxq7kv9lP7YJX3qeVZtyD9ZWBFOitm1Q6pm8+MiqsKVV9CJGtOzsEC44ZOv1w==
X-Received: by 2002:a65:6805:: with SMTP id l5mr12760687pgt.0.1629352163111;
        Wed, 18 Aug 2021 22:49:23 -0700 (PDT)
Received: from localhost (95.169.4.245.16clouds.com. [95.169.4.245])
        by smtp.gmail.com with ESMTPSA id x19sm1821520pfo.40.2021.08.18.22.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 22:49:22 -0700 (PDT)
From:   George Liu <liuxiwei1013@gmail.com>
X-Google-Original-From: George Liu <liuxiwei@inspur.com>
To:     joel@jms.id.au, openbmc@lists.ozlabs.org
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, George Liu <liuxiwei@inspur.com>
Subject: [PATCH] ARM: dtd: fp5280g2: ENable KCS 3 for MCTP binding
Date:   Thu, 19 Aug 2021 13:49:08 +0800
Message-Id: <20210819054908.140514-1-liuxiwei@inspur.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: George Liu <liuxiwei@inspur.com>
---
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
index 1752f3250e44..d0c3acbf6c8c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
@@ -3,6 +3,7 @@
 #include "aspeed-g5.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "FP5280G2 BMC";
@@ -902,4 +903,10 @@ fan@7 {
 
 };
 
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
+
 #include "ibm-power9-dual.dtsi"
-- 
2.30.2

