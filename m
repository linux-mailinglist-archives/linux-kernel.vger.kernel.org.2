Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192FE34A17E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCZGNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhCZGNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:13:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA42C0613AA;
        Thu, 25 Mar 2021 23:13:13 -0700 (PDT)
Received: from ip4d142c50.dynamic.kabel-deutschland.de ([77.20.44.80] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1lPfiX-0000z4-QH; Fri, 26 Mar 2021 07:13:09 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: FYI & RFC: obsoleting reporting-bugs and making reporting-issues
 official
Message-ID: <c396c91f-27c2-de36-7b05-099e03c213f4@leemhuis.info>
Date:   Fri, 26 Mar 2021 07:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1616739193;e8793b06;
X-HE-SMSGID: 1lPfiX-0000z4-QH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lo! Since a few months mainline in
Documentation/admin-guide/reporting-issues.rst contains a text written
to obsolete the good old reporting-bugs text. For now, the new document
still contains a warning at the top that basically says "this is WIP".
But I'd like to remove that warning and delete reporting-bugs.rst in the
next merge window to make reporting-issues.rst fully official. With this
mail I want to give everyone a chance to take a look at the text and
speak up if you don't want me to move ahead for now.

For easier review I'll post the text of reporting-issues.rst in reply to
this mail. I'll do that in a few chunks, as if this was a cover letter
for a patch-set. Note, the version I'll send in some areas looks a bit
different from the one currently in mainline. That's because the text
I'll send already incorporates a few patches from docs-next that are
waiting for the next merge window; I also removed the "WIP" box as well
as two remaining "FIXME" notes, as those point to aspects I mention
below already.

@Greg, @Sasha, I'd be especially glad if at least one of you two could
take a look and yell if there is something you really dislike from the
perspective of the stable maintainers.

@Everyone: if you provide feedback, please state if you think something
needs to be fixed before I remove the WIP box. Everything else I might
leave for later depending on how much feedback I get and how much time I
can find to work on it before the next merge window opens.

It's pretty obvious reporting-issues in a lot of way is quite different
from reporting-bugs, so describing the differences would be hard and
likely not worth it. But there are a few things hidden in the details
I'd like to bring attention to, to ensure they are fine for everyone:

- the old text (reporting-bugs.rst) took a totally different approach to
bugzilla.kernel.org, as it mentions it as the place to file issue for
people that don't known how to contact the appropriate people; the new
text (reporting-issues) explains how to decode the MAINTAINERS file and
mentions out bugtracker rarely, because it isn't working that well (but
nevertheless is useful); those places that mentions it explain that it's
often the wrong place to report an issue.

- the new text tells users to always CC LKML on reports

- the new text tells people pretty directly (and early on!) they will
have to install a vanilla mainline kernel along the way (stable is
mentioned as an option, longterm discouraged); but it also states some
maintainers are willing to accept reports from distro kernels as long as
they are quite close to vanilla mainline or stable.

- the text doesn't yet mention the new 'linux-regressions' mailing list
that was basically agreed on a few days ago
(https://lore.kernel.org/lkml/CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com/
), as I haven't asked yet for its creation. Will do so soon.

Hope that's okay for everybody. Ohh, and I hope it was okay to CC
ksummit-discuss, as that's afaics the best way to reach all the
important people and maintainers (sometimes I wonder if we should have a
better list for this). And it's IMHO on topic anyway as creating this
text was among the things we discussed on the maintainers summit 2017.

BTW, is anyone wonders how the text looks processed, see
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
– but remember, in a few areas it looks a bit different as it's missing
the patches already in docs-next.

Ohh, and yes, the text is quite long. But if you dislike that, please
keep in mind that nobody has to read all of it from top to bottom: the
TLDR and the step-by-step guide basically state all the important bits;
the reference section explains each of the steps in more detail for
those that need more details or just want to look something up.

So, let the final(?) review begin!

Ciao, Thorsten
