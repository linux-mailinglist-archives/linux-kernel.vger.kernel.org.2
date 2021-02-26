Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC3326278
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhBZMPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:15:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:34730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhBZMPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:15:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54D3BAFE5;
        Fri, 26 Feb 2021 12:14:42 +0000 (UTC)
Date:   Fri, 26 Feb 2021 13:14:40 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 3/7] mm,memory_hotplug: Add kernel boot option to
 enable memmap_on_memory
Message-ID: <20210226121440.GE3661@localhost.localdomain>
References: <20210209133854.17399-1-osalvador@suse.de>
 <20210209133854.17399-4-osalvador@suse.de>
 <02041ab3-dcbd-9056-5571-48b84f527e42@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02041ab3-dcbd-9056-5571-48b84f527e42@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:25:58PM +0100, David Hildenbrand wrote:
> > +static __meminit int memmap_on_memory_store(const char *val,
> > +					    const struct kernel_param *kp)
> > +{
> > +	/*
> > +	 * Fail silently in case we cannot enable it due to platform constraints.
> > +	 * User can always check whether it is enabled or not via /sys/module.
> > +	 */
> > +	if (!IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE))
> > +		return 0;
> > +
> > +	return param_set_bool(val, kp);
> > +}
> > +module_param_call(memmap_on_memory, memmap_on_memory_store,
> > +		  memmap_on_memory_show, &memmap_on_memory_enabled, 0400);
> 
> Why are other users not allowed to read?

I copied it from the shuffle one. I guess shuffle code made it 0400 for
security reasons.
Since we do not need that here, I will switch it to 0444.

> Might want to add a MODULE_PARM_DESC().

Sure

> As we fail silently already, I'd keep it simple and use a
> 
> module_param(memmap_on_memory, bool, 0444);
> 
> moving the IS_ENABLED(CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE) into the
> runtime check.

You mean moving this check into mhp_supports_memmap_on_memory() check
from patch#1 right?

Makes sense.


-- 
Oscar Salvador
SUSE L3
