Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EEF3F12F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhHSFxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhHSFxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:53:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CD4C061756
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:52:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q2so3243446plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IF17aolAlURwpUnWUph8bUVhuWbBF2d6WJwX4WbnNTg=;
        b=dMrZyt1F3hsIKuO7fUpYJRjEo/VlUYlC5wrhdPkOgTPHv/q7L9oZNyGXgU8O/5YPa1
         ZUpaROFhFNeXOimJ15G5nC7IcR2fEe2hfkyeBEy7sPT23eycHsc0XRapOwXD9vOPstrn
         U9bEWJkncUXE8dPNvY+MT0s7H+ZFkm8ue/7xCWkE/4KAEx9FrgiEfy4pnra10GiGaHQ0
         o0/VHrjy8IB8XbBGpjrWKf1JMITmkJtY6mM63tNKGIF9td14di10jCmXRj15yu3tYNn6
         d3rCzYYP6KJ44D5BddEkUjMOu8G86JRvI8zWaYTY5bL8QRZhW+jTrCNjsakhjxaa+KbJ
         c1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IF17aolAlURwpUnWUph8bUVhuWbBF2d6WJwX4WbnNTg=;
        b=fX6PYmCz+56Gxy420tT5MGapLpGImZ8IUEKvZFqqsHdpfhJ5vgWvKdEsOWPkXAuYTZ
         N3Zks9RSxW4sj3UoRBKK7Sp7BJJPJzKQpU8ayJYrHOhigIlu7jrwXWPFOPpeCwL7gIJH
         k6QM08gbSUMQnA3nAm/WvkaBMDqHLHyNhmXlQo7R7pn486FzLhgVV8xI+wi8CwoLTEi2
         Dhk3JJfoV9N2OkYjjPUEGOTasPMd98+kd8eGWfDGAdC2kKLzWrkqd2T0rYnUqJs569aX
         EJRIhYal7NQEFJCjt1uW6Xddvx7xEDo8Ie61AtbqtiDoJHqn8D00iWUf9H9d1l5j3u6q
         o+cA==
X-Gm-Message-State: AOAM533X4e2m8jkBnt0DV7zMDrCtB8GT9180uf0eICc7jILRwoar0Twm
        H7xpJm/IcASTwM6ysU/9FtkflaHPFm0=
X-Google-Smtp-Source: ABdhPJwtzQIbitrTyYk+vzJWEmbnvQ+C4XZlT5gcs8oW+Qkj0ReIzTignGSUCDvdAoV7s1cVJyzHzg==
X-Received: by 2002:a17:902:7786:b029:12c:dac0:15ba with SMTP id o6-20020a1709027786b029012cdac015bamr10194807pll.27.1629352352799;
        Wed, 18 Aug 2021 22:52:32 -0700 (PDT)
Received: from localhost (95.169.4.245.16clouds.com. [95.169.4.245])
        by smtp.gmail.com with ESMTPSA id j35sm2162177pgm.55.2021.08.18.22.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 22:52:32 -0700 (PDT)
From:   George Liu <liuxiwei1013@gmail.com>
X-Google-Original-From: George Liu <liuxiwei@inspur.com>
To:     joel@jms.id.au, openbmc@lists.ozlabs.org
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, George Liu <liuxiwei@inspur.com>
Subject: [PATCH] ARM: dts: fp5280g2: Enable KCS 3 for MCTP binding
Date:   Thu, 19 Aug 2021 13:52:27 +0800
Message-Id: <20210819055227.140980-1-liuxiwei@inspur.com>
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

