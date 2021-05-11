Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8523637AF67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhEKTh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhEKThS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:37:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA8C061574;
        Tue, 11 May 2021 12:36:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n2so21329019wrm.0;
        Tue, 11 May 2021 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbo2dYm2L8DHtyqlsUerZ1+9JEygwBTlsKvQFOh2oLg=;
        b=hlzyQ7ZAPllCC8ern1Fui+G+n+XkOExUAIn2pzs5Soa/rpf0fkrUJlWL3xs7yqo5ir
         pxSUoYs1rk7RYluoJ1M2IfNEHLQdlda30QxRWwXTbpkOcPeAp24R0z3O8jBxfRSBa4Ke
         UNimyA9ZpNBcpsAl8x8jFDL29qY32u6sHxKhFopMt3VyPyAMmaCgcp1GLIYHCv5cZFD7
         Lk3aNpv0g3viDV4hsPjob1KCC+5opCE3lZIn/Y1wTiU6bDEtoziRl6/V3ECpcg7k8ij7
         DuNW/66ZruPv+4wuWagKsmSRBKFjV/CGe64jGk/s2KGIdTAWgSxdDpiPHw9MxUp4Cwvx
         /tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbo2dYm2L8DHtyqlsUerZ1+9JEygwBTlsKvQFOh2oLg=;
        b=c5wA8XsrK7uhbVmg02e81vvnZEqgBh5RiWxebMWmoBZKoxoXwQlmy5icEkzqchsP/t
         wTyXEUtqTJC+XyOwRUdSFy6fbQmHv6bIxVt1hYRNa/fsU4Yx5Ivj4sTNUou9uco8sAsd
         N8bJcqgg9hQ2cMkOrXY2iHqX6rq55zNYw3rPFf7HULddhCpn2e/5Q9kz/sroAnyuk40/
         SL1wEmiK2Xa4L1Q9sV7B4KbrOz8H3H0E+xSnDQG+5qGXmGxpi1WIsQBXYWdxmNtZUKZ1
         Qa9oliReWXzav7ayHVXpKh4AE5gO+hPHTyypu+EELyKLZfE4SYhOFmpsHWeqMS/zzvKq
         cvaQ==
X-Gm-Message-State: AOAM530blOSCpuMEj5U2BKNqWaNNU1MVyc6x1lv6UYiFIrZ75QEY27YI
        szi540powxRbow/TlVv2bN8=
X-Google-Smtp-Source: ABdhPJzaO5LRn2VgxO+dFsrqciNDsL6BINoCC5pEKmtUhxTYi3fKQ1UuVZ5nIuo4rGIIKIN+b6rOng==
X-Received: by 2002:adf:9cc1:: with SMTP id h1mr38794633wre.135.1620761769436;
        Tue, 11 May 2021 12:36:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:3e6:d280:2c6d:4527:c2ea:bb9a])
        by smtp.gmail.com with ESMTPSA id a76sm2604562wmd.16.2021.05.11.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:36:09 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 4/4] arm64: defconfig: Enable LT8912B DRM bridge driver
Date:   Tue, 11 May 2021 21:36:01 +0200
Message-Id: <20210511193601.2584324-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511193601.2584324-1-adrien.grassein@gmail.com>
References: <20210511193601.2584324-1-adrien.grassein@gmail.com>
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
index 08c6f769df9a..45db77d1a657 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -701,6 +701,7 @@ CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_DISPLAY_CONNECTOR=m
+CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_NWL_MIPI_DSI=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_PARADE_PS8640=m
-- 
2.25.1

