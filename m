Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B01310A76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhBELmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:42:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhBELjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:39:17 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612525113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WR6Kzn3CtESYxB05B58u2+toQzJ9rEOODL4oHIARXHk=;
        b=aFBzDikLnEqwElPmmZ6oM7GOn4pvJsOwHz21aIzAr+CekUZUYjrC43fhdPQC/l3985mqcT
        dRoiCQ34HHUKKqB6Rt6AWds4MI1ourAuKazdeSmP0z9JgPxjByaD8S9QYnZvjrPzYR2k7n
        kfpbt5kjeFKylaxUEIi+8BGsuVUl4KJrIGjw58Pnd3WWfUy/1sNOtFJQidfHDbK5uey+pT
        yL+oOdGgzCU1/7Lgoq9F5Gbxa3jdJZsWj6E5YFkId7C9jgd0PuSVJFHOWR3sAYH/KXnGvv
        qMrfOLFqjh7m4FYgUPGBqHUB78jvp6L5G+q+5ktw1yUs4izG+592PSr71GvaDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612525113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WR6Kzn3CtESYxB05B58u2+toQzJ9rEOODL4oHIARXHk=;
        b=ddDn0c12AAHE4DYQEl8EBRZ0f2LstxkO48dALyItr5O8VwkSbsqUPHGjYJj4A8L5EQz/4A
        P9W9nbTIKlKY1BBQ==
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 11/12] softirq: Allow inlining do_softirq_own_stack()
In-Reply-To: <CAJhGHyDF-wuK0Q0RZ9mDTo19rayA-jjJ1SGp2-1TS_d5-eHDzw@mail.gmail.com>
References: <20210204204903.350275743@linutronix.de> <20210204211155.214169844@linutronix.de> <CAJhGHyDF-wuK0Q0RZ9mDTo19rayA-jjJ1SGp2-1TS_d5-eHDzw@mail.gmail.com>
Date:   Fri, 05 Feb 2021 12:38:33 +0100
Message-ID: <87a6siagna.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05 2021 at 18:14, Lai Jiangshan wrote:
> On Fri, Feb 5, 2021 at 10:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>  static inline void do_softirq_own_stack(void)
>>  {
>
> Hello
>
> This patch and the next patch have three "#if[n]def" with
> __ARCH_HAS_DO_SOFTIRQ_INLINE and this one is nested in
> __ARCH_HAS_DO_SOFTIRQ.
>
> I wonder if we can use __ARCH_HAS_DO_SOFTIRQ only.
>
> For example, we can move "void do_softirq_own_stack(void);" to around
> the code where __ARCH_HAS_DO_SOFTIRQ are defined in very ARCHs.
> (And for x86, do_softirq_own_stack() is a macro instead of function
> declaration as next patch shows)

We can do that as well. No strong preference.

Thanks,

        tglx
