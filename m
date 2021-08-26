Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB1B3F867B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbhHZL2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241944AbhHZL2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:28:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C26610A6;
        Thu, 26 Aug 2021 11:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629977280;
        bh=NzfEzBZoIifRLjIxopMdWAJ/cAh1A0Wp6hdf3z53P0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RhvASHOwlnO2gywOZwLB/TT9cKMJoNP/6QYhNm8PsO6gXJWtOHV3whOM/6X3W9wDh
         9lOmthEyR8w7bJMhOsAsB/TxycS9Iev6R/KTmTUt0eszmK7mJ2yUNZ1Z1HwKsYoXBK
         pVzLJzVOncTtDgQhaIZzBCZAfBoGybe+zCmrFbFA=
Date:   Thu, 26 Aug 2021 13:27:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     neal_liu <neal_liu@aspeedtech.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW@aspeedtech.com
Subject: Re: [PATCH] usb: host: ehci: skip STS_HALT check for aspeed platform
Message-ID: <YSd6uSfjlqmaN+us@kroah.com>
References: <20210826071525.27651-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826071525.27651-1-neal_liu@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 03:15:25PM +0800, neal_liu wrote:
> STS_HALT also depends on ASS/PSS status for apseed.
> Skip this check on startup.
> 
> Signed-off-by: neal_liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/host/ehci-hcd.c      | 10 +++++++++-
>  drivers/usb/host/ehci-platform.c |  6 ++++++
>  drivers/usb/host/ehci.h          |  1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
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

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
