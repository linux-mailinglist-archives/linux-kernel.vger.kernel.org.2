Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8943E39AEFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 02:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFDAPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 20:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDAPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 20:15:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D043C061756
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 17:13:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dj8so9121320edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 17:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jgOERAj4kroC/04L21IpTkcAV4BGych6ovmQLy8AoNs=;
        b=g+9Oa99pTQWO1AXhooT+rADqtkUqD7GLMRf3+koBNlTuEuoO3+HhWpKPsENJvaXgfO
         wzBgC9Pm/CpGsLbN6m863yCHKOIRkZhsRv8Y4Fs4V3mYw1vtRas6RknQdNZ6bp+YnQ4+
         WScgH1LbL7rwYtiLb5eD+ZfwA3mdXw7hmxpuHxvN/riU6PJCDG6gLzjiWIYS9BLKsZDY
         N4by2xzjeXqiY3BHOIZLfUXHuB0rgJf/Row5BFYSMpXZEURAx/Bs10kFhznHEyjsJvyS
         uuzOzWmlITIKVF7HmipPteqjoobI/9EswDXfriE/uubHfQDgRKoe6ZBhqb3b/NBMYa7k
         cwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jgOERAj4kroC/04L21IpTkcAV4BGych6ovmQLy8AoNs=;
        b=SWvN44fHVg1OwU2H+Q+axhrY3o55gZdNnic1YGagxh6hNexDZQ8xC4SdMRelh+XAzu
         Dy2fiJaJCzh2otBRO/WP/w3J2+h0qVf7oMDBrObgRF1mhoiEbCl9bp7jqMSCmCv7k3GO
         Ob+M0zWEKAqfSNp0Dt0FJDbvTqVhEX7v/4z2UBz07xyP+VmTCYhmuo4GfkfBsUUlnb7W
         9d0NweGPeSwVYTRbvtYya6YbJEOGfaMWE0gbw5V/4DfnQTxVc84+Y0wAHC6gm9LHLhJB
         fY+HHdwUuJxrm4qS+ksrY83HRS0GvJhh6l27sBUGoD7zC0H1vLtGT6+c9UAAbLQf+gQY
         FzlA==
X-Gm-Message-State: AOAM531z85AB+zpNhD84SL9VqcBeK4igEt0LDUNLPIbLPNBkTUFTHa+7
        I09rwqIjfIYwj7KXuf9KPUrWLaytZtH48qDDUbaU+g==
X-Google-Smtp-Source: ABdhPJyu1JxagYetOQcMs7k8K30opVihGyCfPTss881P6qOgbhMNdDdJ9PieTEq2uvgOvqtYq2uA3QkVQtNJabWFLzE=
X-Received: by 2002:aa7:db16:: with SMTP id t22mr1877643eds.49.1622765637798;
 Thu, 03 Jun 2021 17:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093809.1108629-1-axel.lin@ingics.com> <1622715641.1034.5.camel@richtek.com>
 <CAFRkauDs6nyuboPBf9Q-=KDFkSjwQ4z9mDjzm3o95uzdu5bKCw@mail.gmail.com>
 <1622716902.1034.15.camel@richtek.com> <1622733524.3635.10.camel@richtek.com>
In-Reply-To: <1622733524.3635.10.camel@richtek.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Fri, 4 Jun 2021 08:13:21 +0800
Message-ID: <CAFRkauCKoipBe4-QacQbjZgWuFrMPKdAfWB00Q6Lyw7xJ=6sfQ@mail.gmail.com>
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
=E5=B9=B46=E6=9C=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:18=E5=
=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,> >
> > > cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=
=BC 2021=E5=B9=B46=E6=9C=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=88=
6:20=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > >
> > > >
> > > > Hi, Axel:> Use regulator_set_ramp_delay_regmap instead of open-code=
d.
> > > > >
> > > > >
> > > > >
> > > > There's some reason.
> > > > You can refer to https://lkml.org/lkml/2021/6/1/1145.
> > > >
> > > > It's because our ramp value order is from small to large, not large=
 to
> > > > small.
> > > > It conflicts with find_closest_bigger value chosen logic.
> > > I have verified the rt6160_set_ramp_delay() behavior exactly the same=
 as
> > > regulator_set_ramp_delay_regmap. (both functions get the same selecto=
r
> > > for a given delay)
> > >
> > > Could you check if this patch works?
> > Sure.
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

If your table is [1000 2500 5000 10000], find_closest_bigger() will
choose sel=3D0 when ramp_delay=3D0.
If your table is [10000 5000 2500 1000], find_closest_bigger() will
choose sel=3D3 when ramp_delay=3D0.
i.e. In both cases, find_closest_bigger() chooses the fastest ramping value=
.

This meets your exception.

Actually, even if your table is [10000, 1000, 5000, 2500],
find_closest_bigger() still can choose the correct selector.
i.e. sel=3D1 when ramp_delay=3D0 in this case.

Regards,
Axel
