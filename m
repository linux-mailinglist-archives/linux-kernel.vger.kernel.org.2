Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014B5337E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCKTc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 14:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKTcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:32:24 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D18DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:32:24 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id b10so731481vkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C0wdrEAiMMmWHLihbdoEejdJOqcekwArwh5nWI9AF+E=;
        b=pfKBKvLcSEh2rf6Tz2UqQC334LNNdGbmXRRdPFfPxFwCOfENfCMYzVniP+pNXUO51n
         CQhSKFtZDS/FSvZfdtmYMbKeFWFVrEdbLxZZQrke+CrGr0GH9Xf1YHoq8ZsPdCRLakzh
         k3lNNPGv8cPmQk/lTuzRh8m/jsle+oKcczY1DDUlbYzuYv2Tu95yeNFdntqXvGldr8b1
         r08bbJQtXfomjwkbSeIrUWxwk/IAr8HHJxATFRXTqOR1wsZvMRjCGsEeiCsGq6U30VkY
         pGcCz/r2qXA/wQo2HWq/3h0Cnn2Kk/GAhUK1ixUUVlehsYCtS+8Ym4e7GyOC+kqLUeVZ
         WZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C0wdrEAiMMmWHLihbdoEejdJOqcekwArwh5nWI9AF+E=;
        b=prfzuXI1Ds9OM0rewKMdZy6JshI+96tMsSMAPN5vAJcFFsGD3AT9jie1chXN0iHRAb
         iDrazunHcQvA7Zcw8KlJDdmRrSZDCzaD4FAvzzh/KHUkMP0XBaFRkNvnhlZ2HEt+9aZR
         w39g9hqkGEnbBIL0LM8Z9n1QCv9osuvecK35n/DgZSkuGHsccDP/OTqQ9arrFw5DDKf3
         qcubKiZU5HSg/38SyWr8enw1gPGy4cVaySby3lkz8ooecTTSWsbp0ZCIYKfJkjxN8PTU
         rbONPE2EgzdkXa3rauovTgdPFL1LSFQweBALgedbWILCld5lvI1HB+z0+FkePFKKlqlw
         LGeg==
X-Gm-Message-State: AOAM530MS6r9MIVEf/Ezi84xidn9FOY+byhtaO7thRfmfM2npUfdiFaX
        SGHAmqEyUmT2WW5hANz3sHW0wOecrsWlERvmej4nGA==
X-Google-Smtp-Source: ABdhPJxN9I8OGtcD4FwpVzjbwJWAGogBPlnFfl0ADXmkUxUu3+PaAv72E+nohGXh2dZ1mWPFPaQ/qII823BVrfoHJxg=
X-Received: by 2002:a1f:b686:: with SMTP id g128mr5810836vkf.25.1615491143184;
 Thu, 11 Mar 2021 11:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20210209062128.453814-1-nao.horiguchi@gmail.com>
 <alpine.LSU.2.11.2103102214170.7159@eggly.anvils> <20210311151446.GA28650@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210311151446.GA28650@hori.linux.bs1.fc.nec.co.jp>
From:   Jue Wang <juew@google.com>
Date:   Thu, 11 Mar 2021 11:32:12 -0800
Message-ID: <CAPcxDJ6D5OS+XRYbqpr-7bhYCySX=jdPZdZvQL1ecSrQoDEieg@mail.gmail.com>
Subject: Re: [PATCH v1] mm, hwpoison: enable error handling on shmem thp
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Greg Thelen <gthelen@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huge thanks to Hugh for his expertise in shmem thps and forwarding this mes=
sage!

Hi Naoya,

This is the first time I reply to an email in a Linux upstream thread,
apologies for any technical issues due to my email client. And my
apologies for the state of the whole patch not quite shareable with
upstream due to some kernel differences.

Some fyi comment inline.

Thanks,
-Jue





