Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B28232E2E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 08:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhCEH1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 02:27:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:39914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEH1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 02:27:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CDB4AF10;
        Fri,  5 Mar 2021 07:27:01 +0000 (UTC)
Date:   Fri, 5 Mar 2021 08:26:58 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, hwpoison: do not lock page again when
 me_huge_page() successfully recovers
Message-ID: <20210305072652.GA18868@linux>
References: <20210304064437.962442-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304064437.962442-1-nao.horiguchi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 03:44:37PM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Hi Naoya,

good catch!

> Currently me_huge_page() temporary unlocks page to perform some actions
> then locks it again later. My testcase (which calls hard-offline on some
> tail page in a hugetlb, then accesses the address of the hugetlb range)
> showed that page allocation code detects the page lock on buddy page and
> printed out "BUG: Bad page state" message.  PG_hwpoison does not prevent
> it because PG_hwpoison flag is set on any subpage of the hugetlb page
> but the 2nd page lock is on the head page.

I am having difficulties to parse "PG_hwpoison does not prevent it because
PG_hwpoison flag is set on any subpage of the hugetlb page".

What do you mean by that?

> 
> This patch suggests to drop the 2nd page lock to fix the issue.
> 
> Fixes: commit 78bb920344b8 ("mm: hwpoison: dissolve in-use hugepage in unrecoverable memory error")
> Cc: stable@vger.kernel.org
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

The fix looks fine to me:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE L3
