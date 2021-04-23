Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE4369CD4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 00:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhDWWhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 18:37:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48866 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhDWWh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 18:37:27 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619217409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97GQOqgF15L+ntkACoBNhyLvhY9ExoprR9D4OPssQEo=;
        b=kmBN9iOumKV7vlFzDvo4zo7HD1BJXEMww/LgcGOZft9gNKIFqSTTET7rKl4LGbW3E/vGFb
        A55Qgq+S9Tpbv5/xNCfceKPeUaVYqNqpfum6xsdfB3H5eW9gUmFjADXHHfla4R81HuxqKO
        vhnSAXZt48hvpvSWBOLiXr4DWzlCkd10fV/GojB+TM7Z1DDC0jaX9ys1TcejyxscfruVjq
        Pp7tvOqUfVUuJy8wXnt4uZj38l9aRGvCqtcEvEfV15Whd9VCmyRH3qkIoeaJ9fQgt2eS8/
        3CgDSjV/yeJciXKzOJHLxmlbQ1+0D0iET46eW5vESqTX2SE52nITnYubTW9FMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619217409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97GQOqgF15L+ntkACoBNhyLvhY9ExoprR9D4OPssQEo=;
        b=0HEOK5AmQyvh7dEJED5SH4g4JUWhDRaukLZqIvrrDOTWXHGCgxET5stgCVKHLGBfQjEM7G
        Uplns9UBp7oQ46BQ==
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@riseup.net>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Lukasz Majewski <lukma@denx.de>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, kernel@collabora.com
Subject: Re: [patch 6/6] futex: Provide FUTEX_LOCK_PI2 to support clock selection
In-Reply-To: <606120ab-ef46-fa87-5f2c-d480de9ed2c8@riseup.net>
References: <20210422194417.866740847@linutronix.de> <20210422194705.440773992@linutronix.de> <606120ab-ef46-fa87-5f2c-d480de9ed2c8@riseup.net>
Date:   Sat, 24 Apr 2021 00:36:48 +0200
Message-ID: <87o8e4vda7.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andr=C3=A9!

On Fri, Apr 23 2021 at 19:20, Andr=C3=A9 Almeida wrote:
>> @@ -21,6 +21,7 @@
>>   #define FUTEX_WAKE_BITSET	10
>>   #define FUTEX_WAIT_REQUEUE_PI	11
>>   #define FUTEX_CMP_REQUEUE_PI	12
>> +#define FUTEX_LOCK_PI2		13
>>=20=20=20
>>   #define FUTEX_PRIVATE_FLAG	128
>>   #define FUTEX_CLOCK_REALTIME	256
>
> To keep consistency with other operations, maybe add a=20
> FUTEX_LOCK_PI2_PRIVATE?

Good point! Missed that.

>> --- a/kernel/futex.c
>> +++ b/kernel/futex.c
>> @@ -3711,7 +3711,8 @@ long do_futex(u32 __user *uaddr, int op,
>>=20=20=20
>>   	if (op & FUTEX_CLOCK_REALTIME) {
>>   		flags |=3D FLAGS_CLOCKRT;
>> -		if (cmd !=3D FUTEX_WAIT_BITSET && cmd !=3D FUTEX_WAIT_REQUEUE_PI)
>> +		if (cmd !=3D FUTEX_WAIT_BITSET && cmd !=3D FUTEX_WAIT_REQUEUE_PI &&
>> +		    cmd !=3D FUTEX_LOCK_PI2)
>>   			return -ENOSYS;
>>   	}
>
> As FUTEX_LOCK_PI, FUTEX_LOCK_PI2 also requires FUTEX_CMPXCHG right?=20
> Then, add it here:
>
> 	switch (cmd) {
> 	case FUTEX_LOCK_PI:
> +	case FUTEX_LOCK_PI2:
> 	case FUTEX_UNLOCK_PI:
> 	case FUTEX_TRYLOCK_PI:
> 	case FUTEX_WAIT_REQUEUE_PI:
> 	case FUTEX_CMP_REQUEUE_PI:
>   		if (!futex_cmpxchg_enabled)
>   			return -ENOSYS;
>   	}

Indeed. Forgot about that completely.

Thanks for spotting that!

       tglx
