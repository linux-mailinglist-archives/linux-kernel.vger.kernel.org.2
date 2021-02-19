Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABC931FED2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 19:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhBSSdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 13:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSSdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 13:33:47 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40136C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 10:33:07 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e9so3833557plh.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 10:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=apaYLCgpKww0D9oOCdL1/leTpd02z3P4w+UfyB0qUtE=;
        b=cNzmU6RwCi2M7zc1iN6kXALpuF4Dr3p9TUe2IZrVSxDRNZxj43w4OZN9GBVNUyVoGY
         H1RXDjVYIy/K8yNu7pM4zNUC+X8IPbISNDZkI7CMRH6NW31SInd7dD92i1llEAJIpNl9
         iWbI8rgOSf7uQmj0SebJ6NcX/Ooy0yvSHYo1XyOoSpU19UIDftAZr4ACUicBtUMeLzOs
         JxUyV+lfMm+gr31mLh9yWgpO+USuw7r8q/XR26xRmrLSWdm95R71UclAbHcjdoD9mUVg
         /RXbSkNXY3aLx0dVZoac6BkHs3HET/aQxjW2WzpvO3e5JjAUaXvXTBmMVyOyA+7Xdb05
         6Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=apaYLCgpKww0D9oOCdL1/leTpd02z3P4w+UfyB0qUtE=;
        b=V4LIKjsOnl9ghSn3bo6dRPi2LdkrxydFN40gongp49/0WGUhbn4IIsUFl2toYGqU4H
         O1KIojWyUi/XT+mVToQwHLj/d78Oicx7CmnBpwMqRoB4IJo5WXBACG2RoJxXhQ6h0uaI
         9CioF0U52FmP+NZF5XWUh1wUig0my9EpSktTL3mstpXoQtbrho4MRxRbluHuMi9bArM+
         fTgkAM7QwrBEgr4brZoJu+Iizr0J+tfXC1s764LZqQ1I9Um8FAVcHzysVW6jP6oFkIZF
         twsRmLiMxCKb1C0A8LLF9xcrh1wP48sNAa0Hy+IlVDny6jAwUlV6KBPS660o5Vfv0qXS
         wMaQ==
X-Gm-Message-State: AOAM533AyirA6tXotAkP0W0T/VSo4bD1arq8+tc2T2xmHpdsWVOH0t85
        MisVwjs9z7gLwQsi3tPl9L14eQ==
X-Google-Smtp-Source: ABdhPJzGsluCsG7fkC2FvoTQGUbPeiWB8QuireUSeDuRRKhKexRWjsorjPjofN2X3s0CAIhvLZ+5ZQ==
X-Received: by 2002:a17:902:9894:b029:e3:7aa3:a499 with SMTP id s20-20020a1709029894b02900e37aa3a499mr3088340plp.11.1613759586653;
        Fri, 19 Feb 2021 10:33:06 -0800 (PST)
Received: from google.com ([2620:15c:f:10:fc4d:e9c3:d7d:9cb3])
        by smtp.gmail.com with ESMTPSA id 3sm9467713pjk.26.2021.02.19.10.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:33:06 -0800 (PST)
Date:   Fri, 19 Feb 2021 10:32:58 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 16/26] KVM: arm64: Prepare Hyp memory protection
Message-ID: <YDAEWu7RkG1OBFed@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-17-qperret@google.com>
 <20210203143709.GA18907@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203143709.GA18907@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021, Will Deacon wrote:
> On Fri, Jan 08, 2021 at 12:15:14PM +0000, Quentin Perret wrote:

...

> > +static inline unsigned long hyp_s1_pgtable_size(void)
> > +{

...

> > +		res += nr_pages << PAGE_SHIFT;
> > +	}
> > +
> > +	/* Allow 1 GiB for private mappings */
> > +	nr_pages = (1 << 30) >> PAGE_SHIFT;
> 
> SZ_1G >> PAGE_SHIFT

Where does the 1gb magic number come from?  IIUC, this is calculating the number
of pages needed for the hypervisor's Stage-1 page tables.  The amount of memory
needed for those page tables should be easily calculated, and assuming huge
pages can be used, should be far less the 1gb.
 
> > +	nr_pages = __hyp_pgtable_max_pages(nr_pages);
> > +	res += nr_pages << PAGE_SHIFT;
> > +
> > +	return res;

...

> > +void __init kvm_hyp_reserve(void)
> > +{
> > +	u64 nr_pages, prev;
> > +
> > +	if (!is_hyp_mode_available() || is_kernel_in_hyp_mode())
> > +		return;
> > +
> > +	if (kvm_get_mode() != KVM_MODE_PROTECTED)
> > +		return;
> > +
> > +	if (kvm_nvhe_sym(hyp_memblock_nr) < 0) {
> > +		kvm_err("Failed to register hyp memblocks\n");
> > +		return;
> > +	}
> > +
> > +	sort_memblock_regions();
> > +
> > +	/*
> > +	 * We don't know the number of possible CPUs yet, so allocate for the
> > +	 * worst case.
> > +	 */
> > +	hyp_mem_size += NR_CPUS << PAGE_SHIFT;

Is this for per-cpu stack?

If so, what guarantees a single page is sufficient?  Mostly a curiosity question,
since it looks like this is an existing assumption by init_hyp_mode().  Shouldn't
the required stack size be defined in bytes and converted to pages, or is there a
guarantee that 64kb pages will be used?

> There was a recent patch bumping NR_CPUs to 512, so this would be 32MB
> with 64k pages. Is it possible to return memory to the host later on once
> we have a better handle on the number of CPUs in the system?

Does kvm_hyp_reserve() really need to be called during bootmem_init()?  What
prevents doing the reservation during init_hyp_mode()?  If the problem is that
pKVM needs a single contiguous chunk of memory, then it might be worth solving
_that_ problem, e.g. letting the host donate memory in N-byte chunks instead of
requiring a single huge blob of memory.
 
> > +	hyp_mem_size += hyp_s1_pgtable_size();
