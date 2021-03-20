Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071D33429A4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 02:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCTBaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 21:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhCTBap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:30:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9BCC061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 18:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=owb16Ov7R83Y7teUPDpOK0Va5vo7qBUM0louNeHSMxM=; b=uay7dEjB02inYboNEJY+fKl/LU
        zwnsWK++qtSQ3IjFAJmm5dDE1cQL+lYokBJpI3JCYQE1eBB3n48yCbl+k0vegSakJQUYC8uvrzKZw
        2t5TahcqvrAqOJrAulHP1TaibHU/q8Vr6oy1hqFz59Z/TghdfKr8WRg9lyUVi8CYv0i+ep4hdMoYL
        i2DYc4h6loJubVeQJjo506M2abGYqjwQ4PGaufs99sOAocOwhVHIu8hNmx5pVoPlMmCcBACeMpTbL
        rWXHDGFz/dV2hFWgdyidr/rxbBqPtyKwyVhj6g13ytE1LkSMHRjPyF/L1RIexyNWFko5h8a0Gcg8m
        Ewm/Et9w==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNQRt-001e1G-56; Sat, 20 Mar 2021 01:30:42 +0000
Date:   Fri, 19 Mar 2021 18:30:41 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     catalin.marinas@arm.com, will@kernel.org,
        anshuman.khandual@arm.com, suzuki.poulose@arm.com,
        gustavoars@kernel.org, vincenzo.frascino@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cpuinfo: Fix a typo
In-Reply-To: <20210319222848.29928-1-unixbhaskar@gmail.com>
Message-ID: <acc3419e-849b-d11e-c945-16ef37ec0a8@bombadil.infradead.org>
References: <20210319222848.29928-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_183041_216275_A388A768 
X-CRM114-Status: GOOD (  12.26  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote: > > s/acurate/accurate/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/acurate/accurate/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> arch/arm64/kernel/cpuinfo.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 77605aec25fe..51fcf99d5351 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -353,7 +353,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
> 	 * with the CLIDR_EL1 fields to avoid triggering false warnings
> 	 * when there is a mismatch across the CPUs. Keep track of the
> 	 * effective value of the CTR_EL0 in our internal records for
> -	 * acurate sanity check and feature enablement.
> +	 * accurate sanity check and feature enablement.
> 	 */
> 	info->reg_ctr = read_cpuid_effective_cachetype();
> 	info->reg_dczid = read_cpuid(DCZID_EL0);
> --
> 2.26.2
>
>
