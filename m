Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B139311BF0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 08:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBFHWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 02:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhBFHWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 02:22:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E74EA64FD1;
        Sat,  6 Feb 2021 07:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612596126;
        bh=uJW0U1zMvAZv+rGVPbTMrkiyuU6ywj0nhXYICREKdM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=En654oyF05/AukCKqS89Ad74tc5bfONh2v0ljnhPYJyvw9uPjwMShnjkyMjqieS4e
         zNQEXfKWk2rBN/P3qRSDKEMShORuzC9bdJVO/qvYuj3eCGATQlBHaUDIOHvMWE2/HP
         G+ocurJ4OObmBpNfsEN0kNnc/iFQ9bN2UtUq+Wnw=
Date:   Sat, 6 Feb 2021 08:22:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Battersby <tonyb@cybernetics.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Jari Ruusu <jariruusu@protonmail.com>,
        David Laight <David.Laight@aculab.com>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Subject: Re: Kernel version numbers after 4.9.255 and 4.4.255
Message-ID: <YB5DmnPd/Er0+yem@kroah.com>
References: <a85b7749-38b2-8ce9-c15a-8acb9a54c5b5@kernel.org>
 <0b12bac9-1b4e-ec4a-8a45-5eb3f1dbbeca@cybernetics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b12bac9-1b4e-ec4a-8a45-5eb3f1dbbeca@cybernetics.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 12:31:05PM -0500, Tony Battersby wrote:
> On 2/4/21 6:00 AM, Jiri Slaby wrote:
> > Agreed. But currently, sublevel won't "wrap", it will "overflow" to 
> > patchlevel. And that might be a problem. So we might need to update the 
> > header generation using e.g. "sublevel & 0xff" (wrap around) or 
> > "sublevel > 255 : 255 : sublevel" (be monotonic and get stuck at 255).
> >
> > In both LINUX_VERSION_CODE generation and KERNEL_VERSION proper.
> 
> My preference would be to be monotonic and get stuck at 255 to avoid
> breaking out-of-tree modules.

I really do not care about out-of-tree modules sorry, as there's nothing
we can do about them.  And internal kernel apis are always changing,
even in stable/lts releases, so changing this type of thing for them
should not be a big deal as maintainers of this type of code always have
to do that.

thanks,

greg k-h
