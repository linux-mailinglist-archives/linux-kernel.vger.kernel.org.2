Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C263F98F1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245060AbhH0MUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 08:20:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:50529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbhH0MUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 08:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630066788;
        bh=36rePuGIII6ztQM9yWdUbhmy2VQkb0KeoNAL0pJ37b0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JwRluKIHYFr0zjobhsWonJNTVestxBc/4S6wKsTXI47UtXSMv5/Mx8AhE63nPa7mo
         8ReJ/0SwRYC4IJ4oKR1TQBUTjk3B3Y4SFQHzgGe1Pon/neVDkC1HTAe32BJh173UuK
         kPQ2AwZqNDGDRIhjsMlniyAyAh/7SiazZmSWr1+0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.133.192]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1nDBbE3hwx-00yUCz; Fri, 27
 Aug 2021 14:19:47 +0200
Subject: Re: [PATCH] Fix prctl(PR_GET_NAME) to not leak random trailing bytes
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
References: <YSiwLuE17BwRlI/d@ls3530>
 <aa0006e7-58b8-ab05-0599-5609e900ba4d@rasmusvillemoes.dk>
From:   Helge Deller <deller@gmx.de>
Message-ID: <97a0ddcf-243d-f312-8291-01d6595260bf@gmx.de>
Date:   Fri, 27 Aug 2021 14:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <aa0006e7-58b8-ab05-0599-5609e900ba4d@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rVJo3HcM7U7Ar9BboNsiZtxEgxj18axgs3PoVacPYthMOxstrht
 eSN+qCHmJIEtOL252H61YZKhNOPwrLapKtfF1IhTg8/RsVnA8bWh/ebM44iYNu6QPxPO9Tk
 kw379skaDlpeYPQzb5TYSyGmK8X+FWY8U5fY4aJd/pHsH92fSPz9h3PEdhtd6X8Vn4rddHw
 lgTbiQLGz1XPxXnlMYLxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uivJSkOGzUk=:MdFc2qvlIt3cUfQzFM+2ZE
 O6SQuelsNnP92ae72cc1ObjydJrJ4Xq5lVq7A1nTcOnaSjTNbchzvKiS2Iq+uDOv4wOeGwGn9
 Hjejb66j59EZTSpi5QCBmyaAOryu1f7+VRV6vX/Tc3Ht0RxfRu3ICrEjLTmKO8EBfm7Lottls
 gUmY5eNWaS5YXkAbk5YxkANn1gpsQQFNfn7DPTPxGW6EHRubi3OrcTeqnp/gWn6YWr/mFOmYo
 stHqqKLpGv7oamPldmOmAV9jfmGvffwmUr5yCKpWDF9nD6AW6vzTxYTqpKhoRArV4nw7WzQAh
 jgWd1vjge6ywy/1rTyFWMZyugAWQyGIwRLQul23sN9Exf123lDKAY18iWLKJoji/7hlpB/t62
 zogyLGjG7grpCqwoXC+YZqilAPADdCHiFys9YV5F2diAe68FJh0gBmtTT562IUu5/3vsGQ85W
 sPl4uyk1Dbly4iB6LrSpLCga6opVeOQY5IrHjBKBXVtvEPwXVwyxCGju+sFhfwMtcxdnZIC6r
 aqJzCpIcvS0ZPy/kfrsmRbvTWXX/1tm4FZOmUi6W16Ii0BfM9hYjGK5cYJ7RR3DGoDTk933yi
 enpOTgz3maizoQMoRmVjJn0RUWPvFZvTSBI5nfq8dxH4KGNYts787KHRcOL+W++/7thg1rAEg
 GCVMXpGhUlZVkpYN1r3eUYjYRRSkmAOKzCxmaZw9L2i6RKq1agklVgLtNR9Ao9Y+L/vcIxmUD
 TyLd0mX2PWYm38bSGLBhYWPmmsHuGrrme0vFa4yUYY43B1b0Tba9Gbt6yY9O1wZ9hq9fxQefb
 gsNQMBgeCQuVRQUebN2qs/QR1jvpc0rcsTuBkyJRiONpbTO3GlJsnGcfRt2shcMJ6RUlj9s/i
 hxcC/fNdKOzZg5QEeIjcIyV0MCxG/wXYOV2X8xUJU4vAlYzyYsStMob/2+QSFpv8CWT7G6Ntf
 9XKLTtxUfiqcs2PkhrKynlKlkO70Ymvil5ZfvnK9Sn/+A2y+dhQqRjqtD6AVzDjWUUK1y9GKW
 w6Ahn8Ixh3r5QO3HVFCH1DWFmKzBFwoFO0gGTxFlWHvHgklLUKLuZUcMfIMOlgP3gdDDHIeIu
 hfUHW7T+HQLeyEuDH6yrx/l1RLQOef5ke4C
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 12:31 PM, Rasmus Villemoes wrote:
> On 27/08/2021 11.28, Helge Deller wrote:
>> The prctl(PR_GET_NAME) and prctl(PR_SET_NAME) syscalls are used to set =
and
>> retrieve the process name. Those kernel functions are currently impleme=
nted to
>> always copy the full array of 16-bytes back and forth between kernel an=
d
>> userspace instead of just copying the relevant bytes of the string.
>>
>> This patch changes the prctl(PR_GET_NAME) to only copy back the null-te=
rminated
>> string (with max. up to 16 chars including the trailing zero) to usersp=
ace and
>> thus avoids copying and leaking random trailing chars behind the proces=
s name.
>>
>> Background:
>> The newest glibc testsuite includes a test which is implemented similia=
r to
>> this:
>>     prctl(PR_SET_NAME, "thread name", 0, 0, 0);
>>     char buffer[16] =3D { 0, };
>>     prctl(PR_GET_NAME, buffer, 0, 0, 0);
>>     char expected[16] =3D "thread name";
>>     fail if memcmp(buffer, expected, 16) !=3D 0;
>>
>> The compiler may put the "thread name" string given in the PR_SET_NAME =
call
>> somewhere into memory and it's not guaranteed that trailing (up to a to=
tal of
>> 16) chars behind that string has zeroes.
>> As such on the parisc architecture I've seen that the buffer[] array ge=
ts
>> filled on return of prctl(PR_GET_NAME) with such additional random byte=
s, e.g.:
>>         "thread name\000@\032i\000"
>>         74 68 72 65 61 64 20 6E 61 6D 65 00 40 1A 69 00
>>
>> Unfortunatly the glibc testuite tests the full memory block of 16 bytes
>> and fails because it expects zeroed characters behind the process name.
>>
>> In addition to fix the glibc testsuite, I suggest to fix the kernel fun=
ction of
>> prctl(PR_GET_NAME) to just return the null-terminated process name.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Cc: stable@vger.kernel.org
>>
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index ef1a78f5d71c..af71412760be 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2367,7 +2367,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long=
, arg2, unsigned long, arg3,
>>   		break;
>>   	case PR_GET_NAME:
>>   		get_task_comm(comm, me);
>> -		if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
>> +		if (copy_to_user((char __user *)arg2, comm, strlen(comm) + 1))
>>   			return -EFAULT;
>>   		break;
>
> I don't understand. get_task_comm() is
>
> extern char *__get_task_comm(char *to, size_t len, struct task_struct *t=
sk);
> #define get_task_comm(buf, tsk) ({                      \
>          BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);     \
>          __get_task_comm(buf, sizeof(buf), tsk);         \
> })
>
> and __get_task_comm() is
>
> char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *ts=
k)
> {
>          task_lock(tsk);
>          strncpy(buf, tsk->comm, buf_size);
>          task_unlock(tsk);
>          return buf;
> }
>
> so the strncpy should ensure that the caller's buffer after the string's
> terminator gets zero-filled. I can see that parisc has its own
> strncpy(), but I can't read that asm, so I can't see if it actually does
> that mandated-by-C-standard zero-filling.

Oh, the parisc strncpy() asm does NOT zero-fill the target address !!
That's the bug.
I thought strncpy would just copy up to given number of chars.

> It would surprise me if it
> didn't (I'd expect lots of other breakage), but OTOH it is the only way
> I can explain what you've seen.

Interestingly the kernel runs quite well and we don't see any bigger break=
age.
Anyway, the function needs fixing.

Please ignore this patch and thanks for pointing to the real bug.

Helge
