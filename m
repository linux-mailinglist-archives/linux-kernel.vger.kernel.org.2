Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872F23DE188
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhHBVVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbhHBVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:20:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B146BC061760;
        Mon,  2 Aug 2021 14:20:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id h14so36171509lfv.7;
        Mon, 02 Aug 2021 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azI3FQ3xogYeBpKzbdZ5/OFpcQojNSQseR7pUsqw9jA=;
        b=axPDWgaGPOUwvlWTwDK8eHNXe/x8e9hT93C3dI3XS0u6GwynUFSZpHM0kE0zTtaQ6Z
         zV8OMBZe0COatWeOvSRN8FgdnWG2EOXZYbNkTJtAuW7dYZa9EveEm09hTsQtyPNqD8PK
         PR5C9HFAWj2kiEF0SoIjcCnfI/DQrDDj2H6hw9ienp2VcokMEEM7Ax9ip0kWst6CReSO
         UgCpNqNipJ2IgOfzMIoC8VvmZuIdMdPjfbIQ9WbPuOxU/LpRx5/cEpv0uR8HJTRURxT9
         dDqtbzSSfc52FIEhCNTTv+DKvbTKNbNFy4+NPjvsp5GYk6hoZ1uwP9KOSn8P2TlW7SS1
         Mgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azI3FQ3xogYeBpKzbdZ5/OFpcQojNSQseR7pUsqw9jA=;
        b=ALqM3WRLSGNVEETyYNP8LBSVEqiJjlr+Ngr00/ryx0mRxHUx32s3UCSNfBVaDi21Ei
         /toYV370tXMRnA7MvhSiZA0l0PI2MBebGXbH8lGHUoC0RZMW6bfOPC2S8o60KCLqLP44
         Xjue5es3FvZqcZbwpW4EptLCRRGXmL1sdCnb43e2GxKmtwe9CIlUCqWXxKMhXuRpLY+w
         cmQ2wRf+pmDn73O2vUDDi++5greZpvALYhc4XCquxfILOZANPFkkfclrxCOTKVXg9c+4
         ClnRHZmuQ/yYUjJhHnLDfZyA6rh6AP3+ZjVAwRCLMXciXtT96pB/esW+J46gE8AgVqdY
         SCCg==
X-Gm-Message-State: AOAM5303EUQ7/hBluN5I4xNWji9TSfPg/a3eghjAPMWZRZQi1IrQFOOC
        wDKW/gMnnCX+ZU3JfGrShlU=
X-Google-Smtp-Source: ABdhPJwmGo34awUmc6dQpKwgm5Dlj2H99IMiCUJqDpqs25cyGX1b/ffBW8sfmnsI1GOIu9s3FYfh9w==
X-Received: by 2002:a19:f00f:: with SMTP id p15mr13639104lfc.42.1627939242097;
        Mon, 02 Aug 2021 14:20:42 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id p14sm764942lfa.117.2021.08.02.14.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:20:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 10/15] ARM: tegra: jetson-tk1: Correct interrupt trigger type of temperature sensor
Date:   Tue,  3 Aug 2021 00:19:42 +0300
Message-Id: <20210802211947.19715-11-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802211947.19715-1-digetx@gmail.com>
References: <20210802211947.19715-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LM90 temperature sensor should use edge-triggered interrupt because
LM90 hardware doesn't deassert interrupt line until temperature is back
to normal state, which results in interrupt storm. Correct the interrupt
trigger type.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 414cd1cafa7f..35ab296408e1 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1427,7 +1427,7 @@ temperature-sensor@4c {
 			compatible = "ti,tmp451";
 			reg = <0x4c>;
 			interrupt-parent = <&gpio>;
-			interrupts = <TEGRA_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <TEGRA_GPIO(I, 6) IRQ_TYPE_EDGE_FALLING>;
 		};
 
 		eeprom@56 {
-- 
2.32.0

