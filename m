Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176473F4FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhHWRsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhHWRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:47:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDB1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:47:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id me10so10329024ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1XjqUyJNMd2ZLbkK/sFsLTUvba6HdD4u6vq+rnRJ9HM=;
        b=cuBLsnPOnipeZtybbChKkUxipN5F5gVvQTKjFPxTRITk42+HTedxhtUBpKefoD/0NN
         M7UKhN2UEEHrzj+/lAWTrBiMOFBYA+FcZW+S4vilsn6507Ah57B6k0PLbKkLpgQ/OPn/
         pp0LTC7mTU55MvAU1msQhSHyj4zRBrQALAsDrSJcCc4v7nTSq7VqZTqnByI9VzfZBsAC
         g9To5tNK9IQA21FRlcG6iil2XIoiIuBoH99iZPiTAg/3/oLt7cEP1amZw+F6moh2SbhR
         l3blaxyv3cbtgpiGpG9hbTVsFyvT9omkJrlKZ8IVYEMWUb49AkEsw2vCDJK70DYKIeX5
         R6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1XjqUyJNMd2ZLbkK/sFsLTUvba6HdD4u6vq+rnRJ9HM=;
        b=XvngKIc4YzVBYBpNN0Dz4jWjVkXOWDCuz0O7w+Y4imfSA4a5m5i4FzHpRdy5hdzEMZ
         HalGWznYe/aeZzEzrYV2MAI2ZfZj2ZVnUPfUGrPCZN7L1BMRRXAMvxiUYnc35bAXnrYK
         vJJTNpEOj4HkE1YrULaaMESxz40PtvGdGG72j0fxSMswMqmKwlUV+zFZfYkR8xjsPlwm
         BF55HhsUBCAvFhcLeJ1lUkccZQvpn2OYnmtojOmRzzZtVsVrHpJM8G89OAoQxw1ay/oz
         xr0KXfGfLe7es2x2uf4EW6vBX00wGCzgHD+gPFeNW2K32mVFHfT375CvrPOVAE50iXbl
         kyYg==
X-Gm-Message-State: AOAM530NaK4WDl42gjuIAo5s5Tw7MX8cqOL6+u4txE9Uxv7TQvQ2e7HH
        SFy5QwZbWSs+TG2y3atR4MeXGCdjFPlRnnPr04I=
X-Google-Smtp-Source: ABdhPJx75A+zyMRs9Sa6sfWQuacNo49iPMrd71DX2INrL0DQxC7MhflC2jE+NIfPnezwZlFUBjPjXjQ9Uughu9j2UNI=
X-Received: by 2002:a17:906:374e:: with SMTP id e14mr15510393ejc.161.1629740834945;
 Mon, 23 Aug 2021 10:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210819054116.266126-1-shy828301@gmail.com> <20210819054116.266126-3-shy828301@gmail.com>
 <20210820064832.GA63355@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkqnBbqz7rHTQWsBKdq5uSdKDJX=iDz+HDyF2Jo6CX3H1g@mail.gmail.com>
 <20210823050526.GA1452382@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210823050526.GA1452382@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 23 Aug 2021 10:47:03 -0700
Message-ID: <CAHbLzkoUavFuBSHRunvptAUynehFxfs-aAywmE4MjaLi16nL3A@mail.gmail.com>
Subject: Re: [v2 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "osalvador@suse.de" <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        "david@redhat.com" <david@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 10:05 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=
=80=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Fri, Aug 20, 2021 at 11:40:24AM -0700, Yang Shi wrote:
> > On Thu, Aug 19, 2021 at 11:48 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=
=80=80=E7=9B=B4=E4=B9=9F)
> > <naoya.horiguchi@nec.com> wrote:
> > >
> > > On Wed, Aug 18, 2021 at 10:41:16PM -0700, Yang Shi wrote:
> > > > Currently just very simple message is shown for unhandlable page, e=
.g.
> > > > non-LRU page, like:
> > > > soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 (=
)
> > > >
> > > > It is not very helpful for further debug, calling dump_page() could=
 show
> > > > more useful information.
> > > >
> > > > Calling dump_page() in get_any_page() in order to not duplicate the=
 call
> > > > in a couple of different places.  It may be called with pcp disable=
d and
> > > > holding memory hotplug lock, it should be not a big deal since hwpo=
ison
> > > > handler is not called very often.
> > > >
> > > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > > Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > > Cc: Oscar Salvador <osalvador@suse.de>
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  mm/memory-failure.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > > index 7cfa134b1370..60df8fcd0444 100644
> > > > --- a/mm/memory-failure.c
> > > > +++ b/mm/memory-failure.c
> > > > @@ -1228,6 +1228,9 @@ static int get_any_page(struct page *p, unsig=
ned long flags)
> > > >               ret =3D -EIO;
> > > >       }
> > > >  out:
> > > > +     if (ret =3D=3D -EIO)
> > > > +             dump_page(p, "hwpoison: unhandlable page");
> > > > +
> > >
> > > I feel that 4 callers of get_hwpoison_page() are in the different con=
text,
> > > so it might be better to consider them separately to add dump_page() =
or not.
> > > soft_offline_page() still prints out "%s: %#lx: unknown page type: %l=
x (%pGp)"
> >
> > No strong opinion to keep or remove it.
>
> Reading the explanation below, I think that calling dump_page() in the
> original place is fine.  So let's remove "else if (ret =3D=3D 0)" block i=
n
> soft_offline_page().

The "else if (ret =3D=3D 0)" block is used to handle free page IIUC. I'm
supposed you mean the "else if (ret =3D=3D -EIO)" block which just calls
printk.

>
> >
> > > message, which might be duplicate so this printk() may be dropped.
> > > In memory_failure_hugetlb() and memory_failure(), we can call dump_pa=
ge() after
> > > action_result().  unpoison_memory() doesn't need dump_page() at all b=
ecause
> > > it's related to already hwpoisoned page.
> >
> > I don't have a strong opinion either to have the dump_page() called
> > either before action or after action, it just moves around the dumped
> > page information around that printk.
> >
> > For unpoison_memory(), I think it is harmless to have dump_page()
> > called, right? If get_hwpoison_page() can't return -EIO, then the
> > dump_page() won't be called at all, if it is possible then this is
> > exactly why we call dump_page() to help debug.
> >
> > So IMHO calling dump_page() in get_any_page when -EIO is returned
> > could work for all the cases well and avoid duplicating the call.
>
> Fair enough. So could you repost 3/3 with the above change in soft_offlin=
e_page()?
>
> Thanks,
> Naoya Horiguchi
