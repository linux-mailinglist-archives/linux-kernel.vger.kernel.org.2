Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CA230E878
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 01:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhBDA1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbhBDA1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:27:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75339C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 16:26:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id df22so1980224edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 16:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xyEbtM3oBDhnuHqycJNBjjR1/B89Yhm019P071TQu48=;
        b=PyjI0sGecZM5547DnvmFxMBcoowizD9MjexPTlrbIX/HYHp5OR84gY2BgvA/Bzanru
         o/+Gu60Z9DKDxX5SnMvg/ODOwAMYl8ha/jaCQR81p858/G5tGFMpTAGuj0iquoTJUpDy
         avKE4dGHC2ad8cVa+/hIsBMyF3XfZ2/emQ0zuym6sEOmlEvI00WK1bi7JFM7aPoQIFqh
         tIc/w/hv9HGvoKWh4trkbiLujBZ67kIAE4uOD12Cg/sP754OwuJ6DtxJ93/e0VlPXvEi
         DSx6xrZPNvOwzxyGlPECsaosLXkbJvLTSn6EuE8aZ/xwHM34MxjU0Xct+Z4Ju5hgxfO0
         t2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyEbtM3oBDhnuHqycJNBjjR1/B89Yhm019P071TQu48=;
        b=i6g3a/sKhSatS8k7K/7dNefK5GShG2JMngxD/4MipuoIZCuFQDaYOupkqQFtozQLzI
         ilvXqel3kmlRCMt1JhNKpp85ABptFdzGTNc7RrxKkI98APhO54ZYwMyIi6fGrza0eRaZ
         +HiEOs6p2K/YN7pgBdVi1JAYP9Z4Mm1ZlN5uoD/bKHQcn/fMuPKcxJ6Ttecu/ygYn4lR
         HWGtdmFTOu5yDkV0btQ7A8cEFbET2BNjAZEfXBsOMUns1FMpbN+N4zrofOAA+V3jpd8J
         249HbFBobHauouHRwN09dciIh/Oz0oUBXchcI5sAcadtLAgQfebW61tGJsPmBusqWdYq
         QGqQ==
X-Gm-Message-State: AOAM530CPNub+HLfekf/VMhdzeqgq2Ptzgv+LI5B0Uh/1tVBJepSga3R
        V27XyTEuC0hHaaBhMe0NhOdcipFioRVYKeP0DgQ=
X-Google-Smtp-Source: ABdhPJz0Y3aD7STJswOVpoJe2UaXKHkXL0QCnyrLIm6Y21DdDVcZhjmk1ptGfj5vyAroyrWazC4zZQ1crKSKotB05ys=
X-Received: by 2002:aa7:de82:: with SMTP id j2mr5705265edv.313.1612398392246;
 Wed, 03 Feb 2021 16:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003421.45897BF4@viggo.jf.intel.com>
 <CAHbLzkoB98YY0amBWTGcDPStcy1c35CC8D5MPMbVxzRKqVA0Cg@mail.gmail.com>
 <317d4c23-76a7-b653-87a4-bab642fa1717@intel.com> <CAHbLzkqrPvY4Zb17AGJi1Zi7OV9WDUTEpj5DpfWY9c2WHzPBYw@mail.gmail.com>
 <d0ea8634-3fca-68ff-cd39-b3304880295f@intel.com>
In-Reply-To: <d0ea8634-3fca-68ff-cd39-b3304880295f@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 3 Feb 2021 16:26:20 -0800
Message-ID: <CAHbLzkrc=Zj_EfJ7oUSKdY0aL2Ke+zb_DGDwE45dzbdKAqgUYw@mail.gmail.com>
Subject: Re: [RFC][PATCH 05/13] mm/numa: automatically generate node migration order
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Feb 2, 2021 at 4:43 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/2/21 9:46 AM, Yang Shi wrote:
> > On Mon, Feb 1, 2021 at 11:13 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >> On 1/29/21 12:46 PM, Yang Shi wrote:
> >> ...
> >>>>  int next_demotion_node(int node)
> >>>>  {
> >>>> -       return node_demotion[node];
> >>>> +       /*
> >>>> +        * node_demotion[] is updated without excluding
> >>>> +        * this function from running.  READ_ONCE() avoids
> >>>> +        * reading multiple, inconsistent 'node' values
> >>>> +        * during an update.
> >>>> +        */
> >>> Don't we need a smp_rmb() here? The single write barrier might be not
> >>> enough in migration target set. Typically a write barrier should be
> >>> used in pairs with a read barrier.
> >> I don't think we need one, practically.
> >>
> >> Since there is no locking against node_demotion[] updates, although a
> >> smp_rmb() would ensure that this read is up-to-date, it could change
> >> freely after the smp_rmb().
> > Yes, but this should be able to guarantee we see "disable + after"
> > state. Isn't it more preferred?
>
> I'm debating how much of this is theoretical versus actually applicable
> to what we have in the kernel.  But, I'm generally worried about code
> like this that *looks* innocuous:
>
>         int terminal_node = start_node;
>         int next_node = next_demotion_node(start_node);
>         while (next_node != NUMA_NO_NODE) {
>                 next_node = terminal_node;
>                 terminal_node = next_demotion_node(terminal_node);
>         }
>
> That could loop forever if it doesn't go out to memory during each loop.
>
> However, if node_demotion[] *is* read on every trip through the loop, it
> will eventually terminate.  READ_ONCE() can guarantee that, as could
> compiler barriers like smp_rmb().
>
> But, after staring at it for a while, I think RCU may be the most
> clearly correct way to solve the problem.  Or, maybe just throw in the
> towel and do a spinlock like a normal human being. :)
>
> Anyway, here's what I was thinking I'd do with RCU:
>
>  1. node_demotion[] starts off in a "before" state
>  2. Writers to node_demotion[] first set the whole array such that
>     it will not induce cycles, like setting every member to
>     NUMA_NO_NODE. (the "disable" state)
>  3. Writer calls synchronize_rcu().  After it returns, no readers can
>     observe the "before" values.
>  4. Writer sets the actual values it wants.  (the "after" state)
>  5. Readers use rcu_read_lock() over any critical section where they
>     read the array.  They are guaranteed to only see one of the two
>     adjacent states (before+disabled, or disabled+after), but never
>     before+after within one RCU read-side critical section.
>  6. Readers use READ_ONCE() or some other compiler directive to ensure
>     the compiler does not reorder or combine reads from multiple,
>     adjacent RCU read-side critical sections.

Makes sense to me.

>
> Although, after writing this, plain old locks are sounding awfully tempting.
