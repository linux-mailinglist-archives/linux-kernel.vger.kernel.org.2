Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8D416A51
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbhIXDKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243966AbhIXDKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:10:22 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E205EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:08:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 203so7625774pfy.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 20:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XdrQW8HzIhTUGHGMCAa8OI1HGfgif2vYzP/M9GdBHL8=;
        b=KDNtISQSQMv4CpilgRSFENacX0HiHncZVBSM6ApwDe+Qqux9eHl0wIQlGaFkGtgzmW
         9U5Y1Y3uaJ6kETIMl79Y6TFmm8WDDWExy4Puv+Xoj/fskiCcKtof6sCTfECqJVmNFo5L
         QtI+equAXthZCgj/pClwv2sPrnIFMX9emac8lD0fvzojUT1udYDt5G7hUvW/QlXwkHmk
         DMEYxY3LE3n4BpImQIIbTwzQqiRzH2zhPcH7iIzWCMbCkkzXC5KuXNHETZpOEjSun06J
         BT8/+fFUM+LpeyXLmBXpWpTofC5+EphRBz2K8g3Y5Uz626vaNIXBjQz3VZQwmqY8AoGK
         aaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XdrQW8HzIhTUGHGMCAa8OI1HGfgif2vYzP/M9GdBHL8=;
        b=e+ZhHOLIH9epfis7q8b47SUkaJ7uknT1ykktccnOkH9sjoAtESUkwjS9HNajLymxUV
         KwUPkMPC6Uj3wmk57DOn/8i/WGR7sBEQxLT9p5rg9v2qDPPiiTDufY6mr738YXCTD6NT
         RSLMbH2U/bMONjPrnTcInrmJj5UaGI64qja0yY/l5ivto0kqJXCQ137jY+HbHgsCXD3C
         Wb0tb7PEQ19P94t5BitPWEtDM4ikyPKOsXDFd3faW1q93PcCEQwzGpFmRWOOyxc+lMo4
         ngGP8ndFqs5Co5y7J8hzI0C1fikrRacZ4H2Nh+dmT7CiM+cRo7qnwoZ4sY3OzPzQt1JM
         eR2w==
X-Gm-Message-State: AOAM5300uRjmMjHoArRWNdP44lFuyRrEySq7ckdsnHoAIK1VDvf/XfH4
        KUnCHZWtK0w+N6AI0tNMtZz4MMI5ABY=
X-Google-Smtp-Source: ABdhPJzcdMxHWLaKS0URbeoeAWg3TGX5uDiNcULJdbc/9CUIdeMuuydRw4uMMUlIyCEcLCxmcWsmFw==
X-Received: by 2002:aa7:9832:0:b0:44b:232a:a15d with SMTP id q18-20020aa79832000000b0044b232aa15dmr7464526pfl.51.1632452928975;
        Thu, 23 Sep 2021 20:08:48 -0700 (PDT)
Received: from 7YHHR73.igp.broadcom.net (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id u194sm7196075pfc.177.2021.09.23.20.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 20:08:48 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@Broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] reset: Allow building Broadcom STB RESCAL as module
Date:   Thu, 23 Sep 2021 20:08:40 -0700
Message-Id: <20210924030840.9650-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be built as a module and uses device managed resources.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index be799a5abf8a..f9d8b364db5f 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -58,7 +58,7 @@ config RESET_BRCMSTB
 	  a SUN_TOP_CTRL_SW_INIT style controller.
 
 config RESET_BRCMSTB_RESCAL
-	bool "Broadcom STB RESCAL reset controller"
+	tristate "Broadcom STB RESCAL reset controller"
 	depends on HAS_IOMEM
 	depends on ARCH_BRCMSTB || COMPILE_TEST
 	default ARCH_BRCMSTB
-- 
2.25.1

