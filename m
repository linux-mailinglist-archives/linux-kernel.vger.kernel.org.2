Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C122D414168
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhIVF6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231908AbhIVF6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:58:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FB426109F;
        Wed, 22 Sep 2021 05:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632290204;
        bh=jtNJBXWQJAFyj4dvIUymWXFcjy3iScaH2u/8N+y3SAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJgRQcfud2LwnhHkvhM9iKfY/hZOuwF9xSFo5f22Mkz6aIB445lMozpr2bt2YGYPc
         91bw9YsMIVH/ndf4LBld5aEsH+xq1+HA8qrxHb+MaCITkk1vZUTLN3CDwxkCEqPmFM
         rK+387ljTP4QBWzmowjp1iOj0Mm376RAxSZeN8Ak=
Date:   Wed, 22 Sep 2021 07:56:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: usb-skeleton: remove obsolete comment
Message-ID: <YUrFmc8jqkfqF1Nx@kroah.com>
References: <20210921214147.GA9648@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921214147.GA9648@matrix-ESPRIMO-P710>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:41:47PM +0200, Philipp Hortmann wrote:
> This patch fixes the checkpatch.pl warning:
> WARNING: It's generally not useful to have the filename in the file
> 7: FILE: drivers/usb/usb-skeleton.c:7:
> + * This driver is based on the 2.6.3 version of drivers/usb/usb-skeleton.c
> 
> Deleting both lines as the -2.6.3- makes the reader belief this is an
> unusable old file and the -rewritten to be easier ...- is only of value for
> the reader that knows what the driver was before.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/usb/usb-skeleton.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
> index d87deee3e26e..91da019a1171 100644
> --- a/drivers/usb/usb-skeleton.c
> +++ b/drivers/usb/usb-skeleton.c
> @@ -4,8 +4,6 @@
>   *
>   * Copyright (C) 2001-2004 Greg Kroah-Hartman (greg@kroah.com)
>   *
> - * This driver is based on the 2.6.3 version of drivers/usb/usb-skeleton.c
> - * but has been rewritten to be easier to read and use.

No, this is fine to keep in the source code, checkpatch is telling you
something else in the above "hint".

thanks,

greg k-h
