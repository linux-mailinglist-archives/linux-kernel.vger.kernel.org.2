Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3280933F935
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhCQTap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhCQTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:30:15 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AE0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:30:14 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id n24so9964190qkh.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0JxX/EeC1UVKwHOsPcIWefrhVnYu1SGK3e1Us0djvdI=;
        b=jMqzxnkBzKmqp8/t0dQ8FWoAMljO+yxZWRK7+UZ6vZtMQDj7i8jT1jzzhs6/3GOKy8
         jKCnrTz3lgcA4MWCUBetkOmg9NKH3+zj95qod6QGSUBnTuxVF8ZIXhu6J92NLWlYKomw
         BZ0D2PRZXoP9kCE9lYiyIQ+hfxaJw64P4y3t++b9KmDpNOxcGIUmXV9y9sbtt83hMh9e
         Pfz6sfYOiD7vslRPViNBn6uutiRa4RUnFfHX/XLj/4lKjqcwNz2bGX64euEUeDVsmcs9
         6LQlNk1EylWVKkom/2gZtyVPGdryXOjiDouICTsQQ/Vgyc6FLhDSN6YBteC//8INiunb
         XVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0JxX/EeC1UVKwHOsPcIWefrhVnYu1SGK3e1Us0djvdI=;
        b=pnz1DQcN4w+oFEe8h8F8kmvJ2A7fdG6TLp32Zrpfp7MBS8qdkMuvArJSViQO/72mkr
         4yZOjhUXgIMQgE8HqNtbKhWcNU43q4B6uH6p1so2NgQTq0iBVw5ycz7LesxVjAvTA5sd
         astk+yD4h3a/AJuU1YmBwEZJbBH3qguLaJnxcijD5t0K0NAdopeevpq1IHhYwepn3bKi
         3lZ8B3roo1SmXRIANLWUwBBIHtvwhdwUqObs2SqB8GK4ZvxKDUETIgPNknYkx0roxt68
         1aJeDmYsQ8mSMjSTHS7pgPutn8lb6jLy3z/5Mu/OnghvXd/m5x5CiVhXUUZgmfVTCDWh
         oYjQ==
X-Gm-Message-State: AOAM530aOXJBYAhVYWWs8s6wSgNLtuYqzBcDyzOLttwbYWFYP8uuP4mr
        Y2EkyWAt057asGoMlLswarU=
X-Google-Smtp-Source: ABdhPJwPSM87tx00ljWLHFkpcmORvfzihpIgFT74wXLKK+hITK4Ma+fQoiVCAa+vUsUxpV04fTwGrQ==
X-Received: by 2002:a05:620a:15b7:: with SMTP id f23mr872320qkk.58.1616009413783;
        Wed, 17 Mar 2021 12:30:13 -0700 (PDT)
Received: from ArchLinux ([156.146.37.138])
        by smtp.gmail.com with ESMTPSA id f9sm18170545qkk.115.2021.03.17.12.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:30:12 -0700 (PDT)
Date:   Thu, 18 Mar 2021 00:59:54 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: cpu: resctrl: Minor typo fix in the file
 pseudo_lock.c
Message-ID: <YFJYshIZjo+Xcgo5@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210317084016.3787380-1-unixbhaskar@gmail.com>
 <b29afbff-67f4-397b-e289-c3e21755fec0@intel.com>
 <99a7e1fc-0a05-9222-f913-b2d85141a08a@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VJPfBsDAO9Dvj47m"
Content-Disposition: inline
In-Reply-To: <99a7e1fc-0a05-9222-f913-b2d85141a08a@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VJPfBsDAO9Dvj47m
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11:01 Wed 17 Mar 2021, Randy Dunlap wrote:
>On 3/17/21 10:54 AM, Reinette Chatre wrote:
>> Hi Bhaskar,
>>
>> Thank you very much for catching this typo.
>>
>> My feedback [1] to a previous patch from you applies here also. The pref=
ix should be "x86/resctrl:" for contributions to this area.
>

>Bhaskar,
>Pretty much all of your patches need to have improved Subject: lines.
>The file name that is being modified should not be at the end of the Subje=
ct.
>

Noted, ...I was trying to feed the owner of the file as much as possible , =
so
the person can struggle less to understand and hover,considering the load t=
hey
might have on their shoulder.

>>
>> [1] https://lore.kernel.org/lkml/7e3a5c13-db5c-7399-2b80-f1284786ea77@in=
tel.com/
>>
>> On 3/17/2021 1:40 AM, Bhaskar Chowdhury wrote:
>>>
>>> s/derefence/dereference/
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>> ---
>>> =C2=A0 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kerne=
l/cpu/resctrl/pseudo_lock.c
>>> index e916646adc69..43990a882b36 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>> @@ -1307,7 +1307,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *=
rdtgrp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the t=
hread does not get on the CPU for whatever
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reason a=
nd the process which sets up the region is
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * interrup=
ted then this will leave the thread in runnable
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * state and once it g=
ets on the CPU it will derefence
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * state and once it g=
ets on the CPU it will dereference
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the clea=
red, but not freed, plr struct resulting in an
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * empty ps=
eudo-locking loop.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> --
>>> 2.30.2
>>>
>>
>> Reinette
>
>
>--
>~Randy
>

--VJPfBsDAO9Dvj47m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBSWLIACgkQsjqdtxFL
KRW4Owf/YDWTYixmniAOtKYDy+yb05EtMir9acO49uZ3XldNCR/TC9fr4/vCApGw
li0rXlDsUX7Y0qwqxc9MK3mnkfRguiJWmoNPCGedilgypsZDQdGK8TFSr9iZuA12
f7xfSDAyfTuFaXGNJ6NUpTKo87RBUNN2QJsP296NC5U71bFyedOK1hk3HuuOoTiE
GMdBuqm8qGwEo9qnyPEhSkQAFFUgi6f2iaDpIrD3TmjqgAvql5nEG6vwj4RXd+sm
5LR22DDl0WibPvH41vLubPkqGjKqQWqDnVfcmvyI4CA4H0WS48tE0Xdw1VfVwI5R
Rq6tc7WEVH1IFPeUVAqSbCNQWRi0xQ==
=8bXv
-----END PGP SIGNATURE-----

--VJPfBsDAO9Dvj47m--
