Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9A5414EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhIVRUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbhIVRUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:20:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7BAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:18:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t4so12003319qkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWo8F4iMKGCzt0JCBmge44bMfpMpPwLBF9OMRtIl8y8=;
        b=p/+wDw11RlZWpfho0e5YV0S1/tQmJuip2B7eqzld0dYbzGxZaZG8Ewgxvvv8b3AgbE
         x+g6buLS/9roEkrbid4JrpAb0ZJ7ZeiVPikr5A7kzOowIHr/oEUI2ZBn2+Il8Fm+XWYI
         tDdOpFf0TP+HKzCyBhW7WQ83fAPSuGVrlAOp66g3GJaL5KGZDnt6i5trDDf0En/nCIx4
         X4/5JnjaYSepsFjH8Dm0BHZd92QtlxiSFMISEuS9MB8VZqXll5xurQfl8d4aBP+wP3EV
         dNt70gVksLo4Nd8fhNwOKUZwZi7Ssj8rpntGGilX5c9GLeW0lFhhqzMiXdocnVkpAlxV
         ewKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWo8F4iMKGCzt0JCBmge44bMfpMpPwLBF9OMRtIl8y8=;
        b=C9HVWfvTTt+wbuq7PlJSDchtfckmiJUKIVJEFKg0YfaBrSRisEjHvnROxWKfhvVGM0
         VdNX5qJrV6Ic+kkInB68oL7MRAsv0XAU+xVzkyTeZyB9SEro1nqeCvQ8NFNNvZQ5Cdgz
         9uvzygqXK7K8v83xjdz5X8NDhRkJIircsNQPR3reRSeeLWD1rfH8MX+UK7wD4RygtI5i
         EVyt0JSQIEf6We1W4C25dYXbqCbqQNcjasYX7uJpd/y2eb/7WTouF0UxluO+w74w1yVm
         yC/lRXS0uz2ze+n9t1p4X4tLp0ilFsn+U+X4frd0XcKMyngsQyk1hiFtGAhfCc7sJePf
         aX5w==
X-Gm-Message-State: AOAM532e7FxpjNGq+rWygosqb/SQCUabDolxoP0gtSWhAxaKnQetNL0s
        +kD9+KlSJXLyODUmIrTZliPxYsNRm/qHzBo46rM=
X-Google-Smtp-Source: ABdhPJzlfq8I2QBrdt48ZPqvX3rxr+GBeAL9/hTHw44apmlx4D9fJoUmXPEH+rkai1mY2lcBZT5SA0RBRfBPyHPupHs=
X-Received: by 2002:a25:520a:: with SMTP id g10mr292692ybb.117.1632331120807;
 Wed, 22 Sep 2021 10:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210904091050.g5axxctgelciihjn@gilmour> <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
 <20210920144730.d7oabqfbx7pmyyfb@gilmour> <20210920154333.vunyxeshdb7jt5ka@gilmour>
 <20210920155350.h6624mt65vwg72p2@gilmour> <CADVatmNi+jN+EwiWuoDoocZFyErDVNt1ND0BxtjuKiV63aNuJg@mail.gmail.com>
 <20210920171042.oq3ndp3ox4xv5odh@gilmour> <CADVatmOs7Cc1EdCZXMyXcWM-3-J4bU_3zF1thkOohVUL-G6ZrQ@mail.gmail.com>
 <20210922095725.dk4vk42zb3kh7y6s@gilmour> <CADVatmOMV5gMhCuoP65O9mbW639x5=0+bGh92WVL8FFX2Mvu3w@mail.gmail.com>
 <20210922112837.asxuf5vyen2rwu7u@gilmour>
In-Reply-To: <20210922112837.asxuf5vyen2rwu7u@gilmour>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 22 Sep 2021 18:18:05 +0100
Message-ID: <CADVatmOM-EAXbfp11ZwEHtv2fyuGVoWMXW_f2ZfwTv2wX91eFQ@mail.gmail.com>
Subject: Re: Regression with mainline kernel on rpi4
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 12:28 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Wed, Sep 22, 2021 at 11:10:34AM +0100, Sudip Mukherjee wrote:
> > On Wed, Sep 22, 2021 at 10:57 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > >

<snip>

>
> Still works fine (and it required some mangling of the kernel command line).
>
> If we summarize:
>
>   - You initially just dumped a panic and a link to your QA, without any
>     more context:

The SHA was also given, and I didn't know what else you would need.
The openQA link was given to show the dmesg.

>
>   - Then stating that you're not doing any test, really;

Yes, and I still say that, its just a boot test.

>
>   - Well, except for booting Ubuntu, but no other modification
>
>   - But you're not booting the standard image
>
>   - And with a custom initrd

yes, something which has always worked in boot-testing LTS kernel or
mainline kernel.

>
>   - And that QA link states that you're booting from QEMU, but you're
>     not.

I only found that the "WORKER_CLASS" has the name "qemu_rpi4", that is
a name which I choose to give as that worker laptop is connected to
rpi4 and also running qemu tests. If you want I can change the name of
the WORKER_CLASS. :)
iiuc, dmesg shows if its booting in a qemu or on a real hardware.

>
> Please provide a full documentation on what you're doing to generate
> that image, from scratch, in order to get that panic you reported
> previously.

I have now ordered another rpi4 board and will create the image from
scratch and give you the steps.

>
> I've spent an entire day trying to make sense of what you're doing
> exactly to get into that situation. I have other things to work on and I
> don't plan on figuring out any random CI system.

I am not really sure why you are trying to figure out a random CI
system. I can reproduce the problem in our setup everytime I test with
that reverted commit and I have already said I am happy to test with a
debug patch or anything else.


-- 
Regards
Sudip
