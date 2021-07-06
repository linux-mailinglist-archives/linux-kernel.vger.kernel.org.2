Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1B3BC4C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 04:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhGFCgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 22:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhGFCgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 22:36:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC2C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 19:33:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p9so79842pjl.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 19:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06i5KGWmwHVBZFXYJ48PBysuLwO0G27A0FsQXG6hKSc=;
        b=dUKmO6vGEOG98B79jPaqZClgRBc20In6/36jh08wa7rT55304A7Q8dsLlL3LBbkdSq
         6XOKiGrmfL0p2BCZVfPwYnAAZHCWDWpNwn8dYqUQfm88WgGSwsuIw7ofkLe5t2hjNf/U
         N3Kr8NZmXAWzIUGgschfvMo/iGstzUtrzXgk1Fv1Z98Zei2HxIwb6hK/shiG2BzFHTj7
         llI5FAHA7t7BNcKw7dlSoemhF315xKBQTL0IjagVeHemQFKmnCs18DObcQDiVT2coVi/
         r78nzglAl6YLxQtKrjNGJ3E8pVgadzBcWUns80KAwKKXiEhjjJ+agZel2J1wdN4EqJbO
         hUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06i5KGWmwHVBZFXYJ48PBysuLwO0G27A0FsQXG6hKSc=;
        b=LzdoASOji+k/Lc4ZtjvGLOBn8fJ2RAyfpd6/FGJ9OZ3ClnYrPjq5ITqB8rLdKV6EmX
         uMMIb4aioZ2uKtNLLQLif6S8bqqrWXDPH1TKNY6eaE9NPNuBRGrw0862vQPbgfNTHL3g
         kVRvStcGP7GAxDHntxh+SjWRvcxIKIXCu8uD4IshhswCdpDgiOKIw1wdfD6MTvBOnjL0
         TFMiM/sCLIqk9CnE7Khwr4yr1nw0p0ymjqEQu6UNTl7BpkD446g0lclcuspQNnbSzAra
         1VPi1x8tCMnjrclQ7y+L6daMpA0F1d8drar/erOAZ0FgiITub4rNSFvmMK/QVL+pKPih
         OF7A==
X-Gm-Message-State: AOAM5316YQWuMIYBZsZkRI/NSga+o7Rcq2sipKIhjlcuhKBFMKQGNF5s
        FpdYuE/8jTpSLDka7XRLsXCQKlDtCW6N1+CUaDP4T0kmsrxljkfQ
X-Google-Smtp-Source: ABdhPJzassG1l/bv5iP47zIeIbJ7LnhwZwautzwNcbF85KFmqLIn1KNN+Ph1/5NVHNrWrQIadTsIVk9B1T5p1N/N67M=
X-Received: by 2002:a17:90b:19cd:: with SMTP id nm13mr1994265pjb.147.1625538813383;
 Mon, 05 Jul 2021 19:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <1625493432-9945-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1625493432-9945-1-git-send-email-wangqing@vivo.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 6 Jul 2021 10:32:56 +0800
Message-ID: <CAMZfGtUbX+TAx-7RJ4ZpoNLHDa9mp6k+DBqHaYiLjhSJokh3Sw@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] [PATCH] mm: add GFP_ATOMIC flag after local_lock_irqsave
To:     Wang Qing <wangqing@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 9:57 PM Wang Qing <wangqing@vivo.com> wrote:
>
> Use GFP_ATOMIC when local_lock_irqsave in __alloc_pages_bulk
>
> Reported-by: syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d6e94cc..3016ba5
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5309,7 +5309,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>                 }
>                 nr_account++;
>
> -               prep_new_page(page, 0, gfp, 0);
> +               prep_new_page(page, 0, gfp | GFP_ATOMIC, 0);

Hi Wang Qing,

I didn't get the point here. IIUC, prep_new_page() will not allocate
memory. So why do we need GFP_ATOMIC? What I missed here?

Thanks.

>                 if (page_list)
>                         list_add(&page->lru, page_list);
>                 else
> --
> 2.7.4
>
