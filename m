Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC85E31F774
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBSKlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSKkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:40:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A173264EB7;
        Fri, 19 Feb 2021 10:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613731213;
        bh=RErC9QubHxzQe6XsyUGu3rb6BZK6OYuteFLCp8HvQek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGK43yxv3kz5h9SA9UZG1tcj6GOBLFZeMtjfjuCFnDzFpb440fVwmDdNpouB9mXHv
         s+c6SMKum2sA6x1Y97jcipBUrupBIMNL6Sp2gZC5vI19/ZWsFE/dxlouxKr7dxATFL
         E2pKQNs/XNptXI9blNNzv3OY8wdQDrm6c1UZ63wY=
Date:   Fri, 19 Feb 2021 11:40:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Selvakumar Elangovan <selvakumar16197@gmail.com>
Cc:     forest@alittletooquiet.net, tvboxspy@gmail.com,
        oscar.carter@gmx.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] staging: vt6656: fixed a CamelCase coding style issue.
Message-ID: <YC+Vii75qR3Mz48k@kroah.com>
References: <20210219095835.9687-1-selvakumar16197@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219095835.9687-1-selvakumar16197@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:28:35PM +0530, Selvakumar Elangovan wrote:
> This patch renames CamelCase macros uVar and uModulo into u_var and
> u_module in device.h
> 
> This issue was reported by checkpatch.pl
> 
> Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
> ---
>  drivers/staging/vt6656/device.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/device.h b/drivers/staging/vt6656/device.h
> index 947530fefe94..6615d356f74a 100644
> --- a/drivers/staging/vt6656/device.h
> +++ b/drivers/staging/vt6656/device.h
> @@ -385,11 +385,11 @@ struct vnt_private {
>  	struct ieee80211_low_level_stats low_stats;
>  };
>  
> -#define ADD_ONE_WITH_WRAP_AROUND(uVar, uModulo) {	\
> -	if ((uVar) >= ((uModulo) - 1))			\
> -		(uVar) = 0;				\
> +#define ADD_ONE_WITH_WRAP_AROUND(u_var, u_modulo) {	\

"u_" does not really make any sense, right?

Just use "var" and "modulo" please.

But first, why is this needed at all?  Isn't there an in-kernel function
that should be used instead?

thanks,

greg k-h
