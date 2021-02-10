Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5331749A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 00:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhBJXoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 18:44:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:22165 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhBJXoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 18:44:14 -0500
IronPort-SDR: Uu08YLl3OkzNKU4zjqFr8DHrb8355AgnhLNhVz2IymgMSfjZaDOva0+zoROnoPkcACgJMeGVM3
 Dp+XYkdfcmdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="201289781"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="201289781"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 15:42:29 -0800
IronPort-SDR: mRwkIkKabdn26fefoeK1Jpc+zLZoWHmjhGHkDA8+6vhxIzeKlbS0/sgxHuhb5nU1/OpNWDi0+R
 G4Zb3CvGhjmA==
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="510607085"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 15:42:28 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id C54016365;
        Wed, 10 Feb 2021 15:42:28 -0800 (PST)
Date:   Wed, 10 Feb 2021 15:42:28 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Balbir Singh <sblbir@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH V4 0/6] x86: Don't abuse tss.sp1
Message-ID: <20210210234228.GB75203@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210210133917.2414-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210133917.2414-1-jiangshanlai@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:39:11PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> In x86_64, tss.sp1 is reused as cpu_current_top_of_stack.  We'd better
> directly use percpu since CR3 and gs_base is correct when it is used.
Be more direct if not using percpu is incorrect in some way.
> 
> In x86_32, tss.sp1 is resued as thread.sp0 in three places in entry
s/resued/reused
> code.  We have the correct CR3 and %fs at two of the places.  The last
> one is sysenter.  This patchset makes %fs available earlier so that
> we can also use percpu in sysenter.  And add a percpu cpu_current_thread_sp0
> for thread.sp0 instead of tss.sp1
> 
> [V3]: https://lore.kernel.org/lkml/20210127163231.12709-1-jiangshanlai@gmail.com/
> [V2]: https://lore.kernel.org/lkml/20210125173444.22696-1-jiangshanlai@gmail.com/
> [V1]: https://lore.kernel.org/lkml/20210123084900.3118-1-jiangshanlai@gmail.com/
> 
> Changed from V3:
> 	Update subjects as Borislav's imperative request. ^_^
> 	Update changelog as Borislav suggested.
> 	Change EXPORT_PER_CPU_SYMBOL to EXPORT_PER_CPU_SYMBOL_GPL.
> 
> Changed from V2:
> 	Add missing "%ss:" reported by Brian Gerst.
> 
> Changed from V1:
> 	Requested from Andy to also fix sp1 for x86_32.
> 	Update comments in the x86_64 patch as Andy sugguested.
> 
> Lai Jiangshan (6):
>   x86/entry/64: Move cpu_current_top_of_stack out of TSS
>   x86/entry/32: Use percpu instead of offset-calculation to get
>     thread.sp0 in SWITCH_TO_KERNEL_STACK
>   x86/entry/32: Switch to the task stack without emptying the entry
>     stack
>   x86/entry/32: Restore %fs before switching stack
>   x86/entry/32: Use percpu to get thread.sp0 in SYSENTER
>   x86/entry/32: Introduce cpu_current_thread_sp0 to replace
>     cpu_tss_rw.x86_tss.sp1
> 
>  arch/x86/entry/entry_32.S          | 38 +++++++++++++++++-------------
>  arch/x86/include/asm/processor.h   | 12 ++--------
>  arch/x86/include/asm/switch_to.h   |  8 +------
>  arch/x86/include/asm/thread_info.h |  6 -----
>  arch/x86/kernel/asm-offsets.c      |  1 -
>  arch/x86/kernel/asm-offsets_32.c   | 10 --------
>  arch/x86/kernel/cpu/common.c       | 12 +++++++++-
>  arch/x86/kernel/process.c          |  7 ------
>  arch/x86/mm/pti.c                  |  7 +++---
>  9 files changed, 39 insertions(+), 62 deletions(-)
> 
> -- 
> 2.19.1.6.gb485710b
> 
