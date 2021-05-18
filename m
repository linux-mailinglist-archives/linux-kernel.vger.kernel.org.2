Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12A388141
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbhERUVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbhERUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:21:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5ADC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:19:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lg14so16556524ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbjKDwD1WRRxmkhXc4f3TugAgjL4KbmiuHqJM1zpTUo=;
        b=IRuZgZtPG7LPVpmRZeET6NZ2nUuo/rMgBH40E6dtMMqRu/janHK2WrJ1WE5BQ6xR3L
         Of0dOjvc29GpBADtaHjv82d4GytQD3CByP51KBsTCelfA2a00s9gKUSteF5oAgznkjE/
         7+xvgGWolTbd7loHjJeop7lYPMFIZqHekb6wrP41Q2oTLsJj7J02CA+wt+sfWOuVR1KS
         QpaR+JzM5ud7py7Wd/q5k1n+b9Q+TRwljLGB58Rbwn0BPtvSsTjsbhWpaJgmYMc7IdKl
         qY9qylcFFgtdwiEdt9Yd4E6lyn4Qw0F8UF4LXVGtTYXhIwAu73QTmtdS/WVJT+QLTDsJ
         Zdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbjKDwD1WRRxmkhXc4f3TugAgjL4KbmiuHqJM1zpTUo=;
        b=KA3mCc+27rffqpo7I4aer2EmZCAwTBlUbmhgBmGBtu8rowsP5Mj4D2NIdJ7zCAjj0B
         0kSwQuHgTExeBF/kD+Rx1i0NzxOJCwVEctWaZ9tNjl6tmCNXFjcR9Hku2cmRN7cUrtpf
         5PjFy6ErNOvXpMBdwusDvOElxSIZobaX8fUZ/8ODYdcbWFmP/jXH2sWsE2CWGKz7wUfB
         ZkWevjOyP9RJh6s39uM1q94qLanbVf08/UIdGT7wznAg/5rPyXqBTfMN1YypYzPVMuwz
         8jPM6J3r1hsHOarbwbWLOWx7RXv+eZnh8laOomJHxkWjSJK89XgsNX5zyX+uuGkR4sXv
         4W9g==
X-Gm-Message-State: AOAM5321Wut9q4ax2Jd+EZMUMeNn94GhmH9aR79s5hQNl6R390CaaUfG
        hE0MexTcPladtffwzbB3JmOwdctG4GtE6HuQx0w=
X-Google-Smtp-Source: ABdhPJzztRLQmBRFMR015kSLwVbJs7ud7gcNtBafi3NrcJ4G/wbN67YksdWdiHm8F4e5xKQxmN/kDCovr3axkj55iUw=
X-Received: by 2002:a17:906:1699:: with SMTP id s25mr7720560ejd.238.1621369180706;
 Tue, 18 May 2021 13:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210518200927.69011-1-jrdr.linux@gmail.com>
In-Reply-To: <20210518200927.69011-1-jrdr.linux@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 18 May 2021 13:19:29 -0700
Message-ID: <CAHbLzkpZnqAwDDFYHwd7K7CA-8i1yZEwOVVZsb4GqA9_7XCz_Q@mail.gmail.com>
Subject: Re: [PATCH] mm/huge_memory.c: Remove unused variable unmap_success
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:09 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Kernel test robot throws below warning ->
>
>    mm/huge_memory.c: In function 'unmap_page':
> >> mm/huge_memory.c:2345:7: warning: variable 'unmap_success' set but not used [-Wunused-but-set-variable]
>     2345 |  bool unmap_success;
>          |       ^~~~~~~~~~~~~
>
> Remove the unused variable unmap_success.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Thanks for catching this. Reviewed-by: Yang Shi <shy828301@gmail.com>

Just like https://lore.kernel.org/linux-mm/CAHbLzkonsd9f=48+cxKOJamNb9e8qpvWJCYDGFB_wNTdET2zmQ@mail.gmail.com/T/#t,
not sure why my compiler didn't catch such warning.
> ---
>  mm/huge_memory.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 52ca04b905cf..ff79a12993c9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2342,14 +2342,13 @@ static void unmap_page(struct page *page)
>  {
>         enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
>                 TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> -       bool unmap_success;
>
>         VM_BUG_ON_PAGE(!PageHead(page), page);
>
>         if (PageAnon(page))
>                 ttu_flags |= TTU_SPLIT_FREEZE;
>
> -       unmap_success = try_to_unmap(page, ttu_flags);
> +       try_to_unmap(page, ttu_flags);
>  }
>
>  static void remap_page(struct page *page, unsigned int nr)
> --
> 2.25.1
>
>
