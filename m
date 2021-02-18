Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EED31F11F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhBRUhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhBRUgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:36:12 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E0C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:35:31 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id i8so3395131iog.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbAEG2PifLQ/VqMicX/G7j56UYCqmvzR+QI2lQowe2A=;
        b=IqbSvbDFA0ZhYx6Yp4mSkEQzRdoLP9FBgpXdaG9uKeVHmJuEWzUs+K5XmX4LxSKWcL
         IrUZv/Ksp2L+fGJPS3/2i9YBCvwpN/nAzeF2qiG0U2qwAxjahEUxNx8m/c+8l9iP7FoK
         e1V/0ZRQpXAseW/mNSe5AXTCqtIbjnWmDaN/dxT8DzSEXGtAv56xXKM6F9480NyADYpi
         80lnYdj2miubYgoBD6HcIwX33zvCV9wrPk+VN+qMX7J/hKlkYBCBoxDNgDUQs641lGzQ
         vQ1oC6TC0c/ABk1+kFk65R+4x0t4+mofitgRn40e2hNZsY/q4ZaLzo7lo9VpFNoQF/48
         Y19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbAEG2PifLQ/VqMicX/G7j56UYCqmvzR+QI2lQowe2A=;
        b=i7cS+cDm6gHxOsN1tYOGcT+cJu0WMrOkHZIBGbE3BAiQ4vjHnpCK4qngJKkYZ0h9e+
         UpiWTnVwwZWgYISNUDVoR1iuOf1K2+mohYyIAgGw3IIO19rbeenLx1EPYQkMa0uREwIN
         fSWtTgoAzdT49dNGYsi4aLHChcSBibGcGsa45mX7FamdLvKwDBsOhi5ld1rIp6fi5XZ5
         4NaKktI+UobifOOymqXXd2IJBfrShUpkupu3LT+4fcY4sdQyeWSeVHOV0pS014NiVmV0
         vqSoO1UMZFG9ayCykTbtcc+TMhMaBwYPVMdrcPznUoKyOfotF8Lv55kU/aQDEP6D+GwO
         4mfw==
X-Gm-Message-State: AOAM531edPZS68MmDkSWWjPfI0/Ai+TxGHBYZiRfQTuO/S0TVdeWEPyJ
        bRTZ/D/8NS2z8JnzbnHdv459Ybr2WZOO2rwS6DDcsg==
X-Google-Smtp-Source: ABdhPJyWjZ08w2Fog4XJ/edAAhQEhBdT/movvv7vnvK1QF0dLxKTJQLwBbWm4fK0pcrmqL2aOOKubLvFun3le37zzII=
X-Received: by 2002:a02:6911:: with SMTP id e17mr3303786jac.99.1613680531165;
 Thu, 18 Feb 2021 12:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20210217204418.54259-1-peterx@redhat.com> <20210217204619.54761-1-peterx@redhat.com>
 <20210217204619.54761-3-peterx@redhat.com> <CAJHvVchtVtDHE2iJRAmraL+kbTezgfck0Mgj7xM+7U5yaJ5aCQ@mail.gmail.com>
 <20210218203214.GD108961@xz-x1>
In-Reply-To: <20210218203214.GD108961@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 18 Feb 2021 12:34:55 -0800
Message-ID: <CAJHvVch79WBzudS7BU5Lg2et4_2XQM=mEdW=YpbyX1QHHp=tQg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:32 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 18, 2021 at 10:32:00AM -0800, Axel Rasmussen wrote:
> > > @@ -1448,6 +1449,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >                 vma->vm_flags = new_flags;
> > >                 vma->vm_userfaultfd_ctx.ctx = ctx;
> > >
> > > +               if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
> > > +                       hugetlb_unshare_all_pmds(vma);
> >
> > This line yields the following error, if building with:
> > # CONFIG_CMA is not set
> >
> > ./fs/userfaultfd.c:1459: undefined reference to `hugetlb_unshare_all_pmds'
>
> Ouch..  Axel, you mean CONFIG_HUGETLBFS rather than CONFIG_CMA, am I right?

Surprisingly no, there's a "#ifdef CONFIG_CMA" line ~100 lines above
where hugetlb_unshare_all_pmds is defined in hugetlb.c which causes
this. My guess is that putting the function inside that block was
accidental and it can just be moved.

>
> --
> Peter Xu
>
