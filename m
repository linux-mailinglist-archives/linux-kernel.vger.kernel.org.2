Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46743757CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhEFPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbhEFPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:44:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA73C061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 08:43:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h11so5627282pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LcIFfAB5skjGeyCAD2QMmjpF+VNCcVetb+lsu2lskTY=;
        b=Z2vGGhLZma2sfvQ1r1IYFoiaBh/8OD45lcuCFUx7hhUR4L0p3zrETc8AvA/i9r3vZK
         BMwvJeQ4BZ5BK7rSNnP8T9XZf5Go+XMFA7h6OEq4uO/7W5leKfZffK8CvY4NbCvXhxS1
         +m2no7ilCyqCmnV8YdDQnVBqeCST3QB89YIpUzF0tWlkBe3u5efC0UcjqpaG+kcM+lih
         9HBCQvXchWCyikzB2vtYrg8qydzk0U/IVFI/aGscicVtEDbCTgKevXCfP0Mk+2xMKjvC
         xtmveXOWb321zTVdDQbYe5Sw4r6x40mjMgj1SB81L5LiCykz4AW1tm9cSkv//4kBbbbL
         NO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LcIFfAB5skjGeyCAD2QMmjpF+VNCcVetb+lsu2lskTY=;
        b=ML7vGZXDEogabkT6ANp2F6BF8BoOywu8+oHCGgUXxrw/NlQj2zTnXDmhEZT1SPZTDm
         xuIELh2xlMJHxLNQBoQQ9uD02KAKK0SydFlNgIxbjRZc9PexsY3muKSrPcGkRdKsNujm
         3iGhiJ7/ciLll/NuAwwtB4BFJ5PimBFbQ66HV4UrqDYVY3iA/Y8V3zZGgTzsDQQCLDff
         68ponct4qw8jUQZ6/DhUoMJ+hlA0rVea8yAviPl9AusfnsRk9Zd+7n4B6xhah9XoVE2C
         SPBBlSyT9rvavjT8gJVXyI6vc7q4smXW+NplNErH5EgghrQ0FOysONog58moLIJXk81/
         dlbQ==
X-Gm-Message-State: AOAM531KhbQqRNKwZyGheRSlvuplcpz9EmTW6vdh1m5ptBWXyw4fE+FH
        I26Vp+F4dPMMBA1FKBu/xTsMig==
X-Google-Smtp-Source: ABdhPJwzg5Yk54M6Dkv5tgc2Fqqb0Cj/1kw7CHpPzP+oLwemOrk0iU1SGCVH9hc+g3ixgndN+qF/bg==
X-Received: by 2002:a63:e712:: with SMTP id b18mr4963082pgi.2.1620315807827;
        Thu, 06 May 2021 08:43:27 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id 187sm2501268pff.139.2021.05.06.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:43:27 -0700 (PDT)
Date:   Thu, 6 May 2021 15:43:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Eric Biederman <ebiederm@xmission.com>, x86@kernel.org,
        kexec@lists.infradead.org, Joerg Roedel <jroedel@suse.de>,
        stable@vger.kernel.org, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] kexec: Allow architecture code to opt-out at runtime
Message-ID: <YJQOmxx1EMUqNpNn@google.com>
References: <20210506093122.28607-1-joro@8bytes.org>
 <20210506093122.28607-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506093122.28607-2-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Allow a runtime opt-out of kexec support for architecture code in case
> the kernel is running in an environment where kexec is not properly
> supported yet.
> 
> This will be used on x86 when the kernel is running as an SEV-ES
> guest. SEV-ES guests need special handling for kexec to hand over all
> CPUs to the new kernel. This requires special hypervisor support and
> handling code in the guest which is not yet implemented.
> 
> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  kernel/kexec.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index c82c6c06f051..d03134160458 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -195,11 +195,25 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>   * that to happen you need to do that yourself.
>   */
>  
> +bool __weak arch_kexec_supported(void)
> +{
> +	return true;
> +}
> +
>  static inline int kexec_load_check(unsigned long nr_segments,
>  				   unsigned long flags)
>  {
>  	int result;
>  
> +	/*
> +	 * The architecture may support kexec in general, but the kernel could
> +	 * run in an environment where it is not (yet) possible to execute a new
> +	 * kernel. Allow the architecture code to opt-out of kexec support when
> +	 * it is running in such an environment.
> +	 */
> +	if (!arch_kexec_supported())
> +		return -ENOSYS;

This misses kexec_file_load.  Also, is a new hook really needed?  E.g. the
SEV-ES check be shoved into machine_kexec_prepare().  The downside is that we'd
do a fair amount of work before detecting failure, but that doesn't seem hugely
problematic.

> +
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
> -- 
> 2.31.1
> 
