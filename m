Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBA9346819
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhCWSvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhCWSvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:51:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D6FC061574;
        Tue, 23 Mar 2021 11:51:13 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lOm7N-00052g-VX; Tue, 23 Mar 2021 19:51:06 +0100
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
 <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
 <YFkSqIN90S4a3HiF@mit.edu>
 <54aeb1f7-ffc7-74e1-a731-8970d44ff852@leemhuis.info>
 <YFovanxCgq1lF4Ah@mit.edu>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
Message-ID: <5a26cdba-eff9-8a5c-fda1-3f8d14b49868@leemhuis.info>
Date:   Tue, 23 Mar 2021 19:51:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YFovanxCgq1lF4Ah@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616525473;2c98399b;
X-HE-SMSGID: 1lOm7N-00052g-VX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.21 19:11, Theodore Ts'o wrote:
> On Tue, Mar 23, 2021 at 09:57:57AM +0100, Thorsten Leemhuis wrote:
>> On 22.03.21 22:56, Theodore Ts'o wrote:
>>> On Mon, Mar 22, 2021 at 08:25:15PM +0100, Thorsten Leemhuis wrote:
>>>> I agree to the last point and yeah, maybe regressions are the more
>>>> important problem we should work on – at least from the perspective of
>>>> kernel development.  But from the users perspective (and
>>>> reporting-issues.rst is written for that perspective) it feel a bit
>>>> unsatisfying to not have a solution to query for existing report,
>>>> regressions or not. Hmmmm...
>>> First of all, thanks for working on reporting-issues.rst.
>> Thx, very glad to hear that. I didn't get much feedback on it, which
>> made me wonder if anybody besides docs folks actually looked at it...
> I'll admit that I had missed your initial submission,

No wonder with all the lists and mails. :-D That's actually why I wanted
to point to the text on ksummit-list once in the near future after two
remaining issues with the text were solved (see below), but before
removing the "WIP" box at the top and deleting reporting-bugs.rst.

> but having
> looked at it, while I could imagine some nits where it could be
> improved,

Yeah, for sure, with such a text that will always be the case. And I
really would like if a few more people take a closer look and provide
feedback, that really helps to get such a text in shape. I have stared
so much at the text in recent months, that makes it quite easy to miss
typos and errors in the logical flow that a fresh pair of eyes will
immediately spot...

> in my opinion, it's strictly better than the older
> reporting-bugs doc.

Great, thx.

>> Hmmm, yeah, I like that idea. I'll keep it in mind for later: I would
>> prefer to get reporting-issues.rst officially blessed and
>> reporting-bugs.rst gone before working on further enhancements.
> Is there anyone following this thread who believes that there is
> anything we should change *before* oficially blessing
> reporting-issues.rst?  Given that Konstantin has already linked to
> reporting-issues from the front page of kernel.bugzilla.org, I think
> we we should just go ahead and officially bless it and be done with
> it.   :-)

FWIW, here is my current todo list from the top of my head:

* get this patchset reviewed and applied:
https://lore.kernel.org/linux-doc/cover.1616181657.git.linux@leemhuis.info/

* *afterwards* make sure Greg and/or Sasha (now CCed) check the text
from their point of view (above patchset changes quite a few things in
that area, that's why it needs to be applied first)

* get feedback reg. the two FIXME boxes remaining afterwards. One is
about bugzilla (```The old text took a totally different approach to
bugzilla.kernel.org...```), the other about CCing LKML  (```Above
section tells users to always CC LKML […] Should we create mailing list
like linux-issues@vger.kernel.org```). But I guess the approach taken
should be fine for most people, so we could simply remove them. We can
still change things later anyway, I just put those boxes there to
highlight these differences to the old approach.

* remove the note at the top (```This document is being prepared to
replace 'Reporting bugs...``` and delete reporting-bugs.rst

> Once it is blessed, I'd also suggest putting a link to
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> as an "other resources" at https://www.kernel.org.

+1

Ciao, Thorsten
