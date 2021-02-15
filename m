Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3398831C45B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBOXW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhBOXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:21:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F90BC061793;
        Mon, 15 Feb 2021 15:19:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n8so10975505wrm.10;
        Mon, 15 Feb 2021 15:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BnAYcqthbeP36JBAdCKuVGD2HvSCn9Jp3E362FT5BIg=;
        b=sUqPJp9hFrbFAJHaOhlhSPQaVh4deYOU9kGWRaMn4BCP//kc2cz8om5RkaOgGcNFaz
         MUEPqN8YlGx17/Ex2fZyO+AE5G9eT/trYuZSKbHOokDcgtEewwYRpzWYGL66mUojgMeC
         RmdckfENEZQdj+FasHe6Ksomf34vyydQbTOS/o6w1skI4JYxMFyXSZqbtktlvSY7UBPp
         XGRjVhwF38+LL1b+JR0+3K0oPb+W8T83xeQNmBqxSyUA5Vy1VoyRZanaRTw6NiSlUw0t
         bD4+PEkIftyEBxG9G3LCdQoHkcBa6tMip1g6iOm1mgylEAq7Mnq6hybNa7TY8AdJdMAB
         xl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BnAYcqthbeP36JBAdCKuVGD2HvSCn9Jp3E362FT5BIg=;
        b=IJ3+rQPjLNTwSI/E7v1UOfqFgiM99fNeHEkNOoYd3bMEeXL+/3azK0yokWo+Vp5wfc
         mKXUcqto1vcXODiCsz4nFhecL85n42vRH0axKctFB+iNSjTNPKxhl5DLT0tYyRALEEgL
         PI0hcTRqf0pFpmppnAnWF7HQcUUcQQ1XM/oH9BYoJoy6J1KHJYbZMup0tGcvV3M14q1p
         KXwlyMKCzj4ixbwoNLF2tgyHUOa3kctAOLZii83/XYVraz+p5yEQHqcan19foX7MLx2y
         n5d89v0BaP69E8mdEF7f8pNm3Wiwnt3yjO+5SAsHwiK8EZ2UUjrStI6q3Xl9oEWT5HGF
         WYgQ==
X-Gm-Message-State: AOAM530KvKiQNbsRkn8hwq2UvBN/W33oIs1cS03kXjqgAw55eoctQKPB
        LwyRudkKGGZimN1lTIvKKg4=
X-Google-Smtp-Source: ABdhPJzYi71eaDlrlrfueBAo2zS/QqRdfgGbBDOP0B1Kvu0uEAV4Z2cns3l+ZpHT9eDQDOlQXaAobw==
X-Received: by 2002:a5d:690b:: with SMTP id t11mr21007841wru.12.1613431197025;
        Mon, 15 Feb 2021 15:19:57 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27008c8ad15d1b12a6b4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:8c8a:d15d:1b12:a6b4])
        by smtp.gmail.com with ESMTPSA id f5sm963158wmf.15.2021.02.15.15.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:19:56 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 8/8] arm64: defconfig: Enable wm8960 audio driver.
Date:   Tue, 16 Feb 2021 00:19:43 +0100
Message-Id: <20210215231943.36910-9-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215231943.36910-1-adrien.grassein@gmail.com>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used by the Nitrogen8m Mini SBC.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 292c00f893fc..bd310e91d4ed 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -764,6 +764,7 @@ CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_TAS571X=m
 CONFIG_SND_SOC_WCD934X=m
 CONFIG_SND_SOC_WM8904=m
+CONFIG_SND_SOC_WM8960=m
 CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SOC_LPASS_WSA_MACRO=m
-- 
2.25.1

