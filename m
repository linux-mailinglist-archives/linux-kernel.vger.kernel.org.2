Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7253F33F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhHTSlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbhHTSlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:41:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1189EC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 11:40:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id b15so21942185ejg.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/pADhCAwK4juZlSCok3DDyAn5Ad9nUJgtlWKkYwI+sk=;
        b=vAQq/vD+bsbDkzsQULGgQqpeQC0mMft3dolayaH+xHjEkybfiHAGTLXOkL9M6cnjQE
         pir8v5NXo2LH48ydW5CKr+tC3us5e6+Ob5xvfIOsL1Wf2Ytmueq7BTZI0/xPCGhQbhMh
         xPo9kpJr37n3VvYt9UA7vOiVH4FcVaoF779fSZNQcNWJXZ7AAk7O6sQF5roQJBUmDzcW
         AawgC03D6DHXZeEO0D9GhoX0Xb/2BFbqlHo7R2XCeT+vR2IMQSvBQK8aj+q4b39mBN3Q
         jWxUC2onbIYHhfsqF5T1NnAhHmzYNjrEupa39m0Syh8+4+r9joYmgt1ofHTfsPC9OX3Y
         NdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/pADhCAwK4juZlSCok3DDyAn5Ad9nUJgtlWKkYwI+sk=;
        b=m3fwPWWQ4i2dCxj/i7bz10rQanONDOczr1LsQh6U9V3DezDRkYysrAwIXD0hC07gvu
         f6ueqE6hzk8n2nG+KVQnvgdcqNkVwITRYFnatUGAoE7qj1E05zx0+WRUPJsWePnRqjqb
         AgJYUrC0Xd+1eCPQsH2r+TsoLCvziBXtDHFAvxZhtQYubSTIbmilj3TGv69+hqJitpzB
         T47CbegCok3qExLb3SHtv/D9YySIZbwHnB5w3LBbWA+XN7c2z6NLgtWmqxUwmA0PB8xy
         ULfF1itVPeroQCHIRHhThmzPTpLgRt1iz28Er8H6LUz26FHgNqn9flZAbgGWPoZYs0dx
         1xfQ==
X-Gm-Message-State: AOAM530PYPLJdiKyBYorG6+ZD1gl2E816IRRWhlNiEprsq7LepxMCTjC
        u2NqWMwidtatJDE59RkBlMj1i/dHj/0bxBGm+xA=
X-Google-Smtp-Source: ABdhPJwTMcz2avAdDQjv2GkXNUDYA5UHkWh/wkFD/3mVmF+6EPjnMOVFSJHsUz8E0U05BhKQc5KeuFkKYgKU57uPtFI=
X-Received: by 2002:a17:906:1f82:: with SMTP id t2mr22806105ejr.499.1629484836571;
 Fri, 20 Aug 2021 11:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210819054116.266126-1-shy828301@gmail.com> <20210819054116.266126-3-shy828301@gmail.com>
 <20210820064832.GA63355@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210820064832.GA63355@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 20 Aug 2021 11:40:24 -0700
Message-ID: <CAHbLzkqnBbqz7rHTQWsBKdq5uSdKDJX=iDz+HDyF2Jo6CX3H1g@mail.gmail.com>
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

On Thu, Aug 19, 2021 at 11:48 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=
=80=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Wed, Aug 18, 2021 at 10:41:16PM -0700, Yang Shi wrote:
> > Currently just very simple message is shown for unhandlable page, e.g.
> > non-LRU page, like:
> > soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()
> >
> > It is not very helpful for further debug, calling dump_page() could sho=
w
> > more useful information.
> >
> > Calling dump_page() in get_any_page() in order to not duplicate the cal=
l
> > in a couple of different places.  It may be called with pcp disabled an=
d
> > holding memory hotplug lock, it should be not a big deal since hwpoison
> > handler is not called very often.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/memory-failure.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 7cfa134b1370..60df8fcd0444 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1228,6 +1228,9 @@ static int get_any_page(struct page *p, unsigned =
long flags)
> >               ret =3D -EIO;
> >       }
> >  out:
> > +     if (ret =3D=3D -EIO)
> > +             dump_page(p, "hwpoison: unhandlable page");
> > +
>
> I feel that 4 callers of get_hwpoison_page() are in the different context=
,
> so it might be better to consider them separately to add dump_page() or n=
ot.
> soft_offline_page() still prints out "%s: %#lx: unknown page type: %lx (%=
pGp)"

No strong opinion to keep or remove it.

> message, which might be duplicate so this printk() may be dropped.
> In memory_failure_hugetlb() and memory_failure(), we can call dump_page()=
 after
> action_result().  unpoison_memory() doesn't need dump_page() at all becau=
se
> it's related to already hwpoisoned page.

I don't have a strong opinion either to have the dump_page() called
either before action or after action, it just moves around the dumped
page information around that printk.

For unpoison_memory(), I think it is harmless to have dump_page()
called, right? If get_hwpoison_page() can't return -EIO, then the
dump_page() won't be called at all, if it is possible then this is
exactly why we call dump_page() to help debug.

So IMHO calling dump_page() in get_any_page when -EIO is returned
could work for all the cases well and avoid duplicating the call.

>
> Thanks,
> Naoya Horiguchi
