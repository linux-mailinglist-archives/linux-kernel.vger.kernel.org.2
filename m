Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913F33D7AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbhG0QNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhG0QNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:13:37 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D89DC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 09:13:36 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1m8Phv-0007rV-0H; Tue, 27 Jul 2021 18:13:27 +0200
Date:   Tue, 27 Jul 2021 18:13:26 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, tudor.ambarus@microchip.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] mtd: rawnand: Fix probe failure due to
 of_get_nand_secure_regions()
Message-ID: <20210727161326.wozj23a3sblibwpk@viti.kaiser.cx>
References: <20210727062813.32619-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727062813.32619-1-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani and all,

Thus wrote Manivannan Sadhasivam (manivannan.sadhasivam@linaro.org):

> Due to 14f97f0b8e2b, the rawnand platforms without "secure-regions"
> property defined in DT fails to probe. The issue is,
> of_get_nand_secure_regions() errors out if
> of_property_count_elems_of_size() returns a negative error code.

> If the "secure-regions" property is not present in DT, then also we'll
> get -EINVAL from of_property_count_elems_of_size() but it should not
> be treated as an error for platforms not declaring "secure-regions"
> in DT.

> So fix this behaviour by checking for the existence of that property in
> DT and return 0 if it is not present.

> Fixes: 14f97f0b8e2b ("mtd: rawnand: Add a check in of_get_nand_secure_regions()")
> Reported-by: Martin Kaiser <martin@kaiser.cx>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 6 ++++++
>  1 file changed, 6 insertions(+)

> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index cbba46432e39..3d6c6e880520 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -5228,8 +5228,14 @@ static bool of_get_nand_on_flash_bbt(struct device_node *np)
>  static int of_get_nand_secure_regions(struct nand_chip *chip)
>  {
>  	struct device_node *dn = nand_get_flash_node(chip);
> +	struct property *prop;
>  	int nr_elem, i, j;

> +	/* Only proceed if the "secure-regions" property is present in DT */
> +	prop = of_find_property(dn, "secure-regions", NULL);
> +	if (!prop)
> +		return 0;
> +
>  	nr_elem = of_property_count_elems_of_size(dn, "secure-regions", sizeof(u64));
>  	if (nr_elem <= 0)
>  		return nr_elem;
> -- 
> 2.25.1

not surprisingly, this fixes the issue for me.

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
Tested-by: Martin Kaiser <martin@kaiser.cx>

Still, I was wondering if the behaviour of of_property_count_elems_of_size
makes sense. Without a prior check, there's no chance for the caller to
distinguish between "property is absent" and "property is malformed". 

Thanks,
Martin
