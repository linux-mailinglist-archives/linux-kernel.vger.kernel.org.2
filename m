Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE79034C530
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhC2HrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:47:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:41300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhC2Hqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:46:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617004006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4a2jyIpz8nOytOLiHN/bRf2rXhs6J4Qg28YA4GgVXg=;
        b=M+jGBwpI96doNvo22z45CvBY/TPT/ppfA65MKNcF4tZqJfvN3vas6fmkhiE0XU4+UH4NI4
        zIkHvSiAbEnptQizzrwq5t9wNeXr19+dyfZ0RNe/Sw72oWsiHRSnRMLTFYEHIE/AEefAnt
        fCMcWcRs8eYOfx9ieCQWscYFpPQjQ/E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D7E5AEA6;
        Mon, 29 Mar 2021 07:46:46 +0000 (UTC)
Date:   Mon, 29 Mar 2021 09:46:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <YGGF4tFogzETutOR@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-2-mike.kravetz@oracle.com>
 <aba43427-0f51-7eb9-fa73-6e55237c8ddb@redhat.com>
 <YFxkXEXMpcMM/KWd@dhcp22.suse.cz>
 <76aaf359-9496-04df-a585-3662d0375749@oracle.com>
 <4bc3c5d8-f1a7-6439-8fee-582364a7c021@redhat.com>
 <YFzuw0S5S/aG7nVk@google.com>
 <YF0agS53iGkFo41Y@carbon.DHCP.thefacebook.com>
 <d1e712f3-c2f2-dcad-85c0-dc152bb8eecb@oracle.com>
 <0f7f3c4e-530a-5cd2-2719-259e509366e4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f7f3c4e-530a-5cd2-2719-259e509366e4@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-03-21 14:32:01, Mike Kravetz wrote:
[...]
> - Just change the mutex to an irq safe spinlock.

Yes please.

>   AFAICT, the potential
>   downsides could be:
>   - Interrupts disabled during long bitmap scans

How large those bitmaps are in practice?

>   - Wasted cpu cycles (spinning) if there is much contention on lock
>   Both of these would be more of an issue on small/embedded systems. I
>   took a quick look at the callers of cma_alloc/cma_release and nothing
>   stood out that could lead to high degrees of contention.  However, I
>   could have missed something.

If this is really a practical concern then we can try a more complex
solution based on some data.

-- 
Michal Hocko
SUSE Labs
