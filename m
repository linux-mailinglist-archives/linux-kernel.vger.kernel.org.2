Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4E93D0951
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhGUGVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 02:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhGUGSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 02:18:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40932C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 23:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Tg6rDmREVX1ceiTKGgiYnKUFpoX6FiU/JNm2fWqBkw=; b=t3hopBQTUruM/ENRFxNyEOoUC+
        5oJEQnciSH7H7I8MBiuNHyNhq7XNi/0H9lWN4pG4JSoChs5UkzgXC23DuhuRBWouYCC04xOkyZ1xV
        rR+ywDmkEKE0nnaaZ5dg8qfF0i8IuE7hW6GwCxdzrrEd18zJIIHurdno+HOqRNXejciU760Nh3WQx
        3AOh2nuu5mW+eF0HaQSNswWOgds534d05ahBQ3vI0rR4UkVwl5iObPL+K+tNrdsch3TtjxYoxhGnS
        hW5Qq+sSJ88nW4YhTG3gLQZhM3cY/AdifCtrpRz3dSoygFIOUXVfb1SJ8YEApxUrgC5VPetggN9c3
        7B06dTQQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m66BG-008tyJ-Id; Wed, 21 Jul 2021 06:58:13 +0000
Date:   Wed, 21 Jul 2021 07:58:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Anson Jacob <Anson.Jacob@amd.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
        qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
        Christoph Hellwig <hch@infradead.org>,
        Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
        Christian K??nig <christian.koenig@amd.com>, bindu.r@amd.com
Subject: Re: [RFC v2 1/2] ppc/fpu: Add generic FPU api similar to x86
Message-ID: <YPfFgkD+kcRaH8Ow@infradead.org>
References: <20210721044801.840501-1-Anson.Jacob@amd.com>
 <20210721044801.840501-2-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721044801.840501-2-Anson.Jacob@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +/*
> + * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
> + * disables preemption so be careful if you intend to use it for long periods
> + * of time.
> + * TODO: If you intend to use the FPU in irq/softirq you need to check first with
> + * irq_fpu_usable() if it is possible.

Please avoid the overly lone lines comments.

> +extern bool kernel_fpu_enabled(void);
> +extern void kernel_fpu_begin(void);
> +extern void kernel_fpu_end(void);

No need for the externs.

> +/*
> + * Track whether the kernel is using the FPU state
> + * currently.

This all fits on a single line.

> +static bool fpu_support(void)
> +{
> +	if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
> +		return true;
> +	} else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) {
> +		return true;
> +	} else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) {
> +		return true;
> +	}

No need for the braces, or else after a return.  In fact this could
be simplified down to:

	return cpu_has_feature(CPU_FTR_VSX_COMP) ||
		cpu_has_feature(CPU_FTR_ALTIVEC_COMP) ||
		cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE));

> +	preempt_disable();
> +
> +#ifdef CONFIG_VSX
> +	if (cpu_has_feature(CPU_FTR_VSX_COMP)) {
> +		enable_kernel_vsx();
> +		return;
> +	}
> +#endif
> +
> +#ifdef CONFIG_ALTIVEC
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP)) {
> +		enable_kernel_altivec();
> +		return;
> +	}
> +#endif
> +
> +#ifdef CONFIG_PPC_FPU
> +	if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE)) {
> +		enable_kernel_fp();
> +		return;
> +	}
> +#endif

All the features are defined away if not supported (and we already rely
on that in fpu_support()).  So this could become:

	if (cpu_has_feature(CPU_FTR_VSX_COMP))
		enable_kernel_vsx();
	else if (cpu_has_feature(CPU_FTR_ALTIVEC_COMP))
		enable_kernel_altivec();
	else if (!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
		enable_kernel_fp();

Same for the disable path.
