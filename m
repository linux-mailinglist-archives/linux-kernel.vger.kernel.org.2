Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4081A34246F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhCSSRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhCSSQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:16:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE63AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:16:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616177809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVm/M1wNCF3Em/pKHELvCrZvvRoZ57O1vHAbw8cUDNs=;
        b=K8LGrGZFGv2dSD8WaSVakBF8vnP2BksDLfbbWvrvqrSlyB9scuICGuwA9/nM765JTsuJG2
        pXdalMrzaIaFLuIWJEvic4IzWXg9BFzMq+rUu3g5WOo2/VhKGCKRERJZJ5BUAwjb/0vssM
        I2nYAJLGmAYiQbQoPdxzNLT7fU0Q9rinVU4gdg8+0VVewMgS+MfWXdsOM33FM3nzlESZ9t
        ESo1HRASJ/ijTt98SrR/5wn2GeEVZzi9Tzd6MrPWSwBHMf3FJqpe9K9F2PfFQnn6d0weN3
        tDjr7kKH6uwrye12QeLHTBmjMSWTaj+k9+XMHacJNJpk+ZFl7E9j92f4mCQxnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616177809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVm/M1wNCF3Em/pKHELvCrZvvRoZ57O1vHAbw8cUDNs=;
        b=kVG9GVlz5IGK5BremcbgC+gQfs9Tq8dccyWXxDLJBff5LRqP7ld0UvP/iQ8MucCrrdQrf6
        G9rJWODCIErqBdAw==
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 7/9] kentry: Add debugging checks for proper kentry API usage
In-Reply-To: <87pmzv5d90.fsf@nanos.tec.linutronix.de>
References: <cover.1616004689.git.luto@kernel.org> <df38bc3aa82dc122c88bf902f6922ab7c22bf783.1616004689.git.luto@kernel.org> <87pmzv5d90.fsf@nanos.tec.linutronix.de>
Date:   Fri, 19 Mar 2021 19:16:48 +0100
Message-ID: <87h7l757qn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19 2021 at 17:17, Thomas Gleixner wrote:

> On Wed, Mar 17 2021 at 11:12, Andy Lutomirski wrote:
>> +
>> +#define DEBUG_ENTRY_WARN_ONCE(condition, format...) do {} while (0)
>
> So we have a stub for !DEBUG
>
>> +static __always_inline void kentry_cpu_depth_add(unsigned int n) {}
>> +static void kentry_cpu_depth_check(unsigned int n) {}
>> +static __always_inline void kentry_cpu_depth_sub(unsigned int n) {}
>> +
>> +#endif
>> +
>>  /* See comment for enter_from_user_mode() in entry-common.h */
>>  static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
>>  {
>> +	kentry_cpu_depth_add(1);
>>  	arch_check_user_regs(regs);
>>  	lockdep_hardirqs_off(CALLER_ADDR0);
>>=20=20
>> @@ -22,6 +78,14 @@ static __always_inline void __enter_from_user_mode(st=
ruct pt_regs *regs)
>>=20=20
>>  	instrumentation_begin();
>>  	trace_hardirqs_off_finish();
>> +
>> +#ifdef CONFIG_DEBUG_ENTRY
>
> Why do we need that #ifdeffery all over the place?
>
>> +	DEBUG_ENTRY_WARN_ONCE(
>> +		this_cpu_read(kentry_cpu_depth) !=3D 1,
>> +		"kentry: __enter_from_user_mode() called while kentry thought the CPU=
 was in the kernel (%u)",
>> +		this_cpu_read(kentry_cpu_depth));

Because you directly access kentry_cpu_depth which makes the compiler
unhappy.

And of course at the other place where you guard it with IS_ENABLED() it
fails to build with CONFIG_DEBUG_ENTRY=3Dn

kernel/entry/common.c:158:10: error: =E2=80=98struct task_struct=E2=80=99 h=
as no member named =E2=80=98kentry_in_syscall=E2=80=99
   current->kentry_in_syscall =3D true;

This is V4 of this series... Oh well.

     tglx
