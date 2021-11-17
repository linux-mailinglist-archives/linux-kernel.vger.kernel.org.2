Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA2454749
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbhKQNfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhKQNfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:35:10 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA079C061764;
        Wed, 17 Nov 2021 05:32:11 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id 8so2591326qtx.5;
        Wed, 17 Nov 2021 05:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+vy1Tb9YFr84RmlB3AJ4vwvLVwlNlrB/1q9IGAyrEA=;
        b=bNKY+gtDtzIiwz4L+cuAGf8u8aVmbbjT7Sb7NbSQLx2yzKqQ5Qsg3Yn58cC6w4S9Lt
         pnJfoODf5gDYmY+BPpmKBqjMVtBM+XTkoB8quIBe7Y1HKiFRADjAcL9FrULXYqkgkuJU
         pMJ9AhiJO7TJZrbSbbIQigCZhIB1gvhKvDMn2F3dVwVlcHVAQURQQ0dbInJTNV2vHe+/
         wyRYJOHHqUKYzFZZMEXb+DdWYIqf3ao+aBIF21LNQw+eym4SAetlt9IgT3kpqZd2nVrN
         ZCYLJ00jRXSaAcsrw5Tx+sBeGzYhGSpd+NBPKIRgca8O2hr7ju+0zBz1PXQdZcNVVEYC
         waPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+vy1Tb9YFr84RmlB3AJ4vwvLVwlNlrB/1q9IGAyrEA=;
        b=2C3bLcI6/B479N4yQ+kYxu7dPU4i52s8fSkL5aSa2W0mPBuMv9ugiaA6LoSiSCn0F0
         mRsMJAr7yOVwpNDYV/OTMOH5008SwWEBYLjAWWxT9YrI/0hEw9zuvkCVWBKfTR0ySXet
         uWcl3aAiwn6GLZHjuIyAsTLTZ2+S8dtXyuI7IVOl9ThbQOtETEsUXqQHRtfbYyXUBDYN
         evzWTh9IkMg0VI0d/wWGZQ+SSPoBy4RhGnricDSTyf+JIiqWzsNnQB0pXb6VFbkElVnJ
         j4MB+1FPvzSjeCuzZpucG6ofx15gIG0Kr+o926u9XxvIoYr6HjTlk2IHGrxLwxGNKSJv
         mOpw==
X-Gm-Message-State: AOAM531VwrtiE/Ehn0V2xXHEHkgUJA8X5k20tizXXBF+mql5o9aYRVyM
        wRCOViZhNWhyb4/xzFPjni1Ndn41jHg=
X-Google-Smtp-Source: ABdhPJzUmLkAvzGauT7l1Ljxu5j6zNhu+o2GrshVf+Wwb4j6G3O76fuJF/hDci4B4df6Ke44BxeSCA==
X-Received: by 2002:ac8:59c5:: with SMTP id f5mr16956841qtf.135.1637155930158;
        Wed, 17 Nov 2021 05:32:10 -0800 (PST)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id v5sm10411448qtc.60.2021.11.17.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 05:32:09 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, cstevens@beaconembedded.com,
        Adam Ford <aford173@gmail.com>, Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] clk: imx8mn: Fix imx8mn_clko1_sels
Date:   Wed, 17 Nov 2021 07:32:02 -0600
Message-Id: <20211117133202.775633-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to use sys_pll1_80m as the parent for clko1, the
system hangs.  This is due to the fact that the source select
for sys_pll1_80m was incorrectly pointing to m7_alt_pll_clk, which
doesn't yet exist.

According to Rev 3 of the TRM, The imx8mn_clko1_sels also incorrectly
references an osc_27m which does not exist, nor does an entry for
source select bits 010b.  Fix both by inserting a dummy clock into
the missing space in the table and renaming the incorrectly name clock
with dummy.

Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index c55577604e16..021355a24708 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -277,9 +277,9 @@ static const char * const imx8mn_pdm_sels[] = {"osc_24m", "sys_pll2_100m", "audi
 
 static const char * const imx8mn_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
 
-static const char * const imx8mn_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "osc_27m",
-						 "sys_pll1_200m", "audio_pll2_out", "vpu_pll",
-						 "sys_pll1_80m", };
+static const char * const imx8mn_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "dummy",
+						 "sys_pll1_200m", "audio_pll2_out", "sys_pll2_500m",
+						 "dummy", "sys_pll1_80m", };
 static const char * const imx8mn_clko2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_400m",
 						 "sys_pll2_166m", "sys_pll3_out", "audio_pll1_out",
 						 "video_pll1_out", "osc_32k", };
-- 
2.32.0

