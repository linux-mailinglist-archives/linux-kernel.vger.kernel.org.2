Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20404366E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243593AbhDUOdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243227AbhDUOdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:33:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5061B61448;
        Wed, 21 Apr 2021 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619015571;
        bh=dd3HvJVPIBFjv8CRf9O08UUhpaw3gLM9+mwfLrJFx9I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=O+eKtFL+OKhMOqDGQAgHQt8v2ijekLfH10jbVwVfIrQPb9/ig3Q5wlBSjV/l05IV8
         R1C2FriS9EtFBMzyZjB+S2971HoCGrn2+AtkSQdKng4mjTY1j0R+SAiACW0KKyl6Go
         SfejY5cmAyHBN0ynVYCaE7B8cOCyDCsPdBPWKnlqldeBX65FHGZcFQzUyZCvhw6C/H
         3MbeiFA7beIbouBU43WIroHVnu4quJfOGhz9hOhlwhRuw2wWwa5u4titNA3ZuK2bFt
         LMMBgG3n5nmuKoARguerWdkwW3614RGFMnrZIcRdQ2vd6BM37qnXCjvRV6qFuPaqLv
         YA08ueol+sKzw==
Date:   Wed, 21 Apr 2021 16:32:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
In-Reply-To: <4afeeb49-620d-5a9d-29fc-453f6118a944@roeck-us.net>
Message-ID: <nycvar.YFH.7.76.2104211628560.18270@cbobk.fhfr.pm>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <4afeeb49-620d-5a9d-29fc-453f6118a944@roeck-us.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021, Guenter Roeck wrote:

> > Commits from @umn.edu addresses have been found to be submitted in 
> > "bad faith" to try to test the kernel community's ability to review 
> > "known malicious" changes.  The result of these submissions can be 
> > found in a paper published at the 42nd IEEE Symposium on Security and 
> > Privacy entitled, "Open Source Insecurity: Stealthily Introducing 
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu 
> > (University of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Sigh. As if this wouldn't be a problem everywhere.

Right.

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

Therefore I'd like to ask Kangjie Lu (who is CCed here) to consider 
revising his statement in the attempted public clarification:

	"The experiment did not introduce any bug or bug-introducing commit into 
	 OSS."

at [1] as it's clearly not true. Missing mutex unlock clearky is a bug 
introduced by this experiment.

[1] https://www-users.cs.umn.edu/~kjlu/

Thanks,

-- 
Jiri Kosina
SUSE Labs

