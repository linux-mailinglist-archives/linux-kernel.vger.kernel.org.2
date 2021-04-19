Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686333648B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbhDSRGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:06:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6153C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 10:05:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f078100273c47da03104508.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8100:273c:47da:310:4508])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43CB91EC0347;
        Mon, 19 Apr 2021 19:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618851940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TWJ6b+wJROTKL7GE+elLAj17ElKzrLVUoC3BxvWRtfw=;
        b=lN1UlO/CFvknjp15asW0ZjeOuNvhRMptkMK/gweUTMxxNvforBchg1vlWjrYeAe+bXpwVd
        nxIkuqLwqc/72mjiNg3LtpAWPRPPPD9z+XPythoADeeA+N7pNLTu3Lj+UTDMC5fLRpWcBF
        QqTSQyHQwRdB4f9UswHxATVUCyPTCw0=
Date:   Mon, 19 Apr 2021 19:05:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Message-ID: <20210419170538.GG9093@zn.tnic>
References: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
 <20210412224320.1747638-2-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210412224320.1747638-2-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 07:43:18AM +0900, Naoya Horiguchi wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> There can be races when multiple CPUs consume poison from the same
> page. The first into memory_failure() atomically sets the HWPoison
> page flag and begins hunting for tasks that map this page. Eventually
> it invalidates those mappings and may send a SIGBUS to the affected
> tasks.
> 
> But while all that work is going on, other CPUs see a "success"
> return code from memory_failure() and so they believe the error
> has been handled and continue executing.
> 
> Fix by wrapping most of the internal parts of memory_failure() in
> a mutex.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git v5.12-rc5/mm/memory-failure.c v5.12-rc5_patched/mm/memory-failure.c
> index 24210c9bd843..c1509f4b565e 100644
> --- v5.12-rc5/mm/memory-failure.c
> +++ v5.12-rc5_patched/mm/memory-failure.c
> @@ -1381,6 +1381,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  	return rc;
>  }
>  
> +static DEFINE_MUTEX(mf_mutex);
> +
>  /**
>   * memory_failure - Handle memory failure of a page.
>   * @pfn: Page Number of the corrupted page
> @@ -1424,12 +1426,18 @@ int memory_failure(unsigned long pfn, int flags)
>  		return -ENXIO;
>  	}

So the locking patterns are done in two different ways, which are
confusing when following this code:

> +	mutex_lock(&mf_mutex);
> +
>  try_again:
> -	if (PageHuge(p))
> -		return memory_failure_hugetlb(pfn, flags);
> +	if (PageHuge(p)) {
> +		res = memory_failure_hugetlb(pfn, flags);
> +		goto out2;
> +	}

You have the goto to a label where you do the unlocking (btw, pls do
s/out2/out_unlock/g;)...

> +
>  	if (TestSetPageHWPoison(p)) {
>  		pr_err("Memory failure: %#lx: already hardware poisoned\n",
>  			pfn);
> +		mutex_unlock(&mf_mutex);
>  		return 0;

... and you have the other case where you unlock before returning.

Since you've added the label, I think *all* the unlocking should do
"goto out_unlock" instead of doing either/or.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
