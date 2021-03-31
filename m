Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C335019A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhCaNmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:42:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:59547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235869AbhCaNli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617198081;
        bh=Fh27QhdX5NWG2/OE6D5afhTJn3PYHzOQVdDQRQt/Xg8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T0knC0VUWeqoWclDb1lGYcDEaARK9Fd6H8/rt3dj71+NY8ikASJWgj49L5Xxbd6ve
         OWWx6ClfxB1e2gJ2Y/MxCQhd/TrY6cedJU3W/sUdjqKgOwH9dUHXFnMeI7m/7N7fyS
         uf0LOg87niPRF0ZrREQY4G/QRzI3h4W9/iWqueo8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.138.106]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1m6g9N3T13-00hQKy; Wed, 31
 Mar 2021 15:41:21 +0200
Subject: Re: [PATCH] arch: parisc: Remove duplicate struct task_struct
 declaration
To:     Wan Jiabing <wanjiabing@vivo.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20210331012857.2799385-1-wanjiabing@vivo.com>
From:   Helge Deller <deller@gmx.de>
Message-ID: <06101862-156f-8613-1176-751e0eeacc26@gmx.de>
Date:   Wed, 31 Mar 2021 15:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210331012857.2799385-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JaeMRC1lE4KVlHYh7kPARfo9RIePTjJGIKg9Z2UN3vLyBXOUCjj
 GY9rfksQqdFtd+9r0b8rFwdtVtw/NsfqXxbcpLLQjfvzSqg5mnJCj8DDghfXpHKRAoL44Te
 /CxtVN1pjjbVKgU5tuR/1Wx6YWxGbJDgM7zqDhT+I/+ZVamASKVW3EwVkoqHa6iyYH/ZgrI
 KNN7pHZBKsYcJ6J3NgS7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q0vu69HpM1c=:bHAWXqtLCjBdP7TfpuPzJ/
 2y1jG0B1r/zHW60OamhIX5sO0Ud3c3Yn09V1FGaHeLi18zEnue1cUZYxQwslUwG9XjfZeLD1n
 XqDsAAkNUGx+QqFQb0dnxts9AP1MQ7jltDybdP42CBcyr6ekadvhJTcLY5rled34ERXsDyEFf
 JwbLrtZp9tKRYKbZE3fIwtgWYZEm/89nOfDp9557ufiDFiVQqxYCQVKxrV3AN1mnLHge4Dm6J
 aIEqmzqpzSLaZu4C4/x3dnUvx62Fd1Ajz42jVjfSzHJm/4oeXq/Ou+cTc3m2dD0o1U5hLb5MB
 oHIzp4k515Ickbw+yX7R88+MeXiM9gx17mh3WzFHndILTGuRO4hxoHOrLysGn+rdWZbR748rE
 SqN4/XhVKa6aU5Wp2p6PNvUpGgUIPNe+RxzVYSjggpddUhXpLZICgJZ6oiHqeEr7CYaFVotJn
 OsMykGWdZtySlteJ6WQcyPEesd4S6Uqbn2gUEcrbzDNvGZJ43j3wKrhh2Ya0GlkQjHO/53Jl3
 ASvjQoNTj5liaDj8iHej+UzzA+MOv93LFAup2ATZ+Ty1gM5aHaYLi/ox38VA48eavYegV8Y6a
 2j6FrgeLyU6DxQspHfwB/StFFBerSkYRpY0RsJFh9BJLteOT3Ukye+4JX8VYW/nQwakBAozC4
 p6kXpCXePwKq2qaWPDMwEzbdGHPQxfxkqsPpys3YOiLRLx7/4Su3wdB2LxpodgTJoih1pRIue
 lcmpI/xRklbJYTvPsVVUtXH6KiNUsDNkBO7s3oueflfllo4IvQCOfRydNCcP7WLUhczCsv3gs
 a8jyIj0alLW9Yy7HopIv5tLXHwmXE6vBF3hA0wxUyJIM8mX02L26YioyNO79sG7LPDGFFtvFI
 6C71L47m1nIHgRW3bVT4wKZ8o5QT5ClWpvJXsDLZuaK4Q0PP4+BNDMvcdkmDRbMGu+s+ZasDy
 3fCzcucrvkNrlkc7+ikkPwVjPLbOlzbpUombBft8ZUm647IBjtBaFeTB75767/yt7+vRooYwn
 j5JKnH63uqMeqJDjdZkFcGxV0tPP8lNRsqwckDAwPdnQ49jSeOk2cKByyhh++tXS+yax9AoKl
 381jVxo9a/Bvp/IU8FsWg8ilBHRYh1nS02+oAa+64azKut6ji2MGPe7EXJ1oyTZ3/ggzO5m8Y
 Q3iLJf59JSUPNIa8QAWiQP1yTQ3Mx52seAEfBQVpcDCUZQrXsq2rv6HUVjGcZFVNK0I9c=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/21 3:28 AM, Wan Jiabing wrote:
> struct task_struct is declared twice. One has been declared
> at 154th line. Remove the duplicate.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Thanks, applied to parisc tree.

Helge

> ---
>   arch/parisc/include/asm/processor.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/a=
sm/processor.h
> index 11ece0d07374..b5fbcd2c1780 100644
> --- a/arch/parisc/include/asm/processor.h
> +++ b/arch/parisc/include/asm/processor.h
> @@ -272,7 +272,6 @@ on downward growing arches, it looks like this:
>   	regs->gr[23] =3D 0;				\
>   } while(0)
>
> -struct task_struct;
>   struct mm_struct;
>
>   /* Free all resources held by a thread. */
>

