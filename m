Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C232311E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhBWTEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233933AbhBWTE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:04:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C106A64E83;
        Tue, 23 Feb 2021 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614107028;
        bh=YWkkpozB3ER6IruxCaThzXsvEStNfh4WR48id4vPvlk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I3VfJYSz+d2PtdJlnic12kT2Q/y4xcO5gOz0+qcXpMppnOysa9W2+6xuanEvh1hqo
         RNf/I6Dyh2BV4fw78ZUyln/88t6ftQhXUh/52EtNU9d9VAdPkLh8qTV2plXQWYHCay
         U+dlOQmDKP6o1+xDVhtnoRIAir6sB6YAUV0adqWrE5t2X4qoDjuozjvW3qdm8VJo8U
         LQpVcaym+gnY/n+RzrvpWS66VDQPIn8GPiRhIlQongL6IExB6SB2KoYeYjrS69PjiT
         AfASGaXF4mHtX4aP2Hm5HmXz6Qnu+HEAFefWnVaOb61JHeoLRfRVyGvPwqgAOM7uhi
         pi5HD6iBxyEJw==
Received: by mail-ed1-f46.google.com with SMTP id h10so27075630edl.6;
        Tue, 23 Feb 2021 11:03:47 -0800 (PST)
X-Gm-Message-State: AOAM531WdlYKzagWRmAio/ivpr/FAw6hGA1ehBMHRB2R7wkTwXzMiSsA
        SXcSY//qijRGXjN3T7lNVSr8Ej1MVNzcNLfouJg=
X-Google-Smtp-Source: ABdhPJxCB7joItWdqwy1g7sRqW0BGLBkMngXKcSUhXcgiqKN72zVLRKflxhCJ2MUcjjrIVCb9lGHBuJHupznfZLapDM=
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr29217861edb.143.1614107026414;
 Tue, 23 Feb 2021 11:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-2-adrien.grassein@gmail.com> <20210219131825.niiftfm5r32qc6m3@kozik-lap>
 <CABkfQAH75N1k0bDEGzo0mRtoqP=-9p9hzBo43f6gQnSmGsXQUw@mail.gmail.com>
 <20210220191914.pir3ep3utz6uwyrb@kozik-lap> <CABkfQAGyr_ntKMR3Ht0CVZY7zLiBcRN3-WeWiZQ-BTzXHqSF3w@mail.gmail.com>
 <CAJKOXPfb69J+r7WdJMPbMsqaJuKYxKy6BwtEhmPFrEiZz8L8LQ@mail.gmail.com> <CABkfQAG8n3AGdamKZbNx9Q5N_6SB5S4=+nj4zuLP_Xk7zxF-cw@mail.gmail.com>
In-Reply-To: <CABkfQAG8n3AGdamKZbNx9Q5N_6SB5S4=+nj4zuLP_Xk7zxF-cw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Feb 2021 20:03:34 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf9fhsVFAQ+s+xhmuBFUk0=gVrv45JDRHM=WO9keZZwnA@mail.gmail.com>
Message-ID: <CAJKOXPf9fhsVFAQ+s+xhmuBFUk0=gVrv45JDRHM=WO9keZZwnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] arm64: dts: imx8mm-nitrogen-r2: add wifi/bt chip
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 at 11:45, Adrien Grassein <adrien.grassein@gmail.com> wrote:
> > > >
> > > > I would assume this goes from PMIC, so check your schematics. There is
> > > > little point in adding a fixed regulator which is non-controllable.
> > >
> > > No, the 1.8V is issued directly from the alimentation stage.
> > > So we can't control it.
> > >
> > > > I think bindings don't require it.
> > > After reading some code, I can say that vqmmc is not mandatory but it
> > > helped to find out
> > > the caps of the mmc host. In this case, we only support 1.8V on vqmmc.
> > > It avoids driver to guess it (and avoid bad behaviour on any future change).
> >
> > If the supply (hardware) is really 1.8 V then indeed your approach is
> > good. So let's keep that one.
> >
>
> To be sure to understand well: should I keep the fixed regulator?
> Thanks,

Yes, keep it, at least I am fine with it.

Best regards,
Krzysztof
