Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA39364658
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbhDSOmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbhDSOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:42:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3A3C061761
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:42:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e2so13512243plh.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfXdvJ1fort8YfUZHhPvEtiQfHEl5DuslQu28H8S8Bw=;
        b=IS8hhieXJzbGQDJb6Jaf/h7G83Q6KehbtblpZt7edrHNDlvla//ikL9ohOHRfUiUsQ
         inLLyto3hFn5P1IJNt19ccIYNeFlMpf+4rrhxgtbg0Gmkf847sBtKW1MiYtXoSYldE8H
         6Ip/at1yH/dkXcUe5OmxHQo+2BDUdE2MERpKcFoEE2PqJSjcvYqoMRu2YdjGqge/7VU3
         s6qz5pAZZg/5UaOM1VNNiwj3dGX3JuuBxpX4C9QTCorBbMQqRycqojIoBzaYNImAl90P
         EKNsvmNInRuMwjkaJXIwBelpWQ4W6fyuoL++aZ0Q9h5M8Py4cnZ1FaqsyGtBsZb3evH7
         Kp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfXdvJ1fort8YfUZHhPvEtiQfHEl5DuslQu28H8S8Bw=;
        b=tedGkb4mvJNSavSQsr1qojLnRCTzKoaUZ8rq2sUiaq7dqwPcKDfdBB8mAOCn2gr3vZ
         1yL0BLfaJyOEcOb5+ud1ZXqk/EYHxyjjLc+BZWfcB6OdimW8+E2YdDGNN8ncQVP6farT
         fdpaAYv1nnq4h/t0lx2lEZ7r3HmwIy1sjYn4As0KTWJ+1XCOunlE+bQCL8LiUv1DfLk4
         B10YkOHQGEgPF1XMA7byCz7kbk4Vj1F7GI0/hvDL6l9eucC7ejbRnnE3f9z8W3w8xqEE
         RJZOUuo360WlWfZzg7Xr4iRQhbk1cr/sYF1YVcBnxwAEfTidHjNfkRenWM7biyJiiWAn
         rgdw==
X-Gm-Message-State: AOAM531n4YweBmvwF/MRlzBqq/W2Va39hkVszCxwJjwxjfFaMeB0wT5K
        UIddvz4yQE48i+lMTsxyswSDCC5fQUUgH4jZtlGCTe6oS/s=
X-Google-Smtp-Source: ABdhPJw8zHS6Omc0YeA1/oc/wAFsW2xOo/bmxC1Vp9xReo3qmdX2KsWGycjNDAJ7q7ZdKZRKZ+vLkZaqbcjGCEGRd7I=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr23284959plq.17.1618843332560; Mon, 19
 Apr 2021 07:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210415145857.34183-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44FWJiL1yzHR0jwL2VJG_4t_O6An48v47gORitcaahwmYw@mail.gmail.com>
 <YH1xHDbFyJ1URYYV@smile.fi.intel.com> <CAHUa44GqTNoLbwfqPrWFVLV3=M2d-2hE1uDY=CHpCcZgzMu5Og@mail.gmail.com>
 <CAHp75VeP9eXyrpuWpb9smuLUCBmocwfzA1p4NXPNyNfP0i3ngw@mail.gmail.com> <CAHUa44GOZL=2Owua2fD79EnBuzVAh-Oh3nZ=cA1TQy0NAgNMaw@mail.gmail.com>
In-Reply-To: <CAHUa44GOZL=2Owua2fD79EnBuzVAh-Oh3nZ=cA1TQy0NAgNMaw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Apr 2021 17:41:56 +0300
Message-ID: <CAHp75VfUrNmrCgX4WQqwc-CCBv2niDp0iwidc0LvJOx+A-mfcA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] tee: optee: Provide special parameter field for
 UUID values
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 5:30 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> On Mon, Apr 19, 2021 at 3:40 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Apr 19, 2021 at 4:30 PM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > > On Mon, Apr 19, 2021 at 2:01 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Apr 19, 2021 at 01:35:51PM +0200, Jens Wiklander wrote:
> > > > > On Thu, Apr 15, 2021 at 4:58 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > Thanks for review, my answer below.
> > > >
> > > > > >                 struct optee_msg_param_tmem tmem;
> > > > > >                 struct optee_msg_param_rmem rmem;
> > > > > >                 struct optee_msg_param_value value;
> > > > > > +               uuid_t uuid;
> > > > >
> > > > > It's nice to get rid of the cast above, but I'm not that keen on the
> > > > > change in this struct. This file defines the ABI towards Secure world
> > > > > and adding dependencies on external complex types is a larger problem
> > > > > than the cast above in my opinion.
> > > >
> > > > I understand.
> > > >
> > > > So, the cast is simply wrong there. Can you add a comment above that cast to
> > > > explain that and make it is marked as FIXME? Because there is no guarantee that
> > > > internal Linux types can be 1:1 mapped to the ABI of something.
> > >
> > > We might as well fix it directly instead. How about storing the
> > > intermediate result in a proper uuid_t and then export it as:
> > > export_uuid((u8 *)&msg_arg->params[1].u.uuid, &myuuid);
> >
> > Still a casting here.
> > With u64 members you have a (potential) endianness issue (consider
> > BE-32 platform). Also you never know that a b c translates properly to
> > byte array.
> >
> > I would rather see a custom function
> >
> > optee_import_uuid(param, uuid_t *uuid)
> > {
> >   u8 uuid_raw[UUID_SIZE];
> >
> >   put_unaligned_le64(&uuid_raw[0], param.a); // not sure about endianness
> >   put_unaligned_le64(&uuid_raw[0], param.b); // ditto
>
> I believe it's a memcpy() we want then, since UUIDs are supposed to be
> transmitted using a big endian memory pattern.
> We should perhaps add
> u8 octets[24];
> to that union. Then should the result be well defined using export_uuid().

Right, if you do that, it would be wonderful!

> >   import_uuid();
> > }
> >
> > > > What you need, perhaps, is a middle layer function that will copy u64 data
> > > > to uuid_t or so. Also, u64 is not an ABI type, why the respective __uXX
> > > > variants are not in use?
> > >
> > > Does it make any difference? The file isn't shared with user space and
> > > I need to sync the file manually anyway since OP-TEE doesn't have the
> > > same include files.
> >
> > Yes. It gives a hint that these are ABI (that's why I felt free to add
> > a member to the union. I have no idea that's an ABI). Optionally a
> > comment suggesting that.
>
> It does say that it defines a protocol at the beginning of the file, I
> can add ABI too if you think that helps.

I read the structure definition, perhaps some clarification on a data
type level would be nice.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
