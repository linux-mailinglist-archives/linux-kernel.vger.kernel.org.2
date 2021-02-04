Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48CF30F57F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhBDO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbhBDOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:53:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B129C061793
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:52:57 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m1so3240011wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GmzDwYCwB3ACF6L8pkrzfaM1KU2/zTHOCAwwjAAIW1c=;
        b=T4n7B/HDfO8GLn9RDv5a9Mnd7w6QzC1CmmDAy2dGrwaoMO/jJ9ye68xPKJXV0LUP0g
         HMI9KaeCJNVypsn0VcgiXF0nahQXoHOgDKN4FwRWRycbYlkqaH9q1rmG+kRJ8FGQJ1TS
         KQOwwrHclrlRKXj4BjzWTg9Tds6QLnXBGQlVYn2K5UHD2lSJLkgLXYfczlptpwyjMoni
         lRVSC4FnURwvgkpAlTUnIrGGVyJXCmGFRKRzLAt1vP7qj8FHDEynp0phez5v1FcB62jo
         bg9FLizdXkt4a8l65wUYQQXLTkD0GdTnUAlZekz6904IYqEVSUDgLLvEPRXk+a/P6Ta/
         bNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GmzDwYCwB3ACF6L8pkrzfaM1KU2/zTHOCAwwjAAIW1c=;
        b=Z/jSYFg0lKbNMipN4AAv+qw59EiCNSmmO5nM7CNLBOhdvRp5soPXncuBe8XJLi0axj
         3LjMey6MhWr4Yr5pHH2loSOVtaktRs9pJCfX9uo3kaWCjn87GCUgh8yrAehiQlZPUWjf
         59d5+ScGgl6cD1v7/ElKL7Ri1+AlS8zJX6pNJIE4v/VBGZSmwOD84erxbUDlaUElFKxP
         QscQVD8/dLBL6dPS8s+H3uji1WAa84Te+9r0DpmQWtIrLqP2ol93jsbpt1MR+vuylFuq
         B50FoEW5ektS5+q954SzgGrLaseZfizCF4CQUJ7cMYJOvJ15g+v0q9JvwaR/G5G1z7nB
         6Oug==
X-Gm-Message-State: AOAM533EytBG1EkP+a/Xil4vScZbmwIzlWLRyu557zUn4AV7orO3G2Be
        9jR1hjMLA7rkCjwqr9LLidrl+Q==
X-Google-Smtp-Source: ABdhPJytkpleb2goc1M1MLDTsD+ny4hCYPN6kmBxFpTwEmpJaqq+R5jrD51y1ejkMwjS5CKoxfmVRw==
X-Received: by 2002:a05:600c:ce:: with SMTP id u14mr7866356wmm.10.1612450375861;
        Thu, 04 Feb 2021 06:52:55 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id y63sm6195028wmd.21.2021.02.04.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:52:55 -0800 (PST)
Date:   Thu, 4 Feb 2021 14:52:52 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [RFC PATCH v2 12/26] KVM: arm64: Introduce a Hyp buddy page
 allocator
Message-ID: <YBwKRM3uHDMC9S0U@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-13-qperret@google.com>
 <20210202181307.GA17311@willie-the-truck>
 <YBrsep4xK1F4YRWb@google.com>
 <20210204143106.GA20792@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204143106.GA20792@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Feb 2021 at 14:31:08 (+0000), Will Deacon wrote:
> On Wed, Feb 03, 2021 at 06:33:30PM +0000, Quentin Perret wrote:
> > On Tuesday 02 Feb 2021 at 18:13:08 (+0000), Will Deacon wrote:
> > > On Fri, Jan 08, 2021 at 12:15:10PM +0000, Quentin Perret wrote:
> > > > + *   __find_buddy(pool, page 0, order 0) => page 1
> > > > + *   __find_buddy(pool, page 0, order 1) => page 2
> > > > + *   __find_buddy(pool, page 1, order 0) => page 0
> > > > + *   __find_buddy(pool, page 2, order 0) => page 3
> > > > + */
> > > > +static struct hyp_page *__find_buddy(struct hyp_pool *pool, struct hyp_page *p,
> > > > +				     unsigned int order)
> > > > +{
> > > > +	phys_addr_t addr = hyp_page_to_phys(p);
> > > > +
> > > > +	addr ^= (PAGE_SIZE << order);
> > > > +	if (addr < pool->range_start || addr >= pool->range_end)
> > > > +		return NULL;
> > > 
> > > Are these range checks only needed because the pool isn't required to be
> > > an exact power-of-2 pages in size? If so, maybe it would be more
> > > straightforward to limit the max order on a per-pool basis depending upon
> > > its size?
> > 
> > More importantly, it is because pages outside of the pool are not
> > guaranteed to be covered by the hyp_vmemmap, so I really need to make
> > sure I don't dereference them.
> 
> Wouldn't having a per-pool max order help with that?

The issue is, I have no alignment guarantees for the pools, so I may end
up with max_order = 0 ...
