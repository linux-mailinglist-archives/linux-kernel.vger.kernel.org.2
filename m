Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918CD390050
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhEYLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:50:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:40722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhEYLt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:49:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621943306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qp1mQQxgGsYBd7JwEAcG9fT9rHfyYbjsgsObBaU2qc=;
        b=sLyTadvciYNlE2gG/xEWXVtBX92yplamEaVUIwoiyoUXzEyuwzwBXxCUPKfgMNhb+It7XB
        kBKvVMwLiuQvBS5s/ZG2OwPjMpy3cj9EwpbPBcYjSGE24vm6kALTL3iJDmqSg6HfneQ676
        bGwk1ubaTNyFzoMLrAvdJ+WPAeMvBvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621943306;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qp1mQQxgGsYBd7JwEAcG9fT9rHfyYbjsgsObBaU2qc=;
        b=cOCWdUcqBLQXVeewUuKGerxScWtSE7ZD+HoX0Dgmx0afV308UOEyCQme2FTrBS+pnDnYAm
        jYp8FWgfK+WP18Bg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3542AF03;
        Tue, 25 May 2021 11:48:26 +0000 (UTC)
Subject: Re: [PATCH 00/14] Clean W=1 build warnings for mm/
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Yang Shi <shy828301@gmail.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210520084809.8576-1-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <aad3f04f-850a-b134-d0a7-b24af9721ddb@suse.cz>
Date:   Tue, 25 May 2021 13:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520084809.8576-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/21 10:47 AM, Mel Gorman wrote:
> This is a janitorial only. During development of a tool to catch build
> warnings early to avoid tripping the Intel lkp-robot, I noticed that mm/
> is not clean for W=1. This is generally harmless but there is no harm in
> cleaning it up. It disrupts git blame a little but on relatively obvious
> lines that are unlikely to be git blame targets.
> 
>  include/asm-generic/early_ioremap.h | 9 +++++++++
>  include/linux/mmzone.h              | 5 ++++-
>  include/linux/swap.h                | 6 +++++-
>  mm/internal.h                       | 3 +--
>  mm/mapping_dirty_helpers.c          | 2 +-
>  mm/memcontrol.c                     | 2 +-
>  mm/memory_hotplug.c                 | 6 +++---
>  mm/mmap_lock.c                      | 2 ++
>  mm/page_alloc.c                     | 2 +-
>  mm/vmalloc.c                        | 3 +++
>  mm/vmscan.c                         | 2 +-
>  mm/z3fold.c                         | 2 ++
>  mm/zbud.c                           | 2 ++
>  13 files changed, 35 insertions(+), 11 deletions(-)

Thanks, looks good.

patch 3/14 subject looks like it should read just "mm/page_alloc: Make
should_fail_alloc_page a static function"

Acked-by: Vlastimil Babka <vbabka@suse.cz>


