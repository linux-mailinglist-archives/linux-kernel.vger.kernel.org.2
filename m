Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3653C6381
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhGLTTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233183AbhGLTTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:19:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0C076120A;
        Mon, 12 Jul 2021 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626117409;
        bh=IHcOwBmPaeJBX2DDHP2ZsXMyNaAXQsOnf8j8Kq3ksbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LaAoid0gm89HjKLE0eXmC9rHlC2VegZzLpoDmHJY5j/Qca9LUGyeANuvy+IwXvMfb
         59tu+mBklhBpdfQMFsJoJuNEAGDDCzSYD1o2nXIDLV9Jt9XCAGM/l6QVU/FbwkanKO
         b9K4//Iy79S7nE29IVeaoWkpkNUVYu7Rz3V8CNuA=
Date:   Mon, 12 Jul 2021 21:16:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/setlocalversion: fix a bug when LOCALVERSION
 is empty
Message-ID: <YOyVH3qD9O3qsNUL@kroah.com>
References: <alpine.LRH.2.02.2107120957300.14207@file01.intranet.prod.int.rdu2.redhat.com>
 <YOyGrUvA4LjydcP3@kroah.com>
 <alpine.LRH.2.02.2107121502380.8445@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2107121502380.8445@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 03:06:48PM -0400, Mikulas Patocka wrote:
> 
> 
> On Mon, 12 Jul 2021, Greg Kroah-Hartman wrote:
> 
> > On Mon, Jul 12, 2021 at 10:00:59AM -0400, Mikulas Patocka wrote:
> > > The patch 042da426f8ebde012be9429ff705232af7ad7469 
> > > ("scripts/setlocalversion: simplify the short version part") reduces the 
> > > indentation. Unfortunatelly, it also changes behavior in a subtle way - if 
> > > the user has empty "LOCALVERSION" variable, the plus sign is appended to 
> > > the kernel version. It wasn't appended before.
> > > 
> > > This patch reverts to the old behavior - we append the plus sign only if
> > > the LOCALVERSION variable is not set.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > Fixes: 042da426f8eb ("scripts/setlocalversion: simplify the short version part")
> > > 
> > > ---
> > >  scripts/setlocalversion |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Index: linux-2.6/scripts/setlocalversion
> > > ===================================================================
> > > --- linux-2.6.orig/scripts/setlocalversion	2021-07-12 15:29:07.000000000 +0200
> > > +++ linux-2.6/scripts/setlocalversion	2021-07-12 15:50:29.000000000 +0200
> > > @@ -131,7 +131,7 @@ res="${res}${CONFIG_LOCALVERSION}${LOCAL
> > >  if test "$CONFIG_LOCALVERSION_AUTO" = "y"; then
> > >  	# full scm version string
> > >  	res="$res$(scm_version)"
> > > -elif [ -z "${LOCALVERSION}" ]; then
> > > +elif [ "${LOCALVERSION+set}" != "set" ]; then
> > 
> > That's really subtle, can you add a comment here that this handles an
> > empty file?
> > 
> > thanks,
> > 
> > greg k-h
> 
> OK.
> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> 

I can't take a patch like this :(

> The patch 042da426f8ebde012be9429ff705232af7ad7469
> ("scripts/setlocalversion: simplify the short version part") reduces

Properly quote commits, the documentation says you do not need to use
the full sha1.


> indentation. Unfortunatelly, it also changes behavior in a subtle way - if
> the user has empty "LOCALVERSION" variable, the plus sign is appended to
> the kernel version. It wasn't appended before.
> 
> This patch reverts to the old behavior - we append the plus sign only if
> the LOCALVERSION variable is not set.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: 042da426f8eb ("scripts/setlocalversion: simplify the short version part")

See, use that way to quote a commit.

thanks,

greg k-h
