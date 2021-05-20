Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E6338B551
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhETRko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:40:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37004 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhETRkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:40:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14KHdAwa008305;
        Thu, 20 May 2021 12:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621532350;
        bh=YsFqlXZ/Hajwge5aNHpzS6T/LhRAspSHg6EuVrihBzE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uqhVOJUZwiQhO6gcTqnqVlg9kvhMPYwHL7+LyeiCS/YNaFcN863OBBp/0ufzHp36k
         gwhiXr7rKFBLN0nIwTbt8YRxku9JMW5tpOSJ8pceOnD/MHpyuyyPDhAll+hlckt0CW
         qQ3QrWxaCfYrs4iihC0l7WUafn7YtZL8Pi3LVlZo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14KHdAZd105531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 May 2021 12:39:10 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 12:39:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 20 May 2021 12:39:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14KHd8rm001846;
        Thu, 20 May 2021 12:39:09 -0500
Date:   Thu, 20 May 2021 23:09:08 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: otp: use more consistent wording
Message-ID: <20210520173906.3h3m6lykfpnmznkx@ti.com>
References: <20210520155854.16547-1-michael@walle.cc>
 <20210520155854.16547-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210520155854.16547-3-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/21 05:58PM, Michael Walle wrote:
> Use the wording as used in the datasheet to describe the access methods
> of the security registers (aka OTP storage). This will also match the
> function names.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/otp.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
> index 91a4c510ed51..ec0c1b33f7cc 100644
> --- a/drivers/mtd/spi-nor/otp.c
> +++ b/drivers/mtd/spi-nor/otp.c
> @@ -15,14 +15,16 @@
>  #define spi_nor_otp_n_regions(nor) ((nor)->params->otp.org->n_regions)
>  
>  /**
> - * spi_nor_otp_read_secr() - read OTP data
> + * spi_nor_otp_read_secr() - read security register
>   * @nor:	pointer to 'struct spi_nor'
>   * @addr:       offset to read from
>   * @len:        number of bytes to read
>   * @buf:        pointer to dst buffer
>   *
> - * Read OTP data from one region by using the SPINOR_OP_RSECR commands. This
> - * method is used on GigaDevice and Winbond flashes.
> + * Read a security register by using the SPINOR_OP_RSECR commands. This method
> + * is used on GigaDevice and Winbond flashes to access OTP data.
> + *
> + * Please note, the read must not span multiple registers.

Security register is a very vague term. It in no way tells you that it 
means OTP data unless you already know. If I read this for the first 
time, I would think it is some sort of password or access enable/disable 
type of register, and not OTP data region.

Please add a note to clarify this. Same for the write and erase 
functions.

With this fixed,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

>   *
>   * Return: number of bytes read successfully, -errno otherwise
>   */
> @@ -56,16 +58,16 @@ int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
>  }
>  
>  /**
> - * spi_nor_otp_write_secr() - write OTP data
> + * spi_nor_otp_write_secr() - write security register
>   * @nor:        pointer to 'struct spi_nor'
>   * @addr:       offset to write to
>   * @len:        number of bytes to write
>   * @buf:        pointer to src buffer
>   *
> - * Write OTP data to one region by using the SPINOR_OP_PSECR commands. This
> - * method is used on GigaDevice and Winbond flashes.
> + * Write a security register by using the SPINOR_OP_PSECR commands. This method
> + * is used on GigaDevice and Winbond flashes to access OTP data.
>   *
> - * Please note, the write must not span multiple OTP regions.
> + * Please note, the write must not span multiple registers.
>   *
>   * Return: number of bytes written successfully, -errno otherwise
>   */
> @@ -88,7 +90,7 @@ int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
>  
>  	/*
>  	 * We only support a write to one single page. For now all winbond
> -	 * flashes only have one page per OTP region.
> +	 * flashes only have one page per security register.
>  	 */
>  	ret = spi_nor_write_enable(nor);
>  	if (ret)
> -- 
> 2.20.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
