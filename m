Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050F0419001
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhI0Hah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:30:37 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:60684 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbhI0Hag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1632727737; x=1635319737;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LBHyPmsc7ITO9RbPpLS+GT21giX8IHL4T/2PGX053MM=;
        b=NIv8375QmCoMRrJ+vkNaohuhJNB+IPrbUhRoV83/3PB61sBf4BSpXYKvSy+KRUtp
        IUhx38zGN1uHqivJQm4fCA9sTrYcQf76FS3evq3yHw/xXuAbVfURUrhMY8WhTDyB
        DzFrVuLWiwRMcdubxqXr8OtQ19olP9G496TFzMexEtw=;
X-AuditID: c39127d2-c63ec70000001d24-d7-615172b9635a
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C8.B9.07460.9B271516; Mon, 27 Sep 2021 09:28:57 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021092709285741-1755086 ;
          Mon, 27 Sep 2021 09:28:57 +0200 
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
Subject: [PATCH v2 1/2] clk: imx: imx6ul: Move csi_sel mux to correct base register
Date:   Mon, 27 Sep 2021 09:28:56 +0200
Message-Id: <20210927072857.3940880-1-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.09.2021 09:28:57,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 27.09.2021 09:28:57
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWyRoCBS3dnUWCiwaXfphbLLh1ltHh41d9i
        1dSdLBabHl9jtfjYc4/VouvXSmaLy7vmsFlcPOVq8Xf7JhaLf9c2sli82CLuwO3x/kYru8fO
        WXfZPTat6mTz2Lyk3mPjux1MHv1/DTw+b5ILYI/isklJzcksSy3St0vgypjxuaDgnljFvsVb
        mBoYPwl3MXJySAiYSOyf8Za5i5GLQ0hgG6PE5G/z2SCcC4wST/qeM4JUsQkYSSyY1sgEkhAR
        2M4o8aL7PliCWaCDSWLeDDcQW1ggWGL68tVMIDaLgKrE7G0zgCZxcPAK2Ens3iIJsU1eYual
        7+wgNq+AoMTJmU9YQGZKCFxhlLh75yIbRJGQxOnFZ5kh5mtLLFv4mnkCI98sJD2zkKQWMDKt
        YhTKzUzOTi3KzNYryKgsSU3WS0ndxAgM5cMT1S/tYOyb43GIkYmD8RCjBAezkghvMIt/ohBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHe+z1MiUIC6YklqdmpqQWpRTBZJg5OqQZGPd/yJRN8LjlP
        ZZ93v/DVMX7epOl5W1z78/it434cOhPSsU46OSmCN84wXCXA6NryA+66mtc40zweTF7laxm8
        cK7/zhUuC7nL2+Lux5x7MDvm4N25O9fsnRTo/sTgoPuVopvb/Za0mnKfWfgz5/aRGNZfOZfd
        Css7J7Yc/GNecKhpYtOr4MTvSizFGYmGWsxFxYkAuqZH01MCAAA=
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
No changes in v2.
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

