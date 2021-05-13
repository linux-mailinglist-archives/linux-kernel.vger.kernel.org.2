Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432D137F590
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhEMK1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 06:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhEMK05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 06:26:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA2A661104;
        Thu, 13 May 2021 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620901547;
        bh=tGSbnJbV9mpjOtoS4fZRDhnpTdRQz/IXHDW4kTYpYAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1I/jANeD3wLrWb04k8nKmsR8WskdmDEfQnDlB/qG+eYesSbsCu01am3HAH+SUqveR
         7+y3F7VupADfNGsh3gkbc+FnaFq7W5XgtRmTEB2t2fychkG4zIpPchE/u1K4NCOF8I
         5m1vFoYGXFebcrvbSvQbM6suE/okEvakNcJNX74Q=
Date:   Thu, 13 May 2021 12:25:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 8/8] xen/hvc: replace BUG_ON() with negative return value
Message-ID: <YJz+qK8snI64/TKh@kroah.com>
References: <20210513100302.22027-1-jgross@suse.com>
 <20210513100302.22027-9-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513100302.22027-9-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:03:02PM +0200, Juergen Gross wrote:
> Xen frontends shouldn't BUG() in case of illegal data received from
> their backends. So replace the BUG_ON()s when reading illegal data from
> the ring page with negative return values.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/tty/hvc/hvc_xen.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
> index 92c9a476defc..30d7ffb1e04c 100644
> --- a/drivers/tty/hvc/hvc_xen.c
> +++ b/drivers/tty/hvc/hvc_xen.c
> @@ -86,6 +86,11 @@ static int __write_console(struct xencons_info *xencons,
>  	cons = intf->out_cons;
>  	prod = intf->out_prod;
>  	mb();			/* update queue values before going on */
> +
> +	if (WARN_ONCE((prod - cons) > sizeof(intf->out),
> +		      "Illegal ring page indices"))
> +		return -EINVAL;

How nice, you just rebooted on panic-on-warn systems :(

> +
>  	BUG_ON((prod - cons) > sizeof(intf->out));

Why keep this line?

Please just fix this up properly, if userspace can trigger this, then
both the WARN_ON() and BUG_ON() are not correct and need to be correctly
handled.


>  
>  	while ((sent < len) && ((prod - cons) < sizeof(intf->out)))
> @@ -114,7 +119,10 @@ static int domU_write_console(uint32_t vtermno, const char *data, int len)
>  	 */
>  	while (len) {
>  		int sent = __write_console(cons, data, len);
> -		
> +
> +		if (sent < 0)
> +			return sent;
> +
>  		data += sent;
>  		len -= sent;
>  
> @@ -138,7 +146,10 @@ static int domU_read_console(uint32_t vtermno, char *buf, int len)
>  	cons = intf->in_cons;
>  	prod = intf->in_prod;
>  	mb();			/* get pointers before reading ring */
> -	BUG_ON((prod - cons) > sizeof(intf->in));
> +
> +	if (WARN_ONCE((prod - cons) > sizeof(intf->in),
> +		      "Illegal ring page indices"))
> +		return -EINVAL;

Same here, you still just paniced a machine :(

thanks,

greg k-h
