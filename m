Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42D9330B06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhCHKW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhCHKWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:22:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B53C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 02:22:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id kx1so2756810pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 02:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYIHvck8Wqs9hpNy/KAZ+iWG7AzyxCt+S8U+aZRsEuA=;
        b=jLy49ffwvy9I8Kiiej4yQBBWan23Hi+xkGjNBQa6L1XqbNoDVg/LKj4/GblTgggzLQ
         SyyLsI/MTr/0fy9JyW1uM4BovONFNOrSI+TVY4oiEHjTycPSPaWDcQIFJrsKQ1OBQQcc
         UxvSPa1DQG+kgIPUFv2pttYXIkyqwYsbn8nh7SA21+rGv9qhzjySQsZ97f9T1qyFlcw9
         QydkzEISbGAXJZGlGeOfk3OuvUvRGo9CCGtZoDsQytmEMpiRwcupTNZC+/2Dom82GDi5
         zGO1KlPgvljakxaSAtddLw8wuVJVTOMMZ6D/+ffqmLSLZNmYLHvaM17/d3zU9WiEhrGW
         RILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYIHvck8Wqs9hpNy/KAZ+iWG7AzyxCt+S8U+aZRsEuA=;
        b=mJXG081KZC5ja1eXY4DhoyakQhEs1W+/TCot3es9SqmboRy/eRxv7Q8ZS332k6bLrp
         Ts+GPIchn4MvX43kW+kQJiLqMGq82jX7bgLPt+uGgPX3ldpN+cDlQ4UxC68DVnLJPK+Y
         KUEtMz3fVGIQ2jXOPc6l1DnhgpJSIisA0oa7a1jGcc8teY4wFi0aCnQ+GmAgsOzdYXn5
         XMFXCt9+WhV4223gte0i0vU1jE5GYfuTHYyPh7oAgNNdSLdYiFDOWZvFBDs7o1WQKFDM
         HZeZ5ImDgY9wQxoC+YoBf7MWYLNOTOf+KRQRz4pMF0Tk8tL0Q2eWUEM5RhRdoe0KFIxs
         csEA==
X-Gm-Message-State: AOAM532bpl2lIDwhO7Vi2xRhX8HGstXHJmTFkjRkAWk9gz3lCcnCrUIM
        c6+nB6Qs3YesrVLRiRK7Yp9K/NV+IpG3ykCkXio=
X-Google-Smtp-Source: ABdhPJz4KmtkGs7piNazFBXXEYHkh7rjv7GAFUadt9SRlU/al2zZQGdUXaT1k/1yw0T9wdXnaqbPavhN/wj7V3KVXm0=
X-Received: by 2002:a17:902:d2c1:b029:e5:ccfe:1e93 with SMTP id
 n1-20020a170902d2c1b02900e5ccfe1e93mr20309142plc.0.1615198970648; Mon, 08 Mar
 2021 02:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20210305183948.37738-1-andriy.shevchenko@linux.intel.com>
 <20210305221951.GC2896@zn.tnic> <CAHp75VdoGShdAQFkx5PR-H6=csRA_ReaerDg6iy54AMJF+kaOg@mail.gmail.com>
 <20210308101719.GA12818@zn.tnic>
In-Reply-To: <20210308101719.GA12818@zn.tnic>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Mar 2021 12:22:34 +0200
Message-ID: <CAHp75Vc=AvArhekQSufNA+0OsxnsQikmignNt7=+h_t5=Ks_6Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] scripts/decodecode: Decode 32-bit code correctly
 on x86_64
To:     Borislav Petkov <bp@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 12:17 PM Borislav Petkov <bp@suse.de> wrote:
>
> On Mon, Mar 08, 2021 at 11:59:34AM +0200, Andy Shevchenko wrote:
> > It works, but... The question here is why the script behaviour depends
> > so much on the architecture in question (by environment). ARM stuff is
> > using traditional ARCH (and that's what I have expected to work),
> > while x86 has a set of other variables.
> > So, I have to rephrase the commit message then and do actually an
> > alias when ARCH is set in a certain way, Would it be better?
>
> No, I have no clue what you're trying to accomplish. You wanted to
> supply ARCH when decoding a 32-bit oops because you expected ARCH to
> work...?

Yes.

> AFLAGS has always been there, ARM folks added ARCH AFAIR. Also, you need
> AFLAGS to compile the snippet in the correct bitsize.
>
> And there's a usage note at the beginning of the script and I always
> read it to make sure I'm using it right.
>
> So what's the problem again?

Inconsistency.
For the ARM we have to provide ARCH, for x86 a variety of all the flags.

-- 
With Best Regards,
Andy Shevchenko
