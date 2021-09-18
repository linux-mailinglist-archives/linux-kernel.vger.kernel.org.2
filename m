Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666CF41047B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbhIRGwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 02:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232721AbhIRGwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:52:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5934861052;
        Sat, 18 Sep 2021 06:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631947882;
        bh=mnbm4SqrJc6QcChjp+TKhYE9PhGbWQh2MLRpWSNuSog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShJxf7wmeN2bRNYBtXcfdVD1BljL9wGoZr+AxaWTyRzATauKmMzqcihKm9l5G3tW9
         OKJV0g7rzZP68+yA+oFx77YRNI6oUv53tt0FsmJ0qQQ5nHdPlct7j+ZVs1T8+qS+VP
         s07p51hOMaAJzxh9ky6NMnlTvPTz61gzwHFAIfac=
Date:   Sat, 18 Sep 2021 08:51:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        phil@philpotter.co.uk, straube.linux@gmail.com, martin@kaiser.cx,
        paskripkin@gmail.com, nathan@kernel.org,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH V2] staging: r8188eu: use ARRAY_SIZE
Message-ID: <YUWMWEJLX7Xj6nl4@kroah.com>
References: <20210918033910.237216-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918033910.237216-1-deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 03:39:10AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index d04d2f658ce0..44bee3b2d0ce 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -261,10 +261,8 @@ static void process_spec_devid(const struct usb_device_id *pdid)
>  	u16 vid, pid;
>  	u32 flags;
>  	int i;
> -	int num = sizeof(specific_device_id_tbl) /
> -		  sizeof(struct specific_device_id);
>  
> -	for (i = 0; i < num; i++) {
> +	for (i = 0; i < ARRAY_SIZE(specific_device_id_tbl); i++) {
>  		vid = specific_device_id_tbl[i].idVendor;
>  		pid = specific_device_id_tbl[i].idProduct;
>  		flags = specific_device_id_tbl[i].flags;
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
