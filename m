Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64E33528A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhDBJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:25:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234029AbhDBJZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:25:58 -0400
Received: from zn.tnic (p200300ec2f0a2000e9f6c6f26a4b9205.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2000:e9f6:c6f2:6a4b:9205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F27F1EC0288;
        Fri,  2 Apr 2021 11:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617355557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Eta0G1SfvCYsjRcscD6Hy7PEpsXdwgNptI3H7GRU/qE=;
        b=AS1PyZEOhJrLeAebzd55fGEvyU8ZXfs892Nm1VTjydh9SmFwXVJDPwFe7+gg1XHiedb+sJ
        4qHOyC5EUCbdipooe3ek4Q7Ja37piDcnAWmmTQbyv1stmSEZZv84ivcMyImJJJ9Gf4N71a
        +DUlpo6v9dOrohKv+rvzdtq5J+G687M=
Date:   Fri, 2 Apr 2021 11:26:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH V4 02/25] x86/cpu: Add helper function to get the type of
 the current hybrid CPU
Message-ID: <20210402092602.GB28499@zn.tnic>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
 <1617322252-154215-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1617322252-154215-3-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:10:29PM -0700, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index dc6d149bf851..746512a68b30 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -166,6 +166,8 @@ enum cpuid_regs_idx {
>  
>  #define X86_VENDOR_UNKNOWN	0xff
>  
> +#define X86_HYBRID_CPU_TYPE_ID_SHIFT		24

Just put that over the function where it is used, i.e. in intel.c

With that addressed:

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
