Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847703F7B45
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbhHYRMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhHYRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:12:42 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D6C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:11:56 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id n1-20020a4ac7010000b0290262f3c22a63so22024ooq.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqpdMi6hO9sy30ttbNbhBiDZr61Z2YSjCeBA2+p4Zyg=;
        b=PhvdOsPdUqsttKkL0Er1O0q/vt5zs9xr4tg3t8NRacZQRq8HaGmXwsyqw5SKtTD/og
         0wdWiW6CsORl2aJEDwwrjbCFYACsL6NPYRX/SixX0lGCuQiqwusRZVYSIUjqAALxOIIu
         Es1LXLki8lTzat1YzXJVqvB6e2sNXzfpKxtQ93oLQpC5gFtNMOtQCtbNE05A+cDX96kR
         oPocCyYTOtgbV2BTlU7IWAsWMR8sH8iw7YRKEWOSQk+iHiChedCYf77NaiZNYw5vy0YQ
         brDPvF8uq43xmNsxMvbpRNBzSrF96eMJBjL1cUOjZ3lq5Xe77q7pJwrgNx/nUhEZhkfT
         MmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqpdMi6hO9sy30ttbNbhBiDZr61Z2YSjCeBA2+p4Zyg=;
        b=ko/bjZtj7SA7I8A6Bl4HkcZLmTifxOws8VbwS4gcKvpLb/oMG7vkh7IbrkIJywKaOj
         hT1lhF63DKNYFdEs7huGP5FtKf9KDBkAfZ+LozQ/YRLhtrZsel5S5QBSFNzjcw6zcwII
         LL/enKSQKWAELjImuMt2uxz8MNGk/rpP5WQV+ACnfaLrzqDvo1aWzHmfx7srnYMM0FWl
         dHkCLTZaA1Kmk6vzsfHW8UZcbCpAc5nXdIFfS6fwI+Gx5dW1bfFAjP8Vpz9oT5XG9zvB
         rDQOQimMW2h0AZkDPu1NdVLu0h8gYfBj7NnXhen0sgP33OXRom6AwOoI5jtpDZZuRR8i
         mF/Q==
X-Gm-Message-State: AOAM533WFiZ2Spbf7dW8YxcCQFJmVL29orZ97QqvdasBR1/1rpAoh+ai
        HV5LvNVlWUio3C7Wb5jQ4ui4WErYnSZTjzAqRQhc/g==
X-Google-Smtp-Source: ABdhPJw/OLl5o4SwqXbUietzhznnRe+9OjRZAeOIbIOzhxBz2BRu5pQ3fbeYcd5QW+92TvcoO5/bH5JMHQhgeBAfYPo=
X-Received: by 2002:a4a:d40a:: with SMTP id n10mr35067991oos.32.1629911515747;
 Wed, 25 Aug 2021 10:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
 <202108251911.Vwmzl4rI-lkp@intel.com> <9743e1ee-75f4-6231-427b-8c7f659fb252@gmail.com>
 <20210825125159.GU1931@kadam> <bd50c00e-1814-dc32-36cf-73cf58123201@gmail.com>
 <20210825133432.GW1931@kadam> <c982eea8-3b16-656b-dcb3-1b6e0d3e995d@gmail.com>
In-Reply-To: <c982eea8-3b16-656b-dcb3-1b6e0d3e995d@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 10:11:45 -0700
Message-ID: <CAKwvOdn61==-pLs6oDUjeCD7DQvWjRx+b+04JMpN8w9kY9P-uQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of rtw_read8
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel test robot <lkp@intel.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 6:44 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On 8/25/21 4:34 PM, Dan Carpenter wrote:
> > On Wed, Aug 25, 2021 at 04:02:26PM +0300, Pavel Skripkin wrote:
> >> > This is not related to your patch.  Ignore it.
> >> >
> >> >
> >> > > > vim +2022 drivers/staging/r8188eu/hal/usb_halinit.c
> >> > > >
> >> > >
> >> > > >    2020                case HW_VAR_BCN_VALID:
> >> > > >    2021                        /* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
> >> > > > > 2022                         u8 tmp;
> >> > >
> >> > > Hm, I don't know anything about ARM compilers, so should I wrap this code
> >> > > block with {}?
> >> >
> >> > Yep.
> >> >
> >> > >
> >> > > My local gcc 11.1.1 (x86_64) does not produce any warnings/errors
> >> > >
> >> >
> >> > You should figure out whats up with that because it shouldn't compile
> >> > with the gcc options that the kernel uses.
> >> >
> >>
> >> AFAIK, at least 2 guys except me in this CC list compiled my series without
> >> errors/warnings. Maybe, staging tree is missing some Makefile updates?
> >>
> >>
> >> I'll resend series this evening anyway, but this is strange....
> >
> > Hm...  In my version of GCC the error is:
> >
> > drivers/staging/r8188eu/hal/usb_halinit.c:1870:3: error: a label can only be part of a statement and a declaration is not a statement
> >
> > That's a different error from what I was expecting.  It's caused by
> > having a declaration directly after a case statement.  The warning that
> > I was expecting was from -Wdeclaration-after-statement and it looks
> > like this:
> >
> > warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> >
> > You really should try investigate why this compiles for you because
> > something is going wrong.  It should not build without a warning.
> >
>
> Looks like it's bug in gcc 11.1.1. I've rebuilt this module with gcc 10
> (gcc-10 (SUSE Linux) 10.3.1 20210707 [revision
> 048117e16c77f82598fca9af585500572d46ad73]) and build fails with error
> described above
>
>
> My default gcc is
>
> gcc (SUSE Linux) 11.1.1 20210721 [revision
> 076930b9690ac3564638636f6b13bbb6bc608aea]
>
>
> Any idea? :)

The original report said the build was with clang-14, which is near
top of tree and unreleased. It's possible that that build had a bug
that hopefully was reverted.

-- 
Thanks,
~Nick Desaulniers
