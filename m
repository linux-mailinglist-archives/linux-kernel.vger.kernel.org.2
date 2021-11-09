Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9836E44B51B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhKIWH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:07:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhKIWH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:07:58 -0500
Received: from zn.tnic (p200300ec2f18aa00aec912b1b11fde1a.dip0.t-ipconnect.de [IPv6:2003:ec:2f18:aa00:aec9:12b1:b11f:de1a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB68F1EC0399;
        Tue,  9 Nov 2021 23:05:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636495510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Hs94rUgeZ2VvaoKiTf4Jbb/sMwdZcSbUHieuZ19TcqA=;
        b=fU2PxbWCidirYisZ6OjPd6JrMnrj1HtVgU+MeP0yTcnivfn+RE+Ijmn42EDMbA7ChaR9J7
        hVD5lFRAigc4uF4/NT8hFRjmyS5XnOo+lPKqvlCvgcGcuGdS5ZoCvrssN0uNZ1BijRWnkr
        TX7zwKlwrh8Rmn8ve7yib/riWLiMhPU=
Date:   Tue, 9 Nov 2021 23:05:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v0 05/12] x86/mce: Allow instrumentation during task work
 queueing
Message-ID: <YYrwkKANAz/Qj17f@zn.tnic>
References: <20211104144035.20107-1-bp@alien8.de>
 <20211104144035.20107-6-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104144035.20107-6-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 03:40:28PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Fixes
> 
>   vmlinux.o: warning: objtool: do_machine_check()+0xdb1: call to queue_task_work() leaves .noinstr.text section
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index c7181e8e2845..65a8be420aff 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1451,6 +1451,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  	if (worst != MCE_AR_SEVERITY && !kill_current_task)
>  		goto out;
>  
> +	instrumentation_begin();

<peterz> so it might be nice to have a comment with each sandwich to
say why sh*t won't go sideways when instrumentation happens in the #MC
at that point
<peterz> like this shuts things up, but really we don't want
instrumentation here either, except blah

note to self: will need to go through the whole set.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
