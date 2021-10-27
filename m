Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58143C589
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbhJ0Ixu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbhJ0Ixs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:53:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41847C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:51:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a26so2053935pfr.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=sIX7x+jsOOh5AaV+S5PO7/zC51BozSS5Rq+F5YdEC2E=;
        b=CHBG61uLzvDqfRJ/+PW1nWr4QbYXNL3OH9IqUgo1TQV2OdCDHJL35LJxNDytgZHgSD
         ZgDKIj7n6JkhUFlv1ZPMBaLePDJWpa1vN5bBoJZJ5/gPgWQb7a/4Eyo2IRJkueD/ZjMV
         v3dBzwXDOnEc+NcY8x9noBBUOk79O2+8qEybPerdpJSUbtwwuCjsU/mSrcQ9N4qOg3jG
         rsVa6VUMGfmfp1xP/euxae0Wfy5FXZJ/lQN2K4O/j8Qd+Y6ykNli8q/vm2RZD1Z9tcQl
         tA1/wnmpOEUbDzKXGUVw2jDOzzeLmDA4aH08l8Qj05swAte4/dXG1zhxf3yInQEbQQrG
         PS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=sIX7x+jsOOh5AaV+S5PO7/zC51BozSS5Rq+F5YdEC2E=;
        b=vH5z4PggcRqgSivSqF/56lwSzfqw2/mYERkpTX/7ya8lUHk+0aMPkMsOY+iizZhBj3
         AfMH0Ngh1aWaS1eRc84Tn+xgvSGdoZoWuKIcprP458HO1PgQL51EM2J9ig4NEWlUWFc0
         6lTLay/nXkt+sUaj+VerLjQj/ulsPvNTjbP4j+MxmSxLsC9unaKlCskffWGtHZ6ABj5m
         FIN0M5+4HN6hdFglFusNiMm/JgF9+G1BnaPapAwkOsLJmjPZo4v8VHyI9j63OJHLQwg6
         +IrR8p13wf6LZ+Ea22Ta5h7mY/eugjG+JlAvXmUxUvqMBJMDltT/4Qu/1OH/MVQgan1R
         XQHA==
X-Gm-Message-State: AOAM530V54NunRW66rM5Rv2BtCr3idVY2L1FbgymC+VESXhixErwLQ2x
        fXq+ANmFtP3ojZ97BHMQGDI=
X-Google-Smtp-Source: ABdhPJzJStwG8g1rHK/ea6WbgB2QH2Oeg9CnSFm4YNIijvWtlX1WDWWt3VR8/1WOY8yJRSwbFc3nXg==
X-Received: by 2002:a63:7553:: with SMTP id f19mr18914218pgn.328.1635324682687;
        Wed, 27 Oct 2021 01:51:22 -0700 (PDT)
Received: from localhost ([118.208.159.180])
        by smtp.gmail.com with ESMTPSA id n29sm4691263pfv.77.2021.10.27.01.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:51:22 -0700 (PDT)
Date:   Wed, 27 Oct 2021 18:51:16 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/watchdog: prevent printk and send IPI while
 holding the wd lock
To:     benh@kernel.crashing.org, Laurent Dufour <ldufour@linux.ibm.com>,
        mpe@ellerman.id.au, paulus@samba.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20211026162740.16283-1-ldufour@linux.ibm.com>
        <20211026162740.16283-2-ldufour@linux.ibm.com>
        <1635303699.wgz87uxy4c.astroid@bobo.none>
        <33e15005-d342-5270-9b9d-64750f8794a7@linux.ibm.com>
In-Reply-To: <33e15005-d342-5270-9b9d-64750f8794a7@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1635324001.1tf9yz448t.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Laurent Dufour's message of October 27, 2021 6:14 pm:
> Le 27/10/2021 =C3=A0 05:29, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Laurent Dufour's message of October 27, 2021 2:27 am:
>>> When handling the Watchdog interrupt, long processing should not be don=
e
>>> while holding the __wd_smp_lock. This prevents the other CPUs to grab i=
t
>>> and to process Watchdog timer interrupts. Furhtermore, this could lead =
to
>>> the following situation:
>>>
>>> CPU x detect lockup on CPU y and grab the __wd_smp_lock
>>>        in watchdog_smp_panic()
>>> CPU y caught the watchdog interrupt and try to grab the __wd_smp_lock
>>>        in soft_nmi_interrupt()
>>> CPU x wait for CPU y to catch the IPI for 1s in __smp_send_nmi_ipi()
>>=20
>> CPU y should get the IPI here if it's a NMI IPI (which will be true for
>>> =3D POWER9 64s).
>>=20
>> That said, not all platforms support it and the console lock problem
>> seems real, so okay.
>>=20
>>> CPU x will timeout and so has spent 1s waiting while holding the
>>>        __wd_smp_lock.
>>>
>>> A deadlock may also happen between the __wd_smp_lock and the console_ow=
ner
>>> 'lock' this way:
>>> CPU x grab the console_owner
>>> CPU y grab the __wd_smp_lock
>>> CPU x catch the watchdog timer interrupt and needs to grab __wd_smp_loc=
k
>>> CPU y wants to print something and wait for console_owner
>>> -> deadlock
>>>
>>> Doing all the long processing without holding the _wd_smp_lock prevents
>>> these situations.
>>=20
>> The intention was to avoid logs getting garbled e.g., if multiple
>> different CPUs fire at once.
>>=20
>> I wonder if instead we could deal with that by protecting the IPI
>> sending and printing stuff with a trylock, and if you don't get the
>> trylock then just return, and you'll come back with the next timer
>> interrupt.
>=20
> That sounds a bit risky to me, especially on large system when system goe=
s=20
> wrong, all the CPU may try lock here.

That should be okay though, one will get through and the others will=20
skip.

> Furthermore, now operation done under the lock protection are quite fast,=
 there=20
> is no more spinning like the delay loop done when sending an IPI.
>=20
> Protecting the IPI sending is a nightmare, if the target CPU is later pla=
y with=20
> the lock we are taking during the IPI processing, furthermore, if the tar=
get CPU=20
> is not responding the sending CPU is waiting for 1s, which slows all the =
system=20
> due to the lock held.
> Since I do a copy of the pending CPU mask and clear it under the lock=20
> protection, the IPI sending is safe while done without holding the lock.

Protecting IPI sending basically has all the same issues in the NMI
IPI layer.

>=20
> Regarding the interleaved traces, I don't think this has to be managed do=
wn=20
> here, but rather in the printk/console path.

It can't necessarily be because some of the problem is actually that a=20
NMI handler can be interrupted by another NMI IPI because the caller
can return only after handlers start running rather than complete.

I don't think it would be an additional nightmare to trylock.

Thanks,
Nick
