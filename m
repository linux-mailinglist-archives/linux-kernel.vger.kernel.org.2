Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB793EE06A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 01:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhHPX2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 19:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhHPX2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 19:28:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5874B60F35;
        Mon, 16 Aug 2021 23:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629156470;
        bh=OdMJAwPOuwuJZ7/QF/0/fC6Kak6vxLEJ4D/q/1SGn98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WCOKRmXg1hB/Q8MAwBJc2nIRAyNLQ+hdHoANuA5v1B7YXHUyI3e7TDOJ6RcKbjwTb
         C4UhqWI0koQskgJ8yY8iaHLJc+3nqaHQ7+iMQcq1IHUqxiP+hqbyH6Dc2LxlLG4pYG
         alNTlBWeB/LC2YLkSfra2NwA7maGCxptzupMPuyw=
Date:   Mon, 16 Aug 2021 16:27:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
Message-Id: <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
In-Reply-To: <20210816224953.157796-1-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, pushback...

On Mon, 16 Aug 2021 15:49:45 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> 
> Real world use cases
> --------------------
> There are groups today using hugetlb pages to back VMs on x86.  Their
> use case is as described above.  They have experienced the issues with
> performance and not necessarily getting the excepted number smaller huge

("number of")

> pages after free/allocate cycle.
> 

It really is a ton of new code.  I think we're owed much more detail
about the problem than the above.  To be confident that all this
material is truly justified?

Also, some selftests and benchmarking code in tools/testing/selftests
would be helpful?
