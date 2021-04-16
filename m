Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A862361E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhDPLHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237997AbhDPLHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618571230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nHPAeuJEveCP4Fc1NFrF0y8J4SMSH0qhebL+YdyGc54=;
        b=hs2KVe0ErjmlUC7e9lnOzIb1clqo1J0cr2JNT0AKAzhRbQGQtGUmNTq4Yee9GXpSuWCH56
        CPcnMavFdaTdxUDI3v5kutiWP8N/EZVmUaVRyUfk9gCrUiuYnUHTfnpzEMLlkQhKCCPYbB
        5n4TR/JmFcEtzTU1wuFeJU8t7ZbVEDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-DgoPjzdyORO5kVrtif4suA-1; Fri, 16 Apr 2021 07:07:08 -0400
X-MC-Unique: DgoPjzdyORO5kVrtif4suA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB7F8030A1;
        Fri, 16 Apr 2021 11:07:07 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52F361C4;
        Fri, 16 Apr 2021 11:07:04 +0000 (UTC)
Date:   Fri, 16 Apr 2021 19:07:01 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org
Subject: Re: x86/crash: fix crash_setup_memmap_entries() out-of-bounds access
Message-ID: <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
References: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9efaad2ba042b8791cbe8c3e7cad491fe05e06eb.camel@gmx.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thanks for the patch! I suggest always cc kexec list for kexec/kdump
patches.
On 04/15/21 at 07:56pm, Mike Galbraith wrote:
> x86/crash: fix crash_setup_memmap_entries() KASAN vmalloc-out-of-bounds gripe
> 
> [   15.428011] BUG: KASAN: vmalloc-out-of-bounds in crash_setup_memmap_entries+0x17e/0x3a0
> [   15.428018] Write of size 8 at addr ffffc90000426008 by task kexec/1187
> 
> (gdb) list *crash_setup_memmap_entries+0x17e
> 0xffffffff8107cafe is in crash_setup_memmap_entries (arch/x86/kernel/crash.c:322).
> 317                                      unsigned long long mend)
> 318     {
> 319             unsigned long start, end;
> 320
> 321             cmem->ranges[0].start = mstart;
> 322             cmem->ranges[0].end = mend;
> 323             cmem->nr_ranges = 1;
> 324
> 325             /* Exclude elf header region */
> 326             start = image->arch.elf_load_addr;
> (gdb)
> 
> We're excluding two ranges, allocate the scratch space we need to do that.

I think 1 range should be fine, have you tested 1?

The code is just excluding the elf header space which will be loaded
first before anything else so I assume it will be just at the start of
the crashkernel resource region.  Thus [a b] after exclude the start
part will be [c b].  But I have not read the code for long time, maybe I
need to double check.

But anyway 2 would be good since the code is obscure we can easily miss
it in the future.  See how other people think.

> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
>  arch/x86/kernel/crash.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -337,7 +337,7 @@ int crash_setup_memmap_entries(struct ki
>  	struct crash_memmap_data cmd;
>  	struct crash_mem *cmem;
> 
> -	cmem = vzalloc(sizeof(struct crash_mem));
> +	cmem = vzalloc(sizeof(struct crash_mem)+(2*sizeof(struct crash_mem_range)));

Thanks for the patch, can you try below?
vzalloc(struct_size(cmem, ranges, 2));


>  	if (!cmem)
>  		return -ENOMEM;
> 
> 

Thanks
Dave

