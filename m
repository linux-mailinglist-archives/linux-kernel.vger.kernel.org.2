Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFA4517AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 23:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353568AbhKOWjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 17:39:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:50839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242173AbhKOSj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637000355;
        bh=kDTTxeQL+iaRkBJyolOd9ExP4hH800Y+fJt+6ppb7FE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UF5rlDtkXMiVNUUBQuBawETGl96mcsTCd2zcUCSDE+kdemxUvldaw5eaIXtIP1T5I
         uCNGA6g2quiB9zZQSGRJQotVpMBrT/0GnVf7r9rt5XCch5+9xiVk6J++LkfESexjaE
         /tqQ6oA3OpOsDNO3lTZDwOvcuVPXZiLqk1OpO4Tw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.172.2]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wuk-1mjOn134bc-005dTx; Mon, 15
 Nov 2021 19:19:15 +0100
Message-ID: <1d843bb8-64d8-cb17-29c7-9eb60a9bed38@gmx.de>
Date:   Mon, 15 Nov 2021 19:19:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Linux 5.16-rc1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net>
 <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net>
 <CAHk-=wis4sMKEB1EWJW-+jgc4j31S297sx7nq4a_MS92r8-HgA@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAHk-=wis4sMKEB1EWJW-+jgc4j31S297sx7nq4a_MS92r8-HgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:or6wmldag8GoQPpdkqhNhtbeGwdeWhaSw1PfEkPEnt65gZYwlSw
 8cWFWkFm/Ff994oGYWJSirweWJkuwpgLDSlAW+gKNXr+TtOQ5UjaWruWx2E6BKmUZEeKx1F
 yVVF/Z8d9DeWc3v+XHjfqUePZfjtaTR0eGYcnvxppX48g5zF2REIcXc6Kk+MrF/fugSG16d
 JH01tndZiHHT9BEIoZIfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2djuivi6hMw=:3yfE1fWJYmqEiB6L/DiJMb
 /gNd/R0O5bcsI1nbAjU2ywbGwl+GCdH0GQgw3vfTGh8PmGrhxlFsE1e5YmHTxpdLGQ9EBH32C
 XaAM6GPqs/2c3TNcbH38iKxQt2FGIwwCap06OE5VhPqsIRPX5xQW//tRiBEwWMOvZ4qGi3XmO
 hnKfT18if9Pwj9vX3SQoUjugxeKt5OYJHkJb7mtYmjE2RXhpEeKcV4G0Rzoq/+B+CWfRuitjW
 +r3f7nMc2IVFmNf2rXYdlGKvoGJOXjqHpC7Bk1zFfPGalwcSLjh0addBNW4pr62xgVeJDm6Fp
 x5rcM5nSfeLat4+kSjhQLHoRrW/dO62J4UCfHjl7+GAHUePBffKywCykeyX36hSvHVZoBNpVP
 2CoDZQHCm0MH4z2vdTspZtxEd0O8Zmp2KYT23b2B4SAY5KZcvYuyxEMT4mEUxTaLnwtztueEZ
 QNrASOYNqDewKEEvACJBt3K6HXPA6YQV6kVUGepaKM+Vzep0FetbxUO00UsLwKCFXOnzMOxNX
 1ijLvWIAZGGYQ4D1n3El4p2Nb+c+8cc1mtgRe0v8MCtH8rKKysUDO3Yt+UFfSR3029tC7hUmK
 FkqnCDdtRFiy2oB+cHoYmDise29patL+0xCirp9l8rQmhcaU0ERxoDar78++DoqaW8MXmeR6u
 SvLYY52neBLhVOmOyFf2w+mBr0WUYF4VVrpHktdcAhx16CajHicyvZat2QCWSt/WOu28BPqlf
 wbzV4K38NzJ0KRoRNRATKAS04lkEScF07B4aSrA7Pz3hAG+Y2i/neD3Vw9vIvn0s4zmieuS4D
 mVrdcp/oLJFIixaZ6JVIpiSeZGdD4/ngB3emMU35ts1ojgu3GCiinX1SH/QOvQZ61fBI3R66G
 jDw9YFjHT9lK/tAf4DaA3JMArlnqsdwxOihnYfOoZfW6biXG70GY0/Gh8fl4VvPVnD5+blH0H
 A+ATfeDytuuSai/xcCERiNd1RY/gTbZ7uNgLLMyuKshu+EIVzq7gA2imzkNBEefNb2mlq87YG
 HyvLNkAB2Ga46s604i6+gahNCmv3zOVXMJrxs3DlBZoxgxyrnvsl/9w9b3MEE2UpQS2E6E+ag
 X2gUCtxUc5U/2I=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/21 19:10, Linus Torvalds wrote:
> On Mon, Nov 15, 2021 at 9:07 AM Guenter Roeck <linux@roeck-us.net> wrote=
:
>>
>> parisc:allmodconfig: Lots of build failures in arch/parisc/include/asm/=
jump_label.h.
>> Not fixed in -next. The problem seens to be related to the thread_info =
changes,
>> or at least bisect points to commit 01463374c50e ("Merge tag 'cpu-to-th=
read_info-v5.16-rc1'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux").
>
> I don't think they are related to the thread_info changes except very
> incidentally.

Yes.

> From the errors ("expected ':' before '__stringify'") it looks like
> __stringify() isn't defined there, and I do think that header file
> should include <linux/compiler.h> to get it.
>
> I don't actually see how that merge commit you bisected to could
> possibly matter (the diff doesn't show any header file include
> changes, or any parisc ones), but I suspect you might have bisected to
> it because we did end up having actual thread_info errors on parsic
> that weren't fixed until commit 2a2e8202c7a1 ("parisc: move CPU field
> back into thread_info").
>
> So I suspect the parisc build problems started with thread_info issues
> at that merge commit you pinpoint, and then by commit 2a2e8202c7a1
> some other header file simplification had exposed that "no
> __stringify()" thing).
>
> Helge - apparently from allmodconfig and others, we have:
>
>    arch/parisc/include/asm/jump_label.h: In function 'arch_static_branch=
':
>    arch/parisc/include/asm/jump_label.h:18:18: error: expected ':'
> before '__stringify'
>
> and others, which does look like just a missing header file (that was
> presumably previously implicitly included earlier, and now the
> implicit include is gone).

Yes, a header is missing.

I fixed it an hour ago in my for-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/co=
mmit/?h=3Dfor-next&id=3D3ca6cc35f0c8d268b5d35e02e92b1ee99b4569d6

Helge
