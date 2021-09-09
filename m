Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B34405FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 01:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhIIXJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 19:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhIIXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 19:09:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AE1C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 16:07:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bt14so325320ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cfCV5eFbiqZRH3LUtu99b7bbD7QaaPcg2/PD3s5mWgk=;
        b=dHkJB+W08MV/ijfbJPo2wmU1tsachOY9Ua/COaltsFgNCiAIqil+TZgsDKoPmEk7Pj
         kkX5wb6zhlduoom/+erwZUOejqRs5NWJcW8/3Jtlcm5pQ15a+3FoFJWXk2jW31R3Wocn
         jIo1fh0JHBlrDx9iY6LT1JvH45UEp/Wp7Z75o8MuiOko8JOrV1W6wwoxcPLPzk9jkyHT
         fTuKXMHXDliTpZnuuOXxqPx0LgVSjDf2+X4sGOJT92xNW397slxZuTruznC9ifCDpTL4
         8ZKuMPDvbxhFTaQ+p6jkIZAd57Jfk3hygcTTKbPc846TIsQ2XF1ks9cYpyR4GpuNhbNS
         UQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cfCV5eFbiqZRH3LUtu99b7bbD7QaaPcg2/PD3s5mWgk=;
        b=1F3ntqU8h5Oo3qgcKRFxSXOIZ8s8dPkV+b1hX/Kh3+Bs9M8XAzEanMb29i5j1dvpdx
         6OWMNwJ7+7+pgnM7mhAh737WviaYkV09aQaPn1X8SdvzncnIeS+K+jS7Hk7kYFpYB2+c
         /XOycL9A+cPV7Bk+3I2bbGt5iFHhHUabwd+KxRkKmNeocPWjZx8eLcLa77yfO6zlOEOd
         SJz8RSsd+CuXPxOmBybvUvCt5Cl8ZbnWrUo1aC5EytJlzL9Y8bs0Y2R4hy0HXkhHzocl
         64O5FRm9YChuryfoaOAEyPUBHOPsddWzoHUiiloUDQKKdzLK59pSuHOPTMKw5VTKTc0+
         uAuw==
X-Gm-Message-State: AOAM530pEPuKAYRNftbkVT5o6xtLAU3X0GwAtS6VVyNkAe58ym21Ylq0
        0hyipoAb/b3DCpYLXi9DzJN3aiVIsDIW/XiC8sk=
X-Google-Smtp-Source: ABdhPJxZ0vzxJVvPI+BCUBZlKwZw3IpYsDTcEYPRP9odJG7gteluzPJT0PP1htsGTQSsZpUH74iiqC7z6hYyIrtPP1M=
X-Received: by 2002:a17:906:2556:: with SMTP id j22mr6289681ejb.233.1631228869186;
 Thu, 09 Sep 2021 16:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbLzkr35uVHCJB_cr_fZdz3_FXXGam7dsrAn15j5BPfmfX-_A@mail.gmail.com>
 <CAHbLzko+XqFLx9=e2=E3rGRsLzcm32dZnpDf20gnUb2dAR0d_Q@mail.gmail.com>
 <20210902030728.GA1860112@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkoBz2DwPXC5Nj+Kd6-pRaHgtZ-MGNPzYW4azN6Xpz3oyw@mail.gmail.com>
 <20210903115311.GA2477773@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkoXaB_Hz_ZUw4BvR0PKV_ZV4F+hHekRS9RgUnxBYkMV_g@mail.gmail.com>
 <CAHbLzkpDK5qb1=VM8qeDdfjdqRyuL+ehwOK=8uZPYuR7J+xMEQ@mail.gmail.com>
 <CAHbLzko6yTTnBopzASaYeuD5bBsc_kdhQxQoVd-wqEhkzX1agg@mail.gmail.com>
 <20210908025024.GA4117799@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkptCkXdVdG9mr1BU8TEyEpW57go_Pj1uVopkxORqYi8aw@mail.gmail.com>
 <20210908042547.GA11650@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210908042547.GA11650@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 9 Sep 2021 16:07:37 -0700
Message-ID: <CAHbLzkqNPBh_sK09qfr4yu4WTFOzRy+MKj+PA7iG-adzi9zGsg@mail.gmail.com>
Subject: Re: [PATCH] mm: hwpoison: deal with page cache THP
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "osalvador@suse.de" <osalvador@suse.de>,
        "hughd@google.com" <hughd@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 9:25 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Tue, Sep 07, 2021 at 08:14:26PM -0700, Yang Shi wrote:
