Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD01B460679
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357890AbhK1N0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245690AbhK1NYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:24:32 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5D4C061574;
        Sun, 28 Nov 2021 05:19:29 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id z8so3985071ilu.7;
        Sun, 28 Nov 2021 05:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVqTSYrJM1goRfJXek0SWHYdIHEW/tVUJHkNkTLcnhY=;
        b=pnJMEqOhAhwE7YQ0cmi+JUA83cY+1rctJICirfRdROTF8+rTYGdkNqReO1olHpNAey
         ESLUYH+fwMhs6w6XYOOeL3XHlWEdBsj3KlKJx29JDQikzILfZxN8RgNUbvdC/MTOZpnS
         JARsYTDbEFiV/q3HQgL4Us/0akbxI1ako7mVAz9XYidqDo4oBjci4OO1FDVphIbXorsU
         g0ClVgzBANPvBKx2hinzao+EpeisYo+jH9oYw9/VrsmEh05sk2OLdmeKC9wvOyXgoLwC
         nw3KofzsfnbAx5yc+B6sXl+vlrvLPQQjBeLkVaQa1NN8KGH3xRlNhIYqgZMtM9KzeaYh
         MzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVqTSYrJM1goRfJXek0SWHYdIHEW/tVUJHkNkTLcnhY=;
        b=L2fwFw/+lDfRhYoMloiqKkhjb0JmiSu7ZnAliGveG01ISLvZa1+z31G7ZTsywLTL3w
         vDz/ycqQv6ob0e7iMI0hf9M42r3n0lbCM2Y07S8VOtXyMwiSaOGmHi0EmPJWM6cRNvcs
         zB6WP1ZKTz8e+i7BYnjt7fSJuQIg1EmQzDx9QzlxT1Il4z6NKOX2MIB2RdPdOB+hcDnZ
         r2tclDTsPJ4hdnAJskAjtnP2ETIToZjraqrtjerHIJM1JxlrLTxKO2qwq4r1XIejSrAH
         DS9y2B2+cQHrz23WvmMuN5XpI2Q82Kl43cSAiJsHlCTZs+/A3EP3CBJfWihsg43tHoxD
         yACA==
X-Gm-Message-State: AOAM533f78OOcIwhdM4HmQdCKbyCMbdqqRUWWipEnCmG2ytMlDg8nPz9
        xlGJ9hHg1SayYzagFuIUdtS4Hrg0Vo2eJg==
X-Google-Smtp-Source: ABdhPJzxvRJBnMM1KQP9E/SEzKC+NMSJi7gIKSCf5tviihotiveMGVbE7PIJmSMK9wRAb9HU2Rl5pg==
X-Received: by 2002:a92:7d11:: with SMTP id y17mr41594638ilc.223.1638105568826;
        Sun, 28 Nov 2021 05:19:28 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id q12sm6990413ile.77.2021.11.28.05.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:19:28 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 7/9] arm64: dts: imx8mn: put USB controller into power-domains
Date:   Sun, 28 Nov 2021 07:18:50 -0600
Message-Id: <20211128131853.15125-8-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128131853.15125-1-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
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
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index ef1699a9cd7d..902d5725dc55 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1049,6 +1049,7 @@ usbotg1: usb@32e40000 {
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_otg1>;
 				status = "disabled";
 			};

--
2.32.0

