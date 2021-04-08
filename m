Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1913C357E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhDHIxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:53:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:53884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhDHIxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:53:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B807AF0C;
        Thu,  8 Apr 2021 08:53:41 +0000 (UTC)
Date:   Thu, 8 Apr 2021 10:03:15 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shy828301@gmail.com, weixugc@google.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
Subject: Re: [PATCH 01/10] mm/numa: node demotion data structure and lookup
Message-ID: <YG64w7NC59fn8Py+@localhost.localdomain>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183218.E7C9CE24@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401183218.E7C9CE24@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:32:18AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Prepare for the kernel to auto-migrate pages to other memory nodes
> with a user defined node migration table. This allows creating single
> migration target for each NUMA node to enable the kernel to do NUMA
> page migrations instead of simply reclaiming colder pages. A node
> with no target is a "terminal node", so reclaim acts normally there.
> The migration target does not fundamentally _need_ to be a single node,
> but this implementation starts there to limit complexity.
> 
> If you consider the migration path as a graph, cycles (loops) in the
> graph are disallowed.  This avoids wasting resources by constantly
> migrating (A->B, B->A, A->B ...).  The expectation is that cycles will
> never be allowed.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>

I think this patch and patch#2 could be squashed

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
