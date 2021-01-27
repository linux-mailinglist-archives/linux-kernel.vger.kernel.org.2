Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC774305A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhA0LzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:55:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:60598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237395AbhA0LwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:52:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5784ABDA;
        Wed, 27 Jan 2021 11:51:30 +0000 (UTC)
Date:   Wed, 27 Jan 2021 12:51:27 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 2/2] mm: simplify free_highmem_page() and
 free_reserved_page()
Message-ID: <20210127115122.GA28728@linux>
References: <20210126182113.19892-1-david@redhat.com>
 <20210126182113.19892-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126182113.19892-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 07:21:13PM +0100, David Hildenbrand wrote:
> adjust_managed_page_count() as called by free_reserved_page() properly
> handles pages in a highmem zone, so we can reuse it for
> free_highmem_page().
> 
> We can now get rid of totalhigh_pages_inc() and simplify
> free_reserved_page().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> +#define free_highmem_page(page) free_reserved_page(page)

Should we place that under #ifdef CONFIG_HIGHMEM to make clear
that it is only used on that config?
Maybe the #ifdefery ugliness does not pay off.

-- 
Oscar Salvador
SUSE L3
