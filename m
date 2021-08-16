Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DEA3ECEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhHPHA4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 03:00:56 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:64883 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhHPHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:00:55 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 753A740007;
        Mon, 16 Aug 2021 07:00:22 +0000 (UTC)
Date:   Mon, 16 Aug 2021 09:00:20 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH V4 7/8] i3c: master: svc: add the missing module device
 table
Message-ID: <20210816090020.65e1a908@xps13>
In-Reply-To: <20210809063645.2289988-8-xiaoning.wang@nxp.com>
References: <20210809063645.2289988-1-xiaoning.wang@nxp.com>
        <20210809063645.2289988-8-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

Clark Wang <xiaoning.wang@nxp.com> wrote on Mon,  9 Aug 2021 14:36:44
+0800:

> The missing MODULE_DEVICE_TABLE() will cause the svc-i3c-master cannot
> be auto probed when it is built in moudle.
> So add it.
> 
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Jun Li <jun.li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
> V4: New patch in this patchset
> ---
>  drivers/i3c/master/svc-i3c-master.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 5939e0936697..77f67d407acd 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1612,6 +1612,7 @@ static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
>  	{ .compatible = "silvaco,i3c-master" },
>  	{ /* sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
>  
>  static struct platform_driver svc_i3c_master = {
>  	.probe = svc_i3c_master_probe,

Thanks,
Miquèl
