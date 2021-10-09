Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7938427BED
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhJIQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhJIQ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:29:17 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6953C061570;
        Sat,  9 Oct 2021 09:27:20 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r134so3267057iod.11;
        Sat, 09 Oct 2021 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTRWJ0+geg/Q+VvyzY0P5f/pbfTOM2Qw4iCzF8elDzw=;
        b=H6CxIL0WlaSA/YKWPOnLQiLITx6jJPx2G+P3lp/NckyTEluuCGe9NBdnKaf8QrELr8
         Z+Nb8KiUPBpT5sbjUHHtKe8MPZCg5Mn+bo97S8Zd2eryKXNojr2bMLcaWsvJ4lu55xJL
         5Q/UFvYevYMlj3dJWJudqJlHfF1AEnhgN+lVe7ZTH8+oKw6a0POREe/GUn6YqvmNYeng
         Z1SAaL1JUPrflAlbwDo7WIk9GHZ5Fy8RW9MFtKcd80GvezSvklr3TN66Qr/JYrp0mNWn
         TpiAHuYMFmDTnXgFjZt2oi0vCGlHo3iAVJScbCmaZxgdJinZTz0+ibqk68v3KMnIVd3X
         R+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTRWJ0+geg/Q+VvyzY0P5f/pbfTOM2Qw4iCzF8elDzw=;
        b=JuFH/KS5UILR+emjMfErOLJL+3DE33/Ds70kX/zeRLDd10Nx2UJ3U5/oFw3bw9RE5d
         C56d/x679OfbGgTGLrAvulk2QzC8fIf96HtJFIh9hyAXGudNxUtqDezzIjqSB4QPLW7v
         pCo324IcoVsB60XlKo13agXcqd+dB+14vNQAFWBBk/6VsqgTJxjff72yQFxtfHR6Sl4M
         M3AUcH4mu++kGiDcAKxOxig9hsD7O12I4s0ropJcoYdhyVhSjufGQdRbMzpBe4xOO5m8
         Gvj0Plv0FjmgDNRRzhKvMAwjFA+jPnXwHHSdLzONk7JcRe2r+AnbLFQmuElvRzBOMjiX
         Sx4g==
X-Gm-Message-State: AOAM533e7OIv4yYwiLRFk5AxJjbV9CBYG0snx28TG4SZsSCft6Nl1tef
        tP017ndA7HZ9K6VUTF9JZKE=
X-Google-Smtp-Source: ABdhPJzOplxSY4beEbL/NXEefPKnRIDUj1PSKsIGUYcW4FJMOEgPOVbi3Ps4cVXmpQUbH5mso31iQg==
X-Received: by 2002:a6b:6901:: with SMTP id e1mr11886899ioc.137.1633796839927;
        Sat, 09 Oct 2021 09:27:19 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:cb0f:c46c:9a27:ace])
        by smtp.gmail.com with ESMTPSA id y5sm1253722ilg.58.2021.10.09.09.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 09:27:19 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/9] soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
Date:   Sat,  9 Oct 2021 11:26:51 -0500
Message-Id: <20211009162700.1452857-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009162700.1452857-1-aford173@gmail.com>
References: <20211009162700.1452857-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the i.MX8MM, keep the gpumix clocks running when the
domain is active.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index b8d52d8d29db..95f05575f843 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -840,6 +840,7 @@ static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
 			.hskack = IMX8MN_GPUMIX_HSK_PWRDNACKN,
 		},
 		.pgc   = BIT(IMX8MN_PGC_GPUMIX),
+		.keep_clocks = true,
 	},
 };
 
-- 
2.25.1

