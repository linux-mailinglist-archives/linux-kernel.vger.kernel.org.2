Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D263F5E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhHXMjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbhHXMjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:39:05 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC91C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:38:21 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t32so1312743qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RAbeEw2MV7/Q5nPGdY/UAy9tktZwa9LHWfLtieuIPcY=;
        b=pRhmDXl4ZvDVPQ7VlLHDud/taH02pjAZXMSJu0Yj22PDVP6VHZYRaIk3L8G4oFJn/x
         Wq9+4TLPkEmCn3vELd/tG1OSga87aP62nS1O/bvfL8Wp40hHx2I1/BG5aMKswkfAFQt6
         bDzRshSVSmMzjINMjdnta39H75CXPjVjwq0YTD2SG7FVpKuSdHHgtyNFVtCEEmngBZld
         uxkIr1LZLbR8j0LxZsOrzaYUAUwkZcDXYFgkrcX4PGrMjUGaiJvStCtLDZG8P8D+UP9y
         XvAS4wf7wwIzTkslC0/OBJgAtMbO8nEaCCNo77i9/uikuaiiERyHqRSdR3D84MIwFU1g
         CG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RAbeEw2MV7/Q5nPGdY/UAy9tktZwa9LHWfLtieuIPcY=;
        b=rli4qn2C1fKNRy5nKe7FuQPYHgBDOsAgxq/p3aftNPbMxOBLroMeIXr3KYwwP4emOB
         XOXA9viJemU311wHV255yG4CZNczePxuFeERc0yIgcc+a6derJp5GBJraPW2hOaiTX09
         a2nS8mus9Nusg88qWKLM0CBlVK+YVqZIb8uBt84zmKMHW1mbQmuvjayMeZqe7cF7mDOc
         y3jsqHIQqGFxk+qlGiqEgExl9jFI0wXqRct0WHnHLO/yyaYfVR7soMHa/hOS4UxB0B+3
         Hb9AaOrduuabvPD+J3mS8lBTwcdaqHHFRPLk1b2L0HT/Qnb4i2LXE4kk0oXplWdVY5gz
         wzJA==
X-Gm-Message-State: AOAM530rYqrJ4+7SIwDrLpgPZFED1KpRcW6Bli9Csz8TDJXCYi4JueV8
        //pWYnI8kVrMeYkkEdIK4cdVfR32JjwNL192+srgJQ==
X-Google-Smtp-Source: ABdhPJxMysLHANwL8TerUXiiJdaUnzwpgpR25N0z8I3akLu+7kNAmkCspUy7SXw4de9nq7ecZtZO7KWsodWd74QDQM8=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr34537015qtn.364.1629808700537;
 Tue, 24 Aug 2021 05:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200108055735.660475-1-bjorn.andersson@linaro.org>
 <20210217223406.1422005-1-anibal.limon@linaro.org> <20210218041937.GU2774@vkoul-mobl.Dlink>
In-Reply-To: <20210218041937.GU2774@vkoul-mobl.Dlink>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 24 Aug 2021 15:38:09 +0300
Message-ID: <CAA8EJprm=CeDcObmZYJAkAeQPSwo9FSTx19TLu7_pLG-cZ040A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: db410c: Update firmware-name for wcnss
 and mpss
To:     Vinod Koul <vkoul@kernel.org>
Cc:     =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021 at 07:20, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 17-02-21, 16:34, An=C3=ADbal Lim=C3=B3n wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> > Enable the mpss remoteproc node and specify the firmware-name for this
> > and the wcnss remoteproc on the Dragonboard 410c.
> >
> > Link: https://lore.kernel.org/r/20200108055735.660475-1-bjorn.andersson=
@linaro.org
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > [rebased and moved to use pronto label]
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Tested-by: An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boo=
t/dts/qcom/apq8016-sbc.dtsi
> > index 3c7f97539390..8f1ada75d3ed 100644
> > --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> > @@ -301,6 +301,11 @@ &lpass {
> >       status =3D "okay";
> >  };
> >
> > +&mpss {
> > +     status =3D "okay";
> > +     firmware-name =3D "qcom/msm8916/mba.mbn", "qcom/msm8916/modem.mdt=
";
>
> Shouldn't this one be mba.mdt?

No, firmware-qcom-db410c provides mba.mbn rather than mba.mdt

>
> > +};
> > +
> >  &pm8916_resin {
> >       status =3D "okay";
> >       linux,code =3D <KEY_VOLUMEDOWN>;
> > @@ -308,6 +313,7 @@ &pm8916_resin {
> >
> >  &pronto {
> >       status =3D "okay";
> > +     firmware-name =3D "qcom/msm8916/wcnss.mdt";
> >  };
> >
> >  &sdhc_1 {
> > --
> > 2.30.0
>
> --
> ~Vinod



--=20
With best wishes
Dmitry
