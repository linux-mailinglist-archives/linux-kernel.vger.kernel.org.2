Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB6350AB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhCaXYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbhCaXYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:24:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE9C061761;
        Wed, 31 Mar 2021 16:24:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso1916446wmi.3;
        Wed, 31 Mar 2021 16:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCUHDyILVMZQ+zOSKp5xmbbk1ScbD/xQkdbBQ2dSRDw=;
        b=E4eko5yAD1JtBsXMuK7ul1rbSKI+ilv9R0TDlpNx3SqPqX5n+B/MZ712s99oqdmWhH
         25MTQAbc3VkP+VfJPMsrq300CS6geweMUTyrDZ8rfRXX40IRw+qEVtkLhCszwzfEFu9l
         vX5g66KGBKp08b+YVbf71fcfCZaZzKAdPmGCOgdOKrU3pJox2rdnPbqvWNGRM2/z8yJe
         G/jYGwslXqtlOL5HNwvPhB5XBYdVxvhv6KeZ1VrGcicLxIGwefja/0kimrk/+h+0X4ch
         NSgQvaYkZ9rpPSpFngpMVqB5N+MVKTOns8b61s6Z63lupr88MQPbBVLU6k5X4RbQm2Cn
         /r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCUHDyILVMZQ+zOSKp5xmbbk1ScbD/xQkdbBQ2dSRDw=;
        b=Gn4F+Jgbt8shqKb2mGNsjGD3GU3dxUii32F3iPR1Uo1nP1o2+phjw3gQV5xCUaExrX
         LVS4fsGHqiIlHNHsGn+x0UyXhqQhr9xYnLBiG205y2oCbEzCkZ08bLV7KhVbTUebqTEV
         +fBLJA7hXqHjEh2Rrp1OS58CC69+HCRaZ8zpDFxJ5tdO+lO9HNXYBNMr8NYuE+c7e/z2
         iJHvqUx6BBHrsacjKwd/mnf75y0n3Lrv+zytUvUlQOam1GdsekzFB9x4m5p8o0g59ktu
         ryqlUE0G892S/W0HqOEJprHMQuAKuPffkBDm55bjZRcgW6RBYaD+3jJDL+H8ing9/MMV
         EDhA==
X-Gm-Message-State: AOAM533q2lQ8r35OKOsiJ/aoJBk6p9hXD5kYPHapdpt7w3oNWo/mrB4H
        HeGX7y/4TodN3+VckaH0rZk=
X-Google-Smtp-Source: ABdhPJxUI2t1qSz4ZQ3VjinwY8DEJzlMHEkz8DCOG8AWqyvbsBUMisHVZzKO+UY+i2Mq7TScywi42A==
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr5131941wmk.102.1617233041376;
        Wed, 31 Mar 2021 16:24:01 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27007d57ea0d08d946c1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:7d57:ea0d:8d9:46c1])
        by smtp.gmail.com with ESMTPSA id t14sm6343041wru.64.2021.03.31.16.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 16:24:01 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 4/4] arm64: defconfig: Enable LT8912B DRM bridge driver
Date:   Thu,  1 Apr 2021 01:23:56 +0200
Message-Id: <20210331232356.2204476-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331232356.2204476-1-adrien.grassein@gmail.com>
References: <20210331232356.2204476-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used by the Nitrogen8 SBC.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 56398b55500a..ae981d3b1bc8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -690,6 +690,7 @@ CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_DISPLAY_CONNECTOR=m
+CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_NWL_MIPI_DSI=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_SII902X=m
-- 
2.25.1

