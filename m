Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5820E33D4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhCPNP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:15:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42576 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhCPNP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:15:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12GDFIao011863;
        Tue, 16 Mar 2021 08:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615900518;
        bh=8sGhX9btFJsimS/Vsxuxs9nBnZi+riWzMYvjXMqo0/4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RFMwnd/kyaMMkndEA5upZ7aM+xz5vug4Xb8rj9ZaudLQt+AmiyDVogiUXzD71C3Du
         xJ5NRlcCcW7PPh1bATQW7mBPqU11Z17VChlKSDGiQw2X9v5GQfTc6o+4rzbmGsFeiq
         n4bVMjt9KRY0u+CJIrm1S7uQfMCty+SNFMUtYabg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12GDFIes078015
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Mar 2021 08:15:18 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 16
 Mar 2021 08:15:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 16 Mar 2021 08:15:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12GDFH3D046429;
        Tue, 16 Mar 2021 08:15:17 -0500
Date:   Tue, 16 Mar 2021 18:45:16 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [RFC PATCH 2/3] mtd: spi-nor: sfdp: fix spi_nor_read_sfdp()
Message-ID: <20210316131514.tiln7ml2efkj5xkq@ti.com>
References: <20210312190548.6954-1-michael@walle.cc>
 <20210312190548.6954-3-michael@walle.cc>
 <20210316110400.kepjn6b654lhq4dy@ti.com>
 <25579f51e4e0626ad96bcaf2f8015260@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <25579f51e4e0626ad96bcaf2f8015260@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/21 12:15PM, Michael Walle wrote:
> Am 2021-03-16 12:04, schrieb Pratyush Yadav:
> > On 12/03/21 08:05PM, Michael Walle wrote:
> > > If spi_nor_read_sfdp() is used after probe, we have to set read_proto
> > > and the read dirmap.
> > > 
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > ---
> > >  drivers/mtd/spi-nor/sfdp.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> > > index b1814afefc33..47634ec9b899 100644
> > > --- a/drivers/mtd/spi-nor/sfdp.c
> > > +++ b/drivers/mtd/spi-nor/sfdp.c
> > > @@ -179,19 +179,27 @@ static int spi_nor_read_sfdp(struct spi_nor
> > > *nor, u32 addr,
> > >  			     size_t len, void *buf)
> > >  {
> > >  	u8 addr_width, read_opcode, read_dummy;
> > > +	struct spi_mem_dirmap_desc *rdesc;
> > > +	enum spi_nor_protocol read_proto;
> > >  	int ret;
> > > 
> > >  	read_opcode = nor->read_opcode;
> > > +	read_proto = nor->read_proto;
> > > +	rdesc = nor->dirmap.rdesc;
> > >  	addr_width = nor->addr_width;
> > >  	read_dummy = nor->read_dummy;
> > > 
> > >  	nor->read_opcode = SPINOR_OP_RDSFDP;
> > > +	nor->read_proto = SNOR_PROTO_1_1_1;
> > > +	nor->dirmap.rdesc = NULL;
> > >  	nor->addr_width = 3;
> > >  	nor->read_dummy = 8;
> > 
> > NACK. You can't assume the device is still in 1S-1S-1S mode after probe.
> > For example, the s28hs512t flash is switched to 8D-8D-8D mode by the
> > time the probe finishes so this would be an invalid command. Same for
> > any flash that goes into a stateful mode.
> 
> I see.
> 
> > And you can't even keep using nor->read_proto to read SFDP because the
> > Read SFDP command might not be supported in all modes. xSPI spec
> > (JESD251) says that the Read SFDP command is optional in 8D-8D-8D mode.
> > 
> > I think the best approach for this would be to cache the entire SFDP
> > table at parse time. This obviously comes with a memory overhead but I
> > don't think it would be too big. For example, the sfdp table on
> > s28hs512t is 491 bytes and it has 6 tables. Anyway, if the memory usage
> > is too much of a problem we can put the feature behind a config.
> 
> I don't like to have it a config option, because then, if you really
> need it, i.e. some user has an unknown flash, it might not be there.

Right. Then let's hope people don't mind us using up an extra half 
kilobyte or so.

> 
> The next question would be, should I leave the current parsing code
> as is or should I also change that to use the sftp data cache. I'd
> prefer to leave it as is.

For this series its fine if you leave it as is. But eventually it would 
be a good idea to convert all SFDP parsers to use the cache to reduce 
the number of SFDP reads and potentially speed up flash initialization a 
bit.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
