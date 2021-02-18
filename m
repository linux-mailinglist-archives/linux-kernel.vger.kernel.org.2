Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0118F31E645
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 07:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhBRGV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 01:21:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:37674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231865AbhBRGCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 01:02:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27CF7AF4F;
        Thu, 18 Feb 2021 06:01:10 +0000 (UTC)
Date:   Thu, 18 Feb 2021 07:01:06 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <20210218060106.GA3375@localhost.localdomain>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-3-osalvador@suse.de>
 <YC0xAmuJLJ6yNbCD@dhcp22.suse.cz>
 <66332742e9f44697212f25061790291e@suse.de>
 <YC03Pmb6/ePK2UPn@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC03Pmb6/ePK2UPn@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 04:33:18PM +0100, Michal Hocko wrote:
> OK, I have missed that. Maybe just extend the comment. 
> 
> 	/*
> 	 * Hugepage was succesfully isolated and on the tmigratepages
> 	 * list 
> 	 */

Sure, I will improve it.

Thanks 

-- 
Oscar Salvador
SUSE L3
