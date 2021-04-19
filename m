Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D856363EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbhDSJiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhDSJiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618825064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pr6Kj+KN23H2x/H8q/2CCYxabxT7Vqp+jcXC0FHsmgo=;
        b=VBMYSEGWpSuW2E9uUWK2a+Q1DQzIE3J3hpCfIDeQBdFFAVuqisDXLkb1AuqT1ctxNZ3YT1
        8V9F7MCIA4glo4g9uq4s7lSqHyRwWVSgNgS9TPCUfENemeEX8PeEOOhTrEymJaMSTbxdRZ
        D0zEAUT0kBg98PO5P2+bapCubX0Dzpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-WdU_-XUNOvWF7UjLXXBvwg-1; Mon, 19 Apr 2021 05:37:42 -0400
X-MC-Unique: WdU_-XUNOvWF7UjLXXBvwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D8A8801814;
        Mon, 19 Apr 2021 09:37:40 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-172.pek2.redhat.com [10.72.13.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06F64107D5C6;
        Mon, 19 Apr 2021 09:37:36 +0000 (UTC)
Date:   Mon, 19 Apr 2021 17:37:32 +0800
From:   DaveYoung <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries()
 out-of-bounds access
Message-ID: <20210419093732.GB8618@dhcp-128-65.nay.redhat.com>
References: <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
 <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
 <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
 <20210416121636.GA22348@zn.tnic>
 <a853ea8535151fd8b267d8e68a45b33748978d8a.camel@gmx.de>
 <20210416144459.GB22348@zn.tnic>
 <7826c19ecd583700f56d2db33360e8032e812ecf.camel@gmx.de>
 <87sg3puco5.ffs@nanos.tec.linutronix.de>
 <d725b19b4c02273eaab38a10853fa6fb6d5bc76c.camel@gmx.de>
 <20210419085202.GB9093@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419085202.GB9093@zn.tnic>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/21 at 10:52am, Borislav Petkov wrote:
> Here's an attempt to explain what this fixes:
> 
> ---
> From: Mike Galbraith <efault@gmx.de>
> Date: Fri, 16 Apr 2021 14:02:07 +0200
> Subject: [PATCH] x86/crash: Fix crash_setup_memmap_entries() out-of-bounds
>  access
> 
> Commit in Fixes: added support for kexec-ing a kernel on panic using a
> new system call. As part of it, it does prepare a memory map for the new
> kernel.
> 
> However, while doing so, it wrongly accesses memory it has not
> allocated: it accesses the first element of the cmem->ranges[] array in
> memmap_exclude_ranges() but it has not allocated the memory for it in
> crash_setup_memmap_entries(). As KASAN reports:
> 
>   BUG: KASAN: vmalloc-out-of-bounds in crash_setup_memmap_entries+0x17e/0x3a0
>   Write of size 8 at addr ffffc90000426008 by task kexec/1187
> 
>   (gdb) list *crash_setup_memmap_entries+0x17e
>   0xffffffff8107cafe is in crash_setup_memmap_entries (arch/x86/kernel/crash.c:322).
>   317                                      unsigned long long mend)
>   318     {
>   319             unsigned long start, end;
>   320
>   321             cmem->ranges[0].start = mstart;
>   322             cmem->ranges[0].end = mend;
>   323             cmem->nr_ranges = 1;
>   324
>   325             /* Exclude elf header region */
>   326             start = image->arch.elf_load_addr;
>   (gdb)
> 
> Make sure the ranges array becomes a single element allocated.
> 
>  [ bp: Write a proper commit message. ]

Reviewed-by: Dave Young <dyoung@redhat.com>

> 
> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de
> ---
>  arch/x86/kernel/crash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index a8f3af257e26..b1deacbeb266 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -337,7 +337,7 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  	struct crash_memmap_data cmd;
>  	struct crash_mem *cmem;
>  
> -	cmem = vzalloc(sizeof(struct crash_mem));
> +	cmem = vzalloc(struct_size(cmem, ranges, 1));
>  	if (!cmem)
>  		return -ENOMEM;
>  
> -- 
> 2.29.2
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

Thanks
Dave

