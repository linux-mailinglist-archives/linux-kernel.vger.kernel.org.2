Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B183345ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCWJYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhCWJYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:24:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9176C61984;
        Tue, 23 Mar 2021 09:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616491451;
        bh=DPywEhpZNo0wJHcWiKZrIfCpAVQnGNuCBlmXyMkMAbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pk3u/yo5T+Jhe0wSJKsz1HCe7s9TyipXtva0RG46qwXFV/z4lDtnf6M3yZh1xDZOH
         7vm8LdsQkh9iu4aEbHrstJHXJQT2M0shByGXGoU8YM+tREo9HbOHc8nE0L9HnuMvn9
         tFBt7pSgczjTDdYErf/DiDOXgkSMtoCWOycM5rY4=
Date:   Tue, 23 Mar 2021 10:24:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Message-ID: <YFmzuEfpN7zzKel3@kroah.com>
References: <1613702532-5096-1-git-send-email-alex.nemirovsky@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613702532-5096-1-git-send-email-alex.nemirovsky@cortina-access.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 06:42:09PM -0800, Alex Nemirovsky wrote:
> +static struct cortina_uart_port *cortina_uart_ports;

Why is this not a per-device pointer?

> +static void __exit cortina_uart_exit(void)
> +{
> +	platform_driver_unregister(&serial_cortina_driver);
> +	uart_unregister_driver(&cortina_uart_driver);
> +	kfree(cortina_uart_ports);

Should not need to free this here, it should be tied to the device, not
the driver.


> +}
> +
> +module_init(cortina_uart_init);
> +module_exit(cortina_uart_exit);
> +
> +MODULE_AUTHOR("Cortina-Access Inc.");
> +MODULE_DESCRIPTION(" Cortina-Access UART driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 62c2204..1931892 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -277,4 +277,7 @@
>  /* Freescale LINFlexD UART */
>  #define PORT_LINFLEXUART	122
>  
> +/* Cortina-Access UART */
> +#define PORT_CORTINA_ACCESS	123

Also, no need for this, right?  I would prefer to not add new ids if at
all possible.

thanks,

greg k-h
