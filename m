Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22903459516
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhKVSxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:53:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:38847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231699AbhKVSxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637607015;
        bh=lE3hAYAJQ/qcZuhnjnZSZiuOuT/DfD3hCHSy2l/ZcKY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iZNE1qYAdNggYvvHnI1iXOeHZZDLCPok5FMHeTrEaofLth4vfMGuqOv6PXrfVFxyh
         JA2pGf2teC4l4sNsMjX2+52akiVDoCylI2gsZ+Vbqm/i/7UNAyCfg1sTqoo7RUjglB
         OqLsJdA5mOXM4W4FfcgVF6ZXrhzp9jRdebkf0CuY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.29] ([91.137.126.34]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1Obh-1mdAqa2pPX-012msj; Mon, 22
 Nov 2021 19:50:15 +0100
Subject: Re: [PATCH 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and
 i8k_ioctl_unlocked()
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-3-W_Armin@gmx.de>
 <20211122160122.gf6i3qj6dnwi6wla@pali>
 <c23caeab-dd27-4c95-2e25-9eb0ff7b33f6@roeck-us.net>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <e336f501-fe07-7b49-bc65-d6ca443491ca@gmx.de>
Date:   Mon, 22 Nov 2021 19:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c23caeab-dd27-4c95-2e25-9eb0ff7b33f6@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:+U/yhAZc+ahbuRqVIOPG9v69dobZxB22akiDB1NPWd4KQe/RxYv
 hryo/d1U9MbBVhLIomW+lHTcf251+ViwN9MH6ePZv/4mqm32OKLQwVBI43wwRBDtytNPwE3
 NhlXCFzkGW8Sbfk71OdqPaoEnpul48/uSpP7z+b2GGPDDQq2JFp3ECYILPz39zHplc34V9r
 BwKTDpLVRQDD+NwLbvTkA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cwXnVz/4slc=:VVaZm5GRAYQIDMV9v52Nbp
 AO6k8BcaHoNCAz7NTeBxp/CM43hJO2cyq/BtzRuL6cT5WeDBn5DKNlRgWCDazPhjmS5JtEhhC
 BRork3Qlaye2F8l//brh1Derch1VJXPKSHcqNgg+MXVmBiCnsgke6wAUEZWatrEFihqvDOlY9
 f8RNDVHEG+It1PwyFtGzouQfjR7irLDO2hrGUrkXOwZLSSCVTc2uWcdDJoF1XKFh7mF9B24vP
 J3xdjcNuQhn66+rdRKSHZOssAAqU7/JW1heyssIEskXpY6daAsNiufxfJn6Bn3WJUotlFYGGM
 a+ywYUZb9OT7lo7DC0b3m8Pn2HbOQ2gp84KVh50wkn/8a3E9MSYBuII++K/dcCIrGE9lr1y1N
 yEsHSGtdxE78/GuWUvy1bkX/1ymtNTvlkpitdJaqHtxkfyesfJbfvpHS96e323cU2rAUA7YdQ
 8/dm6ScCaXmklLu7Fko27uMj13iTTBIEs0ZE+O1y7SDZ5tXosufxqSr7ectCKVee9oGVpO+q4
 QLAmBBZ7MT1uU+R0BeI2z8Rqr0jGYR4zlYoH0MISNbaYvfh5Fnt5gxaMXUPcHfUxQ9MmiqWgw
 npeZypUo0HHQ5JZck+EPXfwvWokolN8yEXqjyWuRT935+zgiDkHvVruuvQRmJQGzr51Lh8yKr
 /IB9JlkoWjtbI3+iHxrdUz39AZ6EQCK2hStRvvPdK1hfh0EBluST8TEPm84EBMLja8bVwrppH
 JL1+E4z5T7+ZYTatwlGoof4tcc6lVkPK83rEwbowhsM+d2PYVicfhLOlm/iSrdXpEplWfc8cu
 Uv+phswh1plpkDzr+v+K5g46s+bwjXb4iz7J+Rs7mKeq8UctI6mF5k4foK8oI2LLZdKLdaBXo
 mCFLiITc42i/O9t/fB/hpgZqCBJi6ZbvHNJ6EyfkKqcqVzYtx1+8LITCip+pI0f89M063r/D1
 yC8iX0ruarJZL1WKWHsrPTw/FpQOars7aHAd/fxpULwerIsgWfXhOQVSaqjNFsHuin3W0jJkO
 gkO9Q/uXMowozvCJcH7hFQDvbzrMpuQvTWiw3FIi//me1D4DYRUGGdB1oyeR+VuX7WBxoSWOx
 oa6V1RsreqAzMA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 22.11.21 um 18:55 schrieb Guenter Roeck:
> On 11/22/21 8:01 AM, Pali Roh=C3=A1r wrote:
>> On Saturday 20 November 2021 18:03:19 Armin Wolf wrote:
>>> The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
>>> with i8k_mutex held. Judging from the hwmon code, this mutex
>>> only needs to be held when setting the fan speed/mode.
>>
>> Really? I think that there is no difference between setting and getting
>> fan speed/mode. At least I do not see why 'set' needs mutex and 'get' d=
o
>> not need it. Some more explanation is needed...
>>
> I8K_SET_FAN sets the fan speed and returns the current status. Without
> locking, the returned status may not match or be associated with the
> previous
> set operation.
>
> Maybe that doesn't matter, and the synchronization is not needed. If so,
> you can probably remove the locking entirely.
>
> Guenter

That is the reason i kept the locking code. Since i do not want to break
the ioctl interfacein any way, removing the locking code seems too risky
to me.

Armin

