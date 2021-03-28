Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1234BBE8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 12:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhC1KEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 06:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhC1KDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 06:03:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E58B1617ED;
        Sun, 28 Mar 2021 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616925826;
        bh=hCcz/Ooj3nWB+/PcEjVt64iF8JDVLdfoSqVoYjD5mn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FX5J4oWCc+cXRZrMqvD4SJzskFNy+k3ZmeXp006X3dUAOkzrEwuWpXPJN1JTtQ+Pm
         uRI4KD3yIKnNpL9q6mnlNApUqJ2Lg+1pb8ch5u+fMYOZ3SQkRBd6HhX/bXd/6lO5qA
         rCjyCC6O+sjNRi/DeSJZU+VpLHJI4aq+Usw01sSk=
Date:   Sun, 28 Mar 2021 12:03:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [1/5] reporting-issues: header and TLDR
Message-ID: <YGBUf6aQhlBzP+a+@kroah.com>
References: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
 <6a220d2c-568e-2e41-53a4-0800e206d0a6@leemhuis.info>
 <14d9b8a3-94ce-00a6-a17b-934ffd999697@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d9b8a3-94ce-00a6-a17b-934ffd999697@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 11:23:30AM +0200, Thorsten Leemhuis wrote:
> On 26.03.21 07:15, Thorsten Leemhuis wrote:
> > On 26.03.21 07:13, Thorsten Leemhuis wrote:
> >>
> >> Lo! Since a few months mainline in
> >> Documentation/admin-guide/reporting-issues.rst contains a text written
> >> to obsolete the good old reporting-bugs text. For now, the new document
> >> still contains a warning at the top that basically says "this is WIP".
> >> But I'd like to remove that warning and delete reporting-bugs.rst in the
> >> next merge window to make reporting-issues.rst fully official. With this
> >> mail I want to give everyone a chance to take a look at the text and
> >> speak up if you don't want me to move ahead for now.
> >>
> >> For easier review I'll post the text of reporting-issues.rst in reply to
> >> this mail. I'll do that in a few chunks, as if this was a cover letter
> >> for a patch-set. 
> > Here we go:
> > [...]
> > Reporting issues
> > ++++++++++++++++
> > 
> > The short guide (aka TL;DR)
> > ===========================
> > 
> > [...]
> 
> 
> FWIW, on another channel someone mentioned the process in the TLDR is
> quite complicated when it comes to regressions in stable and longterm
> kernels. I looked at the text and it seemed like a valid complaint, esp.
> as those regressions are something we really care about.
> 
> To solve this properly I sadly had to shake up the text in this section
> completely and rewrite parts of it. Find the result below. I'm quite
> happy with it, as it afaics is more straight forward and easier to
> understand. And it matches the step-by-step guide better. And the best
> thing: it's a bit shorter than the old TLDR.
> 
> I'll wait a day or two and then will send it through the regular review
> together with a few small other fixes that piled up for the text, just
> wanted to add it here for completeness.
> 
> ---
> The short guide (aka TL;DR)
> ===========================
> 
> Are you facing a regression with vanilla kernels from the same stable or
> longterm series? One still supported? Then search the `LKML
> <https://lore.kernel.org/lkml/>`_ and the `Linux stable mailing list
> <https://lore.kernel.org/stable/>_` archives for matching reports to
> join. If you don't find any, install `the latest release from that
> series <https://kernel.org/>`_. If it still shows the issue, report it
> to the stable mailing list and the stable maintainers.
> 
> In all other cases try your best guess which kernel part might be
> causing the issue. Check the :ref:`MAINTAINERS <maintainers>` file for
> how its developers expect to be told about problems, which most of the
> time will be by email with a mailing list in CC. Check the destination's
> archives for matching reports; search the `LKML
> <https://lore.kernel.org/lkml/>`_ and the web, too. If you don't find
> any to join, install `the latest mainline kernel
> <https://kernel.org/>`_. If the issue is present there, send a report.
> 
> If you would like to see the issue also fixed in a still supported
> stable or longterm series, install its latest release. If it shows the
> problem, search for the change that fixed it in mainline and check if
> backporting is in the works or was discarded; if it's neither, ask those
> who handled the change for it.
> 
> **General remarks**: When installing and testing a kernel as outlined
> above, ensure it's vanilla (IOW: not patched and not using add-on
> modules). Also make sure it's built and running in a healthy environment
> and not already tainted before the issue occurs.
> 
> While writing your report, include all information relevant to the
> issue, like the kernel and the distro used. In case of a regression try
> to include the commit-id of the change causing it, which a bisection can
> find. If you're facing multiple issues with the Linux kernel at once,
> report each separately.
> 
> Once the report is out, answer any questions that come up and help where
> you can. That includes keeping the ball rolling by occasionally
> retesting with newer releases and sending a status update afterwards.
> 
> ---

The above looks good to me, thanks for doing this work.

greg k-h
