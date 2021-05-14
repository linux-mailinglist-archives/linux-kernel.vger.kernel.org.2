Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49683380270
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 05:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhENDYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 23:24:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55575 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhENDYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 23:24:48 -0400
Received: from [IPv6:2607:fb90:8499:54e2:5b10:3bfe:8ae:a691] ([IPv6:2607:fb90:8499:54e2:5b10:3bfe:8ae:a691])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14E3NK3j3045135
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 13 May 2021 20:23:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14E3NK3j3045135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620962602;
        bh=8ynf+5yIPfkNq8YcZl5TieOBXA43cui1r+6yFVD+gO8=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=AeOEYqb9+kkf8bTzwy4w2F5d6iM2z4NizowWTSxFPH07fj5KS3w+puziaveDKXwXD
         /Yz7jw5ja6MlpYtIgzQquDuW2WkaQr95c16af+CtA4w6wxLL8J3Djojb9av36HbG2j
         UmIc1uCPHD0vWD7W0xZGDVrzP63TgD5fAx4SVdcV+OuzY6MCjD8qieBMafirxhfHG9
         JxN+MSwL9kvQfpgcgv6MVs/dEWX//g6ibKzJL7DGCWaGooanNNanSE7qgAKCS1p4dH
         y4slwDbLP0I2X995QyLYaZiF2sRVS1G6WhrsRO9QyJcnlyv9D8PKWCbTSy6M1Xdh+x
         hjhTgNIoAOtBw==
Date:   Thu, 13 May 2021 20:23:17 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <57bf2ff9-11ff-0907-975e-15177df72144@linux.luto.us>
References: <871racf928.ffs@nanos.tec.linutronix.de> <60495dd3-ea68-4db3-47ad-b7b45796bf76@zytor.com> <87o8dfer7k.ffs@nanos.tec.linutronix.de> <b0ca952a-fd82-7833-ac82-ea8ecad48b53@zytor.com> <87mtsz619u.ffs@nanos.tec.linutronix.de> <b6f47bd3-3e4c-7200-befe-5e14fecf3da7@zytor.com> <57bf2ff9-11ff-0907-975e-15177df72144@linux.luto.us>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle all invalid syscall nrs
To:     Andy Lutomirski <andy@linux.luto.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <486B4C98-FFD1-40B9-B7AF-5323DE07A0FE@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah=2E Also, x32 long is 32 bits=2E=2E=2E

On May 13, 2021 8:18:37 PM PDT, Andy Lutomirski <andy@linux=2Eluto=2Eus> w=
rote:
>On 5/13/21 5:38 PM, H=2E Peter Anvin wrote:
>> On 5/12/21 3:22 PM, Thomas Gleixner wrote:
>>>>
>>>> As far as this being a user ABI change, this is actually a revert
>to the
>>>> original x86-64 ABI; see my message to Ingo=2E
>>>
>>> I'm not against that change, but it has to be well justified and the
>>> reasoning wants to be in the changelog=2E You know the drill :)
>>>
>>=20
>> FYI:
>>=20
>> So in the process of breaking up and better document this patch, I
>have
>> looked at the syscall_numbering_64 (and have rewritten it to be more
>> complete=2E)
>>=20
>> I found that running it under strace fails, as strace (possibly
>ptrace,
>> possibly the strace binary) causes %rax =3D 2^32 to be clobbered to
>zero
>> already=2E=2E=2E
>>=20
>> More motivation, I guess=2E
>>=20
>
>Indeed=2E
>
>I would love to go back in time and switch to long, but there are
>plenty
>of things that use int now=2E  I suppose we could try to make it long for
>real, but seccomp has u32 baked into its ABI=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
