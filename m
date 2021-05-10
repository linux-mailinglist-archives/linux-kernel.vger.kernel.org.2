Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9854E3798A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhEJU53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:57:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38952 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhEJU52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:57:28 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620680182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QI2XiZeCcNmeLCPqZlw0tnyYr49HQjf3MYgn71vGV4Q=;
        b=mU53LUkGmtti1buebdCwqysTEhl4rxmD6sDD9M8uzWoul9ozgYlXnL9+IdQR/zg4TGHyYn
        YnAj8EAxRqYAo9hmeGgbETTxA3tmfCUDFU4KCpzxxMjSylRhUBfhKOPDsB7h3hK7Jct9PJ
        o0Qb5jYFJKFpHSEFzTnmbXHK5ivTwKR8wA6S92kevwvynug0tykYf9GRBqt6J2rfRUP92t
        T43IkJfZO4A+xa4zZgb1uNGdSa4i2HCo+TpI3KGWHlkRd1P6pdEEBbrKjW+GQWOoAzRdg3
        +A4cAUmPQdvyEEPa5MX30pVFyOdDW3z2UdJxGAexbuq0m0CooaMQ5N1ml99zCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620680182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QI2XiZeCcNmeLCPqZlw0tnyYr49HQjf3MYgn71vGV4Q=;
        b=IQkaN5IueAzs7kYtcRIcDpjCxCP8GJbJhZStdvUF/5dmfZ3YQL3lABgFzp7cpkDk8jwWlr
        CrTnSAmlq1/jN9CQ==
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH] sh: remove unused variable
In-Reply-To: <c4ec09f0-8742-06ba-a213-063c40d2f98a@gmail.com>
References: <20210414170517.1205430-1-eric.dumazet@gmail.com> <c4ec09f0-8742-06ba-a213-063c40d2f98a@gmail.com>
Date:   Mon, 10 May 2021 22:56:21 +0200
Message-ID: <87sg2ugvey.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10 2021 at 22:11, Eric Dumazet wrote:
> On 4/14/21 7:05 PM, Eric Dumazet wrote:
>> From: Eric Dumazet <edumazet@google.com>
>>=20
>> Removes this annoying warning:
>>=20
>> arch/sh/kernel/traps.c: In function =E2=80=98nmi_trap_handler=E2=80=99:
>> arch/sh/kernel/traps.c:183:15: warning: unused variable =E2=80=98cpu=E2=
=80=99 [-Wunused-variable]
>>   183 |  unsigned int cpu =3D smp_processor_id();
>>=20
>> Fixes: fe3f1d5d7cd3 ("sh: Get rid of nmi_count()")
>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Frederic Weisbecker <frederic@kernel.org>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> ---
>>  arch/sh/kernel/traps.c | 1 -
>>  1 file changed, 1 deletion(-)
>>=20
>> diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
>> index f5beecdac69382f2d719fa33d50b9d58e22f6ff8..e76b221570999776e3bc9276=
d6b2fd60b9132e94 100644
>> --- a/arch/sh/kernel/traps.c
>> +++ b/arch/sh/kernel/traps.c
>> @@ -180,7 +180,6 @@ static inline void arch_ftrace_nmi_exit(void) { }
>>=20=20
>>  BUILD_TRAP_HANDLER(nmi)
>>  {
>> -	unsigned int cpu =3D smp_processor_id();
>>  	TRAP_HANDLER_DECL;
>>=20=20
>>  	arch_ftrace_nmi_enter();
>>=20
>
> Is there anything wrong with this patch ?

No. I was expecting that it gets picked up by sh folks. Let me take care
of it as I introduced that issue after all.

Thanks,

        tglx
