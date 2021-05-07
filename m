Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF43764BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhEGL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:56:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhEGL41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:56:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620388527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVo4dmnTS1B3YIat+/C81/Fhwd2ollcjvflB6s+6QMM=;
        b=s7+ZERkyEG2++IavH8Rzs4k3w933FNTyYNdb8CFD/nI3YXBbqrAyrCCsjKHgbK1lNbWE9r
        xYHdOfjETLkMTyWmPsTrvf41JNPbzOfWO1uA2GUq7dL9LLMPcxY1jp14+IuRwVnVg4Q7Qa
        IVwzVTvDsktZvsRj+t9jh+HvpYT86Rg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D06EB159;
        Fri,  7 May 2021 11:55:27 +0000 (UTC)
Date:   Fri, 7 May 2021 13:55:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/7] Memory hotplug/hotremove at subsection size
Message-ID: <YJUqrOacyqI+kiKW@dhcp22.suse.cz>
References: <20210506152623.178731-1-zi.yan@sent.com>
 <fb60eabd-f8ef-2cb1-7338-7725efe3c286@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb60eabd-f8ef-2cb1-7338-7725efe3c286@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I haven't read through respective patches due to lack of time but let
 me comment on the general idea and the underlying justification]

On Thu 06-05-21 17:31:09, David Hildenbrand wrote:
> On 06.05.21 17:26, Zi Yan wrote:
> > From: Zi Yan <ziy@nvidia.com>
> > 
> > Hi all,
> > 
> > This patchset tries to remove the restriction on memory hotplug/hotremove
> > granularity, which is always greater or equal to memory section size[1].
> > With the patchset, kernel is able to online/offline memory at a size independent
> > of memory section size, as small as 2MB (the subsection size).
> 
> ... which doesn't make any sense as we can only online/offline whole memory
> block devices.

Agreed. The subsection thingy is just a hack to workaround pmem
alignement problems. For the real memory hotplug it is quite hard to
argue for reasonable hotplug scenarios for very small physical memory
ranges wrt. to the existing sparsemem memory model.
 
> > The motivation is to increase MAX_ORDER of the buddy allocator and pageblock
> > size without increasing memory hotplug/hotremove granularity at the same time,
> 
> Gah, no. Please no. No.

Agreed. Those are completely independent concepts. MAX_ORDER is can be
really arbitrary irrespective of the section size with vmemmap sparse
model. The existing restriction is due to old sparse model not being
able to do page pointer arithmetic across memory sections. Is there any
reason to stick with that memory model for an advance feature you are
working on?
-- 
Michal Hocko
SUSE Labs
