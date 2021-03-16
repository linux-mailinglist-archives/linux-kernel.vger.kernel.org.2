Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF7C33D2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhCPLXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:23:03 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53151 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbhCPLW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:22:27 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C28D522238;
        Tue, 16 Mar 2021 12:22:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615893745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A2fibGlEa/IIMv0LEALY2jlthyVYAhWbg9zu/3yMpqA=;
        b=h2OjtdPiSGzZz0HZJ9g+jp9IPSquJMAEyqpeiyMpoBfhkMmFOHDDM4W0skgXH3bAsfsB/t
        1GjcQ5OKamqtrZqcr/rVbvlmtMTWfgLGmMNR2uFGwImdOQeax2B/s79dzinmEOD4MzMvX1
        rEvPhonNJoKhdPKK1K4AN+9f9Oi2QzY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Mar 2021 12:22:25 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/3] mtd: spi-nor: sfdp: remember sfdp_size
In-Reply-To: <20210316110642.xvn4sohgkdq2ci7x@ti.com>
References: <20210312190548.6954-1-michael@walle.cc>
 <20210312190548.6954-2-michael@walle.cc>
 <20210316104223.42tdob3uwjxc5vdz@ti.com>
 <065642fa4d4282d3d16e1d4f4c176ce8@walle.cc>
 <20210316110642.xvn4sohgkdq2ci7x@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <3deb91e2c9fc3f62ae6976cecae37bf3@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-16 12:06, schrieb Pratyush Yadav:
> On 16/03/21 12:01PM, Michael Walle wrote:
>> Hi Pratyush,
>> 
>> Am 2021-03-16 11:42, schrieb Pratyush Yadav:
>> > On 12/03/21 08:05PM, Michael Walle wrote:
>> > > Save the sftp_size in the spi_nor struct so we can use it to dump the
>> > > SFDP table without parsing the headers again.
>> > >
>> > > Signed-off-by: Michael Walle <michael@walle.cc>
>> > > ---
>> > >  drivers/mtd/spi-nor/sfdp.c  | 12 ++++++++++++
>> > >  include/linux/mtd/spi-nor.h |  1 +
>> > >  2 files changed, 13 insertions(+)
>> > >
>> > > diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
>> > > index 25142ec4737b..b1814afefc33 100644
>> > > --- a/drivers/mtd/spi-nor/sfdp.c
>> > > +++ b/drivers/mtd/spi-nor/sfdp.c
>> > > @@ -16,6 +16,7 @@
>> > >  	(((p)->parameter_table_pointer[2] << 16) | \
>> > >  	 ((p)->parameter_table_pointer[1] <<  8) | \
>> > >  	 ((p)->parameter_table_pointer[0] <<  0))
>> > > +#define SFDP_PARAM_HEADER_PARAM_LEN(p) ((p)->length * 4)
>> > >
>> > >  #define SFDP_BFPT_ID		0xff00	/* Basic Flash Parameter Table */
>> > >  #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
>> > > @@ -1263,6 +1264,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>> > >  	struct sfdp_parameter_header *param_headers = NULL;
>> > >  	struct sfdp_header header;
>> > >  	struct device *dev = nor->dev;
>> > > +	size_t param_max_offset;
>> > >  	size_t psize;
>> > >  	int i, err;
>> > >
>> > > @@ -1285,6 +1287,9 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>> > >  	    bfpt_header->major != SFDP_JESD216_MAJOR)
>> > >  		return -EINVAL;
>> > >
>> > > +	nor->sfdp_size = SFDP_PARAM_HEADER_PTP(bfpt_header) +
>> > > +			 SFDP_PARAM_HEADER_PARAM_LEN(bfpt_header);
>> > > +
>> > >  	/*
>> > >  	 * Allocate memory then read all parameter headers with a single
>> > >  	 * Read SFDP command. These parameter headers will actually be
>> > > parsed
>> > > @@ -1311,6 +1316,13 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>> > >  		}
>> > >  	}
>> > >
>> > > +	for (i = 0; i < header.nph; i++) {
>> > > +		param_header = &param_headers[i];
>> > > +		param_max_offset = SFDP_PARAM_HEADER_PTP(param_header) +
>> > > +				   SFDP_PARAM_HEADER_PARAM_LEN(param_header);
>> > > +		nor->sfdp_size = max(nor->sfdp_size, param_max_offset);
>> > > +	}
>> > > +
>> >
>> > I don't see any mention in the SFDP spec (JESD216D-01) that parameter
>> > tables have to be contiguous.
>> 
>> ch. 6.1, fig.10 looks like all the headers come after the initial SFDP
>> header. If that wasn't the case, how would you find the headers then?
>> 
>> Also ch. 6.3
>> """All subsequent parameter headers need to be contiguous and may be
>> specified..."""
>> 
>> > In fact, it says that "Parameter tables
>> > may be located anywhere in the SFDP space. They do not need to
>> > immediately follow the parameter headers".
>> 
>> The tables itself, yes, but not the headers for the tables.
> 
> Yes, I was talking about the tables and not the headers. There might be
> holes in the SFDP space but I don't think it would be a problem.

Ah, ok. Well basically I'm assuming that the holes will returning some
sane values. Or you could dump the space together with a mask. But that
is overkill ;)

-michael
