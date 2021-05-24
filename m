Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6038E153
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhEXHGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232120AbhEXHGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:06:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FA5C6109E;
        Mon, 24 May 2021 07:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621839915;
        bh=UDB0UygxxaTpgbxA/iNTLBzMQeJMYIzI8xw2uTBWy/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FK5shoVBgizVz8DWImSUP9aicKBEOBAwmuWj3Mmpx8WEBpdE9NEqCrC9aA+kmG4IB
         fd070JKKaEwa0c81CDXC2bOsPVH9U3N+pMSh0x8R4p261QaNyKriQoBjoVrUcJQMek
         VZDBS5lHqcUoqKTbDBWjojcvtzVFbe24ajAwsXJ0=
Date:   Mon, 24 May 2021 09:05:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nizamhaider786@gmail.com
Cc:     lkundrak@v3.sk, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] char: pcmcia: scr24x_cs: Fix redundant fops Removed
 redundant fops assignment, which was already done in cdev_init()
Message-ID: <YKtQKSflPz3Gc1JN@kroah.com>
References: <20210523151111.2968-1-nizamhaider786@gmail.com>
 <20210523151111.2968-2-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523151111.2968-2-nizamhaider786@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 08:41:11PM +0530, nizamhaider786@gmail.com wrote:
> From: Nijam Haider <nizamhaider786@gmail.com>
> 
> Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
> ---
>  drivers/char/pcmcia/scr24x_cs.c | 1 -
>  1 file changed, 1 deletion(-)

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
