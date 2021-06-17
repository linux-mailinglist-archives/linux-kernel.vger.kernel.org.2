Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C193AB3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhFQMoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:44:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhFQMox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:44:53 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623933764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9OpitK2tVEcS1zEXdGuPDBM2/hTZoBVVZfLmWxBIwtw=;
        b=OyA+FFTl1/rGAt0gvdMKKnKrzifWUjzPoYSDHfKlZUMy7knsZEF2xHQ7QEu2xa4FUAbRbM
        VihpLqXvN5aXyNn9WNQpEn/nXp2Ap9b6aiG60YLx86cK1zHTLk7s3eWOCh0tP+Eeq94iP4
        +eQ0t53otopqvlIVewPWqjDJPVyVcEuVN60w3fmJN8vIJ2YBiOZIc+cSE9syjmH8x9oinU
        QiQLgrBwmvnBj9niBzLwBTwHtabtd4xEBQYfRDWYkow+g/p0lToevtLG8KN+GZeTUVIeuP
        DtzLjAb8tTaja46F2FomMdcfAiicG2khcye6uqnhGfxF3r5jDZhHQuKuF1l1uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623933764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9OpitK2tVEcS1zEXdGuPDBM2/hTZoBVVZfLmWxBIwtw=;
        b=BXgqGmpnyJmrjl8+B3a9rNmwmfqDyN12Yb+5QqZ/orVNiMCMKOibYWJKxw0rVT5jNUrYvk
        IfLOYKpLBaRjUXDg==
To:     Borislav Petkov <bp@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V2 14/52] x86/fpu: Make copy_xstate_to_kernel() usable for [x]fpregs_get()
In-Reply-To: <YMojMrxr+UwI0cVR@zn.tnic>
References: <20210614154408.673478623@linutronix.de> <20210614155355.143470533@linutronix.de> <YMojMrxr+UwI0cVR@zn.tnic>
Date:   Thu, 17 Jun 2021 14:42:44 +0200
Message-ID: <87wnqsfyrf.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16 2021 at 18:13, Borislav Petkov wrote:

> On Mon, Jun 14, 2021 at 05:44:22PM +0200, Thomas Gleixner wrote:
>> When xsave with init state optimiziation is used then a component's state
>
> 				optimization
>
>> @@ -1062,14 +1062,20 @@ static void copy_feature(bool from_xstat
>>  	membuf_write(to, from_xstate ? xstate : init_xstate, size);
>>  }
>>  
>> -/*
>> - * Convert from kernel XSAVE or XSAVES compacted format to UABI
>> - * non-compacted format and copy to a kernel-space ptrace buffer.
>> +/**
>> + * copy_uabi_xstate_to_membuf - Copy kernel saved xstate to a UABI buffer
>
> If this is what it does, then the function should be called:
>
> copy_xstate_to_uabi_buf()
>
> or so.
>
> "membuf" is only an implementation detail anyway. IMHO.

Yes. Makes sense. Fixed.
