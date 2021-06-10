Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC11B3A24FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFJHGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:06:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:49231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhFJHGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623308673;
        bh=PT2FAruH41EMJhSUXAlNa2/YRiWJ8FrcU8h5rH4lLGo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AaeUkMafJD+hEMxb/D3AyJkqe/EKppLxDuodxv6lXpmaYG3qoYeNfBRhZmxAQptL/
         t4/Yk3C68YRfcoF5yQgVZgQSZOWZ8cE+rOkvYA00nM/4dqEljSZjGxER3+smD+uPhh
         oYfQTtq4isp243ZK9+qRdx/i7/NK34kPeNZgjl+o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.130.190]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fis-1lBKNF1wng-011yRb; Thu, 10
 Jun 2021 09:04:33 +0200
Subject: Re: linux-parisc compile failure in current git
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
 <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Message-ID: <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de>
Date:   Thu, 10 Jun 2021 09:03:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ASwgOCYgMs0xMuccufBzqtRI1Qa4WbIKBToBlntpQJjHYZCmVVU
 BCDb1AygBXk5cHH2V8JKWWMCVlOF06pGNz+2xxqHnU9kjAXq4jkYtuV9SRRdUI5yG50+7+r
 R2demVSiaI/q5Bd2VccqZJZJ6Or3DTUzLLqJMlAuf0Nk0IvPy0Udw7GEDJ37PUu33AJyM2a
 k39VcvVD87z7u1RDk30/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bGxkefuR4j4=:7wNBJNGv3utNVwqDP5kueZ
 AkAjNUtZfXW2UHCEElzZaRSgo5kXLsAner/Ln6AM7p/YKQ/nB2xbXJpq+jQFg7t0GKzDMhpWc
 7n20gCEzUMbTpnklM4yKD3FqGRm/uCIbuDjDWp0IHWNhaGesaKHYXm//24htYaa3k2I2AXbAs
 qZR+oWuU/sGpDZPNFXNtZH2v8rGsby8xJ1TZ2v5bFxxutgn+leeXqWbquq6PoyMIz6klqrwDW
 4cSlgo2WeJqzLMnf8K6eJ714MiwUBtiB2U1l/tWNHNo8l2RkA48tS1uQbMh8lXCc5uj52Cu1y
 9px7Wn83jZJB2rEsoC8/9pZ9vL7x8NTxbYV8q0Au7C5wEdVdj/Rui+6p4KctSqgY78odH+Kd5
 Br7Cwy+GTHn6PXkapjigv6Yeq3S3mpAbELofAMzK8KoYz2tqyRcHMmuyb2523O1qnr8UCZGtS
 Z4NM65X1RSi71baGPinZvO1ECNqEIMZnlR8iEJECC0s9rQtBcj54o9aLOeOR87BnyLDk7zyMs
 uO2/4RyDfnqcIOm8FFTzD+VYBaZt0HfsEOhNS/YojB/YZeuoi8rXIDUT3wmwtAR7cw8WiirrI
 71iR+9o7RVvqU32Bigi6bOL65txIGdagLXl3e/hJt/y9/yGD32UqHYt93brPN9Sn8PygK19Jq
 HT6wrpLzVMpEWdQCU89e83S8HHhMHI6Ijy1m28DH8MAvQJYijFVt10UVaBxDrpbVMN6q3hJ9T
 y0P2m73lGfKMv9qcjY+mYnum3FpuxK0XBaEiALUrvdv1wS/YyWvv6tZ7fDBsDZU/NlYttKolt
 cvaoQGL0tnRh1WjmuFir1Umr36s9vlT9hCENUqnPSGV2IcEwN6dMG1jF3gAQD7gFVnaE8S5WP
 /XcCcq3/OMqBVUPjgQSn2UvA47kyaztoXZsJq+LIAumYobd7CyzYAnL3wpH4RwnIXn9v2iL9P
 h4raneI3MBBLs+B9wN0mwpMmPsadiDtETYgT3UFLV5KevhRvP+Wa3lFBKXsgA7QiCFFwjXFJh
 gHCPdXllcOnRasbEbU6YTrU6ji463jMeUnrvG4ToZhDlTq8+J8PpOseMBPjh0idJzMlXnwsde
 pz9g33PEu/UgTpzYkqLIVLVsfxEzkwfwq0m
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 6/10/21 4:03 AM, Masahiro Yamada wrote:
> On Thu, Jun 10, 2021 at 7:50 AM Helge Deller <deller@gmx.de> wrote:
>>
>> On 6/1/21 12:21 PM, Meelis Roos wrote:
>>> Upstream Linux git fails to compile on gentoo hppa -  .config below.
>>> I have 2 gcc-s as always:
>>> $ gcc-config -l
>>>    [1] hppa2.0-unknown-linux-gnu-9.3.0
>>>    [2] hppa2.0-unknown-linux-gnu-10.2.0 *
>>>
>>>    [3] hppa64-unknown-linux-gnu-10.2.0 *
>>
>>
>> I see the same issue too, but only when compiling natively on a parisc =
machine.
>> Cross-compiling on a x86 box works nicely.
>>
>> First I thought it's a problem with setting the "cross_compiling" flag =
in ./Makefile.
>> But that's not sufficient.
>>
>> On a x86 machine (which builds fine) I get
>> SRCARCH=3Dparisc SUBARCH=3Dx86 UTS_MACHINE=3Dparisc
>> The arch/parisc/kernel/asm-offsets.c file gets preprocessed via:
>> hppa64-linux-gnu-gcc
>>
>> On a native 32bit parisc machine I have:
>> SRCARCH=3Dparisc SUBARCH=3Dparisc UTS_MACHINE=3Dparisc
>> Here the arch/parisc/kernel/asm-offsets.c file gets preprocessed via:
>> gcc
>> Instead here the native hppa64-linux-gnu-gcc (cross compiler) should ha=
ve been used too, since
>> we build a 64-bit hppa kernel (CONFIG_64BIT is set).
>> Note, on hppa we don't have an "-m64" compiler flag as on x86.
>
> I see.
> hppa is not a bi-arch compiler, in other words,
> http- and hppa64- are separate compilers.

