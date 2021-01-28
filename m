Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA37A307F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhA1UFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhA1T66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 14:58:58 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB15864E34;
        Thu, 28 Jan 2021 19:45:55 +0000 (UTC)
Date:   Thu, 28 Jan 2021 19:45:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.11-rc5
Message-ID: <20210128194551.76c76cfe@archlinux>
In-Reply-To: <YA7Q0XZMIdudb6x9@kroah.com>
References: <YA1u24kUPB+B7gKY@kroah.com>
        <CAHk-=whe0kHRKsNegF+JxCooS_Z0otcEX_Ggz=iN2v3D1Rssxg@mail.gmail.com>
        <YA7Q0XZMIdudb6x9@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 15:08:17 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Jan 24, 2021 at 11:31:59AM -0800, Linus Torvalds wrote:
> > On Sun, Jan 24, 2021 at 4:58 AM Greg KH <gregkh@linuxfoundation.org> wrote:  
> > >
> > > David Lechner (1):
> > >       counter:ti-eqep: remove floor  
> > 
> > I'm not sure why that ti-eqep counter driver seems to be in your
> > "iio/staging" pile rather than "char/misc", but whatever..  
> 
> Jonathan said why that was needed, I think it was due to fixes in the
> counter core code, but he can verify this better than I can...

Hi Linus / Greg,

Bit of history involved here...

The counter drivers started out as just another sensor type
under IIO, but ended up pushing the boundaries of the ABI a lot -
ultimately making it clear that they really didn't fit in IIO.
William came up with a better abstraction / framework that
became drivers/counter/, but currently the patch flow for
drivers/counter/ is sufficiently low that I handle their
patches along side IIO rather than via a separate tree.

There is also a cross dependency because of legacy IIO ABI
though we are aiming to drop that either this cycle or next.

Hope that clears it up.  If either of you would prefer
it a different way in future let me know.

This particular fix was local to the driver - it was pretending
it supported something that hardware couldn't actually do.

Thanks,

Jonathan

> 
> thanks,
> 
> greg k-h

