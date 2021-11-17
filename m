Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C592454747
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhKQNfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237617AbhKQNfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:35:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E89D61B2B;
        Wed, 17 Nov 2021 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637155928;
        bh=RqhuoZ7YaVo+Q6mLkZ6Y9JXOf35z24ngjYLLZhdDNlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEO0+fU+NaFgslnhjjyVMcsMtuT+MrokVCExg1ovve5lSTOhki3Jc/igmRd6WalMR
         tPRQaX2EHQEwm+1Vd5ocI4AJXzJT2V0XDYZbz3YlO8NNYhE6K7juTJ+btAVW3HGw9A
         DFHTxrtN6TtwBZsmHOfmUMaQa3Maqqix5pkIO87Y=
Date:   Wed, 17 Nov 2021 14:32:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] USB: Delete the useless assignment to "nbytes"
Message-ID: <YZUEVswwxLsNyV04@kroah.com>
References: <20211111151124.2659-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111151124.2659-1-luo.penghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 03:11:24PM +0000, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> The assignment of the local variable "nbytes" in the if statement
> will not be used
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---
>  drivers/usb/mon/mon_bin.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
> index f48a23a..b8ba0f7 100644
> --- a/drivers/usb/mon/mon_bin.c
> +++ b/drivers/usb/mon/mon_bin.c
> @@ -845,7 +845,6 @@ static ssize_t mon_bin_read(struct file *file, char __user *buf,
>  			mutex_unlock(&rp->fetch_lock);
>  			return -EFAULT;
>  		}
> -		nbytes -= step_len;
>  		buf += step_len;
>  		rp->b_read += step_len;
>  		done += step_len;
> -- 
> 2.15.2
> 
> 

This patch is not correct (it's either wrong, or incomplete).  Please
fix your "robot" to not send changes that you have not properly
verified.

thanks,

greg k-h
