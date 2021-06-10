Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13C73A2185
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 02:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhFJAkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 20:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFJAkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 20:40:35 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92344C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 17:38:40 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e10so38114099ybb.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 17:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2/f6S74QIZa+VUWQuoSSzousj3I48cGhlMI5oyO9WI=;
        b=jNmHpI0GwtQj0ih3Zrhtz0gf2nBWSoCFrw340eiHQOXdrijafJubsgHdqXhRpBb7i4
         a9PmfXgVyqzkIwJo1LvHtiF35nXLjTyxsT4tPjfUQVq8KevuiF/CZ8j0nwCw1wqt+yi+
         r7sEVtkCbgdFvQD0hkYWtn0CFCtBLxu0xd7IlUhadkGPDvrV0h2x02IDj9vCsFCp/8P1
         U9aYtq57VWOMteu5rQf1G9XUGEJ1a6JtBRSVdfEenjlSRQFaWeEruJ8TKbq8Q4b++gZI
         QmY/jL4KTmbAujwrChfUbVIa+73gkQZwh8wutS/Jxf5ubxZSZ+MBUPWWs8sMcoMo+W9Y
         uNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2/f6S74QIZa+VUWQuoSSzousj3I48cGhlMI5oyO9WI=;
        b=dkkN52z5OSHR8neQoPcb+kD7KOU/79Z8lGQnOuJEdvd9G2kL1771eNuzYnSdfx1KNy
         YwHBtHY9C7tbI/KIyPm8wFZX0z27IeYeOxjRQTXCoGMIfVFguoPg8/YfdcuREdeTTbVp
         kMcdiMrzZ99tdjKetT+U6hafMBag9ufmGzKstI29F0qVobZEWs7tLBZKPQEfYX/LneHn
         fgVbI5gJ9ZYRLVwoyHP2zo4FUvh2EbMn6eMQBvC/6nz4Ce+2tMwNKRJG4nvCPjhs2/Iw
         CPGPBi/WS4dvh6MDGQ8g1VN7MY1fjFoKnNK4s8COUg3fT53gyTog9X4TqVd/59Z60/0n
         6uFg==
X-Gm-Message-State: AOAM533+2B8wVlvg9KXH9+XvLPPZLDGTfvk2Bz8007k1nezUYfMklyse
        96MeyIkxK73TdIrIFR7yIUyGuyPf+C+t8zNnKS1J6Q==
X-Google-Smtp-Source: ABdhPJzNCnCV2wqj+tijkGyORCUKf+xMwXuX121HHUI0q7dl4yvfPYes2wMYp9v7OJmfJRFpnQfqozcC+tw0hUzL3DY=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr3563826ybg.111.1623285519598;
 Wed, 09 Jun 2021 17:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210430195232.30491-1-michel@lespinasse.org> <20210430195232.30491-5-michel@lespinasse.org>
In-Reply-To: <20210430195232.30491-5-michel@lespinasse.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 9 Jun 2021 17:38:28 -0700
Message-ID: <CAJuCfpFJfry1Td8Sbv27pqxE2CdSyH=6Cy065vL69JNQex1kOw@mail.gmail.com>
Subject: Re: [PATCH 04/29] do_anonymous_page: use update_mmu_tlb()
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 12:52 PM Michel Lespinasse
<michel@lespinasse.org> wrote:
>
> update_mmu_tlb() can be used instead of update_mmu_cache() when the
> page fault handler detects that it lost the race to another page fault.
>
> (TODO double check with Bibo Mao <maobibo@loongson.cn>)

You probably can drop this TODO. It looks like this one call was
missed in https://patchwork.kernel.org/project/linux-mips/patch/1590375160-6997-2-git-send-email-maobibo@loongson.cn
after Andrew asked to replace all update_mmu_cache() calls with an
alias in the previous version of this patch here:
https://patchwork.kernel.org/project/linux-mips/patch/1590031837-9582-2-git-send-email-maobibo@loongson.cn/#23374625.

>
> Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 550405fc3b5e..59ff65cb3ab4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3567,7 +3567,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>         vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>                         &vmf->ptl);
>         if (!pte_none(*vmf->pte)) {
> -               update_mmu_cache(vma, vmf->address, vmf->pte);
> +               update_mmu_tlb(vma, vmf->address, vmf->pte);
>                 goto release;
>         }
>
> --
> 2.20.1
>
