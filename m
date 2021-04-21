Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C471D366EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbhDUPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:16:48 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57332 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbhDUPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:16:47 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 896DF4AE;
        Wed, 21 Apr 2021 17:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1619018171;
        bh=TAunVkjVto0RThnQ/DWnbsC41TzzzfFJt7SWrqC9jhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXwpnus3C2WCoiV5Cexo5HruEmWFO1Oasm3fNykS//URnqUv9jdCb46eIOa80AT5j
         awe5BMTth9Ejn/g02auw2h6RTwk9k2VX56YJ9kBWjQA+TGIxGsMEXOtonzyt4x4icw
         Tayl64CB1m5fth69j6vZ71jsA+yhYHhM8J2m65Ew=
Date:   Wed, 21 Apr 2021 18:16:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Jiri Kosina <jikos@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Qiushi Wu <wu000273@umn.edu>,
        x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Will Deacon <will@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <YIBBt6ypFtT+i994@pendragon.ideasonboard.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <4afeeb49-620d-5a9d-29fc-453f6118a944@roeck-us.net>
 <nycvar.YFH.7.76.2104211628560.18270@cbobk.fhfr.pm>
 <CAK8KejoGgoWcEUm7gnTw+_5CuZX1+bnHoeY0Ea-pAO+gd8dbcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8KejoGgoWcEUm7gnTw+_5CuZX1+bnHoeY0Ea-pAO+gd8dbcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

On Wed, Apr 21, 2021 at 09:44:52AM -0500, Kangjie Lu wrote:
> On Wed, Apr 21, 2021 at 9:32 AM Jiri Kosina wrote:
> > On Wed, 21 Apr 2021, Guenter Roeck wrote:
> > > > Commits from @umn.edu addresses have been found to be submitted in
> > > > "bad faith" to try to test the kernel community's ability to review
> > > > "known malicious" changes.  The result of these submissions can be
> > > > found in a paper published at the 42nd IEEE Symposium on Security and
> > > > Privacy entitled, "Open Source Insecurity: Stealthily Introducing
> > > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu
> > > > (University of Minnesota) and Kangjie Lu (University of Minnesota).
> > >
> > > Sigh. As if this wouldn't be a problem everywhere.
> >
> > Right.
> >
> > > > Because of this, all submissions from this group must be reverted from
> > > > the kernel tree and will need to be re-reviewed again to determine if
> > > > they actually are a valid fix.  Until that work is complete, remove this
> > > > change to ensure that no problems are being introduced into the
> > > > codebase.
> > > >
> > > > This patchset has the "easy" reverts, there are 68 remaining ones that
> > > > need to be manually reviewed.  Some of them are not able to be reverted
> > > > as they already have been reverted, or fixed up with follow-on patches
> > > > as they were determined to be invalid.  Proof that these submissions
> > > > were almost universally wrong.
> > > >
> > > > I will be working with some other kernel developers to determine if any
> > > > of these reverts were actually valid changes, were actually valid, and
> > > > if so, will resubmit them properly later.  For now, it's better to be
> > > > safe.
> > > >
> > > > I'll take this through my tree, so no need for any maintainer to worry
> > > > about this, but they should be aware that future submissions from anyone
> > > > with a umn.edu address should be by default-rejected unless otherwise
> > > > determined to actually be a valid fix (i.e. they provide proof and you
> > > > can verify it, but really, why waste your time doing that extra work?)
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > >
> > > [ ... ]
> > > >   Revert "hwmon: (lm80) fix a missing check of bus read in lm80 probe"
> > >
> > > I see
> > >
> > > 9aa3aa15f4c2 hwmon: (lm80) fix a missing check of bus read in lm80 probe
> > > c9c63915519b hwmon: (lm80) fix a missing check of the status of SMBus read
> > >
> > > The latter indeed introduced a problem which was later fixed with
> >
> > Therefore I'd like to ask Kangjie Lu (who is CCed here) to consider
> > revising his statement in the attempted public clarification:
> >
> >         "The experiment did not introduce any bug or bug-introducing commit into
> >          OSS."
> >
> > at [1] as it's clearly not true. Missing mutex unlock clearky is a bug
> > introduced by this experiment.
> 
> Hi everyone,
> 
> I am so sorry for the concerns. I fully understand why the community is
> angry. Please allow me to have a very quick response, as Jiri requested. We
> will provide a detailed explanation later.
> 
> These are two different projects. The one published at IEEE S&P 2021 has
> completely finished in November 2020. My student Aditya is working on a new
> project that is to find bugs introduced by bad patches. Please do not link
> these two projects together.  I am sorry that his new patches are not
> correct either. He did not intentionally make the mistake.

Do you have a list of all known bad commits ? Not that we shouldn't
revert the other ones as well, but having a list of bad ones would be
useful when reviewing commits individually to see which ones may
actually be correct.

> > [1] https://www-users.cs.umn.edu/~kjlu/

-- 
Regards,

Laurent Pinchart
