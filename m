Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1096A33EC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhCQJFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:05:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59688 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhCQJFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:05:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12H958gd031480;
        Wed, 17 Mar 2021 04:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615971908;
        bh=CFJ2+PiQFeamPdSmnwEFhov7N4y6g4MKwY4Bys1qRy8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=d0Xw+e0yE60NtlZf2yx0zPj25LqHxiIJyGRMVezXFVQti0sx4ED/kAwdGPCE8aD+t
         qnMx4FwJCaKRcoq+5qpdei8DqHEJ4eAhamnShFX/l8bGegcBwx2iedqQrTHMwRS9y2
         lqBRPRYXwTZoBlqBNokZ0HRfChHCQpz1nuGXuJcg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12H9589H118204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Mar 2021 04:05:08 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 17
 Mar 2021 04:05:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 17 Mar 2021 04:05:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12H957XS105253;
        Wed, 17 Mar 2021 04:05:08 -0500
Date:   Wed, 17 Mar 2021 14:35:06 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <vigneshr@ti.com>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection
 logic out of the core
Message-ID: <20210317090504.ra3vm76xexhaqg2l@ti.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
 <963232a4-9100-ebca-927c-7f5a1e947fbe@ti.com>
 <9889bae0-8eba-7cbc-d9bb-04e038bd28c8@microchip.com>
 <6016b725-a779-1d2c-9884-099c58f53557@ti.com>
 <45d00a12-cb79-774e-f8e8-d65602629a90@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <45d00a12-cb79-774e-f8e8-d65602629a90@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/21 06:09AM, Tudor.Ambarus@microchip.com wrote:
> On 3/15/21 8:23 AM, Vignesh Raghavendra wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 3/9/21 12:58 PM, Tudor.Ambarus@microchip.com wrote:
> >> On 3/8/21 7:28 PM, Vignesh Raghavendra wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> On 3/6/21 3:20 PM, Tudor Ambarus wrote:
> >>>> It makes the core file a bit smaller and provides better separation
> >>>> between the Software Write Protection features and the core logic.
> >>>> All the next generic software write protection features (e.g. Individual
> >>>> Block Protection) will reside in swp.c.
> >>>>
> >>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>>> ---
> >>>>  drivers/mtd/spi-nor/Makefile |   2 +-
> >>>>  drivers/mtd/spi-nor/core.c   | 407 +---------------------------------
> >>>>  drivers/mtd/spi-nor/core.h   |   4 +
> >>>>  drivers/mtd/spi-nor/swp.c    | 419 +++++++++++++++++++++++++++++++++++
> >>>
> >>> Hmmm, name swp.c does not seem intuitive to me. How about expanding it a
> >>> bit:
> >>>
> >>> soft-wr-protect.c or software-write-protect.c ?
> 
> Having in mind that we have the SWP configs, I think I prefer swp.c.
> But let's see what majority thinks, we'll do as majority prefers.
> Michael, Pratyush?

I don't have much of an opinion on this tbh. But I usually prefer short 
names so I'd go with swp.c here. Maybe also add a comment at the top of 
the file mentioning the full name "Software Write Protection logic" or 
something similar for clarification.

> 
> >>>
> >>
> 
> cut
> 
> > 
> > I am not a fan of renaming Kconfig options as it breaks make
> > olddefconfig flow which many developers rely on.
> > 
> 
> I'm fine keeping them as they are for now. If someone else screams we will
> reconsider.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
