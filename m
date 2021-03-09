Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF793330E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhCIV1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:27:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:43748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231594AbhCIV07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:26:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3E501AFF9;
        Tue,  9 Mar 2021 21:26:58 +0000 (UTC)
Date:   Tue, 9 Mar 2021 22:26:55 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Zi Yan <ziy@nvidia.com>
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
Subject: Re: [PATCH v4 3/3] x86/vmemmap: Handle unpopulated sub-pmd ranges
Message-ID: <YEfoH8US4YVxak7r@localhost.localdomain>
References: <20210301083230.30924-1-osalvador@suse.de>
 <20210301083230.30924-4-osalvador@suse.de>
 <380379B8-5331-447F-84E7-FB55EABA1C51@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <380379B8-5331-447F-84E7-FB55EABA1C51@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 02:39:02PM -0500, Zi Yan wrote:
> Hi Oscar,
> 
> vmemmap_use_new_sub_pmd and vmemmap_use_sub_pmd are not defined when CONFIG_SPARSEMEM_VMEMMAP
> and !CONFIG_MEMORY_HOTPLUG. It leads to compilation errors.

Meh, yeah, that's right.

I fixed that up, I will send a v6.

Thanks for noticing!



-- 
Oscar Salvador
SUSE L3
