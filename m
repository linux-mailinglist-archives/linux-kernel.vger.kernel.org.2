Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA75839B0F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFDDdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDDdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:33:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C210BC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 20:31:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g20so12381464ejt.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 20:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BJI3mJGMDw+7Io3BxiMW0VYaj3nzR4CPuw/4IRjIJhE=;
        b=bro8TAo8s9Y4gnHc1ePGf1uMKUtir59WeQIvrJNkMl0BF4VO0dPRd/Jb/49lyGPHHs
         fBZKQ08CDNo1bjmNvOncGLTZm8FELmFJXhOXXlfPhEhMez6QKM1/4x3cK61x8mA80LzW
         mC/dDq9B3TY3aWpDuErYGmZng2C355o79yXJI7mvyKgMLIBpfacolX4QI96tiCiQ1Onz
         9cm6lbzgavztq1kP/k9FhFBl8fFTlE22hbwfCqn0RuZ1kRhOHv4DGHx+NYCNrIAeMGoX
         +7gKqlDM3ZLkWaHy5NWTtWFxLFApnYHbrGApSE0ue15OTn59nL0duW/OGSnJRt+CXsZQ
         nXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BJI3mJGMDw+7Io3BxiMW0VYaj3nzR4CPuw/4IRjIJhE=;
        b=NodJvk6poyYF4Lngg7NuP+ndMUguO7vqDngqtThGprqKBtp8OslWST3Pa5AJObqsxd
         7f4/c9R+ESkJnFBcNv3y5REMgqRlQxSqakXkn2OyW8bvtBtZMhFApa0UYIWsDlkn0i2O
         s+TGWLPdyAom6vREiV9LNcDc6d1qa1jbpV7yDF/ZKbkN0eADjnqJRFvPZFad1esjAz4A
         gTLnHbMo/fnUoW7MkkPgTu7BRZey8lsZBzfv8LUHC0WRIjaWcdk5fy31H5LFqGpUCp5W
         UxrEsdKNhMdyBTUDruiB2hEjZ/XeJx0L4BofGdcWySRUrLpV001AQd+waAxa/NpmQNwt
         qA+Q==
X-Gm-Message-State: AOAM531ier52iIZ3LBVhmoNHDG93PSmHByn4wU7h02X9Zi2v52sdeSJ7
        CWKITQ4n+FcT5cOdV0+sph+98JCsmrqL/eOwGb1IfsNQVIISi3uo
X-Google-Smtp-Source: ABdhPJyjoC1WQLDZZHL37MTA4vuFYNLMKJiw4G/iZEdAKguOdwg74Mevo2nhiyhsHLRFV7GfakcWDVrU1939hlPqutU=
X-Received: by 2002:a17:906:3884:: with SMTP id q4mr2266152ejd.66.1622777475334;
 Thu, 03 Jun 2021 20:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093809.1108629-1-axel.lin@ingics.com> <1622715641.1034.5.camel@richtek.com>
 <CAFRkauDs6nyuboPBf9Q-=KDFkSjwQ4z9mDjzm3o95uzdu5bKCw@mail.gmail.com>
 <1622716902.1034.15.camel@richtek.com> <1622733524.3635.10.camel@richtek.com>
 <CAFRkauCKoipBe4-QacQbjZgWuFrMPKdAfWB00Q6Lyw7xJ=6sfQ@mail.gmail.com> <1622773474.9011.14.camel@richtek.com>
In-Reply-To: <1622773474.9011.14.camel@richtek.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Fri, 4 Jun 2021 11:30:39 +0800
Message-ID: <CAFRkauCdRoChK-djEi+TzC4As5JzykPF=fb1YmDukEjWJG0K_g@mail.gmail.com>
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
=E5=B9=B46=E6=9C=884=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8810:26=E5=
=AF=AB=E9=81=93=EF=BC=9A
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

0 does not mean ramp disable.
It could be explicitly set to zero or its unintialized (zero by default).
see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/regulator/core.c?id=3D1653ccf4c52df6a4abe8ec2f33f2cb2896d129ea
