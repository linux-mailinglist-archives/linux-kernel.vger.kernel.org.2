Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C316415265
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhIVVJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbhIVVJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:09:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522E2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AUrxzWHUDiIkVe0pCul4am+eYMocI+xR3IVu4etN2ik=; b=cI/HH1n9IHnS59Vwg4T3USPEJy
        yqf8pBFHwg5vfUgTgEbWExme4EnKhpOAMEInsYDmvANFsP+4IFDpZy8B/KKofwXXSYwJNFosQIUKK
        Sq4v1oBqKCyYTjDAPP70tg2LZi0Ykv/MjflLLrp98W7O7cvK98g6kUOZnM7Tz8rmGSdSx7I6xhelB
        oArJi2a4PuonEOFbhGyovGkihF/0RPvq/uDaJm3WxcEWJ/xo/gu3Q1jr62MEc2B3P1DuIGer9jrH/
        7iX/qmRLNvBaOG8girQUCSEhXtJ3Mtqwu8xEdFEGb5Ok2+ia36YjIMITMl6al/VCXvrv/a6wgd+QV
        cG1qUw7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT9Sc-0054ul-PD; Wed, 22 Sep 2021 21:07:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E7FD9811F0; Wed, 22 Sep 2021 23:07:22 +0200 (CEST)
Date:   Wed, 22 Sep 2021 23:07:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] x86/traps: Demand-populate PASID MSR via #GP
Message-ID: <20210922210722.GV4323@worktop.programming.kicks-ass.net>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-5-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920192349.2602141-5-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 07:23:45PM +0000, Fenghua Yu wrote:
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..a25d738ae839 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -61,6 +61,7 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/vdso.h>
> +#include <asm/iommu.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -526,6 +527,14 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>  	return GP_CANONICAL;
>  }
>  
> +static bool fixup_pasid_exception(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> +		return false;
> +
> +	return __fixup_pasid_exception();
> +}
> +
>  #define GPFSTR "general protection fault"
>  
>  DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> @@ -538,6 +547,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  
>  	cond_local_irq_enable(regs);
>  
> +	if (user_mode(regs) && fixup_pasid_exception())
> +		goto exit;
> +
>  	if (static_cpu_has(X86_FEATURE_UMIP)) {
>  		if (user_mode(regs) && fixup_umip_exception(regs))
>  			goto exit;

So you're eating any random #GP that might or might not be PASID
related. And all that witout a comment... Enlighten?
