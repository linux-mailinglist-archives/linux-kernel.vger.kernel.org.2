Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527DF32D10A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbhCDKmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:42:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:38790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238851AbhCDKlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:41:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E779DAAC5;
        Thu,  4 Mar 2021 10:41:08 +0000 (UTC)
Date:   Thu, 4 Mar 2021 11:41:06 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YEC5QvTl6RGNbytK@localhost.localdomain>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-2-osalvador@suse.de>
 <3f071dd4-3181-f4e0-fd56-1a70f6ac72fe@redhat.com>
 <YEC0ODM5gtEU+JqN@localhost.localdomain>
 <4ede47fd-d01e-6d9c-288a-2ec97b5392af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ede47fd-d01e-6d9c-288a-2ec97b5392af@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:32:29AM +0100, David Hildenbrand wrote:
> I think this is now the second fatal error we can have (-EINTR, -ENOMEM),
> thus the current interface (return "NULL" on fatal errros) no longer works
> properly.
> 
> No strong opinion about fixing this up on top - could be it's cleaner to
> just do it right away.

Ok, I see.

Then I will start working on that in v4.

Any more feedback to either patch#1 or patch#2?

Thanks!


-- 
Oscar Salvador
SUSE L3
