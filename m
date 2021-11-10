Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A1044C55E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhKJQwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhKJQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:52:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D00C061764;
        Wed, 10 Nov 2021 08:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5tEk+9IC6breLjA9Y5Hl6sjwzv1uZV7l5Zia416dvHg=; b=tQAMRO6Ez06RwurTHSr9s7avVV
        Tz9krQ6BkKZUbdoYUw58TAYyPIAXBXPEpFjZFeUjuRpqF0nAmlVoc4VvJZhnX3z5DWWqTkr155uH3
        pGwKEh6yAei7elz7lT0hSlMkUoPpQPxj5MfciPpy59zFMD33a1QPQoDaXDH50B1uzrsh5pzzPT0bo
        rezzJ/abVwdShGbpYFqExlLNllY3IXs4kIHKUzqBxIjtoaBxikSCHPxXLQg+zMS/MVZWyMrui81vv
        V1Q6MygcWXzmK6Ag1HuU5ZwiwFL50nIxzM4zeZYX0OVbd+I4RapBK8+mRbBfa6QpyYhUC+n5rOVKF
        L/14o88g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkqnK-0021ZL-Bk; Wed, 10 Nov 2021 16:49:54 +0000
Date:   Wed, 10 Nov 2021 16:49:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
Message-ID: <YYv4Msg7zVLS3KE/@casper.infradead.org>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110125601.GQ1740502@nvidia.com>
 <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
 <20211110143859.GS1740502@nvidia.com>
 <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 04:37:14PM +0100, David Hildenbrand wrote:
> > I'd suggest to make this new lock a special rwsem which allows either
> > concurrent read access OR concurrent PTL access, but not both. This
> 
> I looked into such a lock recently in similar context and something like
> that does not exist yet (and fairness will be challenging). You either
> have a single reader or multiple writer. I'd be interested if someone
> knows of something like that.

We've talked about having such a lock before for filesystems which want
to permit either many direct-IO accesses or many buffered-IO accesses, but
want to exclude a mixture of direct-IO and buffered-IO.  The name we came
up with for such a lock was the red-blue lock.  Either Team Red has the
lock, or Team Blue has the lock (or it's free).  Indicate free with velue
zero, Team Red with positive numbers and Team Blue with negative numbers.
If we need to indicate an opposing team is waiting for the semaphore,
we can use a high bit (1 << 30) to indicate no new team members can
acquire the lock.  Not sure whether anybody ever coded it up.
