Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF13A3F49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhFKJpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:45:25 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:44799 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhFKJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:45:24 -0400
Received: by mail-pj1-f50.google.com with SMTP id h12-20020a17090aa88cb029016400fd8ad8so5680160pjq.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAdZfASurs1ygbbINL5Ok2FOjyRmWMvweZ0+SdQTRoY=;
        b=H4JeCklOEQkShw9YbzD2d/VpWRnxlfU443MvoF3eqTb4ptap8TIpFHZweQC3/KCRiG
         HQ64aT3xkkbq5zv1Nmt2zkwBVkNAT5WBGwC9pr7bX0io/wOtMl2xPGzpQVRbuC2A50Gl
         nKD+wmlHH8YYdRluEWuoQLL8+DYweyaA3phYJRPOdS7Hh+yeDtlHRTFAmwTZTudSLNFD
         FG7l1rUrjRBn+jvTgJk+MbqMTc0PTz08NNXfenNZSAjUVGRe4uQeCc5cIZ5amOrmrAM4
         qYzIMOB1vcaLDEk1yIcqgbgM8kWkQjr3Em5KifxjN43MI9+A6xR1uWfR2EOJsFHJLErM
         6ltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAdZfASurs1ygbbINL5Ok2FOjyRmWMvweZ0+SdQTRoY=;
        b=FKJRWYCFgMNBdWi77Fv9F/tR4XC4x5MowRmAhf6bpny4FMF/tqy64TUTDN7kf3SDi4
         bGpZoJCdNX8JOzWhu6AivOjcDyJ3Dn/L3wjfHoiS4hDHY8I5HN95KRmropCb0Yn9yHrI
         iRJFPj/kSUMkbQWjwYJsiif0Kg174Mhf59cc+z7mOhz5JXgtmpRBjIgKN/Vhvk4GCbf5
         tChUV9ybatLSjZa5d/aeGkQQHWqeYqhtb6lQgGLq34hvv5Ur3QdbszUfYwmUw/Rmn9Fn
         W6ZDMP7FeZl1SUNkjxT4XxF13V+Z3vTc038+9EwphDAzc/2xLmiItPs6mrwnAKyAlEd/
         y28g==
X-Gm-Message-State: AOAM5331dw0aAoGnAqWZjzK3dpaZRueMiZUSSarKgq6hzCOfnrNOpLIb
        LYBOLskLBqP5dmF3ZXK+fRriGHHxPe+Ep5tgsfo=
X-Google-Smtp-Source: ABdhPJywHyHodhkkuIHgu2LJXxhIF2VjIEmU5xl7b2nnFtuJgxxbogxzfRZ6b2fi2IGxIYmFCWgDp4Be4CLaZ+ZeZR4=
X-Received: by 2002:a17:90b:818:: with SMTP id bk24mr3729800pjb.228.1623404531235;
 Fri, 11 Jun 2021 02:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210611071241.16728-1-thunder.leizhen@huawei.com>
 <20210611071241.16728-2-thunder.leizhen@huawei.com> <CAHp75VfX95GVkd6iJ-aYNp7nO56nLSxgreE4fDXAm3h3p6VEjg@mail.gmail.com>
 <81415ec7-078c-fb3f-2373-3f46608fe39e@huawei.com>
In-Reply-To: <81415ec7-078c-fb3f-2373-3f46608fe39e@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 12:41:55 +0300
Message-ID: <CAHp75VeybOch9xUwy5vtufenBA2unb61sGAVoCdTpy2tRcCxLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] scripts: add spelling_sanitizer.sh script
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 12:30 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
> On 2021/6/11 15:58, Andy Shevchenko wrote:
> > On Fri, Jun 11, 2021 at 10:19 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:

...

> >> +# Convert the format of 'codespell' to the current
> >> +sed -r -i 's/ ==> /||/' $src
> >> +
> >> +# Move the spelling "mistake||correction" pairs into file $tmp
> >
> >> +# There are currently 9 lines of comments in $src, so the text starts at line 10
> >> +sed -n '10,$p' $src > $tmp
> >> +sed -i '10,$d' $src
> >
> > This is fragile, use proper comment line detection.
>
> I've thought about that too. But I'm wondering if it needs to be that
> complicated.
>
> Think about it. It's not something for personal temporary use, so it
> should be perfect. I'll change to dynamic computing.

sed has a possibility to choose between two anchors.

Google for `sed -e '/anchor 1/,/anchor 2/'` expressions. So, it will
be less complicated than current code.


-- 
With Best Regards,
Andy Shevchenko
