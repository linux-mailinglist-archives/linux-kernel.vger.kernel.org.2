Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA67348E36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhCYKjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:39:14 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:59298 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhCYKir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:47 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 06:38:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1616667825; x=1619259825;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XX4NYHDVdIgAN4+alHloHPftwp/jpIXj92Iyg+stYRI=;
        b=Uk2lHMmpx3dpmxY9cRjYqJ/7+6crykxYhG58hiB+/kvGFb9drKEZnzMRcIPZlo03
        Qv8xTs68SCb73l9Y9s7DLfVw1nxwCMxtjPFelWwTZDWceYEL7IOIf9E5UbPMbWpl
        IKMieQCOzXb7IXPJ6sVaw/QrngESA/3qL4xXQ/flCDc=;
X-AuditID: c39127d2-868b870000001c91-c3-605c64b15204
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E2.DE.07313.1B46C506; Thu, 25 Mar 2021 11:23:45 +0100 (CET)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021032511234504-229425 ;
          Thu, 25 Mar 2021 11:23:45 +0100 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH] mtd: rawnand: nand_bbt: Skip bad blocks when searching for the BBT in NAND
Date:   Thu, 25 Mar 2021 11:23:37 +0100
Message-Id: <20210325102337.481172-1-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 25.03.2021 11:23:45,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 25.03.2021 11:23:45
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWyRoCBS3djSkyCQfseLovLu+awWexuWsZu
        cbh9H6vF5J1vGC3+n/3A7sDqMW9NtcfmJfUeN+cVehy/sZ3J4/MmuQDWKC6blNSczLLUIn27
        BK6MNd82MBd84a7omvGWvYHxCWcXIweHhICJxMI3aV2MXBxCAlsZJQ6f6mGGcK4xSvz/dpWl
        i5GTg03ASGLBtEYmEFtEIESi//0ZFpAiZoFJjBIP9pxnBUkIC0RLHNk2kRVkKouAqsSl4wEg
        YV4BW4kfj56D9UoIyEvMvPSdHSIuKHFy5hOwORICVxglbj3fxgZRJCRxevFZZhCbWUBbYtnC
        18wTGPlmIemZhSS1gJFpFaNQbmZydmpRZrZeQUZlSWqyXkrqJkZg+B2eqH5pB2PfHI9DjEwc
        jIcYJTiYlUR4k3xjEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzbuAtCRMSSE8sSc1OTS1ILYLJ
        MnFwSjUwbrkVOz167mWRz5bO2kYWjlea7ywx2Lfjh5ba3BRGDns7j9Rbni9rQnMvtW98O0VB
        85PczAPpxzMblQV0d7p/55vvoXt8WeOJJR+7prjXbzvzRbadTWza2/31gXOPe8QayYcduPnr
        yflWy2WFxUsYzRT8/3d93S0xl2f54uxuv5e5G/VyxVc3KbEUZyQaajEXFScCAA/Fb8stAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blocks containing the bad block table can become bad as well. So
make sure to skip any blocks that are marked bad when searching for the
bad block table.

Otherwise in very rare cases where two BBT blocks wear out it might
happen that an obsolete BBT is used instead of a newer available
version.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 drivers/mtd/nand/raw/nand=5Fbbt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand=5Fbbt.c b/drivers/mtd/nand/raw/nand=
=5Fbbt.c
index dced32a126d9..6e25a5ce5ba9 100644
--- a/drivers/mtd/nand/raw/nand=5Fbbt.c
+++ b/drivers/mtd/nand/raw/nand=5Fbbt.c
@@ -525,6 +525,7 @@ static int search=5Fbbt(struct nand=5Fchip *this, uint8=
=5Ft *buf,
 {
 	u64 targetsize =3D nanddev=5Ftarget=5Fsize(&this->base);
 	struct mtd=5Finfo *mtd =3D nand=5Fto=5Fmtd(this);
+	struct nand=5Fbbt=5Fdescr *bd =3D this->badblock=5Fpattern;
 	int i, chips;
 	int startblock, block, dir;
 	int scanlen =3D mtd->writesize + mtd->oobsize;
@@ -560,6 +561,10 @@ static int search=5Fbbt(struct nand=5Fchip *this, uint=
8=5Ft *buf,
 			int actblock =3D startblock + dir * block;
 			loff=5Ft offs =3D (loff=5Ft)actblock << this->bbt=5Ferase=5Fshift;
=20
+			/* Check if block is marked bad */
+			if (scan=5Fblock=5Ffast(this, bd, offs, buf))
+				continue;
+
 			/* Read first page */
 			scan=5Fread(this, buf, offs, mtd->writesize, td);
 			if (!check=5Fpattern(buf, scanlen, mtd->writesize, td)) {
--=20
2.25.1

