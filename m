Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB77D3BE446
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhGGIZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 04:25:18 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:62412 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhGGIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1625646155; x=1628238155;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TaHQKkZoKqqFdK7Q1tZHDcJT6AzhHXDxyqv0IQazNlY=;
        b=s1B0PmV1XJbdVRdQzk7MVTXiwUKLE3RFoUR9pXYfKm8I/zrqFeMXSVb4U5gyABbL
        9bd/Z8I0kaiozmbTCfdzCHlXeu/fpPZREVmu3qd1qS+G8bw5SfSatxsRGgt1qW7y
        p700adAAGycqh1qg/4T1sgTHgfLKd5MFZanzGMHBvoo=;
X-AuditID: c39127d2-a9fbd70000001c5e-9c-60e5644b39aa
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E8.9F.07262.B4465E06; Wed,  7 Jul 2021 10:22:35 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021070710223480-1106131 ;
          Wed, 7 Jul 2021 10:22:34 +0200 
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
        linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH] fixup! mtd: rawnand: nand_bbt: Skip bad blocks when searching for the BBT in NAND
Date:   Wed, 7 Jul 2021 10:22:34 +0200
Message-Id: <20210707082234.4917-1-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706181308.1aa21d00@xps13>
References: <20210706181308.1aa21d00@xps13>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 07.07.2021 10:22:35,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 07.07.2021 10:22:35
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWyRoCBS9c75WmCwYJmQYvTZ04xWRzp28xs
        MXHlZGaLh1f9LVZN3cli8elaN6PF5V1z2Cx2Ny1jt3g4+yqjxeH2fawWk3e+YbT4u30Ti8X/
        sx/YHXg95q2p9thxdwmjx85Zd9k9ZnfMZPV4OuEgk8fmFVoem1Z1snlsXlLvcXNeoUf/XwOP
        4ze2M3l83iQXwBPFZZOSmpNZllqkb5fAlTF12262guMcFVeffGNsYGxh72Lk5JAQMJFYNakf
        yObiEBLYxihxs2kdE4RzjVHi948vYFVsAkYSC6Y1MoHYIgIhEv3vz7CAFDELfGaWeHq2hQ0k
        ISyQJHH8OkQRi4CKxPvTN8CaeQWsJV4/3sAEsU5eYual70BxDg5OAR2Jl8etQUwhAW2JVb9y
        IKoFJU7OfAI2XkLgCqNE94TJUK1CEqcXn2UGsZmB6pctfM08gVFgFpKeWUhSCxiZVjEK5WYm
        Z6cWZWbrFWRUlqQm66WkbmIExs/hieqXdjD2zfE4xMjEwXiIUYKDWUmEl9HhaYIQb0piZVVq
        UX58UWlOavEhRmkOFiVx3g28JWFCAumJJanZqakFqUUwWSYOTqkGRlenLxu7JRa7XtTmeKRk
        FeJsc2P2j7VRxhP/p7NfmFRky5S3tPyFsNEGv1J/ly15Ii6ssx9LvV68TraVuXbba4YXeqkZ
        DOKvzlh7dn94M0VMfJ5c+oJtjZuFC1sClVoy1O4Iz9B3kGDn3tN0+uNSHmc2F9U98U+sNklM
        rztnvNAuROvkoX3rlFiKMxINtZiLihMB4yr7Jo0CAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix helper parameter alignment.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
Hi Miquel,

sorry, I forgot to realign the parameters. Here's a fixup for that. Hope
it's ok this way.

Regards,
Stefan

---
 drivers/mtd/nand/raw/nand=5Fbbt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand=5Fbbt.c b/drivers/mtd/nand/raw/nand=
=5Fbbt.c
index 2a30714350ee..b7ad030225f8 100644
--- a/drivers/mtd/nand/raw/nand=5Fbbt.c
+++ b/drivers/mtd/nand/raw/nand=5Fbbt.c
@@ -448,9 +448,8 @@ static int scan=5Fblock=5Ffast(struct nand=5Fchip *this=
, struct nand=5Fbbt=5Fdescr *bd,
 }
=20
 /* Check if a potential BBT block is marked as bad */
-static int bbt=5Fblock=5Fcheckbad(struct nand=5Fchip *this,
-				      struct nand=5Fbbt=5Fdescr *td,
-				      loff=5Ft offs, uint8=5Ft *buf)
+static int bbt=5Fblock=5Fcheckbad(struct nand=5Fchip *this, struct nand=5F=
bbt=5Fdescr *td,
+			      loff=5Ft offs, uint8=5Ft *buf)
 {
 	struct nand=5Fbbt=5Fdescr *bd =3D this->badblock=5Fpattern;
=20
--=20
2.25.1

