Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E78843C976
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbhJ0MVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241894AbhJ0MVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:21:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51270C061243
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 05:19:13 -0700 (PDT)
Received: from zn.tnic (p200300ec2f161500de850afe3c1188c4.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1500:de85:afe:3c11:88c4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CFAC91EC0602;
        Wed, 27 Oct 2021 14:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635337151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vsVX54iamSqF8EqMqhMff/1IYYGj1jxaET3s56qWpSM=;
        b=JetjZbaEOtDjwhfyfi8AbnoEMhCb/CVLigHWsv0vFUZ79EumhPjnUj1Tie7TBKnCzdjwhD
        DXqV3jezLY4mwCJe1ZqygneGbPPFIVgnlnpWJNlvkOatAT0kQYly7gHyMNm9Xc+2NlMYr0
        0wqb+SCw8JM2h9xOxk/1CTrx4yxwpXs=
Date:   Wed, 27 Oct 2021 14:19:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V4 01/50] x86/entry: Add fence for kernel entry swapgs in
 paranoid_entry()
Message-ID: <YXlDu38aFAeBut5k@zn.tnic>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
 <20211026141420.17138-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026141420.17138-2-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:13:31PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Commit 18ec54fdd6d18 ("x86/speculation: Prepare entry code for Spectre
> v1 swapgs mitigations") adds FENCE_SWAPGS_{KERNEL|USER}_ENTRY
> for conditional swapgs.  And in paranoid_entry(), it uses only
> FENCE_SWAPGS_KERNEL_ENTRY for both branches.  It is because the fence
> is required for both cases since the CR3 write is conditinal even PTI
> is enabled.
> 
> But commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in
> paranoid entry") switches the code order and changes the branches.
> And it misses the needed FENCE_SWAPGS_KERNEL_ENTRY for user gsbase case.
> 
> Add it back.
> 
> Fixes: Commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in paranoid entry")
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_64.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index e38a4cf795d9..1f98188e83ef 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -898,6 +898,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
>  	rdmsr
>  	testl	%edx, %edx
>  	jns	.Lparanoid_entry_swapgs
> +	FENCE_SWAPGS_KERNEL_ENTRY

Wouldn't it be cleaner to simply move the FENCE up from under the swapgs
to before the jns instruction?

This way you kill speculation for both cases and have a single fence.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
