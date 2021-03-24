Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737A9347999
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbhCXN24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhCXN2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:28:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897EC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:28:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o16so24475392wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytesatwork-ch.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9I4AZHWv0YWI2h8e398dfx117Hw+f6MFnU7XsPYdq2Y=;
        b=TDXRRSmx+Po/IKLV9wl6cmct9YX37QWmMqlDV+ScNn0aCH4whg01yX7ZE/yRLFx10K
         He7SyfCeDGPRVad89rMTMF8Boy+EbAOm23OP9af3LA4EkwDtBgpLa2FuVwngpgYFeooo
         q4Z7UoTn48nGTfOAAk7qsnUJe0P/6IXZdmHXj6dlEcWR7Uou7p0M6jYsu6K0ckI59goX
         6Zt9XW1x/0e8OoAIXDAqj1FIdWE8fuKdCzjQ3SDPbRuQXhogW9sFX/CSpPstpfmr8qlO
         AzzW6wQVHbdA5KqiecntYTm51fEeuXJqJQVl2EfHDSFEQ5/cHkeD03QN8P3znX5BiaJa
         kYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9I4AZHWv0YWI2h8e398dfx117Hw+f6MFnU7XsPYdq2Y=;
        b=ba8XMTfmNNaVPh6+5Xmq/GDPBhuOUpXLmM+/foKmQNe7dIF6vu3W2zc3JgscTjoHAo
         wrTnm4Z8t3QUYN+Y/r6OiN5GKcfheM1NX50QsZupOQibD2l+FmmGhDcmHTB2qG9800PX
         P4dyGQDARLsHpsVwC6rzKRjnVvYvVtgS9DYQbzUCJgaGGcyZEGVp2H5/t9gNs2L6Kc50
         TepD1L1mvJSg/Twjeh6dcP9zxqNUkAz4Vcn2zuBdjFOypEZlYpgS/K957siD11pxdTJW
         /N8LkU4ZaSoU/XhJQj3MGQcHPcJ9quIb0uKIkk6bsUXphXWGqZ7s9vo94qv7gJTDvVfI
         u0ig==
X-Gm-Message-State: AOAM530j0sFqaqP3MlLYVK1c/1KOo5s8rcSapmuQtuYrTFtHpLMBRqDN
        pI2rJEr0q2HJtQlRhKFavqi9GA==
X-Google-Smtp-Source: ABdhPJxaGkQM+Z2rWDJmOL0reSHlkr4v+WrkCxrQLCoOFiHS65bSSHZY/cHcyf8bOUCEJ/SraArL3w==
X-Received: by 2002:a5d:5411:: with SMTP id g17mr3559714wrv.194.1616592526581;
        Wed, 24 Mar 2021 06:28:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:c9a6:940:259a:e996:942a:832f])
        by smtp.gmail.com with ESMTPSA id x6sm2645645wmj.32.2021.03.24.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:28:46 -0700 (PDT)
From:   =?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     oliver.staebler@bytesatwork.ch, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mm/q: Fix pad control of SD1_DATA0
Date:   Wed, 24 Mar 2021 14:28:41 +0100
Message-Id: <20210324132841.5841-1-oliver.staebler@bytesatwork.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAOMZO5B_uHS_Z2LuMwHDmn9erORrsrNBMHMjkW-hW+pnfHZThQ@mail.gmail.com>
References: <CAOMZO5B_uHS_Z2LuMwHDmn9erORrsrNBMHMjkW-hW+pnfHZThQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix address of the pad control register
(IOMUXC_SW_PAD_CTL_PAD_SD1_DATA0) for SD1_DATA0_GPIO2_IO2.  This seems
to be a typo but it leads to an exception when pinctrl is applied due to
wrong memory address access.

Signed-off-by: Oliver Stäbler <oliver.staebler@bytesatwork.ch>
---
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index 5ccc4cc91959d..a003e6af33533 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -124,7 +124,7 @@
 #define MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD                                     0x0A4 0x30C 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SD1_CMD_GPIO2_IO1                                      0x0A4 0x30C 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0                                 0x0A8 0x310 0x000 0x0 0x0
-#define MX8MM_IOMUXC_SD1_DATA0_GPIO2_IO2                                    0x0A8 0x31  0x000 0x5 0x0
+#define MX8MM_IOMUXC_SD1_DATA0_GPIO2_IO2                                    0x0A8 0x310 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1                                 0x0AC 0x314 0x000 0x0 0x0
 #define MX8MM_IOMUXC_SD1_DATA1_GPIO2_IO3                                    0x0AC 0x314 0x000 0x5 0x0
 #define MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2                                 0x0B0 0x318 0x000 0x0 0x0
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
index b94b02080a344..68e8fa1729741 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h
@@ -130,7 +130,7 @@
 #define MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD                                     0x0A4 0x30C 0x000 0x0 0x0
 #define MX8MQ_IOMUXC_SD1_CMD_GPIO2_IO1                                      0x0A4 0x30C 0x000 0x5 0x0
 #define MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0                                 0x0A8 0x310 0x000 0x0 0x0
-#define MX8MQ_IOMUXC_SD1_DATA0_GPIO2_IO2                                    0x0A8 0x31  0x000 0x5 0x0
+#define MX8MQ_IOMUXC_SD1_DATA0_GPIO2_IO2                                    0x0A8 0x310 0x000 0x5 0x0
 #define MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1                                 0x0AC 0x314 0x000 0x0 0x0
 #define MX8MQ_IOMUXC_SD1_DATA1_GPIO2_IO3                                    0x0AC 0x314 0x000 0x5 0x0
 #define MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2                                 0x0B0 0x318 0x000 0x0 0x0
-- 
2.26.2

