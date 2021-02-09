Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B65315ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhBJANu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:13:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhBIUn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:43:59 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612903394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7jUaMxS9WvU0nvaR4lPpE29E41vntfff3TxhbLAxsU=;
        b=LyN2VE166aOewaHejGq3b/xCLEfPK9uLP2p79EOuPymIGG4x8su8T+YeYuxdAmcw9fj4mh
        +vbZ8+Rdd4Ok293OUjP9uoQiriXB+HOMMv6krp8wCuLeoBVEqEGlZly3Co5wC+zYkGn6o/
        lv7BRifmm+kaN5GMMxb1a9fH9uJ13g2LKSIitas449G0bEsO0wMVPYhyh1LpKdrBnfIBlc
        mB1BIlct3D29tpKMpF7Ag7F7dR7f2RzfCkOAhUKEEMN8DEoZJ4OEiJjilDsVL1jncCXZPS
        z51W0xpi3yaedjYe21cpaMv83hCkQ7FwVG9RR6/z4CnE/hSLe9C8fBS4Osj5yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612903394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7jUaMxS9WvU0nvaR4lPpE29E41vntfff3TxhbLAxsU=;
        b=AFetXLnWjWgEYScVDm0SpUSPIrLG9BpORSy9KQRTh0kRTLKdx5uA8HbguTXdbDU7SBQdpz
        6ddgN1UtLbQ6r8CQ==
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 11/12] softirq: Allow inlining do_softirq_own_stack()
In-Reply-To: <87a6siagna.fsf@nanos.tec.linutronix.de>
References: <20210204204903.350275743@linutronix.de> <20210204211155.214169844@linutronix.de> <CAJhGHyDF-wuK0Q0RZ9mDTo19rayA-jjJ1SGp2-1TS_d5-eHDzw@mail.gmail.com> <87a6siagna.fsf@nanos.tec.linutronix.de>
Date:   Tue, 09 Feb 2021 21:43:13 +0100
Message-ID: <87r1lpas66.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lai,

On Fri, Feb 05 2021 at 12:38, Thomas Gleixner wrote:
> On Fri, Feb 05 2021 at 18:14, Lai Jiangshan wrote:
>> On Fri, Feb 5, 2021 at 10:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>  static inline void do_softirq_own_stack(void)
>>>  {
>>
>> Hello
>>
>> This patch and the next patch have three "#if[n]def" with
>> __ARCH_HAS_DO_SOFTIRQ_INLINE and this one is nested in
>> __ARCH_HAS_DO_SOFTIRQ.
>>
>> I wonder if we can use __ARCH_HAS_DO_SOFTIRQ only.
>>
>> For example, we can move "void do_softirq_own_stack(void);" to around
>> the code where __ARCH_HAS_DO_SOFTIRQ are defined in very ARCHs.
>> (And for x86, do_softirq_own_stack() is a macro instead of function
>> declaration as next patch shows)
>
> We can do that as well. No strong preference.

actually it's not that trivial. It ends up in include hell and then
pulls the whole irq stack macro mess into every file which includes
interrupt.h.

I've moved the default function prototype and the stub into
asm-generic/softirq_stack.h and let x86 override it.

Thanks,

        tglx
