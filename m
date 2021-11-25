Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F9F45D470
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 06:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbhKYFy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 00:54:56 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:42516 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245252AbhKYFwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 00:52:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UyDytYc_1637819376;
Received: from 30.21.164.78(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UyDytYc_1637819376)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Nov 2021 13:49:37 +0800
Message-ID: <141bdfc6-f898-3cc3-f692-726c5f6cb74d@linux.alibaba.com>
Date:   Thu, 25 Nov 2021 13:50:25 +0800
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
 <d51d8f1a-ebda-e45a-9dd5-e5cca707ccdc@linux.alibaba.com>
 <7423472b-a6d4-4b37-0953-24b11aba2fad@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <7423472b-a6d4-4b37-0953-24b11aba2fad@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/25 3:05, Mike Kravetz wrote:
> On 11/24/21 02:47, Baolin Wang wrote:
>>
>>
>> On 2021/11/24 3:25, Mike Kravetz wrote:
>>> On 11/15/21 22:03, Baolin Wang wrote:
>>>> On 2021/11/16 12:21, Andrew Morton wrote:
>>>>> On Sun,  7 Nov 2021 16:57:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>>
>>> I 'think' this is OK since the behavior is not really defined today.  But, we
>>> are changing user visible output.
>>
>> Actually we did not change the user visible output for a hugetlb migration. Since we still return the number of hugetlb failed to migrate as before (though previous hugetlb behavior is not reasonable), not the number of hguetlb subpages. We just correct the hugetlb migration stats for the hugetlb in kernel, like PGMIGRATE_SUCCESS/FAIL stats.
>>
> 
> Yes, the values returned by move_pages() will not change.
> 
> The 'stats' in the kernel which are changing are user visible.  Specifically.
> the fields pgmigrate_success and pgmigrate_fail in the file /proc/vmstat.
> The values reported there for migrated hugetlb pages is changing as a result
> of this series.
> 
> In addition, if someone monitors the trace point at the end of migrate_pages
> they will start seeing different values.

Right, agree.

> 
> As mentioned, these values are not currently documented for hugetlb pages so
> I think it is OK to change.  If someone thinks otherwise, please speak up!
> 
> Making them be similar to what is reported for THP pages would be a good
> thing.

OK.

>>>
>>> Perhaps we should go ahead and document the hugetlb behavior when making these
>>> changes?
>>
>> Sure. How about adding below modification for hugetlb?
> 
> Yes, please do make the below changes as well.

Thanks.

Andrew, I am not sure you can help to fold below changes into your mm 
branch, or you want me to resend this patch set with adding below 
changes, or just send an incremental patch to add hugetlb documentation?

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
