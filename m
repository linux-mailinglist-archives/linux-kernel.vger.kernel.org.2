Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9B2368703
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhDVTRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVTRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:17:00 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A848C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:16:24 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZeo6-007SQT-MK; Thu, 22 Apr 2021 19:16:10 +0000
Date:   Thu, 22 Apr 2021 19:16:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
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
Message-ID: <YIHLenGduv592lpv@zeniv-ca.linux.org.uk>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421180155.GA2287172@nvidia.com>
 <18edc472a95f1d4efe3ef40cc9b8d2611d4ab990.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18edc472a95f1d4efe3ef40cc9b8d2611d4ab990.camel@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:53:12PM -0400, Doug Ledford wrote:

> This all really sounds like a knee-jerk reaction to thier posting.  I
> have to say, I think it's the wrong reaction to have.

Agreed, however...

> Remember, these
> guys are the ones explaining how things can be done and exposing the
> tricks.

... these guys are the one who provide summarized stats (as opposed to
the raw data and experimental protocol) illustrating their thesis,
along with some advocacy towards their prefered "solutions".

> That puts them in the white-hat hacker camp, not the black-hat
> hacker camp.  You shouldn't be banning them, you should be listening to
> them and seeing if they found any constructive ways to improve and
> harden the maintenance process against these sorts of things.

I'm sorry, but what they are doing is no science - it's advocacy.
The data would certainly be useful - how the submission attempts
went, what correlated with successful ones - timing relative to -rc,
lists involved, etc.; I can think of a bunch of possible factors,
but there's no way to test any of that against their data.
Examining the threads around individual submissions would also be
interesting and might bring useful information.  Except that we
can't do that, since they have not even bothered to publish the
list of SHA1 of commits they got in, nevermind the Message-Id of
the relevant emails.

I don't like the circus with blanket reverts either, for a lot
of reasons.  And ethics questions aside, their raw data might
very well be worth looking into, but as for the trust in their
conclusions... I've seen xenobiology papers done better than
that.
