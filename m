Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10C6460649
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 13:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357595AbhK1M4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 07:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348515AbhK1Mx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 07:53:59 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4EC061758;
        Sun, 28 Nov 2021 04:50:42 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id v23so17433505iom.12;
        Sun, 28 Nov 2021 04:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0jKsQjKFBUKwWQ07Nx9t2d16P3k9jPIBzztuqFG6lM=;
        b=hcVmw5XejyB9QGXWHaC/UgNLFcxQrtiohbazB3oQWq+7doDcfEgF6cib0T3ujvOTdr
         OQHnNRNBYcBnjUvYVXlhj1HY7U/F1g9unGPl3/G+jFY3Y/rCzi0KYlBCo6Tog/mjjLdc
         U9zwFKIDVjfyJeCStJzn7cNGI709uPo0d0PLVxDwyd9f6M2ZknPtGT7Qa6C6LWxlJbAp
         P/7Mbd5HQLy/3t1wrfr0VMlg2iZgihLJG1rf0vd7jEhlDROCjZ4FexZEr2ilTm8eHVbA
         GdLm41diF6fG+TZkELECGnZ0Xne2N4BU34/QGuAEOmTKIUuJImYKVzTiR4cmkS+YNl3y
         J9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0jKsQjKFBUKwWQ07Nx9t2d16P3k9jPIBzztuqFG6lM=;
        b=SqBrg4ckpOG8AJLv7//TqEN/3trMmO8mg+T4tx7POyiofhq5Ab07UAchfDAuwCk4ce
         KFiDtzZg3Njm/kGRr5II9PlddqK7InseEZG69MxI/kmescozX9vJlel4Adc34/pGiUro
         02MB6lldJ/SuoZrcZc5UyGYFDlNG3rSeUcrKpYNjKYfdBMNmmVMdyUmfhF1epW9AWkmY
         GSndfNQ1OqBdtjj1EcQ4pIhCed8Jzw+4R+Oij0vYxJyRMgx0F/ySPB82dtEYItL5mzSA
         PTmr9u6eaTN+omvCsCw5IS8fdFekQSZ6k8Yj8ehqXqAkGy2iwFCMRZBHjTi07C6fduNP
         JDPQ==
X-Gm-Message-State: AOAM532W5q+Wz2pb9x8pQPfoK6jQKllx9hjmXM3FGVIpkMIaj2teQ7c7
        C9XCIb5fN9tWoM/lt1Q6+SRGeB7beDYAig==
X-Google-Smtp-Source: ABdhPJwvEkKgG+lFEce12qfrXrXkBjFzaBKrWIXpRicGusZRyLBUJHbxT2vO8P4X35Mvq0d4ZvumUg==
X-Received: by 2002:a05:6638:3899:: with SMTP id b25mr63705763jav.39.1638103841977;
        Sun, 28 Nov 2021 04:50:41 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id j21sm6545240ila.6.2021.11.28.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 04:50:41 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, tharvey@gateworks.com,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/5] arm64: defconfig: Enable OV5640
Date:   Sun, 28 Nov 2021 06:50:11 -0600
Message-Id: <20211128125011.12817-5-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128125011.12817-1-aford173@gmail.com>
References: <20211128125011.12817-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Beacon EmbeddedWorks imx8mm development kit has a TD Next 5640
Camera.  Enable the OV5640 driver to use the camera.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V3:  No Change
V2:  No Change

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8df432182275..f7964a405f6a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -669,6 +669,7 @@ CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_SDR_PLATFORM_DRIVERS=y
 CONFIG_VIDEO_RCAR_DRIF=m
 CONFIG_VIDEO_IMX219=m
+CONFIG_VIDEO_OV5640=m
 CONFIG_VIDEO_OV5645=m
 CONFIG_VIDEO_QCOM_CAMSS=m
 CONFIG_DRM=m
-- 
2.32.0

