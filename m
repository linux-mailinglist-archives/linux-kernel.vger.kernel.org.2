Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD833B33B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhCONEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhCONDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:03:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E8B664E31;
        Mon, 15 Mar 2021 13:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615813427;
        bh=aOfTSIJxQGADpAtRCwCJxunGitSuzRFpohPWL/lcI+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyIjZLrssdFWwvc/rSZe5M5ojsv8YCSjs+Pp+Dd7GDIXkSjefhvIFwQ3/mgSPJbFH
         h1CZV/Om+5sYPKXgAOOzvQ6MwrHZQ+dYKvxXajqyJ/DGWn6kaK3RSJjDTr1Nq4b/PM
         2mGATrvONj5buFyYLwzrOIYyxRo70k6CHufxk9W8=
Date:   Mon, 15 Mar 2021 14:03:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Hongren Zheng (Zenithal)" <i@zenithal.me>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usbip: tools: add options and examples in man page
 related to device mode
Message-ID: <YE9bMVmra4c8Afzs@kroah.com>
References: <YE9Vyrs+Z8MusjDM@Sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9Vyrs+Z8MusjDM@Sun>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 08:40:42PM +0800, Hongren Zheng (Zenithal) wrote:
> The commit e0546fd8b748b19d8edd1550530da8ebad6e4b31 implemented device
> mode for user space tools, however the corresponding options are not
> documented in man page.
> 
> This commit documents the options and provides examples on device mode.
> ---
>  tools/usb/usbip/doc/usbip.8  | 25 +++++++++++++++++++++++++
>  tools/usb/usbip/doc/usbipd.8 | 22 ++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
> index a15d20063b98..385b0eda8746 100644
> --- a/tools/usb/usbip/doc/usbip.8
> +++ b/tools/usb/usbip/doc/usbip.8
> @@ -49,6 +49,13 @@ then exit.
>  Attach a remote USB device.
>  .PP
>  
> +.HP
> +\fBattach\fR \-\-remote=<\fIhost\fR> \-\-device=<\fdev_id\fR>
> +.IP
> +Attach a remote USB gadget.
> +Only used when the remote usbipd is in device mode.
> +.PP
> +
>  .HP
>  \fBdetach\fR \-\-port=<\fIport\fR>
>  .IP
> @@ -73,6 +80,14 @@ Stop exporting a device so it can be used by a local driver.
>  List USB devices exported by a remote host.
>  .PP
>  
> +.HP
> +\fBlist\fR \-\-device
> +.IP
> +List USB gadgets of local usbip-vudc.
> +Only used when the local usbipd is in device mode.
> +This can not list usbip-vudc USB gadgets of the remote device mode usbipd.
> +.PP
> +
>  .HP
>  \fBlist\fR \-\-local
>  .IP
> @@ -93,5 +108,15 @@ List local USB devices.
>      client:# usbip detach --port=0
>          - Detach the usb device.
>  
> +The following example shows the use of device mode
> +
> +    server:# usbip list --device
> +        - Note this is the server side
> +
> +    client:# modprobe vhci-hcd
> +
> +    client:# usbip attach --remote=server --device=usbip-vudc.0
> +        - Connect the remote USB gadget
> +
>  .SH "SEE ALSO"
>  \fBusbipd\fP\fB(8)\fB\fP
> diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
> index fb62a756893b..53c8d5792de6 100644
> --- a/tools/usb/usbip/doc/usbipd.8
> +++ b/tools/usb/usbip/doc/usbipd.8
> @@ -29,6 +29,12 @@ Bind to IPv4. Default is both.
>  Bind to IPv6. Default is both.
>  .PP
>  
> +.HP
> +\fB\-e\fR, \fB\-\-device\fR
> +.IP
> +Run in device mode. Rather than drive an attached device, create a virtual UDC to bind gadgets to.
> +.PP
> +
>  .HP
>  \fB\-D\fR, \fB\-\-daemon\fR
>  .IP
> @@ -86,6 +92,22 @@ USB/IP client can connect and use exported devices.
>          - A usb device 1-2 is now exportable to other hosts!
>          - Use 'usbip unbind --busid=1-2' when you want to shutdown exporting and use the device locally.
>  
> +The following example shows the use of device mode
> +
> +    server:# modprobe usbip-vudc
> +        - Use /sys/class/udc/ interface
> +        - usbip-host is independent of this module.
> +
> +    server:# usbipd -e -D
> +        - Start usbip daemon in device mode.
> +
> +    server:# modprobe g_mass_storage file=/tmp/tmp.img
> +        - Bind a gadget to usbip-vudc
> +        - in this example, a mass storage gadget is bound
> +
> +    server:# usbip list --device
> +        - Note this is the server side
> +
>  .SH "SEE ALSO"
>  \fBusbip\fP\fB(8)\fB\fP
>  
> -- 
> 2.30.1


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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
