Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE5A358392
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhDHMq1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Apr 2021 08:46:27 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:60317 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhDHMq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:46:26 -0400
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 589EB100013;
        Thu,  8 Apr 2021 12:46:12 +0000 (UTC)
Date:   Thu, 8 Apr 2021 14:46:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     <joern@lazybastard.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <matthias.bgg@gmail.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yi.zhang@huawei.com>
Subject: Re: [PATCH 3/3] mtd: phram: Fix error return code in phram_setup()
Message-ID: <20210408144610.0c0686ae@xps13>
In-Reply-To: <20210408111514.1011020-4-yukuai3@huawei.com>
References: <20210408111514.1011020-1-yukuai3@huawei.com>
        <20210408111514.1011020-4-yukuai3@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

Yu Kuai <yukuai3@huawei.com> wrote on Thu, 8 Apr 2021 19:15:14 +0800:

> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/mtd/devices/phram.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
> index 5b04ae6c3057..6ed6c51fac69 100644
> --- a/drivers/mtd/devices/phram.c
> +++ b/drivers/mtd/devices/phram.c
> @@ -270,6 +270,7 @@ static int phram_setup(const char *val)
>  	if (len == 0 || erasesize == 0 || erasesize > len
>  	    || erasesize > UINT_MAX || rem) {
>  		parse_err("illegal erasesize or len\n");
> +		ret = -EINVAL;
>  		goto error;
>  	}
>  

It looks like you're doing the opposite of what you say.

Thanks,
Miquèl
