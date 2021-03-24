Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E8934752C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbhCXJ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhCXJ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:56:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0995C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:56:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x7so1301731wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zd3a1Pha0wUYu2R6zdy8s+B646l7d3Lvae5TuckR0EY=;
        b=U0que7K2B4rkwiuPtiy5Z9egdK8jGRMux9SNxVBJwoKA/8fIqWHNOiXgZdOQBD4wBF
         R4HV7PdWRSTicWsPpeKx1pIetzbOCPRKf4L0MR10b5XVl7hcx7e1IarY+Kft4dwbqGoQ
         l5M1M5De9IAoENpbX1pZ/6jQVF0BtMU/0AeuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=zd3a1Pha0wUYu2R6zdy8s+B646l7d3Lvae5TuckR0EY=;
        b=DshlLe1pRoN8ziSX6p4Q6U4sMxc1vFa84dhhqeUdext9wa74m39NJEWyjP4ph0JMmp
         rAo4TMsAg4NdJkMq2o8yQMU2gyJWH+J7sp+f/pkaa+G2PvcuDWjg/KEw/Xp/B9rJPkiM
         vWyqxTP62EcTCtZTfHTEJxImMYLM0mQwBcLRh8fZBMhhxvHwiRaUjxpdmalvnB/VgB6W
         NYPbuCPiUhalqEcN0oiMb+EPgYM6apZq5kCYpX1SfUOgsFeyAqPbD4wYhDsxkYFK/4GZ
         JJB6dGskFrtDjNIW5MJRxA+30PKCulJX+1h6f24vifesCrE9EPMdfC9e8eYArFl9L05m
         /Opg==
X-Gm-Message-State: AOAM53173oyV600voVT0yx8uyeTM2nPRsiAIrCycVGo6wz0/QJkH7tpE
        cZtGmVrFpB58IfdFJbRkcf7sQw==
X-Google-Smtp-Source: ABdhPJw4rrg4IlYNXkGJgQdvOCEud4BerOq8bkSdWc8ME0hAviDkH4obUmQPJdQhxUmV4BS7vFMCpQ==
X-Received: by 2002:a05:6000:181b:: with SMTP id m27mr2571542wrh.363.1616579805501;
        Wed, 24 Mar 2021 02:56:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a131sm1771261wmc.48.2021.03.24.02.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 02:56:45 -0700 (PDT)
Date:   Wed, 24 Mar 2021 10:56:43 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <YFsM23t2niJwhpM/@phenom.ffwll.local>
Mail-Followup-To: Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>,
        Jason Gunthorpe <jgg@nvidia.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Koenig <christian.koenig@amd.com>
References: <20210321184529.59006-1-thomas_os@shipmail.org>
 <20210321184529.59006-2-thomas_os@shipmail.org>
 <YFnST5VLcEgv9q+s@phenom.ffwll.local>
 <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
 <20210323163715.GJ2356281@nvidia.com>
 <5824b731-ca6a-92fd-e314-d986b6a7b101@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5824b731-ca6a-92fd-e314-d986b6a7b101@shipmail.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 06:06:53PM +0100, Thomas Hellström (Intel) wrote:
> 
> On 3/23/21 5:37 PM, Jason Gunthorpe wrote:
> > On Tue, Mar 23, 2021 at 05:34:51PM +0100, Thomas Hellström (Intel) wrote:
> > 
> > > > > @@ -210,6 +211,20 @@ static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
> > > > >    	if ((pfn & (fault_page_size - 1)) != 0)
> > > > >    		goto out_fallback;
> > > > > +	/*
> > > > > +	 * Huge entries must be special, that is marking them as devmap
> > > > > +	 * with no backing device map range. If there is a backing
> > > > > +	 * range, Don't insert a huge entry.
> > > > > +	 * If this check turns out to be too much of a performance hit,
> > > > > +	 * we can instead have drivers indicate whether they may have
> > > > > +	 * backing device map ranges and if not, skip this lookup.
> > > > > +	 */
> > > > I think we can do this statically:
> > > > - if it's system memory we know there's no devmap for it, and we do the
> > > >     trick to block gup_fast
> > > Yes, that should work.
> > > > - if it's iomem, we know gup_fast wont work anyway if don't set PFN_DEV,
> > > >     so might as well not do that
> > > I think gup_fast will unfortunately mistake a huge iomem page for an
> > > ordinary page and try to access a non-existant struct page for it, unless we
> > > do the devmap trick.
> > > 
> > > And the lookup would then be for the rare case where a driver would have
> > > already registered a dev_pagemap for an iomem area which may also be mapped
> > > through TTM (like the patch from Felix a couple of weeks ago). If a driver
> > > can promise not to do that, then we can safely remove the lookup.
> > Isn't the devmap PTE flag arch optional? Does this fall back to not
> > using huge pages on arches that don't support it?
> 
> Good point. No, currently it's only conditioned on transhuge page support.
> Need to condition it on also devmap support.
> 
> > 
> > Also, I feel like this code to install "pte_special" huge pages does
> > not belong in the drm subsystem..
> 
> I could add helpers in huge_memory.c:
> 
> vmf_insert_pfn_pmd_prot_special() and
> vmf_insert_pfn_pud_prot_special()

The somewhat annoying thing is that we'd need an error code so we fall
back to pte fault handling. That's at least my understanding of how
pud/pmd fault handling works. Not sure how awkward that is going to be
with the overall fault handling flow.

But aside from that I think this makes tons of sense.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
