Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F2312556
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBGP3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhBGP1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:27:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11FDA64E3B;
        Sun,  7 Feb 2021 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612711603;
        bh=2BJH4zXw2LnY0j+NbpIjEN6FbOeqdmXD4EuZife4vzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvQI6bpt2AvuiVY56id0N1varcTk/z6AK0AYPkAKRjo/chgHKDmoFg6SeSC2g310a
         SxfC7ZLE15KqB9+33oE9nYbvaLqQyIr3yzb1W/2nzZKjjxEoq3/MI8uNpdqcpN8gSj
         bMq7HDEF8/TY0MerCDyl9Y2tsp9tiLZqm2isPEc8=
Date:   Sun, 7 Feb 2021 16:26:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthek <mail@karthek.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCAGsKf6fEqYEv9p@kroah.com>
References: <YB/2Uvj99+sReckM@karthik-strix-linux.karthek.com>
 <YB/6ZmZwCF3jeEue@kroah.com>
 <YB/9hS2S1oaCmuDq@karthik-strix-linux.karthek.com>
 <YB//EZl0aeLk/y+E@kroah.com>
 <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
 <YCAEL9Eed6ijeeR+@kroah.com>
 <YCAFEvCySI8u2059@karthik-strix-linux.karthek.com>
 <YCAFeSw//h8JYpFk@kroah.com>
 <YCAGQYng2hhg6xJk@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCAGQYng2hhg6xJk@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 08:54:49PM +0530, karthek wrote:
> On Sun, Feb 07, 2021 at 04:21:29PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Feb 07, 2021 at 08:49:46PM +0530, karthek wrote:
> > > On Sun, Feb 07, 2021 at 04:15:59PM +0100, Greg Kroah-Hartman wrote:
> > > > On Sun, Feb 07, 2021 at 08:41:59PM +0530, karthek wrote:
> > > > > On Sun, Feb 07, 2021 at 03:54:09PM +0100, Greg Kroah-Hartman wrote:
> > > > > > On Sun, Feb 07, 2021 at 08:17:33PM +0530, karthek wrote:
> > > > > > 
> > > > > > <snip>
> > > > > > 
> > > > > > For some reason you sent this only to me, which is a bit rude to
> > > > > > everyone else on the mailing list.  I'll be glad to respond if you
> > > > > > resend it to everyone.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > i> greg k-h
> > > > > 
> > > > > ok anyway
> > > > > 
> > > > > Those both lines(from, signed-off-by) are exactly same, what's problem
> > > > > with them?
> > > > 
> > > > I don't see the context here...
> > > are you real greg or bot?
> > 
> > All too real :)
> > 
> > > > Anyway, if you do sign documents with just "karthek" (lowercase and
> > > > all), that's fine, but I do have to ask, right?
> > > I do sign just karthek everywhere(bank,gov docs,etc), thats my legal
> > > signature
> > 
> > Ok, that's good to know, however I have an application here from you
> > with a different name on it.  Odd...
> Ofcourse thats my legal name(Karthik Alapati) and this is my legal
> signature(karthek)
> FYI this is the first time i used my legal name on internet application

Great, please use your legal name on a signed-off-by: line, as it is a
legal statement.

thanks,

greg k-h
