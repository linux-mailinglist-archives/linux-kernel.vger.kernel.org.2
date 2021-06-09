Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66C63A0A37
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 04:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhFICtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 22:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231668AbhFICtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623206846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M6AD2nLmb56QVhFCgYdZqvhrlY7oWTcZgGvZozkCcw0=;
        b=JrZbxaRs3FfRuNVNfiSiRpuE08zFVo6iGIxxYekCCvQsvsMf2k1xjnSNDawy/DNKBa7Y9Q
        2B4Ku2RoPoDKniE9B/QfjJmKZ1znqJow8be8OnltmjRDhea6o5XeV6yHyAGFK0sX0Xa/Uz
        c1gHj1rihM6VHZFzrJawAaINELUoMvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-ycxNtIymMJ2lkUBWT-83bg-1; Tue, 08 Jun 2021 22:47:23 -0400
X-MC-Unique: ycxNtIymMJ2lkUBWT-83bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DFB2107ACE4;
        Wed,  9 Jun 2021 02:47:20 +0000 (UTC)
Received: from localhost (ovpn-13-223.pek2.redhat.com [10.72.13.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14C5160CC9;
        Wed,  9 Jun 2021 02:47:12 +0000 (UTC)
Date:   Wed, 9 Jun 2021 10:47:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Young <dyoung@redhat.com>, Boris Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] crash_core, vmcoreinfo: Append 'SECTION_SIZE_BITS' to
 vmcoreinfo
Message-ID: <20210609024709.GA591017@MiWiFi-R3L-srv>
References: <20210608103359.84907-1-kernelfans@gmail.com>
 <20210608142432.GA587883@MiWiFi-R3L-srv>
 <20210608141410.0026a925ba3a609b0dd4e560@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608141410.0026a925ba3a609b0dd4e560@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/21 at 02:14pm, Andrew Morton wrote:
> On Tue, 8 Jun 2021 22:24:32 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > On 06/08/21 at 06:33am, Pingfan Liu wrote:
> > > As mentioned in kernel commit 1d50e5d0c505 ("crash_core, vmcoreinfo:
> > > Append 'MAX_PHYSMEM_BITS' to vmcoreinfo"), SECTION_SIZE_BITS in the
> > > formula:
> > >     #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> > > 
> > > Besides SECTIONS_SHIFT, SECTION_SIZE_BITS is also used to calculate
> > > PAGES_PER_SECTION in makedumpfile just like kernel.
> > > 
> > > Unfortunately, this arch-dependent macro SECTION_SIZE_BITS changes, e.g.
> > > recently in kernel commit f0b13ee23241 ("arm64/sparsemem: reduce
> > > SECTION_SIZE_BITS"). But user space wants a stable interface to get this
> > > info. Such info is impossible to be deduced from a crashdump vmcore.
> > > Hence append SECTION_SIZE_BITS to vmcoreinfo.
> > 
> > ...
> >
> > Add the discussion of the original thread in kexec ML for reference:
> > http://lists.infradead.org/pipermail/kexec/2021-June/022676.html
> 
> I added a Link: for this.

Thanks, Andrew.

>  
> > This looks good to me.
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> 
> I'm thinking we should backport this at least to Fixes:f0b13ee23241. 
> But perhaps it's simpler to just backport it as far as possible, so I
> added a bare cc:stable with no Fixes:.  Thoughts?

Yeah, it should add cc:stable, thanks. Otherwise it will break
vmcore dumping on 5.12 stable kernel even though with the updated
makedumpfile utility. Fixes:f0b13ee23241 will help stable kernel
maintainer easier to identify which kernel this patch need be applied
on? If only having cc:stable with no Fixes is allowed, it's also OK. 