On Thu, Mar 11, 2021 at 7:14 AM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Wed, Mar 10, 2021 at 11:22:18PM -0800, Hugh Dickins wrote:
> > On Tue, 9 Feb 2021, Naoya Horiguchi wrote:
> >
> > > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > >
> > > Currently hwpoison code checks PageAnon() for thp and refuses to hand=
le
> > > errors on non-anonymous thps (just for historical reason).  We now
> > > support non-anonymou thp like shmem one, so this patch suggests to en=
able
> > > to handle shmem thps. Fortunately, we already have can_split_huge_pag=
e()
> > > to check if a give thp is splittable, so this patch relies on it.
> >
> > Fortunately? I don't understand. Why call can_split_huge_page()
> > at all, instead of simply trying split_huge_page() directly?
>
> The background of this change was that I've experienced triggering
> VM_BUG_ON_PAGE() at the beginning of split_huge_page_to_list() in the old=
er
> kernel (I forgot specific condition of the BUG_ON).  I thought that that =
was
> caused by race between thp allocation and memory_failure.  So I wanted to
> have some rigid way to confirm that a given thp is splittable.  Then I fo=
und
> can_split_huge_page(), which sounds suitable to me because I expected the=
 API
> to be maintained by thp subsystem.
>
> But I rethink that split_huge_page_to_list() seems to have different set =
of
> VM_BUG_ON_PAGE()s now, and anyway split_huge_page_to_list() calls
> can_split_huge_page() internally, so I might have wrongly read the code.
>
> > And could it do better than -EBUSY when split_huge_page() fails?
>
> Yes it could.
>
> >
> > >
> > > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> >
> > Thanks for trying to add shmem+file THP support, but I think this
> > does not work as intended - Andrew, if Naoya agrees, please drop from
> > mmotm for now, the fixup needed will be more than a line or two.
>
> I agree to drop it. I need research more to address the following comment=
s.
>
> >
> > I'm not much into memory-failure myself, but Jue discovered that the
> > SIGBUS never arrives: because split_huge_page() on a shmem or file
> > THP unmaps all its pmds and ptes, and (unlike with anon) leaves them
> > unmapped - in normal circumstances, to be faulted back on demand.
> > So the page_mapped() check in hwpoison_user_mappings() fails,
> > and the intended SIGBUS is not delivered.
>
> Thanks for the information.  The split behaves quite differently between
> for anon thp and for shmem thp.  I saw some unexpected behavior in my
> testing, maybe that's due to the difference.
>
> >
> > (Or, is it acceptable that the SIGBUS is not delivered to those who
> > have the huge page mapped: should it get delivered later, to anyone
> > who faults back in the bad 4k?)
>
> Later access should report error in page fault, so the worst scenario
> of consuming corrupted data does not happen, but precautionary signal
> does not work so it's not acceptable.
In our experiment with SHMEM THPs, later accesses resulted in a zero
page allocated instead of a SIGBUS with BUS_MCEERR_AR reported by the
page fault handler. That part might be an opportunity to prevent some
silent data corruption just in case.
>
> >
> > We believe the tokill list has to be set up earlier, before
> > split_huge_page() is called, then passed in to hwpoison_user_mappings()=
.
> >
> > Sorry, we don't have a proper patch for that right now, but I expect
> > you can see what needs to be done.  But something we found on the way,
> > we do have a patch for: add_to_kill() uses page_address_in_vma(), but
> > that has not been used on file THP tails before - fix appended at the
> > end below, so as not to waste your time on that bit.
> >
>
> Thank you very much, I'll work on top of it.
>
> Thanks,
> Naoya Horiguchi
>
> ...
> >
> > [PATCH] mm: fix page_address_in_vma() on file THP tails
> > From: Jue Wang <juew@google.com>
> >
> > Anon THP tails were already supported, but memory-failure now needs to =
use
> > page_address_in_vma() on file THP tails, which its page->mapping check =
did
> > not permit: fix it.
> >
> > Signed-off-by: Jue Wang <juew@google.com>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> >
> >  mm/rmap.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > --- 5.12-rc2/mm/rmap.c        2021-02-28 16:58:57.950450151 -0800
> > +++ linux/mm/rmap.c   2021-03-10 20:29:21.591475177 -0800
> > @@ -717,11 +717,11 @@ unsigned long page_address_in_vma(struct
> >               if (!vma->anon_vma || !page__anon_vma ||
> >                   vma->anon_vma->root !=3D page__anon_vma->root)
> >                       return -EFAULT;
> > -     } else if (page->mapping) {
> > -             if (!vma->vm_file || vma->vm_file->f_mapping !=3D page->m=
apping)
> > -                     return -EFAULT;
> > -     } else
> > +     } else if (!vma->vm_file) {
> > +             return -EFAULT;
> > +     } else if (vma->vm_file->f_mapping !=3D compound_head(page)->mapp=
ing) {
> >               return -EFAULT;
> > +     }
> >       address =3D __vma_address(page, vma);
> >       if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
> >               return -EFAULT;
> >
