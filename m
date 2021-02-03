Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F09430DC74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhBCOQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:16:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:59288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhBCOQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:16:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67821ACB0;
        Wed,  3 Feb 2021 14:16:01 +0000 (UTC)
Date:   Wed, 3 Feb 2021 15:15:58 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] x86/vmemmap: Drop handling of 1GB vmemmap ranges
Message-ID: <20210203141553.GA26770@linux>
References: <20210203104750.23405-1-osalvador@suse.de>
 <20210203104750.23405-3-osalvador@suse.de>
 <ec2f6a46-b2a8-8131-a2ac-48a02a1ea201@redhat.com>
 <20210203141038.GA26693@linux>
 <a503f51d-42fe-3cd1-aa7c-66af33f1b3f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a503f51d-42fe-3cd1-aa7c-66af33f1b3f8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:12:05PM +0100, David Hildenbrand wrote:
> On 03.02.21 15:10, Oscar Salvador wrote:
> > On Wed, Feb 03, 2021 at 02:33:56PM +0100, David Hildenbrand wrote:
> > > One problem I see with existing code / this change making more obvious is
> > > that when trying to remove in other granularity than we added (e.g., unplug
> > > a 128MB DIMM avaialble during boot), we remove the direct map of unrelated
> > > DIMMs.
> > 
> > So, let me see if I understand your concern.
> > 
> > We have a range that was mapped with 1GB page, and we try to remove
> > a 128MB chunk from it.
> > Yes, in that case we would clear the pud, and that is bad, so we should
> > keep the PAGE_ALIGNED checks.
> > 
> > Now, let us assume that scenario.
> > If you have a 1GB mapped range and you remove it in smaller chunks bit by bit
> > (e.g: 128M), the direct mapping of that range will never be cleared unless
> 
> No, that's exactly what's happening. Good thing is that it barely ever
> happens, so I assume leaving behind some direct mapping / page tables is not
> that bad.

Sorry, I meant that that is the current situation now.

Then let us keep the PAGE_ALIGNED stuff.

I shall resend a v3 later today.


thanks for the review ;-)

-- 
Oscar Salvador
SUSE L3
