Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AFC3A2906
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFJKK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:10:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56388 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:10:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15AA84o6118534;
        Thu, 10 Jun 2021 05:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623319684;
        bh=Nzwl1maxkkM3tS11aSKlYLUOpSuNU9y2PTvlbUjk97A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=K8NTQoIDxQth6lY/UeHuekQCripSgHA2VNDnpgVZ5a2GT9CClLAA6V3sfO7AMmBlV
         HPPinl8OW8seCyQQSiQP0K9N0R+gdlHyou0EZQZx23H3HaJJz8CQdFmejAhKz3C1KH
         SIkSlD5BrB27A3pp001HDQL+W8k+d8ZgvwNMtJYg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15AA83cJ046584
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jun 2021 05:08:03 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 10
 Jun 2021 05:08:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 10 Jun 2021 05:08:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15AA82hH031094;
        Thu, 10 Jun 2021 05:08:02 -0500
Date:   Thu, 10 Jun 2021 15:38:01 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     John Thomson <git@johnthomson.fastmail.com.au>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] mtd: spi-nor: write support for minor aligned partitions
Message-ID: <20210610100759.v57c5wa46ky33waj@ti.com>
References: <20210608040719.14431-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210608040719.14431-1-git@johnthomson.fastmail.com.au>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/21 02:07PM, John Thomson wrote:
> Do not prevent writing to mtd partitions where a partition boundary sits
> on a minor erasesize boundary.
> This addresses a FIXME that has been present since the start of the
> linux git history:
> /* Doesn't start on a boundary of major erase size */
> /* FIXME: Let it be writable if it is on a boundary of
>  * _minor_ erase size though */
> 
> Allow a uniform erase region spi-nor device to be configured
> to use the non-uniform erase regions code path for an erase with:
> CONFIG_MTD_SPI_NOR_USE_VARIABLE_ERASE=y
> 
> On supporting hardware (SECT_4K: majority of current SPI-NOR device)
> provide the facility for an erase to use the least number
> of SPI-NOR operations, as well as access to 4K erase without
> requiring CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
> 
> Introduce erasesize_minor to the mtd struct,
> the smallest erasesize supported by the device

Instead of having just a major and minor erase size, wouldn't it make 
more sense to have a list of all supported erases on a sector? That is, 
instead of hard coding two erase size instead of one, how about 
generalizing the erase machinery to allow any number of erase sizes on a 
sector and then choosing the most efficient one on run time?

For example, imagine a device can support 4K, 64K, and 256K erases on 
each sector. Then you should be able to use 2 x 4K erases if you want to 
erase 8K, 2 x 64K + 1 x 4K erases for 132K and so on.

I am not very familiar with MTD erase machinery so I would like someone 
else to chime in, but I think my suggestion above is the better way 
forward.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
