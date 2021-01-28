Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA630811A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhA1W3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhA1W3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:29:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2FCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:28:26 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j11so1548856plt.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=EU8Tm3K3oBlbbIeULtvbxU5p2tn0TQtZedwnNIY0Y84=;
        b=BgZAIzU4NSonuhxkBzNY3c7VaB8jSmmWONbtZOdYQ2id+Zm4dBNl3Td000Ay/R2Vka
         HZz13NCZDH7whsxHvmb0YNyd6VBfj3CYEfI2Y3wx7D41QkClnROSyUaMEVU4IWrmn8QN
         sOA4U26j0xUAErYAkMHrfo+uMIfEiPCQL9JXLbglEzeXG1qXZvH2jHSVQaEAc3b6xZRY
         LkKp6X1lRRi8pLYyIWcIL1+kjTiR/nF2DKWS4cwbJ1Rv385gkQz33y13ihw+dcBs3i7Y
         z4wAaYzPpICf5r2Uq09E59pO12nEXLdMArTYcW4Kf9e0jPIzP4WTDs1LAg4ANYYnrMZV
         Xrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=EU8Tm3K3oBlbbIeULtvbxU5p2tn0TQtZedwnNIY0Y84=;
        b=a9oQFzwMT1EGJG/j/bVo+pOlG3mdXe6h045/F0dqMnKpNrPUqsldq34EyWrDYX1uMK
         rJqyystMcz9egVA2RqAKOW8XWc48V4TVnvU2jNLB77jo8JAZrrgiSUZkurdMDnYzaxvR
         1Yl7LwvshnkYrBbjnYdUYGBlShhL67X6prJGWMopgrAp22M8Rf5PiNIjODeK7NFNKbI2
         f3CF7TpM8xqcdpbE+nnhgEJ5856tekcworI8Qtorb9DaKDnh+kMI9ddtXcjgTXhw6A5W
         D1ncMukJYRsKWl1tmvJBW6xA1b/i+jSM3AckPaHth2TVMScbm8wLpqq4H4Szy93tbsja
         soVQ==
X-Gm-Message-State: AOAM531SxIZHp+xjhRI/FKihqzYKlV9ONvZ6NzkiGwkquOL27hMxm3s+
        k6Av5YBT12GzN/WRpIx0HEKuSpWCpkun2g==
X-Google-Smtp-Source: ABdhPJzFe2/P5brnc2ev5Q8HoSO/uUHvj6D6QO6jxHq4qeewaCtN9jvyrggp2amIDjiWjiU/RgsauA==
X-Received: by 2002:a17:90b:fc9:: with SMTP id gd9mr1429601pjb.107.1611872905499;
        Thu, 28 Jan 2021 14:28:25 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id r30sm6872643pfq.12.2021.01.28.14.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:28:24 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:28:23 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     David Hildenbrand <david@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: count CMA pages per zone and print
 them in /proc/zoneinfo
In-Reply-To: <F1BB7F6F-DD08-4D97-A79A-CC7CA6A579E2@redhat.com>
Message-ID: <89e1dbcd-605d-6a7b-361-c130f7eb9d8c@google.com>
References: <6d9cff33-39c1-ef8e-a18e-c865b95240b6@google.com> <F1BB7F6F-DD08-4D97-A79A-CC7CA6A579E2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1482994552-507496633-1611872904=:323143"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-507496633-1611872904=:323143
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 28 Jan 2021, David Hildenbrand wrote:

> > ﻿On Thu, 28 Jan 2021, David Hildenbrand wrote:
> > 
> >> diff --git a/mm/vmstat.c b/mm/vmstat.c
> >> index 7758486097f9..957680db41fa 100644
> >> --- a/mm/vmstat.c
> >> +++ b/mm/vmstat.c
> >> @@ -1650,6 +1650,11 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
> >>           zone->spanned_pages,
> >>           zone->present_pages,
> >>           zone_managed_pages(zone));
> >> +#ifdef CONFIG_CMA
> >> +    seq_printf(m,
> >> +           "\n        cma      %lu",
> >> +           zone->cma_pages);
> >> +#endif
> >> 
> >>    seq_printf(m,
> >>           "\n        protection: (%ld",
> > 
> > Hmm, not sure about this.  If cma is only printed for CONFIG_CMA, we can't 
> > distinguish between (1) a kernel without your patch without including some 
> > version checking and (2) a kernel without CONFIG_CMA enabled.  IOW, 
> > "cma 0" carries value: we know immediately that we do not have any CMA 
> > pages on this zone, period.
> > 
> > /proc/zoneinfo is also not known for its conciseness so I think printing 
> > "cma 0" even for !CONFIG_CMA is helpful :)
> > 
> > I think this #ifdef should be removed and it should call into a 
> > zone_cma_pages(struct zone *zone) which returns 0UL if disabled.
> > 
> 
> Yeah, that’s also what I proposed in a sub-thread here.
> 

Ah, I certainly think your original intuition was correct.

> The last option would be going the full mile and not printing nr_free_cma. Code might get a bit uglier though, but we could also remove that stats counter ;)
> 
> I don‘t particularly care, while printing „0“ might be easier, removing nr_free_cma might be cleaner.
> 
> But then, maybe there are tools that expect that value to be around on any kernel?
> 

Yeah, that's probably undue risk, the ship has sailed and there's no 
significant upside.

I still think "cma 0" in /proc/zoneinfo carries value, though, especially 
for NUMA and it looks like this is how it's done in linux-next.  With a 
single read of the file, userspace can make the determination what CMA 
pages exist on this node.

In general, I think the rule-of-thumb is that the fewer ifdefs in 
/proc/zoneinfo, the easier it is for userspace to parse it.

(I made that change to /proc/zoneinfo to even print non-existant zones for 
each node because otherwise you cannot determine what the indices of 
things like vm.lowmem_reserve_ratio represent.)
--1482994552-507496633-1611872904=:323143--
