Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E973D0D15
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhGUK3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239633AbhGUKT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:19:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 693A16024A;
        Wed, 21 Jul 2021 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626865127;
        bh=DFwEgDEXW/LZtYl7uojJx9kXcSpyiS4kMBCg+Z++wLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyhdzGEsyrrB30xG4064GTctlnUiMhxEE6TpBf940Iqx/pVH4oVoEaf/9YJN9nw+o
         CRQ65lrqddfptubI8FrFjDSmvaH9FKkkoBWmIfJvqv3QhWA5bF6N86Y0Ek9eplcEg2
         G4dxzE07jdwrRubg0sdyehTxAnbxyBWbJ+dRRSJ8=
Date:   Wed, 21 Jul 2021 12:58:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: nozomi: change tty_unregister_device to
 tty_port_unregister_device
Message-ID: <YPf95Wd6pbjgeU3g@kroah.com>
References: <20210720083805.1430892-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720083805.1430892-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 04:38:05PM +0800, Dongliang Mu wrote:
> The pairwise api invocation of tty_port_register_device should be
> tty_port_unregister_device, other than tty_unregister_device.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/tty/nozomi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
> index 0c80f25c8c3d..08bdd82f60b5 100644
> --- a/drivers/tty/nozomi.c
> +++ b/drivers/tty/nozomi.c
> @@ -1417,7 +1417,8 @@ static int nozomi_card_init(struct pci_dev *pdev,
>  
>  err_free_tty:
>  	for (i--; i >= 0; i--) {
> -		tty_unregister_device(ntty_driver, dc->index_start + i);
> +		tty_port_unregister_device(&dc->port[i].port, ntty_driver,
> +				dc->index_start + i);
>  		tty_port_destroy(&dc->port[i].port);
>  	}
>  	free_irq(pdev->irq, dc);
> -- 
> 2.25.1
> 

What commit does this fix?  Should it go to stable kernels?  Can you
please resend it with that information?

And how did you find this?

thanks,

greg k-h
