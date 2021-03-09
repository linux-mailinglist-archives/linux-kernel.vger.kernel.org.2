Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4DA331B86
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhCIAMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhCIALu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:11:50 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F01BC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:11:49 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id mj10so23975138ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 16:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7S+uifTuzp5DoZcXR8fUrkrnbuEPn9xXlGu3V6LLQPY=;
        b=XffjNWC/ElUKr97poPnZfOllbB87Kj+qT1u4i4ukzXktWwvVHLdbUHgxLshWPXWnV3
         YkXSfDNEcY2mOE5dFI2pt/TrCYqI7CtEVJO9/ydbDjAvDuPIunezV78wEb4EsDEoTfxg
         TyuAVuH1plNfYa743uU4mBWaJIG7inSMOXAvsVBF4NW3VuMyybLcW7RqffSa08PlNKbj
         E5Ff6gFsnCAGFNRqQTakoGJfvpqxSxudx8apymssSM6u0jbPGxkZh25mGDvwmljc0+pW
         ih+5VhAaWiFXZFwalxTHKHcAIWT8d/5BHGf+971sM6/22RWyrn03hIy+qG9g6UQWbP5K
         Nkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7S+uifTuzp5DoZcXR8fUrkrnbuEPn9xXlGu3V6LLQPY=;
        b=qkckKElJuSywqE1H95lSeBZkUieSk4KlviGSwzo0ksDOj6pqmDA/Q++C4aqVV3JEQL
         7tV8O5EK/kcu+7yiFfXklBsbPP9Ig7uJ9wrXUIQxkIHJ2KgilD8VT4x5rDWBGhpla5u8
         2EoIV0wKfCiLY8EKK9laLpWTfHbrCwT6jvaxvOQDeGThc4RYImEFlpWtuxZ7lbyY45MJ
         HX5KLYmCswTuwswNo/1Ne1ml6NL01LvLbbD8CG0QSrCnoROJkkEE9GNXMNxscgAg89au
         eZ7Z0SwLSogvqvsYIJwdHndtNTHkJD8mAoZ6aPuJ1zM+xggf/w9wk8r8i6cBPtL7kqxx
         gW8Q==
X-Gm-Message-State: AOAM533cV/Y3My1b4lJzP8W1K5hdrD9yrWTcb8Gvt7m00YvKRP85j0Bt
        +ef4pUFzOxCSM36B6/4ywfmiuS1WTLk4UqphE7Z+nePlxEw=
X-Google-Smtp-Source: ABdhPJxWkwTmEUFi6fcF0vwoczQxwHGvYkoLiWPZxrUXwxMxmaRvlPzg+McQ3CQID6v/Dtd+rzM8Q/vjIuz6n8iIdm4=
X-Received: by 2002:a17:907:2bf6:: with SMTP id gv54mr17808640ejc.514.1615248708462;
 Mon, 08 Mar 2021 16:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com> <20210305000000.48BA4A97@viggo.jf.intel.com>
In-Reply-To: <20210305000000.48BA4A97@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 16:11:36 -0800
Message-ID: <CAHbLzkqfJ-OQ4cfymRV0MS+dLVZSUW_mW3F7e=2_XPYUULF_Mw@mail.gmail.com>
Subject: Re: [PATCH 06/10] mm/vmscan: add page demotion counter
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 4:01 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Yang Shi <yang.shi@linux.alibaba.com>
>
> Account the number of demoted pages into reclaim_state->nr_demoted.
>
> Add pgdemote_kswapd and pgdemote_direct VM counters showed in
> /proc/vmstat.
>
> [ daveh:
>    - __count_vm_events() a bit, and made them look at the THP
>      size directly rather than getting data from migrate_pages()
> ]
>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
>
> --
>
> Changes since 202010:
>  * remove unused scan-control 'demoted' field

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>
>  b/include/linux/vm_event_item.h |    2 ++
>  b/mm/vmscan.c                   |    5 +++++
>  b/mm/vmstat.c                   |    2 ++
>  3 files changed, 9 insertions(+)
>
> diff -puN include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter include/linux/vm_event_item.h
> --- a/include/linux/vm_event_item.h~mm-vmscan-add-page-demotion-counter 2021-03-04 15:35:57.698806425 -0800
> +++ b/include/linux/vm_event_item.h     2021-03-04 15:35:57.719806425 -0800
> @@ -33,6 +33,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
>                 PGREUSE,
>                 PGSTEAL_KSWAPD,
>                 PGSTEAL_DIRECT,
> +               PGDEMOTE_KSWAPD,
> +               PGDEMOTE_DIRECT,
>                 PGSCAN_KSWAPD,
>                 PGSCAN_DIRECT,
>                 PGSCAN_DIRECT_THROTTLE,
> diff -puN mm/vmscan.c~mm-vmscan-add-page-demotion-counter mm/vmscan.c
> --- a/mm/vmscan.c~mm-vmscan-add-page-demotion-counter   2021-03-04 15:35:57.700806425 -0800
> +++ b/mm/vmscan.c       2021-03-04 15:35:57.724806425 -0800
> @@ -1118,6 +1118,11 @@ static unsigned int demote_page_list(str
>                             target_nid, MIGRATE_ASYNC, MR_DEMOTION,
>                             &nr_succeeded);
>
> +       if (current_is_kswapd())
> +               __count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
> +       else
> +               __count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
> +
>         return nr_succeeded;
>  }
>
> diff -puN mm/vmstat.c~mm-vmscan-add-page-demotion-counter mm/vmstat.c
> --- a/mm/vmstat.c~mm-vmscan-add-page-demotion-counter   2021-03-04 15:35:57.708806425 -0800
> +++ b/mm/vmstat.c       2021-03-04 15:35:57.726806425 -0800
> @@ -1244,6 +1244,8 @@ const char * const vmstat_text[] = {
>         "pgreuse",
>         "pgsteal_kswapd",
>         "pgsteal_direct",
> +       "pgdemote_kswapd",
> +       "pgdemote_direct",
>         "pgscan_kswapd",
>         "pgscan_direct",
>         "pgscan_direct_throttle",
> _
>
