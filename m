Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAA63E4FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 01:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbhHIXZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 19:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhHIXZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 19:25:21 -0400
Received: from mail-pl1-x662.google.com (mail-pl1-x662.google.com [IPv6:2607:f8b0:4864:20::662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E0EC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 16:25:00 -0700 (PDT)
Received: by mail-pl1-x662.google.com with SMTP id f3so7775164plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 16:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:date:from:to:cc:subject
         :message-id:references:content-disposition:in-reply-to;
        bh=weT4wxpTlko71+UwKvjmclfuAAVngJ2f37H+93Nqsj4=;
        b=dkjYDBKufPKBKe27p7Te897b5l9udq+P7Uv6sm7vNyiVf3bJml4lsrtK4CyKpK8Jaq
         b0F8Sp2FMi/7KLTREk7wTmfrM42FW+b0rrKD0ZSIS+Yv1mgmB1YzgvgvJZl/1BSqV8vr
         LNfX8QDiF0r6XjBdePGJEF3zlue0ov2zVvt4TZntnBsia3cw3FS2bNAI6a7MPBYcqVAu
         5l/6Foty2y+OGrB0oPsz+tYLIejaxtQ79BzuG6GIAGpwJhkBOcSaVAZJGX28Xpaz0/xX
         6PL3oStvk1RkqOFH8TzFt0mB2+AY43JBjS19FlSU1AOJtQzh/jS1GWXwBr7vGGo5yb6i
         WiIQ==
X-Gm-Message-State: AOAM533XrbFN2ol0K5haTAe6BPrzEeB7OdBUVP2RpeZFiRtkAzM/rrfN
        AoK2Ly9QhmSxeD2E+/Mum9NOD4z/h/ozVbiy8ozFegmhID6E
X-Google-Smtp-Source: ABdhPJyKmMymqBQVIKOccxdAZPleKivNE6KwWGRUh6O+mQ60NoDcWygTxR8hpq32MRwFtsPDSoZaNVQqkx+E
X-Received: by 2002:a65:41c7:: with SMTP id b7mr55589pgq.81.1628551498507;
        Mon, 09 Aug 2021 16:24:58 -0700 (PDT)
Received: from smtp.aristanetworks.com (smtp.aristanetworks.com. [54.193.82.35])
        by smtp-relay.gmail.com with ESMTPS id ch23sm3852754pjb.14.2021.08.09.16.24.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Aug 2021 16:24:58 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from chmeee (unknown [10.95.69.61])
        by smtp.aristanetworks.com (Postfix) with ESMTPS id C24C2301B627;
        Mon,  9 Aug 2021 16:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1628551497;
        bh=weT4wxpTlko71+UwKvjmclfuAAVngJ2f37H+93Nqsj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpr4s2Sn4Us3FioFlDnMNmAsYWsz31Uwkpe97hr9cPU/JFCpx4A2vCrftlJrhQa3M
         gzKxEW9/5rzLb9GtoC1ECoWODNdptPBWueURp2aVUM5BuT2fVToCoOizb5vQKttuMc
         H6Qfvsj24gljM7krSnPfnTA4KM2+x6NYg2LirWV6YM68o3GmZPRWNYkRbSyuba/pS8
         Mq9ZjOAlQWRqtINPuR8kQHQJ1vwVMx1KQN7QE2iH7tWQVHtOBVi8zbAAPrzBlU2bx5
         ltjLaueS8sHKPaMHiLRY6dUjLblIkKsCfllxTNdYJb/J/qZqs+WeGNxol65qW+VgzS
         pQ+4iQPRYc8gQ==
Received: from kevmitch by chmeee with local (Exim 4.94.2)
        (envelope-from <kevmitch@arista.com>)
        id 1mDEdc-001qDt-AT; Mon, 09 Aug 2021 16:24:56 -0700
Date:   Mon, 9 Aug 2021 16:24:55 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: allow i386 kexec to load x86_64 bzImage anywhere
Message-ID: <YRG5RyazxdfIeOzw@chmeee>
References: <20210807022154.425449-1-kevmitch@arista.com>
 <20210809021316.GA28879@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809021316.GA28879@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:13:16AM +0800, Baoquan He wrote:
> On 08/06/21 at 07:21pm, Kevin Mitchell wrote:
> > In linux-5.2, the following commit allows the kdump kernel to be loaded
> > at a higher address than 896M
> > 
> > 9ca5c8e632ce ("x86/kdump: Have crashkernel=X reserve under 4G by
> > default")
> > 
> > While this limit does indeed seem unnecessary for x86_64 kernels, it
> > still is required to boot to or from i386 kernels. Therefore,
> > kexec-tools continues to enforce it when using the i386 bzImage loader.
> > 
> > However, the i386 bzImage loader may also be used to load an x86_64
> > kernel from i386 user space to be kexeced by an x86_64 kernel. In this
> > case, the limit was incorrectly enforced.
> 
> Are you doing kexec/kdump switching to x86_64 kernel on a i386 system?

We run an x86_64 kernel, but our initrd userspace in which we load the x86_64
kdump kernel is i386 to conserve space as many of our smaller devices are memory
constrained. We also need to fit this initrd into our coreboot SPI flash image
which is limited to a few megabytes.

> Could you tell more about your testing or product environment so that we
> know why we need to do that?

Previous to 9ca5c8e632ce, this worked without issue because the crashkernel area
was always reserved in a location that satisfied the limits defined in
kexec-bzImage.c even on an x86_64 kernel. Once we switched to
linux-5.10, we started seeing

Aboot# kexec --load-panic --initrd=initrd-i386-kdump
    --command-line="$crash_cmd_line" linux-x86_64-kdump
Could not find a free area of memory of 0x8000 bytes...
locate_hole failed

which is the result of hitting the kexec-bzImage.c limits. However, these appear
not to apply in the case of x86_64 kernel loaded from an x86_64 kernel even when
using an i386 kexec.

With this patch, I am able to load the kdump kernel into the new default
crashkernel location assigned by the linux-5.10 kernel (e.g., 1968MB, 3264MB)
and have it successfully kexeced when triggering a panic. This was tested on all
our current CPU platforms including both AMD (eKabini, Steppe Eagle, Crowned
Eagle, Merlin Falcon) and Intel (SandyBridge, Broadwell-DE) CPUs variously
running on between 4Gb - 64 Gb of RAM.

Conversely, I tried unconditionally removing the limits in kexec-bzImage.c, but
found that if either or both of the running or kdump kernels were i386 and the
crashkernel reservation was above the 896M limit (I had to force this as the
default location selected by the kernel is below this), the kexec would hang
indefinitely. Therefore, I have kept those limits in place when either kernel is
i386.

> AFAIK, we rarely kexec/kdump switch to
> x86_64 kenrel from a i386 kernel.
> 
> Thanks
> Baoquan
> 
> > 
> > This commit adds an additional check for an x86_64 image kexeced by an
> > x86_64 kernel in the i386 loader and bumps the limit to the maximum
> > addressable 4G in that case.
> > 
> > Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
> > ---
> >  kexec/arch/i386/kexec-bzImage.c | 41 ++++++++++++++++++++++-----------
> >  1 file changed, 28 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
> > index df8985d..7b8e36e 100644
> > --- a/kexec/arch/i386/kexec-bzImage.c
> > +++ b/kexec/arch/i386/kexec-bzImage.c
> > @@ -22,6 +22,7 @@
> >  #include <string.h>
> >  #include <stdlib.h>
> >  #include <errno.h>
> > +#include <limits.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> >  #include <fcntl.h>
> > @@ -114,6 +115,7 @@ int do_bzImage_load(struct kexec_info *info,
> >  	struct entry32_regs regs32;
> >  	struct entry16_regs regs16;
> >  	unsigned int relocatable_kernel = 0;
> > +	unsigned int kernel64 = 0;
> >  	unsigned long kernel32_load_addr;
> >  	char *modified_cmdline;
> >  	unsigned long cmdline_end;
> > @@ -155,6 +157,13 @@ int do_bzImage_load(struct kexec_info *info,
> >  		dbgprintf("bzImage is relocatable\n");
> >  	}
> >  
> > +	if ((setup_header.protocol_version >= 0x020C) &&
> > +	    (info->kexec_flags & KEXEC_ARCH_X86_64) &&
> > +	    (setup_header.xloadflags & 1)) {
> > +		kernel64 = 1;
> > +		dbgprintf("loading x86_64 bzImage from an x86_64 kernel\n");
> > +	}
> > +
> >  	/* Can't use bzImage for crash dump purposes with real mode entry */
> >  	if((info->kexec_flags & KEXEC_ON_CRASH) && real_mode_entry) {
> >  		fprintf(stderr, "Can't use bzImage for crash dump purposes"
> > @@ -197,17 +206,17 @@ int do_bzImage_load(struct kexec_info *info,
> >  	/* Load the trampoline.  This must load at a higher address
> >  	 * than the argument/parameter segment or the kernel will stomp
> >  	 * it's gdt.
> > -	 *
> > -	 * x86_64 purgatory code has got relocations type R_X86_64_32S
> > -	 * that means purgatory got to be loaded within first 2G otherwise
> > -	 * overflow takes place while applying relocations.
> >  	 */
> > -	if (!real_mode_entry && relocatable_kernel)
> > +	if (!real_mode_entry && relocatable_kernel) {
> > +		/* x86_64 purgatory could be anywhere */
> > +		unsigned long purg_max_addr = kernel64 ? ULONG_MAX : 0x7fffffff;
> > +
> >  		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
> > -					0x3000, 0x7fffffff, -1, 0);
> > -	else
> > +					0x3000, purg_max_addr, -1, 0);
> > +	} else {
> >  		elf_rel_build_load(info, &info->rhdr, purgatory, purgatory_size,
> >  					0x3000, 640*1024, -1, 0);
> > +	}
> >  	dbgprintf("Loaded purgatory at addr 0x%lx\n", info->rhdr.rel_addr);
> >  
> >  	/* The argument/parameter segment */
> > @@ -277,14 +286,20 @@ int do_bzImage_load(struct kexec_info *info,
> >  	if (real_mode->protocol_version >=0x0205 && relocatable_kernel) {
> >  		/* Relocatable bzImage */
> >  		unsigned long kern_align = real_mode->kernel_alignment;
> > -		unsigned long kernel32_max_addr = DEFAULT_BZIMAGE_ADDR_MAX;
> > +		unsigned long kernel_max_addr = DEFAULT_BZIMAGE_ADDR_MAX;
> >  
> > -		if (kernel32_max_addr > real_mode->initrd_addr_max)
> > -			kernel32_max_addr = real_mode->initrd_addr_max;
> > +		/*
> > +		 * x86_64 kernels can be kexeced by an x86_64 kernel
> > +		 * from any addressable location
> > +		 */
> > +		if (kernel64)
> > +			kernel_max_addr = ULONG_MAX;
> > +		else if (kernel_max_addr > real_mode->initrd_addr_max)
> > +			kernel_max_addr = real_mode->initrd_addr_max;
> >  
> >  		kernel32_load_addr = add_buffer(info, kernel + kern16_size,
> >  						size, size, kern_align,
> > -						0x100000, kernel32_max_addr,
> > +						0x100000, kernel_max_addr,
> >  						1);
> >  	}
> >  	else {
> > @@ -296,9 +311,9 @@ int do_bzImage_load(struct kexec_info *info,
> >  	dbgprintf("Loaded 32bit kernel at 0x%lx\n", kernel32_load_addr);
> >  
> >  	/* Tell the kernel what is going on */
> > -	setup_linux_bootloader_parameters(info, real_mode, setup_base,
> > +	setup_linux_bootloader_parameters_high(info, real_mode, setup_base,
> >  		kern16_size_needed, command_line, command_line_len,
> > -		initrd, initrd_len);
> > +		initrd, initrd_len, kernel64); /* put x86_64 initrd high too */
> >  
> >  	if (real_mode_entry && real_mode->protocol_version >= 0x0201) {
> >  		real_mode->loader_flags |= 0x80; /* CAN_USE_HEAP */
> > -- 
> > 2.32.0
> > 
> 
