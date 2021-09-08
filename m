Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3DD4032DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 05:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347430AbhIHDPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 23:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhIHDPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 23:15:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1A9C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 20:14:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mf2so1153977ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 20:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w28qwB6uuk0TmzATBqadaAK/GMSgO2rEp01QI9DAiu4=;
        b=IOnxrwqp7N6Esw4/Sp7ke8HcDz3rOHTzmn5b/+Ug5iuYUP2fUxkbpGdLKhnbiuzRPX
         O1Xprm93z4CVnQ6UruW26o0nhp+puApY4JVWCg4RlR0dLRS17szLArt9RctNkoUTvWq0
         17hRauezF0AugWyQt7JvZ03Z/K1KDpwrlS1n3cEsDwXYBOlsnpwntAYzN/NonOdvWyL2
         poEmpYNGRgtVz6XlIF/k+HVpazgJE2nuGWYL1LQuSQJY8V7mwcCdZPqPMpcqb4vmuboN
         j8f/s5HZUHA29ZgN4GH8yJFs7cM3F6PwPTsRe+rF3iP3QzAyz964toGfFo/Rzmmf4U69
         5znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w28qwB6uuk0TmzATBqadaAK/GMSgO2rEp01QI9DAiu4=;
        b=r82LRXn5Mb0GJQghIIkvlHQyr+WNhj/CE3NHdxWxoxbfm/sAivnh5kDITJW92H+S9p
         VueWtzoNItFeJq8ZKROXAq01nTMqQac6jClzXu3FuzZ6xO1+9c5Wur3H4Wp7l9ZLTeeU
         d0/vd5kev8dRcJ+VTOZNnN3xPH8lwFGF4cRUR66Ki8gM5tnG0iFv+ZCdJxvatOjN9+6K
         VdIJLXwQ2g6gW1hB+zC/IhcTD8/C5cK3cO0xQf01RvjFkRBOGtPnBWBCpZNGPC20zT27
         Vc2jqhKmGEHX8sUWM5GqqSnSjHhH9Urnhu0FlQSu1lhwet33NZav9YF4yksTpzy9vGWP
         ndgg==
X-Gm-Message-State: AOAM530Soj4onYzHEY/RI36veUiA2k2j711Hq3lg85mnTzSLvQ1c1+7S
        53vlYh1/BCZPoZVHa5RxdfIpbWvTAUFlb2PCPCQ=
X-Google-Smtp-Source: ABdhPJzhgOVf6JDYsVJsgBRW5Hv4Dgb9WcXaR3/VzlYUjt4rkZV4lNNjWJyCD+iIIHfQ7UbLzSyQ3oPMT19xYRx7Uhs=
X-Received: by 2002:a17:907:2492:: with SMTP id zg18mr1793585ejb.233.1631070877936;
 Tue, 07 Sep 2021 20:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbLzkpvR77xfs+ip1T8G09=ixz4Ko3E-6iKTEZkFCfGTxi6Aw@mail.gmail.com>
 <20210827035739.GA3247360@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkr35uVHCJB_cr_fZdz3_FXXGam7dsrAn15j5BPfmfX-_A@mail.gmail.com>
 <CAHbLzko+XqFLx9=e2=E3rGRsLzcm32dZnpDf20gnUb2dAR0d_Q@mail.gmail.com>
 <20210902030728.GA1860112@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkoBz2DwPXC5Nj+Kd6-pRaHgtZ-MGNPzYW4azN6Xpz3oyw@mail.gmail.com>
 <20210903115311.GA2477773@hori.linux.bs1.fc.nec.co.jp> <CAHbLzkoXaB_Hz_ZUw4BvR0PKV_ZV4F+hHekRS9RgUnxBYkMV_g@mail.gmail.com>
 <CAHbLzkpDK5qb1=VM8qeDdfjdqRyuL+ehwOK=8uZPYuR7J+xMEQ@mail.gmail.com>
 <CAHbLzko6yTTnBopzASaYeuD5bBsc_kdhQxQoVd-wqEhkzX1agg@mail.gmail.com> <20210908025024.GA4117799@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210908025024.GA4117799@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 7 Sep 2021 20:14:26 -0700
