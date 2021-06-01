Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4BE397917
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhFARcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhFARcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:32:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A962C061574;
        Tue,  1 Jun 2021 10:30:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s6so18342864edu.10;
        Tue, 01 Jun 2021 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZU7MeMeqaOuCTZ3sqp7bNYhGpsFZJI5NcMTixuEmNc=;
        b=n9Lkz/pQ9CpyYXguK6RFMVoa//agj46r+6vl7yAaoW12EwCNXx87X8icEPAZtFBBsY
         iAbIjVUHXw2q8R5OsNvAFcEpET/6nZ8qHI7ZbqqES/DFhTD1uCFaLfIhTTnxSox6tIDC
         I0TsUS5YS76KnR2D9vljqANHKlocu7ceGhkpW/e7LbN2FjTWy1O6SCNnegExUZQoFYmn
         CAG+UfgY9YakqAlJfh4PIF4vmVtUwf890jHcUKUGg5XBYoZ0+HYEzHNIfsWz0iqyJEHh
         lZQm6MUB/HBW9vcCprnYYEid4l00IACyaGO0cPC7iA7I16lE5AzQa+zTzoaxz0PB962U
         DwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZU7MeMeqaOuCTZ3sqp7bNYhGpsFZJI5NcMTixuEmNc=;
        b=D1beHgTJihb4qQlGeF5gP/rWg7zvVELBFq0ulWXrdffJEQf2KXPI3aR6y0QIZYKxwW
         AVSSU7QG+dHUeeqa2l/R1YidE6+37pgpjUFMsf5t01fNRLA/Euc+r3WtwWh4uYax+BYx
         cX2NqqIbWuoDUcN1U+y82txfo4fC9BXYqznE8sRzxbVLUPBNDbS6iojh3557kQVlyDT7
         lPdUCtn2tDQSeHLqoQE36R4Xp3kEycltbDiWEsd7NZAHnJdTM9hkH9/YWZgReUsTbDKI
         DNubWF2U9cvDwx/jnwgsBA52tdm57n1X0sqSST7xd7GpMm93JVSdEkOlLaA9LYSb8Jjd
         qbHg==
X-Gm-Message-State: AOAM532Gegsux32aYPD9ANlsTOHyuKYYnERrwc1l62Wfbq/QLGw9K6r9
        KerKcfq6vOkDyOwqvUCVB44vJYv207/Bnu/m1bq0Ein8uDM=
X-Google-Smtp-Source: ABdhPJyapykyMAghFYqhlGXruK4mnwOOIfqX2WKDoXOZPMZ4aqHhZ6LL4Gyfo4slkwBtRa+WuZSOuuveZTkz7XRLEq8=
X-Received: by 2002:a05:6402:145a:: with SMTP id d26mr2712959edx.151.1622568629059;
 Tue, 01 Jun 2021 10:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <YLX8uYN01JmfLnlK@mwanda>
In-Reply-To: <YLX8uYN01JmfLnlK@mwanda>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Jun 2021 10:30:17 -0700
Message-ID: <CAHbLzkpkxJHVaihrPWV04ejgbaJU4xiN7xTvfHcn33cX6JcgYA@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: fix a double unlock bug
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 2:24 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We're supposed to be holding the "vmf->ptl" spin_lock when we goto
> out_map.  The lock is dropped after if finishes cleaning up.
>
> Fixes: 9aff7b33c74a ("mm: thp: refactor NUMA fault handling")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for catching this. Acked-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/huge_memory.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e353bbc6cee3..caa0148f15bb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1465,10 +1465,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>
>         pmd = pmd_modify(oldpmd, vma->vm_page_prot);
>         page = vm_normal_page_pmd(vma, haddr, pmd);
> -       if (!page) {
> -               spin_unlock(vmf->ptl);
> +       if (!page)
>                 goto out_map;
> -       }
>
>         /* See similar comment in do_numa_page for explanation */
>         if (!was_writable)
> --
> 2.30.2
>
