Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5692D41D916
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350615AbhI3LvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350609AbhI3LvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:51:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F30C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:49:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e1600628f023c6c6559e3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:1600:628f:23c:6c65:59e3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9BCB1EC026F;
        Thu, 30 Sep 2021 13:49:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633002561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zem8paSl3IEvGjH/9/Yo51pLAsOn7wi/jHVT4rCQ9Vs=;
        b=ZBIGHE2DxneHCUOEePSEe/hMa9iA15d/gfYgdDgS4pYAIXLAcc06ZbdnWjXwLlohQTgcaY
        YssbZ5RtNiKTqVk2uZzoCN8XEaa6ffpjtLV1N8Jnfe1TWGDW4AKK+P+0Z9lMwsDTjFCWDT
        OwgwR0HIws2WBvOaY8k3UjDtufGGJRs=
Date:   Thu, 30 Sep 2021 13:49:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>
Subject: Re: [PATCH V2 04/41] x86/entry: Introduce __entry_text for entry
 code written in C
Message-ID: <YVWkQgQD+j9fT6Ge@zn.tnic>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
 <20210926150838.197719-5-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210926150838.197719-5-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 11:08:01PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Some entry code will be implemented in C files.  We need __entry_text

Who's "we"?

> to set them in .entry.text section.  __entry_text disables instruments

s/instruments/instrumentation/

> like noinstr, but it doesn't disable stack protector since not all
> compiler supported by kernel supporting function level granular
> attribute to disable stack protector.  It will be disabled by C file
> level.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/include/asm/idtentry.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 1345088e9902..6779def97591 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -11,6 +11,9 @@
>  
>  #include <asm/irq_stack.h>
>  
> +/* Entry code written in C. */
> +#define __entry_text __noinstr_section(".entry.text")

I'm assuming that __noinstr_section() is defined somewhere, maybe in
patch 3, which I don't have in my mbox.

Yah, the 0th message says:

"  compiler_types.h: Add __noinstr_section() for noinstr"

Aha, I see why: you haven't CCed me on that one so I don't have it:

https://lkml.kernel.org/r/20210926150838.197719-4-jiangshanlai@gmail.com

I have all the remaining 40 but not that one.

On your next submission, please make sure you CC x86@kernel.org so that
all x86 people get the whole patchset.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
