Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032144390E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJYINp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:13:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43080 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhJYINo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:13:44 -0400
Received: from zn.tnic (p200300ec2f0f4e000a452ba2b8b488bc.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4e00:a45:2ba2:b8b4:88bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ACEF81EC0531;
        Mon, 25 Oct 2021 10:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635149481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XerDelKnQnqFUpKBVbfntjCEOx/QIs8AQ8RjCfFUIz0=;
        b=WeiZjF65sQFmHWqSIHTvI+30LWday5ReA9mLZHnn94LWEQKkMQXQ7UI5wkAXeC0qCc9QQZ
        7Vq1CuFlUiKA+b3O4Y2mIEDPYV3niRu8lkVJpwGTWW9DcUUG/o66EabCv6q+ZvjCe+7UXx
        bOuCx3GKfg+geYl2hMixcBPHXaF5y7g=
Date:   Mon, 25 Oct 2021 10:11:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, arjan@linux.intel.com,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH 15/23] x86/fpu: Add sanity checks for XFD
Message-ID: <YXZmqF3KlHZBrdgn@zn.tnic>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
 <20211021225527.10184-16-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211021225527.10184-16-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 03:55:19PM -0700, Chang S. Bae wrote:
> @@ -217,12 +240,15 @@ static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64
>   * Restore xstate from kernel space xsave area, return an error code instead of
>   * an exception.
>   */
> -static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
> +static inline int os_xrstor_safe(struct fpstate *fpstate, u64 mask)
>  {
> +	struct xregs_state *xstate = &fpstate->regs.xsave;
>  	u32 lmask = mask;
>  	u32 hmask = mask >> 32;
>  	int err;
>  
> +	/* Must enforce XFD update here */
> +

<--- something's missing here?

>  	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
>  		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
>  	else
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
