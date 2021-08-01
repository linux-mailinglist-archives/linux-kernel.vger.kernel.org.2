Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37C53DCA4C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 08:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhHAGZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 02:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhHAGZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 02:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB87A61057;
        Sun,  1 Aug 2021 06:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627799126;
        bh=Uur95jcj5xjC1fQ1fgKkATD2aJ8tRMWLGjQ2YoCRlpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9uZmwshEStcEHfd+SmaPCqMk6Pn6PcV8Bg9dxKs5AxUhqg/ctUb3BMxqByxxv+dQ
         trZhsGF1pETq9PYNDZQuRh+ILOf5iYfqPc4vV51EGgTeRPW9+1MHZQTUH3PPZc/AXs
         1lNioAnKwjp44GmD6eBLmBD/6EmINIA8Y2wgBBYc=
Date:   Sun, 1 Aug 2021 08:25:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] firewire: ohci: make reg_(read|write) unsigned
Message-ID: <YQY+U9i8Zw7OAKOO@kroah.com>
References: <20210731104112.512449-1-jordy@pwning.systems>
 <YQY+BL4nR9Loddum@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQY+BL4nR9Loddum@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 08:24:04AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Jul 31, 2021 at 12:41:12PM +0200, Jordy Zomer wrote:
> > The reg_(read|write) functions used to
> > take a signed integer as an offset parameter.
> > The callers of this function only pass an unsigned integer to it.
> > Therefore to make it obviously safe, let's just make this an unsgined
> > integer as this is used in pointer arithmetics.
> > 
> > Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> > ---
> >  drivers/firewire/ohci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Same thing should probably also be done in
> drivers/firewire/init_ohci1394_dma.c for the same inline functions,
> right?

And sound/firewire/isight.c also could use this.  Seems like there was
some copy/paste in firewire drivers :)

thanks,

greg k-h
