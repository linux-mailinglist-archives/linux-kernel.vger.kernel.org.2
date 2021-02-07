Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9608312519
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 16:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBGPRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 10:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhBGPQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 10:16:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B886764DE3;
        Sun,  7 Feb 2021 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612710962;
        bh=SvW7SvqKrXRlUqN6DpuNxTzmpsI7E9wVbtz7Ru2Z9nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLR10qcGlhFbQP+rqQ+31TAPMeGKQyvAUaSKpmNnb5sLEpe2YYO/UtiXGFaMyUYLX
         y1G6aG0IMRxg0LHw/x5+/Nv5DX/UTFCjzf8AlACj/6vxa5ydS144Z6laGeZnhaij06
         aUhjnLzBZCFiVgxLjunKkVFnJxB4HWwcvVYqix1I=
Date:   Sun, 7 Feb 2021 16:15:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     karthek <mail@karthek.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCAEL9Eed6ijeeR+@kroah.com>
References: <YB/2Uvj99+sReckM@karthik-strix-linux.karthek.com>
 <YB/6ZmZwCF3jeEue@kroah.com>
 <YB/9hS2S1oaCmuDq@karthik-strix-linux.karthek.com>
 <YB//EZl0aeLk/y+E@kroah.com>
 <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCADP8ijAYvrsU7F@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 08:41:59PM +0530, karthek wrote:
> On Sun, Feb 07, 2021 at 03:54:09PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Feb 07, 2021 at 08:17:33PM +0530, karthek wrote:
> > 
> > <snip>
> > 
> > For some reason you sent this only to me, which is a bit rude to
> > everyone else on the mailing list.  I'll be glad to respond if you
> > resend it to everyone.
> > 
> > thanks,
> > 
> i> greg k-h
> 
> ok anyway
> 
> Those both lines(from, signed-off-by) are exactly same, what's problem
> with them?

I don't see the context here...

Anyway, if you do sign documents with just "karthek" (lowercase and
all), that's fine, but I do have to ask, right?

thanks,

greg k-h
