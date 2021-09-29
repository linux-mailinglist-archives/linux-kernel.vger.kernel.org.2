Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3762041BF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 08:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244269AbhI2GSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 02:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243585AbhI2GSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 02:18:02 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D1EC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 23:16:21 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 134so1675026iou.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ue2L72Yfa5y6ge63nlG9vKeGiwu3moJ7Urp0CKfDZT0=;
        b=ngmZOUK7gUzxHkbE4NjGhdHnB1ja0k9VeSYIzbC4VTlKX/5aNtROcQLvSMsiAN8fDS
         votmpw4/M0pwqwLET5us7zujCPvMuiZ+gY5KgAy+LEXdr/zDkRl2RjbaQMtCYktRmh1p
         nfg0BBkIKvVjc0R7aD/LeB6N+b31sSpO38nAGf41Gzpnb3LYOXh8YYN7uX8zp58ok2jc
         SPlJSPSmHocAwC+kPPW5xarFzPglrEZRphwvg1xwXYnmqyAdtc4HRbUnzRFYRMdcauJT
         QWNbJSR5qfqi3yn8nmTTKCBdqqkr6L/ZSOjmVPzllZNFTosZSN0BTTXjg5e2y9AAaT5+
         Rr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ue2L72Yfa5y6ge63nlG9vKeGiwu3moJ7Urp0CKfDZT0=;
        b=aEuA2bbU8slVnIZUjVBibUL6jnOLKumcOXJr0FsxfHMJE9//gKqHU2eOd31gRT6yVU
         m2MLfihamal8ASA5ymgOW1DQ+M2MMdKEtyprrhajtJ3trgmkwCl65Jvfspu3rzYk9MjS
         aTmgTkiLLU4BGvtbkWyldKNoD125/ArwoLgetbCSGhnq3TZYtto15pUVrmUKhSfLe28h
         iKU3hCEConCpTyH9TGgCvZueyyfhGtrofrmd2eqbFegpKZg0TA+GUdTGNNps+2MN9IPd
         jLhtyqX54Cvy4FMMgNdKPuvlcGrNqdHFhpzvy5OGyi3wQ2hQBgaVP1hTUIgVd6EhXdQI
         LcqQ==
X-Gm-Message-State: AOAM5326EdABe7+D9V3CaO9p7/YXVa5WphkhX9BZMBaBSGOUe7ELWdNw
        ZXi4d0cB9kZiuCeH6JL4kavJZsUcXIyOBBWoVBI=
X-Google-Smtp-Source: ABdhPJyI+Ic2qBPRcopqrZ34ZMTuw7uTPBjY9+UwnwywG2bCSxm8ounk7mWOZpCjxJn5a1+eSbTQWUknvws5N+qH5+k=
X-Received: by 2002:a05:6638:d0e:: with SMTP id q14mr7867836jaj.139.1632896180981;
 Tue, 28 Sep 2021 23:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <1632831797-32192-1-git-send-email-liangcaifan19@gmail.com> <20210928152919.df87f6c8194316ff1407cdc7@linux-foundation.org>
In-Reply-To: <20210928152919.df87f6c8194316ff1407cdc7@linux-foundation.org>
From:   Fan Liangcai <liangcaifan19@gmail.com>
Date:   Wed, 29 Sep 2021 14:15:53 +0800
Message-ID: <CAEc3SeA8eyMjfrA8Q9UY3knvNwrn68wC7kVn10QZf=X0te5Vsg@mail.gmail.com>
Subject: Re: [PATCH] mm: Set min_free_kbytes with user_min_free_kbytes when
 user_min_free_kbytes is preferred
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     liangcai.fan@unisoc.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2021=E5=B9=B49=E6=9C=882=
9=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=886:29=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Tue, 28 Sep 2021 20:23:17 +0800 Liangcai Fan <liangcaifan19@gmail.com>=
 wrote:
>
> > The 'min_free_kbytes' and 'user_min_free_kbytes' maybe inconsistent
> > after a few times of memory hotplug.
>
> What does "inconsistent" mean here?
>
> Please describe the problem in more detail, perhaps with examples.
>
example:
1. Turn on the device with 1G memory, and the calculated 'new_min_free_kbyt=
es'
is 3452kb, at this time 'min_free_kbytes' =3D 'new_min_free_kbytes' =3D 345=
2kb,
'user_min_free_kbytes' is the initial value -1.

2. The user sets 'min_free_kbytes' to 4096kb through the node,
at this time 'user_min_free_kbytes' =3D 'min_free_kbytes' =3D 4096kb.

3. The memory has increased by 2G, and the memory has become 3G.
Recalculate 'new_min_free_kbytes' to be 6568kb, which is greater than
'user_min_free_kbytes'(4096kb), at this time
'min_free_kbytes' =3D 'new_min_free_kbytes' =3D 6568kb,
'user_min_free_kbytes' =3D 4096kb.

4. The memory has been reduced by 2G, and now the memory has become 1G.
Recalculate 'new_min_free_kbytes' to be 3452kb, which is less than
'user_min_free_kbytes'(4096kb). The original logic does not modify
'min_free_kbytes'.
At this time, 'min_free_kbytes' is the last 'new_min_free_kbytes'(6568kb).
The memory is 1G ,'min_free_kbytes' should be equal to
'user_min_free_kbytes'(4096kb)
set by the user.

> > When 'new_min_free_kbytes' is not larger than 'user_min_free_kbytes',
> > set 'min_free_kbytes' with 'user_min_free_kbytes' rather than leave
> > it as the 'new_min_free_kbytes' calculated for the last time.
> >
> > Signed-off-by: Liangcai Fan <liangcaifan19@gmail.com>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > ---
> >  mm/page_alloc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index b37435c..ddf9dc1 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -8467,6 +8467,12 @@ int __meminit init_per_zone_wmark_min(void)
> >               if (min_free_kbytes > 262144)
> >                       min_free_kbytes =3D 262144;
> >       } else {
> > +             /*
> > +              * Set 'min_free_kbytes' with 'user_min_free_kbytes' rath=
er than
> > +              * leave it as the 'new_min_free_kbytes' calculated for t=
he last
> > +              * time.
> > +              */
>
> This comment explains what the code is doing, which is almost always
> obvious from reading the code!  A better comment will describe *why*
> the code is doing whatever is does.   "why, not what", please.
>
I think this comment is redundant and will be deleted.
> > +             min_free_kbytes =3D user_min_free_kbytes;
> >               pr_warn("min_free_kbytes is not updated to %d because use=
r defined value %d is preferred\n",
> >                               new_min_free_kbytes, user_min_free_kbytes=
);
> >       }
>
