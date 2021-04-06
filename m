Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E16355D99
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 23:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbhDFVFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 17:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhDFVFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 17:05:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3D2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 14:04:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a25so1080664ejk.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+joV+qmAQTX6W5D3ult4hJeoWrn1GtjQphIjc6QUDxI=;
        b=o0Wne08IYo8GRQHbrIO11Ao58rWJ1IwKE8wsCtFNNWepfoVVyUe2rSMttI8A2tFlHv
         rKndxv4Aiy/sGI78RU1VQsnJPZB+2/484cCVlFb/1W2uTtgmlq62eopat5LuicFaGshW
         ONKxVO17t/L9ygq7tT4vAoURr+Qsz8qeaA4jboyLP8soPHzi7OjLo4OmaWFN3ZKrQT/q
         pZT3xyOZV0EpW0zBjT8EASLMUfhNkVR1hQJOo1BtdpUq6Flc32pa+gj+bBo1N3cgoMhC
         XvHGDqfiA42fBy2ciR/lpq+kwbrLO8SzyxNU0lYObrqVygxYqsImsdzawR3FvkU8Z878
         DP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+joV+qmAQTX6W5D3ult4hJeoWrn1GtjQphIjc6QUDxI=;
        b=bbNiOuEKLGJnAIZsfSudgxf5R4xvt0psRD+LlmE2S+vpr600Fvw2T7mx9fsW4hsNpO
         wIbTAiA5MzNGFYpdOu+ipu7nCSL6YgnQ1TcWVB/Cao4iFB8jcUQ0ReQLZ7DK7YgXxBD1
         GtjZYfq397U5ID8PBhnlGeb0qPGmzUoQ4Uvt0lb3OM8hG3xSC4BtqXOzsnJeDj5jJAcf
         SPv0nLSm4teCQrLSvPTBZqQesGdPmDqY3Uz6CZtIrotyBufVBCf3KEqj94JAOMklkxJg
         2q6FXmeTyoDbhS3E1lm8uZneHwh2OMO3fLaMPPZjM3Li3fWID8h+5PfAWQAWdt4cCP/S
         waRg==
X-Gm-Message-State: AOAM530VFCHk0cjo6NMC9cKB+B+QnLDgw/RjBd3VIucTAfIwA+A4UMX4
        Qi3QQDJZSNbW82kiG/30Io4x+PZ8lovhTXRiNxk=
X-Google-Smtp-Source: ABdhPJx++EtRbXkk8rcqprgz5WDhhuyU8NprIgw4QUprSaRB29XyhBJim/pfK9Zu3YxyrlFKXoAYsh3QZDS9EXv9bys=
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr36694251ejf.25.1617743098057;
 Tue, 06 Apr 2021 14:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210404153311.1460106-1-yanfei.xu@windriver.com>
 <20210404153311.1460106-3-yanfei.xu@windriver.com> <CAHbLzkrSaODz+SeT+GY3tOS6Jm8NSznmknP83RUCrn+Sr9cAAg@mail.gmail.com>
 <e0fa88df-ff8b-f820-e255-92fbeecc37e6@windriver.com> <6d188d5b-94d0-1606-52c2-a3e0b6455a27@windriver.com>
