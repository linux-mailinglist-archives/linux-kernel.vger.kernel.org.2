Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA9A349AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhCYUNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 16:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:12:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AE5C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 13:12:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u19so2914829pgh.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oKCCJvFAhyXitm2ivJmoGad7JQ14zbFEvHLYcmjzujI=;
        b=Wal6MNfKxDi8FAcS76nifM2uKxeApjUPR6pWBvMdiVwjENJ41KMHuiuBFSD68Kmsw9
         Lj6aeh5bHVzjXrKYdh9GN1E7DYqrLpMbFN1uWSjgjJcQO31d2CqzRn7VCrDuQmvRJq5i
         ghv9+NKQw3gSb5VzPnb/wS2syQWGS9UA1m8l9bIRQwdx0L+mDejM52xy2/1a1zUgHQ5w
         T8Za1iMNlpdEB1QMt8LOvKaKvCJ9EGTHwARD+iyvYFOkmdhhyeGoEjuiQFERdgJ9DSXg
         2YXTUduQqMJCfgkJkzxBISnilOSBCSMM5bjvQAPbkVHrgkS32OEc9h5xpBGeOlvVcTdw
         iRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oKCCJvFAhyXitm2ivJmoGad7JQ14zbFEvHLYcmjzujI=;
        b=Cj0gIwlUWMHOje2QEzEYemy18oU9a8G7gn5RMr04QzcLzoxK8nKRx6bXS7XxFtC+vd
         h3f9HA6dtZu9YZw2+8fqvRkPaFxYlJSD5Jt5+Ynws+ENWXCyFD8p9VqqrQUege8Tgo3f
         iSW2MK/YHdRigRgviFSpPGe2bZ1KuLuljd4vKe/9SSmhxlf74fw1oXI4pcZ3d+UkNek6
         K17/ypbcFtFISwYb5r+CpJOySfbbLKbx6OxDMcT/kYdio3xhgXr1eBTbFFdAH9frfShw
         /mOswsB8eotLFI0vbcXdaipSfw98PFNQVOXDv/6+cFijGE3hBZH6919Wq5W0bxBE0xqi
         n6mg==
X-Gm-Message-State: AOAM5319rlv33QPCSeqwPn9KR4cSFApUeQt1SmqtJz2ghCVzYu8jSflJ
        OzCjYdez2sdWnWPO86AsrT8=
X-Google-Smtp-Source: ABdhPJxpPtICV9qH7Mky40gHzeB9G0a1Pe1w3UI8+/0GeVw7mcKrL6dozLNBYQNgTSj/eg1Zn1KqDw==
X-Received: by 2002:a63:ce03:: with SMTP id y3mr8974310pgf.414.1616703175343;
        Thu, 25 Mar 2021 13:12:55 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:4c1e:8d39:76c4:59d7])
        by smtp.gmail.com with ESMTPSA id b84sm6519072pfb.162.2021.03.25.13.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 13:12:54 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 25 Mar 2021 13:12:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 1/8] mm: cma: introduce cma_release_nowait()
Message-ID: <YFzuw0S5S/aG7nVk@google.com>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
 <YFxkXEXMpcMM/KWd@dhcp22.suse.cz>
 <76aaf359-9496-04df-a585-3662d0375749@oracle.com>
 <4bc3c5d8-f1a7-6439-8fee-582364a7c021@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bc3c5d8-f1a7-6439-8fee-582364a7c021@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 06:15:11PM +0100, David Hildenbrand wrote:
> On 25.03.21 17:56, Mike Kravetz wrote:
> > On 3/25/21 3:22 AM, Michal Hocko wrote:
> > > On Thu 25-03-21 10:56:38, David Hildenbrand wrote:
> > > > On 25.03.21 01:28, Mike Kravetz wrote:
> > > > > From: Roman Gushchin <guro@fb.com>
> > > > > 
> > > > > cma_release() has to lock the cma_lock mutex to clear the cma bitmap.
> > > > > It makes it a blocking function, which complicates its usage from
> > > > > non-blocking contexts. For instance, hugetlbfs code is temporarily
> > > > > dropping the hugetlb_lock spinlock to call cma_release().
> > > > > 
> > > > > This patch introduces a non-blocking cma_release_nowait(), which
> > > > > postpones the cma bitmap clearance. It's done later from a work
> > > > > context. The first page in the cma allocation is used to store
> > > > > the work struct. Because CMA allocations and de-allocations are
> > > > > usually not that frequent, a single global workqueue is used.
> > > > > 
> > > > > To make sure that subsequent cma_alloc() call will pass, cma_alloc()
> > > > > flushes the cma_release_wq workqueue. To avoid a performance
> > > > > regression in the case when only cma_release() is used, gate it
> > > > > by a per-cma area flag, which is set by the first call
> > > > > of cma_release_nowait().
> > > > > 
> > > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > > [mike.kravetz@oracle.com: rebased to v5.12-rc3-mmotm-2021-03-17-22-24]
> > > > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > > > ---
> > > > 
> > > > 
> > > > 1. Is there a real reason this is a mutex and not a spin lock? It seems to
> > > > only protect the bitmap. Are bitmaps that huge that we spend a significant
> > > > amount of time in there?
> > > 
> > > Good question. Looking at the code it doesn't seem that there is any
> > > blockable operation or any heavy lifting done under the lock.
> > > 7ee793a62fa8 ("cma: Remove potential deadlock situation") has introduced
> > > the lock and there was a simple bitmat protection back then. I suspect
> > > the patch just followed the cma_mutex lead and used the same type of the
> > > lock. cma_mutex used to protect alloc_contig_range which is sleepable.
> > > 
> > > This all suggests that there is no real reason to use a sleepable lock
> > > at all and we do not need all this heavy lifting.
> > > 
> > 
> > When Roman first proposed these patches, I brought up the same issue:
> > 
> > https://lore.kernel.org/linux-mm/20201022023352.GC300658@carbon.dhcp.thefacebook.com/
> > 
> > Previously, Roman proposed replacing the mutex with a spinlock but
> > Joonsoo was opposed.
> > 
> > Adding Joonsoo on Cc:
> > 
> 
> There has to be a good reason not to. And if there is a good reason,
> lockless clearing might be one feasible alternative.

I also don't think nowait variant is good idea. If the scanning of
bitmap is *really* significant, it might be signal that we need to
introduce different technique or data structure not bitmap rather
than a new API variant.
