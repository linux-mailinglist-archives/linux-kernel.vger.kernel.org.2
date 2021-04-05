Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF835414F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhDEKxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhDEKxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:53:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E378611EE;
        Mon,  5 Apr 2021 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617620004;
        bh=P4InjT3ttiDD9nOPApan7PBGcPT/E/+OPbV/dF6/Nv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baUynYFpJi0K96OG9K4AgWrBkBmi0FrEYXD3X2lJR9Pc06t2iuAJD/DcG1EumJMAh
         ZITw17rRpZxP3jl5QeWW3gtMH1b+M+T+IrHibqnCKUoj8ojRj2/jLx4GAsLX3zxbLD
         gijPMGtkBT6f+yPXCP5ZfJKbmVaJ9DzEueIZhxHE=
Date:   Mon, 5 Apr 2021 12:53:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     zbr@ioremap.net, corbet@lwn.net, rikard.falkeborn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] w1: ds2438: fixed a coding style issue to
 preferred octal style
Message-ID: <YGrsIg9efV/8asDE@kroah.com>
References: <20210403044821.390485-1-sampaio.ime@gmail.com>
 <20210405105009.420924-1-sampaio.ime@gmail.com>
 <20210405105009.420924-7-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405105009.420924-7-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 07:50:06AM -0300, Luiz Sampaio wrote:
> Changed the permissions to preferred octal style.
> 
> Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
> ---
>  drivers/w1/slaves/w1_ds2438.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
> index 56e53a748059..ccb06b8c2d78 100644
> --- a/drivers/w1/slaves/w1_ds2438.c
> +++ b/drivers/w1/slaves/w1_ds2438.c
> @@ -388,7 +388,7 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
>  	return ret;
>  }
>  
> -static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
> +static BIN_ATTR(iad, 0664, iad_read, iad_write, 0);

Why not BIN_ATTR_RW() instead?

thanks,

greg k-h
