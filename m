Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B665F4226F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhJEMnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhJEMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:43:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4249C061749;
        Tue,  5 Oct 2021 05:41:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g41so85515716lfv.1;
        Tue, 05 Oct 2021 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XpKYD9E3rJIEfDrcb6VLQtwXgInFx9KzFG4M4majEQs=;
        b=S1fWl9EdPHAlX7K0qHKuTB1OaqcSn/Bz2Fd6glU5/vPoLdVhGkj9qJaY2luQY7I2Zu
         0+qTRJtDuOAXcl5zwuQFJCwU5xFX9Hoy+ZzO1TQ1YJabSQzqgAKGKDmHrARYJ16ahRtC
         ShF3xtTvJwh5lZeiQwV+P3+YpHQ+bQbx3bwPgp5a5vaKSkfW/uV4RKjHZrXt0Ok/mcUd
         Kze2SINUPtngd9FhJCh0/Lfqv5CW2FAEFGcV+pt5/XR5nKNoSdjjBGBWm5QETqrzRaKe
         y5L+YfUkbp+g0CcrDClm3V/Ilfbihxl3X93qASAWV4zrRCd6qb93saYLDPhpLFNofErQ
         aX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XpKYD9E3rJIEfDrcb6VLQtwXgInFx9KzFG4M4majEQs=;
        b=i+EA/fqf9FjCShzdy74YYizrY6C23vsihf4DqTcmze7B6kzqqe5TkIkAS34p3AbrdN
         22K50Djf8ZP9YpdMDNF3os/zkqNDpziDBeTX4eec/nmQzolRWq2Ejs9crD6Pu8CsTkkR
         4U0ZJ03yxa1gkS16dwpvIJZ8R2NqmN8BmmGZ0qDVJd9Vg0QkU/Wy7wTXXQ+icoDzfF/P
         hzh09F0uRJy9VtrE2sKxxMtdHwnQMrvBelzKhQojIEN1+yPdgTlqLWoMP7cU/yyhjSlu
         fhkFr8wXRTjNJct0MO+sU2ESNuZy15uMgB+xCsAFTItiveZTPkLztoevP7XnRqWhTBMW
         BI7A==
X-Gm-Message-State: AOAM533ISGEVYtNOuZ4oaZbXOyuUShN/is8z2XbuTj72UYaxh2Gojd4a
        ArebbPf5bJyB/JlGo9qUp+oZPMrWw+VRts0APRI=
X-Google-Smtp-Source: ABdhPJww6f4HJYe7iGnS8kWLpGh3Jt6HAF+txW7zmITtvuGzTPaqOdExkraL5Yg3BNi0MU978iZrxzkbkd8upGznyzk=
X-Received: by 2002:a2e:530b:: with SMTP id h11mr22385687ljb.372.1633437681114;
 Tue, 05 Oct 2021 05:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
 <1633396615-14043-2-git-send-email-u0084500@gmail.com> <YVw87lc4uXSvCiyC@sirena.org.uk>
 <CADiBU38X6nY1D7NpgW8+61AX6rUU7jngnPagryDKxUAKdtGjAg@mail.gmail.com>
In-Reply-To: <CADiBU38X6nY1D7NpgW8+61AX6rUU7jngnPagryDKxUAKdtGjAg@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 5 Oct 2021 20:41:09 +0800
Message-ID: <CADiBU38=k9JcceGzjCUwO4OpgC3+zK_Pw2G0uOyOYg0FRvvzBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: rt9120: Add rt9210 audio amplifier support
To:     Mark Brown <broonie@kernel.org>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, allen lin <allen_lin@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:54=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, Oct 05, 2021 at 09:16:55AM +0800, cy_huang wrote:
> >
> > > +static const char * const sdo_select_text[] =3D {
> > > +     "NONE", "INTF", "FINAL", "RMS Detect"
> > > +};
> >
> > Why not None and Final?
> >
> Just follow the datasheet to write the text.
> Whatever, Ack in next.
> > > +     if (event =3D=3D SND_SOC_DAPM_PRE_PMU)
> > > +             snd_soc_component_write(comp, RT9120_REG_ERRRPT, 0);
> > > +     else if (event =3D=3D SND_SOC_DAPM_POST_PMU)
> > > +             msleep(RT9120_AMPON_WAITMS);
> > > +     else if (event =3D=3D SND_SOC_DAPM_POST_PMD)
> > > +             msleep(RT9120_AMPOFF_WAITMS);
> >
> > This should be a switch statement, it'd be clearer.
> >
> Ack in next.
> > > +     /* Default config volume to 0dB */
> > > +     snd_soc_component_write(comp, RT9120_REG_MSVOL, 0x180);
> > > +     /* Mute by default */
> > > +     snd_soc_component_update_bits(comp, RT9120_REG_VOLRAMP,
> > > +                                   RT9120_MUTE_MASK, RT9120_MUTE_MAS=
K);
> >
> > As ever you should leave the defaults at whatever the hardware defaults
> > to, the defaults for one machine may not be suitable for another so we
> > shouldn't be trying to do that in software.
> The default volume will be kept in value 0x7ff (mute).
> I just want to follow the ASoC flow to control mute/unmute mask by AMP on=
/off.
> If to default set volume to 0dB and mute is improper, user have to use
> mixer control to configure the volume.
> Does mute function also need to be removed also?

Sorry, loop all again.
