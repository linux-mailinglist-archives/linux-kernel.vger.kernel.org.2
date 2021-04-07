Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA43564CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbhDGHLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:11:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:50892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhDGHLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:11:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2F85B083;
        Wed,  7 Apr 2021 07:11:34 +0000 (UTC)
Date:   Wed, 7 Apr 2021 09:11:32 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] mm,memory_hotplug: Factor out adjusting present
 pages into adjust_present_page_count()
Message-ID: <20210407071119.GA8659@linux>
References: <20210406111115.8953-1-osalvador@suse.de>
 <20210406111115.8953-4-osalvador@suse.de>
 <f2682c45-1a7d-cefa-ccf1-af54898421f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2682c45-1a7d-cefa-ccf1-af54898421f1@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 05:33:46PM +0200, David Hildenbrand wrote:
> On 06.04.21 13:11, Oscar Salvador wrote:
> > From: David Hildenbrand <david@redhat.com>
> > 
> > Let's have a single place (inspired by adjust_managed_page_count()) where
> > we adjust present pages, to prepare for additional bookkeeping.
> 
> Maybe in the context of this series, remove the "additional bookkeeping"
> part.

Definitely, it was a slip.

Thanks

-- 
Oscar Salvador
SUSE L3