In-Reply-To: <6d188d5b-94d0-1606-52c2-a3e0b6455a27@windriver.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 6 Apr 2021 14:04:46 -0700
Message-ID: <CAHbLzkrzy+c2igYEW00bO6EqMNZMwntXQA6nyn0n_vUXyTXU0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: khugepaged: check MMF_DISABLE_THP ahead of
 iterating over vmas
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 5, 2021 at 8:05 PM Xu, Yanfei <yanfei.xu@windriver.com> wrote:
>
>
>
> On 4/6/21 10:51 AM, Xu, Yanfei wrote:
> >
> >
> > On 4/6/21 2:20 AM, Yang Shi wrote:
> >> [Please note: This e-mail is from an EXTERNAL e-mail address]
> >>
> >> On Sun, Apr 4, 2021 at 8:33 AM <yanfei.xu@windriver.com> wrote:
> >>>
> >>> From: Yanfei Xu <yanfei.xu@windriver.com>
> >>>
> >>> We could check MMF_DISABLE_THP ahead of iterating over all of vma.
> >>> Otherwise if some mm_struct contain a large number of vma, there will
> >>> be amounts meaningless cpu cycles cost.
> >>>
> >>> BTW, drop an unnecessary cond_resched(), because there is a another
> >>> cond_resched() followed it and no consumed invocation between them.
> >>>
> >>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> >>> ---
> >>>   mm/khugepaged.c | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >>> index 2efe1d0c92ed..c293ec4a94ea 100644
> >>> --- a/mm/khugepaged.c
> >>> +++ b/mm/khugepaged.c
> >>> @@ -2094,6 +2094,8 @@ static unsigned int
> >>> khugepaged_scan_mm_slot(unsigned int pages,
> >>>           */
> >>>          if (unlikely(!mmap_read_trylock(mm)))
> >>>                  goto breakouterloop_mmap_lock;
> >>> +       if (test_bit(MMF_DISABLE_THP, &mm->flags))
> >>> +               goto breakouterloop_mmap_lock;
> >>
> >> It is fine to check this flag. But mmap_lock has been acquired so you
> >> should jump to breakouterloop.
> >
> > Oops! It's my fault. Thank you for pointing out this.
> > Will fix it in v2.
> >
> >>
> >>>          if (likely(!khugepaged_test_exit(mm)))
> >>>                  vma = find_vma(mm, khugepaged_scan.address);
> >>>
> >>> @@ -2101,7 +2103,6 @@ static unsigned int
> >>> khugepaged_scan_mm_slot(unsigned int pages,
> >>>          for (; vma; vma = vma->vm_next) {
> >>>                  unsigned long hstart, hend;
> >>>
> >>> -               cond_resched();
> >>
> >> I don't have a strong opinion for removing this cond_resched(). But
> >> IIUC khugepaged is a best effort job there is no harm to keep it IMHO.
> >>
> >
> > Yes, keeping it is no harm. But I think we should add it when we need.
> > Look at the blow codes, there are only some simple check between these
> > two cond_resched().  And we still have some cond_resched() in the
> > khugepaged_scan_file() and khugepaged_scan_pmd() which is the actual
> > wrok about collapsing. So I think it is unnecessary.  :)
> >
>
> BTW, the original author add this cond_resched() might be worry about
> the hugepage_vma_check() always return false due to the MMF_DISABLE_THP.
> But now we have moved it out of the for loop of iterating vma.

A little bit of archeology showed the cond_resched() was there in the
first place even before MMF_DISABLE_THP was introduced.

>
> um.. That is my guess..
>
> Thanks,
> Yanfei
>
> >          for (; vma; vma = vma->vm_next) {
> >                  unsigned long hstart, hend;
> >
> >          cond_resched();                 //here
> >                  if (unlikely(khugepaged_test_exit(mm))) {
> >                          progress++;
> >                          break;
> >                  }
> >                  if (!hugepage_vma_check(vma, vma->vm_flags)) {
> > skip:
> >                          progress++;
> >                          continue;
> >                  }
> >                  hstart = ALIGN(vma->vm_start, HPAGE_PMD_SIZE);
> >                  hend = ALIGN_DOWN(vma->vm_end, HPAGE_PMD_SIZE);
> >                  if (hstart >= hend)
> >                          goto skip;
> >                  if (khugepaged_scan.address > hend)
> >                          goto skip;
> >                  if (khugepaged_scan.address < hstart)
> >                          khugepaged_scan.address = hstart;
> >                  VM_BUG_ON(!IS_ALIGNED(khugepaged_scan.address,
> > HPAGE_PMD_SIZE));
> >
> >                  if (shmem_file(vma->vm_file) && !shmem_huge_enabled(vma))
> >                          goto skip;
> >
> >                  while (khugepaged_scan.address < hend) {
> >                          int ret;
> >                          cond_resched();        //here
> >
> >
> >>>                  if (unlikely(khugepaged_test_exit(mm))) {
> >>>                          progress++;
> >>>                          break;
> >>> --
> >>> 2.27.0
> >>>
> >>>
