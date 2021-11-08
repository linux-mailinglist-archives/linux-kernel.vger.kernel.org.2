Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97C447AB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhKHHLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:11:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236168AbhKHHLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:11:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 411266112F;
        Mon,  8 Nov 2021 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636355301;
        bh=WG+MUmo7ZfgpICCSz7TrSwgD5tzJlfGEj9mAbIhpCDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bA6UMB6knomM1ld5X5hZ+j+qoN6OKCrPJPhpsm2+hSxbJBueE7fiNviScsDLiXDI7
         zP50uj5iQtRkEEofhAN6zcVd9j8Wz1lTwNGqFVA0OrHela6xEtcIDRUngqqUcfs5kc
         yrePBDYXgcUevFpXptfs9SNi0Jk4iibxeFnkSQSU=
Date:   Mon, 8 Nov 2021 08:08:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Bruce Mitchell <Bruce.Mitchell@ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v4] usb: ehci: handshake CMD_RUN instead of STS_HALT
Message-ID: <YYjM40q6p3zT7CIH@kroah.com>
References: <20210910073619.26095-1-neal_liu@aspeedtech.com>
 <CACPK8Xf40cfnFFeeAzkdXk6ikbfBhWOOt6U8Oq3iCaxe5v5=_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xf40cfnFFeeAzkdXk6ikbfBhWOOt6U8Oq3iCaxe5v5=_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 01:27:02AM +0000, Joel Stanley wrote:
> Hi Greg,
> 
> On Fri, 10 Sept 2021 at 07:38, Neal Liu <neal_liu@aspeedtech.com> wrote:
> >
> > For Aspeed, HCHalted status depends on not only Run/Stop but also
> > ASS/PSS status.
> > Handshake CMD_RUN on startup instead.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
> > Tested-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Has this one gone in? If not, here's some tags:
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> It also needs to go to stable:
> 
> Cc: stable@vger.kernel.org
> Fixes: 280a9045bb18 ("ehci: fix EHCI host controller initialization sequence")

This patch failed to apply to 4.4.y, 4.9.y, and 4.14.y, so could you
provide a working backport for those kernels for me to be able to queue
it up to the stable queues there?

thanks,

greg k-h
