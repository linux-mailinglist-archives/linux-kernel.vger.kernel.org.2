Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFAE3154FF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhBIRZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232925AbhBIRYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:24:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF72264EA6;
        Tue,  9 Feb 2021 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612891422;
        bh=LjXPuFKczCfjBI/X7fEAoeb2xqworCPIBUql3tWStkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NXdM4wwPmE4n+1lNsvpX9JpfzUjbm32HJtpdb6pommxMUSVdXRF3zGO2bmt7Jf3nH
         V0FRcK6zPgxdZ5VhxlcO7QBIMZa5SCO/y7kgtL2RL796FElha6xAfzi8PSE/F9BhFn
         1X6T4zOiwO7N4g2+XLul2b2Jw87Lf9m9l8OziwkI=
Date:   Tue, 9 Feb 2021 18:23:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthek <mail@karthek.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCLFG03glpl76Haq@kroah.com>
References: <YB/6ZmZwCF3jeEue@kroah.com>
 <YB/9hS2S1oaCmuDq@karthik-strix-linux.karthek.com>
 <YB//EZl0aeLk/y+E@kroah.com>
 <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
 <YCAEL9Eed6ijeeR+@kroah.com>
 <YCAFEvCySI8u2059@karthik-strix-linux.karthek.com>
 <YCAFeSw//h8JYpFk@kroah.com>
 <YCAGQYng2hhg6xJk@karthik-strix-linux.karthek.com>
 <YCAGsKf6fEqYEv9p@kroah.com>
 <YCK2YgaM5u++djnl@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCK2YgaM5u++djnl@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:50:50PM +0530, karthek wrote:
> On Sun, Feb 07, 2021 at 04:26:40PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Feb 07, 2021 at 08:54:49PM +0530, karthek wrote:
> > > On Sun, Feb 07, 2021 at 04:21:29PM +0100, Greg Kroah-Hartman wrote:
> > > > On Sun, Feb 07, 2021 at 08:49:46PM +0530, karthek wrote:
> > > > > On Sun, Feb 07, 2021 at 04:15:59PM +0100, Greg Kroah-Hartman wrote:
> > > > > > On Sun, Feb 07, 2021 at 08:41:59PM +0530, karthek wrote:
> > > > > > > On Sun, Feb 07, 2021 at 03:54:09PM +0100, Greg Kroah-Hartman wrote:
> > > > > > > > On Sun, Feb 07, 2021 at 08:17:33PM +0530, karthek wrote:
> > > > > > > > 
> > > > > > > > <snip>
> > > > > > > > 
> > > > > > > > For some reason you sent this only to me, which is a bit rude to
> > > > > > > > everyone else on the mailing list.  I'll be glad to respond if you
> > > > > > > > resend it to everyone.
> > > > > > > > 
> > > > > > > > thanks,
> > > > > > > > 
> > > > > > > i> greg k-h
> > > > > > > 
> > > > > > > ok anyway
> > > > > > > 
> > > > > > > Those both lines(from, signed-off-by) are exactly same, what's problem
> > > > > > > with them?
> > > > > > 
> > > > > > I don't see the context here...
> > > > > are you real greg or bot?
> > > > 
> > > > All too real :)
> > > > 
> > > > > > Anyway, if you do sign documents with just "karthek" (lowercase and
> > > > > > all), that's fine, but I do have to ask, right?
> > > > > I do sign just karthek everywhere(bank,gov docs,etc), thats my legal
> > > > > signature
> > > > 
> > > > Ok, that's good to know, however I have an application here from you
> > > > with a different name on it.  Odd...
> > > Ofcourse thats my legal name(Karthik Alapati) and this is my legal
> > > signature(karthek)
> > > FYI this is the first time i used my legal name on internet application
> > 
> > Great, please use your legal name on a signed-off-by: line, as it is a
> > legal statement.
> > 
> > thanks,
> > 
> > greg k-h
> 
> pinging?
> 
> iam aware of how many patches you get everyday.im not expecting your
> immediate attention but just pinging...

Ping on what?  I was waiting for a new patch to be sent that met the
above requirements.  My pending queue for staging patches is empty at
the moment.

thanks,

greg k-h
