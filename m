Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5023B8D84
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 07:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhGAFzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 01:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhGAFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 01:55:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B74C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:53:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k10so9564369lfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 22:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nTQU7wEFq6JVSvSTnTKC7ide9Twk5SOoZt3/8VCj47g=;
        b=Zr+6zTRsDmGZAuTZgQ/HaZ1YLyqlzYuLKGv6ZwnVJr60ilZ+fOSmvkTum5b76Tm0Wo
         FfZVraNlLQERuIEPTZVNRUNxaK5jUlh60YPSv+bKw5rL3FdwUkCwla+slBSoeNvrDJaG
         fgiU7G5/Kb6z+bjFW5CBFTcZMTgvOQHpC6qeGYjXqcQjC3wv/1D1RJFJjKNGJhoNHg2s
         miGwSnyyTkP5/FShOITqeNffihR1p88tzp4udypF8dxqa4eeIuD9n+GMo6H1QfKHRWZ5
         L3I02TzE3jKO+alRfPHN1BkV+nTUW0/fjGVwOL85K1BipfLLlU9kF7F670PgidnYxCts
         ePXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nTQU7wEFq6JVSvSTnTKC7ide9Twk5SOoZt3/8VCj47g=;
        b=ExSYijaNbcXTZGgHvRlzFnABu62pB42lVyZt3BiRhJK20rT5yYdjjVmZBViKF1wZ4y
         iumT9Zvk3Zhu7AQrz/zzqJ166Yss6FRBtKn5btM0vWcD4CAcIaT+ECtYEx3Dt7nssWKx
         4oEo52wSDPMifMVCCFzz1lCH1htyTCxrQh0J3b0/fLzZLj8CrBanJ9QdQwOhhzjBaHwJ
         W3dc7CWgmRNVG9/6vUrSxCDhVaPr9Dl6FL4SHOPGjOcMWhUNEzHT16VDPdfLA5/mnQ7f
         EXBAxnq+7oxwB90PSnBwfC95tEcDyLoPVedK5LpgBvrCIDUbdmupS4EXX5n/shNY8pac
         NK4Q==
X-Gm-Message-State: AOAM531dLDd/zCi9LH2D5+Kn4+rDt55SHpyZieC1RsR/2eAKZWxAz+tr
        fXBowM8BQb6F0ncw8hhro9+obATt5r5Qh1le2gU=
X-Google-Smtp-Source: ABdhPJz7BhP5K9G0zeAIH4CU8KZ0/vKDwBWFwVLt3Ay7aSmqDTW4JhuZckbx04fBH9geMOrb2AtJlgTi4QZsZ1Yq+yU=
X-Received: by 2002:a05:6512:32c9:: with SMTP id f9mr25914900lfg.638.1625118795090;
 Wed, 30 Jun 2021 22:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <1625111646-3955-1-git-send-email-u0084500@gmail.com> <CAFRkauCNf6fP8zAz+0gY_Vzb_wCtVyYqLjw8s1T+t2s=bR0RQw@mail.gmail.com>
