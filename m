Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AC035810F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhDHKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:47:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:59754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDHKrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:47:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7AA1DAF0C;
        Thu,  8 Apr 2021 10:47:13 +0000 (UTC)
Date:   Thu, 8 Apr 2021 12:47:10 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        weixugc@google.com, yang.shi@linux.alibaba.com,
        rientjes@google.com, ying.huang@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 05/10] mm/migrate: demote pages during reclaim
Message-ID: <YG7fLpeSw1dF4tiS@localhost.localdomain>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183225.2EDC224F@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401183225.2EDC224F@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:32:25AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This is mostly derived from a patch from Yang Shi:
> 
> 	https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/
> 
> Add code to the reclaim path (shrink_page_list()) to "demote" data
> to another NUMA node instead of discarding the data.  This always
> avoids the cost of I/O needed to read the page back in and sometimes
> avoids the writeout cost when the pagee is dirty.
> 
> A second pass through shrink_page_list() will be made if any demotions
> fail.  This essentally falls back to normal reclaim behavior in the
> case that demotions fail.  Previous versions of this patch may have
> simply failed to reclaim pages which were eligible for demotion but
> were unable to be demoted in practice.
> 
> Note: This just adds the start of infratructure for migration. It is
> actually disabled next to the FIXME in migrate_demote_page_ok().
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: osalvador <osalvador@suse.de>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
