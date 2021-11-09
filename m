Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128C744A292
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242998AbhKIBT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbhKIBOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:14:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629DC043190
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 17:03:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f4so69537791edx.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 17:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZr9FPrZOxgsc8U/wDnZ9LLLwqLTqPz85QXmM/1k+jk=;
        b=TeNAQ5OubajkI3l1MfahzCgoz+EVErCV6IZJNzki5F7+gKV4K8rgOl14X8FjjJP/zO
         nqAzQ+GiDxTt9tl/D5/Gm2R4rPkaZEYiTDGCHO0rPxTqXZCKR7B4FiB9zO0jKkFV4DR9
         4u5vDGWVkhoTyt5MlGEo8V1xdwn1a2oJ3fVC/5PDkl9urx6+gjNILjk0NtPmxknDXrXN
         03sUtFermnuyKGUwqdDzOJcUTR3hgMB99n0Sypc1pUReDXLaVG2YObyb0vunZ9A0yyGh
         RWOjvjyfNU9xyf30L89p8TPlzzY4M9Vi5iu66MVV74j04Vc7WLjnCloIf/2YnErlyI3F
         Q2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZr9FPrZOxgsc8U/wDnZ9LLLwqLTqPz85QXmM/1k+jk=;
        b=EuF7CUF8BUw/RRIjF2Owc6+uuxYXgq0Llju5kuBiJVJT2Cc1y3SaqD9USo7WgozdM1
         s6FwTIGzYYoOPDnou0XMk7AP6O0tZDvPbCXL/AfP5lS0bdoBXHuSq5pscIZxJBpuGGOm
         Kp1o4ZKZ7wB8ntSOQfNewbJ5h0w1+VTHU01D1Rtv6fjd1xzz/FiIEyEuOTUVTehyIb4g
         Ucu/og5nsbpVpTKQZMLOCZX4/mDxvgfnozBmQMQGBoCXQaKoxFT46BkbvgYpkOmaFlfw
         iS+QvcX7VATycK6tDTGMQ7GvSBijQVcVra220vMqSDgfjHjMrZdpgkP6qLCNmQQS0uTd
         HxjQ==
X-Gm-Message-State: AOAM530O8O70ZKjEGmec0LIwmV6+gL6bIqeV3XljQkpZT8rGZlmetIaJ
        MdBLaBIOjuMNZeaRRyTeAyK1Xr2rXaSTt7TGob8=
X-Google-Smtp-Source: ABdhPJxkaEeOP7RUo6eIVTAm9qolIyX+ECKaCMHrhmyNtkLMv8worAYtlC3m+2ROqdlUd5ukHIn2jnstxCAyb/h6DMk=
X-Received: by 2002:a05:6402:520b:: with SMTP id s11mr4531859edd.363.1636419804995;
 Mon, 08 Nov 2021 17:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20211105055058.3152564-1-naoya.horiguchi@linux.dev>
 <20211105055058.3152564-4-naoya.horiguchi@linux.dev> <CAHbLzkoCUs-Z9m47SnF3sR-wai3_M6R4Jkxq8bNBTdoTrkh5vA@mail.gmail.com>
 <20211109005320.GA3341842@u2004>
In-Reply-To: <20211109005320.GA3341842@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Nov 2021 17:03:13 -0800
Message-ID: <CAHbLzkpUX9NdKz5yz8j7ej-2hh0hKSB20_E_Ug4d2r3_NC6YUA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm/hwpoison: fix unpoison_memory()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 4:53 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Mon, Nov 08, 2021 at 03:27:55PM -0800, Yang Shi wrote:
> > On Thu, Nov 4, 2021 at 10:52 PM Naoya Horiguchi
> > <naoya.horiguchi@linux.dev> wrote:
> ...
> > > @@ -1942,6 +1987,26 @@ core_initcall(memory_failure_init);
> > >                 pr_info(fmt, pfn);                      \
> > >  })
> > >
> > > +static inline int clear_page_hwpoison(struct ratelimit_state *rs, struct page *p)
> > > +{
> > > +       if (TestClearPageHWPoison(p)) {
> > > +               unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
> > > +                                page_to_pfn(p), rs);
> > > +               num_poisoned_pages_dec();
> > > +               return 1;
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > > +static inline int unpoison_taken_off_page(struct ratelimit_state *rs,
> > > +                                         struct page *p)
> > > +{
> > > +       if (put_page_back_buddy(p) && clear_page_hwpoison(rs, p))
> >
> > It seems there might be race condition between free and allocation to
> > kick the page out of buddy before the hwpoisoned flag is cleared IIUC?
> >
> >         CPU A                     CPU B
> > Free:                            Allocation:
> > acquire zone lock
> > put back to buddy
> > release zone lock
> >                                      acquire zone lock
> >                                      try to allocate this page
> >                                      if it is hwpoisoned then reset
> > PageBuddy (not buddy page anymore)
> >                                      release zone lock
> >
> > Did I miss something?
>
> No, this is a nice catch. CPU B finds hwpoisoned page on free list then
> calling bad_page().  So doing "put back to buddy" and clear_page_hwpoison
> inside a single zone lock should prevent this race.

Yeah, or clear the flag before putting it back to buddy? Anyway
clearing the flag under zone lock is not a big deal either.

>
> Thanks,
> Naoya Horiguchi
