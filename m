Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373E6445CD1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 00:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhKEAC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 20:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232410AbhKEAC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 20:02:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A56F604D2;
        Thu,  4 Nov 2021 23:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636070387;
        bh=ed29zpkeOjsycDqE+cquSEnEmDgcI51DG+xfYCKXcz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E56O7dJ97Huw9uzbwz9GmCdTVSA/2qNNXJnG/u6mGPYRiohU8IMbXLFVtwhh0g87o
         UDcW+OCPZ40zr+YJUTKHL1AJVhKOXLciO9DgFpDM8OYub84f5XAHQeN16VFPimXQB0
         +D0vMja12Rj/s59GKc5Zmxw7wgaiKrFjaHguWC9F5SqoMKLQUcKb1US4rmMiuYOfaA
         if1XE2rRox8P2kvY6dSnoxq0zVt8O+KvgwOL414uLIwGCm4Bv5tP3XthcKi/TaA3z+
         3+u/aLKe/OdnvJ2y3bHGq7sXyXxBGAcrKTxLXRcb8PQ5rMxpCnUpFLS6lsxtuLcZsF
         kwPsIXJnypQPA==
Date:   Thu, 4 Nov 2021 16:59:42 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] usb: dwc2: hcd_queue: Fix use of floating point literal
Message-ID: <YYRz7oyZQSaeWFCz@archlinux-ax161>
References: <20211104215923.719785-1-nathan@kernel.org>
 <CAKwvOdnBv8LcxvVYJKacL7eUXAoGVfnQp7TAL_r+P8V0WcOq1Q@mail.gmail.com>
 <CAKwvOdkp99t4ZvVgMLCzKjRq+AwM2-t+JRJeh8vs3vGq=kMoQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkp99t4ZvVgMLCzKjRq+AwM2-t+JRJeh8vs3vGq=kMoQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 04:33:41PM -0700, Nick Desaulniers wrote:
> On Thu, Nov 4, 2021 at 4:29 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Thu, Nov 4, 2021 at 2:59 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > A new commit in LLVM causes an error on the use of 'long double' when
> > > '-mno-x87' is used, which the kernel does through an alias,
> > > '-mno-80387' (see the LLVM commit below for more details around why it
> > > does this).
> > >
> > >  drivers/usb/dwc2/hcd_queue.c:1744:25: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux-gnu' does not support it
> > >                          delay = ktime_set(0, DWC2_RETRY_WAIT_DELAY);
> > >                                              ^
> > >  drivers/usb/dwc2/hcd_queue.c:62:34: note: expanded from macro 'DWC2_RETRY_WAIT_DELAY'
> > >  #define DWC2_RETRY_WAIT_DELAY (1 * 1E6L)
> > >                                  ^
> > >  1 error generated.
> > >
> > > This happens due to the use of a 'long double' literal. The 'E6' part of
> > > '1E6L' causes the literal to be a 'double' then the 'L' suffix promotes
> > > it to 'long double'.
> > >
> > > There is no visible reason for a floating point value in this driver, as
> > > the value is only used as a parameter to a function that expects an
> > > integer type.  Use USEC_PER_SEC, which is the same integer value as
> > > '1E6L', to avoid changing functionality but fix the error.
> > >
> > > Fixes: 6ed30a7d8ec2 ("usb: dwc2: host: use hrtimer for NAK retries")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1497
> > > Link: https://github.com/llvm/llvm-project/commit/a8083d42b1c346e21623a1d36d1f0cadd7801d83
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Thanks for the patch!
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> hmm...should we explicitly #include <vdso/time.h> for this
> declaration?  It may work due to transitive includes, but that's
> generally considered brittle should those transitive includes change
> in the future.

This file uses ktime_t, which comes from include/linux/ktime.h, which
eventually includes include/vdso/time64.h. include/vdso/time64.h is only
included in three header files and no drivers so I do not think this is
that brittle. I am happy to change that if the maintainers feel it is
worth the extra include.

> >
> > > ---
> > >  drivers/usb/dwc2/hcd_queue.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
> > > index 89a788326c56..bdf1927e1be1 100644
> > > --- a/drivers/usb/dwc2/hcd_queue.c
> > > +++ b/drivers/usb/dwc2/hcd_queue.c
> > > @@ -59,7 +59,7 @@
> > >  #define DWC2_UNRESERVE_DELAY (msecs_to_jiffies(5))
> > >
> > >  /* If we get a NAK, wait this long before retrying */
> > > -#define DWC2_RETRY_WAIT_DELAY (1 * 1E6L)
> > > +#define DWC2_RETRY_WAIT_DELAY (1 * USEC_PER_SEC)
> > >
> > >  /**
> > >   * dwc2_periodic_channel_available() - Checks that a channel is available for a
> > >
> > > base-commit: d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
> > > --
> > > 2.34.0.rc0
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
