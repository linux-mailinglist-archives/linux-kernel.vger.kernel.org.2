Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796A34043EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 05:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350083AbhIIDYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 23:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbhIIDXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 23:23:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EE2C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 20:22:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q3so634822edt.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 20:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpXgtd6llm5EYXYD9SbAG8NLcGpwtyJ1cM/ICnpdcRk=;
        b=LXleL7MjU+eD7n5fhiebmisBxoLwH6T4J+SGXTcurH8Cpnzy11Sj1ewq/UZORKhMbO
         7dvPH1sgJR/ax52NpBRgWBtwyzB8QbRRCtlJGk+Hrm+7WY9iM+eoJdSOlOFPbnXI5taZ
         RenuY+pl1+M+Nw3fWuMVH+U/lG3SljW3O7uXDNuvRCi1A7a0HhuDyrvgyyX8pKm7vdT2
         U2MrH453Ghiku3dCYob6xvPSpNCX9H2a4q8TfAQU14jACDjfsHl2F7mgrvn4P66TO3Gq
         t3uVhd3icXJHzTB8WUTCPO38xZmdtFIxm9Gehsl0cma4hhXaAbEAh7cTQDCOH9JgD2i+
         iXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpXgtd6llm5EYXYD9SbAG8NLcGpwtyJ1cM/ICnpdcRk=;
        b=n7Rsrh0csW5eptyYh2sAFY6UiTDQciVs2qESt9F1v5/SAUfspyl/hGGpUdQB579OFa
         zReNnXEegP1xhBFGAlPjWUAfH3iHukJ46XQMCGGnD6hOAj/dPEOg/nO2rYEM/7465npN
         P0YglauCHAkeZIr6vRY/+QkFzTVyxDrY228HMtikC5jPiH4YltWdSlansVFeCsJreQVi
         hTFwifWRpyE0+H58h/99fZLKmDiny2NKMeVrGEQTXi7i7PUrzr02MYrHBfsMAdZeC3+F
         VpPDlVB7IRjOzKe/qCdDRureOAwZUHDE4jBZtAKgsUAxGrQRryxuhaCe+bpVxydEGQLT
         1trA==
X-Gm-Message-State: AOAM533Rw4zpIc7R14RJ0PJQ2K7/zNdtnnZopmT6Qw6SSdyViuSFXeG3
        +Oc2/7cfrP0ehW6QJJttwzC9shps/X5H1NrkEGY=
X-Google-Smtp-Source: ABdhPJxmOIW7g932Zn63vmcSMh8fiX+gvGZ0vPE22QhW8N1Ttf+kbFECcZJMtw4VvNrdDijCn9n9+CSgpbgRb1MDhAs=
X-Received: by 2002:aa7:ccd6:: with SMTP id y22mr862724edt.363.1631157745832;
 Wed, 08 Sep 2021 20:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210909004131.163221-1-naoya.horiguchi@linux.dev>
In-Reply-To: <20210909004131.163221-1-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 8 Sep 2021 20:22:14 -0700
Message-ID: <CAHbLzkq_S+90vjRsoEST0Dqidnjy6M1=iQ00h95CaWE1S=WwfQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm, hwpoison: add is_free_buddy_page() in HWPoisonHandlable()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 5:41 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> commit fcc00621d88b ("mm/hwpoison: retry with shake_page() for
> unhandlable pages") changes the return value of __get_hwpoison_page() to
> retry for transiently unhandlable cases.  However, __get_hwpoison_page()
> currently fails to properly judge buddy pages as handlable, so hard/soft
> offline for buddy pages always fail as "unhandlable page".  This is
> totally regrettable.
>
> So let's add is_free_buddy_page() in HWPoisonHandlable(), so that
> __get_hwpoison_page() returns different return values between buddy
> pages and unhandlable pages as intended.
>
> Fixes: fcc00621d88b ("mm/hwpoison: retry with shake_page() for unhandlable pages")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git v5.14-rc7-mmotm-2021-08-23-16-42/mm/memory-failure.c v5.14-rc7-mmotm-2021-08-23-16-42_patched/mm/memory-failure.c
> index 60df8fcd0444..3416c55be810 100644
> --- v5.14-rc7-mmotm-2021-08-23-16-42/mm/memory-failure.c
> +++ v5.14-rc7-mmotm-2021-08-23-16-42_patched/mm/memory-failure.c
> @@ -1126,7 +1126,7 @@ static int page_action(struct page_state *ps, struct page *p,
>   */
>  static inline bool HWPoisonHandlable(struct page *page)
>  {
> -       return PageLRU(page) || __PageMovable(page);
> +       return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(page);

It seems to work. Although this may change the return value of
get_any_page() to 1 when MF_COUNT_INCREASED is set. This may cause
soft offline to mishandle free buddy page, but MF_COUNT_INCREASED is
only set when madvise is used, and madvise definitely can't soft
offline free buddy page. It did take me a while to figure out this
trick. Maybe need some refactor?

Anyway this patch looks fine to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

>  }
>
>  static int __get_hwpoison_page(struct page *page)
> --
> 2.25.1
>
