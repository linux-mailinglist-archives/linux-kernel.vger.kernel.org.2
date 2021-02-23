Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3630323158
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhBWTVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbhBWTSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:18:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4EDC0617A9;
        Tue, 23 Feb 2021 11:17:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t15so23649709wrx.13;
        Tue, 23 Feb 2021 11:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTr1/mv6nsyXy8Axrc2R950ucaShXBUxnX7juCfyHPA=;
        b=taJkGM9E9fqDSBNdWN56z/pHRLCIViIrJkGfRzq6yxbeypt2mE20AcRuXW4rVILHQt
         ldwZoxPfVoeCkvNbmJt5L+jjm6qNcJhscXGET+Wol3oqlSpHBiMyMbkxkm3KiD+x5Iz6
         iHM+vVIo0/BjO9dDG/HsoxlHcTtAd6b6q0NqZjL5ixOx3G+SpYiVvhmKwiPrG91+EXJi
         X9RsIMcNjNNKQm5Zeok2t+QnXV9AKP47Y4mJnE00kBeigdMOj+ukrdIUsk4rIrfVTpti
         QUBjZsVxVpeC/bvQiczQeRcGLWNP4pfQd9x3/E0nmDjT5I7FjudI596dVfAFkKCP3J0l
         U9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTr1/mv6nsyXy8Axrc2R950ucaShXBUxnX7juCfyHPA=;
        b=UB2yO7GnW5Ml6tkAFFFMdncJp+R2XYMAWcBKkTScNbucS2iRMSxCL3DE6d7cZd8zZz
         rPyT2ovil4RuS7A0JWARtRjSvCDjpUTOIaMxjUXIztQ7RjIjJqT+kDkrs9wNT93lwu+t
         2yph47WR31pf/ExMgk8FtRDF9uITz3ttyz1+FSu6pDNu0N6kTwXVkyRpCt8ruk5+3EKD
         9vn+FO6VZeyfOfWTJtaiw41V3esga4/qM3LyOT7bE6O75vQDL9ARCu7NwzrsNf3WfZCs
         YVz3QEVtetEZVW0FUxgHChB1ppSQTUlbjqg2uS1taoLTcxosbNeEDbiMJzPqNS1J2mTx
         zUiA==
X-Gm-Message-State: AOAM53177I0n/khirwk4N88pWbq5Zvq4cUGvEmNewyFhmHLISwVTmbh+
        p9Wk5CfAFyaIzJMOZirQrME=
X-Google-Smtp-Source: ABdhPJwrhVSJ0cuYzgU2i+NE3qLswjWPTJ5YYKdyYYnA9LIowR9udrqCv7Ezi3VkZAjSkZpp8yDWFQ==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr28325033wrq.425.1614107822405;
        Tue, 23 Feb 2021 11:17:02 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id a21sm3611413wmb.5.2021.02.23.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:17:02 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 10/10] arm64: defconfig: Enable wm8960 audio driver.
Date:   Tue, 23 Feb 2021 20:16:52 +0100
Message-Id: <20210223191652.436397-10-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223191652.436397-1-adrien.grassein@gmail.com>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used by the Nitrogen8m Mini SBC.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
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

