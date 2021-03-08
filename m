Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D90330A4C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCHJ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:29:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40764 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhCHJ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:28:32 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1289SLvZ050081;
        Mon, 8 Mar 2021 03:28:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615195701;
        bh=0BgwOyXj46vN2xSUIzDn7AJEwtHYfiYNyoZA6nVxYlE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XpyqItcZFs2eJ5uqzFPTOeal1CiLe2yY+dPZGdpkQKYExgMRYwhzuyVIT+SV82bt6
         Lq06JDWX0YrBdEfhzlA1bCpQVTGvDhJzYikmUYf58R4EtALH6U4fQ9RxnuHNsfHZLK
         XLNQYqosyqpSungJdn9ldXW1l2xwbv9EYc3qNuso=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1289SLwx077045
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 03:28:21 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 03:28:20 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 03:28:20 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1289SKh8028622;
        Mon, 8 Mar 2021 03:28:20 -0600
Date:   Mon, 8 Mar 2021 14:58:19 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH] MAINTAINERS: Add Michael and Pratyush as designated
 reviewers for SPI NOR
Message-ID: <20210308092817.k2gtrz5xwxofynbk@ti.com>
References: <20210308092333.80521-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210308092333.80521-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/21 11:23AM, Tudor Ambarus wrote:
> It's already been the case for some time that Michael and Pratyush
> are reviewing SPI NOR patches. Update MAINTAINERS to reflect reality.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Pratyush Yadav <p.yadav@ti.com>

> ---
> Michael, Pratyush, please send your Acked-by tags if you agree.
> 
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d92f85ca831d..ba561e5bc6f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16862,6 +16862,8 @@ F:	arch/arm/mach-spear/
>  
>  SPI NOR SUBSYSTEM
>  M:	Tudor Ambarus <tudor.ambarus@microchip.com>
> +R:	Michael Walle <michael@walle.cc>
> +R:	Pratyush Yadav <p.yadav@ti.com>
>  L:	linux-mtd@lists.infradead.org
>  S:	Maintained
>  W:	http://www.linux-mtd.infradead.org/
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
