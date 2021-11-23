Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA32E45AA40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbhKWRpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:45:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48760 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbhKWRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:45:45 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1ANHgAUF039109;
        Tue, 23 Nov 2021 11:42:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637689330;
        bh=C3Bb1vDGAhm1AJp5UEueP9HcLsWC2LXhC5cUz5gg8gU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DLhOavivfCAuJi1YPYoZd+mLtxDocGG+nuHf3IxBW7ubaCyfCHqpvIDsbXZCfodFn
         WnIrLV5VLzHId4SOZFFlsoBIIZDlqj/aXDiiK8gwBCksn24IKdo2P9lkRP4cbBqtf+
         RIG5dJos+M7iwQqJRzDHjg2nSga9nNks4oFpBj3o=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1ANHgAen079491
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 11:42:10 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 23
 Nov 2021 11:42:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 23 Nov 2021 11:42:09 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1ANHg8bo069940;
        Tue, 23 Nov 2021 11:42:09 -0600
Date:   Tue, 23 Nov 2021 23:12:08 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
CC:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
Message-ID: <20211123174206.bzh5yq2f7sgkqpmi@ti.com>
References: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
 <9a158e2ef6635212c1e353590e3b773b@walle.cc>
 <1e133bc6-5edb-c4ce-ad44-3de77048acf2@nokia.com>
 <e9589af968d7b9dafbce17325dbf8472@walle.cc>
 <85251c3b-13c1-8b24-0ce2-6793ea55e39a@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85251c3b-13c1-8b24-0ce2-6793ea55e39a@nokia.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/21 01:13PM, Alexander Sverdlin wrote:
> Dear maintainers!
> 
> On 22/11/2021 16:05, Michael Walle wrote:
> > Thanks, so that's the SFDP data for the mt25qu256aba8e12-1sit part. and the
> > jedec id is 20bb19104473, correct?
> 
> While we are at this part, I've encountered another issue:
> 
> The chip supports 1-1-1, 1-1-4 and 1-4-4 write OPs in extended SPI mode,
> while only 1-1-0 erase. (as well as 4-4-4/4-4-0, but that's not the issue here,
> I think).
> 
> Now the erase code (chip/sector) uses spi_nor_spimem_setup_op(nor, &op, nor->write_proto)
> in both functions.
> 
> In my opinion, as I look into Micron or Macronix datasheets, write_proto has little to
> do with erase_proto. (there is currently no separate erase_proto)

I think this just worked for most flashes since both writes and erases 
generally use 1-bit mode. 4 or 8 bit modes are generally used for reads 
only.

> 
> Before I come up with a totally wrong patch, wanted to ask your opinion, how should
> it be solved, what do you think?
> 
> I do not see any erase-related tables for this in JESD216C.
> I also cannot come up with an example of a chip with erase != 1-1-0.

See Micron MT35XU512ABA or Cypress S28HS512T (in spansion.c). Both have 
erase in 8D-8D-8D mode.

> 
> Shall I hardcode 1-1-0 for erase?
> Shall I introduce erase_proto? What would be the logic for its setting/discovery?

I think introducing erase_proto would be the sensible thing. You would 
have to see if we can discover erase protocol from SFDP. But my question 
is: is that really worth it? Do you really need that little bit speed 
boost you'd get by transmitting write data in 4 bit mode, since the 
large portion of the time would be spent in the chip actually flashing 
the data.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
