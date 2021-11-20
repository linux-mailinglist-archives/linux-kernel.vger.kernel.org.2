Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D030B45801F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 20:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhKTTme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 14:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhKTTmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 14:42:33 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECB3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 11:39:29 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id t8so3910950ilu.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 11:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HEMff71RlaXqe7RhjG4RiJigQfl+s6363OujmoYTTX0=;
        b=AXqO+SpOoyiKRPwLgibCLtw2qn3hesnIUyNCtggQ+gBS+uxQb0WCx0wWSmMtmIz5yp
         f9SXuyrS2A2BHL3iMtY2jdShZyZ9EuMG1jioRjWnXTzdectn6LzN90fqB5e9zhcYg9IA
         EZ49/fHiBF2b5fqxSmbnVkh+KwCcBfIuyF5pz8A2DT3BvvQmhp42KVQHRIkQJl49W0Gx
         F8QNiW0CI0bVfYhG/sVIKmsn0nnTL88nEjElfiNRwS/WjkPKZbUuRTnIsEVa7ErJViXd
         YfP9D0GeHdckoVocR2hJ36Mgyotyjf1/Bp9txoAJMTJVLV6ExPZuCDuqhYp2TB2x++e8
         LEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HEMff71RlaXqe7RhjG4RiJigQfl+s6363OujmoYTTX0=;
        b=s+rF6yKNsUJ++M9zkuzpExjD6MQDiw1kPFy355j++RcO9Vf+xP1YHf/x4SMFGwyPDT
         cP7x7YQ+XoXpXwnTgM4cp1Fqr3kRDSw1/D6+medbws8wANkArhPMOwfC3dSwWorkpCs2
         ksxrBWp/tUBTEY3H3SwYsKkqUrru2JivffXO63dX68ohUnUX2Kw5W3886pkkLYbUed98
         3LpMK3cM53G7ELJnWA3lV9d1oFQAwvCfOzhxhecluoprFAS8vKGyMD7nWDb3jkgIAk++
         Df48Oomcxo5029fE1+XEfmoVFYWJcrY15OuFzG/MdATOxDNhGanu96P33QeUmG9+NenV
         H+GA==
X-Gm-Message-State: AOAM530sj0JqucSAowAQBoyVoDkJUiMtRmT8QC9mcjsxx8/fb94sgRVd
        WrHMz02khdRnykyVJm/zOi9VGq4g8cO6v0p2
X-Google-Smtp-Source: ABdhPJzmqccMF1OFCxJXonwKLorfBJ+Lhc7j6k2agLmQFWUQV8T0Jx6GgW9Cm0zf8QeQ1apkE1rkzQ==
X-Received: by 2002:a05:6e02:1707:: with SMTP id u7mr11240790ill.210.1637437168081;
        Sat, 20 Nov 2021 11:39:28 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:de9c:9e61:8791:1fd7])
        by smtp.gmail.com with ESMTPSA id j3sm2414916ilu.64.2021.11.20.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 11:39:27 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx: gpcv2: keep i.MX8MM VPU-H1 bus clock active
Date:   Sat, 20 Nov 2021 13:39:16 -0600
Message-Id: <20211120193916.1309236-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the vpu-h1 clock when the domain is active because reading
or writing to the VPU-H1 IP block cause the system to hang.

Fixes: 656ade7aa42a ("soc: imx: gpcv2: keep i.MX8M* bus clocks enabled")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index b8d52d8d29db..7b6dfa33dcb9 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -734,6 +734,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 			.map = IMX8MM_VPUH1_A53_DOMAIN,
 		},
 		.pgc   = BIT(IMX8MM_PGC_VPUH1),
+		.keep_clocks = true,
 	},
 
 	[IMX8MM_POWER_DOMAIN_DISPMIX] = {
-- 
2.32.0

