Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9B534673A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhCWSId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:08:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55250 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231352AbhCWSIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:08:05 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12NI7RRV010579
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 14:07:28 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 763FF15C39CC; Tue, 23 Mar 2021 14:07:27 -0400 (EDT)
Date:   Tue, 23 Mar 2021 14:07:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        workflows@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: RFC: create mailing list "linux-issues" focussed on issues/bugs
 and regressions
Message-ID: <YFouX8vspDCFcBXT@mit.edu>
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
 <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
 <20210323122025.77888b49@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323122025.77888b49@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:20:25PM -0400, Steven Rostedt wrote:
> On Mon, 22 Mar 2021 20:25:15 +0100
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
> 
> > I agree to the last point and yeah, maybe regressions are the more
> > important problem we should work on – at least from the perspective of
> > kernel development.  But from the users perspective (and
> > reporting-issues.rst is written for that perspective) it feel a bit
> > unsatisfying to not have a solution to query for existing report,
> > regressions or not. Hmmmm...
> 
> I think the bulk of user issues are going to be regressions. Although you
> may be in a better position to know for sure, but at least for me, wearing
> my "user" hat, the thing that gets me the most is upgrading to a new kernel
> and suddenly something that use to work no longer does. And that is the
> definition of a regression. My test boxes still run old distros (one is
> running fedora 13). These are the boxes that catch the most issues, and if
> they do, they are pretty much guaranteed to be a regression.

I think it depends on the user and the subsystem.  You're a
sophisticated user, but I've fielded a goodly number of ext4 "bug
reports" which were coming from a Ubuntu 16.04 kernel, or a user who
is seeing a block device issue (either a driver bug or a hardware
failure), or in some cases both.

A lot of these "bug reports" would be headed off at the pass if we
advertised:

https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

much more heavily; assuming we can get the users to actually read it,
first.

						- Ted
