Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF47358288
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhDHLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhDHLzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:55:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5598061074;
        Thu,  8 Apr 2021 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617882902;
        bh=iQk6+bM0UOUsorND9uQvTGZPvJSGKBUdzwIBG7StOd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIgHbqkFvfRyFgeEuKMH+0cJfL44FIcLDdjmWuwU4hewQwZEjpnXfeslfh0TQd6cL
         UzKJfMfmz94+vOh14zO7Izv3do+DUfT4HCkOJjeTjdHCQuV6mQdKXJzySLfCbnC8ku
         1vEs1S2zX5ULnO3VOuVdPUXTnihgRds0yVEmLzC1Nf1oxQ3+WGLEVq8EX79WgSWhIj
         TkHRE642ciIgvftXHGeP+LoT70gEkMbM69lGkGLBtDjvL3Uk/3oXNUC8LrIhav8B1p
         msVEiRFsNuSbfkJnqciZ/l5oLPjWvZwIJUCcjUtyrd+zRlcs076ptSuEI48uCcEnKv
         jFZPd6YFNlPIA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUTFR-0003Pz-NF; Thu, 08 Apr 2021 13:54:57 +0200
Date:   Thu, 8 Apr 2021 13:54:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] USB: cdc-acm: fix TIOCGSERIAL implementation
Message-ID: <YG7vEQa53AhN+piv@hovoldconsulting.com>
References: <20210407102845.32720-1-johan@kernel.org>
 <20210407102845.32720-4-johan@kernel.org>
 <a1a94db2d373c4c7b8841908d8e6133ab022232e.camel@suse.com>
 <YG7RiLoscS6VXG7n@hovoldconsulting.com>
 <0049152ce9da85c50fda91c1b77ca233ba0fef3d.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0049152ce9da85c50fda91c1b77ca233ba0fef3d.camel@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:34:12PM +0200, Oliver Neukum wrote:
> Am Donnerstag, den 08.04.2021, 11:48 +0200 schrieb Johan Hovold:
> > On Thu, Apr 08, 2021 at 10:36:46AM +0200, Oliver Neukum wrote:
> > > Am Mittwoch, den 07.04.2021, 12:28 +0200 schrieb Johan Hovold:
> 
> > > Well, the devices report it. It is part of the standard.
> > 
> > No, the standard doesn't include anything about a baud-base clock
> > AFAICT.
> 
> Unfortunately it does.
> dwDTERate - chapter 6.3.11 - table 17

That's not the base clock rate, that's just the currently configured
line speed which you can read from termios.
 
> If we does this wrongly, we should certainly fix it, but just removing
> the reporting doesn't look right to me.

The driver got its interpretation of baud_base wrong, and CDC doesn't
even have a concept of base clock rate so removing it is the right thing
to do.

Again, baud_base is really only relevant with legacy UARTs and when
using the deprecated ASYNC_SPD_CUST.

And if the user wants to knows the current line speed we have a
different interface for that.

Johan
