Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B249330AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhCHKIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:08:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51312 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhCHKIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:08:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 128A3UkX009810;
        Mon, 8 Mar 2021 04:03:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615197810;
        bh=BWvL4Cr1ZKgQ/f6q2AUSU2PkTWuHi0CFrxYQThL4B4A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uaHO7COVhsb9ICQ48tIBfw7xDW3+k+lMvZaS6O++l9Ort07xG0JluNI65/8DK87AJ
         hBp3vQ9YrVtVsAeYCrmlzRZfSctIVesFwk/zmWyZFKsynB3UP6nFM19InGLpnToiu0
         bkgby75EZUyT/Z/k9RZ4JM5/04ltFy8uFh5r+cps=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 128A3Uod097615
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 04:03:30 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 04:03:30 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 04:03:30 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 128A3RQq093760;
        Mon, 8 Mar 2021 04:03:28 -0600
Subject: Re: [PATCH] MAINTAINERS: Add Michael and Pratyush as designated
 reviewers for SPI NOR
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <michael@walle.cc>,
        <p.yadav@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>
References: <20210308092333.80521-1-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <a4369f1c-fb59-ae96-42a9-9b6f1a02060a@ti.com>
Date:   Mon, 8 Mar 2021 15:33:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308092333.80521-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/21 2:53 PM, Tudor Ambarus wrote:
> It's already been the case for some time that Michael and Pratyush
> are reviewing SPI NOR patches. Update MAINTAINERS to reflect reality.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

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
> 
