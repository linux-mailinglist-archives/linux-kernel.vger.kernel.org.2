Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DC632F764
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 01:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhCFA5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 19:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhCFA5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 19:57:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFED665071;
        Sat,  6 Mar 2021 00:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614992236;
        bh=0IqKdxvmrz+QUHpTk1VBUkhYWVz5TV+kPB13ug6tHzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RpS7DcKenRZjpX3KelAyqN+9lpeExflxhAs2jrdaB1ZrlvdQmxkw2eyh3QlfH1gAO
         cP6nd6JtPTalDmzHcHQpcFdKQtIzrNeNtE8x1xvWB2VNf0jgpzvcdyyNW2rCk7NCYy
         vEqIk8sWyQ2rM2ygurXM0JDHd3QXuyQSyjMxu2wg=
Date:   Fri, 5 Mar 2021 16:57:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Saravanan D <saravanand@fb.com>
Cc:     <mingo@redhat.com>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH V6] x86/mm: Tracking linear mapping split events
Message-Id: <20210305165715.94140a44b177d0e34d59e220@linux-foundation.org>
In-Reply-To: <20210218235744.1040634-1-saravanand@fb.com>
References: <20210218235744.1040634-1-saravanand@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021 15:57:44 -0800 Saravanan D <saravanand@fb.com> wrote:

> To help with debugging the sluggishness caused by TLB miss/reload,
> we introduce monotonic hugepage [direct mapped] split event counts since
> system state: SYSTEM_RUNNING to be displayed as part of
> /proc/vmstat in x86 servers
>
> ...
>
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -120,6 +120,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_SWAP
>  		SWAP_RA,
>  		SWAP_RA_HIT,
> +#endif
> +#ifdef CONFIG_X86
> +		DIRECT_MAP_LEVEL2_SPLIT,
> +		DIRECT_MAP_LEVEL3_SPLIT,
>  #endif
>  		NR_VM_EVENT_ITEMS
>  };

This is the first appearance of arch-specific fields in /proc/vmstat.

I don't really see a problem with this - vmstat is basically a dumping
ground of random developer stuff.  But was this the best place in which
to present this data?
