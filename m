Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A020361F07
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbhDPLpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241891AbhDPLpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:45:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D13161057;
        Fri, 16 Apr 2021 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618573476;
        bh=g1GQ3fMRsXXUxb3TziyhacMOOpriyOWdQMsWa6+jGug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJi5NHc+XLro4v3JuXfxVimD3qTxlRIlEQW0jKcbC1fkOeMbhX+QD36Vpgv/m5ZWS
         w9k0pCOsSSy5e1rtpgZ6meO2kxgPq/nHRJ8xHTAE/3ueN6qs6pqlukQ1HUBO0cBT9Z
         1AQShBFk27Hug5dFGtBphwLSnqUSmscREcGT3KDTwjeLt7aURG5nZp5OsnGRS8Tf1v
         cyIiJ5wZAAlMJuC7YOXtzgBlbuPlBe1viVwrvSNQ2ApaD5WM28tOf9xQWfW9Tzj99G
         Xv0t+SbyVly+TfTJMs7hkGCjxMV0CtCIjWPw5NkGbs+NBYqqEsV1nMMDioVyRJhgy+
         nG5AVY/FWbnzA==
Date:   Fri, 16 Apr 2021 14:44:26 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
Message-ID: <YHl4mqgh5CtNk1l7@kernel.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
 <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
 <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
 <3811547a-9057-3c80-3805-2e658488ac99@redhat.com>
 <YHdPmtpzFxHE9mAt@kernel.org>
 <f5503130-c0e7-329f-86c4-727ece1c860f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5503130-c0e7-329f-86c4-727ece1c860f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 11:30:12AM +0200, David Hildenbrand wrote:
> > Not sure we really need a new pagetype here, PG_Reserved seems to be quite
> > enough to say "don't touch this".  I generally agree that we could make
> > PG_Reserved a PageType and then have several sub-types for reserved memory.
> > This definitely will add clarity but I'm not sure that this justifies
> > amount of churn and effort required to audit uses of PageResrved().
> > > Then, we could mostly avoid having to query memblock at runtime to figure
> > > out that this is special memory. This would obviously be an extension to
> > > this series. Just a thought.
> > 
> > Stop pushing memblock out of kernel! ;-)
> 
> Can't stop. Won't stop. :D
> 
> It's lovely for booting up a kernel until we have other data-structures in
> place ;)

A bit more seriously, we don't have any data structure that reliably
represents physical memory layout and arch-independent fashion. 
memblock is probably the best starting point for eventually having one.

-- 
Sincerely yours,
Mike.
