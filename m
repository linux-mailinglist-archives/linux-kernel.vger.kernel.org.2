Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8EF3B1848
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFWK7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:59:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhFWK7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:59:02 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624445803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSRw2o6fZe25+FTw4bxUdNYAwrLxHUJ1pNl7aOVIvtM=;
        b=tkUZj+dECygGSHk0puCOoTHLKhyj+9ivi22N2O8I+YEiJiWNj4JbD+Ctd4LBp6+HnfCpZI
        4lZwl/So0Rlw/RD7X46fyR56ivkQu0Xo5+yNHRThBysYSlKCKygzq2QzYnKeri/djLSdoW
        T/Xe2oMRXjsfypch1Tl+89Sgw5jdwodViWL8fSjEioo4iYZsBRnterfILc3aMlK2TpnA7f
        cQ/ivI9eK01FsOeygXar+v48zwlz3j4oc7xKn8Pdwxn3UZubgelxXDNaSjx3i9Mqc0SF0n
        BsxINBI/kpQkf8kVBTwN2hvSNPuB9lU+6Z34e/REdxiv40c3htv2s5uWPudJMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624445803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSRw2o6fZe25+FTw4bxUdNYAwrLxHUJ1pNl7aOVIvtM=;
        b=2nVvLAezXldeT/3G8MGPqC2b8OcksiEPK3PW4gidP67S1JKQsKVGnRjGy2f5eGOGHDYQTo
        RLkQQ4R3M3UbngCA==
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
Subject: Re: [patch V3 64/66] x86/fpu: Return proper error codes from user access functions
In-Reply-To: <YNLxKB9a6XQHW+w3@zn.tnic>
References: <20210618141823.161158090@linutronix.de> <20210618143451.682092608@linutronix.de> <YNLxKB9a6XQHW+w3@zn.tnic>
Date:   Wed, 23 Jun 2021 12:56:43 +0200
Message-ID: <87lf70df2s.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23 2021 at 10:30, Borislav Petkov wrote:
>> +/* Returns 0 or the negated trap number, which results in -EFAULT for #PF */
>>  #define user_insn(insn, output, input...)				\
>>  ({									\
>>  	int err;							\
>> @@ -94,14 +95,14 @@ static inline void fpstate_init_soft(str
>>  	might_fault();							\
>>  									\
>>  	asm volatile(ASM_STAC "\n"					\
>> -		     "1:" #insn "\n\t"					\
>> +		     "1: " #insn "\n"					\
>>  		     "2: " ASM_CLAC "\n"				\
>>  		     ".section .fixup,\"ax\"\n"				\
>> -		     "3:  movl $-1,%[err]\n"				\
>> +		     "3:  negl %%eax\n"					\
>>  		     "    jmp  2b\n"					\
>>  		     ".previous\n"					\
>> -		     _ASM_EXTABLE(1b, 3b)				\
>> -		     : [err] "=r" (err), output				\
>> +		     _ASM_EXTABLE_FAULT(1b, 3b)				\
>> +		     : [err] "=a" (err), output				\
>>  		     : "0"(0), input);					\
>>  	err;								\
>
> Don't we wanna do the same for XSTATE_OP() too?
>
> Because restore_hwregs_from_user() could call
> xrstor_from_user_sigframe() too which ends up doing XRSTOR and latter
> can cause a #PF too.

Bah, right you are.
