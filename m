Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B5F345B09
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCWJiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:38:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45238 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCWJiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:38:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12N9bp41110303;
        Tue, 23 Mar 2021 04:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616492271;
        bh=lMMVKyFJzlJoeShELvMWIsSH9PNuNNEcc6pyxCzg6cQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Zc/gNEeUPwC04z7EYU6c0Oa8HjEWIrH6aVsu7yiwqoLDJkSjuGunJpyUGv/NVacFQ
         JWLGkJaATd8qYNK1ZxC5Y4ELm6Jzi71LkgjbP8YfRiTRBNgKAKrU9Q2guUlEJum/Dk
         tbjAy2T77ZtcnpdUUQFq9S6iNTaGTjgMr5PpdmMY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12N9bpkW044031
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Mar 2021 04:37:51 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 23
 Mar 2021 04:37:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 23 Mar 2021 04:37:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12N9boZj002155;
        Tue, 23 Mar 2021 04:37:51 -0500
Date:   Tue, 23 Mar 2021 15:07:49 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
Message-ID: <20210323093747.snojk5kq7p6im4rq@ti.com>
References: <20210318092406.5340-1-michael@walle.cc>
 <20210318092406.5340-2-michael@walle.cc>
 <20210322142141.pd7ondg6l76idz7d@ti.com>
 <0efba47de8737059b4f3c593c26297bf@walle.cc>
 <20210322184214.ernzjfwfle6dfhpv@ti.com>
 <7e00a5fc05a186d5b34916e5a9f45a48@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7e00a5fc05a186d5b34916e5a9f45a48@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/21 11:31PM, Michael Walle wrote:
> Am 2021-03-22 19:42, schrieb Pratyush Yadav:
> > On 22/03/21 04:32PM, Michael Walle wrote:
> > > Am 2021-03-22 15:21, schrieb Pratyush Yadav:
> > > > On 18/03/21 10:24AM, Michael Walle wrote:
> > > > > +
> > > > > +	sfdp->num_dwords = DIV_ROUND_UP(sfdp_size, sizeof(*sfdp->dwords));
> > > >
> > > > The SFDP spec says that Parameter Table Pointer should be DWORD aligned
> > > > and Parameter Table length is specified in number of DWORDs. So,
> > > > sfdp_size should always be a multiple of 4. Any SFDP table where this is
> > > > not true is an invalid one.
> > > >
> > > > Also, the spec says "Device behavior when the Read SFDP command crosses
> > > > the SFDP structure boundary is not defined".
> > > >
> > > > So I think this should be a check for alignment instead of a round-up.
> > > 
> > > Well, that woundn't help for debugging. I.e. you also want the SFDP
> > > data
> > > in cases like this. IMHO we should try hard enough to actually get a
> > > reasonable dump.
> > > 
> > > OTOH we also rely on the header and the pointers in the header. Any
> > > other ideas, but just to chicken out?
> > 
> > Honestly, I don't think reading past the SFDP boundary would be too bad.
> > It probably will just be some garbage data. But if you want to avoid
> > that, you can always round down instead of up.
> 
> Like I said, while the storage will be rounded up to a multiple of
> DWORDs, only sfdp_size is transferred. Thus it case a pointer is not
> DWORD aligned, we end up with zeros at the end.
> 
> I'll add a comment.

Right.
 
> > This way you will only
> > miss the last DWORD at most. In either case, a warning should be printed
> > so this problem can be brought to the user's attention.
> 
> I was about to add a warning/debug message. But its the wrong place.
> It should really be checked in the for loop which iterates over the
> headers before parsing them. You could check sfdp_size but then two
> unaligned param pointers might cancel each other out.
> 
> This can be a seperate patch, besides adding a warning, should there
> be any other things to do, e.g. stop parsing and error out?

Just removing the bad table from the "tables to parse" list should be 
the most conservative option.

> 
> ..
> 
> > > > > +		goto exit;
> > > > > +	}
> > > > > +
> > > > > +	err = spi_nor_read_sfdp_dma_unsafe(nor, 0, sfdp_size, sfdp->dwords);
> 
> Btw, this can be spi_nor_read_sfdp(). But I'm not sure, what this
> whole dma capable buffer should be. Is kmalloc(GFP_KERNEL)
> considered DMA safe?

I think spi_nor_read_sfdp_dma_unsafe() is meant for buffers that are 
allocated on stack. Both its current users pass in buffers on the stack. 
Also see bfa4133795e5 (mtd: spi-nor: fix DMA unsafe buffer issue in 
spi_nor_read_sfdp(), 2017-09-06).

sfdp->dwords is a DMA safe buffer, so you should directly use 
spi_nor_read_sfdp() here. All spi_nor_read_sfdp_dma_unsafe() does is 
allocate a buffer using kmalloc(GFP_KERNEL), pass it to 
spi_nor_read_sfdp() and copy the contents back.

> 
> The buffer ends in spi_nor_read_data(), which is also called from
> mtdcore:
> 
> spi_nor_read_sfdp()
>   spi_nor_read_raw()
>     spi_nor_read_data()
> 
> mtd_read()
>   mtd_read_oob()
>     mtd_read_oob_std()
>       spi_nor_read()
>         spi_nor_read_data()
> 
> Is the buffer passed from mtd_read() also DMA-safe? Doesn't the SPI
> drivers allocate DMA safe buffers if they need them?

SPI MEM at least requires the buffers to be DMA-safe. The comment for 
data.buf.in says "input buffer (must be DMA-able)".

Dunno if mtd_read() always passes a DMA-safe buffer though.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
