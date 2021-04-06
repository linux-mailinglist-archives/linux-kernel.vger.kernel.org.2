Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F5355942
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbhDFQeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:34:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:55950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346415AbhDFQeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:34:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7249B26B;
        Tue,  6 Apr 2021 16:33:59 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 06 Apr 2021 18:33:59 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] mm,memory_hotplug: Relax fully spanned sections
 check
In-Reply-To: <b915143d-a8df-ddfc-94a8-7578fdd5f7bc@redhat.com>
References: <20210406111115.8953-1-osalvador@suse.de>
 <20210406111115.8953-3-osalvador@suse.de>
 <b915143d-a8df-ddfc-94a8-7578fdd5f7bc@redhat.com>
User-Agent: Roundcube Webmail
Message-ID: <df9bdb5157d6ad2f4a922d396ddf0c07@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-06 17:32, David Hildenbrand wrote:
> I'd only relax start_pfn. That way the function is pretty much
> impossible to abuse for sub-section onlining/offlining.
> 
> if (WARN_ON_ONCE(!nr_pages ||
> 		 !IS_ALIGNED(start_pfn, pageblock_nr_pages))
> 		 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))

But this is not going to work.
When using memmap_on_memory, the nr of pages that online_pages() and 
offline_pages() get might be less than PAGES_PER_SECTION, so this check 
will always blow us up.

-- 
Oscar Salvador
SUSE L3
