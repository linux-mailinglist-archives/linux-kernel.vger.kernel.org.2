Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE20B365C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhDTPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232910AbhDTPZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:25:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 982F161264;
        Tue, 20 Apr 2021 15:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618932310;
        bh=MAjswkG1d6uIfyIvGoPH2JcXnT5VvPujn7l2uT7Uvj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWMQKAMU43ygxwHm/tIVp+WpJQapUl0Kd60x6HPlbDjcKHnf74tigDwWzGVjUZtAA
         tSdT+jZGx+d3ZPsKLu+jqBEA39bKT+7+0vr0dhyxEZGCpGlPxkgZ97678lO8WgGG4d
         QgW3tLOkl5mV+MxGBxxN5j8RAFrxIUGHaYegouiIHqIGoy34Dvfl8diR65SAtnm2sr
         Lmm/xaDLwYIOcOCnrqMkGqhYpZmIddlqTjCcrJUYJP4M5Cr95OivNBA3jWrHSClyG2
         NlCodhM9dvGtr9D03VRf+IlIRcvRBQbVUFXaCEmYNLH08BeSOZ5UALddCrzzC0+Eer
         T0ouGAFTRdlJA==
Date:   Tue, 20 Apr 2021 18:25:01 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/4] memblock: update initialization of reserved pages
Message-ID: <YH7yTahcTVy31Uxk@kernel.org>
References: <20210420090925.7457-1-rppt@kernel.org>
 <20210420090925.7457-3-rppt@kernel.org>
 <ed8f10a0-9b68-1d12-0305-90fd378af6b9@redhat.com>
 <YH7tL77Z9UzTAFca@kernel.org>
 <45a7e13d-3e44-3b94-a253-2df72649a83d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a7e13d-3e44-3b94-a253-2df72649a83d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 05:18:55PM +0200, David Hildenbrand wrote:
> On 20.04.21 17:03, Mike Rapoport wrote:
> > On Tue, Apr 20, 2021 at 03:56:28PM +0200, David Hildenbrand wrote:
> > > On 20.04.21 11:09, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > The struct pages representing a reserved memory region are initialized
> > > > using reserve_bootmem_range() function. This function is called for each
> > > > reserved region just before the memory is freed from memblock to the buddy
> > > > page allocator.
> > > > 
> > > > The struct pages for MEMBLOCK_NOMAP regions are kept with the default
> > > > values set by the memory map initialization which makes it necessary to
> > > > have a special treatment for such pages in pfn_valid() and
> > > > pfn_valid_within().
> > > 
> > > Just a general question while thinking about it:
> > > 
> > > Would we right now initialize the memmap of these pages already via
> > > memmap_init_zone()->memmap_init_range()? (IOW, not marking the
> > > PageReserved?)
> > 
> > Yep. These pages are part of memblock.memory so they are initialized in
> > memmap_init_zone()->memmap_init_range() to the default values.
> > 
> 
> So instead of fully initializing them again, we mostly would only have to
> set PageReserved(). Not sure how big that memory usually is -- IOW, if we
> really care about optimizing the double-init.

IIUC, these are small areas reserved by the firmware, like e.g. ACPI
tables.

@Ard, am I right?

-- 
Sincerely yours,
Mike.
