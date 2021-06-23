Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C683B1478
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhFWHSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhFWHSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:18:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 310CD60FD8;
        Wed, 23 Jun 2021 07:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624432583;
        bh=gUYucQ8HqQ2jObNB1QQJmkZpO17aNXY0zhfqtWAGLis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZYWZsX+gSkaay0/bPyGEhWn9N2f89q6Dt6acyO2DKx3OHXEipV3rh5kBnwumed0X
         56d3eK1ZORCMmsqp7yD6mQafEamLu4vn46EDM4xV6+7PqxFlqi7SzJi7h6EDEWiL3U
         YvWto2U8UsquF718sZDwfwtjWwTk8xBIqzRAeZD/tavCg3gejCICQagW3LVNmV3tTA
         Out2aJQqKZ7jHeLxVRY0fymnIT7cdMntT2vLqPsUiLNOKZXPnafJMgMb3STB8CDM+B
         623Wpd9tlhw0kKEYCBU4D5P4gPj6YUnzMojwNRzx7d/nLZ6eYHgS3TMyBL7Hdwx2X0
         6o2RefQdSdzvQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lvx7U-0004eB-JY; Wed, 23 Jun 2021 09:16:21 +0200
Date:   Wed, 23 Jun 2021 09:16:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
Subject: Re: [PATCH] tty: serial: owl: Fix data race in owl_uart_remove
Message-ID: <YNLfxMZZ0a80qKLg@hovoldconsulting.com>
References: <20210617110443.6526-1-saubhik.mukherjee@gmail.com>
 <YMswdqNpjb9n1pdW@kroah.com>
 <ceebf511-9971-6deb-a6dd-458d69de2bbd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceebf511-9971-6deb-a6dd-458d69de2bbd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:06:53AM +0530, Saubhik Mukherjee wrote:
> On 6/17/21 4:52 PM, Greg KH wrote:
> > On Thu, Jun 17, 2021 at 04:34:43PM +0530, Saubhik Mukherjee wrote:
> >> Suppose the driver is registered and a UART port is added. Once an
> >> application opens the port, owl_uart_startup is called which registers
> >> the interrupt handler owl_uart_irq.
> >>
> >> We could have the following race condition:
> >>
> >> When device is removed, owl_uart_remove is called, which calls
> >> uart_remove_one_port, which calls owl_uart_release_port, which writes
> >> NULL to port->membase. At this point parallely, an interrupt could be
> >> handled by owl_uart_irq which reads port->membase.
> >>
> >> This is because it is possible to remove device without closing a port.
> >> Thus, we need to check it and call owl_uart_shutdown in owl_uart_remove.

No, this makes no sense at all. The port is deregistered and hung up by
uart_remove_one_port() (and the interrupt line is consequently disabled
by the driver) before it is released so this can never happen.

> >> Found by Linux Driver Verification project (linuxtesting.org).

And you clearly did not test this, which you should mention.

Johan
