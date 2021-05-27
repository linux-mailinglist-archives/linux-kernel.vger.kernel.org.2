Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F118A392D15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhE0LvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhE0LvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:51:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B7C061574;
        Thu, 27 May 2021 04:49:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622116183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpJO8/wUONUzp+lF25GXIlQ0ASXxx+GAXWN69tVWybM=;
        b=luSN3hdXA90fnIwYe7NygmIBDq9maKK/qrasbv8wHHA5XtNPKkZtE/AQalBVLJ52L9XBKW
        XwjBkHd6nuCkrKdQ4tVJ6DggzAkQtFt0eDTJjZCXEHap1GjFIrsTXcMPVniTgUALV3FPxG
        2w4uarEfDk6diyXvdyUJb7SBWSuQigNEfLsmEl7kPgsH/gKQLB7mtfEeo70E2B2CPfIIVE
        jGj2lWJMFhapo20dLtLULSamX+NTLZJYbfKuwyWbJFG7PfSJNx2SgljCRJj6fQH6Ldi806
        xrzBfHF+dqzXkufsY28zBnh9TIgYjaN4igXiIOhLDcNgsxtqggeVshvvsd+9hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622116183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KpJO8/wUONUzp+lF25GXIlQ0ASXxx+GAXWN69tVWybM=;
        b=6lIJmAPeNZzRVa7qPhy+UsX4TXKyKEUoXs1xxXMM3hjbDoHKXPA5ugrTGWG+WKhp1VezHc
        juA0Ssr9VxsIO8CQ==
To:     Borislav Petkov <bp@suse.de>, James Feeney <james@nurealm.net>
Cc:     linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86-ml <x86@kernel.org>
Subject: Re: [PATCH] x86/thermal: Fix LVT thermal setup for SMI delivery mode
In-Reply-To: <YK905sC/2cVOYo6I@zn.tnic>
References: <YKWAt1zLM2vfv4Sp@zn.tnic> <e7701de5-35f3-da9d-7339-df2de6d8b3cf@nurealm.net> <YKYqABhSTTUG8cgV@zn.tnic> <a264eaef-1c94-77e1-dfbf-e436a41588be@nurealm.net> <YKjJfu4kRDflQS5e@zn.tnic> <373464e3-b8a0-0fe0-b890-41df0eecf090@nurealm.net> <YKqLSqIM7Gi5x+IA@zn.tnic> <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net> <YKtbBXZGpVZS1M4R@zn.tnic> <1f6c70f4-6680-d6ea-465a-548dc7698317@nurealm.net> <YK905sC/2cVOYo6I@zn.tnic>
Date:   Thu, 27 May 2021 13:49:42 +0200
Message-ID: <87h7io8kh5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27 2021 at 12:31, Borislav Petkov wrote:
> @@ -1226,6 +1227,14 @@ void __init setup_arch(char **cmdline_p)
>  
>  	x86_init.timers.wallclock_init();
>  
> +	/*
> +	 * This needs to run before setup_local_APIC() which soft-disables the
> +	 * local APIC temporarily and that masks the thermal LVT interrupt,
> +	 * leading to softlockups on machines which have configured SMI
> +	 * interrupt delivery.
> +	 */
> +	therm_lvt_init();

That works, but TBH, it's a hack....

What I really fail to understand is how disabling that LVT entry makes
the machine lock up. 

Also if disabling this entry is causing the BIOS/SMM gunk to go south, then
disabling CONFIG_X86_THERMAL_VECTOR should have the same effect.

Which made me look at other places like lapic_suspend/resume which does
the save/restore Kconfig conditional as well.

Thanks,

        tglx





