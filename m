Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EC933405B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhCJO2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhCJO16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:27:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C86C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:27:58 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a9900452923910729ca7d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9900:4529:2391:729:ca7d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 325911EC026F;
        Wed, 10 Mar 2021 15:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615386477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ttfTjP2mc2NJJolPrw5G/H4gc7B5Dvgh5Pc2Z3g4DpA=;
        b=G784EB3nGQcdzbE411YJBthr26JHN+gLIXa9Mev0eBrSU7eI4sjreG0NMvN+zNNB54YtHy
        i0jxQFrSMbo47kN4XHS8n7NOZcgZya/AeZtPKe2DkA78ZC7wsMhTyfqjR8mbzAWexYvenm
        xLXKKRRIdxC2CTowlvkgT/jaa0sGEaU=
Date:   Wed, 10 Mar 2021 15:27:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 05/12] x86/alternative: support ALTERNATIVE_TERNARY
Message-ID: <20210310142754.GH23521@zn.tnic>
References: <20210309134813.23912-1-jgross@suse.com>
 <20210309134813.23912-6-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309134813.23912-6-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 02:48:06PM +0100, Juergen Gross wrote:
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 89889618ae01..4fb844e29d26 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -178,6 +178,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
>  	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
>  	".popsection\n"
>  
> +#define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr1, newinstr2)	\
> +	ALTERNATIVE_2(oldinstr, newinstr2, X86_FEATURE_ALWAYS, newinstr1, feature)

Make that:

/*
 * If @feature is set, patch @newinstr_yes, else @newinstr_no
 */
#define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
        ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS, newinstr_yes, feature)

and in alternative-asm.h too pls.

Regardless, this looks nice! :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
