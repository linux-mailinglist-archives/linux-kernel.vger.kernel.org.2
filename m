Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6140359333
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhDIDnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhDIDno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:43:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5BC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=5kD0HUtQLBSTJmuDYboGV1rro1FgjGZFQ2RlCNvjwvI=; b=beO+98D7S/ngHF0nnJYLFgDAH9
        EMbdBkHql2rUUSKZsdRCVYRFC6i1zs/yBP18RfEaegMlSAlHIeVzSAlW0AtYfEHg3zXpK64r5M0Vl
        YHhMKVS8eKAEl+vDW3II0gS5pI0l3jC9qa3gY4L8RgzpcpBqfWTC5Aw9Lu4eVPldFa8oqZjuzoLqq
        BQYJicvpKxbMxLr91rwjKsEv40QoV2Cia2tF0Sh+tMGC8VISxrX90lxEh0300z4v0eX+WcWQ2rpcK
        ogAwEXYhPU8abw3GH5VTYHKnCOahsDrA3ZcBNQXf8p1fsRmrx9zlsMUByFc0xKehVvMgB24AQBMwp
        xm9MF1oQ==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUi35-009ti2-Ao; Fri, 09 Apr 2021 03:43:11 +0000
Subject: Re: [PATCH 5/5] x86/speculation: Add PSF mitigation kernel parameters
To:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, Jonathan Corbet <corbet@lwn.net>
References: <20210407125024.242491-1-rsaripal@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <72b45d78-f66b-bd18-4931-04feb206cd79@infradead.org>
Date:   Thu, 8 Apr 2021 20:43:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210407125024.242491-1-rsaripal@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 5:50 AM, Ramakrishna Saripalli wrote:
> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
> 
> PSF mitigation introduces new kernel parameters.
> 
> The kernel parameters for PSF mitigation are modeled
> after spec_store_bypass_disable.

Maybe too much copy-pasta. See below.

> 
> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..68dfde77a87d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2876,6 +2876,7 @@
>  					       nospectre_v2 [X86,PPC,S390,ARM64]
>  					       spectre_v2_user=off [X86]
>  					       spec_store_bypass_disable=off [X86,PPC]
> +					       psfd=off [X86]
>  					       ssbd=force-off [ARM64]
>  					       l1tf=off [X86]
>  					       mds=off [X86]
> @@ -3243,6 +3244,8 @@
>  
>  	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
>  
> +	nopsfd          [HW,X86] Disable mitigation for Predictive Store Forwarding.
> +
>  	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
>  			Equivalent to smt=1.
>  
> @@ -4002,6 +4005,48 @@
>  			that).
>  			Format: <bool>
>  
> +        psfd=		[HW,X86]
> +                        Predictive Store Forwarding Disable control
> +
> +                        Certain AMD processors feature a new technology called Predictive
> +                        Store Forwarding. This feature is designed to improve the
> +                        performance of code execution by predicting dependencies
> +                        between loads and stores.
> +
> +                        Modern processors implement techniques to optimize the
> +                        execution of a load instruction to an address that was
> +                        recently written by a store instruction.
> +
> +                        PSF expands on the above by speculating on the relationship
> +                        between loads and stores without waiting for address
> +                        calculation to complete. With PSF, CPU learns over time the
> +                        relationship between loads and stores.
> +
> +                        Incorrect PSF predictions can occur for various reasons.
> +                        Please see the AMD PSF whitepaper for more information.
> +
> +                        All AMD processors that implement PSF also provide ability
> +                        to control mitigation of PSF.
> +
> +                        Following options are provided to control PSF mitigation.
> +
> +                        The options are:
> +                        on      - Unconditionally disable Speculative Store Bypass

			                                     PSF.

> +                        off     - Unconditionally enable Speculative Store Bypass

			                                    PSF.

> +                        auto    - Kernel detects whether the CPU is vulnerable.
> +                                  If the CPU is not vulnerable, off is selected.
> +                                  If the CPU is vulnerable, default mitigation is
> +                                  KConfig dependent.
> +                        prctl   - Control Predictive Store Forwarding per thread
> +                                  via prctl. Predictive Store Forwarding is enabled
> +                                  per process by default. The state of the control
> +                                  is inherited on fork.
> +                        seccomp - Same as prctl above but all seccomp threads will
> +                                  disable PSF unless they opt out.
> +
> +                        Default mitigations:
> +                        [X86] If CONFIG_SECCOMP=y "seccomp" else "prctl"
> +
>  	psi=		[KNL] Enable or disable pressure stall information
>  			tracking.
>  			Format: <bool>
> 


-- 
~Randy

