Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A3A3D6E09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 07:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhG0F10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 01:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234887AbhG0F1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:27:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8747610D0;
        Tue, 27 Jul 2021 05:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627363646;
        bh=dq6ahuYU1FBLrdnNuaHmwV8noXCRW5UxuGkJIYAWyG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnJvORGfIslrZN3wgk8zR7Fic0twmFr2i506B79b2cvRidOieWUJ0Tb2xV6NMb99h
         dPZab4pwHSWTYrX2lEDx0L3emhuLRK+vq1rCy0FU3llnosgxHnQvL8T7QFZ7Ddhh3u
         NKX3QHDxG7LPYQsYQd4V8aRxXCbf0z09FGGIIa9g=
Date:   Tue, 27 Jul 2021 07:27:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Bill Wendling <morbo@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
Message-ID: <YP+ZOx8BETgufxBS@kroah.com>
References: <20210714091747.2814370-1-morbo@google.com>
 <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com>
 <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 01:47:33PM -0700, Nathan Chancellor wrote:
> + Greg and Rafael as the maintainer and reviewer of drivers/base/module.c
> respectively, drop everyone else.

Odd no one cc:ed us originally, I guess they didn't want the patch ever
merged?  :(

> 
> Original post:
> 
> https://lore.kernel.org/r/20210726201924.3202278-2-morbo@google.com/
> 
> On 7/26/2021 1:19 PM, 'Bill Wendling' via Clang Built Linux wrote:
> > Fix the following build warning:
> > 
> >    drivers/base/module.c:36:6: error: variable 'no_warn' set but not used [-Werror,-Wunused-but-set-variable]
> >          int no_warn;

That's not going to be a good warning to ever have the kernel use due to
how lots of hardware works (i.e. we need to do a read after a write but
we can throw the read away as it does not matter).


> > 
> > This variable is used to remove another warning, but causes a warning
> > itself. Mark it as 'unused' to avoid that.
> > 
> > Signed-off-by: Bill Wendling <morbo@google.com>
> 
> Even though they evaluate to the same thing, it might be worth using
> "__always_unused" here because it is :)

But it is not unused, the value is written into it.

So this isn't ok, sometimes we want to write to variables but never care
about the value, that does not mean the compiler should complain about
it.

thanks,

greg k-h
