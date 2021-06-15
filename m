Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9A3A7F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFONZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhFONZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:25:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D6B16145D;
        Tue, 15 Jun 2021 13:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623763426;
        bh=njAVyJRWhBO8YU/Or9Lp1K4CKrYWEHtrBeO7xM2r8bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oq6jCPTrRIN3sdQDVBmIOAKW5zx24/7UOmZRhFhNCFDc+7TF+K7QCsRh5bH7jr+ZO
         YjfnbG0ZRhB2byC0AN97v/XZWoP+SvTfI0gx0I4oNnKvWq6kgfWrW/leAR88JzkEGP
         YFZCGdC5o1qIglx5y6NfBie68elEo9NPBEv96H4U=
Date:   Tue, 15 Jun 2021 15:23:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] staging: rtl8723bs: move LPS_RPWM_WAIT_MS macro
Message-ID: <YMip4N/RW1FYvnkd@kroah.com>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
 <5756b958b5d279f1cc8cea7887f50d003b17b94e.1623756906.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5756b958b5d279f1cc8cea7887f50d003b17b94e.1623756906.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 01:45:36PM +0200, Fabio Aiuto wrote:
> move LPS_RPWM_WAIT_MS macro from include/autoconf.h to
> include/hal_btcoex.h in order to empty unneeded
> autoconf.h.
> 
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/include/hal_btcoex.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/include/hal_btcoex.h b/drivers/staging/rtl8723bs/include/hal_btcoex.h
> index eb9d0ba861a5..849fb90b43b7 100644
> --- a/drivers/staging/rtl8723bs/include/hal_btcoex.h
> +++ b/drivers/staging/rtl8723bs/include/hal_btcoex.h
> @@ -9,6 +9,8 @@
>  
>  #include <drv_types.h>
>  
> +#define LPS_RPWM_WAIT_MS	300
> +
>  /*  Some variables can't get from outsrc BT-Coex, */
>  /*  so we need to save here */
>  struct bt_coexist {
> -- 
> 2.20.1
> 
> 

Note, this did not "move" anything, it just added it.

I'll take it, but be more careful in the future please.

thanks,

greg k-h
