Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADFC34D397
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhC2PSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:18:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40106 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhC2PSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:18:13 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lQteb-00050s-LV; Mon, 29 Mar 2021 15:18:09 +0000
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Colin Ian King <colin.king@canonical.com>
Subject: re: mm/page_alloc: add a bulk page allocator
Message-ID: <61c479aa-18fe-82f3-c859-710c3555cbaa@canonical.com>
Date:   Mon, 29 Mar 2021 16:18:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis on linux-next with Coverity has found a potential
uninitialized variable issue in function __alloc_pages_bulk with the
following commit:

commit b0e0a469733fa571ddd8fe147247c9561b51b2da
Author: Mel Gorman <mgorman@techsingularity.net>
Date:   Mon Mar 29 11:12:24 2021 +1100

    mm/page_alloc: add a bulk page allocator

The analysis is as follows:

5023 unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
5024                        nodemask_t *nodemask, int nr_pages,
5025                        struct list_head *page_list,
5026                        struct page **page_array)
5027 {
5028        struct page *page;
5029        unsigned long flags;
5030        struct zone *zone;
5031        struct zoneref *z;
5032        struct per_cpu_pages *pcp;
5033        struct list_head *pcp_list;
5034        struct alloc_context ac;
5035        gfp_t alloc_gfp;
    1. var_decl: Declaring variable alloc_flags without initializer.
5036        unsigned int alloc_flags;
5037        int nr_populated = 0;
5038
    2. Condition !!(nr_pages <= 0), taking false branch.
5039        if (unlikely(nr_pages <= 0))
5040                return 0;
5041
5042        /*
5043         * Skip populated array elements to determine if any pages need
5044         * to be allocated before disabling IRQs.
5045         */
    3. Condition page_array, taking true branch.
    4. Condition page_array[nr_populated], taking true branch.
    5. Condition nr_populated < nr_pages, taking true branch.
    7. Condition page_array, taking true branch.
    8. Condition page_array[nr_populated], taking true branch.
    9. Condition nr_populated < nr_pages, taking true branch.
    11. Condition page_array, taking true branch.
    12. Condition page_array[nr_populated], taking true branch.
    13. Condition nr_populated < nr_pages, taking false branch.
5046        while (page_array && page_array[nr_populated] &&
nr_populated < nr_pages)
    6. Jumping back to the beginning of the loop.
    10. Jumping back to the beginning of the loop.
5047                nr_populated++;
5048
5049        /* Use the single page allocator for one page. */
    14. Condition nr_pages - nr_populated == 1, taking false branch.
5050        if (nr_pages - nr_populated == 1)
5051                goto failed;
5052
5053        /* May set ALLOC_NOFRAGMENT, fragmentation will return 1
page. */
5054        gfp &= gfp_allowed_mask;
5055        alloc_gfp = gfp;

    Uninitialized scalar variable (UNINIT)
    15. uninit_use_in_call: Using uninitialized value alloc_flags when
calling prepare_alloc_pages.

5056        if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask,
&ac, &alloc_gfp, &alloc_flags))
5057                return 0;

And in prepare_alloc_pages():

4957 static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int
order,
4958                int preferred_nid, nodemask_t *nodemask,
4959                struct alloc_context *ac, gfp_t *alloc_gfp,
4960                unsigned int *alloc_flags)
4961 {
4962        ac->highest_zoneidx = gfp_zone(gfp_mask);
4963        ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
4964        ac->nodemask = nodemask;
4965        ac->migratetype = gfp_migratetype(gfp_mask);
4966

    1. Condition cpusets_enabled(), taking false branch.

4967        if (cpusets_enabled()) {
4968                *alloc_gfp |= __GFP_HARDWALL;
4969                /*
4970                 * When we are in the interrupt context, it is
irrelevant
4971                 * to the current task context. It means that any
node ok.
4972                 */
4973                if (!in_interrupt() && !ac->nodemask)
4974                        ac->nodemask = &cpuset_current_mems_allowed;
4975                else
4976                        *alloc_flags |= ALLOC_CPUSET;
4977        }
4978
4979        fs_reclaim_acquire(gfp_mask);
4980        fs_reclaim_release(gfp_mask);
4981
    2. Condition gfp_mask & 1024U /* (gfp_t)1024U */, taking true branch.
4982        might_sleep_if(gfp_mask & __GFP_DIRECT_RECLAIM);
4983
    3. Condition should_fail_alloc_page(gfp_mask, order), taking false
branch.
4984        if (should_fail_alloc_page(gfp_mask, order))
4985                return false;
4986
    4. read_value: Reading value *alloc_flags when calling
gfp_to_alloc_flags_cma.
4987        *alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);

And in call gfp_to_alloc_flags_cma():

in /mm/page_alloc.c

3853 static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
3854                                                  unsigned int
alloc_flags)
3855 {
3856#ifdef CONFIG_CMA
    1. Condition gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE, taking
true branch.
3857        if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
    2. read_value: Reading value alloc_flags.
3858                alloc_flags |= ALLOC_CMA;
3859#endif
3860        return alloc_flags;
3861 }

So alloc_flags in gfp_to_alloc_flags_cma is being updated with the |=
operator and we managed to get to this path with uninitialized
alloc_flags.  Should alloc_flags be initialized to zero in
__alloc_page_bulk()?

Colin


