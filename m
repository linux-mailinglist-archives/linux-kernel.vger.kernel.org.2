Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024B233080B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbhCHGXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:23:48 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54644 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhCHGXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:23:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1286N75W051359;
        Mon, 8 Mar 2021 00:23:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615184587;
        bh=QklpySCLOwECbEk2YWP3FRQbNMYZhudGOqMYSRereIc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cqMnerDD9HPv1w2NGd/PV60ZTgBBK67KVh3pr6VEJ+JMUkbDEOIchqoz35qbyYdjW
         hu2T/1vnWyYsEKqcLafb9oFgYapnhcoh7OO8ZQCz2wmXgw/RxljTmR+/67oQc3zEuw
         ui5fMvC6jLhJhHWVTIAdB8saQtEKtgqEHDlvDUC0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1286N7Yx026903
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 00:23:07 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 00:23:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 00:23:07 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1286N4Od093672;
        Mon, 8 Mar 2021 00:23:05 -0600
Subject: Re: [PATCH v1 1/1] mtd: spi-nor: intel-spi: Move platform data header
 to x85 subfolder
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Lee Jones <lee.jones@linaro.org>
References: <20210304140820.56692-1-andriy.shevchenko@linux.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <a515499d-d91d-117e-8cc9-de1f12912358@ti.com>
Date:   Mon, 8 Mar 2021 11:53:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210304140820.56692-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/21 7:38 PM, Andy Shevchenko wrote:
> In order to group x86 related platform data move intel-spi.h to x85 folder.
> 
> While at it, remove duplicate inclusion in C file.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Nit, typo in $subject and commit message: s/x85/x86. Tudor may be able
to fix it locally while applying.

Apart from that

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Regards
Vignesh

>  drivers/mtd/spi-nor/controllers/intel-spi.c       | 1 -
>  drivers/mtd/spi-nor/controllers/intel-spi.h       | 2 +-
>  include/linux/mfd/lpc_ich.h                       | 2 +-
>  include/linux/platform_data/{ => x86}/intel-spi.h | 0
>  4 files changed, 2 insertions(+), 3 deletions(-)
>  rename include/linux/platform_data/{ => x86}/intel-spi.h (100%)
> 
> diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
> index b54a56a68100..a413892ff449 100644
> --- a/drivers/mtd/spi-nor/controllers/intel-spi.c
> +++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
> @@ -15,7 +15,6 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/spi-nor.h>
> -#include <linux/platform_data/intel-spi.h>
>  
>  #include "intel-spi.h"
>  
> diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.h b/drivers/mtd/spi-nor/controllers/intel-spi.h
> index e2f41b8827bf..f2871179fd34 100644
> --- a/drivers/mtd/spi-nor/controllers/intel-spi.h
> +++ b/drivers/mtd/spi-nor/controllers/intel-spi.h
> @@ -9,7 +9,7 @@
>  #ifndef INTEL_SPI_H
>  #define INTEL_SPI_H
>  
> -#include <linux/platform_data/intel-spi.h>
> +#include <linux/platform_data/x86/intel-spi.h>
>  
>  struct intel_spi;
>  struct resource;
> diff --git a/include/linux/mfd/lpc_ich.h b/include/linux/mfd/lpc_ich.h
> index 6ddca2bbb3a8..39967a5eca6d 100644
> --- a/include/linux/mfd/lpc_ich.h
> +++ b/include/linux/mfd/lpc_ich.h
> @@ -8,7 +8,7 @@
>  #ifndef LPC_ICH_H
>  #define LPC_ICH_H
>  
> -#include <linux/platform_data/intel-spi.h>
> +#include <linux/platform_data/x86/intel-spi.h>
>  
>  /* GPIO resources */
>  #define ICH_RES_GPIO	0
> diff --git a/include/linux/platform_data/intel-spi.h b/include/linux/platform_data/x86/intel-spi.h
> similarity index 100%
> rename from include/linux/platform_data/intel-spi.h
> rename to include/linux/platform_data/x86/intel-spi.h
> 
