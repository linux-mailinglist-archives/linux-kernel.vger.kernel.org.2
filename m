Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B26A41D949
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350609AbhI3MBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbhI3MB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:01:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC38EC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:59:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b15so24061850lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2urBgTbrDy1NbbFIzmr42ZFWl2s0KjeYzYyD5qhFrc4=;
        b=SeSsmgknghflT8KgWVilE0n1nVMjlidLm1JbPThgKYs00o83ve/58usCMiT1UJQiup
         TsViclsHEIjqkC02jlO4Fo9xh+Fon2nEPRsMqXTMUqDnbSOkeAzOWaIc2wuBnh4m4ZfW
         KTP0wXqe3cmarbNmH49O18Ib5hhePs2ARiuRzFWZvsP9ROZ0Y7JJIBlLWmG7OeWL0lzi
         atncENt5GodChMDXdPDp72rG2m4iaBygNIhXmMUFovdkQilKaLJSgy03GdNRKEV81j+C
         ZImf3vJa+omBvJeJRXFt0TRoQATw4nSvpUwPpupS6LofrSN9Jn9xO6hBhstGTXx0uqv/
         ev0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2urBgTbrDy1NbbFIzmr42ZFWl2s0KjeYzYyD5qhFrc4=;
        b=3jTY2kfGfZ8+S3Ocxu3++cYrKXozRfctDhsoZX8w7tw7P70jFEpZzgyUEO/8MHaP8G
         vWWLx2wEKb37bMtWp33sgV5HJpQR6yfE1MR60lMENMJSlnH3O6Lb5BSRgXZ8aumVf9a4
         Jdsb8wIl0OIDe6Qmh3zGSAsvaltoQuHE1wLQTR2Y/ni6YtyPXB7h5cT8kLYmq2UnLn3a
         uB85pkfCtiOImjYPSCm6P/UQ0a8qxycPqWOdQhdBIgibiwm5onBe4+tGX3mhdXczkqTR
         EJRrMYOi52R8zEAQsM7pgyR1sR7/PbdDJ2X9rrFJ23xfa7RnPVF5YppRDjDTfSVh7V9F
         j+uQ==
X-Gm-Message-State: AOAM533nOrYRADx0QXMa0E8NKeoXQKjImCcTbIwyZHCGRaAJfcUhcu3o
        9rLmCdJze7GcHx4Bwxj8sVvCUbPQbyl8LtPyyQNFmg==
X-Google-Smtp-Source: ABdhPJyOP0kOtwctz7szw16nkMPbZtUhsv6sIPeLPUqE+gW3MWhUQlbAU8CxYiYfN/IQGftPTZtDeD5NUdWLxalmNIY=
X-Received: by 2002:a2e:160f:: with SMTP id w15mr5467653ljd.355.1633003185058;
 Thu, 30 Sep 2021 04:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-9-pasha.tatashin@soleen.com> <20210929123513.GC21631@willie-the-truck>
 <CA+CK2bDw3A7FkZoQbB-AQWHj89Azqjrm12WFQVcfQjS+2Tmgyg@mail.gmail.com> <20210930081607.GA23250@willie-the-truck>
In-Reply-To: <20210930081607.GA23250@willie-the-truck>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 30 Sep 2021 07:59:07 -0400
Message-ID: <CA+CK2bBEh9dMHSVfVLNSZgjb8TKHXfCgf34g5+XsbeuhSLajFw@mail.gmail.com>
Subject: Re: [PATCH v17 08/15] arm64: kexec: configure EL2 vectors for kexec
To:     Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 4:16 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 29, 2021 at 11:54:55PM -0400, Pasha Tatashin wrote:
> > > > +/* Allocates pages for kexec page table */
> > > > +static void *kexec_page_alloc(void *arg)
> > > > +{
> > > > +     struct kimage *kimage = (struct kimage *)arg;
> > > > +     struct page *page = kimage_alloc_control_pages(kimage, 0);
> > > > +
> > > > +     if (!page)
> > > > +             return NULL;
> > > > +
> > > > +     memset(page_address(page), 0, PAGE_SIZE);
> > >
> > > Hmm, I think we might be missing barriers here to ensure that the zeroes
> > > are visible to the page-table walker before we plumb the page into the
> > > page-table.
> > >
> > > Usually, that's taken care of by the smp_wmb() in __pXX_alloc() but I
> > > can't see that here. Is it hiding?
> >
> > Based on the comment in __pte_alloc() that smp_wmb() is needed in
> > order to synchronize pte setup with other cpus prior to making it
> > visible to them. This is not needed here. First, by the time these
> > page tables are used the other cpus are offlined (kexec reboot code is
> > single threaded). Second, we never insert any entry into a page table
> > that is actively used by any cpu.
>
> I think the comment there is wrong, but the barrier is still necessary.
> How else do you guarantee that the page-table walker reads the zeroes from
> the memset?

True, good point. We are still safe because we have the following:
cpu_install_ttbr0() is used to load trans_pgd tables both in kexec and
hibernate cases.

cpu_install_ttbr0 has: local_flush_tlb_all()

dsb(nshst);   // Ensure prior page-table updates have completed
__tlbi(vmalle1);  // Invalidate the TLB
dsb(nsh);   // Ensure the TLB invalidation has completed
isb();  // Discard any instructions fetched from the old mapping

Pasha
