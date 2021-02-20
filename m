Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0B13206E3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhBTTVQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 20 Feb 2021 14:21:16 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:40892 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBTTVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:21:12 -0500
Received: by mail-ed1-f43.google.com with SMTP id q10so16619974edt.7;
        Sat, 20 Feb 2021 11:20:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CdZdY+wjRNfw1jbOEm4Qee3g4OL6v8y6yVQhOX5mqs8=;
        b=YjkXptnEJPhSRLRlEtM5bfMvpg8M6lw+g6kfj2Boqi+kTy6kayLmATDf70omndHZPO
         epaJmsHlCWrqiRzLc2oPWPZgCEPutCdME9YV0LYg0f8otIAcc3aE0HQAuld2l4IuoFwT
         r29gkbHPNt1JEfVxmOAnGr82igRtOtnyh/iKPfMj7jJq2kRyj7By/fAKVNKfwqAAOYzk
         fsl/LjSRjuO6KrQAeMb6qkUExgA1y2LL3n9rDe6Fouc1VKjEHFDaG9UrCpuMbS16AR7/
         d6MTSq1PD8MmK6RWwXJhEcgZslxDgxjsHBtIA0wKsDecEPYNINT3i8VqRTKKsc6eWd2T
         GAcw==
X-Gm-Message-State: AOAM5328YBX3L6AHGXx0/mZpHOrXIde93xVF7zDwz3MIQYLr34/R+PpG
        A+m0xIoVtNHRdGyUKTrIqec=
X-Google-Smtp-Source: ABdhPJzn45HpnhFKzehd0ns6kqR4zObJWCOALH/4m94AbXvp9HI0fkSvQTVqa9Qw9bbLUFuM0NgNxw==
X-Received: by 2002:aa7:cd63:: with SMTP id ca3mr8341404edb.119.1613848831058;
        Sat, 20 Feb 2021 11:20:31 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id m21sm6152746edq.86.2021.02.20.11.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 11:20:30 -0800 (PST)
Date:   Sat, 20 Feb 2021 20:20:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] arm64: dts: imx8mm-nitrogen-r2: add espi2 support
Message-ID: <20210220192029.nl3mk3b2tejxzyda@kozik-lap>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-4-adrien.grassein@gmail.com>
 <20210219131947.fcgoshnowurvwqf3@kozik-lap>
 <CABkfQAEB5K6HO9U_GkHGVDTKjR_JyBJVodidWXFSJcqw8LPcgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CABkfQAEB5K6HO9U_GkHGVDTKjR_JyBJVodidWXFSJcqw8LPcgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:02:35PM +0100, Adrien Grassein wrote:
> Le ven. 19 févr. 2021 à 14:19, Krzysztof Kozlowski <krzk@kernel.org> a écrit :
> >
> > On Wed, Feb 17, 2021 at 05:10:47PM +0100, Adrien Grassein wrote:
> > > Add the description for espi support.
> > >
> > > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 30 +++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > index f62a25efc69e..c4bb22bb4e6a 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > > @@ -10,6 +10,14 @@ / {
> > >       model = "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> > >       compatible = "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> > >
> > > +     clock {
> > > +             clk16m: clk16m {
> >
> > No changes here. The review tag was conditional in a way that I assumed
> > you will implement this change.
> >
> Sorry I misunderstood your comment. I renamed the "clocks" node.
> By the way, after a review, this nod is useless (not used).

The "clocks" node was okay, you can also remove it. I was commenting
below the clock itself. The device nodes should have generic names, so
"clock" or "clock-16m".

Best regards,
Krzysztof

