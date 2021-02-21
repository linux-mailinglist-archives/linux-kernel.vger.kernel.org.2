Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB32320D2E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBUTbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhBUTa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:30:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E352C061574;
        Sun, 21 Feb 2021 11:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=VSMHLHDB7pBRPWsMCPY4560P/deR5lUq0uveRSDWdaA=; b=c6OzXVJOwVR/jqpy4S0SXjhCTW
        fqL/ClLdHlKhcuBHDnYMdZoL+s3mGgrXJXWrrTuo9WHKHI4cmmFUZrSnebANRMPeISmEbvrOYqj4w
        nacRc+x+bPe6kVOWoBGCcIRPfiFPT8Y7QPQf73QkUlBRGVuAgC2n/IyHdcD0/4tr4Db5A3NOW62d9
        urdKCWiiEAA+B44cRVda9F5cyqKbTpVAb5UBI0rdJOB021apJ7zgtbCw8tM/EdT+cVVuDZG9/NubK
        /oizGz4tgYoI+dhtZQL7XuTcoTCWT+vqfSw6/LtfclschpiTBeHdDLghnicQvKQqXXLRThbOVVcpU
        5MDrKYAA==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDuQp-0005FX-Mn; Sun, 21 Feb 2021 19:30:16 +0000
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cb6151cf-8f71-2275-c757-098d163f87ff@infradead.org>
Date:   Sun, 21 Feb 2021 11:30:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210221185637.19281-23-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/21 10:56 AM, Chang S. Bae wrote:
> "xstate.disable=0x60000" will disable AMX on a system that has AMX compiled
> into XFEATURE_MASK_USER_ENABLED.
> 
> "xstate.enable=0x60000" will enable AMX on a system that does NOT have AMX
> compiled into XFEATURE_MASK_USER_ENABLED (assuming the kernel is new enough
> to support this feature).
> 
> Rename XFEATURE_MASK_USER_SUPPORTED to XFEATURE_MASK_USER_ENABLED to be
> aligned with the new parameters.
> 
> While this cmdline is currently enabled only for AMX, it is intended to be
> easily enabled to be useful for future XSAVE-enabled features.
> 

Hi,
Can we tell people (in this Doc file) where to look up the values that can be
used in xstate.enable and xstate.disable?

thanks.

> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v3:
> * Fixed a few typos. (Randy Dunlap)
> 
> Changes from v2:
> * Changed the kernel tainted when any unknown state is enabled. (Andy
>   Lutomirski)
> * Simplified the cmdline handling.
> * Edited the changelog.
> 
> Changes from v1:
> * Renamed the user state mask define (Andy Lutomirski and Dave Hansen)
> * Changed the error message (Dave Hansen)
> * Fixed xfeatures_mask_user()
> * Rebased the upstream kernel (5.10) -- revived the param parse function
> ---
>  .../admin-guide/kernel-parameters.txt         | 15 +++++
>  arch/x86/include/asm/fpu/types.h              |  6 ++
>  arch/x86/include/asm/fpu/xstate.h             | 24 +++----
>  arch/x86/kernel/fpu/init.c                    | 65 +++++++++++++++++--
>  4 files changed, 93 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a10b545c2070..ec79f63979a4 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6014,6 +6014,21 @@
>  			which allow the hypervisor to 'idle' the guest on lock
>  			contention.
>  
> +	xstate.enable=	[X86-64]
> +	xstate.disable=	[X86-64]
> +			The kernel is compiled with a default xstate bitmask --
> +			enabling it to use the XSAVE hardware to efficiently
> +			save and restore thread states on context switch.
> +			xstate.enable allows adding to that default mask at
> +			boot-time without recompiling the kernel just to support
> +			the new thread state. (Note that the kernel will ignore
> +			any bits in the mask that do not correspond to features
> +			that are actually available in CPUID.)  xstate.disable
> +			allows clearing bits in the default mask, forcing the
> +			kernel to forget that it supports the specified thread
> +			state. When a bit set for both, the kernel takes
> +			xstate.disable as a priority.
> +
>  	xirc2ps_cs=	[NET,PCMCIA]
>  			Format:
>  			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]



-- 
~Randy