Message-ID: <CAHbLzkptCkXdVdG9mr1BU8TEyEpW57go_Pj1uVopkxORqYi8aw@mail.gmail.com>
Subject: Re: ##freemail## Re: [PATCH] mm: hwpoison: deal with page cache THP
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

On Tue, Sep 7, 2021 at 7:50 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Tue, Sep 07, 2021 at 02:34:24PM -0700, Yang Shi wrote:
> > On Fri, Sep 3, 2021 at 5:03 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Fri, Sep 3, 2021 at 11:01 AM Yang Shi <shy828301@gmail.com> wrote:
> ...
> > > > > >
> > > > > > AFAIK the address_space error just works for fsync. Anyway I co=
uld be wrong.
> > > > > >
> > > > > > I think clearing the dirty flag might be the easiest way? It se=
ems
> > > > > > unnecessary to notify the users when writing back since the mos=
t write
> > > > > > back happens asynchronously. They should be notified when the p=
age is
> > > > > > accessed, e.g. read/write and page fault.
> > > > > >
> > > > > > I did some further investigation and got a clearer picture for
> > > > > > writeback filesystem:
> > > > > > 1. The page should be not written back: clearing dirty flag cou=
ld
> > > > > > prevent from writeback
> > > > > > 2. The page should be not dropped (it shows as a clean page): t=
he
> > > > > > refcount pin from hwpoison could prevent from invalidating (cal=
led by
> > > > > > cache drop, inode cache shrinking, etc), but it doesn't avoid
> > > > > > invalidation in DIO path (easy to deal with)
> > > > > > 3. The page should be able to get truncated/hole punched/unlink=
ed: it
> > > > > > works as it is
> > > > > > 4. Notify users when the page is accessed, e.g. read/write, pag=
e fault
> > > > > > and other paths: this is hard
> > > > > >
> > > > > > The hardest part is #4. Since there are too many paths in files=
ystems
> > > > > > that do *NOT* check if page is poisoned or not, e.g. read/write=
,
> > > > > > compression (btrfs, f2fs), etc. A couple of ways to handle it o=
ff the
> > > > > > top of my head:
> > > > > > 1. Check hwpoison flag for every path, the most straightforward=
 way,
> > > > > > but a lot work
> > > > > > 2. Return NULL for poisoned page from page cache lookup, the mo=
st
> > > > > > callsites check if NULL is returned, this should have least wor=
k I
> > > > > > think. But the error handling in filesystems just return -ENOME=
M, the
> > > > > > error code will incur confusion to the users obviously.
> > > > > > 3. To improve #2, we could return error pointer, e.g. ERR_PTR(-=
EIO),
> > > > > > but this will involve significant amount of code change as well=
 since
> > > > > > all the paths need check if the pointer is ERR or not.
> > > > >
> > > > > I think the approach #3 sounds good for now, it seems to me that =
these
> > > > > statements are about general ways to handle error pages on all pa=
ge cache
> > > > > users, so then the amount of code changes is a big problem, but w=
hen
> > > > > focusing on shmem/tmpfs, could the amount of changes be more hand=
lable, or
> > > > > still large?
> > > >
> > > > Yeah, I agree #3 makes more sense. Just return an error when findin=
g
> > > > out corrupted page. I think this is the right semantic.
> >
> > I had a prototype patchset for #3, but now I have to consider stepping
> > back to rethink which way we should go. I actually did a patchset for
> > #1 too. By comparing the two patchsets and some deeper investigation
> > during preparing the two patchsets, I realized #3 may not be the best
> > way.
> >
> > For #3 ERR_PTR will be returned so all the callers need to check the
> > return value otherwise invalid pointer may be dereferenced, but not
> > all callers really care about the content of the page, for example,
> > partial truncate which just set the truncated range in one page to 0.
> > So for such paths it needs additional modification if ERR_PTR is
> > returned. And if the callers have their own way to handle the
> > problematic pages we need to add a new FGP flag to tell FGP functions
> > to return the pointer to the page.
> >
> > But we don't need to do anything for such paths if we go with #1. For
> > most paths (e.g. read/write) both ways need to check the validity of
> > the page by checking ERR PTR or page flag. But a lot of extra code
> > could be saved for the paths which don't care about the actual data
> > for #1.
>
> OK, so it's not clear which is better. Maybe we need discussion over
> patches...

