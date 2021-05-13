Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3589537F0DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 03:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhEMBSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 21:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234683AbhEMBSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 21:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620868617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8rIOlce/5RXrT16ramfLpoZjAAz9w2C7JWd/JQK5isA=;
        b=Sz87xDnH113sWSHdeLObUgq6frhPNvVcr/FYNy+VTQimg0j87ykJSENRXaTQIkhiwzoPHF
        VvLZsdw5G3uj0yn05owGhPPU22sJRk/XbJ8bo9mFw4dl24w0jd/2rbrj1V8xircJpLlei8
        RYDXJFLj1ZyNi6Lwqjiju0CN1zbn5CU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-mgF-RyesNwGIJLXXb7cNcw-1; Wed, 12 May 2021 21:16:53 -0400
X-MC-Unique: mgF-RyesNwGIJLXXb7cNcw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14FC9801B12;
        Thu, 13 May 2021 01:16:52 +0000 (UTC)
Received: from localhost (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15A0B63BA7;
        Thu, 13 May 2021 01:16:50 +0000 (UTC)
Date:   Thu, 13 May 2021 09:16:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Miles Chen <miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, k-hagio-ab@nec.com
Subject: Re: [PATCH] mm/sparse: fix check_usemap_section_nr warnings
Message-ID: <20210513011648.GA6776@MiWiFi-R3L-srv>
References: <20210511093114.15123-1-miles.chen@mediatek.com>
 <YJpbWVrgJFLRpzl3@kernel.org>
 <1620797600.14730.7.camel@mtkswgap22>
 <YJuh90iYeZ8F4Ain@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJuh90iYeZ8F4Ain@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/21 at 12:37pm, Mike Rapoport wrote:
> On Wed, May 12, 2021 at 01:33:20PM +0800, Miles Chen wrote:
> > On Tue, 2021-05-11 at 13:24 +0300, Mike Rapoport wrote:
> > > On Tue, May 11, 2021 at 05:31:14PM +0800, Miles Chen wrote:
> > > > In current implementation of node_data, if CONFIG_NEED_MULTIPLE_NODES=y,
> > > > node_data is allocated by kzmalloc. If CONFIG_NEED_MULTIPLE_NODES=n,
> > > > we use a global variable named "contig_page_data".
> > > > 
> > > > If CONFIG_DEBUG_VIRTUAL is not enabled. __pa() can handle both kzalloc and
> > > > symbol cases. But if CONFIG_DEBUG_VIRTUAL is set, we will have the
> > > > "virt_to_phys used for non-linear address" warning when booting.
> > > 
> > > Maybe we'll just allocate pgdat for CONFIG_NEED_MULTIPLE_NODES=n (which is
> > > essentially !NUMA) case in, say, free_area_init()?
> > 
> > 
> > thanks for your comment.
> > 
> > I check the source tree and found that contig_page_data is used by
> > crash_core.c as a symbol. I am not familiar with crash_core but I guess
> > allocate pgdat may break this crash_core users.
> > 
> > For example: some userspace scripts want to read the address of
> > contig_page_data symbol from a corefile.
> > 
> > kernel/crash_core.c:460:        VMCOREINFO_SYMBOL(contig_page_data);
> > 
> > #ifndef CONFIG_NEED_MULTIPLE_NODES
> >         VMCOREINFO_SYMBOL(mem_map);
> >         VMCOREINFO_SYMBOL(contig_page_data);
> > #endif
> 
> My understanding is that VMCOREINFO_SYMBOL() should correspond to actual
> symbol. If there is no contig_page_data symbol, there is no need for
> VMCOREINFO_SYMBOL() either.

Yeah, it's exported for makedumpfile and crash utility to parse and get
the memory layout of the corrupted kernel. If removing it, makedumpfile
will get it from node_data[]. Looks like a good idea to unify code for
numa|!numa on pglist_data instances.

Add Kazu to CC since he maintain makedumpfile and Crash utilities.

My concern is that that only happens on arm/arm64/riscv, does it mean the
warning is not necessary, so can be removed? Or we need to check if
CONFIG_DEBUG_VIRTUAL doesn't work well in this case.

Thanks
Baoquan

