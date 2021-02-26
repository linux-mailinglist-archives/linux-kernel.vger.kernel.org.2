Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B739326194
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhBZKwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:52:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:37028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230144AbhBZKwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:52:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D802AE72;
        Fri, 26 Feb 2021 10:52:04 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] trim the uses of compound_head()
To:     Yu Zhao <yuzhao@google.com>, akpm@linux-foundation.org,
        alex.shi@linux.alibaba.com, willy@infradead.org
Cc:     guro@fb.com, hannes@cmpxchg.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20210224084807.2179942-1-yuzhao@google.com>
 <20210226091718.2927291-1-yuzhao@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bd876842-b1e6-66fd-da1a-b181cede101a@suse.cz>
Date:   Fri, 26 Feb 2021 11:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226091718.2927291-1-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/21 10:17 AM, Yu Zhao wrote:
> Patch series "mm: lru related cleanups" starting at commit 42895ea73bcd
> ("mm/vmscan.c: use add_page_to_lru_list()") bloated vmlinux by 1777
> bytes, according to:
>   https://lore.kernel.org/linux-mm/85b3e8f2-5982-3329-c20d-cf062b8da71e@suse.cz/

Huh, I thought Andrew didn't want to send it for 5.12:
https://lore.kernel.org/linux-mm/20210223145011.0181eed96ab0091a493b51f6@linux-foundation.org/

> It turned out many places inline Page{Active,Unevictable} which in
> turn include compound_head().
> 
> From the v1:
>   Removing compound_head() entirely from Page{Active,Unevictable} may
>   not be the best option (for the moment) because there may be other
>   cases that need compound_head().
> 
> In addition to picking a couple pieces of low-hanging fruit, this v2
> removes compound_head() completely from Page{Active,Unevictable}.
> 
> bloat-o-meter result before and after the series:
>   add/remove: 0/0 grow/shrink: 6/92 up/down: 697/-7656 (-6959)

Good that you found a way to more than undo the bloat then. But we need to be
careful so bugs are not introduced due to pressure to not have bloated 5.12.

IIRC Kirill introduced these macros so I'm CCing him.

> Yu Zhao (3):
>   mm: bypass compound_head() for PF_NO_TAIL when enforce=1
>   mm: use PF_NO_TAIL for PG_lru
>   mm: use PF_ONLY_HEAD for PG_active and PG_unevictable
> 
>  fs/proc/task_mmu.c         |  3 ++-
>  include/linux/page-flags.h | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 

