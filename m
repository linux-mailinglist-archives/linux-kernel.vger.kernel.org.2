Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B673B3A71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 03:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhFYBVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 21:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFYBVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 21:21:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C02DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 18:19:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r7so11148498edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 18:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoLS3ADa/+8BAi3YAB3Uh9nOJE8VWVnz5sgYqPDWI3Q=;
        b=osrVvp6raQnfu6B6Xb+kb2NfDcSkW7H9HQ//hPmZ08tpQ8rhJd+Rnvos2qnMtq8Elp
         G1ZHBf2T80eRu8QIrJRLO1CETd59CO8WX/UIDwGjpLGjbkAyjQd1R+lWjjDCxQnOznGT
         PEvmlBQYRlJlPsdtv0Kp5CXY0RvLiQeCuVJ+FIGEKFTF8p9Z7ox+m/Ax0/EvTi0V8Hl4
         SxvoqQEsDXaGCQe7yWKB0mF6xUxaFtxHUgZXnsrhvuoxqXNUzGhQVA0l810CydI+z00H
         x4PiBiKWcZmQVKYAwEPeK2Wbaqm1+iBGiCRpvCln1St4oX8hmlceakZFYri1CQd7HO4t
         Uv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoLS3ADa/+8BAi3YAB3Uh9nOJE8VWVnz5sgYqPDWI3Q=;
        b=C2HIVVOtdehJwKi9c2Ikc+dEfGeOWi8q2SVmp4APDH+A9oRJ9WF5mtiiJS2GUe1Pd7
         ffCBmyKl3Da+ZdriVRRWkzcsJyWS+u2IrZqMybnWN06sYb2Siyy7t2FXBBCzNmmA/qZW
         do03pJObggEbXoQ7cihDj7otlKMAQXeZvZS+IluGlHEQc0Bn7zgzcVI+16qwSc6ZwY32
         cFyorZDvztBgCA+wVhtwH8h6KLCJgXO00b/3blMgNUsJrMiucfPIEH4vSfRBAyDMKK78
         f6W0W88EzvMo1iT/ejmQQEufkeuU6mVfn/mYojnS7B8AxT7HdHlanaUA+2FFq02YT9Xl
         aMzA==
X-Gm-Message-State: AOAM532hAw5eHBkKP845QpIHOWcAKZ/ZMIxc69DTZ6rAZsmmKanxCQE8
        V1Weoq8+mb2sHuQRk1mq5S4pKNCKEmhfT+vdZ6A=
X-Google-Smtp-Source: ABdhPJw3kPMl04utqvKIwFBtMwYhSeLvZjFw6BOEbZWCAAFgPCjQjMjnPOoWW40lFnKjboDmM2pE8VrCwcyKlPCYSxI=
X-Received: by 2002:a05:6402:268f:: with SMTP id w15mr7413359edd.228.1624583972016;
 Thu, 24 Jun 2021 18:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210625014710.42954-1-gshan@redhat.com> <20210625014710.42954-4-gshan@redhat.com>
In-Reply-To: <20210625014710.42954-4-gshan@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 24 Jun 2021 18:19:21 -0700
Message-ID: <CAKgT0UebcvDrkL8J=oZAt-N2Lg3AG0vfekw6Lknmiho00vam4g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mm/page_reporting: Allow driver to specify
 reporting order
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 4:46 PM Gavin Shan <gshan@redhat.com> wrote:
>
> The page reporting order (threshold) is sticky to @pageblock_order
> by default. The page reporting can never be triggered because the
> freeing page can't come up with a free area like that huge. The
> situation becomes worse when the system memory becomes heavily
> fragmented.
>
> For example, the following configurations are used on ARM64 when 64KB
> base page size is enabled. In this specific case, the page reporting
> won't be triggered until the freeing page comes up with a 512MB free
> area. That's hard to be met, especially when the system memory becomes
> heavily fragmented.
>
>    PAGE_SIZE:          64KB
>    HPAGE_SIZE:         512MB
>    pageblock_order:    13       (512MB)
>    MAX_ORDER:          14
>
> This allows the drivers to specify the page reporting order when the
> page reporting device is registered. It falls back to @pageblock_order
> if it's not specified by the driver. The existing users (hv_balloon
> and virtio_balloon) don't specify it and @pageblock_order is still
> taken as their page reporting order. So this shouldn't introduce any
> functional changes.
>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  include/linux/page_reporting.h | 3 +++
>  mm/page_reporting.c            | 6 ++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
> index 3b99e0ec24f2..fe648dfa3a7c 100644
> --- a/include/linux/page_reporting.h
> +++ b/include/linux/page_reporting.h
> @@ -18,6 +18,9 @@ struct page_reporting_dev_info {
>
>         /* Current state of page reporting */
>         atomic_t state;
> +
> +       /* Minimal order of page reporting */
> +       unsigned int order;
>  };
>
>  /* Tear-down and bring-up for page reporting devices */
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 34bf4d26c2c4..382958eef8a9 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -329,6 +329,12 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>                 goto err_out;
>         }
>
> +       /*
> +        * Update the page reporting order if it's specified by driver.
> +        * Otherwise, it falls back to @pageblock_order.
> +        */
> +       page_reporting_order = prdev->order ? : pageblock_order;
> +

An alternative to this would be to look at setting up some
comparisons. I might add another variable and do something like:
order = prdev->order ? : pageblock_order;
if (order < page_reporting_order)
    page_reporting_order = order;

You could essentially do something similar in the previous patch but
just use pageblock_order directly rather than having to add a local
variable.

That way if you need to still pull down the page reporting order you
can do so without prdev->order or pageblock_order overwriting the
value and pushing it back up.