In-Reply-To: <CAFRkauCNf6fP8zAz+0gY_Vzb_wCtVyYqLjw8s1T+t2s=bR0RQw@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 1 Jul 2021 13:53:03 +0800
Message-ID: <CADiBU3_dCNvZRwewiztB0UGFvDz3g5sw-q+95sg9akqte1YJsA@mail.gmail.com>
Subject: Re: [PATCH] regulator: rt5033: Use linear ranges to map all voltage selection
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Lin <axel.lin@ingics.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8812:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> cy_huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=881=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:54=E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> From: ChiYuan Huang <cy_huang@richtek.com>
>>
>> Instead of linear mapping, Use linear range to map all voltage selection=
.
>>
>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>> ---
>> Even though commit 6549c46af855 ("regulator: rt5033: Fix n_voltages sett=
ings for BUCK and LDO")
>> can fix the linear mapping to the correct min/max voltage
>> But there're still non-step ranges for the reserved value.
>>
>> To use the linear range can fix it for mapping all voltage selection.
>> ---
>>  drivers/regulator/rt5033-regulator.c | 23 +++++++++++++++--------
>>  1 file changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/regulator/rt5033-regulator.c b/drivers/regulator/rt=
5033-regulator.c
>> index 0e73116..2ff607c 100644
>> --- a/drivers/regulator/rt5033-regulator.c
>> +++ b/drivers/regulator/rt5033-regulator.c
>> @@ -13,6 +13,16 @@
>>  #include <linux/mfd/rt5033-private.h>
>>  #include <linux/regulator/of_regulator.h>
>>
>> +static const struct linear_range rt5033_buck_ranges[] =3D {
>> +       REGULATOR_LINEAR_RANGE(1000000, 0, 20, 100000),
>> +       REGULATOR_LINEAR_RANGE(3000000, 21, 31, 0),
>> +};
>> +
>> +static const struct linear_range rt5033_ldo_ranges[] =3D {
>> +       REGULATOR_LINEAR_RANGE(1200000, 0, 18, 100000),
>> +       REGULATOR_LINEAR_RANGE(3000000, 19, 31, 0),
>> +};
>> +
>>  static const struct regulator_ops rt5033_safe_ldo_ops =3D {
>>         .is_enabled             =3D regulator_is_enabled_regmap,
>>         .enable                 =3D regulator_enable_regmap,
>> @@ -24,8 +34,7 @@ static const struct regulator_ops rt5033_buck_ops =3D =
{
>>         .is_enabled             =3D regulator_is_enabled_regmap,
>>         .enable                 =3D regulator_enable_regmap,
>>         .disable                =3D regulator_disable_regmap,
>> -       .list_voltage           =3D regulator_list_voltage_linear,
>> -       .map_voltage            =3D regulator_map_voltage_linear,
>> +       .list_voltage           =3D regulator_list_voltage_linear_range,
>>         .get_voltage_sel        =3D regulator_get_voltage_sel_regmap,
>>         .set_voltage_sel        =3D regulator_set_voltage_sel_regmap,
>>  };
>> @@ -39,9 +48,8 @@ static const struct regulator_desc rt5033_supported_re=
gulators[] =3D {
>>                 .ops            =3D &rt5033_buck_ops,
>>                 .type           =3D REGULATOR_VOLTAGE,
>>                 .owner          =3D THIS_MODULE,
>> -               .n_voltages     =3D RT5033_REGULATOR_BUCK_VOLTAGE_STEP_N=
UM,
>> -               .min_uV         =3D RT5033_REGULATOR_BUCK_VOLTAGE_MIN,
>> -               .uV_step        =3D RT5033_REGULATOR_BUCK_VOLTAGE_STEP,
>> +               .linear_ranges  =3D rt5033_buck_ranges,
>> +               .n_linear_ranges =3D ARRAY_SIZE(rt5033_buck_ranges),
>>
>
> If you want to use linear range here, you need to change RT5033_REGULATOR=
_BUCK_VOLTAGE_STEP_NUM back to 32
> rather than delete the .n_voltages setting.

Sorry, I really forget the N_VOLTAGES.
>
> I'm fifty-fifty about the change because I don't see any benefit with con=
verting to linear range (even though in theory it's correct).
> The voltage of all entries in the second linear range is the *same* as th=
e latest selector of the first linear range.
> When the regulator core to choose the best selector, it will always selec=
t the latest selector of the first linear range if it meets the requested r=
ange anyway.
> (Because the entries in the second linear range are not *better*, it's ju=
st the same.)
>
> If the initial version is this driver is using linear range then it's fin=
e.
> But given the initial version is using linear so when I fix the n_voltage=
s setting I decide to not change it to linear range.
> This makes it easier to fix older versions if necessary.
> (I'm not sure if linear range is available in some old kernel versions, t=
he initial version of this driver was committed in 2014).
>
>
From the regulator register in probe, it will get the current voltage
from the IC.
If the vout sel is not is over N_VOLTAGES, it will return the error number.

But as I think it's the side effect to change the vout step num.
To use the linear range is just to guarantee all vout sel range are include=
d.

That's my initial thoughts.
> Regards,
> Axel
>
