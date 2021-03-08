Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA90E331693
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhCHSs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:48:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhCHSso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:48:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98111AC1F;
        Mon,  8 Mar 2021 18:48:43 +0000 (UTC)
Date:   Mon, 8 Mar 2021 19:48:40 +0100
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
Subject: Re: [PATCH v4 2/3] x86/vmemmap: Drop handling of 1GB vmemmap ranges
Message-ID: <20210308184840.GC25767@linux>
References: <20210301083230.30924-1-osalvador@suse.de>
 <20210301083230.30924-3-osalvador@suse.de>
 <62c5b490-353a-ca3a-d2c8-f02189210c32@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c5b490-353a-ca3a-d2c8-f02189210c32@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 10:42:59AM -0800, Dave Hansen wrote:
> On 3/1/21 12:32 AM, Oscar Salvador wrote:
> > We never get to allocate 1GB pages when mapping the vmemmap range.
> > Drop the dead code both for the aligned and unaligned cases and leave
> > only the direct map handling.
> 
> Could you elaborate a bit on why 1GB pages are never used?  It is just
> unlikely to have a 64GB contiguous area of memory that needs 1GB of
> contiguous vmemmap?  Or, does the fact that sections are smaller than
> 64GB keeps this from happening?

AFAIK, the biggest we populate vmemmap pages with is 2MB, plus the fact
that as you pointed out, memory sections on x86_64 are 128M, which is
way smaller than what would require to allocate a 1GB for vmemmap pages.

Am I missing something?


-- 
Oscar Salvador
SUSE L3
