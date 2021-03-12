Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA682338778
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhCLIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbhCLIdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:33:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF64E64F6D;
        Fri, 12 Mar 2021 08:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615538020;
        bh=2QmrWLt/8fKtwKSmY7oZM80CYQiHKdcJGLksaKtWM9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acZw/M1wQvuLRBy6HgW7nmBDG56NR2+itE8bh9qxCpjUZgsHA1++xm8jpYbBWtkQA
         mNPHBwv8snQgLX0icCNWqmAzhgXua00fv4bqHtP1Vy1UpsOhT9e9t7U0GSrW5M5LDI
         4+oDZ96turxEfMsZtMdHmOSGDEfLmlZDj2Gt5qio=
Date:   Fri, 12 Mar 2021 09:33:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hassan Shahbazi <h.shahbazi.git@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: tty: vt: vt.c: fix NULL dereference crash
Message-ID: <YEsnYVwzRoEsbkie@kroah.com>
References: <20210307105642.112572-1-h.shahbazi.git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307105642.112572-1-h.shahbazi.git@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 12:56:43PM +0200, Hassan Shahbazi wrote:
> Fix a NULL deference crash on hiding the cursor.
> 
> Reported by: syzbot
> https://syzkaller.appspot.com/bug?id=defb47bf56e1c14d5687280c7bb91ce7b608b94b
> 
> Signed-off-by: Hassan Shahbazi <h.shahbazi.git@gmail.com>
> ---
>  drivers/tty/vt/vt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 284b07224c55..8c3e83c81341 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -904,7 +904,9 @@ static void hide_cursor(struct vc_data *vc)
>  	if (vc_is_sel(vc))
>  		clear_selection();
>  
> -	vc->vc_sw->con_cursor(vc, CM_ERASE);
> +	if (vc->vc_sw)
> +		vc->vc_sw->con_cursor(vc, CM_ERASE);
> +
>  	hide_softcursor(vc);
>  }
>  
> -- 
> 2.26.2
> 

Are you sure this actually fixes the problem?  How did you test it?  Did
syzbot test this?

I had a few reports of this patch _not_ solving the problem, so getting
confirmation of this would be good.

thanks,

greg k-h
