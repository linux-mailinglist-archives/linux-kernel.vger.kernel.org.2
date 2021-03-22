Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8B1344913
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhCVPSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhCVPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:18:28 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC49BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:18:27 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lOMJv-0006QD-Qm; Mon, 22 Mar 2021 16:18:19 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org,
        workflows@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: RFC: create mailing list "linux-issues" focussed on issues/bugs and
 regressions
Message-ID: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
Date:   Mon, 22 Mar 2021 16:18:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616426307;1afa6a5f;
X-HE-SMSGID: 1lOMJv-0006QD-Qm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lo! I want to provide users with an easier way to search our multitude
of mailing lists for reports about issues (aka bugs), as reporting the
same kernel problem multiple times has known downsides for everyone
involved. That's why I propose to create this new mailing list:

linux-issues@lists.linux.dev

Developers and users reporting or handling issues then can CC it or
search it via lore. But this will only fly if the idea has buy-in from
at least the core kernel maintainers, to make sure they and the
developers actually use it. That's why I'm looking for feedback with
this mail and also CCed ksummit-discuss, as that's the easiest way to
make sure maintainers get aware of this idea and can raise their voice.


Note, there is a second reason why ksummit-discuss is CCed: another
reason why I want to create this new list is making it easier to find
and track regressions reported to our various mailing lists (often
without LKML in CC, as for some subsystems it's seems to be custom to
not CC it). Back on the maintainers summit in 2017 it was agreed to
create a dedicated list for this purpose
(https://lwn.net/Articles/738216/). I even requested a
"linux-regressions@vger.kernel.org" a while later, but didn't hear
anything back; and, sadly, about the same time I started having trouble
finding spare time for working on regression tracking. :-/

But I soon will get back into that area:
https://linux-regtracking.leemhuis.info/post/hello-world/ Hence it's a
good time to prepare some groundwork for that. But these days I think
having something like linux-regressions@lists.linux.dev might be over
engineered, at least for now: a linux-issues@lists.linux.dev with a
simple "[regressions]" in the subject will suffice, as that tag is
something a lot of people are used to already. And if we think we need
that list we can still create it in the future. Or what do you folks
think about it?



We can obviously bikeshed about the name for the list. I'm sure some
people will prefer to use "bugs" instead of "issues" there. I propose
"issues" for now, because the new text I've written about reporting
kernels issues/bugs uses the word "issues" in the filename, the title,
and the body while avoiding "bug" (see
Documentation/admin-guide/reporting-issues.rst or
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
). I chose this approach as users are dealing with issues that might or
might not be bugs in the kernel. We discussed this before above text was
merged, but in the end stayed with issues:
https://lore.kernel.org/linux-doc/b5f5dfad-07bb-b518-0dff-3aa340333046@infradead.org/
BTW, creating this list will partly solve the second of the "FIXME
warning boxes" currently left in that text (two others are solved by
patches that are under review currently).


The question "Why not simply LKML" will likely pop up, but the thing is:
searching for reports there will often turn up patches that improve the
kernel and don't fix anything. That makes it hard to find issue reports,
especially for users that are not used to deal with mailing lists and
their archives.

And yes, I'm quite aware that searching linux-issues@lists.linux.dev
list obviously won't turn up reports that are filed in
bugzilla.kernel.org or some other bug tracking tool. That's okay, as the
reporting-issues.rst tells users to look in those places as well.

Another "and yes, I'm quite aware" note: sure reporting issues/bugs by
mail has downsides and maybe instead of creating yet another mailing
list it would be better if all the kernel issues would be reported to a
central place like bugzilla.kernel.org. But that tracker doesn't work
that well currently, as quite a few of the issues filed there afaics
never reach the people that need to be handle them. I don't see that
changing any time soon (we had a discussion about this recently:
https://lore.kernel.org/linux-doc/20210111194822.4kvl2tx24anyu23k@chatter.i7.local/
).

Creating a new mailing list for issues OTOH is something that can be
done quickly and easily to improve the situation without too much
hassle. That's why that's my plan currently, unless the discussion that
hopefully evolved due to this mail leads to something better. :-D

Ciao, Thorsten
