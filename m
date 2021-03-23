Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A7D346751
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhCWSMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:12:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56154 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231214AbhCWSMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:12:02 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12NIBs7r012557
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 14:11:55 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6FBA415C39CC; Tue, 23 Mar 2021 14:11:54 -0400 (EDT)
Date:   Tue, 23 Mar 2021 14:11:54 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
Message-ID: <YFovanxCgq1lF4Ah@mit.edu>
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
 <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
 <YFkSqIN90S4a3HiF@mit.edu>
 <54aeb1f7-ffc7-74e1-a731-8970d44ff852@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54aeb1f7-ffc7-74e1-a731-8970d44ff852@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:57:57AM +0100, Thorsten Leemhuis wrote:
> On 22.03.21 22:56, Theodore Ts'o wrote:
> > On Mon, Mar 22, 2021 at 08:25:15PM +0100, Thorsten Leemhuis wrote:
> >> I agree to the last point and yeah, maybe regressions are the more
> >> important problem we should work on – at least from the perspective of
> >> kernel development.  But from the users perspective (and
> >> reporting-issues.rst is written for that perspective) it feel a bit
> >> unsatisfying to not have a solution to query for existing report,
> >> regressions or not. Hmmmm...
> > First of all, thanks for working on reporting-issues.rst.
> 
> Thx, very glad to hear that. I didn't get much feedback on it, which
> made me wonder if anybody besides docs folks actually looked at it...

I'll admit that I had missed your initial submission, but having
looked at it, while I could imagine some nits where it could be
improved, in my opinion, it's strictly better than the older
reporting-bugs doc.

> Hmmm, yeah, I like that idea. I'll keep it in mind for later: I would
> prefer to get reporting-issues.rst officially blessed and
> reporting-bugs.rst gone before working on further enhancements.

Is there anyone following this thread who believes that there is
anything we should change *before* oficially blessing
reporting-issues.rst?  Given that Konstantin has already linked to
reporting-issues from the front page of kernel.bugzilla.org, I think
we we should just go ahead and officially bless it and be done with
it.   :-)

Once it is blessed, I'd also suggest putting a link to
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
as an "other resources" at https://www.kernel.org.

					- Ted
