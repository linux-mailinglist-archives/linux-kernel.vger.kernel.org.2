Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F46346DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 00:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhCWXLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 19:11:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51962 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234246AbhCWXLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 19:11:06 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 59C7D1F9FC;
        Tue, 23 Mar 2021 23:11:06 +0000 (UTC)
Date:   Tue, 23 Mar 2021 23:11:06 +0000
From:   Eric Wong <e@80x24.org>
To:     workflows@vger.kernel.org
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
Message-ID: <20210323231106.GA7165@dcvr>
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
 <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
 <20210323122025.77888b49@gandalf.local.home>
 <72f1c67bc8ad21bb1e5a7d77b88e2c3e50065e3b.camel@HansenPartnership.com>
 <20210323214317.t3igv3nan4lfolgr@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323214317.t3igv3nan4lfolgr@chatter.i7.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> On Tue, Mar 23, 2021 at 09:30:33AM -0700, James Bottomley wrote:
> > > I think the bulk of user issues are going to be regressions. Although
> > > you may be in a better position to know for sure, but at least for
> > > me, wearing my "user" hat, the thing that gets me the most is
> > > upgrading to a new kernel and suddenly something that use to work no
> > > longer does. And that is the definition of a regression. My test
> > > boxes still run old distros (one is running fedora 13). These are the
> > > boxes that catch the most issues, and if they do, they are pretty
> > > much guaranteed to be a regression.
> > > 
> > > I like the "linux-regressions" mailing list idea.
> > 
> > Can't we use the fancy features of public inbox to get the best of both
> > worlds?  Have the bug list (or even a collection of lists) but make the
> > linux-regressions one a virtual list keying off an imap flag which a
> > group of people control.  That way anything that is flagged as a
> > regression appears in that public inbox.  I assume the search can be
> > quite wide so we could flag a regression on any list indexed by lore?

The lei (local email interface) data model will have "labels"(*)
and developers will be able to publish mail with it via static
HTML/Atom/JSON feed via cronjob and whatnot.

> There's a number of ways we can accomplish this, sure.
> 
> However, this functionality is not in production yet, and I'm not sure which
> upcoming public-inbox features we'll be implementing as a public
> lore.kernel.org service,

> which ones we'll only offer to kernel.org account holders,

lei could offer read-write JMAP support; either as a CGI tied
to Unix user accounts or some virtual user system.  Some fixes
I'm currently making to speed up the test suite will also make
it more suitable for a largish virtual user system.

> and which ones should really be running locally by developers
> themselves.

lei will be MY dream mail/git tool that fills in the gaps
left by other tools; I hope it can make others happy, too :)

> So, I don't want to say either yes or no to this one for the fear of
> over-promising. I guess this is why I'm not in sales. :)

Heh, same here.  Once I start using lei to handle all of my mail
and there's a data-loss bug, I could conceivably never know
about it because the bug reports would be lost... :x


[1] "labels" are "mailboxes" in JMAP-speak; and lei's per-user data
    model will be tied to JMAP.  "keywords" are Maildir/IMAP-system
    flags (seen/flagged/answered/...).  JMAP doesn't allow arbitrary
    keywords, but does allow arbitrary labels.
