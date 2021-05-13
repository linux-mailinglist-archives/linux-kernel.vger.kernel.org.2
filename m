Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94B237FBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhEMQwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhEMQwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:52:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75530C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:51:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id c22so12685147ejd.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+x/gpF6l0HoceprgaR+m+dBIab4JXxPwBNySb5f8CY=;
        b=kdPIZROcykp+3ZiaBH0uhIag+D1DVbvcU9m/td9lrDAczqXZpBOG5Hs7cAdSisxAdE
         uk4MgspLwNUEwKFAklFzc0EdjPEjcLUJGk2hw0mSAwxg+w6epSfnA8U6I3eRep5D+qWn
         duQ1M6VVn4SvIC5qr556hZrkGEhAaezP7GyUrxMe8gYriwyKywEm2Yvgt8IjJQqTJTPa
         BeM85Ij2irgx9pHQyLOMLz8z40A04ZOcWtug+fSq9oru/j6eYFqu76YBD9WPiaqHBMS1
         VuJ/MjB5lT0zOke0wIpdSqVq07LvM3u2i3sGafCL/PVCZ/6SZ69N/mFroEPzwwqempas
         cHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+x/gpF6l0HoceprgaR+m+dBIab4JXxPwBNySb5f8CY=;
        b=nf4H9EfWn79dpCS7Q2mTYUm3NhaXOuHY8X2qUX9LPsp4n4wRheP87Aq1trOPxab2zi
         jmM0GuVpkUAu513qgpr/Izl2NBlrYyK12e6Txp2DIqus4co418+0vpmYRwiM+l1tETSq
         rnbGRZ3DhDPg0MIEDalEk25s4x7wFvId0z98zb4krOO7/VPrKArGkoao21l+UJimBQqp
         9UCmZeSexpQgMJOJJafvQ9q/CcQWhHhqi5EbDboxkavZQ3y5gu0PuWmyHs4dw07hPAK8
         N6amNWlbe8yCDNcb7Lwrv98aA3s0XOmPAF7Yj03RCfADgKr2mO9X8n/o+eH8pB0PSCr6
         bl0g==
X-Gm-Message-State: AOAM532ItAm1cQVDZu3kSkEsJ+OzX9CTk+trgDRgQy3cJ1WsZiUUoJrS
        DGBmBDMV9bjt/hxqg3zWnL1A2g1mPZBQc6CtxndWR0lfaTU=
X-Google-Smtp-Source: ABdhPJyFr0RFygozyGcTC/b9RkCKOMNOZWjjgUbBTTPNQdqjs0ul0Up6iQhjq31yiRfEYzPNpkGONjY/sEQCndNfYr0=
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr44621223ejf.25.1620924668070;
 Thu, 13 May 2021 09:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <1620890438-9127-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1620890438-9127-1-git-send-email-anshuman.khandual@arm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 13 May 2021 09:50:55 -0700
Message-ID: <CAHbLzkpMF9b148ois7vMPrB9TVQNAfObWD=b02RFFvYBGhX3mg@mail.gmail.com>
Subject: Re: [RFC] mm/thp: Update mm's MM_ANONPAGES stat in set_huge_zero_page()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:20 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Although the zero huge page is being shared across various processes, each
> mapping needs to update its mm's MM_ANONPAGES stat by HPAGE_PMD_NR in order
> to be consistent. This just updates the stats in set_huge_zero_page() after
> the mapping gets created.

I don't get why MM_ANONPAGES needs to be inc'ed when huge zero page is
installed. This may cause inconsistency between some counters, for
example, MM_ANONPAGES may be much bigger than anon LRU.

MM_ANONPAGES should not be inc'ed unless a new page is allocated and
installed, right?

>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Should it update MM_SHMEM_PAGES instead ? Applies on latest mainline.
>
>  mm/huge_memory.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..262703304807 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -706,6 +706,7 @@ static void set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
>         if (pgtable)
>                 pgtable_trans_huge_deposit(mm, pmd, pgtable);
>         set_pmd_at(mm, haddr, pmd, entry);
> +       add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
>         mm_inc_nr_ptes(mm);
>  }
>
> --
> 2.20.1
>
>
