Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD572361E11
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbhDPKi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:38:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:36192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233979AbhDPKiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:38:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E10B3B000;
        Fri, 16 Apr 2021 10:37:59 +0000 (UTC)
Date:   Fri, 16 Apr 2021 12:37:54 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YHlpAvTPuRZtKo0i@localhost.localdomain>
References: <20210416102153.8794-1-osalvador@suse.de>
 <20210416102153.8794-5-osalvador@suse.de>
 <df8220ac-4214-5ff6-0048-35553fea8c8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df8220ac-4214-5ff6-0048-35553fea8c8c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 12:33:34PM +0200, David Hildenbrand wrote:
> IIRC, we have to add the zero shadow first, before touching the memory. This
> is also what mm/memremap.c does.
> 
> In mhp_deinit_memmap_on_memory(), you already remove in the proper
> (reversed) order :)

But looking at online_pages(), we do it after the
move_pfn_range_to_zone(), right? AFAIK (I might be well wrong here),
memory_notify() will eventually call kasan_add_zero_shadow? So that
comes after the move_pfn_range_to_zone? Or is my understanding
incorrect?


-- 
Oscar Salvador
SUSE L3
