Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC5D3F8AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbhHZPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 11:21:42 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:56490 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242904AbhHZPVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1629991250; x=1632583250;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LfHR+esUZqjukvcNKRaf39fw5s9wBCQeVlt2BZrLEOk=;
        b=t7fforA6zG/rrswdR4SY8onuqW6nrhnulxA8Uk+qTGZDqRqQ/y7UO0BTR62nqTyM
        IU7c2iHRLMZ62dOsCUD7s7ig8+wXYwcnmnLODf/T+jJN1i4OqufyAKaSAhLhIx2X
        FHJpBHsd3SOz2wBYAubd3S1MWeyIX3IvpKwISQvfOzk=;
X-AuditID: c39127d2-777be70000001c5c-17-6127b1529c5c
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EF.C0.07260.251B7216; Thu, 26 Aug 2021 17:20:50 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021082617204983-1475685 ;
          Thu, 26 Aug 2021 17:20:49 +0200 
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
Subject: [PATCH 1/2] clk: imx: imx6ul: Move csi_sel mux to correct base register
Date:   Thu, 26 Aug 2021 17:20:48 +0200
Message-Id: <20210826152049.4175381-1-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 26.08.2021 17:20:50,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 26.08.2021 17:20:50
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWyRoCBSzdoo3qiQd8SPotll44yWjy86m+x
        aupOFotNj6+xWnzsucdq0fVrJbPF5V1z2CwunnK1+Lt9E4vFv2sbWSxebBF34PZ4f6OV3WPn
        rLvsHptWdbJ5bF5S77Hx3Q4mj/6/Bh6fN8kFsEdx2aSk5mSWpRbp2yVwZSx9uJy94JhYRU9b
        B3MD40PhLkZODgkBE4mOPX+Zuhi5OIQEtjFKdO+8zA7hXGCUaOpazQZSxSZgJLFgWiNYlYjA
        dkaJF933GUESzAIdTBLzZriB2MICARLb961lAbFZBFQlPt3dyQRi8wrYSXQ9P8IIsU5eYual
        7+wQcUGJkzOfsIAMlRC4wijR3/CLBaJISOL04rPMEAu0JZYtfM08gZFvFpKeWUhSCxiZVjEK
        5WYmZ6cWZWbrFWRUlqQm66WkbmIEhvPhieqXdjD2zfE4xMjEwXiIUYKDWUmEd8F3tUQh3pTE
        yqrUovz4otKc1OJDjNIcLErivPd7mBKFBNITS1KzU1MLUotgskwcnFINjOoCYTrNe5Or3quv
        u8K273U3l/ehbt1D6sdbtINXGVZOFDHc3iIUeu+nx292M5nA2Vu4eG2fGcokGZ7elFTv1lt+
        tf3Avmrlpi/ThAseFJ1pylTIPKQlU3qI/bmlzoo9rfIv2S9nJv++97bpeOz7v+KKZ3ZyWWqk
        pPMLzP928sSHF+84zvSaK7EUZyQaajEXFScCAOjCzutVAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The csi=5Fsel mux register is located in the CCM register base and not the
CCM=5FANALOG register base. So move it to the correct position in code.

Otherwise changing the parent of the csi clock can lead to a complete
system failure due to the CCM=5FANALOG=5FPLL=5FSYS=5FTOG register being fal=
sely
modified.

