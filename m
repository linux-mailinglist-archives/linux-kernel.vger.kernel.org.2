Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C624334A42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhCJV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:58:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:57124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232417AbhCJV6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:58:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5306EAD87;
        Wed, 10 Mar 2021 21:58:20 +0000 (UTC)
Date:   Wed, 10 Mar 2021 22:58:17 +0100
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
Subject: Re: [PATCH v5 3/4] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <YElA+cMxS4NZHFAV@localhost.localdomain>
References: <20210309174113.5597-1-osalvador@suse.de>
 <20210309174113.5597-4-osalvador@suse.de>
 <3471fe0e-d8f4-c8fe-2096-8d9c8b1ab5bc@redhat.com>
 <20210310174953.GA16289@linux>
 <1814c21c-b822-0ec6-c16d-92424d00663a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1814c21c-b822-0ec6-c16d-92424d00663a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 06:58:26PM +0100, David Hildenbrand wrote:
> Thinking again, I guess it might be a good idea to factor out the core
> functions into common code. For the optimization part, it might make sense
> too pass some "state" structure that contains e.g., "unused_pmd_start".

Yeah, that really sounds like a good thing to do.

> 
> Then we don't have diverging implementations of essentially the same thing.
> 
> Of course, we can do that on top of this series - unifying both
> implementations.

I would rather do it on top of this series, not because I am lazy, but
rather fairly busy and I will not be able to spend much time on it
anytime soon.

Once this series gets merged, I commit to have a look into that.

Thanks!


-- 
Oscar Salvador
SUSE L3
