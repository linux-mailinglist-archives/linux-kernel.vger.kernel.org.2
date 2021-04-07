Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC3356F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353216AbhDGO5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353171AbhDGO51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE73E6113D;
        Wed,  7 Apr 2021 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617807434;
        bh=tUfOgaHcl8ljWu0Wz4/Ge0t5B4gD7a3bBu4ayfksIec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbDifmJtZHVDm4kG2+oWzWbeF+rTRt7NhGUFOHuDZXvgQsUUm3WyLxk1zQ4qzDxzJ
         k0CUR6uIV/wS1Z7rlVAnRfXPMfZXjE03zZGg6Hh+gsmwTpRLR87kOnN0iWlgiBwieO
         5Q9dN09ZoJ3cgfBEObPbXnfkihVrXNIMDDrWthhE=
Date:   Wed, 7 Apr 2021 16:56:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] MAINTAINERS: add regressions mailing list
Message-ID: <YG3IK46M4LNWp3EO@kroah.com>
References: <cover.1617786974.git.linux@leemhuis.info>
 <f959331ed0e1a8ed59be9771fcab64378bd6977d.1617786974.git.linux@leemhuis.info>
 <YG2BxMBLqEt4mkgS@kroah.com>
 <3121a1cd-47c6-b26e-0cb3-71872d5ffc65@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3121a1cd-47c6-b26e-0cb3-71872d5ffc65@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 12:51:43PM +0200, Thorsten Leemhuis wrote:
> On 07.04.21 11:56, Greg KH wrote:
> > On Wed, Apr 07, 2021 at 11:21:55AM +0200, Thorsten Leemhuis wrote:
> >> Add the newly created regression mailing list finally created after it
> >> already had been agreed on during the maintainers summit 2017 (see
> >> https://lwn.net/Articles/738216/ ). The topic was recently discussed
> >> again, where an idea to create a broader list for all issues was
> >> discussed, but Linus preferred a more targeted list:
> >> https://lkml.kernel.org/r/CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com/
> >>
> >> Hence, the creation for that list was asked for and granted:
> >> https://bugzilla.kernel.org/show_bug.cgi?id=212557
> >>
> >> In the end it became regressions@lists.linux.dev instead of
> >> linux-regressions@lists.linux.dev as 'Linux' is redundant in the latter
> >> case.
> >>
> >> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> >> ---
> >> I was a bit unsure how to add that list to MAINTAINERS. I considered
> >> adding a 'M:' with my name and email address there as well, but getting
> >> CCed on a lot of regression reports might be a bit much. I also left a
> >> 'S: supported' out, as that doesn't make much sense in this case afaics;
> >> and I checked, there are other entries that don't have those two (but
> >> it's rare).
> > 
> > Put your name there, you are the "maintainer of regressions!"  :)
> 
> Okay, will do. :-D
> 
> /me wonders why he suddenly feels like entering a self-made trap ;-)
> 
> > [...]
> >> +REGRESSIONS
> >> +L:	regressions@lists.linux.dev
> >> +K:	regression
> > 
> > A bit more information here perhaps?  This will not really help anyone
> > out to know what to do.
> 
> Did you mean a different headline for the entry?  Or would you suggest
> to use a webpage (W:) for that or a Subsystem Profile document (P:)
> here? Using either of the two latter was the plan, but for now I'm a bit
> unsure what to write there except maybe "Thorsten is working on a
> semi-automatic solution for tracking Linux kernel regressions. Details
> will follow. For now report regressions as outlined in
> reporting-issues.rst; but in case you have any problem or think there is
> a regressions not handled appropriately by the maintainers, get him
> involved, he'll try to help".
> 
> Or did you have something totally different in mind?

Well, "K:	regression" is not a regex, so that's not going to
really help much.

How about something simple like:
	KERNEL REGRESSIONS:
	M:	Thorsten Leemhuis <linux@leemhuis.info>
	L:	regressions@lists.linux.dev
	S:	Supported

That looks a bit more like other entries, has a name and a list and a
state of your status for this work.

Would that work?

thanks,

greg k-h
