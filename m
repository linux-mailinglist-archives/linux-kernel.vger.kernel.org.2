Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FEC42650B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhJHHMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:12:45 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:45391 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhJHHMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633677048; x=1665213048;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=jWRHRVPBFUVetVaD+ip2tzxDrpeioyY+OQf4Xmta5Mg=;
  b=W0Ngx5S3OyohZ3200i0V1o+DyGtDIxN4JiQOC94qwiSXmjrg56yrVDMH
   PZ+l7VgwfYq5dJ377RiKnCan1+M2lUGqbnpKLpniGwnhf/+gERjfw9Jyk
   iMfslQhzTGxXBP0TEp9Rol7xEYGgD8UWy1ykmUpuKsMUz7vwcwebRR/+n
   TEiqL0gPt+sQfB7JzcSgcxBDTALOIwrqkP95ix0UiyZGVkAi3O9Bv3ZKH
   P1YSPMMgYUyym4P23v5XQAnYEmpCREoF5mt39zLe4J82vke4sUz/TZ0L4
   RmvMugJ0hH/nlOKS59NDARUm9RadD/kLSl063Hw1QlLCUD8/BptbQSPZB
   w==;
X-IronPort-AV: E=Sophos;i="5.85,356,1624312800"; 
   d="scan'208";a="19934038"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Oct 2021 09:10:47 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 08 Oct 2021 09:10:47 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 08 Oct 2021 09:10:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633677047; x=1665213047;
  h=subject:from:to:cc:date:mime-version:
   content-transfer-encoding:message-id;
  bh=jWRHRVPBFUVetVaD+ip2tzxDrpeioyY+OQf4Xmta5Mg=;
  b=TOZYn8l2TBErpX73ID7emRlGD4OrAv8fcevpHjHSgNu9yomgJDAwpjtF
   7FBYuXswMe2prDoBalCQWy3GdfbCCbtaB4Nn3aaxpijgO41p2CIQP9sog
   EZ8wZQkB4UNOtsmmPDeNqq1bY1tQNqMhIwTrSGiUTOPQs5iMmcOCgHuwM
   BrZRFZ36NjOf+VQcj4+byOwfBlpL1rBldU0ECRahJHNKdEcUBZVthy51U
   6dHUZ/YHH3280U/kOz2QHntapN/wkiRq/hgUK8VdO8JOk40Fj2dVDZdri
   BnrAinhKHJ5DYKdccDEZ+7QAc9BFQaDoAb8ROFREAQ/E7U95KmeCYzfid
   A==;
X-IronPort-AV: E=Sophos;i="5.85,356,1624312800"; 
   d="scan'208";a="19934037"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Oct 2021 09:10:47 +0200
Received: from vtuxmail01.tq-net.de (localhost [127.0.0.1])
        by vtuxmail01.tq-net.de (Postfix) with ESMTP id E992E280065;
        Fri,  8 Oct 2021 09:10:46 +0200 (CEST)
Received: by vtuxmail01 (kopano-spooler) with MAPI; Fri, 8 Oct 2021 09:10:46
 +0200
Subject: AW: (EXT) Re: [PATCH 1/2] dt-bindings: mtd: spi-nor: Add
 output-driver-strength property
From:   "Alexander Stein" <Alexander.Stein@ew.tq-group.com>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        =?us-ascii?Q?linux-kernel=40vger=2Ekern?= =?us-ascii?Q?el=2Eorg?= 
        <linux-kernel@vger.kernel.org>, "Michael Walle" <michael@walle.cc>,
        =?us-ascii?Q?devicetree=40vger=2Ekernel=2Eorg?= 
        <devicetree@vger.kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Rob Herring" <robh@kernel.org>,
        =?us-ascii?Q?linux-mtd=40lists=2Einfradead=2Eorg?= 
        <linux-mtd@lists.infradead.org>, "Pratyush Yadav" <p.yadav@ti.com>
Date:   Fri, 8 Oct 2021 07:10:46 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.7.82
Message-Id: <kcEE.RpXtjvjwSXyzkQ19eSpGDg.AB9KnRO81wE@vtuxmail01.tq-net.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Oct 2021 14:26:28 +0200, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> On Mon, 04 Oct 2021 13:15:28 +0200, Alexander Stein wrote:
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> >
> > This property is for optimizing output voltage impedance and is
> > specific to each board.
> >
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > I checked Micron and Macronix datasheets. Both have similar but not
> > identical supported values. Also the register locations are different.
> > For those reasons I decided to specify the Ohms value directly and let
> > the device specfic driver figure out if it is supported where to write
> > it to.
> > BTW: Are the Ohm values and the corresponding register bits standardized
> > somewhere=3F
> >
> >=C2=A0 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 6 ++++++
> >=C2=A0 1 file changed, 6 insertions(+)
> >
>
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>
> Full log is available here: https://patchwork.ozlabs.org/patch/1536062

Thanks for pointing that out. I checked the amount of error messages related to
jedec,spi-nor.yaml before and after applying these patches using
> ARCH=3Darm64 make -j12 dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mtd/jedec,spi-nor.yaml 2>&1 > /dev/null | wc -l

with all arm64 platforms enabled. There wasn't a change in the line count,
so I assume this new binding didn't cause them.

Best regards,
Alexander

