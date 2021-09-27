Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7075D419002
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhI0Hai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:30:38 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:60684 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbhI0Hag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1632727738; x=1635319738;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HCXR0qaq8e2WGlSq+apDDiCnECGqMM9ONRMb9OHWyE8=;
        b=EFZI6yU8fDNleeadxVJsal1GoHz1iM+wUzVoTeziZ6Tkv4V0vRWr5xs1k52HvjdY
        1Pi+lRLjnBdl9uxtd56vR60liquXoFFXF36wk4LGhKOdmbzTmMpoeoEbwtCuvims
        dhCsSEinpQW9oEbpDTSNJd/brIY950P4JG1chw5qi8E=;
X-AuditID: c39127d2-c275470000001d24-d9-615172bafc72
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A9.B9.07460.AB271516; Mon, 27 Sep 2021 09:28:58 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021092709285769-1755087 ;
          Mon, 27 Sep 2021 09:28:57 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Stefan Riedmueller <s.riedmueller@phytec.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: imx: imx6ul: Fix csi clk gate register
Date:   Mon, 27 Sep 2021 09:28:57 +0200
Message-Id: <20210927072857.3940880-2-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210927072857.3940880-1-s.riedmueller@phytec.de>
References: <20210927072857.3940880-1-s.riedmueller@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.09.2021 09:28:57,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.09.2021 09:28:57
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWyRoCBS3dXUWCiwcIbjBbLLh1ltHh41d9i
        1dSdLBabHl9jtfjYc4/VouvXSmaLy7vmsFlcPOVq8Xf7JhaLf9c2sli82CLuwO3x/kYru8fO
        WXfZPTat6mTz2Lyk3mPjux1MHv1/DTw+b5ILYI/isklJzcksSy3St0vgyrh4Xbhgg3DFs4Xf
        2BsYFwt0MXJySAiYSPzdtou5i5GLQ0hgG6PEzEtfmCCcC4wSF9rusIJUsQkYSSyY1giWEBHY
        zijxovs+I4jDLNDBJPF2xTpGkCphAWeJk/vbgGZxcLAIqEoseiUDEuYVsJN4M2U6C8Q6eaAN
        39lBbE4Be4kDyxqYQGwhoJqeXfNYIeoFJU7OfMICMl9C4AqjxN07F9kgmoUkTi8+ywxiMwto
        Syxb+Jp5AqPALCQ9s5CkFjAyrWIUys1Mzk4tyszWK8ioLElN1ktJ3cQIDP7DE9Uv7WDsm+Nx
        iJGJg/EQowQHs5IIbzCLf6IQb0piZVVqUX58UWlOavEhRmkOFiVx3vs9TIlCAumJJanZqakF
        qUUwWSYOTqkGxpXqx/PmXi5Ya7vuIL/pbo4jsdO63++0id38+cG5EFvhnAvTHqXlpEvoPXwR
        PC+5YuOHI7ovFVQvNImlpT3Ze+pQVFZJztLZXEtLtpSLzTX1/3bT067yqefLzcfDOLWP77Bq
        TJGf8fHs7N+f9zZsPH2r7HxT1ZErAsrXM477Ki2fpHLCUfHrMgslluKMREMt5qLiRACFwSRq
        bAIAAA==
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
Tested-by: Fabio Estevam <festevam@gmail.com>
---
Changes in v2:
 - Added comment about ref manual mismatch
 - Added Tested-by from Fabio
---
 drivers/clk/imx/clk-imx6ul.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 206e4c43f68f..520b100bff4b 100644
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
@@ -391,6 +390,12 @@ static void =5F=5Finit imx6ul=5Fclocks=5Finit(struct d=
evice=5Fnode *ccm=5Fnode)
 	hws[IMX6UL=5FCLK=5FPXP]		=3D imx=5Fclk=5Fhw=5Fgate2("pxp",		"axi",		base =
+ 0x70,	30);
=20
 	/* CCGR3 */
+	/*
+	 * Although the imx6ull reference manual lists CCGR2 as the csi clk
+	 * gate register, tests have shown that it is actually the CCGR3
+	 * register bit 0/1, same as for the imx6ul.
+	 */
+	hws[IMX6UL=5FCLK=5FCSI]		=3D imx=5Fclk=5Fhw=5Fgate2("csi",	"csi=5Fpodf",	=
base + 0x74,	0);
 	hws[IMX6UL=5FCLK=5FUART5=5FIPG]	=3D imx=5Fclk=5Fhw=5Fgate2("uart5=5Fipg",=
	"ipg",		base + 0x74,	2);
 	hws[IMX6UL=5FCLK=5FUART5=5FSERIAL]	=3D imx=5Fclk=5Fhw=5Fgate2("uart5=5Fse=
rial",	"uart=5Fpodf",	base + 0x74,	2);
 	if (clk=5Fon=5Fimx6ul()) {
--=20
2.25.1

