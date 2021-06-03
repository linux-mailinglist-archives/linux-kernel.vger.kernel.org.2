Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A6A399F53
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCLAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:00:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E869C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 03:58:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l1so8580415ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tCMCFGgV57wSoDA6uCGc93LuPVo+OxVrkcwFPrUs/Q4=;
        b=d0O7e8ZulPvA7OwO5pVX6MnaAa2RcQlpU2RelXwY7cPAK3cDA/ujP/6RCdImjx9hyQ
         23d28Tq9aX1Wg0InQ1ylq1TtN6TZVVyUgHo2lfBXi5+J1VMQopxsDeNiHmKZf3kQGZdT
         SVSC6Eh+bVFfBO6wtJ1OI0HszYxoVuVEJBz+xFShRYCz8NKVBk7Ms9mxlp/NGyft4B/c
         iKS4Wi7UCn32w7kmeudQw6N7TkZXlRgyRVrEGWaomQNxi7CGT/oKEAo638VVsyKDOwDT
         O3UCCi+DLfYk2tIjBmViibklZmzZe+EMGoSBMQ/y+yDHkDuQpGRY8YokvHNwlLcy3msv
         aqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tCMCFGgV57wSoDA6uCGc93LuPVo+OxVrkcwFPrUs/Q4=;
        b=CNX9WSVJUVoOtapEbKaOJOuVKTKWAiBl4aRMdUe6tCUeybisC3zpmOamggANq1g7y+
         B51R1lBP3WFx7/lgTfgtsuLGMclX7OqUcTtir2HcdguzVWq9Gaa80WFLSt9+Ue5bbrmf
         JNV70NglIzIRzz1J5XpPkaBo7PqHhgpxJsgPN/6y3Ue0yCnsaj6hr8/5YmNIVREHGlpL
         hd+IChcMayAOXpqHcX/dA5ratGGCtM8FvyYBGLyxBOEcCGmei0QmIRoLU1OH2Lz9acib
         wf4pMdB9SHV5QsDn7N5YV3JewOTSz8zkj7l8ZAl3CYJ6XWEvsQQAWNDZtSBSVbHys8rV
         O2Sg==
X-Gm-Message-State: AOAM530o2xrcuKoEMRqAIp+dZWGGXPY7Lyxc+4uAdnQfGEQ8BZho3LGs
        qvNBzQiVXUp+ZKfRXq7t5y1Cq6TieR0XZofvGnfPUWzVVBZ3cMm4
X-Google-Smtp-Source: ABdhPJzQzhXm/a6eb3conLGy8bywS1/kI9o8N8QdZooyDsakOdRXcp4w5XWzPdKotuUT0r7UfD++XZ3NHkzO2m49chg=
X-Received: by 2002:a17:906:a017:: with SMTP id p23mr39252877ejy.460.1622717909183;
 Thu, 03 Jun 2021 03:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210603093809.1108629-1-axel.lin@ingics.com> <1622715641.1034.5.camel@richtek.com>
 <CAFRkauDs6nyuboPBf9Q-=KDFkSjwQ4z9mDjzm3o95uzdu5bKCw@mail.gmail.com> <1622716902.1034.15.camel@richtek.com>
In-Reply-To: <1622716902.1034.15.camel@richtek.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 3 Jun 2021 18:57:53 +0800
Message-ID: <CAFRkauC2qugUBbHccf6jV=e_xRLAJP0JyPsFMzmTQO5KUaj=Qg@mail.gmail.com>
Subject: Re: [PATCH] regulator: rt6160: Convert to use regulator_set_ramp_delay_regmap
To:     =?UTF-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC 2021=
=E5=B9=B46=E6=9C=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:41=E5=
=AF=AB=E9=81=93=EF=BC=9A
>
> > cy_huang(=E9=BB=83=E5=95=9F=E5=8E=9F) <cy_huang@richtek.com> =E6=96=BC =
2021=E5=B9=B46=E6=9C=883=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:20=
=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > >
> > > Hi, Axel:> Use regulator_set_ramp_delay_regmap instead of open-coded.
> > > >
> > > >
> > > There's some reason.
> > > You can refer to https://lkml.org/lkml/2021/6/1/1145.
> > >
> > > It's because our ramp value order is from small to large, not large t=
o
> > > small.
> > > It conflicts with find_closest_bigger value chosen logic.
> > I have verified the rt6160_set_ramp_delay() behavior exactly the same a=
s
> > regulator_set_ramp_delay_regmap. (both functions get the same selector
> > for a given delay)
> >
> > Could you check if this patch works?
> Sure.

The find_closest_bigger() does not rely on ascending or descending
table entries.
Regards,
Axel
