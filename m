Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE533A4AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 00:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFKWOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 18:14:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFKWOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 18:14:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623449542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ah3TBIuHhKSOPKVyDmoqh3phJuiLGLjdjcmSXr7zZjw=;
        b=bzmH5Ki82WoDvbvj4T6igPTQqMJDtdK/gmJ2llALfUUFVU8kFilwmIUc1zE1Vfm1ff+5ZX
        LaizN3sR4Qw9VTOQi75KLjoZVoZAWE39ebYkG/zUEqhyPWlZcpx0fx5phFPrPjIOd9Ry1o
        DG/m1vxr9XxnsuVv4xXzHhIE+QkWmXvX5Eo6UzwPoc/w4WuXD0tsbXT8mwpmroEUtuUPlV
        yHar5uZHqMxbOn6jIggtyXZpWG9fU5yXcR4lnqV4yCEgnlCxWuqGsspfsJLZavwqumC6QT
        3llFh80WaoZiBOYxBtKaip1yWqTclFRfmWd77jOWDFGnAHmobTPTIr6I8zf14w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623449542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ah3TBIuHhKSOPKVyDmoqh3phJuiLGLjdjcmSXr7zZjw=;
        b=zZtMq+oZhTMy5NiZqIceK79a1tyFvaWxuQ5t2FuJG98T0i/ruuI/uNdXM2QIiCHR1pqBpC
        s/plee4I7JRr9nAQ==
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch 08/41] x86/fpu: Restrict fpstate sanitizing to legacy components
In-Reply-To: <2be2ef6c-fcb8-46cf-976c-2b3a9537b660@kernel.org>
References: <20210611161523.508908024@linutronix.de> <20210611163111.820639606@linutronix.de> <2be2ef6c-fcb8-46cf-976c-2b3a9537b660@kernel.org>
Date:   Sat, 12 Jun 2021 00:12:21 +0200
Message-ID: <874ke4vynu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2021 at 12:03, Andy Lutomirski wrote:
> On 6/11/21 9:15 AM, Thomas Gleixner wrote:
>> + *
>> + * This is required for the legacy regset functions.
>> + */
>> +static void fpstate_sanitize_legacy(struct fpu *fpu)
>> +{
>> +	struct fxregs_state *fx = &fpu->state.fxsave;
>> +	u64 xfeatures;
>> +
>> +	if (!use_xsaveopt())
>> +		return;
>
> This is confusing, since we never use xsaveopt.  It's also wrong -- see
> above.  How about just removing it?

We do and this code is buggy because xsaves does not clear the component
storage either. Neither does xsavec which we in fact do not use in the
kernel.

So here is how the different opcodes behave on a buffer filled with 0xff
when looking the first four 64bit words of the buffer after doing a
xrstor with all feature bits cleared

Intel SKLX
 
XSAVE    000000000000037f 0000000000000000 0000000000000000 0000ffff00001f80
XSAVEOPT ffffffffffffffff ffffffffffffffff ffffffffffffffff 0000ffff00001f80
XSAVEC   ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
XSAVES   ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff

AMD ZEN2

XSAVE    000000000000037f 0000000000000000 0000000000000000 0002ffff00001f80
XSAVEOPT ffffffffffffffff ffffffffffffffff ffffffffffffffff 0002ffff00001f80
XSAVEC   ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
XSAVES   ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff

I verified that all saved buffers have xstate.header.xstate_bv == 0

So nothing about any of this is consistent and correct. But it magically
works for unknown reasons.

Thanks,

        tglx



