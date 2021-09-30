Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5363E41D550
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349060AbhI3IR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348949AbhI3IR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:17:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53F5661528;
        Thu, 30 Sep 2021 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632989774;
        bh=IG9QanQU30BLOgTHId32QxYcNknUkvBQ+NHpixLYVRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/QiGQjMBdERAF+TEj/DaIlMsGCQTgzbvy1yvZpmUKkympQ2p3y9BFGXwHdhcT0tf
         i7M9CfaKuPQQ5RVAK+/tRVKSp+oR2mnUmmbNx/9KKdjcXdnaInSfMPDV2i+zpUYkHk
         2YSCDJ1tF0tzOArcbGJQHC1iZgYfrohiAwO+vZmj7wDpKb006LxLNKtLlAtGMGL91u
         lRfl8gglbql1M4KFSkiqcf3NYXU6gnPHnhTfkSwySAZM1bMXmbmWK9gGiZcVkvDxyd
         EJgh9cWq1xivkblynxfp20eC3NbHEWZpbX9sVRWfuolWWE0ksGR0zWDHE8NEq4Z04e
         MkFb6pq9C3ErQ==
Date:   Thu, 30 Sep 2021 09:16:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Subject: Re: [PATCH v17 08/15] arm64: kexec: configure EL2 vectors for kexec
Message-ID: <20210930081607.GA23250@willie-the-truck>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-9-pasha.tatashin@soleen.com>
 <20210929123513.GC21631@willie-the-truck>
 <CA+CK2bDw3A7FkZoQbB-AQWHj89Azqjrm12WFQVcfQjS+2Tmgyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDw3A7FkZoQbB-AQWHj89Azqjrm12WFQVcfQjS+2Tmgyg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:54:55PM -0400, Pasha Tatashin wrote:
> > > +/* Allocates pages for kexec page table */
> > > +static void *kexec_page_alloc(void *arg)
> > > +{
> > > +     struct kimage *kimage = (struct kimage *)arg;
> > > +     struct page *page = kimage_alloc_control_pages(kimage, 0);
> > > +
> > > +     if (!page)
> > > +             return NULL;
> > > +
> > > +     memset(page_address(page), 0, PAGE_SIZE);
> >
> > Hmm, I think we might be missing barriers here to ensure that the zeroes
> > are visible to the page-table walker before we plumb the page into the
> > page-table.
> >
> > Usually, that's taken care of by the smp_wmb() in __pXX_alloc() but I
> > can't see that here. Is it hiding?
> 
> Based on the comment in __pte_alloc() that smp_wmb() is needed in
> order to synchronize pte setup with other cpus prior to making it
> visible to them. This is not needed here. First, by the time these
> page tables are used the other cpus are offlined (kexec reboot code is
> single threaded). Second, we never insert any entry into a page table
> that is actively used by any cpu.

I think the comment there is wrong, but the barrier is still necessary.
How else do you guarantee that the page-table walker reads the zeroes from
the memset?

Will
