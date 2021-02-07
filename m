Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3853122E3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBGIwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:52:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhBGIwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:52:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B565A60201;
        Sun,  7 Feb 2021 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612687887;
        bh=Te2f4LJDttBiHNlXfp8cuIwD/nJSEOIrmPUWFUIQbyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCURj3U16A6PD+/cRP8aZMJ+sEswhPCw5gsEPMo5MAr8oHySYQsZvbzjrUffZuZxU
         enax1niJnUNrun5cR1WFMP74I5H4MP0/w2uvoQ4KXBiNa/umz6PDWQ48TbVdQbZsfA
         UDEZG+bSqKZpbHs2vhqRFrnrMzvIuRn6BFvyJ1Lk=
Date:   Sun, 7 Feb 2021 09:51:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] staging: emxx_udc: Make incorrectly defined global
 static
Message-ID: <YB+qDND2OmY8WwA0@kroah.com>
References: <YB+l1t/k4VuSw3B9@kroah.com>
 <20210207084658.269898-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207084658.269898-1-memxor@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 02:16:58PM +0530, Kumar Kartikeya Dwivedi wrote:
> The global gpio_desc pointer and int vbus_irq were defined in the header,
> instead put the definitions in the translation unit and make them static as
> there's only a single consumer, and these symbols shouldn't pollute the
> global namespace.
> 
> This fixes the following sparse warnings for this driver:
> drivers/staging/emxx_udc/emxx_udc.c: note: in included file:
> drivers/staging/emxx_udc/emxx_udc.h:23:18: warning: symbol 'vbus_gpio' was not
> declared. Should it be static?  drivers/staging/emxx_udc/emxx_udc.h:24:5:
> warning: symbol 'vbus_irq' was not declared. Should it be static?
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 3 +++
>  drivers/staging/emxx_udc/emxx_udc.h | 2 --
>  2 files changed, 3 insertions(+), 2 deletions(-)

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
