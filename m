Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB07035AB3C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 07:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbhDJF5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 01:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhDJF5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 01:57:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 729EB61182;
        Sat, 10 Apr 2021 05:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618034238;
        bh=dcPFxMPX4tfyyZmiflVgnpEGjviTQ9XhYMbVmHnLDeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Js6X6uMJtdNw+tXyjGsbXy6ZgWxU87cRKvsTvKNYSQh6dqm1NB1Tp5talqzzDm8hX
         vdPWfHM2jQIDntSbI0yQsbOFaJWwlfBI9OuYTZ+10jXj2jaGa0q+r1BVKTQ+N+x8sK
         tZjF9cHELKO4jkZ16toJfsXh1wD3HVO1RgDNycUQ=
Date:   Sat, 10 Apr 2021 07:57:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hminas@synopsys.com
Subject: Re: [PATCH v2] usb: dwc2: Enable RPi in ACPI mode
Message-ID: <YHE+OyonLsCCMh7A@kroah.com>
References: <20210409203809.21940-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409203809.21940-1-jeremy.linton@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 03:38:09PM -0500, Jeremy Linton wrote:
> The dwc2 driver has everything we need to run
> in ACPI mode except for the ACPI module device table
> boilerplate. With that added and identified as "BCM2848",
> an id in use by other OSs for this device, the dw2
> controller on the BCM2711 will work.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/usb/dwc2/core.h     |  2 ++
>  drivers/usb/dwc2/params.c   | 18 +++++++++++++++++-
>  drivers/usb/dwc2/platform.c |  1 +
>  3 files changed, 20 insertions(+), 1 deletion(-)


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
