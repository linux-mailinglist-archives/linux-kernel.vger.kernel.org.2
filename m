Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F076643AD35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhJZHeJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Oct 2021 03:34:09 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:44625 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJZHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:34:08 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 85D98100002;
        Tue, 26 Oct 2021 07:31:42 +0000 (UTC)
Date:   Tue, 26 Oct 2021 09:31:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andreas Oetken <ennoerlangen@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas Oetken <andreas.oetken@siemens-energy.com>
Subject: Re: [PATCH] drivers: mtd: Fixed breaking list in
 __mtd_del_partition.
Message-ID: <20211026093141.64be4e38@xps13>
In-Reply-To: <20211025205724.3306739-1-andreas.oetken@siemens-energy.com>
References: <20211025205724.3306739-1-andreas.oetken@siemens-energy.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

ennoerlangen@gmail.com wrote on Mon, 25 Oct 2021 22:57:24 +0200:

> Not the child partition should be removed from the partition list
> but the partition itself. Otherwise the partition list gets broken
> and any subsequent remove operations leads to a kernel panic.
> 

Can you please Add a couple of Fixes: + Cc: stable tags?

> Signed-off-by: Andreas Oetken <andreas.oetken@siemens-energy.com>
> ---
>  drivers/mtd/mtdpart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 95d47422bbf20..5725818fa199f 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -313,7 +313,7 @@ static int __mtd_del_partition(struct mtd_info *mtd)
>  	if (err)
>  		return err;
>  
> -	list_del(&child->part.node);
> +	list_del(&mtd->part.node);
>  	free_partition(mtd);
>  
>  	return 0;


Thanks,
Miquèl
