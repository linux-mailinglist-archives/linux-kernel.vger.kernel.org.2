Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7843536461E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbhDSOar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhDSOan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:30:43 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFC6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:30:12 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v19-20020a0568300913b029028423b78c2dso24097482ott.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gj46eHqwGog6MM83EGWyn/d2gDw8gFPwgfxb+P24o6o=;
        b=lkjySsHHyCKy9V1I4ctG8Ub1AgpYKyAuzEzcSNEdD6DDIejJcaBrdvFQij3q1W6nkh
         ph3/QcpKP1doY1wwlSUTOL0ycAOL4E/i45ucmDsMszNr+VDpKTZdTAwGkRgdjJ4MFQZt
         Sy2J6LBcsk0shbd+V9/F055vcs32TuxuRm78E3BVgiFgv7oQ8brYvpy9cQyR3KQw2GKW
         YIcZuEUq6FO7ZvIWcmLQw/A/7mMFXXUY9s1blDA4b2iE2W4scxuIDudwarlynD8QuCSn
         /hbFjEeejeoK6D5kjnmwKPWGbXlRpyOFlHAZjdPFaUC5aqNgx07oVpzTUNGwbIkle7f7
         G+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gj46eHqwGog6MM83EGWyn/d2gDw8gFPwgfxb+P24o6o=;
        b=aQeMbqkY2iSmDQM6vuBjSHNkKMB1Fu8jviM4XgWWwUtI1osvUuh2BZgdBOSopVuCHK
         OlCNBfrpuDZsEvWaXAfEa+9nnt1HvxAQcXFDPjO5ZgA9oASCaAJnT4MKXRUhxMppwAd+
         h1YD+QWI+7EWYvHhQmCHPfWtdUWS9xkNU5JNxFt1wKRv2a9ooXMGmFSt3XNdJ8eodDe8
         KORqKn/u65JAhqzpAHbZhQmz9vhOF44xEO4KGTZ9u7Fp9Z5HjTrn8fasJLFrVpdGIVKe
         dzmZvd4Oh4YGqGDXJL4s6k/ev/rhiC1tbgn2OQAj5n2BeUgNXUhOYFU56qzzTceFKDX+
         8FIg==
X-Gm-Message-State: AOAM531JIgRy0P/oXSPMMJAopP5dNQagGQoRtcmy34IxY0WzPYwRANrx
        WHSbPEeN3rO3m0pw+r4yBjDiii2MTc9/kpepv8vUSw==
X-Google-Smtp-Source: ABdhPJwSYDy60sZm2oeM8mHFQBmtJjl37bNE4CpyjornHp8itMqA2mkUWPkd6ohCMFSwNCxs5Rt2QtE15JWk5o4IWbw=
X-Received: by 2002:a9d:5f8c:: with SMTP id g12mr2582275oti.283.1618842611531;
 Mon, 19 Apr 2021 07:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210415145857.34183-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44FWJiL1yzHR0jwL2VJG_4t_O6An48v47gORitcaahwmYw@mail.gmail.com>
 <YH1xHDbFyJ1URYYV@smile.fi.intel.com> <CAHUa44GqTNoLbwfqPrWFVLV3=M2d-2hE1uDY=CHpCcZgzMu5Og@mail.gmail.com>
 <CAHp75VeP9eXyrpuWpb9smuLUCBmocwfzA1p4NXPNyNfP0i3ngw@mail.gmail.com>
In-Reply-To: <CAHp75VeP9eXyrpuWpb9smuLUCBmocwfzA1p4NXPNyNfP0i3ngw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 19 Apr 2021 16:30:00 +0200
Message-ID: <CAHUa44GOZL=2Owua2fD79EnBuzVAh-Oh3nZ=cA1TQy0NAgNMaw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] tee: optee: Provide special parameter field for
 UUID values
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 3:40 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 19, 2021 at 4:30 PM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> > On Mon, Apr 19, 2021 at 2:01 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Apr 19, 2021 at 01:35:51PM +0200, Jens Wiklander wrote:
> > > > On Thu, Apr 15, 2021 at 4:58 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Thanks for review, my answer below.
> > >
> > > > >                 struct optee_msg_param_tmem tmem;
> > > > >                 struct optee_msg_param_rmem rmem;
> > > > >                 struct optee_msg_param_value value;
> > > > > +               uuid_t uuid;
> > > >
> > > > It's nice to get rid of the cast above, but I'm not that keen on the
> > > > change in this struct. This file defines the ABI towards Secure world
> > > > and adding dependencies on external complex types is a larger problem
> > > > than the cast above in my opinion.
> > >
> > > I understand.
> > >
> > > So, the cast is simply wrong there. Can you add a comment above that cast to
> > > explain that and make it is marked as FIXME? Because there is no guarantee that
> > > internal Linux types can be 1:1 mapped to the ABI of something.
> >
> > We might as well fix it directly instead. How about storing the
> > intermediate result in a proper uuid_t and then export it as:
> > export_uuid((u8 *)&msg_arg->params[1].u.uuid, &myuuid);
>
> Still a casting here.
> With u64 members you have a (potential) endianness issue (consider
> BE-32 platform). Also you never know that a b c translates properly to
> byte array.
>
> I would rather see a custom function
>
> optee_import_uuid(param, uuid_t *uuid)
> {
>   u8 uuid_raw[UUID_SIZE];
>
>   put_unaligned_le64(&uuid_raw[0], param.a); // not sure about endianness
>   put_unaligned_le64(&uuid_raw[0], param.b); // ditto

I believe it's a memcpy() we want then, since UUIDs are supposed to be
transmitted using a big endian memory pattern.
We should perhaps add
u8 octets[24];
to that union. Then should the result be well defined using export_uuid().

>
>   import_uuid();
> }
>
> > > What you need, perhaps, is a middle layer function that will copy u64 data
> > > to uuid_t or so. Also, u64 is not an ABI type, why the respective __uXX
> > > variants are not in use?
> >
> > Does it make any difference? The file isn't shared with user space and
> > I need to sync the file manually anyway since OP-TEE doesn't have the
> > same include files.
>
> Yes. It gives a hint that these are ABI (that's why I felt free to add
> a member to the union. I have no idea that's an ABI). Optionally a
> comment suggesting that.

It does say that it defines a protocol at the beginning of the file, I
can add ABI too if you think that helps.

Cheers,
Jens
