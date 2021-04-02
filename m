Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7E352898
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhDBJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:24:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50238 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhDBJYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:24:31 -0400
Received: from zn.tnic (p200300ec2f0a2000e9f6c6f26a4b9205.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2000:e9f6:c6f2:6a4b:9205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B21811EC0288;
        Fri,  2 Apr 2021 11:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617355469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pD9cJlmd0OoSPyAI6OCJEIeS8ESGaSccB2WyGFoCRT0=;
        b=eQvhg9gHhb0OTVqY9n9H49egKMNHB2IkWhkdO3eJlqsrLy316ibps72CU8dxk5G/7cEh8+
        fHxBHoQsCslFfuM4WMNun1YDJv7eNud0XBW86XSbzTrILfJvOkGU69aZAbwD5S06F2rAir
        Weyw5WpvMUPSNv4sbPTvxDP8Llz9k4E=
Date:   Fri, 2 Apr 2021 11:24:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V4 01/25] x86/cpufeatures: Enumerate Intel Hybrid
 Technology feature bit
Message-ID: <20210402092427.GA28499@zn.tnic>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
 <1617322252-154215-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617322252-154215-2-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:10:28PM -0700, kan.liang@linux.intel.com wrote:
> From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> Add feature enumeration to identify a processor with Intel Hybrid
> Technology: one in which CPUs of more than one type are the same package.
> On a hybrid processor, all CPUs support the same homogeneous (i.e.,
> symmetric) instruction set. All CPUs enumerate the same features in CPUID.
> Thus, software (user space and kernel) can run and migrate to any CPU in
> the system as well as utilize any of the enumerated features without any
> change or special provisions. The main difference among CPUs in a hybrid
> processor are power and performance properties.
> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Len Brown <len.brown@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v3 (as part of patchset for perf change for Alderlake)
>  * None
> 
> Changes since V2 (as part of patchset for perf change for Alderlake)
>  * Don't show "hybrid_cpu" in /proc/cpuinfo (Boris)
> 
> Changes since v1 (as part of patchset for perf change for Alderlake)
>  * None
> 
> Changes since v1 (in a separate posting):
>  * Reworded commit message to clearly state what is Intel Hybrid
>    Technology. Stress that all CPUs can run the same instruction
>    set and support the same features.
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index cc96e26d69f7..1ba4a6e1690c 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -374,6 +374,7 @@
>  #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
>  #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
>  #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
> +#define X86_FEATURE_HYBRID_CPU		(18*32+15) /* "" This part has CPUs of more than one type */
>  #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
>  #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
>  #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
> -- 

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
