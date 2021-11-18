Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC5455645
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbhKRIJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244211AbhKRIJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:09:46 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C5C061766;
        Thu, 18 Nov 2021 00:06:46 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c4so5206417pfj.2;
        Thu, 18 Nov 2021 00:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mgsW5zpR+Fm95RGExIosgA746rEyU+7rhONWYOnX1Rk=;
        b=H/DiSYB/EeZjNLx8luIFk2VR/wseaF0CdLbORuJ8EKsjre+JUuFVxer/aVcz38VuRz
         PsR+0DgYx8GVtADYU/p+CJ0RusxDpXavABuTAoPV7nphRRCiRy/BDpSqZ1UNcGMDDZs0
         D5rdEhnks9j8Y2y0RsIWrhjMst8hDJhISKHPUfQI3O8e6CPbrHF52r8gb2Tmhg+J3k3A
         0JxDKiZPMpzbrbuysDgM7jgfgqF5xOKn7PNXtC81Kz1zeLeBcZ8fATZN2nhnGmA7BuN/
         o+hdRkekDWdUq96A4LX5yxTOpBc4Oxdfp/M+rRp0EYywjajWMYFhOzx+E4RhLVhbwTP1
         v3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mgsW5zpR+Fm95RGExIosgA746rEyU+7rhONWYOnX1Rk=;
        b=6HDb+4xGv3s4jt8+Mhf7VTi7AKqoNWxLXfYoU9+DhQzuYzeKH8e7XMTPWkJTAxyjf+
         auh3nLPKYbAesvWu8CB4XieNufm2PH2Id0z0FAZiT/B5+PfENMqlP94bWY5Mss2JEnF/
         a/39Fk0TbDifVKCk8y0Hvf/gjDIrJVSKU1RQ/Hev22B5/A3KlLC5HB2J2gQnVTfkjnlA
         bNrWOzqmNeYI7qRlIt6rPrEP9J2b4lZnKzglTMbApEAcwRZ8+MGWBNaSUnXNo0GzOkDw
         MmZc0k17swfsZkpWUyT6VFB+SHCubHGG5PBWBP3qN1eYCq4j8c32kgT/N/MXKjaU0zN1
         xrSg==
X-Gm-Message-State: AOAM533LdxQ2a/Wia9xpHObc9XDS0RyZGLKVtXh9JNordmpGhYcIsEaX
        6fVZz9uQqel202S23XRUNWA=
X-Google-Smtp-Source: ABdhPJxvosdAe2opzaUx5WWXZ2+z4gCEp104QdiNmmGOOWUY9uttvBO+2aulTLBr89cNYxvR6w93Kw==
X-Received: by 2002:a05:6a00:26e3:b0:49f:c0ca:850e with SMTP id p35-20020a056a0026e300b0049fc0ca850emr54156983pfw.4.1637222806262;
        Thu, 18 Nov 2021 00:06:46 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h3sm2311640pfi.207.2021.11.18.00.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 00:06:45 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     abel.vesa@nxp.com
Cc:     festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, s.hauer@pengutronix.de, sboyd@kernel.org,
        shawnguo@kernel.org, zealci@zte.com.cn, cgel.zte@gmail.com,
        deng.changcheng@zte.com.cn
Subject: [PATCH v2] clk: imx: Use div64_ul instead of do_div
Date:   Thu, 18 Nov 2021 08:06:34 +0000
Message-Id: <20211118080634.165275-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117013853.158777-1-deng.changcheng@zte.com.cn>
References: <20211117013853.158777-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. Here the divisor is an unsigned long
which on some platforms is 64 bit wide. So use div64_ul instead of do_div
to avoid a possible truncation.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/clk/imx/clk-pllv3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 20ee9611ba6e..55497e0585a6 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -247,7 +247,7 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
 	div = rate / parent_rate;
 	temp64 = (u64) (rate - div * parent_rate);
 	temp64 *= mfd;
-	do_div(temp64, parent_rate);
+	temp64 = div64_ul(temp64, parent_rate);
 	mfn = temp64;
 
 	temp64 = (u64)parent_rate;
@@ -277,7 +277,7 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	div = rate / parent_rate;
 	temp64 = (u64) (rate - div * parent_rate);
 	temp64 *= mfd;
-	do_div(temp64, parent_rate);
+	temp64 = div64_ul(temp64, parent_rate);
 	mfn = temp64;
 
 	val = readl_relaxed(pll->base);
@@ -334,7 +334,7 @@ static struct clk_pllv3_vf610_mf clk_pllv3_vf610_rate_to_mf(
 		/* rate = parent_rate * (mfi + mfn/mfd) */
 		temp64 = rate - parent_rate * mf.mfi;
 		temp64 *= mf.mfd;
-		do_div(temp64, parent_rate);
+		temp64 = div64_ul(temp64, parent_rate);
 		mf.mfn = temp64;
 	}
 
-- 
2.25.1

