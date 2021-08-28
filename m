Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A773FA631
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhH1OI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 10:08:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhH1OI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 10:08:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630159655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=It4Lds59IjUbHF19nJTRlAWmtvD1xmA9F7P5RHXxWlI=;
        b=HGwbiGMRcZNAzkvRkLtgrTdn52xAH1NQI2g3+fRV9g2eKf8pG3B3efhWFjpuM8EvmUZrE/
        1HiXmI5jtDmi3hGgmSxs3rMs8r87dT8j26hC9h4skX56yZD4IJ5bNm/F5cqJcyHhxFfqca
        T8rMkKgCQDuBMcM7aZG/hL4xgF39FW1yXT4uYS5eoiczEzY4Q02GYdGlvdFJ10QwFMFq+f
        eJ3cwxszfL9vcQUfwbHf3cXLNSSAzN8rEHO3n9VaJfKym9L47WJAO+AxES77wvhinaRfkN
        5YgmChrFoFTRLRXeWYo9pkalB+aCAPxfjeBMywJnxjkPf1Yt4rQWE3QQwzbOqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630159655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=It4Lds59IjUbHF19nJTRlAWmtvD1xmA9F7P5RHXxWlI=;
        b=QpT2F+LG4109YgJvvGCDquOSmu7mgSLePGIE/3mao0StIrldmKBfmNQF9JwHgFOHW+CaiJ
        xSEi613rOQ8DQ8DA==
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH,RESEND] softirq: Introduce SOFTIRQ_FORCED_THREADING
In-Reply-To: <AJ*AdQAQD9tzCOr4iYm-E4pL.3.1630117097688.Hmail.wangqing@vivo.com>
References: <AJ*AdQAQD9tzCOr4iYm-E4pL.3.1630117097688.Hmail.wangqing@vivo.com>
Date:   Sat, 28 Aug 2021 16:07:34 +0200
Message-ID: <87wno5hdcp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qing,

On Sat, Aug 28 2021 at 10:18, =E7=8E=8B=E6=93=8E wrote:
>> On Mon, Aug 23 2021 at 11:33, Wang Qing wrote:
>> What you are proposing here is completly different as you enforce
>> softirq execution in context of ksoftirqd only.
>
> Thank you for reply and explanation, I just provide a choice to balance
> the execution of softirq according to their own business scenarios.

That's not a choice. Forced interrupt threading is a boot-time option
and not a compile time boolean. So with your change you even changed the
behaviour of the kernel when your magic config switch is not selected by
the user.

>> What are you referring to? PREEMPT_RT does not modify the priority of
>> ksoftirqd. If system designers want to do that, then they can do so from
>> user space.=20
>
> I refer to the kernel-3.14 RT Patches. I used it at that time and achieve=
d=20
> very good results.

There is a reason why RT does not use this anymore and switched to a
different model. As I said before. Just because it works for you, it's
not necessarily a solution which should be exposed for general
consumption.

> I remember where I saw that softirqd was split into the original process=
=20
> and the RT process. This can partially solve my problem.

Your patch has absolutely nothing to do with that. You just picked some
random part out of those 7+ years old patches and then claim that it's
something RT does, which is just not true.

Thanks,

        tglx

