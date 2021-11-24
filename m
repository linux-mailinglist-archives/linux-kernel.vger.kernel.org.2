Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AFD45B89D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhKXKuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:50:17 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43750 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229482AbhKXKuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:50:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uy7GqCS_1637750824;
Received: from 30.21.164.55(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uy7GqCS_1637750824)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Nov 2021 18:47:05 +0800
Message-ID: <d51d8f1a-ebda-e45a-9dd5-e5cca707ccdc@linux.alibaba.com>
Date:   Wed, 24 Nov 2021 18:47:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/3] mm: migrate: Correct the hugetlb migration stats
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ziy@nvidia.com, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
 <71a4b6c22f208728fe8c78ad26375436c4ff9704.1636275127.git.baolin.wang@linux.alibaba.com>
 <20211115202146.473fff2404d7fb200dd48bd3@linux-foundation.org>
 <71816b8f-93e5-5a2a-e616-d52a1c4d354c@linux.alibaba.com>
 <3e6dcac6-c947-5f94-cd94-b59a8247dbcf@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3e6dcac6-c947-5f94-cd94-b59a8247dbcf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/24 3:25, Mike Kravetz wrote:
> On 11/15/21 22:03, Baolin Wang wrote:
>>
>>
>> On 2021/11/16 12:21, Andrew Morton wrote:
>>> On Sun,  7 Nov 2021 16:57:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>> Correct the migration stats for hugetlb with using compound_nr() instead
>>>> of thp_nr_pages(),
>>>
>>> It would be helpful to explain why using thp_nr_pages() was wrong.
>>
>> Sure. Using thp_nr_pages() to get the number of subpages for a hugetlb is incorrect, since the number of subpages in te hugetlb is not always HPAGE_PMD_NR.
>>
> 
> Correct.  However, prior to this patch the return value from thp_nr_pages
> was never used for hugetlb pages; only THP.  So, this really did not have any
> bad side effects prior to this patch that I can see. >
>>> And to explain the end user visible effects of this bug so we can
>>
>> Actually not also user visible effect, but also hugetlb migration stats in kernel are incorrect. For he end user visible effects, like I described in patch 1,  the syscall move_pages() can return a non-migrated number larger than the number of pages the users tried to migrate, when a THP page is failed to migrate. This is confusing for users.
>>
> 
> It looks like hugetlb pages were never taken into account when originally
> defining the migration stats.  In the documentation (page_migration.rst) it
> only talks about Normal and THP pages.  It does not mention how hugetlb pages
> are counted.
> 
> Currently, hugetlb pages count as 'a single page' in the stats
> PGMIGRATE_SUCCESS/FAIL.  Correct?  After this change we will increment these
> stats by the number of sub-pages.  Correct?

Right.

> 
> I 'think' this is OK since the behavior is not really defined today.  But, we
> are changing user visible output.

Actually we did not change the user visible output for a hugetlb 
migration. Since we still return the number of hugetlb failed to migrate 
as before (though previous hugetlb behavior is not reasonable), not the 
number of hguetlb subpages. We just correct the hugetlb migration stats 
for the hugetlb in kernel, like PGMIGRATE_SUCCESS/FAIL stats.

> 
> Perhaps we should go ahead and document the hugetlb behavior when making these
> changes?

Sure. How about adding below modification for hugetlb?
diff --git a/Documentation/vm/page_migration.rst 
b/Documentation/vm/page_migration.rst
index 08810f5..8c5cb81 100644
--- a/Documentation/vm/page_migration.rst
+++ b/Documentation/vm/page_migration.rst
@@ -263,15 +263,15 @@ Monitoring Migration
  The following events (counters) can be used to monitor page migration.

  1. PGMIGRATE_SUCCESS: Normal page migration success. Each count means 
that a
-   page was migrated. If the page was a non-THP page, then this counter is
-   increased by one. If the page was a THP, then this counter is 
increased by
-   the number of THP subpages. For example, migration of a single 2MB 
THP that
-   has 4KB-size base pages (subpages) will cause this counter to 
increase by
-   512.
+   page was migrated. If the page was a non-THP and non-hugetlb page, then
+   this counter is increased by one. If the page was a THP or hugetlb, then
+   this counter is increased by the number of THP or hugetlb subpages.
+   For example, migration of a single 2MB THP that has 4KB-size base pages
+   (subpages) will cause this counter to increase by 512.

  2. PGMIGRATE_FAIL: Normal page migration failure. Same counting rules 
as for
     PGMIGRATE_SUCCESS, above: this will be increased by the number of 
subpages,
-   if it was a THP.
+   if it was a THP or hugetlb.

  3. THP_MIGRATION_SUCCESS: A THP was migrated without being split.