Yes.

>> Mashahiro, do you maybe have an idea what gets wrong here, or which
>> patch has changed the behaviour how the asm-offsets.c file gets preproc=
essed?
>
> Presumably, commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
>
> Prior to that commit, arch/parisc/Makefile was like this:
>
> ifneq ($(SUBARCH),$(UTS_MACHINE))
>          ifeq ($(CROSS_COMPILE),)
>                      ...
>
> Now I understand why arch/parisc/Makefile was written this way.
>
> Reverting the change in arch/parisc/Makefile will restore the original b=
ehavior.

Sadly, reverting this change (23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3) do=
es not
restore the original behavior.

> But, please keep in mind that there is an issue remaining.
>
> Please see this code:
>
> ifdef CONFIG_64BIT
> UTS_MACHINE :=3D parisc64
> CHECKFLAGS +=3D -D__LP64__=3D1
> CC_ARCHES =3D hppa64
> LD_BFD :=3D elf64-hppa-linux
> else # 32-bit
> CC_ARCHES =3D hppa hppa2.0 hppa1.1
> LD_BFD :=3D elf32-hppa-linux
> endif
>
>
> UTS_MACHINE is determined by CONFIG_64BIT.
>
> CONFIG_64BIT is defined only after Kconfig is finished.
> When you are trying to configure the .config,
> CONFIG_64BIT is not defined yet.
> So UTS_MACHINE is always 'parisc'.

Yes.
See above, but it worked when I had SUBARCH=3Dx86 (when running my laptop)=
.


> As you know, Kconfig files now have a bunch of 'cc-option' syntax
> to check the compiler capability in Kconfig time.
> Hence, you need to provide a proper compiler in Kconfig time too.
>
> When you build a 64-bit parisc kernel on a 32-bit parisc machine,

Please note, that we don't have a 64-bit parisc userspace yet (just kernel=
).
This means, that all builds on parisc machines are 32bit and do a
cross-compilation to a parisc64 kernel if requested in the .config.

> Kconfig is passed with CC=3Dgcc since SUBARCH=3D=3DUTS_MACHINE=3D=3Dpari=
sc.
> After Kconfig, CROSS_COMPILE=3Dhppa64-* is set,
> and the kernel is built by CC=3Dhppa64-*-gcc.

Right. That is the old behaviour. Based on the CONFIG_64BIT option
the hppa64 compiler is choosen for CROSS_COMPILE.

> So, Kconfig evaluated a compiletely different compiler. This is pointles=
s.

Yes, probably.


> There are some options
>
> [option 1]
>    revert the parisc bit of 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
>    This will restore the functionality you may want, but
>    as I said above, Kconfig is doing pointless things.

as mentioned above: Doesn't solve the issue.

> [option 2]
>     Stop using cc-cross-prefix, and pass CROSS_COMPILE explicitly.
>     This is what many architectures including arm, arm64 do.
>     You need to explicitly pass CROSS_COMPILE=3Daarch64-linux-gnu- etc.
>     if you are cross-compiling arm64.

Might be an option, but it's not as handy as simply choosing CONFIG_64BIT
and then things are done automatically.

> [option 3]
>     Introduce ARCH=3Dparisc64.
>
>     When you are building 64-bit kernel, you can pass ARCH=3Dparisc64
>      A patch attached.  (but not tested much)

Tried it, but doesn't work.
asm-offsets.c is still preprocessed with 32bit compiler (gcc, not hppa20-g=
cc).

Thanks for your help so far!
If you like I'm happy to give you an account on a hppa64 machine to reprod=
uce yourself.
I'll now try to bisect where it goes wrong. There must be something else b=
efore commit 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3.

Helge
