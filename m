Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8653A0AAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhFIDfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhFIDfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:35:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D84C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 20:33:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id og14so30780225ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 20:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zh4dLowpRXamYp3qLRzT8y8IQ2eyrjVOw7NGJBWBd3s=;
        b=kx0NFa7eVUmlTIwYyMYE0NrK1MqlpkUXD7Qn/ZnPU8vB9VPdBpETgd5CtFNOU5C+Ij
         Vfc6R5bVN04CpVTyjTHlaesWnJ4eDPmyYrLBmVFWnOYRSPtvgmkq4O6Jj3LkbsVOX1/t
         2VHDNdek7/GckTaAJ6doa1mIHKPl4oBJuOaa5UmrDbh6Eo4P2/fQu1gFeH6BS38vcmQh
         vmycU2T5v7o0+/e2egZTWwYNstVcLK3NHDhu5ekqbE8FVXIEu0mYNT5YGEq/uqApWv5S
         dKKFPUpieTpVsD5/Z85vhX/9kp9RSPs6l0V+23UHE8hk2fAbEEl+GS4mctpLGiVMTITE
         7coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zh4dLowpRXamYp3qLRzT8y8IQ2eyrjVOw7NGJBWBd3s=;
        b=q4QlSPmPNkKW5iAXe7oJHsyxnRhNGYXBBneo3Tph8sZUfLgS20BAmNoy82lRwOrTDo
         bErNgOnx4CaJ7NBG3anjztbnaPdNnahW7TuJiaYsTCybooP5mw5ce++QiqBez4zwRi7k
         Cyn1lUMEychQCLUe26It1o5Bc/624PRpl5y6sE44wNYhXRLLW0jjh84fOfOm5uPcUgZy
         v2CU7mzPGH3x8Pygl7r8YVrUWnGuovoT81XcgcEFx9q0NIfLxCP8LyKaXbVPKfPtUFxZ
         tmcx3DDAwPloOdbmxM3V11ZKBkGUpN2tya1Iq11Zyzy5N9t1CzgPa5iKfDln6FjYivg9
         fcOg==
X-Gm-Message-State: AOAM533u1hyBGJutNqHEmCRx34leqTuSbHxXlOZGhWOsxyhtlgBGcqvc
        2Ttz7nTT4+KSug5sc4HVyfB0B/og6nIx/6aT4vA0Ww==
X-Google-Smtp-Source: ABdhPJzXX6AztZqfG/lrJFiX+qSKFP6XRxwYY2PhkyKN0OhEweSPGTqwO+Z1KOQu01E58Z8LfS/cF9NnuIyl6L4XV4c=
X-Received: by 2002:a17:906:ae85:: with SMTP id md5mr26453737ejb.301.1623209587161;
 Tue, 08 Jun 2021 20:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093809.1108629-1-axel.lin@ingics.com> <1622715641.1034.5.camel@richtek.com>
 <CAFRkauDs6nyuboPBf9Q-=KDFkSjwQ4z9mDjzm3o95uzdu5bKCw@mail.gmail.com>
 <1622716902.1034.15.camel@richtek.com> <1622733524.3635.10.camel@richtek.com>
 <CAFRkauCKoipBe4-QacQbjZgWuFrMPKdAfWB00Q6Lyw7xJ=6sfQ@mail.gmail.com>
 <1622773474.9011.14.camel@richtek.com> <CAFRkauCdRoChK-djEi+TzC4As5JzykPF=fb1YmDukEjWJG0K_g@mail.gmail.com>
 <1622785727.9011.17.camel@richtek.com> <CAFRkauAFVdxHcKkNzAW3uHhADwb2G-sdiLBUoZj+eOAXEV4rfA@mail.gmail.com>
 <1622788151.9011.20.camel@richtek.com>
In-Reply-To: <1622788151.9011.20.camel@richtek.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 9 Jun 2021 11:32:30 +0800
Message-ID: <CAFRkauAOCRPKHpzEfYx9ZtsvR+7QRtPdZpw71NtKQJFNw3BVfQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: rt6160: Convert to use regulator_set_ramp_delay_regmap
To:     =?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u0084500@gmail.com" <u0084500@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC 2021=
=E5=B9=B46=E6=9C=884=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:29=E5=
=AF=AB=E9=81=93=EF=BC=9A
>
>
> =E6=96=BC =E4=BA=94=EF=BC=8C2021-06-04 =E6=96=BC 13:59 +0800=EF=BC=8CAxel=
 Lin =E6=8F=90=E5=88=B0=EF=BC=9A