> ...
> > > > > > > > 5. We also could define a new FGP flag to return poisoned p=
age, NULL
> > > > > > > > or error pointer. This also should need significant code ch=
ange since
> > > > > > > > a lt callsites need to be contemplated.
> > > > > > >
> > > > > > > Could you explain a little more about which callers should us=
e the flag?
> > > > > >
> > > > > > Just to solve the above invalidate/truncate problem and page fa=
ult
> > > > > > doesn't expect an error pointer. But it seems the above
> > > > > > invalidate/truncate paths don't matter. Page fault should be th=
e only
> > > > > > user since page fault may need unlock the page if poisoned page=
 is
> > > > > > returned.
> > >
> > > Orignally PG_hwpoison is detected in page fault handler for file-back=
ed pages
> > > like below,
> > >
> > >   static vm_fault_t __do_fault(struct vm_fault *vmf)
> > >   ...
> > >           ret =3D vma->vm_ops->fault(vmf);
> > >           if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_F=
AULT_RETRY |
> > >                               VM_FAULT_DONE_COW)))
> > >                   return ret;
> > >
> > >           if (unlikely(PageHWPoison(vmf->page))) {
> > >                   if (ret & VM_FAULT_LOCKED)
> > >                           unlock_page(vmf->page);
> > >                   put_page(vmf->page);
> > >                   vmf->page =3D NULL;
> > >                   return VM_FAULT_HWPOISON;
> > >           }
> > >
> > > so it seems to me that if a filesystem switches to the new scheme of =
keeping
> > > error pages in page cache, ->fault() callback for the filesystem need=
s to be
> > > aware of hwpoisoned pages inside it and returns VM_FAULT_HWPOISON whe=
n it
> > > detects an error page (maybe by detecting pagecache_get_page() to ret=
urn
> > > PTR_ERR(-EIO or -EHWPOISON) or some other ways).  In the other filesy=
stems
> > > with the old scheme, fault() callback does not return VM_FAULT_HWPOIS=
ON so
> > > that page fault handler falls back to the generic PageHWPoison check =
above.
> >
> > Yes, exactly. If we return ERR_PTR we need modify the above code
> > accordingly. But returning the page, no change is required.
> >
> > >
> > > > >
> > > > > It seems page fault check IS_ERR(page) then just return
> > > > > VM_FAULT_HWPOISON. But I found a couple of places in shmem which =
want
> > > > > to return head page then handle subpage or just return the page b=
ut
> > > > > don't care the content of the page. They should ignore hwpoison. =
So I
> > > > > guess we'd better to have a FGP flag for such cases.
> > >
> > > At least currently thp are supposed to be split before error handling=
.
> >
> > Not for file THP.
> >
> > > We could loosen this assumption to support hwpoison on a subpage of t=
hp,
> > > but I'm not sure whether that has some benefit.
> >
> > I don't quite get your point. Currently the hwpoison flag is set on
> > specific subpage instead of head page.
>
> Sorry, I miss the case when thp split fails, then the thp has hwpoison
> flag set on any subpage.  I only thought of the successful case, where th=
e
> resulting error page is no longer a subpage.
>
> >
> > > And also this discussion makes me aware that we need to have a way to
> > > prevent hwpoisoned pages from being used to thp collapse operation.
> >
> > Actually not. The refcount from hwpoison could prevent it from
> > collapsing. But if we return ERR_PTR (#3) we need extra code in
> > khugepaged to handle it.
>
> OK, so we already prevent it.

I just realized I'm wrong for the refcount. The poisoned page has been
isolated from LRU before khugepaged finds it. So the refcount from
isolation is not incremented at all. The refcount seen by khugepaged
is 3: hwpoison, page cache and khugepaged. It actually meets the
expectation.

The khugepaged does check if the page is a LRU page or not but without
holding page lock, so it may race with hwpoison. After holding page
lock, it doesn't check LRU flag anymore. So I think we need add the
check.

>
> Thanks,
> Naoya Horiguchi
>
> >
> > So I realized #1 would require fewer changes. And leaving the page
> > state check to callers seem reasonable since the callers usually check
> > other states, e.g. uptodate.
