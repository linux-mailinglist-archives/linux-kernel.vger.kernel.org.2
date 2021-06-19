Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B893ADBF9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 00:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhFSWaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 18:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFSWaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 18:30:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E46C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 15:28:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624141685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0WkUU1i1UNpoG5pIe7zGWwNtXQBifCDLlz/iTVaWavw=;
        b=IoB2cHdkor3N6XKoijdTkXID8pdDe4JIzj5V6e/pbivlsZ4yftFbeXwv7fUt7iTrfPqLwy
        HmG/aB9s5oNy2bvSQf6OdvZtNTkRy8B+v/hWXIo+4fQ9O4MEq6/4Y/83Bn6UMq6+sQWyC0
        TRSk5F7TSunYTQNRrUAr/zlJF+tGp68jPykFS8erKoBTcdChSR1wpc4+avkXWAkxfodcjJ
        uju60I0aZjLJgM4vZpBimI/u+YM/zEKStW3noSkYmB5C5364CJuMzwZHVQ1O3fmZYkgs9m
        wvZ42ixLYCGuG8B6npwRjax6soLNZ7sKUaa6UGOfupJQQ9ixh6ziesY6C4wmWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624141685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0WkUU1i1UNpoG5pIe7zGWwNtXQBifCDLlz/iTVaWavw=;
        b=a2e27GGGAmo0bH0zDMZhcnNe1gmSW6n33X4SAj2CfS9MnN8sSDW1p4wIFKW03cbUHHqXAl
        EokKR0YTBzhi/MAw==
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, paulmck@kernel.org,
        paulus@samba.org, peterz@infradead.org, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        vincent.guittot@linaro.org, will@kernel.org
Subject: Re: [RFC PATCH 01/10] thread_info: add helpers to snapshot thread flags
In-Reply-To: <20210609122001.18277-2-mark.rutland@arm.com>
References: <20210609122001.18277-1-mark.rutland@arm.com> <20210609122001.18277-2-mark.rutland@arm.com>
Date:   Sun, 20 Jun 2021 00:28:04 +0200
Message-ID: <87h7hth4ln.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09 2021 at 13:19, Mark Rutland wrote:
> We have common helpers to manipulate individual thread flags, but where
> code wants to check several flags at once, it must open code reading
> current_thread_info()->flags and operating on a snapshot.

Who's we?

> As some flags can be set remotely it's necessary to use READ_ONCE() to
> get a consistent snapshot even when IRQs are disabled, but some code
> forgets to do this. Generally this is unlike to cause a problem in
> practice, but it is somewhat unsound, and KCSAN will legitimately warn
> that there is a data race.
>
> To make it easier to do the right thing, and to highlight that
> concurrent modification is possible, let's add a new helpers to
> snapshot

let's add? Why not simply "add"?

> +static inline unsigned long read_ti_thread_flags(struct thread_info *ti)

__always_inline() as Marco pointed out already

Other than those nitpicks:

 Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