>
> cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC 20=
21=E5=B9=B46=E6=9C=884=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=881:48=
=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
>
> =E6=96=BC =E4=BA=94=EF=BC=8C2021-06-04 =E6=96=BC 11:30 +0800=EF=BC=8CAxel=
 Lin =E6=8F=90=E5=88=B0=EF=BC=9A
>
> cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC 20=
21=E5=B9=B46=E6=9C=884=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:26=
=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
>
> cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC 20=
21=E5=B9=B46=E6=9C=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:18=
=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
> Hi,> >
>
>
> cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC 20=
21=E5=B9=B46=E6=9C=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:20=
=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
>
> Hi, Axel:> Use regulator_set_ramp_delay_regmap instead of open-coded.
>
>
>
>
>
> There's some reason.
> You can refer to https://lkml.org/lkml/2021/6/1/1145.
>
> It's because our ramp value order is from small to large, not large to
> small.
> It conflicts with find_closest_bigger value chosen logic.
>
> I have verified the rt6160_set_ramp_delay() behavior exactly the same as
> regulator_set_ramp_delay_regmap. (both functions get the same selector
> for a given delay)
>
> Could you check if this patch works?
>
> Sure.
>
> After my test sample code, below's the result.
> ascending [1000 2500 5000 10000]
> target =3D  1000 =3D>sel =3D 0
> target =3D  2500 =3D>sel =3D 1
> target =3D  5000 =3D>sel =3D 2
> target =3D 10000 =3D>sel =3D 3
> target =3D  1700 =3D>sel =3D 1
> target =3D  2750 =3D>sel =3D 2
> target =3D  7500 =3D>sel =3D 3
> target =3D 15000 =3D>failed to find best select, sel =3D 3
> target =3D     0 =3D>sel =3D 0
> descending [10000 5000 2500 1000]
> target =3D  1000 =3D>sel =3D 3
> target =3D  2500 =3D>sel =3D 2
> target =3D  5000 =3D>sel =3D 1
> target =3D 10000 =3D>sel =3D 0
> target =3D  1700 =3D>sel =3D 2
> target =3D  2750 =3D>sel =3D 1
> target =3D  7500 =3D>sel =3D 0
> target =3D 15000 =3D>failed to find best select, sel =3D 0
> target =3D     0 =3D>sel =3D 3
>
>
> It means when target is in range or even over, the result are all correct=
.
> But like as the ramp target is equal to 0, the selection will only choose=
 the minimum one.
> When the ramp target is equal to 0, it means the user want to disable the=
 rammpping function.
>
> As I know, if target is equal to 0, it must find the fastest rampping val=
ue as the best selection.
>
>
> If your table is [1000 2500 5000 10000], find_closest_bigger() will
> choose sel=3D0 when ramp_delay=3D0.
> If your table is [10000 5000 2500 1000], find_closest_bigger() will
> choose sel=3D3 when ramp_delay=3D0.
> i.e. In both cases, find_closest_bigger() chooses the fastest ramping val=
ue.
>
> This meets your exception.
>
> Actually, even if your table is [10000, 1000, 5000, 2500],
> find_closest_bigger() still can choose the correct selector.
> i.e. sel=3D1 when ramp_delay=3D0 in this case.
>
> This selection may be wrong.
> ramp_delay=3D0 means ramp disabled,
> If chip not support rampping disable, this selection must be configured a=
s fastest rampping value, not the minimum one.
>
>
> 0 does not mean ramp disable.
> It could be explicitly set to zero or its unintialized (zero by default).
> see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/regulator/core.c?id=3D1653ccf4c52df6a4abe8ec2f33f2cb2896d129ea
>
> How about 'ramp_disable' falg is true?
>
>
> My understanding is:
> If the h/w does not support disabling ramp_delay, the regulator core
> won't call ops->set_ramp_delay when ramp_delay=3D0.
> If the h/w supports disabling ramp, i.e. ramp_disable flag is true,
> the regulator core will
> call ops->set_ramp_delay with ramp_delay=3D0. in this case, it should
> have an exactly match and
> write the register to disable ramp_delay.
>
>
> If this can be guaranteed , to use the set_ramp_delay_regmap helper funct=
ion would be better.

Hi ChiYuan,
Can you add  Reviewed-by or Acked-by if this patch works.

Regards,
Axel
