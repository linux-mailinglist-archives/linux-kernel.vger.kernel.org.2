Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E007392B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhE0KDH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 May 2021 06:03:07 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58745 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbhE0KDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:03:06 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 75FBD100005;
        Thu, 27 May 2021 10:01:29 +0000 (UTC)
Date:   Thu, 27 May 2021 12:01:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-i3c@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH -next] i3c: master: svc: drop free_irq of
 devm_request_irq allocated irq
Message-ID: <20210527120123.75f2ea09@xps13>
In-Reply-To: <20210518131127.1308550-1-yangyingliang@huawei.com>
References: <20210518131127.1308550-1-yangyingliang@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Yang Yingliang <yangyingliang@huawei.com> wrote on Tue, 18 May 2021
21:11:27 +0800:

> irq allocated with devm_request_irq should not be freed using
> free_irq, because doing so causes a dangling pointer, and a
> subsequent double free.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 1f6ba4221817..761c9c468357 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1448,7 +1448,7 @@ static int svc_i3c_master_remove(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	free_irq(master->irq, master);
> +	devm_free_irq(&pdev->dev, master->irq, master);

Wouldn't removing this call the right solution? If it's a device
managed resource, it won't probably be needed to free it explicitly in
the remove path.

>  	clk_disable_unprepare(master->pclk);
>  	clk_disable_unprepare(master->fclk);
>  	clk_disable_unprepare(master->sclk);

Thanks,
Miquèl
