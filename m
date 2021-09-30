Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8D41DB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351514AbhI3NzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbhI3NzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:55:18 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1C3C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:53:35 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0B7B92A5; Thu, 30 Sep 2021 15:53:28 +0200 (CEST)
Date:   Thu, 30 Sep 2021 15:52:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] x86/mm/64: Flush global TLB on AP bringup
Message-ID: <YVXBNeF8HZwtquE1@8bytes.org>
References: <20210929145501.4612-1-joro@8bytes.org>
 <20210929145501.4612-3-joro@8bytes.org>
 <9d1d3000-d4eb-eb6d-1a34-4b58fb0322e3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d1d3000-d4eb-eb6d-1a34-4b58fb0322e3@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 08:09:38AM -0700, Dave Hansen wrote:
> On 9/29/21 7:54 AM, Joerg Roedel wrote:
>
> > +	__flush_tlb_all();
> >  }
> 
> Is there a reason to do this flush here as opposed to doing it closer to
> the CR3 write where we switch away from trampoline_pgd?  cr4_init()
> seems like an odd place.

Yeah, the reason is that global flushing is done by toggling CR4.PGE and
I didn't want to do that before CR4 is set up.

The CR3 switch away from the trampoline_pgd for secondary CPUs on x86-64
happens in head_64.S already. I will add some asm to do a global flush
there right after the CR3 switch. Secondary CPUs are already on kernel
virtual addresses at this point.


	Joerg
