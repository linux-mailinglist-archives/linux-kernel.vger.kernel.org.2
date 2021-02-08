Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE708313EA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhBHTQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbhBHR5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:57:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C47C061797
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:56:44 -0800 (PST)
Received: from zn.tnic (p200300ec2f073f0023a6d1f14b392727.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3f00:23a6:d1f1:4b39:2727])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2F771EC04C2;
        Mon,  8 Feb 2021 18:56:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612807002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2JLTZK7Um6zaEjKpd2T6QZeRWlyTYoCQQV+lk35yvAQ=;
        b=TihGHaKa9tovhESzxfy6HRwn4+DDjUzZXhYeftw06ik2E4gCflAFkUrXGAyZAKghwxztkr
        9Ih2gSKDGdQYxR1qsx0b9RunIbrwdZpfNT65HSVfwXPdmZpxX+ySpzsSQ/LAazpmIZ7REP
        uTERNgdt3TlIB8Jfkmo911kAPxIVzeY=
Date:   Mon, 8 Feb 2021 18:56:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 02/49] x86/cpu: Describe hybrid CPUs in cpuinfo_x86
Message-ID: <20210208175640.GD18227@zn.tnic>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1612797946-18784-3-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 07:24:59AM -0800, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index c20a52b..1f25ac9 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -139,6 +139,16 @@ struct cpuinfo_x86 {
>  	u32			microcode;
>  	/* Address space bits used by the cache internally */
>  	u8			x86_cache_bits;
> +	/*
> +	 * In hybrid processors, there is a CPU type and a native model ID. The
> +	 * CPU type (x86_cpu_type[31:24]) describes the type of micro-
> +	 * architecture families. The native model ID (x86_cpu_type[23:0])
> +	 * describes a specific microarchitecture version. Combining both
> +	 * allows to uniquely identify a CPU.
> +	 *
> +	 * Please note that the native model ID is not related to x86_model.
> +	 */
> +	u32			x86_cpu_type;

Why are you adding it here instead of simply using
X86_FEATURE_HYBRID_CPU at the call site?

How many uses in this patchset?

/me searches...

Exactly one.

Just query X86_FEATURE_HYBRID_CPU at the call site and read what you
need from CPUID and use it there - no need for this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