Yeah, the conclusion is #1 would need fewer changes than #3.

>
> ...
>
> > > >
> > > > >
> > > > > > 5. We also could define a new FGP flag to return poisoned page,=
 NULL
> > > > > > or error pointer. This also should need significant code change=
 since
> > > > > > a lt callsites need to be contemplated.
> > > > >
> > > > > Could you explain a little more about which callers should use th=
e flag?
> > > >
> > > > Just to solve the above invalidate/truncate problem and page fault
> > > > doesn't expect an error pointer. But it seems the above
> > > > invalidate/truncate paths don't matter. Page fault should be the on=
ly
> > > > user since page fault may need unlock the page if poisoned page is
> > > > returned.
>
> Orignally PG_hwpoison is detected in page fault handler for file-backed p=
ages
> like below,
>
>   static vm_fault_t __do_fault(struct vm_fault *vmf)
>   ...
>           ret =3D vma->vm_ops->fault(vmf);
>           if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT=
_RETRY |
>                               VM_FAULT_DONE_COW)))
>                   return ret;
>
>           if (unlikely(PageHWPoison(vmf->page))) {
>                   if (ret & VM_FAULT_LOCKED)
>                           unlock_page(vmf->page);
>                   put_page(vmf->page);
>                   vmf->page =3D NULL;
>                   return VM_FAULT_HWPOISON;
>           }
>
> so it seems to me that if a filesystem switches to the new scheme of keep=
ing
> error pages in page cache, ->fault() callback for the filesystem needs to=
 be
> aware of hwpoisoned pages inside it and returns VM_FAULT_HWPOISON when it
> detects an error page (maybe by detecting pagecache_get_page() to return
> PTR_ERR(-EIO or -EHWPOISON) or some other ways).  In the other filesystem=
s
> with the old scheme, fault() callback does not return VM_FAULT_HWPOISON s=
o
> that page fault handler falls back to the generic PageHWPoison check abov=
e.

Yes, exactly. If we return ERR_PTR we need modify the above code
accordingly. But returning the page, no change is required.

>
> > >
> > > It seems page fault check IS_ERR(page) then just return
> > > VM_FAULT_HWPOISON. But I found a couple of places in shmem which want
> > > to return head page then handle subpage or just return the page but
> > > don't care the content of the page. They should ignore hwpoison. So I
> > > guess we'd better to have a FGP flag for such cases.
>
> At least currently thp are supposed to be split before error handling.

Not for file THP.

> We could loosen this assumption to support hwpoison on a subpage of thp,
> but I'm not sure whether that has some benefit.

I don't quite get your point. Currently the hwpoison flag is set on
specific subpage instead of head page.

> And also this discussion makes me aware that we need to have a way to
> prevent hwpoisoned pages from being used to thp collapse operation.

Actually not. The refcount from hwpoison could prevent it from
collapsing. But if we return ERR_PTR (#3) we need extra code in
khugepaged to handle it.

So I realized #1 would require fewer changes. And leaving the page
state check to callers seem reasonable since the callers usually check
other states, e.g. uptodate.


>
> Thanks,
> Naoya Horiguchi
