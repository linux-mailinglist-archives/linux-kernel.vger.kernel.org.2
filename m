Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A85352ED2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhDBR60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:58:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:38776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBR6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:58:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DFF0ACBF;
        Fri,  2 Apr 2021 17:58:13 +0000 (UTC)
Date:   Fri, 2 Apr 2021 19:58:10 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <YGdbMvv/nUSn7VDb@localhost.localdomain>
References: <20210309214050.4674-1-osalvador@suse.de>
 <20210309214050.4674-4-osalvador@suse.de>
 <0c4132aa-5d59-c0ba-5cfc-4ac401feba04@intel.com>
 <YEqQMm6+oQiQmwB0@localhost.localdomain>
 <20210330022950.GL351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330022950.GL351017@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 03:29:50AM +0100, Matthew Wilcox wrote:
> I can reproduce this with next-20210329.
> 
> .config attached.

Hi Matthew,

Thanks for the report. I tried to reproduce this with the attached
config on next-20210401 and I had no luck.


You still see it on that one?

Thanks

-- 
Oscar Salvador
SUSE L3
