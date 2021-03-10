Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F283343C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhCJQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbhCJQyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:54:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D25C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 08:54:07 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a9900eba30628a18a04b3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9900:eba3:628:a18a:4b3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 946481EC01CE;
        Wed, 10 Mar 2021 17:54:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615395245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QfdyuiekIGUWJFvwv5T1R86Xtjz+b2DXJJZVuyOQUWY=;
        b=HkDIn7zSSwGmcAWvazpOdAtybAxH8wMPEzk6IN5MlI8k9BdtBRCpclAFrHJQ+Sai+4QnO1
        pqq+geEyF++ERHRC6kYPcwfHq1GtsXtzTpkYRC9DydZDPje3YzB+0oVZKMOpD763UtDd6u
        xH3rP1pp8DLhpYFa6NKEWvn6EAAHkC4=
Date:   Wed, 10 Mar 2021 17:53:58 +0100
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
Subject: Re: [PATCH V2 1/25] x86/cpufeatures: Enumerate Intel Hybrid
 Technology feature bit
Message-ID: <20210310165358.GI23521@zn.tnic>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1615394281-68214-2-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 08:37:37AM -0800, kan.liang@linux.intel.com wrote:
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
> index cc96e26d69f7..e7cfc9eedf8d 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -374,6 +374,7 @@
>  #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
>  #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
>  #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
> +#define X86_FEATURE_HYBRID_CPU		(18*32+15) /* This part has CPUs of more than one type */

							  /* "" This ...

unless you have a valid use case for "hybrid_cpu" being present there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
