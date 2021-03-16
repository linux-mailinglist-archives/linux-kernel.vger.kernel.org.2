Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DEE33DD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbhCPTUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbhCPTTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:19:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E70C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:19:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z1so22908011edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6Vzk8VT7CSO7U742Td38RGtE0keze+h9TLzW6HQXXc=;
        b=GydREVbKMbv810VnAeG22Q4t4zqHtGsMA9e8miBDPJGGE9w0F9kExYqC06TyXXRPc7
         iEddchnK6lflk84Nu7mNvXulzjvPFLncGpGAUdnYyV/bNlTZQZiArosRQmNyVGvQF63g
         gbtomYgz3qPyaX36A2QZ9ug2Pp6FhwhmyKPD3mweUqrbjdBRMmGogPr/Hi2CmT/lkc2b
         uP+3zZ1auReC4wDx/38GAeC2FGkCg4u1uryGVuzUmFMjVeWlB3VzI5eOwnntuzHiH45C
         rNYx+/zNWfTkNd70LDaDJLOXfRMtlBOQSGfUrty0sXa6KW/gP1CirEWRF1kz+DAiFaek
         dE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6Vzk8VT7CSO7U742Td38RGtE0keze+h9TLzW6HQXXc=;
        b=E/fAymOQ1DrHhi1knyOWE/3LoE7Huy7twMPMjR5WQgIADfRF32ES5OI1e9PMEccZw2
         CbGwZSDllOB5yncSwLNqxeyl5zjy6rU7TZI9KuDO/MqvQF/UdnPYdgZjiiLWYmKqRCZO
         Bx0MLANZBB1mEvsCVMxoit+Qsb1nYV7ge/6GS1KeZdse1l/CVhsiXA5U3g6qdSDH+OV6
         lUOiiCeydh2mWhem1qLGcvdzjEoVIYopK9tXkNidgyBhZRvAfNSLhc/vUE6Fk/Lj+fvP
         hCb9OBcqAuceBM83V5lXIoqXU7oofpMDWfHqt5zrMoHMBt7th3447SCgJJ4QLirCBAZa
         X4Hw==
X-Gm-Message-State: AOAM5318tuo70H/6/2eZ0WVbN5QiI8NdcxC2YqgTDd/lpkBsXhZAdj1a
        pPwdSx66g1XxKYHJv0rz1DTHhQjiCagxelWP1Qmh6Q==
X-Google-Smtp-Source: ABdhPJzhGyum+xNFOIbL81WhK9++sMcatEGBHuDj59K3Cg00UwnFJJqkJvO+tbIT+09NtrXSAHWt2g64ElP4JLrxVQ8=
X-Received: by 2002:a05:6402:304b:: with SMTP id bu11mr36682115edb.157.1615922372300;
 Tue, 16 Mar 2021 12:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <alpine.LSU.2.11.2103131934290.18112@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2103131934290.18112@eggly.anvils>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 16 Mar 2021 15:18:55 -0400
Message-ID: <CADyq12z+o0Rtziprkfs=PX2MPRPZyWBSgONYrRggZ8TEifq2sg@mail.gmail.com>
Subject: Re: [PATCH] mm: Allow shmem mappings with MREMAP_DONTUNMAP
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,
Thanks for this suggestion, responses in line.

> A better patch would say:
>
> -       if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> -                       vma->vm_flags & VM_SHARED))
> +       if ((flags & MREMAP_DONTUNMAP) &&
> +           (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
>                 return ERR_PTR(-EINVAL);
>
> VM_DONTEXPAND is what has long been used on special mappings, to prevent
> surprises from mremap changing the size of the mapping: MREMAP_DONTUNMAP
> introduced a different way of expanding the mapping, so VM_DONTEXPAND
> still seems a reasonable name (I've thrown in VM_PFNMAP there because
> it's in the VM_DONTEXPAND test lower down: for safety I guess, and best
> if both behave the same - though one says -EINVAL and the other -EFAULT).

I like this idea and am happy to mail a new patch. I think it may make
sense to bring the lower block up here so that it becomes more clear
that it's not duplicate code and that the MREMAP_DONTUNMAP case
returns -EINVAL and other cases return -EFAULT. I wonder if the
-EFAULT error code would have made more sense from the start for both
cases, do you have any thoughts on changing the error code at this
point?

> With that VM_DONTEXPAND check in, Dmitry's commit cd544fd1dc92
> ("mremap: don't allow MREMAP_DONTUNMAP on special_mappings and aio")
> can still be reverted (as you agreed on 28th December), even though
> vma_is_anonymous() will no longer protect it.

I agree and if Dmitry does not have time I would be happy to mail a
revert to cd544fd1dc92 as we discussed in [1]. Dmitry, would you like
me to do that?

> Was there an mremap(2) man page update for MREMAP_DONTUNMAP?
> Whether or not there was before, it ought to get one now.

Yes, the mremap(2) man page was updated when this flag was added and
it will require a further update to reflect this expanded mapping
support.

Thanks
Brian

1. https://lkml.org/lkml/2020/12/28/2340
