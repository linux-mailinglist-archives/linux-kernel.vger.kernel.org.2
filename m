Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0FB3AF3E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhFUSFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232227AbhFUSB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:01:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DD97613E0;
        Mon, 21 Jun 2021 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624298100;
        bh=UU/I2PapTSxwR1LIaIk6Vnp1XdnWKTjXQ1G8zYGJvzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=en9N5gy6gBuCpvej5Ad/8mxHyoGN70z2oNReVUnkY8VnSFJm0+PUj2SgLX68kmGmL
         QIPKQhCTjPXcxmedF9o6csURuGrJpi3oq5NQHchzrxe7MqUt9SvZ6OyO9KbaJketTT
         hKKTJj9JfDz+HA6mKkvbjolIFFt/h3icmj+3cBBArPmYmN4fcRvW7++izEStOn2xuy
         Z7aYnoBw7w4TTQSyugZkvxOUY87DAs2yVI/tFx1jXFVbIkqTSOGp/BDAYvA1ptHDYA
         X42RoCjPOxlqFoDN7Vr448w9vIAdy4d7jr76ZgjffLiVmkf3YooIe0ut3A6DeAjZLa
         KJUt4rRlJtrjQ==
Date:   Mon, 21 Jun 2021 18:54:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mattst88@gmail.com, mingo@redhat.com, monstr@monstr.eu,
        paulmck@kernel.org, peterz@infradead.org, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, vincent.guittot@linaro.org
Subject: Re: [PATCH v2 0/9] thread_info: use helpers to snapshot thread flags
Message-ID: <20210621175452.GB29713@willie-the-truck>
References: <20210621090602.16883-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621090602.16883-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:05:52AM +0100, Mark Rutland wrote:
> As thread_info::flags scan be manipulated by remote threads, it is
> necessary to use atomics or READ_ONCE() to ensure that code manipulates
> a consistent snapshot, but we open-code plain accesses to
> thread_info::flags across the kernel tree.
> 
> Generally we get away with this, but tools like KCSAN legitimately warn
> that there is a data-race, and this is potentially fragile with compiler
> optimizations, LTO, etc.
> 
> These patches introduce new helpers to snahpshot the thread flags, with
> the intent being that these should replace all plain accesses.
> 
> Since v1 [1]:
> * Drop RFC
> * Make read_ti_thread_flags() __always_inline
> * Clarify commit messages
> * Fix typo in arm64 patch
> * Accumulate Reviewed-by / Acked-by tags
> * Drop powerpc patch to avoid potential conflicts (per [2])
> 
> [1] https://lore.kernel.org/r/20210609122001.18277-1-mark.rutland@arm.com
> [2] https://lore.kernel.org/r/87k0mvtgeb.fsf@mpe.ellerman.id.au
> 
> Thanks,
> Mark.
> 
> Mark Rutland (9):
>   thread_info: add helpers to snapshot thread flags
>   entry: snapshot thread flags
>   sched: snapshot thread flags
>   alpha: snapshot thread flags
>   arm: snapshot thread flags
>   arm64: snapshot thread flags

FWIW, you have two identical arm64 patches in this series, just with a
different subject. For the one you decide to keep:

Acked-by: Will Deacon <will@kernel.org>

Will
