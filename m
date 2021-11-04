Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C058445724
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhKDQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhKDQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:22 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C45CC061226;
        Thu,  4 Nov 2021 09:18:41 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n128so7521458iod.9;
        Thu, 04 Nov 2021 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KZYvh9YTEa3UjJS3SYNeCelmoTch8A9tHLSAnOEFbKA=;
        b=kADGUg5wSEi7bygU8gsgdGAitj8oQZiu3hHaq8DgF/xW7pYrY4utdXtvplmFK2GGPH
         dbFxD99Jr9TH0V0umQlRPjDcSoH3u/IvmOdP96+sUbln72R+3aS/6ngyh5UgxQ7U7Pw2
         8QG/mkRz/8rM0XI1mOQGczO1nCmtV6u6tZjURjDGZDkp5mUum2pyaAImQrSMCbKeIQ6J
         7QAJ8jNmR2H3BEjgRmFDxg0y2OVcKZpeHK6B+3ORQj8eWSxnzv4oEzd2zI8KKsSa3M/b
         krRuaZrfu7QgFhoyq5LbveU5Gm5LpvLAjlW+jPsPUAVbXl9TD4Rt8A7KU0cXlTKvfcDb
         qZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZYvh9YTEa3UjJS3SYNeCelmoTch8A9tHLSAnOEFbKA=;
        b=w133bh8TvTo6j7seLK2e61IJsXiOa/ztaVugWgznukltGKhmJHfvXUKgMVOMtjkYqJ
         A292H3iCfkUD2EEzULzE7uu/k3gR/kMWuLO39EZyioCYNBy/ssIZYEw9IxEfOBZFlzWH
         piCAGMaafquOYlMQe66xBQcSN1l7PWkygmZ7rUC1XgyoBeaMRnG7i8fA+nRRvfUaQ8oG
         O8pXcA0WG1EP69GXIApSUecLL5bgovEr7CudkWpPmsuwEiffULDp0LChibnRsnT+vDri
         RUVyxhgPtcn4BY5WevJqrOHsMpLLiRpBgppCdaEqzoeZFmG6Bt/DvEvl2J5VKb4ZrVDq
         tXhA==
X-Gm-Message-State: AOAM532hzrCGyqIiIjBJZf1vtFPSycqgnt0kacapBFzRReYedb4g3ZE6
        EJ+cJ9QNy3Hz35rkVvDGUuM=
X-Google-Smtp-Source: ABdhPJzshge6v2vY4iUXHobSSJLkYGBPQOkKGauXpWvek8cCyVK9Ulx3zy4dc1KQJ+LfnbSkhwBfgA==
X-Received: by 2002:a05:6638:2650:: with SMTP id n16mr4713605jat.72.1636042720914;
        Thu, 04 Nov 2021 09:18:40 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id e17sm3266326iow.18.2021.11.04.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:18:40 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, ariel.dalessandro@collabora.com,
        krzk@kernel.org, tharvey@gateworks.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 7/9] arm64: dts: imx8mn: put USB controller into power-domains
Date:   Thu,  4 Nov 2021 11:18:02 -0500
Message-Id: <20211104161804.587250-8-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211104161804.587250-1-aford173@gmail.com>
References: <20211104161804.587250-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have support for the power domain controller on the i.MX8MN,
we can put the USB controller in the respective power domain to allow
it to power down the PHY when possible.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index f5bafd9db673..4e9d7099bb4f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1021,6 +1021,7 @@ usbotg1: usb@32e40000 {
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_otg1>;
 				status = "disabled";
 			};
 
-- 
2.32.0

