Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAE134E0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhC3F7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhC3F7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:59:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F76A6191B;
        Tue, 30 Mar 2021 05:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617083958;
        bh=+5DO+lXCL5MeWGlG77YUtf/+D9Bht5ixm4alm8/c6S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GT+Qc6M4+0XVaboH0yUMU55OBIAmswUaSY+E9CiXcxK8SBW1Bzu5w0ezQWLFTe3Fp
         TQyHYWXLB0uqPQ6x7+4l+XMTSb1a+dGODNC5alxMldDFUeT6lZF3qw6ie0g7A+BKQ7
         0u0Tsm2DR0k286T1aTdwSY7AC4BOimDM+K+4w4vI=
Date:   Tue, 30 Mar 2021 07:59:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [1/5] reporting-issues: header and TLDR
Message-ID: <YGK+M66FWJOMC8ky@kroah.com>
References: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
 <6a220d2c-568e-2e41-53a4-0800e206d0a6@leemhuis.info>
 <14d9b8a3-94ce-00a6-a17b-934ffd999697@leemhuis.info>
 <87r1jxpol6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1jxpol6.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:44:21PM -0600, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
> > FWIW, on another channel someone mentioned the process in the TLDR is
> > quite complicated when it comes to regressions in stable and longterm
> > kernels. I looked at the text and it seemed like a valid complaint, esp.
> > as those regressions are something we really care about.
> >
> > To solve this properly I sadly had to shake up the text in this section
> > completely and rewrite parts of it. Find the result below. I'm quite
> > happy with it, as it afaics is more straight forward and easier to
> > understand. And it matches the step-by-step guide better. And the best
> > thing: it's a bit shorter than the old TLDR.
> 
> I think this is much improved - concise is good! :)  I really just have
> one little comment...
> 
> > I'll wait a day or two and then will send it through the regular review
> > together with a few small other fixes that piled up for the text, just
> > wanted to add it here for completeness.
> >
> > ---
> > The short guide (aka TL;DR)
> > ===========================
> >
> > Are you facing a regression with vanilla kernels from the same stable or
> > longterm series? One still supported? Then search the `LKML
> > <https://lore.kernel.org/lkml/>`_ and the `Linux stable mailing list
> > <https://lore.kernel.org/stable/>_` archives for matching reports to
> > join. If you don't find any, install `the latest release from that
> > series <https://kernel.org/>`_. If it still shows the issue, report it
> > to the stable mailing list and the stable maintainers.
> 
> If we really want this to be a short guide that gets people to the
> answer quickly, we might as well put the addresses to report to right
> here rather than making people search for them.

"stable@vger.kernel.org" is good to use here, no need to also cc: any
individuals for this type of thing.

thanks,

greg k-h
