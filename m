Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BDF429BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhJLDJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhJLDJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:09:57 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE9C061570;
        Mon, 11 Oct 2021 20:07:56 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o83so19805894oif.4;
        Mon, 11 Oct 2021 20:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vVvBHngaWKoiA0++47ZxjHijX6w95ry8pBLW3rnsyKM=;
        b=H9QwPe1Ga5lUz1oYHLYo1JXPU/nYvZOAWkRMgEQdMGj79GPeGqm9vTqS2PhYSElTeb
         dKUQWF04Fo4hEOu/O+5K+8jO3EE0iteMyFjRNi+8yvHdvvSwEwLRLY1xuFAF5TeY1OHr
         zXcrXJtpIye4HG2gHbsswu78EUWdqXmH3sSpfJwQkBf9AAQ/8igFUaNx1fCGhb/JWeUy
         xyhtmsrfkwBjtnsLO0hFN376XVyHwckh5ohEZ6S2OVK4QqX941k2w9M1n5mjbzE1S04K
         vu/VnFoSLCmetvsOswr7gR8QR6QnDW7LAmV5DMAgzHmKKpHWAEU7wKeFbEUa4Hy4cYP7
         ofBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vVvBHngaWKoiA0++47ZxjHijX6w95ry8pBLW3rnsyKM=;
        b=7/Rc2nRmkvgR/ZLVVGj2+T5jl0wlvIddhJm2l8kZin3nSsXXD/x+PtVmIDIAb4b+VN
         86Wq7OdVNUGEKwGN5T5WoAgnGEePqbfaFngMsn3xC4/6fRuNpPfbr54qt4fACp4EYWlS
         nUO0qHYb4WVCTglGm19x/2VHGVdAAmsv/+PfByhH6Dy6nCbf+LXm4hgAHA1AqsqWEYL/
         OFFyAQn10b7GAuWLPEJg8ZYCD4aY/fZIWm6wUoLpv4QlZEz2lkDy1OcFOxa/3+FDmm7L
         1BU9MZeXrTELfR27HpYqVw54X1S27eObKPot90FannVk4XB56BB+28Pf2C1GpIn6AmEH
         aNSQ==
X-Gm-Message-State: AOAM530M5BWRjuLdN2pVz2bdH71G4Fe3JTX0GIk4cJ0eeli1sloR+Zx0
        5tQtZsDF1NdEos4eJyzfFI6IXR5WDSN7D44MTXQ=
X-Google-Smtp-Source: ABdhPJxgyBjsHO8t4SthfXn3vCmil4DtjN9T0E5geL0LHORC7tvbOOtT5ExBRj+csc1mPr5d7b3pBuGYbtFvoCflkE8=
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr1838200oia.95.1634008075820;
 Mon, 11 Oct 2021 20:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <1633668612-25524-1-git-send-email-u0084500@gmail.com>
 <1633668612-25524-3-git-send-email-u0084500@gmail.com> <YWA+ykStTEyzRbEy@sirena.org.uk>
 <CADiBU3-X5n3b-ZUCFf48C=5oD6RC1E9MD+M6demMLoHzZ3CEBA@mail.gmail.com>
In-Reply-To: <CADiBU3-X5n3b-ZUCFf48C=5oD6RC1E9MD+M6demMLoHzZ3CEBA@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 12 Oct 2021 11:07:43 +0800
Message-ID: <CADiBU39SKqSULSesj060a62YpMp1hD9ftfMPGtdcbOyZh8iPrw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: rt9120: Add rt9210 audio amplifier support
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

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=8812=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:47=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:51=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Fri, Oct 08, 2021 at 12:50:12PM +0800, cy_huang wrote:
> >
> > > +static const struct snd_kcontrol_new rt9120_snd_controls[] =3D {
> > > +     SOC_SINGLE_TLV("MS Volume", RT9120_REG_MSVOL, 0, 2047, 1, digit=
al_gain),
> > > +     SOC_SINGLE("SPK Gain", RT9120_REG_SPKGAIN, 0, 7, 0),
> >
> > Volume controls should end in Volume even if they don't have TLV
> > information so applications know how to render them.  I'll fix
> > this up as I apply.
>
> It's not linear mapping analog gain and cannot use the TLV as you said.
> Mappling table is listed like as below
> 0 -> 6dB
> 1 -> 8dB
> 2 -> 10dB
> 3 -> 12dB
> 4 -> 13dB
> 5 -> 14dB
> 6 -> 15dB
> 7 -> 16dB
>
> Do I just need to change it to 'SPK Gain Volume' to present this control =
item?
> Or is there any table mapping for the nonlinear TLV information?

Finally found there's 'DECLARE_TLV_DB_RANGE' that can meet the requirement.
I will fix this by the tlv db range and naming it to 'SPK Gain Volume'.
If there's any changes still needed, please feel free to let me know.
