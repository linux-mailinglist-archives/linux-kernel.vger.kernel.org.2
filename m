Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286C3369017
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbhDWKL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhDWKLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2756B61406;
        Fri, 23 Apr 2021 10:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619172677;
        bh=/o0BXhvCn3g+qLDsEXyFdO+FwTtsbkOwzDn8RkxaNLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekx0DYnh1ATISx6W3yjr6KQhPx8EfgS3Os+sBUwW/ksP5iHaJDJ8sY1soCTX6J5xU
         M6D/OB24ACFSWHXzdvNe69/DnufgtffGere6A0qY9Ch7c84wROVsoD10642+MoQejf
         4Sq6tHGMyiKCQm0X9Vq5da/GX/OdMi/O7TBucMQE=
Date:   Fri, 23 Apr 2021 12:11:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        regressions@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        ksummit@lists.linux.dev, workflows@vger.kernel.org
Subject: Re: RFC: building a regression tracking bot for Linux kernel
 development
Message-ID: <YIKdQKJNZOSfdL9B@kroah.com>
References: <268a3049-7c0b-8a33-1ff6-5a2d35fcba16@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <268a3049-7c0b-8a33-1ff6-5a2d35fcba16@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:16:40AM +0200, Thorsten Leemhuis wrote:
> Lo! As mentioned a few times recently I'm staring to build a bot for
> semi-automatic Linux kernel regressions tracking. Find below a rough
> description of how I imagine it's going to work. That way I want to give
> everyone a chance to influence things before I'm starting to code for
> real. Early feedback will help to build something that's acceptable for
> the Linux kernel developer community and used in practice in the long
> run, and that's what I aim for.
> 
> I know, I know, "Talk is cheap. Show me the code.". But I had to think
> things through and write some of it down anyway, so no harm done in
> posting it as RFC. I CCed ksummit, as many maintainers hang out there
> and because this is a follow up to my former regression tracking work we
> discussed on both kernel and maintainers summit 2017; it fact it
> hopefully might be something for this year as well, we'll see, too early
> to tell.
> 
> So how will the "regzbot" work? The ideal case is simple:
> 
> Someone reports a regression to the recently created regressions mailing
> list(regressions@lists.linux.dev). There the user includes a tag like this:
> > #regzb introduced: 94a632d91ad1 ("usc: xhbi-foo: check bar_params earlier")

That's great, but the ability for most people to track stuff down to the
commit id feels very low.  I would think that the "this no longer works"
is the bug report / regression, and eventually that can be tracked down
to "commit XXXX caused this" which is what you want to see above.

Or am I confused?

> That will make regzbot add the report to its list of regressions it
> tracks, which among other will make it store the mail's message-id
> (let's assume it's `xt6uzpqtaqru6pmh@earth.solsystem`). Ideally some
> developer within a few days will fix the regression with a patch. When
> doing so, they already often include a tag linking to the report:
> > Link: https://lore.kernel.org/r/xt6uzpqtaqru6pmh@earth.solsystem
> 
> 
> Regzbot will notice this tag refers to the regression it tracks and
> automatically close the entry for it.
> 
> That's it already. The regression was tracked with:
> 
>  * minimal overhead for the reporter
>  * no additional overhead for the developers – only something they ought
> to do already became more important

That's great, and for tracking commits that we know are bad (like a few
I see being reported against linux-next right now), that's wonderful and
a huge step forward.

But how are you going to track "issues that are not narrowed down to a
commit" with this?  Or is that not the goal here?

Ah, I should have kept reading:

> That can't be all
> -----------------
> 
> Of course the world is more complicated than the simple example scenario
> above, as the devil is always in the details. The three most obvious
> problems the initial ideal scenario left aside:
> 
> * The reporter doesn't specify the #regzb tag at all. Regzbot can't do
> anything about it, it sadly won't have visionary power and a AI engine
> any time soon. Some human (for a while that often will be me) thus needs
> to reply with the tag with a proper reply-to to the report to make
> regboz track it.

Any specific format/tag we can use to help make this easier?  Or is that
just something that you are going to do "by hand" to start with?

> * The commit causing the regression is unknown to the reporter. In that
> case the tag should mention the span when the regression was introduced:
> > #regzb introduced: v5.7..v5.8-rc1

Ah, "introduced", I should have read the whole email, my fault...

> * The developer who fixes the issue forgets to place the "Link:" tag,
> which can't be added once committed. In that case some human needs to
> reply to the thread with the initial report with a tag like this:
> > #regzb Fixed-by: c39667ddcfd5 

nice!

>  * regression in stable and longterm kernels sometimes affect multiple
> versions, for example if a patch that works fine in mainline was
> backported to the longterm kernel 5.10 and 5.4 – but causes problems in
> both, as something required by the patch is missing in those lines. How
> this will be solved exactly remains to be seen, maybe like this:
> > #regzb Introduced: c39667ddcfd6 e39667ddcfd1 ("usc: xhbi-foo: check bar_params a little later again")
> 
>  Then regzbot can look those commits up and from that determine the
> affected versions. Obviously the reporter will likely not be aware of
> it, hence it's likely that the stable maintainer or the developer need
> to send a mail to make regzbot aware that this regression affects
> multiple versions.

This shouldn't be that big of an issue, as the stable maintainers have
simple tools that can show "what releases was this commit in" today,
which is what we use to track what commits need to be backported where.

I can give you a copy of my tools off-line if you are curious about this
and think it's worth adding to your tool.

Oh, and many thanks for doing this, I think this looks great.

greg k-h
