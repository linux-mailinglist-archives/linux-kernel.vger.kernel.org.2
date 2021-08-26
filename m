Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399953F8AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbhHZPVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:21:40 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:56496 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbhHZPVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1629991250; x=1632583250;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=duOsq4MHaTArCqJvE67LMUe9FgHH8uyGmRkCSJuLJN0=;
        b=W8Q6PkhkYNakRdYJZdb1pYomZfJIL8ZlAvFzoNa/NTFXZ63wx3j8LtyXEyadzZUN
        DIVMvxbql1xjTXAXFs2R99R0sPNjbEVWnX3GdB636t73SIE9K58aof6hIA+7GAP8
        J9xb79HTqt9zPFC8qpQLUdS5FKdbwgoKDe2BlRsBpaM=;
X-AuditID: c39127d2-c85d824000001c5c-18-6127b152e179
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id FF.C0.07260.251B7216; Thu, 26 Aug 2021 17:20:50 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021082617205010-1475686 ;
          Thu, 26 Aug 2021 17:20:50 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Stefan Riedmueller <s.riedmueller@phytec.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: imx: imx6ul: Fix csi clk gate register
Date:   Thu, 26 Aug 2021 17:20:49 +0200
Message-Id: <20210826152049.4175381-2-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826152049.4175381-1-s.riedmueller@phytec.de>
References: <20210826152049.4175381-1-s.riedmueller@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 26.08.2021 17:20:50,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 26.08.2021 17:20:50
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWyRoCBSzdoo3qiwfpOfotll44yWjy86m+x
        aupOFotNj6+xWnzsucdq0fVrJbPF5V1z2CwunnK1+Lt9E4vFv2sbWSxebBF34PZ4f6OV3WPn
        rLvsHptWdbJ5bF5S77Hx3Q4mj/6/Bh6fN8kFsEdx2aSk5mSWpRbp2yVwZWy5/5Sp4JJAxYa1
        21gbGCfydTFyckgImEjsbNjK2sXIxSEksI1RYk7bIkYI5wKjxPOpv5hBqtgEjCQWTGtkAkmI
        CGxnlHjRfZ8RJMEs0MEkMW+GG4gtLOAgcXPZLDYQm0VAVeLg99tMIDavgJ3EmcXf2CDWyUvM
        vPSdHcTmFLCX2DupAyjOAbTNTmL6uyCIckGJkzOfsIDskhC4wijR3/CLBaJXSOL04rPMEHu1
        JZYtfM08gVFgFpKeWUhSCxiZVjEK5WYmZ6cWZWbrFWRUlqQm66WkbmIEBv/hieqXdjD2zfE4
        xMjEwXiIUYKDWUmEd8F3tUQh3pTEyqrUovz4otKc1OJDjNIcLErivPd7mBKFBNITS1KzU1ML
        UotgskwcnFINjO7NZlOrgFG4enXAh0cs3wNbNe4s3dL/frZ/xK/ar29k3IJmtWy5kBf0Wfp2
        WNiktccK9n8SFn432/zkmxdbNNV3d13t/my0eu7DGfPrr32fqMoUyVKRsn3R/haNM/f+7fT4
        IGkW7uB+mmFbpPEtFUXX7SXcUYvOMZ/TmNoi5tY5tbuqqPyZqBJLcUaioRZzUXEiAHeDBlFs
        AgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the imx6ul Reference Manual the csi clk gate register is
CCM=5FCCGR3 (offset 0x74) bit 0/1. For the imx6ull on the other hand the
Reference Manual lists register CCM=5FCCGR2 (offset 0x70) bit 2/3 as the
csi clk gate which is the current setting.

Tests have shown though that the correct csi clk gate register for the
imx6ull is actually CCM=5FCCGR3 bit 0/1 as well. Thus set the correct
register for both platforms.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 drivers/clk/imx/clk-imx6ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 206e4c43f68f..5dd222fab01b 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -380,7 +380,6 @@ static void =5F=5Finit imx6ul=5Fclocks=5Finit(struct de=
vice=5Fnode *ccm=5Fnode)
 		hws[IMX6ULL=5FCLK=5FESAI=5FIPG]	=3D imx=5Fclk=5Fhw=5Fgate2=5Fshared("esa=
i=5Fipg",	"ahb",		base + 0x70,	0, &share=5Fcount=5Fesai);
 		hws[IMX6ULL=5FCLK=5FESAI=5FMEM]	=3D imx=5Fclk=5Fhw=5Fgate2=5Fshared("esa=
i=5Fmem",	"ahb",		base + 0x70,	0, &share=5Fcount=5Fesai);
 	}
-	hws[IMX6UL=5FCLK=5FCSI]		=3D imx=5Fclk=5Fhw=5Fgate2("csi",		"csi=5Fpodf",=
		base + 0x70,	2);
 	hws[IMX6UL=5FCLK=5FI2C1]		=3D imx=5Fclk=5Fhw=5Fgate2("i2c1",		"perclk",	b=
ase + 0x70,	6);
 	hws[IMX6UL=5FCLK=5FI2C2]		=3D imx=5Fclk=5Fhw=5Fgate2("i2c2",		"perclk",	b=
ase + 0x70,	8);
 	hws[IMX6UL=5FCLK=5FI2C3]		=3D imx=5Fclk=5Fhw=5Fgate2("i2c3",		"perclk",	b=
ase + 0x70,	10);
@@ -391,6 +390,7 @@ static void =5F=5Finit imx6ul=5Fclocks=5Finit(struct de=
vice=5Fnode *ccm=5Fnode)
 	hws[IMX6UL=5FCLK=5FPXP]		=3D imx=5Fclk=5Fhw=5Fgate2("pxp",		"axi",		base =
+ 0x70,	30);
=20
 	/* CCGR3 */
+	hws[IMX6UL=5FCLK=5FCSI]		=3D imx=5Fclk=5Fhw=5Fgate2("csi",	"csi=5Fpodf",	=
base + 0x74,	0);
 	hws[IMX6UL=5FCLK=5FUART5=5FIPG]	=3D imx=5Fclk=5Fhw=5Fgate2("uart5=5Fipg",=
	"ipg",		base + 0x74,	2);
 	hws[IMX6UL=5FCLK=5FUART5=5FSERIAL]	=3D imx=5Fclk=5Fhw=5Fgate2("uart5=5Fse=
rial",	"uart=5Fpodf",	base + 0x74,	2);
 	if (clk=5Fon=5Fimx6ul()) {
--=20
2.25.1

