Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFBA38DFD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 05:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhEXDVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 23:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhEXDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 23:21:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 20:20:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f18so9300471ejq.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 20:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UV+IIiaESw5plOu1kB4kNiRQoDlm7XC16kel3ldThc=;
        b=t4ZF0pX91tbZPTG4a3RsnCUsR867kJhIsRLFK2FJvhqbrXneRMEuVHJKslabXH8ejX
         PB90Q3oadFOPaqrZNJCBOivSFJiKvRT72yty1H8/o2Z5Y0sGOPzVHtQ2pVVzPWFYZnri
         eko5ylTi32YLWCvWC3mtP1LMWFXUzC8Q6EtJtW4jl4ys26bhMIbBDOnshPR8L4vEAZww
         zqzDqvNIbRJ059UvvScw40Cy3efBzmejnA32TDgnm/OEgSBQbfJ++XvV4cPBK8To92SU
         lVtet/excg0XP/P5C4dg4Dws3TMZf0A9IX3Mq/KWsXoshd2x9q6nL/W45yF9Ok2UeayA
         lXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UV+IIiaESw5plOu1kB4kNiRQoDlm7XC16kel3ldThc=;
        b=cTNQOnIQkZjF0AU6vmlqvSv6N987NrVVkt13ZqnVgbF8A0ZsVrb3cLHVUmPDSaLDVv
         agSYbg4yMHU2N2zDmml5SoR48tIE36IcDs2rZrOFyswthMRC/XLho8hICaxdWnlzKtNH
         N3L58M+bU1eAeoE3juL2uiilb7LnxjugoXM9c4kdw7FW1+MSAZu8D6Ti0aqzu+t0t0Ew
         i9gdFRowDjXO8YfEsR0hSe8kWcYGz/1M5cXosrBM1Xy1uErdnJJ/4iYo3TMgtc20lssT
         V+h0A+0hohL+n+SCwF5YHKmDZMbZJyawVGA3cXI8JQGq4PORkl+yp1s9mZfwxhzxFug6
         H+sg==
X-Gm-Message-State: AOAM531l7fDWcZD+UE/+n7hknLf9JpTc+GGQbcQYnlKLuPxNrT7O/EUN
        cAfnjRLQdgW5LYsMaPRw3CVrtp5Icxf0Q6VTC+MLDHFxPsMDZg==
X-Google-Smtp-Source: ABdhPJxSO6yeIC0VFxiyHU8Q5cmEiF0vtZyk4fopXUN0/UTJvOUzfGpEs7UI4BzBgrcLzpjnfEaXYNmFUfMszv4G7zM=
X-Received: by 2002:a17:906:1e15:: with SMTP id g21mr20998448ejj.241.1621826410849;
 Sun, 23 May 2021 20:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7=BFoktwgy=T0GK6Mpmp2gYToCUs=CrM29MRWw8O7TPypQ8w@mail.gmail.com>
 <CAHp75Vf8kQ73w0R9ieDNjDVkxM-V83QRN9mc6BjRZA8xHpPNAA@mail.gmail.com>
 <CAHp75Vft8pnA+m0C=Ok7nRyjERAd2uJJ4q6HcN460j0Hir6Kaw@mail.gmail.com>
 <CAM7=BFoH7Q+YHvPFnHM4j72ORHQp4gTjHFjnfeLsV2-30ZLNYw@mail.gmail.com>
 <CA+7tXigG7QVYOtkuFrqciHfuxE4+c0JM9z8r0e9rooTjjz5PYA@mail.gmail.com>
 <CAHp75VdeSkQSHjwTFObj84TyOOW2dh9LW3Ci9L7=iDFTbEvRoA@mail.gmail.com> <20210522190759.GA9755@basil.scara.com>
In-Reply-To: <20210522190759.GA9755@basil.scara.com>
From:   Trent Piepho <tpiepho@gmail.com>
Date:   Sun, 23 May 2021 20:20:00 -0700
Message-ID: <CA+7tXigHEwwnVqjD=Hi1HBCxrBfeuvieK8v=W4nvgsm+ipaLmQ@mail.gmail.com>
Subject: Re: A divide by zero bug in lib/math/rational.c (with triggering input)
To:     Oskar Schirmer <oskar@scara.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Yiyuan guo <yguoaz@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 12:08 PM Oskar Schirmer <oskar@scara.com> wrote:
> On Fri, May 21, 2021 at 12:53:27 +0300, Andy Shevchenko wrote:
> > On Fri, May 21, 2021 at 12:20 PM Trent Piepho <tpiepho@gmail.com> wrote:
> > > On Fri, May 21, 2021 at 12:55 AM Yiyuan guo <yguoaz@gmail.com> wrote:
>
> Sorry, it does not. E.g. with the given fraction of 31/1000
> and the registers restricted to 8 and 5 bits respectively, the
> proposed fixed function would still divide by zero, because
> n1 == 0. If it was for the division by d1, the test for !d1

Yes, values less than 1 less than the smallest allowed non-zero value
will divide by zero will finish on the 2nd iteration, with n1 == 0,
and divide by zero.

The finished patch I've since sent fixes this.

> Moreover, for a fraction of 33/1000, both the original and
> the latest version would produce 1/30, which is off by some
> 1.01%, but the proposed fixed version would result in 1/31,
> which is worse: 2.24% off.

Finished patch correctly produces 1/30 in this case.

> I think the original function was not so bad. And the code it
> produced was much shorter than the latest version, although
> this might not be an argument in times, where a simple OS
> kernel is beyond the 40MB.

I measured this.  I've compared the original, which did not consider
semi-convergents nor out of range values, the current version, which
does semi-convergents but fails on out of range, and the patched
version, which handles that too.

Size in bytes:
X64 149 205 278
ARM 164 220 300

So 129 bytes on x64 and 136 bytes on ARM.  Not all that much.  I
didn't try writing a special check for large/small inputs in the older
code to see how large that was, for a more like-to-like comparison to
my latest patch.
