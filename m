Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E814F3AB0C7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFQKCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhFQKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:02:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:00:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e7so2654456plj.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=27sMd2moHgzQvQjtsTsdW0WmOcaUMLnHlf1rpJWHkIk=;
        b=p0wXy2XYJozttoKUdpv21S9gx/9ogI4iB9q9kzw57Bzqa50zF02B0SiLYejvEPOVuK
         XIvpwUMDLvlefk4PD0kgUTjdNxcyT17PP/uKDkiMkJCCRe22c4GduYAwwP0xwXURixRF
         8xakFRh7YhcSXbIC7uiXlZNMZZoHAiNdjYRcQVnBimrh5IwD6fcW5/b8M4jl+iBh/9VQ
         DcQG8x7oq9JBj6qND+PHLJZLyjVK0hOY+MOrh95BLW5gycoruHhs4CSpP13J0HeIVt67
         WCIVck+20ad2dzzftLph4nrHlqsw8cQW1FKVzp3SMLFdAGEB94snZCeSE8bqZuA44KZe
         Xhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=27sMd2moHgzQvQjtsTsdW0WmOcaUMLnHlf1rpJWHkIk=;
        b=HQYK+jjznA+cuUw9AIalsEOaR56bTjfT319qbUeHyH6xwZghyXJd3858bHizIj0N/q
         PNJPFSCoWCoqOT7Fb5E3r8dJo1AN2VoZUI900e4EUf5K7he07zidwLQwm7T3EpgEI/oP
         xL4QQjmlNavZZh6YJsSHukJrZ5Mb3coBoRmU8Go+OAvLQgQgIxNg2uvOOJFAjlzFHEhE
         y/6uus6yjTpu9DPafjVZ7rh6d1pCcDMNVd2Q1D9NPVFWzSwOrssNfhRlriVPXAzrCIfZ
         uII0HMD/jbqcTmvXnvUFUDvVO0NXqAgdNOARHv2oWumO/EtSEzksi2mJznN7miLqKGvS
         iZUg==
X-Gm-Message-State: AOAM533MEGFt9J2/1RAw023krwhdMvtJgETETeqYQ2moZP6FZyVg9reB
        3tcCvHWoW5OSK8BQkaSpMUI=
X-Google-Smtp-Source: ABdhPJxxuh69FWPW4fUP0ExfHicJfooHaJwLOUNdovwUAzKmPk5QGOjkIDV9iiUXaYD8zSk0gUCpNw==
X-Received: by 2002:a17:90a:a087:: with SMTP id r7mr16033072pjp.84.1623924027936;
        Thu, 17 Jun 2021 03:00:27 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id t1sm4659988pjs.20.2021.06.17.03.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:00:27 -0700 (PDT)
Date:   Thu, 17 Jun 2021 20:00:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC][PATCH] sched: Use lightweight hazard pointers to grab lazy
 mms
To:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        the arch/x86 maintainers <x86@kernel.org>
References: <cover.1623813516.git.luto@kernel.org>
        <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
        <1623816595.myt8wbkcar.astroid@bobo.none>
        <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
        <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
        <1623893358.bbty474jyy.astroid@bobo.none>
        <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
        <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
        <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
        <YMsRgfKbcaW66/99@hirez.programming.kicks-ass.net>
In-Reply-To: <YMsRgfKbcaW66/99@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1623923470.ex9n1iunep.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Peter Zijlstra's message of June 17, 2021 7:10 pm:
> On Thu, Jun 17, 2021 at 11:08:03AM +0200, Peter Zijlstra wrote:
>> On Wed, Jun 16, 2021 at 10:32:15PM -0700, Andy Lutomirski wrote:
>=20
>> --- a/arch/x86/include/asm/mmu.h
>> +++ b/arch/x86/include/asm/mmu.h
>> @@ -66,4 +66,9 @@ typedef struct {
>>  void leave_mm(int cpu);
>>  #define leave_mm leave_mm
>> =20
>> +/* On x86, mm_cpumask(mm) contains all CPUs that might be lazily using =
mm */
>> +#define for_each_possible_lazymm_cpu(cpu, mm) \
>> +	for_each_cpu((cpu), mm_cpumask((mm)))
>> +
>> +
>>  #endif /* _ASM_X86_MMU_H */
>=20
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 8ac693d542f6..e102ec53c2f6 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -19,6 +19,7 @@
>> =20
>=20
>> +
>> +#ifndef for_each_possible_lazymm_cpu
>> +#define for_each_possible_lazymm_cpu(cpu, mm) for_each_online_cpu((cpu)=
)
>> +#endif
>> +
>=20
> Why can't the x86 implementation be the default? IIRC the problem with
> mm_cpumask() is that (some) architectures don't clear bits, but IIRC
> they all should be setting bits, or were there archs that didn't even do
> that?

There are. alpha, arm64, hexagon (of the SMP supporting ones), AFAICT.

I have a patch for alpha though (it's 2 lines :))

Thanks,
Nick
