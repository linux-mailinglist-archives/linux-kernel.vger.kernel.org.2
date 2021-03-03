Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB9632B75A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbhCCK7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:59:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240936AbhCCAll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614732014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJ8fhS+O4Rb8GZGJYkmyko8OHt98hIay+OTIrXCbPnE=;
        b=Czt/YkzAempczxZYUXyqpdOb/8vFsWulT/OiUna3FOvVX6MtZbtZTT0YPwOwL/r8KozBDY
        8qYQKhbyJKFZLBq4x6sOTuvnlFFQ2SFtqAydDcJt4aOYxt/XjXMxuR3fG5jhpKS3mRZW1Q
        y4HBxjiiPg2SmjKbvIi3SMcbbbSgOMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-ruB1zOTSNRy5GP62OfiObw-1; Tue, 02 Mar 2021 19:40:10 -0500
X-MC-Unique: ruB1zOTSNRy5GP62OfiObw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7A35803F47;
        Wed,  3 Mar 2021 00:40:07 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C12FB6FEE2;
        Wed,  3 Mar 2021 00:40:01 +0000 (UTC)
Date:   Wed, 3 Mar 2021 08:39:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 1/2] x86/setup: consolidate early memory reservations
Message-ID: <20210303003959.GB2962@MiWiFi-R3L-srv>
References: <20210302100406.22059-1-rppt@kernel.org>
 <20210302100406.22059-2-rppt@kernel.org>
 <20210302130409.GA2962@MiWiFi-R3L-srv>
 <YD5XJrtJDgdmMt42@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD5XJrtJDgdmMt42@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 at 05:17pm, Mike Rapoport wrote:
> On Tue, Mar 02, 2021 at 09:04:09PM +0800, Baoquan He wrote:
...
> > > +static void __init early_reserve_memory(void)
> > > +{
> > > +	/*
> > > +	 * Reserve the memory occupied by the kernel between _text and
> > > +	 * __end_of_kernel_reserve symbols. Any kernel sections after the
> > > +	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
> > > +	 * separate memblock_reserve() or they will be discarded.
> > > +	 */
> > > +	memblock_reserve(__pa_symbol(_text),
> > > +			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
> > > +
> > > +	/*
> > > +	 * Make sure page 0 is always reserved because on systems with
> > > +	 * L1TF its contents can be leaked to user processes.
> > > +	 */
> > > +	memblock_reserve(0, PAGE_SIZE);
> > > +
> > > +	early_reserve_initrd();
> > > +
> > > +	if (efi_enabled(EFI_BOOT))
> > > +		efi_memblock_x86_reserve_range();
> > > +
> > > +	memblock_x86_reserve_range_setup_data();
> > 
> > This patch looks good to me, thanks for the effort.
> > 
> > While at it, wondering if we can rename the above function to
> > memblock_reserve_setup_data() just as its e820 counterpart
> > e820__reserve_setup_data(), adding 'x86' to a function under arch/x86
> > seems redundant.
> 
> I'd rather keep these names for now. First, it's easier to dig to them in the git
> history and second, I'm planning more changes in this area and these names
> are as good as FIXME: to remind what still needs to be checked :)

I see, thanks for explanation.

