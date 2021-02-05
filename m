Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D93310AE2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBEMHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhBEMEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:04:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99AFC061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:03:38 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bad00ff9d6d5b91facfca.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ad00:ff9d:6d5b:91fa:cfca])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73CF71EC030F;
        Fri,  5 Feb 2021 13:02:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612526566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sKxM3ZrxvQUzR3JycrEdrI/8jyBLCDgk1CkoAaj5SSs=;
        b=K+PS6/Tv06ySifmoob52mksbJAOoDnXEsKabYYxN4cmyEKQnZWdctsyNElrgB6F3q7aQuO
        bsBF8ATPCII8npUABzL4lzW90E7iftEzyOPLFma3RwpSpJEBwONY+ltauYjQ0n+R0pC+e+
        RD/SCEo+UXB3JDEo3u9aHgkez7snj5o=
Date:   Fri, 5 Feb 2021 13:02:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 01/12] x86/entry: Fix instrumentation annotation
Message-ID: <20210205120244.GE17488@zn.tnic>
References: <20210204204903.350275743@linutronix.de>
 <20210204211154.091926005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204211154.091926005@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:49:04PM +0100, Thomas Gleixner wrote:
> Embracing a callout into instrumentation_begin() / instrumentation_begin()
> does not really make sense. Make the latter instrumentation_end().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -270,7 +270,7 @@ static void __xen_pv_evtchn_do_upcall(vo
>  
>  	instrumentation_begin();
>  	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
> -	instrumentation_begin();
> +	instrumentation_end();
>  
>  	set_irq_regs(old_regs);

Cc: <stable@vger.kernel.org> ?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
