Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F2E36883D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbhDVUvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:51:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50192 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236851AbhDVUvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:51:13 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13MKm4pR001839
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 16:48:04 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3C1D015C3B0D; Thu, 22 Apr 2021 16:48:04 -0400 (EDT)
Date:   Thu, 22 Apr 2021 16:48:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <jikos@kernel.org>, Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <YIHhBNp38vgpkuW+@mit.edu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421180155.GA2287172@nvidia.com>
 <18edc472a95f1d4efe3ef40cc9b8d2611d4ab990.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18edc472a95f1d4efe3ef40cc9b8d2611d4ab990.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:53:12PM -0400, Doug Ledford wrote:
> I have to agree with Jason.  This seems like trying to push a thumbtack
> into a bulletin board using a pyle driver.  Unless the researchers are
> lying (which I've not seen a clear indication of), the 190 patches you
> have selected here are nothing more than collateral damage while you are
> completely missing the supposed patch submission addresses from which
> the malicious patches were sent!

The 190 reverts are going through the standard review process.  Quite
a few of those patches are getting a "this looks good, please don't
revert".  And these reverts aren't going to be going in for 5.12, but
rather for the next merge window.  So we have plenty of time to review
them and either (a) drop the revert, or (b) if it does get reverted,
we can always re-apply it after it gets proper review.

Given that some of the 190 patches have been found to contain bugs,
regardless of whether they were submitted in good faith or not, it may
be that some of these buggy patches may point out opportunities for us
to improve our patch review processes.  So as a random sampling of
"trivial" (or maybe not-so-trivial) patches sent from a university
since 2018, doing a more careful patch review is precisely a way to,
as you put it:

> harden the maintenance process against these sorts of things.

> This all really sounds like a knee-jerk reaction to thier posting.  I
> have to say, I think it's the wrong reaction to have.  Remember, these
> guys are the ones explaining how things can be done and exposing the
> tricks.  That puts them in the white-hat hacker camp, not the black-hat
> hacker camp.

The idea of turning some students loose on trying to get evil patches
past some kernel maintainers that had worried me didn't appear to be
doing adequate review is something that had crossed my mind over 10 or
15 years ago.  I just didn't do it because, (a) the obvious ethics
concerns, and (b) it wouldn't actually tell us anything new.

Also, even the assistant department head of the UMN CS department has
admitted that this was clearly an IRB failure, and that what they did
was clearly Human Subject Research that should have been stopped cold
at the "get permission from the IRB" stage.  So that puts them in the
gray-hat category at best.

> You shouldn't be banning them, you should be listening to
> them and seeing if they found any constructive ways to improve and
> harden the maintenance process against these sorts of things.

Well, the paper is available.  Aside from the obvious, "be more
careful with code reviews", they had the advice of adding to our Code
of Conduct, "don't do this unethical thing we just did".  Which might
or might not work in terms of preventing academics who submitted
patches in bad faith, but I very much would prevent someone working
for the Ministry of State Security.

So you could consider doing an in-depth review of the patches sent
from umn.edu to be a step towards doing more careful review.  Let's
see what we learn from that analysis.

						- Ted
