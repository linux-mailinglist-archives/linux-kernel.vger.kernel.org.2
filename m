Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5845B8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbhKXLGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 06:06:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236994AbhKXLGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D38F60F58;
        Wed, 24 Nov 2021 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637751791;
        bh=pNtpfI9OTL0x8QraprdRcpGtrA43z45AvqlIzIQ9RpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wj0YdZ5ReKQu4zH3Okmc1Yukr74LZ6YZE+sjNAynSobEbl4Plt1WGqZAREauo/o/N
         WqXCLY09kaXiWR36S0ko0+j6Mvh7KhPhvPvJlU9pNzOtcYJfZjU43iQ2vnrJL9PNfv
         x7h0hEWXaup6tB10Ih1wd1AdwrpOUwg9uKs3kpWo=
Date:   Wed, 24 Nov 2021 12:03:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Linux regressions report for mainline [2021-11-24]
Message-ID: <YZ4b7N4OTjypAtc7@kroah.com>
References: <163774583541.221636.5062449110647587402@leemhuis.info>
 <ed60649f-db15-db1d-f7b5-a0878f639d64@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed60649f-db15-db1d-f7b5-a0878f639d64@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 11:01:52AM +0100, Thorsten Leemhuis wrote:
> Lo! This was the first report sent by regzbot, my Linux kernel
> regression tracking bot, so I guess it might be a good idea to highlight
> a few of it's aspects:
> 
> On 24.11.21 10:25, Regzbot (on behalf of Thorsten Leemhuis) wrote:
> > From: Regzbot (for Thorsten Leemhuis) <regressions@leemhuis.info>
> > 
> > Hi, this is regzbot, the Linux kernel regression tracking bot.
> > 
> > Currently I'm aware of 15 regressions in linux-mainline. Find the
> > current status below and the latest on the web:
> > 
> > https://linux-regtracking.leemhuis.info/regzbot/mainline/
> > 
> > Bye bye, hope to see you soon for the next report.
> >    Regzbot (on behalf of Thorsten Leemhuis)
> 
> >From now on I plan to make regzbot send such reports on Monday mornings,
> e.g. usually a few hours after Linus released a new RC.
> 
> Let me know what you think about the format.
> 
> A few random thoughts and explanations about the current format:
> 
> - next weeks report will highlight regressions that get added to regzbot
> over the next few days
> 
> - I chose to categorize the regressions by identification status and by
> version line. Those where the culprit is identified come first, as they
> are the ones which most of the time can be solved by reverting the culprit
> 
> - the entries in each section are ordered by time of last activity,
> which makes it easy to spot those where nothing happened recently, as
> they are near the end of a section.
> 
> - the webui (https://linux-regtracking.leemhuis.info/regzbot/mainline/ )
> links to the latest five activities regzbot noticed (an activity most of
> the time will be a mail send in reply to the report or a related thread
> that regzbot monitors). I for now chose to not do that in the report, as
> it would make it much longer and might be something that spam filters
> consider suspicious.
> 
> That's it from my side. Let me know what you think.

I like it, but as a maintainer, I find this hard to know what to do with
it.

As a maintainer, I want to be reminded of what regressions have been
reported for my subsystem, so I know what to do and who to go poke about
them.

I could dig through the list and try to see if these are relevant to me,
but it's not always obvious.

How about something like "one email per issue" as a response from the
first report, that would cc: the needed maintainers (or people from
MAINTAINERS, you should be able to get that automatically from
get_maintainer.pl) and the subsystem mailing list (again from
get_maintainers.pl), so that I am constantly reminded that "you need to
get this fixed!".

Pester me, it's my job as a maintainer to get regressions resolved.  If
I see a long list with no names on it, It's easier for me to just ignore
:)

Anyway, I know that's more work for you, don't do it if you don't want
to, but as you have individual items in your database already, maybe it
is easy to do, I don't know.  Thanks again for doing this work, it's
great to see happen.

thanks,

greg k-h
