Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07E4147B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhIVLXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbhIVLW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:22:58 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690DFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:21:28 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id p4so8507611qki.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XBkQaLoJFY3Nt7OwoQ6/7lzhxTuoEyjysqz5W7urwSI=;
        b=PlpkA6+3wsVQJU0jUmF5nNb/fwQsrdTvfonPn2SL6UVtcj1PjnfKqKn7v1DhHtuf2s
         iitwrOiQhTfJOtWYRyjIHatzadgc/uu34c6YMNneSINqQuHT2NoDXdNyzU0wfqawf+Ny
         b2Q8T8w1HWNHzGCn3h8Vq6gs8KcbSXTECnqQTOV8maQVxGNu2T+FwyqgxkAkbxfQK5Tb
         rXUkD9VXDVy1Wc1/L40UwUXDR4uXFvHvQmOZpDaBBs/3NBuZU/gpQbEHe+0TR8vk20cG
         hOeoD/5qJAVHtZrlyBxjyj0ZaILGTJ2WZzMmetIqwWsm/PmDs4HrTF+q3+KEmEwYYCoG
         /Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XBkQaLoJFY3Nt7OwoQ6/7lzhxTuoEyjysqz5W7urwSI=;
        b=R1V5Xgo7V8sfGdpDb4kAr7NTYs/rPF4JLC6Er4vDx7XUyGqzatLUXSYaMS33bPc6p/
         Hvp+OjrIjYfep78PGVTRcS32gB6UuVPGHHTNcJ3F2jfwUeC2ZVGHv5zeQQHdjqOhYFnj
         BGFWniYx95SL0js3o4Q3j3AVS8l5vkF28gWAbnNakQSufP+hSNwLxwers0YeWLtYvfsX
         zcTj4cln9t/Bw8XkAf9ckIuGIQqFRCnkW/M9IjDBoxC/5GZfWWUPoGcTRyBp2EwRylcE
         RfzAFcaM40xxEgInlX0yYxmpHnv9rP0+VKSFh7BuHNKkHUFEkWzXTy6ZiW0SBDqmqz7I
         hB5Q==
X-Gm-Message-State: AOAM533hWU6gxveFjYm9gb/Kg0XHBojsQsDdkQ8NynsbKCxW/tlNvYS0
        vEc5Pepa+HYZ/Th92frD19fH0SNb5avGzWUPFL8=
X-Google-Smtp-Source: ABdhPJxfOxoaqJ9qJtwPKJmRdP07b/eFIWne3Aru1UUuefVLCXuB27CA8ThyVovWBMbZpLUbMzIDsRfYFxcJnJRqzvU=
X-Received: by 2002:a5b:ecb:: with SMTP id a11mr44209942ybs.434.1632309687464;
 Wed, 22 Sep 2021 04:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YvovgRNC5EFhN_d=jApwSAsWcNj35=FCJf1k867vBqfw@mail.gmail.com>
 <067b8eea-3c77-c1f0-8e68-b99e6bf0c033@leemhuis.info>
In-Reply-To: <067b8eea-3c77-c1f0-8e68-b99e6bf0c033@leemhuis.info>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 22 Sep 2021 13:21:18 +0200
Message-ID: <CAKXUXMxg-eywEYrR0oSAo14F7CmiYAT7VDxV71U4-Tv8E0LeVQ@mail.gmail.com>
Subject: Re: finding regressions with syzkaller
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Paul Albertella <paul.albertella@codethink.co.uk>
Cc:     Dmitry Vyukov <dvyukov@google.com>, regressions@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        automated-testing@yoctoproject.org,
        Sasha Levin <sashalevin@google.com>,
        Marco Elver <elver@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Mara Mihali <mihalimara22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 1:25 PM Thorsten Leemhuis <linux@leemhuis.info> wro=
te:
>
> [CCing Lukas]
>
> Hi Dmitry!
>
> On 10.08.21 19:08, Dmitry Vyukov wrote:
> > [...]
> > The idea is to generate random test programs (as syzkaller does) and
> > then execute them on 2 different kernels and compare results (so
> > called "differential fuzzing"). This has the potential of finding not
> > just various "crashes" but also logical bugs and regressions.
>
> Hmmm, interesting concept!
>
> > The major issue is various false positive differences caused by
> > timings, non-determinism, accumulated state, intentional and
> > semi-intentional changes (e.g. subtle API extensions), etc. We learnt
> > how to deal with some of these to some degree, but feasibility is
> > still an open question.
>
> Sounds complicated and like a lot of manual work.
>
> Do you have in mind that Linus and hence many other Kernel developers
> afaics only care about regressions someone actually observed in a
> practice? Like a software or script breaking due to a kernel-side change?
>
> To quote Linus from
> https://lore.kernel.org/lkml/CA+55aFx3RswnjmCErk8QhCo0KrCvxZnuES3WALBR1Nk=
PbUZ8qw@mail.gmail.com/
>
> ```The Linux "no regressions" rule is not about some theoretical
> "the ABI changed". It's about actual observed regressions.
>
> So if we can improve the ABI without any user program or workflow
> breaking, that's fine.```
>
> His stance on that afaik has not changed since then.
>
> Thus after ruling our all false positives syzkaller might find, there
> will always be the follow-up question "well, does anything/anyone
> actually care?". That might be hard to answer and requires yet more
> manual work by some human. Maybe this working hours at least for now are
> better spend in other areas.
>
> > Since this work is in very early stage, I only have very high-level que=
stions:
> >  - what do you think about feasibility/usefulness of this idea in gener=
al?
>
> TBH I'm a bit sceptical due to the above factors. Don't get me wrong,
> making syzkaller look out for regressions sounds great, but I wonder if
> there are more pressing issues that are worth getting at first.
>
> Another aspect: CI testing already finds quite a few regressions, but
> those that are harder to catch are afaics often in driver code. And you
> often can't test that without the hardware, which makes me assume that
> syzkaller wouldn't help here (or am I wrong?)
>
> >  - any suggestions on how to make the tool find more differences/bugs
> > or how to make it more reliable?
> >  - is there a list or pointers to some known past regressions that
> > would be useful to find with such tool? (I've looked at the things
> > reported on the regressions@ list, but it's mostly crashes/not
> > booting, but that's what syzkaller can find already well)
>
> I first wanted to tell you "look up the reports I compiled in 2017 in
> the LKML archives", but I guess the way better solution is: just grep
> for "regression" in the commit log.
>
> >  - anybody else we should CC?
>
> I guess the people from the Elisa project might be interested in this,
> that's why I CCed Lukas.
>

Thanks, Thorsten. I do follow the syzkaller mailing list, so I have
seen that email before, but I do appreciate your implicit
acknowledgement here :)

... and Dmitry is back from vacation and I guess we will hear more
today at the Testing and Fuzzing MC on this topic.

Further people/lists to CC are: Paul Albertella
<paul.albertella@codethink.co.uk> (already CCed here)

I am personally certainly interested and I think this work gives
companies in the area of building trustable software and systems (see
Paul's area of expertise) a good understanding how reliable and to
which extent the statement "all Linux kernels are backwards
compatible" really holds.

I unfortunately lost the Fuzzing Team (Jouni H=C3=B6gander, Jukka Kaartinen
et al.) previously working with me, and I need to first get back some
budget, build up a new team and hope that we can then also follow this
idea and contribute here as well. (Fingers crossed that I can convince
some others to give me money and work with me on this...)

Looking forward to the presentation at the MC.

Best regards,

Lukas
