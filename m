Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D82369CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 00:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhDWWen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 18:34:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48814 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhDWWej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 18:34:39 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619217241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0C6O7YdE9DAqA2E6WEAMhD6XoiomXzh9eXVeT01CkY=;
        b=YjOnx72spIC8z6YC0irn1WsoGzhEeCYTTjADWIKVdIQzUaMA/B3ovkVLNcR0YlUME/lBKc
        8SEbWaJ7i3fLL/OFSV2DDWgsZ8Ou+7c2r/W/pwYok3bcEwA5qVQVdbqbpKPX9J0gG4OZV1
        O/wuliFxoXpkDekX7299kusxN4KD2fw4DLN7+2CTRRQsVj1VanqJYLgyc5UmqFiLJ1oD9V
        i/8Hrz7vjh/xhivnXm2vjdotw+QJA6fFF0+Sc+xOVvjbQpeMPjzOuqHQ4mesPh+FwJ7CDG
        +YXcmPigde5f1Jpmt5iPzcPJG0qYdIXQJG+oUCP34PtIfKw+chuwnMRErP0Pvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619217241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0C6O7YdE9DAqA2E6WEAMhD6XoiomXzh9eXVeT01CkY=;
        b=3hRn33tEzACsqQ/+jHM2IjDI2N1hkxb3DSUF5ghc8BidKUiizevnl0b2LVadAsq5XbW/ON
        wIE7Hdk8pdtX2SAg==
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Lukasz Majewski <lukma@denx.de>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>, kernel@collabora.com
Subject: Re: [patch 3/6] futex: Get rid of the val2 conditional dance
In-Reply-To: <f8cda7fa-46e9-5add-ccb6-441323ba2042@collabora.com>
References: <20210422194417.866740847@linutronix.de> <20210422194705.125957049@linutronix.de> <f8cda7fa-46e9-5add-ccb6-441323ba2042@collabora.com>
Date:   Sat, 24 Apr 2021 00:34:00 +0200
Message-ID: <87r1j0vdev.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23 2021 at 18:40, Andr=C3=A9 Almeida wrote:
>>=20=20=20
>> -	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
>> +	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3=
);
>
> Given do_futex()'s type signature, I think it makes more sense to cast=20
> utime to u32.

It's a pointer which you better force cast to unsigned long first.

So the explicit thing would be '(u32)(unsigned long) utime' which is
what the val2 dance stupidly did with 'int'

		val2 =3D (int) (unsigned long) utime;

But with doing it at function call argument it's implicit, because the

  unsigned long  to u32 conversion is well defined

while

  (u32)ptr

is only well defined on 32bit.

Thanks,

        tglx

