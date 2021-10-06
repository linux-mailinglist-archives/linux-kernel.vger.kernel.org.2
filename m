Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F78423A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhJFJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhJFJLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:11:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B104C061749;
        Wed,  6 Oct 2021 02:09:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t9so7608100lfd.1;
        Wed, 06 Oct 2021 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3vIcEyr7QuVBCeh3mAP0j/ko23BFx3UEwrFTydDoOjw=;
        b=Y+lq3L8PXp/1DJR4LuSkH4uvV2i5I7JQW+Mg5eysonjJbDnGZYTGpaPdiR11IGqjhG
         JKH30t3CTeuWR3tTFw37vPdfhQwu5/jIu1wDWVkbzn89HlN35RhhEDICcFfEyNVMjckn
         SjqvEwF93o+Dll9Ho4OF2rQq/2zRsHdhwwtEhEOIwmkXpKoFcrqFxO4DVljYJs9D2ltS
         oFRDnzfCFwXbYYBsbXNY19dMVpF/xPb1fOKPr0zirVmIqBcGNmZLUQdMU4uSmOpxMzvJ
         0Ku5Vl+pdpzY8bLAUf/jPHbkD0qTEQzay2idwQYGswCmlxim/4JK2TC07JRXpKgjrVdf
         A3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3vIcEyr7QuVBCeh3mAP0j/ko23BFx3UEwrFTydDoOjw=;
        b=mOiFYmR0uAGZbmBmaWxbiYeyxJndOCoIzg/hE3QwcNp4cMNOu9FeQDeCDJnDGYQCl1
         LJYZ0L1oT9CyBhdfTaIdaZXAo9wF2T9P2v2Y4964trPcmHzvls2z1AR5oyk3FKScOG/u
         +snnpvUl1CtuxLeoLxMXAVabtF1cfqevBy25HDO3r/F53zsNgC0RCJYGtOEm28s9s4FO
         MNE8eYJ9DG/KeAeCFJs+I3JdZWgzgNnGbQ1xSu5n3yN7ccScIDxdandguuZGwj/4VEh2
         UVPL2aRZ3B4jeRydBJ/MJWvYCSUD/CPsLTyK88HKyRFx1lEJtbPW2Lr338RvhD+w5P+G
         RVew==
X-Gm-Message-State: AOAM533hBPg+0v6Go91YGhvMX/AdWfa6KJaTpL+RqHpPad4ywSSgu7Cy
        7UsCiaK/OPjnwpD/RnZv7i8Yp8uvkX8LAjXjUqh14Mbt
X-Google-Smtp-Source: ABdhPJzMfNeD2VPG/6FkmkYV9CXq06WhI5WUIlsAqQRktPRR9FccwJ9bJa1onYE9OFp6sVr+8NN/olw+7nSRxwBQT1k=
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr26860600ljg.415.1633511363662;
 Wed, 06 Oct 2021 02:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <1633396615-14043-1-git-send-email-u0084500@gmail.com>
 <1633396615-14043-2-git-send-email-u0084500@gmail.com> <YVw87lc4uXSvCiyC@sirena.org.uk>
 <CADiBU38X6nY1D7NpgW8+61AX6rUU7jngnPagryDKxUAKdtGjAg@mail.gmail.com> <YVxIv6NOiVdNSkXf@sirena.org.uk>
In-Reply-To: <YVxIv6NOiVdNSkXf@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 6 Oct 2021 17:09:12 +0800
Message-ID: <CADiBU3-A3vcn9ekKnL+mRjafHzi25W0OQs8HzGg_t99mtJurWQ@mail.gmail.com>
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

Hi, Mark:

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 05, 2021 at 08:36:44PM +0800, ChiYuan Huang wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:54=E5=AF=AB=E9=81=93=EF=BC=9A
> > > On Tue, Oct 05, 2021 at 09:16:55AM +0800, cy_huang wrote:
>
> > > > +     /* Default config volume to 0dB */
> > > > +     snd_soc_component_write(comp, RT9120_REG_MSVOL, 0x180);
> > > > +     /* Mute by default */
> > > > +     snd_soc_component_update_bits(comp, RT9120_REG_VOLRAMP,
> > > > +                                   RT9120_MUTE_MASK, RT9120_MUTE_M=
ASK);
>
> > > As ever you should leave the defaults at whatever the hardware defaul=
ts
> > > to, the defaults for one machine may not be suitable for another so w=
e
> > > shouldn't be trying to do that in software.
>
> > The default volume will be kept in value 0x7ff (mute).
> > I just want to follow the ASoC flow to control mute/unmute mask by AMP =
on/off.
> > If to default set volume to 0dB and mute is improper, user have to use
> > mixer control to configure the volume.
> > Does mute function also need to be removed also?
>
> It's totally fine and indeed quite common for devices to be muted by
> default - usually systems will have UCM profiles that unmute things by
> the time users actually interact with them.
>
> Please don't take things off-list unless there is a really strong reason
> to do so.  Sending things to the list ensures that everyone gets a
> chance to read and comment on things.

After asking the HW member, there's already builtin HW volume ramp function=
.
Mute API is still no need. There's already no pop issue without mute functi=
on.

So the next change, I'll remove the default volume and mute config,
and also mute API.

Thx.
