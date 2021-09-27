Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A87419532
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhI0Njz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:39:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60332 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhI0Njy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:39:54 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18RDc74e004328;
        Mon, 27 Sep 2021 08:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632749887;
        bh=DCKjXvBPcTFSaHvRzpi9LbszU5rTTnzEeL7qD7ID1K0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xlAAAl5m2wqfELe+3wvlHeFZ8Z4dbIS1BiUxEn1Lcgir6ubyB1NXYvwNGXguKC/sF
         B9IqViEcjrDPGBbTb3lLMznIw7q0kEkQ7bgsEaRTW3/C84Nj4TPC3MMYV9dt/0i7ZX
         1PQqGb9qky7+ekp3ViHH4f4fysSPebd/ZPdrYC8Q=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18RDc7HC100275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Sep 2021 08:38:07 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Sep 2021 08:38:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Sep 2021 08:38:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18RDc7mR022309;
        Mon, 27 Sep 2021 08:38:07 -0500
Date:   Mon, 27 Sep 2021 08:38:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <kristo@kernel.org>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] firmware: ti_sci: Use devm_bitmap_zalloc when applicable
Message-ID: <20210927133807.rtkfjkxxlwpdqcnf@scouring>
References: <1bd77909ff75f62a2228a39db208c4c6d1b3e0e2.1632659746.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1bd77909ff75f62a2228a39db208c4c6d1b3e0e2.1632659746.git.christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:36-20210926, Christophe JAILLET wrote:
> 'xfer_alloc_table' is a bitmap. So use 'devm_bitmap_zalloc()' to simplify
> code and improve the semantic of the code.
> 
> While at it, remove a redundant 'bitmap_zero()' call.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/firmware/ti_sci.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 235c7e7869aa..a33eb884102f 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -3352,13 +3352,11 @@ static int ti_sci_probe(struct platform_device *pdev)
>  	if (!minfo->xfer_block)
>  		return -ENOMEM;
>  
> -	minfo->xfer_alloc_table = devm_kcalloc(dev,
> -					       BITS_TO_LONGS(desc->max_msgs),
> -					       sizeof(unsigned long),
> -					       GFP_KERNEL);
> +	minfo->xfer_alloc_table = devm_bitmap_zalloc(dev,
> +						     desc->max_msgs,
> +						     GFP_KERNEL);
>  	if (!minfo->xfer_alloc_table)
>  		return -ENOMEM;
> -	bitmap_zero(minfo->xfer_alloc_table, desc->max_msgs);
>  
>  	/* Pre-initialize the buffer pointer to pre-allocated buffers */
>  	for (i = 0, xfer = minfo->xfer_block; i < desc->max_msgs; i++, xfer++) {
> -- 
> 2.30.2
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
