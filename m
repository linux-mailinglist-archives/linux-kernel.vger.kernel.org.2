Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7167E35019E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhCaNoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbhCaNnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:43:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5DCC061574;
        Wed, 31 Mar 2021 06:43:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h13so22365878eds.5;
        Wed, 31 Mar 2021 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+ghmHWrd0VtTpXMMo8zY7Xh4t5dWaWkK420iWQuOzE=;
        b=hFVHUo9h/qlKnYSMTOoSPd1LJIxEdbBrg1QzBaoV1NgiHXV82hcZF5wDR7N/NMfntB
         P9iTvb0REKeFfTPA+wNQXPS4nF9eJrImstfcWCAQ3UXKg5DhBVGmV+0LMSz3pIbLCQuM
         QstQ4CsPDUJ0P6Fc9PZ5Ofhzk2Ik1GtngZraiVa6Q1E2bhUQr/P5Zkx7W+DMKbHyo8I/
         As6aVdD386AX/0TQxCF9sHgFQiG4iQgAEVeADY2F6rFWsaVcwyVsHNzgBe0+iyDUzAqL
         AZeDsF89/FiSqD5oaPbgd9wP8thzcL+ZcWQlbBgziupIha7+tAPrIzJCab72jFHK/0/M
         WAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+ghmHWrd0VtTpXMMo8zY7Xh4t5dWaWkK420iWQuOzE=;
        b=sdfbcsgt5diK2qw2ah48POCBGEuGSIa9vUHmsLiQl1aWJfp2At4WPKcZ0FQXVA1oJ0
         pMTtNEWE2GLJxKzkjl1asGTaUi/2Pdh2McxyMGun5cW0IScPM8REMFLn1CnUlgg8oNMs
         hev8JV/5Nu5kFAMyLrWVGatWCQfJngAQNJe00nWMNXyLA1Nt2NFmTXOcI1/C6EeSGTtG
         sHmbP6CNaQOpz94Lcx+pkB5aCygFSfeBwKDSCgqAVxZs1xg8F8R/kL2puXOfcYYoBpgg
         zw9n4VsPbYGRGmfFOyW3rLMmkrK8lNuXgbfADPFAyfRhHqIISyToo3vrJibR5CSRygrs
         OT7Q==
X-Gm-Message-State: AOAM533vxwOzBZuvMM0EOZl7Rvn6IBdez0sO1JlwlTYdIM3aB0CYdRoO
        c6s774lWIjCy9r0MHWnymjGJjRSqCer5+XsYCkU=
X-Google-Smtp-Source: ABdhPJx8TL94WZcE0wlBpqElMqz9jeHvusM9qw/17ly9e8PKWRwngPkeCU2XsHwzp8Y86umlehcxte6M1qgFNMsnZh0=
X-Received: by 2002:aa7:d687:: with SMTP id d7mr3771645edr.118.1617198228074;
 Wed, 31 Mar 2021 06:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210330184218.279738-1-jernej.skrabec@siol.net>
In-Reply-To: <20210330184218.279738-1-jernej.skrabec@siol.net>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 31 Mar 2021 15:43:37 +0200
Message-ID: <CAJiuCcc4hs781Hz_=tehcm4S2nci8e0DEJKeUY5ck=bpcgNUbg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] arm64: dts: allwinner: h6: beelink-gs1:
 Remove ext. 32 kHz osc reference
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Tue, 30 Mar 2021 at 20:42, Jernej Skrabec <jernej.skrabec@siol.net> wrot=
e:
>
> Although every Beelink GS1 seems to have external 32768 Hz oscillator,
> it works only on one from four tested. There are more reports of RTC
> issues elsewhere, like Armbian forum.
>
> One Beelink GS1 owner read RTC osc status register on Android which
> shipped with the box. Reported value indicated problems with external
> oscillator.
>
> In order to fix RTC and related issues (HDMI-CEC and suspend/resume with
> Crust) on all boards, switch to internal oscillator.
>
> Fixes: 32507b868119 ("arm64: dts: allwinner: h6: Move ext. oscillator to =
board DTs")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Tested-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index 669d39fc716a..6249e9e02928 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -289,10 +289,6 @@ sw {
>         };
>  };
>
> -&rtc {
> -       clocks =3D <&ext_osc32k>;
> -};
> -
>  &spdif {
>         status =3D "okay";
>  };
> --
> 2.31.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/20210330184218.279738-1-jernej.skrabec%40siol.net.
