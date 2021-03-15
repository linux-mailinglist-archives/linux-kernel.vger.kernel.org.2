Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B546033AB90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCOGYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:24:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54566 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhCOGYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:24:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12F6Nisw111892;
        Mon, 15 Mar 2021 01:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615789424;
        bh=+xpVIqXBMlQSCgMDub+F48I456GSb3TAm140SRUSPpE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I2U9/tFAjwr4SGj3+eW0Wkh1QHAjSnSho3Vv0eeXT3RQLHhdKuD16sSw6qNT7ddcr
         XClmfYTOOmQZi4q/KpmoUGFD7A3vndZof6Jg7WYC2nP2zRs3QCOx+L4aKjH8kWZilj
         DB64b3VJT2n9eWU9x0uVwi9xLneuby5K2b2zrjv0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12F6NiBl045707
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Mar 2021 01:23:44 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 15
 Mar 2021 01:23:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 15 Mar 2021 01:23:43 -0500
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12F6NfFt122635;
        Mon, 15 Mar 2021 01:23:42 -0500
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection logic
 out of the core
To:     <Tudor.Ambarus@microchip.com>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
 <963232a4-9100-ebca-927c-7f5a1e947fbe@ti.com>
 <9889bae0-8eba-7cbc-d9bb-04e038bd28c8@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <6016b725-a779-1d2c-9884-099c58f53557@ti.com>
Date:   Mon, 15 Mar 2021 11:53:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9889bae0-8eba-7cbc-d9bb-04e038bd28c8@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/21 12:58 PM, Tudor.Ambarus@microchip.com wrote:
> On 3/8/21 7:28 PM, Vignesh Raghavendra wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 3/6/21 3:20 PM, Tudor Ambarus wrote:
>>> It makes the core file a bit smaller and provides better separation
>>> between the Software Write Protection features and the core logic.
>>> All the next generic software write protection features (e.g. Individual
>>> Block Protection) will reside in swp.c.
>>>
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> ---
>>>  drivers/mtd/spi-nor/Makefile |   2 +-
>>>  drivers/mtd/spi-nor/core.c   | 407 +---------------------------------
>>>  drivers/mtd/spi-nor/core.h   |   4 +
>>>  drivers/mtd/spi-nor/swp.c    | 419 +++++++++++++++++++++++++++++++++++
>>
>> Hmmm, name swp.c does not seem intuitive to me. How about expanding it a
>> bit:
>>
>> soft-wr-protect.c or software-write-protect.c ?
>>
> 
> I thought about the SWP configs that we have.
> 
> How about keeping swp.c and rename configs to:
> s/MTD_SPI_NOR_SWP_DISABLE/MTD_SPI_NOR_DISABLE_BOOT_SWP
> s/MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE/MTD_SPI_DISABLE_BOOT_SWP_ON_VOLATILE
> s/MTD_SPI_NOR_SWP_KEEP/MTD_SPI_NOR_KEEP_BOOT_SWP
> 
> The renamed configs should better indicate that the software write protection
> is disabled just at boot time, while the locking support is still enabled.
> Otherwise one may think that with a MTD_SPI_NOR_SWP_DISABLE, all the
> software write protection features are stripped/not available.
> 

I am not a fan of renaming Kconfig options as it breaks make
olddefconfig flow which many developers rely on.

Regards
Vignesh
