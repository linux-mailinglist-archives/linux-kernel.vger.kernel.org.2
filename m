Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53669326070
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBZJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:48:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:47304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhBZJsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:48:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80850AF31;
        Fri, 26 Feb 2021 09:47:35 +0000 (UTC)
Date:   Fri, 26 Feb 2021 10:47:32 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <20210226094732.GB3240@linux>
References: <YDizi3/TKYnSi5Zo@dhcp22.suse.cz>
 <1F1B32C0-10EA-4A7F-A062-1B8CE8D47C3F@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1F1B32C0-10EA-4A7F-A062-1B8CE8D47C3F@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:25:46AM +0100, David Hildenbrand wrote:
> I‘m planning on giving both patches a churn early next week, with
> 
> a) free huge pages
> b) idle allocated huge pages
> c) heavily read huge pages
> 
> (Them I‘m also planning on having another brief look at the patches :) )

That would be great, thanks!

-- 
Oscar Salvador
SUSE L3
