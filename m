Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E97E3B4376
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhFYMkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:40:53 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:43902 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1624624701; x=1627216701;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5rNdhdXpJ/OcCBy+pGDMiUzxnKn/i2JIsqtlVIR5JxU=;
        b=Je3xqMWYA/RnsU70jBeehli98zJNfC2+CBbqFtvIfm6m8Apo+g18hyS1UyhsyOL/
        bM5tat8REkQX2r/rtk7Qsg7BxbJm2KQzXncGTdp2P6gJmqcle8nCcTsEWlJufnPx
        ZS3KNf/Sjk3CaZPFT6Dso94DSaUIyiLwNf4w3dhFfvs=;
X-AuditID: c39127d2-a9fbd70000001c5e-d3-60d5ce3dcc57
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 84.70.07262.D3EC5D06; Fri, 25 Jun 2021 14:38:21 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021062514382171-1041864 ;
          Fri, 25 Jun 2021 14:38:21 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dan Brown <dan_brown@ieee.org>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: nand_bbt: Skip bad blocks when searching for the BBT in NAND
Date:   Fri, 25 Jun 2021 14:38:21 +0200
Message-Id: <20210625123821.207458-1-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 25.06.2021 14:38:21,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 25.06.2021 14:38:21
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWyRoCBS9f23NUEgysPDCxOnznFZHGkbzOz
        xcSVk5ktHl71t1g1dSeLxadr3YwWl3fNYbPY3bSM3eLh7KuMFofb97FaTN75htHi7/ZNLBb/
        z35gd+D1mLem2mPH3SWMHjtn3WX3mN0xk9Xj6YSDTB6bV2h5bFrVyeaxeUm9x815hR79fw08
        jt/YzuTxeZNcAE8Ul01Kak5mWWqRvl0CV8baC4vZC+bKVrSuOc3YwLhTvIuRg0NCwETiZJ9Q
        FyMXh5DANkaJEw8usUA41xklNhy/xdrFyMnBJmAksWBaIxOILSIQItH//gxYEbPAUWaJ8zcP
        gCWEBaIljmybCNbAIqAqsaxtM5jNK2ArsWDRPmYQW0JAXmLmpe/sEHFBiZMzn4ANkhC4wihx
        5fgHRogiIYnTi8+CNTALaEssW/iaeQIj3ywkPbOQpBYwMq1iFMrNTM5OLcrM1ivIqCxJTdZL
        Sd3ECIyIwxPVL+1g7JvjcYiRiYPxEKMEB7OSCO+jlksJQrwpiZVVqUX58UWlOanFhxilOViU
        xHk38JaECQmkJ5akZqemFqQWwWSZODilGhjXrdA0CyniX1nspi49y/F9D3fgz6I5dvnSwaFN
        z2zVuqemT3+aJXBjRkHMzLZv+6w5Au9vjDz16uub1SdvZElNemabJ7KkYL7SRNm0RX8UyibH
        Pd3usGXv4oKs0PWui4zY/r9acfRlKJOJh4oly+FPEXZ/JzOZ+Seustp+Z0b9G6sX0pFdk34p
        sRRnJBpqMRcVJwIA+Z241HYCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blocks containing the bad block table can become bad as well. So
make sure to skip any blocks that are marked bad when searching for the
bad block table.

Otherwise in very rare cases where two BBT blocks wear out it might
happen that an obsolete BBT is used instead of a newer available
version.

This only applies to drivers which make use of a bad block marker in flash.
Other drivers won't be able to identify bad BBT blocks and thus can't skip
these.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---

Hi,

this is the second approach of this patch. The first one [1] unfortunately =
lead
to boot failures on i.MX 27 boards [2] since the i.MX 27 driver uses the bad
block marker position for the bad block table marker which lead to falsely
identifying all BBT blocks as bad.

This new patch now skips the check for bad BBT blocks if the BBT marker
position in OOB overlaps with the bad block marker position or if a driver
can't use bad block markers in flash at all (NAND=5FBBT=5FNO=5FOOB=5FBBM or
NAND=5FNO=5FBBM=5FQUIRK are set). This hopefully makes sure we don't break =
drivers
which cannot check for bad BBT blocks due to the limitations mentioned befo=
re.

I was only able to test this patch on a phyCORE-i.MX 6 and a phyCARD-i.MX 2=
7.
Therfore would really appreciate more people testing this to make sure I ha=
ve
not missed another use case where the bad block marker position in OOB is u=
sed
in a different way than for the BBM.

Regards,
Stefan

[1] https://lore.kernel.org/linux-mtd/20210325102337.481172-1-s.riedmueller=
@phytec.de/
[2] https://lore.kernel.org/linux-mtd/CAOMZO5DufVR=3D+EzCa1-MPUc+ZefZVTXb5K=
gu3Wxms7cxw9GmGg@mail.gmail.com/

 drivers/mtd/nand/raw/nand=5Fbbt.c | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand=5Fbbt.c b/drivers/mtd/nand/raw/nand=
=5Fbbt.c
index dced32a126d9..2a30714350ee 100644
--- a/drivers/mtd/nand/raw/nand=5Fbbt.c
+++ b/drivers/mtd/nand/raw/nand=5Fbbt.c
@@ -447,6 +447,36 @@ static int scan=5Fblock=5Ffast(struct nand=5Fchip *thi=
s, struct nand=5Fbbt=5Fdescr *bd,
 	return 0;
 }
=20
+/* Check if a potential BBT block is marked as bad */
+static int bbt=5Fblock=5Fcheckbad(struct nand=5Fchip *this,
+				      struct nand=5Fbbt=5Fdescr *td,
+				      loff=5Ft offs, uint8=5Ft *buf)
+{
+	struct nand=5Fbbt=5Fdescr *bd =3D this->badblock=5Fpattern;
+
+	/*
+	 * No need to check for a bad BBT block if the BBM area overlaps with
+	 * the bad block table marker area in OOB since writing a BBM here
+	 * invalidates the bad block table marker anyway.
+	 */
+	if (!(td->options & NAND=5FBBT=5FNO=5FOOB) &&
+	    td->offs >=3D bd->offs && td->offs < bd->offs + bd->len)
+		return 0;
+
+	/*
+	 * There is no point in checking for a bad block marker if writing
+	 * such marker is not supported
+	 */
+	if (this->bbt=5Foptions & NAND=5FBBT=5FNO=5FOOB=5FBBM ||
+	    this->options & NAND=5FNO=5FBBM=5FQUIRK)
+		return 0;
+
+	if (scan=5Fblock=5Ffast(this, bd, offs, buf) > 0)
+		return 1;
+
+	return 0;
+}
+
 /**
  * create=5Fbbt - [GENERIC] Create a bad block table by scanning the device
  * @this: NAND chip object
@@ -560,6 +590,10 @@ static int search=5Fbbt(struct nand=5Fchip *this, uint=
8=5Ft *buf,
 			int actblock =3D startblock + dir * block;
 			loff=5Ft offs =3D (loff=5Ft)actblock << this->bbt=5Ferase=5Fshift;
=20
+			/* Check if block is marked bad */
+			if (bbt=5Fblock=5Fcheckbad(this, td, offs, buf))
+				continue;
+
 			/* Read first page */
 			scan=5Fread(this, buf, offs, mtd->writesize, td);
 			if (!check=5Fpattern(buf, scanlen, mtd->writesize, td)) {
--=20
2.25.1

