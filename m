Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D7D312544
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhBGP06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:26:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhBGPWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:22:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF0C064E2B;
        Sun,  7 Feb 2021 15:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612711292;
        bh=ZhjyIQwX+IMa9nFaRoFfzPyKC/sUAtrFekYpLYwow10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kRW3Tdqwqs61NOuyT7/gkd6Gf3akIn4GNrUfqpQLdF0hw686nWJ7jHY95ouB6z8OQ
         WAU9l5sDuaPmLj2fguqdpMKA8e3anSXJKg88zIQBylmopf13TXppgsgfaVfSGAwqJ2
         OkTZRe+6m/OTOMSKMr+M/yL6okXrfxuzMN/OxZvY=
Date:   Sun, 7 Feb 2021 16:21:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthek <mail@karthek.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCAFeSw//h8JYpFk@kroah.com>
References: <YB/2Uvj99+sReckM@karthik-strix-linux.karthek.com>
 <YB/6ZmZwCF3jeEue@kroah.com>
 <YB/9hS2S1oaCmuDq@karthik-strix-linux.karthek.com>
 <YB//EZl0aeLk/y+E@kroah.com>
 <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
 <YCAEL9Eed6ijeeR+@kroah.com>
 <YCAFEvCySI8u2059@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCAFEvCySI8u2059@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 08:49:46PM +0530, karthek wrote:
> On Sun, Feb 07, 2021 at 04:15:59PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Feb 07, 2021 at 08:41:59PM +0530, karthek wrote:
> > > On Sun, Feb 07, 2021 at 03:54:09PM +0100, Greg Kroah-Hartman wrote:
> > > > On Sun, Feb 07, 2021 at 08:17:33PM +0530, karthek wrote:
> > > > 
> > > > <snip>
> > > > 
> > > > For some reason you sent this only to me, which is a bit rude to
> > > > everyone else on the mailing list.  I'll be glad to respond if you
> > > > resend it to everyone.
> > > > 
> > > > thanks,
> > > > 
> > > i> greg k-h
> > > 
> > > ok anyway
> > > 
> > > Those both lines(from, signed-off-by) are exactly same, what's problem
> > > with them?
> > 
> > I don't see the context here...
> are you real greg or bot?

All too real :)

> > Anyway, if you do sign documents with just "karthek" (lowercase and
> > all), that's fine, but I do have to ask, right?
> I do sign just karthek everywhere(bank,gov docs,etc), thats my legal
> signature

Ok, that's good to know, however I have an application here from you
with a different name on it.  Odd...

greg k-h