Also remove the SET=5FRATE=5FPARENT flag since one possible supply for the
csi=5Fsel mux is the system PLL which we don't want to modify.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 drivers/clk/imx/clk-imx6ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 5dbb6a937732..206e4c43f68f 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -161,7 +161,6 @@ static void =5F=5Finit imx6ul=5Fclocks=5Finit(struct de=
vice=5Fnode *ccm=5Fnode)
 	hws[IMX6UL=5FPLL5=5FBYPASS] =3D imx=5Fclk=5Fhw=5Fmux=5Fflags("pll5=5Fbypa=
ss", base + 0xa0, 16, 1, pll5=5Fbypass=5Fsels, ARRAY=5FSIZE(pll5=5Fbypass=
=5Fsels), CLK=5FSET=5FRATE=5FPARENT);
 	hws[IMX6UL=5FPLL6=5FBYPASS] =3D imx=5Fclk=5Fhw=5Fmux=5Fflags("pll6=5Fbypa=
ss", base + 0xe0, 16, 1, pll6=5Fbypass=5Fsels, ARRAY=5FSIZE(pll6=5Fbypass=
=5Fsels), CLK=5FSET=5FRATE=5FPARENT);
 	hws[IMX6UL=5FPLL7=5FBYPASS] =3D imx=5Fclk=5Fhw=5Fmux=5Fflags("pll7=5Fbypa=
ss", base + 0x20, 16, 1, pll7=5Fbypass=5Fsels, ARRAY=5FSIZE(pll7=5Fbypass=
=5Fsels), CLK=5FSET=5FRATE=5FPARENT);
-	hws[IMX6UL=5FCLK=5FCSI=5FSEL] =3D imx=5Fclk=5Fhw=5Fmux=5Fflags("csi=5Fsel=
", base + 0x3c, 9, 2, csi=5Fsels, ARRAY=5FSIZE(csi=5Fsels), CLK=5FSET=5FRAT=
E=5FPARENT);
=20
 	/* Do not bypass PLLs initially */
 	clk=5Fset=5Fparent(hws[IMX6UL=5FPLL1=5FBYPASS]->clk, hws[IMX6UL=5FCLK=5FP=
LL1]->clk);
@@ -270,6 +269,7 @@ static void =5F=5Finit imx6ul=5Fclocks=5Finit(struct de=
vice=5Fnode *ccm=5Fnode)
 	hws[IMX6UL=5FCLK=5FECSPI=5FSEL]	  =3D imx=5Fclk=5Fhw=5Fmux("ecspi=5Fsel",=
	base + 0x38, 18, 1, ecspi=5Fsels, ARRAY=5FSIZE(ecspi=5Fsels));
 	hws[IMX6UL=5FCLK=5FLCDIF=5FPRE=5FSEL]	  =3D imx=5Fclk=5Fhw=5Fmux=5Fflags(=
"lcdif=5Fpre=5Fsel", base + 0x38, 15, 3, lcdif=5Fpre=5Fsels, ARRAY=5FSIZE(l=
cdif=5Fpre=5Fsels), CLK=5FSET=5FRATE=5FPARENT);
 	hws[IMX6UL=5FCLK=5FLCDIF=5FSEL]	  =3D imx=5Fclk=5Fhw=5Fmux("lcdif=5Fsel",=
	base + 0x38, 9, 3, lcdif=5Fsels, ARRAY=5FSIZE(lcdif=5Fsels));
+	hws[IMX6UL=5FCLK=5FCSI=5FSEL]		  =3D imx=5Fclk=5Fhw=5Fmux("csi=5Fsel", ba=
se + 0x3c, 9, 2, csi=5Fsels, ARRAY=5FSIZE(csi=5Fsels));
=20
 	hws[IMX6UL=5FCLK=5FLDB=5FDI0=5FDIV=5FSEL]  =3D imx=5Fclk=5Fhw=5Fmux("ldb=
=5Fdi0", base + 0x20, 10, 1, ldb=5Fdi0=5Fdiv=5Fsels, ARRAY=5FSIZE(ldb=5Fdi0=
=5Fdiv=5Fsels));
 	hws[IMX6UL=5FCLK=5FLDB=5FDI1=5FDIV=5FSEL]  =3D imx=5Fclk=5Fhw=5Fmux("ldb=
=5Fdi1", base + 0x20, 11, 1, ldb=5Fdi1=5Fdiv=5Fsels, ARRAY=5FSIZE(ldb=5Fdi1=
=5Fdiv=5Fsels));
--=20
2.25.1

