Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE8139B253
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 08:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhFDGCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 02:02:45 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:39600 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFDGCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 02:02:44 -0400
Received: by mail-ej1-f41.google.com with SMTP id l1so12707656ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 23:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IepL4STzv+bRHR/ws0I4OMBLiTx2pbylGuF5n2ofQIg=;
        b=WTT9Szg46u5n3cH8R8wY0HzIIQvp2XwnJn9CBBFLtMcaE/af2l0Zi234eliO4voAo1
         fNOzV5jTlDS3TD+uHbWnzYWNNMEcD8NNra/BS7XYtkehmy7014xuroip+lDtHJTGkVKE
         o+KbYB0I3UsJjBsgIeneYDZsRT+E7LlSCHppRNtK2lAaMzAlU9DFIe0EKgZzFDagURFv
         TMxN7bXd2hBJqqBTfsYC7SpxCIyaqgB+nFhwNOPG/ZDiZgDuYFQZM4B1Vix6C0unI/kH
         TeOTHWY84SnCe0xyfRe5/ZMP7IuVmtwil0MU0jAY5tQAe2KBhUd1Zi1UHmtNCIOpLRYo
         feNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IepL4STzv+bRHR/ws0I4OMBLiTx2pbylGuF5n2ofQIg=;
        b=HuTUTGtgi6Q5QoGPUnORP29b8pJLpwwNwYaBekOsTIJxtmz/5g79gGfrRZr0RSUZCL
         PEx1w5F1yCOsJczRYDp3NI2bSV9QbCQJmNTkC7UNghTwcX7N4fyOxWF27/DUtY2lmg7v
         YDHRoUz7C0Fk7cHMn/Gnm4SvG9s6qRTWgsTU4ABlQMwNf22mAhUtWgZTsAD4laU2G0Ft
         GvRHDpNhxbzJzk9hAyDQKH1j9e4Da9oAW4iBWdlik83da+Ie9+BtXhxyiHVH0h5HIhmc
         p4qEKEyMa//caIa+/MM7L3UkPCwrNHDfgxWv8/+NrGsNv3AYR1ze+D3W54q6Zmrv8w4c
         cODw==
X-Gm-Message-State: AOAM531UoSyhVI2cU9Es2pgvay14MsvW41ovMs0gh0eXqwtIzpXKZRLM
        ETlJe7g6bn/8YqVqYd/XuGT6Kufq3P9nXp3XoAxc8A==
X-Google-Smtp-Source: ABdhPJwdOsU8YC2ueYp4I5jK8Wr7oYeoTfStB4F3ZU04p88BkHoUJa32mUloV9YDzIZohHesvsL2uryq8n8ox+ckhSo=
X-Received: by 2002:a17:906:a017:: with SMTP id p23mr2690273ejy.460.1622786383374;
 Thu, 03 Jun 2021 22:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093809.1108629-1-axel.lin@ingics.com> <1622715641.1034.5.camel@richtek.com>
 <CAFRkauDs6nyuboPBf9Q-=KDFkSjwQ4z9mDjzm3o95uzdu5bKCw@mail.gmail.com>
 <1622716902.1034.15.camel@richtek.com> <1622733524.3635.10.camel@richtek.com>
 <CAFRkauCKoipBe4-QacQbjZgWuFrMPKdAfWB00Q6Lyw7xJ=6sfQ@mail.gmail.com>
 <1622773474.9011.14.camel@richtek.com> <CAFRkauCdRoChK-djEi+TzC4As5JzykPF=fb1YmDukEjWJG0K_g@mail.gmail.com>
 <1622785727.9011.17.camel@richtek.com>
In-Reply-To: <1622785727.9011.17.camel@richtek.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Fri, 4 Jun 2021 13:59:07 +0800
Message-ID: <CAFRkauAFVdxHcKkNzAW3uHhADwb2G-sdiLBUoZj+eOAXEV4rfA@mail.gmail.com>
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
=E5=B9=B46=E6=9C=884=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=881:48=E5=
=AF=AB=E9=81=93=EF=BC=9A
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

My understanding is:
If the h/w does not support disabling ramp_delay, the regulator core
won't call ops->set_ramp_delay when ramp_delay=3D0.
If the h/w supports disabling ramp, i.e. ramp_disable flag is true,
the regulator core will
call ops->set_ramp_delay with ramp_delay=3D0. in this case, it should
have an exactly match and
write the register to disable ramp_delay.
