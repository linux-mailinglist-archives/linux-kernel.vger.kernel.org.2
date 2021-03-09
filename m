Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8B3330E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhCIV2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:28:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:45500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhCIV1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:27:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F49BAFF9;
        Tue,  9 Mar 2021 21:27:53 +0000 (UTC)
Date:   Tue, 9 Mar 2021 22:27:50 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] x86/vmemmap: Drop handling of 1GB vmemmap ranges
Message-ID: <YEfoVqVglWUbepvW@localhost.localdomain>
References: <20210309174113.5597-1-osalvador@suse.de>
 <20210309174113.5597-3-osalvador@suse.de>
 <a701a162-d581-42e9-bae5-7c43741bbf7b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a701a162-d581-42e9-bae5-7c43741bbf7b@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:34:51AM -0800, Dave Hansen wrote:
> On 3/9/21 9:41 AM, Oscar Salvador wrote:
> > We never get to allocate 1GB pages when mapping the vmemmap range.
> > Drop the dead code both for the aligned and unaligned cases and leave
> > only the direct map handling.
> 
> I was hoping to seem some more meat in this changelog, possibly some of
> what David Hildenbrand said in the v4 thread about this patch.
> Basically, we don't have code to allocate 1G mappings because it isn't
> clear that it would be worth the complexity, and it might also waste memory.
> 
> I'm fine with the code, but I would appreciate a beefed-up changelog:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Since I had to do another pass to fix up some compilaton errors,
I added a bit more of explanation in that regard.

Thanks!


-- 
Oscar Salvador
SUSE L3
