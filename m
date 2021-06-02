Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E96398C8B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhFBOVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhFBOUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:20:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE749C061343
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:15:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622643311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OiC947Q2dhRoFMhU4hnm3hnzs9cb7ezMk8IdRSSaldc=;
        b=ZTQh1SU8XI4cIVAojGZOkZQdc/4otLiETCCv01ttQB7qRZ4CaCc38o37ecDKcq7sU2GXMt
        0nQSqapYFve1Le47Ob5uNXe+FK1GAntPdiezQKOS6bZc2dryLtBGxJtRH5ESBE85aDNAfH
        35BTv0jijvcf6/Rwz9Zew+5XO6s/vZyiZlJ16MH/zWuQ7fTqTtntJjCrhcwhSM55Ne5Gec
        qM0ckvVMDkXPNQldisD3uTZzAZvRsfTwV5TOLMkY59QenIjF9SzmAeejeWB8kFzk5hhqIj
        Zk2tWYPHkgxvUgF5eXCXQdsZynKmXHAnuCnREANkU2fuKLmCAY2oLxoixLQuug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622643311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OiC947Q2dhRoFMhU4hnm3hnzs9cb7ezMk8IdRSSaldc=;
        b=7rw1fcYB6QhwyTvK4mHIXSPKbHP1Jlq6GhSw0DLx6weiHfGVs+VSS5x+BD/PSNb2gntIY2
        D46ubLXhpb6ViGCQ==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [patch 1/8] selftests/x86: Test signal frame XSTATE header corruption handling
In-Reply-To: <YLd7s/cw8MsUlWvM@zn.tnic>
References: <20210602095543.149814064@linutronix.de> <20210602101618.285452223@linutronix.de> <YLd7s/cw8MsUlWvM@zn.tnic>
Date:   Wed, 02 Jun 2021 16:15:11 +0200
Message-ID: <87a6o81hg0.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02 2021 at 14:38, Borislav Petkov wrote:
> On Wed, Jun 02, 2021 at 11:55:44AM +0200, Thomas Gleixner wrote:
>> From: Andy Lutomirski <luto@kernel.org>
>> 
>> This is very heavily based on some code from Thomas Gleixner.  On a system
>> without XSAVES, it triggers the WARN_ON():
>> 
>>     Bad FPU state detected at copy_kernel_to_fpregs+0x2f/0x40, reinitializing FPU registers.
>
> That triggers
>
> [  149.497274] corrupt_xstate_[1627] bad frame in rt_sigreturn frame:00000000dad08ab1 ip:7f031449ffe1 sp:7ffd0c5c59f0 orax:ffffffffffffffff in libpthread-2.31.so[7f0314493000+10000]
>
> on an AMD laptop here.

Yes, that's the ratelimited printk in the signal code.

>> +static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
>> +			   unsigned int *ecx, unsigned int *edx)
>> +{
>> +	asm volatile(
>> +		"cpuid;"
>> +		: "=a" (*eax),
>> +		  "=b" (*ebx),
>> +		  "=c" (*ecx),
>> +		  "=d" (*edx)
>> +		: "0" (*eax), "2" (*ecx));
>> +}
>> +
>> +static inline int xsave_enabled(void)
>> +{
>> +	unsigned int eax, ebx, ecx, edx;
>> +
>> +	eax = 0x1;
>> +	ecx = 0x0;
>> +	__cpuid(&eax, &ebx, &ecx, &edx);
>> +
>> +	/* Is CR4.OSXSAVE enabled ? */
>> +	return ecx & (1U << 27);
>> +}
>
> One fine day someone should sit down and unify all those auxillary
> functions used in the selftests into a lib...

Yes please. Shuah, that would be a great newcomer task...

>> +
>> +int main()
>
> ERROR: Bad function definition - int main() should probably be int main(void)

Bah, I thought I had fixed that.

