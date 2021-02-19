Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2A31FA41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhBSODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBSOD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:03:27 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18241C061756;
        Fri, 19 Feb 2021 06:02:47 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jt13so13562687ejb.0;
        Fri, 19 Feb 2021 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rlCdt+bBMYW5MMvzuCoUwtbB41pk2wZIzzv1yeG1BbU=;
        b=sxImjz+JB1jsSUz1yeQFTdGKq4GzapU9awQWs+ym5f1aVI6sUN47AN/LWLNeoe5bdl
         WYAH+D2s80chLYMddxqPlTESUTbCciYBcF7IX1pqlM0RmgKhR4Hc1taa6wmjgZ0HEOsd
         /Ek35mkRmVcIJqKQtcMeSZ0b7vHdFkfKAXjGNaufT2oelDiOmeD9jM+7PRo3fJ4761qg
         FjuDO2ejo/rBxJIzgxM8Hb3FIjIAXV4JkpIu/cwRsGoYdPtVve/mPwDO8uvmRJBRLEO+
         PSc3cCKPoW8TfBTWQkltg8+p/Osjg4oeqo+CKrYpe2WTI3r5ScU8+qpOcGHyXXOHn766
         Yb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rlCdt+bBMYW5MMvzuCoUwtbB41pk2wZIzzv1yeG1BbU=;
        b=gRhTGa1sajW5csPNVfdwjseCLglJPhmffgDPph0SgQyH5Gcqy6lCXcWMisVsWLXURn
         Dz501LARp8XrIwGnGZwLk4gWqJq69WJFo6AtYlh4IdYfsrJikSiB0Kw7MlFgegshWejm
         2UuCkDqxAt3mracXk7H6hrLtYQ46VR8jtrZoHr8q5UNb8i8S3P4OQ7O7NNlFGUZTbg7B
         MEO0/iq1Zts8fQp7YHlQYHFv/9bzLgzev+2jautPRMvtKqDae8J0Ac79chD1sEo0/x0b
         zEE2D7xvfPKhfxl1n1XnqjoMRFzdN+OA6XfQh+qoa8/9V3qohNsWp8BOTUDrOKAAnXXf
         8/iQ==
X-Gm-Message-State: AOAM532GLEw3X4v8aXDNPZ58oGDSURrQRh+d7Y8dTwFZ2buew4+Xl0V1
        wBZ4zPkM+3asE8jBaXCMOCVJAxejQA2uSOgfwyc=
X-Google-Smtp-Source: ABdhPJyLAV5fXnqyK03k8lQTh/uS8cTWH20tOmTXeCjhcR37Nl1IOdN+0C8uyDg8YfYFBbnRw3/Yjb+f/Efbz77YKaE=
X-Received: by 2002:a17:906:11d5:: with SMTP id o21mr8559303eja.504.1613743365807;
 Fri, 19 Feb 2021 06:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-4-adrien.grassein@gmail.com> <20210219131947.fcgoshnowurvwqf3@kozik-lap>
In-Reply-To: <20210219131947.fcgoshnowurvwqf3@kozik-lap>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Fri, 19 Feb 2021 15:02:35 +0100
Message-ID: <CABkfQAEB5K6HO9U_GkHGVDTKjR_JyBJVodidWXFSJcqw8LPcgg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 19 f=C3=A9vr. 2021 =C3=A0 14:19, Krzysztof Kozlowski <krzk@kernel.o=
rg> a =C3=A9crit :
>
> On Wed, Feb 17, 2021 at 05:10:47PM +0100, Adrien Grassein wrote:
> > Add the description for espi support.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > index f62a25efc69e..c4bb22bb4e6a 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > @@ -10,6 +10,14 @@ / {
> >       model =3D "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> >       compatible =3D "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> >
> > +     clock {
> > +             clk16m: clk16m {
>
> No changes here. The review tag was conditional in a way that I assumed
> you will implement this change.
>
Sorry I misunderstood your comment. I renamed the "clocks" node.
By the way, after a review, this nod is useless (not used).

> Best regards,
> Krzysztof

Thanks,
Adrien
