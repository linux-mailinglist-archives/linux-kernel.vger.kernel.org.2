Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E023EDCB1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhHPR5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:57:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:17964 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232320AbhHPR5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:57:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="237980198"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="237980198"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 10:56:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="519744355"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 10:56:48 -0700
Date:   Mon, 16 Aug 2021 10:56:46 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] mm,hwpoison: fix race with hugetlb page allocation
Message-ID: <20210816175646.GA1600630@agluck-desk2.amr.corp.intel.com>
References: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
 <20210603233632.2964832-2-nao.horiguchi@gmail.com>
 <20210812042813.GA1576603@agluck-desk2.amr.corp.intel.com>
 <20210812090303.GA153531@hori.linux.bs1.fc.nec.co.jp>
 <20210812152548.GA1579021@agluck-desk2.amr.corp.intel.com>
 <20210813062951.GA203438@hori.linux.bs1.fc.nec.co.jp>
 <96d4fd8b75e44a6c970e4d9530980f21@intel.com>
 <20210816171207.GA2239284@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816171207.GA2239284@u2004>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 02:12:07AM +0900, Naoya Horiguchi wrote:
> This dump indicates that HWPoisonHandlable() returned false due to
> the lack of PG_lru flag.  In older code before 5.13, get_any_page() does
> retry with shake_page(), but does not since 5.13, which seems to me
> the root cause of the issue. So my suggestion is to call shake_page()
> when HWPoisonHandlable() is false.
> 
> Could you try checking that the following diff fixes the issue?
> I could still have better fix (like inserting shake_page() to other
> retry paths in get_any_page()), but the below is the minimum one.

Tried it ... and it works! Injected and recovered from a thousand
errors without seeing any problems.

-Tony

P.S. Somewhere in the mail system your patch arrived with <TAB>s
changed to spaces. Here's what I applied to v5.14-rc6 (hopefully with
TABS preserved) ... just in case anyone else is following along with
this thread and wants to try some tests.

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index eefd823deb67..aa6592540f17 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1146,7 +1146,7 @@ static int __get_hwpoison_page(struct page *page)
 	 * unexpected races caused by taking a page refcount.
 	 */
 	if (!HWPoisonHandlable(head))
-		return 0;
+		return -EBUSY;
 
 	if (PageTransHuge(head)) {
 		/*
@@ -1199,9 +1199,14 @@ static int get_any_page(struct page *p, unsigned long flags)
 			}
 			goto out;
 		} else if (ret == -EBUSY) {
-			/* We raced with freeing huge page to buddy, retry. */
-			if (pass++ < 3)
+			/*
+			 * We raced with (possibly temporary) unhandlable
+			 * page, retry.
+			 */
+			if (pass++ < 3) {
+				shake_page(p, 1);
 				goto try_again;
+			}
 			goto out;
 		}
 	}
