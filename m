Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EAA309C96
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhAaOK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:10:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231579AbhAaMsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 07:48:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CCE564E09;
        Sun, 31 Jan 2021 12:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612097244;
        bh=9kbVzVw62kZgIKKE9B1IS70GsTH18purMEstGi/VG68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EbR5owstkp/sTS6s3kPfORsR/Nvku7bfOdwHThUYwVy80Al0j8BOTFt4dD721IP8j
         ol2zb++Io6xxms7O9CY0MSkWboSTkUF+/idOtbqPAElZ6uGR7swA1t68Wt92iaNPZt
         uQclxVbNcg/ej4RJAo0fM5ucl3kXUEiYvZo4FvGA=
Date:   Sun, 31 Jan 2021 13:47:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: add option to disable registration of
 legacy ISA ports
Message-ID: <YBam2m2VMowH5Yth@kroah.com>
References: <20210128172244.22859-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128172244.22859-1-mans@mansr.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:22:44PM +0000, Mans Rullgard wrote:
> On systems that do not have the traditional PC ISA serial ports, the
> 8250 driver still creates non-functional device nodes.  This change
> makes only ports that actually exist (PCI, DT, ...) get device nodes.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 26 ++++++++++++++++++++------
>  drivers/tty/serial/8250/Kconfig     |  5 +++++
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index cae61d1ebec5..49695dd3677c 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -555,6 +555,7 @@ static void __init serial8250_isa_init_ports(void)
>  	}
>  }
>  
> +#ifdef CONFIG_SERIAL_8250_ISA

This is just making a mess of the code.  To do this right, pull the isa
code out into a separate file and put the #ifdef in a .h file, so we can
properly maintain and support this code over time.  This change as-is is
not going to make that any easier :(

> +config SERIAL_8250_ISA
> +	bool "8250/16550 ISA device support" if EXPERT

So, no one will set this?

What userspace visable change will be caused by this?  Will ports get
renumbered?  What harm is this causing systems today without this
change?

thanks,

greg k-h
