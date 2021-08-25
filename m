Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BC83F734A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbhHYKaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:30:52 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:40234 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237244AbhHYKau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:30:50 -0400
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CA66B837F24A;
        Wed, 25 Aug 2021 10:30:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id A579C1A29FA;
        Wed, 25 Aug 2021 10:30:01 +0000 (UTC)
Message-ID: <53afc244281b6a76aecf4a5565d7e6395e376d4e.camel@perches.com>
Subject: Re: [PATCH] mxser: use semi-colons instead of commas
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Wed, 25 Aug 2021 03:30:00 -0700
In-Reply-To: <20210825072435.GB13013@kili>
References: <20210825072435.GB13013@kili>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: fhz34dbq4brzn9e34cqdugwpe39kmw6f
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A579C1A29FA
X-Spam-Status: No, score=-0.57
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+5U8rMBtJFv9T/N4vofemkm0kOCT7Z/2Y=
X-HE-Tag: 1629887401-102061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-08-25 at 10:24 +0300, Dan Carpenter wrote:
> This code works, but it's cleaner to use semi-colons at the end of
> a statement instead of a comma.

There are still multiple dozens of this type of comma use
in the kernel.

Julia Lawall created a cocci script to convert the commas
to semicolons that worked pretty well.

https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2008201856110.2524@hadrien/

> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
[]
> @@ -1039,12 +1039,12 @@ static int mxser_get_serial_info(struct tty_struct *tty,
>  	if (closing_wait != ASYNC_CLOSING_WAIT_NONE)
>  		closing_wait = jiffies_to_msecs(closing_wait) / 10;
>  
> 
> -	ss->type = info->type,
> -	ss->line = tty->index,
> -	ss->port = info->ioaddr,
> -	ss->irq = info->board->irq,
> -	ss->flags = info->port.flags,
> -	ss->baud_base = MXSER_BAUD_BASE,
> +	ss->type = info->type;
> +	ss->line = tty->index;
> +	ss->port = info->ioaddr;
> +	ss->irq = info->board->irq;
> +	ss->flags = info->port.flags;
> +	ss->baud_base = MXSER_BAUD_BASE;
>  	ss->close_delay = close_delay;
>  	ss->closing_wait = closing_wait;
>  	ss->custom_divisor = MXSER_CUSTOM_DIVISOR,


