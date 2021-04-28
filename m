Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E32D36DCE3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbhD1QWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbhD1QWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:22:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF10EC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:22:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id zg3so13910509ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMB6lxmPnvhCab0TpujzWdPU0Z4pjoErZwLGf29ahVs=;
        b=rbWVvBwOF0IKkWL6UqJvyx5PA9puqWJNnasIOJRVGqj9NfFdC4XB1IShjwmEo6eAe5
         9LMU6+YxYMCBCGkHK5kHKch+fScAhE7sPwM+fH2BGttU53f7QfvcN2AQ2Aqx2VVauBlA
         vlZx0I8cmuiofoTKBs9Xh8XU0pMbCW0QKHz3GLmBfGdRmF92H7oQxy7pnkzDwYVDer22
         CAK/uEOoL6iHWOjnuHw/bsyxoM+dhUu+Kq8+QIT0ZlShqyC62Fr71zZm2TpKhR0rhxzN
         cfgTvHLLkXpiHiTlG3LHrcLvtPNN/UoESKoO5hFh/9aA8Yai525nr6nPfoOFKONxPm+2
         9UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMB6lxmPnvhCab0TpujzWdPU0Z4pjoErZwLGf29ahVs=;
        b=Vt2y/F+6E1A0j96tx8q36TfOKwaosXEbY70pD9g5fLcN0sEwZ9zPQL2yap+BBpcQTG
         i64XTAZ+Xi64QHimhuSPsp8fUrYQqEV/wTyB0pEzQiv7WnUXLkHMDYntoDIACk99F5B8
         A0DHRA3NPmazqZaj8Sc9P0FzMTKJtyohk/dlzgAsRKe7mBmilKL8F2oOUyCS3hkvmgBG
         EH5k4ToSR7YM0I21L9TVB8hZ4lNXMER6KsjHhRsTKTak+FIBUOqZ9UQ4bWZvLuzs+/uR
         WrMC1e0UW1H29/8bQUf2VqaLPM6wSnRFYWc9zeWVFKW4fidVwWI/YoNOcTRPGh1TnEUp
         IQZw==
X-Gm-Message-State: AOAM533w/FVxSUh34LYXYjL5aYNQJDYw2rKcAoAxb5l7Ug2I3/GI/t1n
        eJs0+N/bJJ09E0ApgovgSVlq4XHXRiTRSee0g2c=
X-Google-Smtp-Source: ABdhPJwRBzNaPHfGJyPs1X6LjTtSk+HM8vD2TZkmDC2eYJjlc920w3dQIrDcjNcECOkgxHQ71daNirKgDsMP5XH0Ulc=
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr30322064ejf.25.1619626927582;
 Wed, 28 Apr 2021 09:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210427133214.2270207-1-linmiaohe@huawei.com>
 <20210427133214.2270207-4-linmiaohe@huawei.com> <CAHbLzkrBAtTM8aE_pM4ASQ6cGyfPcs7_7HPJLCd9T24VyqU5wQ@mail.gmail.com>
 <1fa95721-2ae0-af5f-b2e4-cdb430ebc263@huawei.com>
In-Reply-To: <1fa95721-2ae0-af5f-b2e4-cdb430ebc263@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 28 Apr 2021 09:21:55 -0700
Message-ID: <CAHbLzkr6j2TFUTUv3kEXR-jKQ+Qc11su2r9U-KiDjG4KrnGRkQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/huge_memory.c: add missing read-only THP checking
 in transparent_hugepage_enabled()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        william.kucharski@oracle.com, Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        aneesh.kumar@linux.ibm.com, Ralph Campbell <rcampbell@nvidia.com>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 7:06 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2021/4/28 5:03, Yang Shi wrote:
> > On Tue, Apr 27, 2021 at 6:32 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
> >> (non-shmem) FS"), read-only THP file mapping is supported. But it
> >> forgot to add checking for it in transparent_hugepage_enabled().
> >>
> >> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/huge_memory.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 76ca1eb2a223..aa22a0ae9894 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -74,6 +74,9 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
> >>                 return __transparent_hugepage_enabled(vma);
> >>         if (vma_is_shmem(vma))
> >>                 return shmem_huge_enabled(vma);
> >> +       if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> >> +           (vma->vm_flags & VM_DENYWRITE))
> >> +               return true;
> >
>
> Many thanks for your quick respond and Reviewed-by tag!
>
> > I don't think this change is correct. This function is used to
> > indicate if allocating THP is eligible for the VMAs or not showed by
> > smap. And currently readonly FS THP is collapsed by khugepaged only.
> >
> > So, you need check if the vma is suitable for khugepaged. Take a look
> > at what hugepage_vma_check() does.
> >
> > And, the new patch
> > (https://lore.kernel.org/linux-mm/20210406000930.3455850-1-cfijalkovich@google.com/)
> > relax the constraints for readonly FS THP, it might be already in -mm
> > tree, so you need adopt the new condition as well.
> >
>
> Many thanks for your comment. I referred to what hugepage_vma_check() does about
> Read-only file mappings when I came up this patch. But it seems I am miss something.

Yes, you need do the below check for readonly FS THP too:

if ((vm_flags & VM_NOHUGEPAGE) ||
    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
return false;

This check is done separately for anonymous and shmem. It seems not
perfect to do it three times in a row. So I'd suggest extracting the
check into a common helper then call it at the top of
transparent_hugepage_enabled() .

The helper also could replace the same check in
__transparent_hugepage_enabled() and shmem_huge_enabled().

> Take the new patch into account, the check for READ_ONLY_THP now should be:
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 76ca1eb2a223..a46a558233b4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -74,6 +74,10 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>                 return __transparent_hugepage_enabled(vma);
>         if (vma_is_shmem(vma))
>                 return shmem_huge_enabled(vma);
> +       if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> +           !inode_is_open_for_write(vma->vm_file->f_inode) &&
> +           (vma->vm_flags & VM_EXEC))
> +               return true;
>
>         return false;
>  }
>
> Am I miss something about checking for READ_ONLY_THP case? Or READ_ONLY_THP case is ok
> but other case is missed? Could you please explain this more detailed for me?
>
> Many thanks!
>
> >>
> >>         return false;
> >>  }
> >
> >> --
> >> 2.23.0
> >>
> >>
> >
> > .
> >
>
