Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4921D44D55B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 11:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhKKK62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhKKK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:58:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539DFC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 02:55:38 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i12so3848522wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 02:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpugqKF0NXYCQnpiV9FuWTWK1rzKK3N+/XfyNs4VIPc=;
        b=VlHya6G7pptLSYhQzhJHY/CN9V6xpe2hEg0GqkO4t5rmi+nVotlReIE61R6MMgGXlL
         MSjkSkV+owPBHgIHkkMYH2Gu9T4LCi67algVKqjPWIxC7Sl6EOFApOL67EYKk71hT2Wj
         s8aOnbj/u4hHUdH0j4X3RAU9BlJuedCW2IvqSZ32RlCzXrKc4Z9BGMmGCIe5XddZ0pMY
         rm8zPFCldIBbRUFWR73jlmbH9yzwA1HnhfIJ1bmCuVrMKwH6WgLdRrJAhhnAwkf6U0aY
         HjaPSs1tfwpsejq7KlaIhzb//ALxCu9Wlbsif1ozOVBMxdE1HR+k/Of6bCniBBDmgzlz
         AgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpugqKF0NXYCQnpiV9FuWTWK1rzKK3N+/XfyNs4VIPc=;
        b=hEA5D+t7aYQBOBPyFj9bZXuwwMcTYcr0ew9fhsh8E2ogp4fMq1tfIcRW93Yea6HWWt
         6/eE3VbwU8rYzfQbJw0diTN0pq8HP27Q09yIbfXzRyzNQ5NkD1AQkRyOWDf9d9/PCpOs
         iN23owunErIQGoHxu8bwecPKoOC1rpFWRiFhQBKrJgDqgbEoBpBTnG9JYMCRC048Kg7h
         E9hkVgBh26bwX9rIXw2wZAWZZs1NKs/DAtpXan6ZrewBxs3tP4TVRpyx5QSr1obC1NTO
         iFSjcEMGryJnkLNqLqzM3IRh3JuEhIokdHkNW90WCp95veXMMHy+y1i7qwIin4e3N7nc
         EV1g==
X-Gm-Message-State: AOAM533TO4xrJ61Y8GUMXIG0p13n05ym4n/GXkOCMYQOvX4u1nj/rD4G
        yR49vKMketJ3Er71FIU5DZI55f/2+k3LGEykYSl0zTsZjVE=
X-Google-Smtp-Source: ABdhPJyChilwfCHwBCCuuDFdQ7VQT9nqokT9fABmJcHu0tfoAR9HZl9eUvTtcuJ4fd+0zOKiSx7zwtYtg7uO/iF8ecg=
X-Received: by 2002:a1c:790d:: with SMTP id l13mr25011754wme.101.1636628136874;
 Thu, 11 Nov 2021 02:55:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
 <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna> <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna>
In-Reply-To: <YYzxWPIWFAV04LRU@lahna>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Thu, 11 Nov 2021 11:55:25 +0100
Message-ID: <CAHifhD4cmsTFc02xNMWnMA74qMQcWMjNoseV3uRjwpY2N9xJ1A@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Richard Hughes <hughsient@gmail.com>
Cc:     Mauro Lima <mauro.lima@eclypsium.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do., 11. Nov. 2021 um 11:33 Uhr schrieb Mika Westerberg
<mika.westerberg@linux.intel.com>:
>
> Hi,
>
> On Thu, Nov 11, 2021 at 09:59:32AM +0100, Hans-Gert Dahmen wrote:
> > > I think we discussed this previously already but in any case, instead of
> > > removing the tag from the "main" driver, we can make certain "safe"
> > > parts of the driver available without that tag. That would allow you to
> > > read the things the controller exposes and allow distros safely include
> > > the driver too. By "safe" parts, I mean the information available
> > > through the SPI flash controller without actually sending commands to
> > > the flash chip. I think this is the information everybody (on this
> > > thread at least) is interested in. Unless I'm mistaken - I did not check
> >
> > Yes you are mistaken. My patch is about safely reading the BIOS/UEFI
> > binary on every past and future x86_64 system. There are tools out
> > there that use the interface my patch uses and they can not work any
> > longer when /dev/mem is locked down with SecureBoot enabled. The
> > tools, like fwupd, should work out-of-the-box on the typical
> > distribution. During this discussion we were told that my patch is not
> > welcome and that we have to work with you to achieve the same. So I'm
> > curious to hear how that can be done.
>
> OK, I see from your patch that it uses the direct mapped read-only
> region to read this data.
>
> Do we know what information exactly fwupd needs?

I think Richard can tell us best and he should receive this mail.

> I mean exposing all of
> this might not be good idea from security perspective (but I'm not an
> expert)

There is no secret hidden in there and the binary is typically openly
shared by the vendor through update sites or mechanisms. Actually it
would be better from a security perspective to access all of it to be
able to compare it to the official versions and check it for malicious
modifications, which is becoming ever more relevant in the wake of
recent CVEs about supply-chain attacks. Doing so would be a possible
use beyond fwupd and I am specifically speaking about the open source
converged security suite by 9elements.

> However, we can perhaps expose some of it through intel-spi,
> and make that work so that distros can enable it safely.

That would really be great and I'd already like to thank you for being
open about going down this path. I think Mauro is willing to
collaborate on this front, correct me if I am wrong.

> My concern of
> removing the DANGEROUS tag is that we end up bricking yet another Lenovo
> laptop by accident. Avoiding that would give me more peace of mind :)

Yes of course, I think to not endanger users with malfunctions caused
by code we produce is of our mutual interest here and we should make
sure to be absolutely serious about it.

Hans-Gert
