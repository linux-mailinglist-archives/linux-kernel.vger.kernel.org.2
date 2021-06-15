Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021ED3A7F10
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhFONVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhFONVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:21:08 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BB5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:19:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G486605RGz9sWD;
        Tue, 15 Jun 2021 23:18:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623763141;
        bh=QWoDAKw5TRrud4qQsPs8Td3rpC3GWyv1vI3PzogclYs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=obw7u1K+kdbcMc37FlUCkFJeHTzauxSgzLuPSxDPH5epUmGHmxREvvXoJLwQtNFtv
         UYJ5o3UL7s3+GW5Lqj0foYpxwWS5qr6eGEJ1TOn+QUPi21auVRVEAB78VXBZAm6pm8
         bjwkYZBCQkB7vPauArApH6tnFrpWoQbo9Ott582AuQJI4nQPkg0P/tgLB3X6tBTb93
         afqt1rDUVU58NOna1ztrum2o2Ibr32DST//5IH3N6bCwct99GKj4LGfjWuujt9RzkH
         dzxv7J3QeLFs16a/nSVyoG824NXRIPt1zoY0fb5bng1NYGozRsobl/IHldgRM4QAPs
         u89gCrpzX392A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, paulmck@kernel.org, paulus@samba.org,
        peterz@infradead.org, rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
Subject: Re: [RFC PATCH 09/10] powerpc: snapshot thread flags
In-Reply-To: <20210609122001.18277-10-mark.rutland@arm.com>
References: <20210609122001.18277-1-mark.rutland@arm.com>
 <20210609122001.18277-10-mark.rutland@arm.com>
Date:   Tue, 15 Jun 2021 23:18:52 +1000
Message-ID: <87k0mvtgeb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:
> Some thread flags can be set remotely, and so even when IRQs are
> disabled, the flags can change under our feet. Generally this is
> unlikely to cause a problem in practice, but it is somewhat unsound, and
> KCSAN will legitimately warn that there is a data race.
>
> To avoid such issues, we should snapshot the flags prior to using them.
> Let's use the new helpers to do so on powerpc.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> ---
>  arch/powerpc/kernel/interrupt.c     | 16 ++++++++--------
>  arch/powerpc/kernel/ptrace/ptrace.c |  3 +--
>  2 files changed, 9 insertions(+), 10 deletions(-)

This looks good.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


But, it clashes terribly with a series I'm planning to take for v5.14
that reworks our interrupt return code.

https://lore.kernel.org/linuxppc-dev/20210610130921.706938-1-npiggin@gmail.com/T/#t

So if you're also targeting v5.14 then it might be best to drop this
patch from the series, and we can do the conversion later.

cheers

