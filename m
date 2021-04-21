Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE28C366E04
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbhDUOWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239469AbhDUOWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:22:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B2C56144B;
        Wed, 21 Apr 2021 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619014903;
        bh=0yQMyhTCkuHUWiu3K9JKpgRYqS7WFDiWp7NRJBSSbss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvG9Xpu8PBUmRDqa1lzjIxlFY2yDe40q8GKSMUKEmi+I1R6kdryA9fetViiGpE3xx
         hKUeoIbhZwfw8aOx/d+VxTfI7HOJzbAhPj7MUs9YGwp/Dipi7W1rAky5SVr5qQkt2z
         ypss8BmHMVfkJzW0diTtSXoKizCDsQsQNn5wxSgc=
Date:   Wed, 21 Apr 2021 16:21:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <YIA09UyI0y6fcb94@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <4afeeb49-620d-5a9d-29fc-453f6118a944@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4afeeb49-620d-5a9d-29fc-453f6118a944@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:56:49AM -0700, Guenter Roeck wrote:
> On 4/21/21 5:57 AM, Greg Kroah-Hartman wrote:
> > I have been meaning to do this for a while, but recent events have
> > finally forced me to do so.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> 
> Sigh. As if this wouldn't be a problem everywhere.
> 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > This patchset has the "easy" reverts, there are 68 remaining ones that
> > need to be manually reviewed.  Some of them are not able to be reverted
> > as they already have been reverted, or fixed up with follow-on patches
> > as they were determined to be invalid.  Proof that these submissions
> > were almost universally wrong.
> > 
> > I will be working with some other kernel developers to determine if any
> > of these reverts were actually valid changes, were actually valid, and
> > if so, will resubmit them properly later.  For now, it's better to be
> > safe.
> > 
> > I'll take this through my tree, so no need for any maintainer to worry
> > about this, but they should be aware that future submissions from anyone
> > with a umn.edu address should be by default-rejected unless otherwise
> > determined to actually be a valid fix (i.e. they provide proof and you
> > can verify it, but really, why waste your time doing that extra work?)
> > 
> > thanks,
> > 
> > greg k-h
> > 
> [ ... ]
> >   Revert "hwmon: (lm80) fix a missing check of bus read in lm80 probe"
> 
> I see
> 
> 9aa3aa15f4c2 hwmon: (lm80) fix a missing check of bus read in lm80 probe
> c9c63915519b hwmon: (lm80) fix a missing check of the status of SMBus read
> 
> The latter indeed introduced a problem which was later fixed with
> 
> 07bd14ccc304 hwmon: (lm80) Fix missing unlock on error in set_fan_div()
> 
> I guess that was part of the experiment. I don't see a problem with the
> patch that is being reverted, but it is not extremely valuable either,
> so I don't mind the revert. It is not valuable enough to re-apply it later
> either.
> 
> FWIW, I didn't see the problem with the second patch even when re-reviewing
> it, which makes me suspect that they introduced missing-unlock problems on
> purpose. It is important to keep that in mind when re-reviewing the patches.
> Also, it may be part of the pattern that they introduced one or more valid
> patches followed by a malicious one into the same subsystem on purpose.

Thanks for the review of these, much appreciated.

greg k-h
