Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D738B832
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhETURl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:17:41 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55571 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhETURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:17:41 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MO9r5-1m8Fj90Taj-00OXPy for <linux-kernel@vger.kernel.org>; Thu, 20 May
 2021 22:16:18 +0200
Received: by mail-wr1-f44.google.com with SMTP id a4so18932922wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 13:16:18 -0700 (PDT)
X-Gm-Message-State: AOAM532EamSwJoAEIJRHY9hyu9cqgpS+HKTEyVLZjOtU4ywsQyuBlb/y
        YkfxJEwva4falY6VdbRPYdvTgUOKek+iFssZvyI=
X-Google-Smtp-Source: ABdhPJyQrHnCI/Hpu5bEC+JGGuXBB7UQJ5QXDEOi0UjFxOvYdeF2arsMknKaXCVcHS4Q5uJm14ECiNMg4Vfi/u9uQT4=
X-Received: by 2002:a05:6000:1b0b:: with SMTP id f11mr6012183wrz.165.1621541777749;
 Thu, 20 May 2021 13:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210511203716.117010-1-rikard.falkeborn@gmail.com>
 <CAMj1kXF0rMwjgm27=i3XkrXJ=21C_x4he5Ls+7FSKUhsva970Q@mail.gmail.com>
 <YKaukFKw4KTmnOVd@rikard> <YKa8JjT9AFOspIl5@yury-ThinkPad>
In-Reply-To: <YKa8JjT9AFOspIl5@yury-ThinkPad>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 May 2021 22:15:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1i1XE_rUrg_kX87NPA7NBJa5m2gVrHSuBE3XzFLUKPWA@mail.gmail.com>
Message-ID: <CAK8P3a1i1XE_rUrg_kX87NPA7NBJa5m2gVrHSuBE3XzFLUKPWA@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: Fix compilation error with GENMASK
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aiXiW0rveAmvguh8ZrnxIbJvHaHavswGfIO/jAkzJurlF2qhFtI
 fYDmCWMYGsNZi/nMpm3AUdheQCVkXq2cinvkpf3vAIqxA9+KvOXBZrlxFZ3SV44D+p0DDIU
 QOyLtGWG+sYg11WUgSLLgkiES7TXhdobEnXcDbs3vPxZYyF1vq3zgb5HH/+q1vERnJirSrz
 iTJBrVRGh1fnFPHKxrWcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T92om8N0pKw=:c0HxSjOlTCJhJu/IDFzNUn
 GxgNTlGzJ1QG+VueXth3rx11qlhMI+Q8cp+sOPPFsV2eaUH3hA/ZhRaJK1GHYsA81MdzRsyIx
 Uqq1j45fJGmReEQz63ma4nphyPF0hojQDpEarRqm7te4jOdrOCJEbfQ/yOGYUPdLIFx91om6i
 B9kknFH2N3HBvcrwXsMrcy1koOJPG6b3d6U5CbY1AKktUhxqZrErrKuQxs9K6mHVL2NM0+CkH
 fiWUva/fhEMUsWJ4jnoB+UB8L2qReZRY8hYUzmj+fupe90NIPidslc7RgFrvlgx0HBuzFTnwV
 Wg98Hrb7BUAA5+V6IdhmHy9tt6I9CjEhp6nDKg/NqgEvP2I9/BRzoCON3tWh62aFN0W3z52VC
 +pkjKC1dks9k/Q4OknqO8Uyq+45w9x8g4oNCUiVYKsdeR6kx8hKa4Gls5yWW0r6Zcw7DHYqmk
 ks/Dll7LhQ6KVlxgdzrEZG6jMFlSq2fys+0/1YMDa4DKW+dIR6M20l9vS1rmxw14J6uJRz+I9
 M31LB0pP+keVsF24Oo1TtAxY1HukDIIGBlLv5dcnDTfrGf8zVtxUNlkB6jSI9zsn6yKA/NimM
 AyA/fk+wfAHJX919sZ3wVJ6WM+a41atHq/zr2J2/UGDtEuyagwUP7PuJ6Pe4mTandIveStGeO
 ixb0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 9:44 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Thu, May 20, 2021 at 08:46:40PM +0200, Rikard Falkeborn wrote:
> > > > +/*
> > > > + * This returns a constant expression while determining if an argument is
> > > > + * a constant expression, most importantly without evaluating the argument.
> > > > + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > > > + */
> > > > +#define __is_constexpr(x) \
> > > > +       (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> > > > +
> > > >  #endif /* _LINUX_CONST_H */
> > > > --
> > > > 2.31.1
> > > >
> >
> > Friendly ping.
>
> I added this patch in my Bitmap tree, but since it's actually a build
> bug fix, I think it's worth to move it faster with Arnd's or Andrew's
> trees?

I have a few days off next week and won't be able to validate it before then,
so it would be faster to have Andrew pick it up.

Moving the definition to const.h seem reasonable to me here, feel
free to add

Acked-by: Arnd Bergmann <arnd@arndb.de>
