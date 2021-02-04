Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9333030FAA6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbhBDSFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbhBDSB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:01:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7997EC06178C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:01:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c12so4591434wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sgNBgGYoMlIjzXJS7k+uTJr90AGrN8C+0QKMchqVgEw=;
        b=Sge4JAbgrFLOizl11w9D9oQSAmAxwysJJW+ccrQVWH3ezom8wIwM6z9XWUlzOfNRhC
         Jiz/Z0fwGZlSo+kWjB2iV8VlRI25x/wqVzkaVWFrDTrJLatKYfuN8jzaHg7RCdkDaqE5
         VKKxtZNvMbU6xv1PrGxNgfs24F1XOAtvlS9QjdUgxxt0D6WrAVj8qoUhNoxMQ0JIEGRi
         jm32ZYSURfxm7Bbxf95Qa4KEt5B3gzPag9r32O6cMQusXyCbiODFioaUjENYLWWWP+Tb
         YbDAdDPDq8CFjHTGCe1PVUYpFrmKe/cvt2yMg6pVlCCnPTMOFH/igkbptVPNcYEO4OqS
         OrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sgNBgGYoMlIjzXJS7k+uTJr90AGrN8C+0QKMchqVgEw=;
        b=R8FMGFCSs1doo8jafWYCQjoWtzvjXJM8QQtFjHg0G/3ibZuaSd1v7DKl/9Hy5MLMpP
         mawkDXwBQgWhztU6OKDjZHO+salQMFfveBYVFFots4VI0EVVKE4PVVwqXAiuOUub9Oy6
         LKateqBxF/EXoaY8ZnrElcJyTqsGdKask+wx602WDbFtOKGzmwSETsm/YFko9lmztcu6
         hoMf4ofQbPZKX5My8lOarYV1ZR4UXjRM6s8Vz/9NZcTAw2O4JaADY3yuiMjJFq9Zs1My
         HzMX8rzj2szEKPbXya3alnHJji9FV9uhKFhWSjIJC3UoDYE0jRh0J+6Bi4Lsrq6z0EKC
         nLqQ==
X-Gm-Message-State: AOAM5303Kov/+P4HnqAd57eIgruKOJ/ntVMp9+tbovfv2uEsfwA8mdRA
        HnSU5shTRwa7CypWzpx2Hwb3Xw==
X-Google-Smtp-Source: ABdhPJxzVwJVmeoEOZDZT5PwvHVmhUwJ0gSawClAAnwU0xD6ZtCQJxYDI7bHVG6gBHJ0ToO7Ntu4zQ==
X-Received: by 2002:adf:b749:: with SMTP id n9mr534156wre.267.1612461676095;
        Thu, 04 Feb 2021 10:01:16 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id t18sm8959891wrr.56.2021.02.04.10.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:01:15 -0800 (PST)
Date:   Thu, 4 Feb 2021 18:01:12 +0000
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
Message-ID: <YBw2aIr/Ktx1dsOT@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-13-qperret@google.com>
 <20210202181307.GA17311@willie-the-truck>
 <YBrsep4xK1F4YRWb@google.com>
 <20210204143106.GA20792@willie-the-truck>
 <YBwKRM3uHDMC9S0U@google.com>
 <20210204174849.GA21303@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204174849.GA21303@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Feb 2021 at 17:48:49 (+0000), Will Deacon wrote:
> On Thu, Feb 04, 2021 at 02:52:52PM +0000, Quentin Perret wrote:
> > On Thursday 04 Feb 2021 at 14:31:08 (+0000), Will Deacon wrote:
> > > On Wed, Feb 03, 2021 at 06:33:30PM +0000, Quentin Perret wrote:
> > > > On Tuesday 02 Feb 2021 at 18:13:08 (+0000), Will Deacon wrote:
> > > > > On Fri, Jan 08, 2021 at 12:15:10PM +0000, Quentin Perret wrote:
> > > > > > + *   __find_buddy(pool, page 0, order 0) => page 1
> > > > > > + *   __find_buddy(pool, page 0, order 1) => page 2
> > > > > > + *   __find_buddy(pool, page 1, order 0) => page 0
> > > > > > + *   __find_buddy(pool, page 2, order 0) => page 3
> > > > > > + */
> > > > > > +static struct hyp_page *__find_buddy(struct hyp_pool *pool, struct hyp_page *p,
> > > > > > +				     unsigned int order)
> > > > > > +{
> > > > > > +	phys_addr_t addr = hyp_page_to_phys(p);
> > > > > > +
> > > > > > +	addr ^= (PAGE_SIZE << order);
> > > > > > +	if (addr < pool->range_start || addr >= pool->range_end)
> > > > > > +		return NULL;
> > > > > 
> > > > > Are these range checks only needed because the pool isn't required to be
> > > > > an exact power-of-2 pages in size? If so, maybe it would be more
> > > > > straightforward to limit the max order on a per-pool basis depending upon
> > > > > its size?
> > > > 
> > > > More importantly, it is because pages outside of the pool are not
> > > > guaranteed to be covered by the hyp_vmemmap, so I really need to make
> > > > sure I don't dereference them.
> > > 
> > > Wouldn't having a per-pool max order help with that?
> > 
> > The issue is, I have no alignment guarantees for the pools, so I may end
> > up with max_order = 0 ...
> 
> Yeah, so you would still need the range tracking,

Hmm actually I don't think I would, but that would essentially mean the
'buddy' allocator is now turned into a free list of single pages
(because we cannot create pages of order 1).

> but it would at least help
> to reduce HYP_MAX_ORDER failed searches each time. Still, we can always do
> that later.

Sorry but I am not following. In which case do we have HYP_MAX_ORDER
failed searches?

Thanks,
Quentin
