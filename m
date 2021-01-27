Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1BA3059FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhA0LiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:38:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:48080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234365AbhA0Lf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:35:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD444AC9B;
        Wed, 27 Jan 2021 11:34:43 +0000 (UTC)
Date:   Wed, 27 Jan 2021 12:34:41 +0100
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
Subject: Re: [PATCH] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <20210127113436.GA28551@linux>
References: <20210127112315.28297-1-osalvador@suse.de>
 <ff7c0838-bfb2-9904-8dcc-4f6f979734d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff7c0838-bfb2-9904-8dcc-4f6f979734d3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:29:27PM +0100, David Hildenbrand wrote:
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index b5a3fa4033d3..9b6d45ea353b 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -873,6 +873,71 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >   #define PAGE_INUSE 0xFD
> 
> Note that I called it "PAGE_UNUSED", using "PAGE_INUSE" might make it a
> little harder to digest.

Yeah, I wanted to recycle the PAGE_INUSE macro for x86, but on a second though
we might just call it PAGE_UNUSE as it gives a better perspective.

Let us see if there are other pushbacks/reviews, and if not, I shall re-submit
with that addressed.

Thanks

-- 
Oscar Salvador
SUSE L3
