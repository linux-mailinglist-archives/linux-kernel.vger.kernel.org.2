Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D53DDAEC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhHBOYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhHBOYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:24:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6FEC04F9C9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:21:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p21so24702739edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B04BQlaidpyijFU7BfQqGywEVs1HZBYHBKlltsjDI90=;
        b=YVU0Bpk96bXf7jtBLka7c+7Ieyp2hOvD/9a4h+Ew6gDmJfIymH08r5vepGlrNkKGr5
         dvLp3gryXO5s2oPaBynZiWY6IoU48sCOYCYFxk23VRnqMx/ffniFp+nvY/gAfZgmcikl
         hHaupRCoElpbiB4l4yBZ76eFtpW5RK2dk5THxytHa+YPDhWozkraWqQ1X7hygn2LtgQl
         ljc5jF9zcIdRY0jen+32nDAmbHoiFDz1z0DXYl40D9kq+DwgI9WW+zfuM7EU0ZdmPyx4
         rHQr8spoV5ZgHRZvMG3Nite0vkD890j6qUvxcUTYCuKv+zmMJG7UaoFBq3e3FIM6L/Bg
         PP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=B04BQlaidpyijFU7BfQqGywEVs1HZBYHBKlltsjDI90=;
        b=G6UXQd7QfPhzkyOIpAGS3ZLCfW7mVZnLp76p0GCeIMmLXKeYjiXlE0YxWW3S3XPA7n
         wCaHo5ZBot4nO3b7fBmFHioH4IhCs5N2gC9CFjKhI6k2Cujsw1mNtOdpZ9PS9uHLxjEv
         COr9kR57nkHC3VVayIDx2A95NZWQTcrzaWgHDJiCk3uAZUFksK8afUM669syEnMaw5zL
         jcrvTt5TcdlXiSHO5qJKMm/TTv4XPIsarNMaYUR+fpKOneDf5fEzgoHKzLkN5b3YZrhP
         Wmoi1y91tDwOx4AW3i9Q88Ymbqq6qr8soNnPleLijrQtCTS9BAysa3ybh7kAXnM0Pg33
         ecdA==
X-Gm-Message-State: AOAM531Q7BxknNLd8g6duxo+K0DXUD87vGhDkJGcyJ9qpI+6z5edLCzp
        uSyy6XfxJprnpBGNRoH/vn1cnwyQtRQ4y/q0
X-Google-Smtp-Source: ABdhPJznZzNC0wMuspVUsQeIYsfM4FxhXltAmdVnA7v7Nh/p4VfUQklWQod0HSywbyqw5f38HwyWJA==
X-Received: by 2002:a05:6402:1778:: with SMTP id da24mr19784630edb.385.1627914082435;
        Mon, 02 Aug 2021 07:21:22 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id r27sm6264721edb.66.2021.08.02.07.21.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 07:21:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: 5.14.0-rc1 KASAN use after free
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CAJfuBxwJam5=s3Rr06RyLoO19s3HTBomnNi6P3dw59s_b7we+Q@mail.gmail.com>
Date:   Mon, 2 Aug 2021 16:21:20 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE6B2429-5846-4EE8-896A-691BD11C76D0@linaro.org>
References: <CAJfuBxxVEVwj=hGa+FoQUV6i7BtoUbiJwGunnRq26Fp=Ax2ziQ@mail.gmail.com>
 <8057650.rSI8SBESIY@natalenko.name>
 <98103103-c517-59d2-a4d6-9b0758cbdfc1@kernel.dk>
 <CAJfuBxwJam5=s3Rr06RyLoO19s3HTBomnNi6P3dw59s_b7we+Q@mail.gmail.com>
To:     jim.cromie@gmail.com
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 23 lug 2021, alle ore 15:08, jim.cromie@gmail.com ha =
scritto:
>=20
> On Sun, Jul 18, 2021 at 5:58 PM Jens Axboe <axboe@kernel.dk> wrote:
>>=20
>> On 7/18/21 3:08 PM, Oleksandr Natalenko wrote:
>>> + Paolo, Jens et al.
>>>=20
>>> On =C4=8Dtvrtek 15. =C4=8Dervence 2021 16:32:29 CEST =
jim.cromie@gmail.com wrote:
>>>> hi all,
>>>>=20
>>>> I noticed this report this morning, from 3 days ago,
>>>> about 10 minutes after boot.
>>>> Its easiest to ignore it, and I dont want to make a fuss,
>>>> but it looks useful to someone
>>>>=20
>>>>=20
>>>> [   33.663464] Bluetooth: RFCOMM ver 1.11
>>>> [  646.343628]
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [
>>>> 646.343649] BUG: KASAN: use-after-free in bfq_get_queue+0x47d/0x900 =
[
>>>> 646.343680] Read of size 8 at addr ffff88810d864a00 by task
>>>> journal-offline/1639
>>=20
>> There are only a few commits between 5.13 and master in this area, =
see
>> attached. I'd just start reverting from the top, one by one, and see
>> which one is causing the issue. Jim, would that be feasible?
>>=20
>=20
> oops, didn't see this earlier.
> It hasnt happened since, I can try to recreate mid-next-week
>=20

Still nothing?

Thanks,
Paolo

>=20
>> --
>> Jens Axboe

