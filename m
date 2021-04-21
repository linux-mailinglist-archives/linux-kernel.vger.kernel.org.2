Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94B1366F70
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244096AbhDUPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbhDUPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:50:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D4EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:49:53 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n140so42819732oig.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=26XHvJ6qLyygq07cg9UNyTuC4V7eJhvVKq79hVkxLwg=;
        b=IL44mP5jzHfCkM9PiwXl1yPUTR8pL/ZaUxNRwN36uzPo/HfPOgSS8qH4zNin7lIk5B
         dqRBItpizXyySSD7lL6sBHL0rSNlZBl/BInCxWJdmlUx2NwLhWWCLjE1hQUHWWr42iV3
         vBGA3LQsVKI4GE4+SoaV1B4y+HwUBjv4722ZiTXPHQ08A6Zjvu2MaVpMRfOtRfNJyEqW
         BufZKikq+WF1fnFQa22LdIbGt71u31LfEbAMXvSfDmwIXQFhw6MofOIDi6IQ5RsTsr0b
         eahb9ExrZsY/BG8Dibx0mpI929AzL8vIHreqO/6mHwju5yP4nWYLONzA2ZHJYeR8gHv0
         eq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=26XHvJ6qLyygq07cg9UNyTuC4V7eJhvVKq79hVkxLwg=;
        b=fPTLXz9f7PduTpTaTNJBD6WSWbWhYXv0kmqvhA7sfAgPZPge4UVZDLUAK7JWJPnrkq
         rgqNBHPg/sfufeQrgTgZtEwpaXVjvoSGZrmFe6aRpoyFMXUI+Rii+QfGjJtj+p6xnpNI
         LyWvTUVjIFtRNGuQY9ECpbbBEqzD754dV+uiSLnh/OGK9GxgE9UJdCEpMv//IeUq/3CP
         JGmOcmKE9YxFGuI3jGshIwC008MwiQJphEulJqT16Dy/Gp1Q5vhRB7dKSPht8d9s/rF6
         eQDaue913Ult0GTeSMa6SiY/+fLeLPp8cphReOlD72decBi4MnZw7b5Uw+nJCgIO0IsG
         Vngg==
X-Gm-Message-State: AOAM531HFx89tJqY4GPFXNvUwn36t8d9bEdy5ajqmdVREHHna79h5rDI
        1XkyGQxpInoM4VYC4bHjZig=
X-Google-Smtp-Source: ABdhPJwYxn9GthH0/clqo8YsybirRh0O1a6Zb2z37TNOSkWpEqmDtSukriC1+V3+0gkBdgY1zoH2kw==
X-Received: by 2002:a05:6808:68e:: with SMTP id k14mr7187354oig.175.1619020192248;
        Wed, 21 Apr 2021 08:49:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2sm605887otl.48.2021.04.21.08.49.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Apr 2021 08:49:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Apr 2021 08:49:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Jiri Kosina <jikos@kernel.org>,
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <20210421154949.GA168854@roeck-us.net>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <4afeeb49-620d-5a9d-29fc-453f6118a944@roeck-us.net>
 <nycvar.YFH.7.76.2104211628560.18270@cbobk.fhfr.pm>
 <CAK8KejoGgoWcEUm7gnTw+_5CuZX1+bnHoeY0Ea-pAO+gd8dbcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8KejoGgoWcEUm7gnTw+_5CuZX1+bnHoeY0Ea-pAO+gd8dbcg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:44:52AM -0500, Kangjie Lu wrote:
> On Wed, Apr 21, 2021 at 9:32 AM Jiri Kosina <jikos@kernel.org> wrote:
> 
> > On Wed, 21 Apr 2021, Guenter Roeck wrote:
> >
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
> > > > they actually are a valid fix.  Until that work is complete, remove
> > this
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
> > > > about this, but they should be aware that future submissions from
> > anyone
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
> > > c9c63915519b hwmon: (lm80) fix a missing check of the status of SMBus
> > read
> > >
> > > The latter indeed introduced a problem which was later fixed with
> >
> > Therefore I'd like to ask Kangjie Lu (who is CCed here) to consider
> > revising his statement in the attempted public clarification:
> >
> >         "The experiment did not introduce any bug or bug-introducing
> > commit into
> >          OSS."
> >
> > at [1] as it's clearly not true. Missing mutex unlock clearky is a bug
> > introduced by this experiment.
> >
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
> 

The author of commit c9c63915519b is Kangjie Lu <kjlu@umn.edu>, not some
student, and I have to assume that it intentionally introduced a problem.
That was the whole point of the exercise, wasn't it ?
As mentioned by Jiri, the statement "The experiment did not introduce
any bug or bug-introducing commit into OSS" is obviously wrong. It is
a lie, to say it directly.

I absolutely agree with Greg's assertion: All patches introduced from
the umn.edu domain can not be trusted and should be reverted.

It might be worthwhile to have a discussion at the upcoming maintainers
summit on how to handle contributions from untrusted sources in the
future, and how to identify trusted contributors. Quite obviously the
paradigm has finally changed from "assume the contribution is
well-intended" to "assume the contribution is malicious". I guess that
was prone to happen, but it is sad to experience it anyway.

For my part, congratulations (in a negative sense): You made me much less
inclined to accept minor bug fixes from people I don't know in the future.

Guenter
