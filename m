Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC43A381D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 01:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhFJXw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 19:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhFJXw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 19:52:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7D2F6136D;
        Thu, 10 Jun 2021 23:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623369060;
        bh=iwUAIwA2W61o1prvvamdUIf6AtaFz5r7O1ts0WnAZvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1hl+iDvOesB0fP8b2CzjhanTWLNZOLkfRKgOqgpfhGZM15tqXB+coZwUEFJ2lASH/
         XRLZjV1KhdbNKDn1pEge5HGh0MSAlnXvhQiELoSAsV6sFnPd/MbX1Qz8koYfTmJ/21
         p61OmRf9ebrOMJdCoGcgNkHPV/mSGJTsF2RpdD3k=
Date:   Thu, 10 Jun 2021 16:50:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/hwpoison: do not lock page again when
 me_huge_page() successfully recovers
Message-Id: <20210610165059.6618498250f60674c1bb9c03@linux-foundation.org>
In-Reply-To: <20210609072029.74645-1-nao.horiguchi@gmail.com>
References: <20210609072029.74645-1-nao.horiguchi@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jun 2021 16:20:29 +0900 Naoya Horiguchi <nao.horiguchi@gmail.com> wrote:

> Currently me_huge_page() temporary unlocks page to perform some actions
> then locks it again later.  My testcase (which calls hard-offline on
> some tail page in a hugetlb, then accesses the address of the hugetlb
> range) showed that page allocation code detects this page lock on buddy
> page and printed out "BUG: Bad page state" message.
> 
> check_new_page_bad() does not consider a page with __PG_HWPOISON as bad
> page, so this flag works as kind of filter, but this filtering doesn't
> work in this case because the "bad page" is not the actual hwpoisoned
> page. So stop locking page again.  Actions to be taken depend on the
> page type of the error, so page unlocking should be done in ->action()
> callbacks.  So let's make it assumed and change all existing callbacks
> that way.

I'm getting a reject against Linus mainline here, and a -stable patch
doesn't want such things happening.

--- mm/memory-failure.c
+++ mm/memory-failure.c
@@ -1782,6 +1796,8 @@ int memory_failure(unsigned long pfn, int flags)
 
 identify_page_state:
 	res = identify_page_state(pfn, p, page_flags);
+	mutex_unlock(&mf_mutex);
+	return res;
 unlock_page:
 	unlock_page(p);
 unlock_mutex:

and...  That mutex_unlock() looks odd.  The patch adds no matching
mutex_lock?
