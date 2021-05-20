Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAFD38B55B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhETRma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:42:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54268 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbhETRm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:42:27 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14KHemLf076201;
        Thu, 20 May 2021 12:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621532448;
        bh=As/rsp/ZN/WjQohJMlHsJic0S5FeRBqChGR/2ESLt+0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aNgEF4wDBo/rtV0c6nfaxHn8+0YkXO2ILT6DIB3GA+B2QiPVFDkIBt2uMeG9B8Ixy
         dJjMKWRQkI7k6/TnrgMUsKc+c3jaNfUmpYg0oQ2jiOGArIlWTgZ+1QNBAZ4lumssAc
         BWfs7xji/9OBLQtcqiQIF9ieXIiSMFx6fC2xOvIA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14KHemGl065082
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 May 2021 12:40:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 12:40:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 20 May 2021 12:40:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14KHelTr014229;
        Thu, 20 May 2021 12:40:48 -0500
Date:   Thu, 20 May 2021 23:10:47 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 1/3] mtd: spi-nor: otp: fix access to security
 registers in 4 byte mode
Message-ID: <20210520174045.sxbffwia7mec24rt@ti.com>
References: <20210520155854.16547-1-michael@walle.cc>
 <20210520155854.16547-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210520155854.16547-2-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/21 05:58PM, Michael Walle wrote:
> The security registers either take a 3 byte or a 4 byte address offset,
> depending on the address mode of the flash. Thus just leave the
> nor->addr_width as is.
> 
> Fixes: cad3193fe9d1 ("mtd: spi-nor: implement OTP support for Winbond and similar flashes")
> Signed-off-by: Michael Walle <michael@walle.cc>

I have not done due diligence in researching this topic. But the premise 
sounds good to me. So,

Acked-by: Pratyush Yadav <p.yadav@ti.com>

> ---
>  drivers/mtd/spi-nor/otp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
> index 61036c716abb..91a4c510ed51 100644
> --- a/drivers/mtd/spi-nor/otp.c
> +++ b/drivers/mtd/spi-nor/otp.c
> @@ -40,7 +40,6 @@ int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
>  	rdesc = nor->dirmap.rdesc;
>  
>  	nor->read_opcode = SPINOR_OP_RSECR;
> -	nor->addr_width = 3;
>  	nor->read_dummy = 8;
>  	nor->read_proto = SNOR_PROTO_1_1_1;
>  	nor->dirmap.rdesc = NULL;
> @@ -84,7 +83,6 @@ int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
>  	wdesc = nor->dirmap.wdesc;
>  
>  	nor->program_opcode = SPINOR_OP_PSECR;
> -	nor->addr_width = 3;
>  	nor->write_proto = SNOR_PROTO_1_1_1;
>  	nor->dirmap.wdesc = NULL;
>  
> -- 
> 2.20.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
