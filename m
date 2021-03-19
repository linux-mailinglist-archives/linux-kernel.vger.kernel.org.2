Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28656341DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhCSNKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCSNKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:10:23 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72D7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:10:22 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id e7so3438028vsq.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vN+6ZZbUDY/MgRy4uJY7I9AN3GwOfse3JgEB5J3TpJ4=;
        b=kLwx5x3+nJXRDDLtWxnZKra9ZWYq3G51xUBlJaIFOR98DaZGCzTuotMuOpxLg2HIGI
         eXrCmUUWvnwNILnJa7RgonPy2PHSIr6DXWX74/hB1JrvLOqO2Z1BgQ8ML0ypgrg0+4FU
         QHIloqf1j5R6K78BJ7vVhNLgLC5WaatP5BBVYGUbi4DmJadM/MYguA0cN7tABPOr7+OG
         ieHCur1UTi2XdY2DDN2TwR6QULmScs7W0bH8V7TEzd9HhhtOTtC3JABR0T7oICtm0FGP
         lk2p2284sTbnC8a2gGgVx5D3GzoreiQMiFXpd+IbfLGOlmAHlVgfQPlpqfsakyuO5NtR
         jzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vN+6ZZbUDY/MgRy4uJY7I9AN3GwOfse3JgEB5J3TpJ4=;
        b=VFap1JOSCw/WodoNN3ANxxxsX2Pkssb1NP2gQa2XhEAk+P3dMUYNsaZA3gYeujsI0i
         hj8E0bziSl/GOxSybY8S8Hdst56TiWXtZ5gQQk/yEkuwD4MvY4TS6EKeblU5v/Nc3yf0
         9eCc/yfytmcJuJ3ozmicOmVZYWBU674p9dC5QeNgqyXDHf1swxsYh8QQEZk+RFuNgsK+
         LnksSUx80l2JEx+4hDThH4kMnp/vDLaKyM7viiLSBGWyYTx8bRV3DYOaun2+QAOyA3CO
         2UzPA6oG9Izg7/QIRnugKwaSF+Cqx967Xgd5FBVFPhJLMVkZtIrqZ5bh58lb0JRlYqKo
         xZdQ==
X-Gm-Message-State: AOAM530YV9G5e5WWQIHitHrCDozRXR3RZGihtn7ejttZvnKXWP5Fg7ht
        Qj4s1PHZqe0TvgdPf+Q5cxij+Nm1X8omq+8tqh4NOrHEniLtGQ==
X-Google-Smtp-Source: ABdhPJxNxas+qVvOyI2M057o6zIbYXFwxZYAOqVxNVFavGZHLr48LcwYHjZN59TzJd9ochapNdFPKC1LqwPiVPOevw8=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr2482548vsc.55.1616159422004;
 Fri, 19 Mar 2021 06:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210317093117.16091-1-ulf.hansson@linaro.org> <AM6PR04MB4966C6D0E08AB4C25B280CF480689@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4966C6D0E08AB4C25B280CF480689@AM6PR04MB4966.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 14:09:43 +0100
Message-ID: <CAPDyKFrCaS-tkFrZ3S2Bpq=vu=daGB00Onjs39o8AcWxHcQf-w@mail.gmail.com>
Subject: Re: [PATCH] firmware: imx: scu-pd: Update comments for single global
 power domain
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ying Liu <victor.liu@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 at 04:31, Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> Hi Ulf,
>
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Wednesday, March 17, 2021 5:31 PM
> >
> > Since the introduction of the PM domain support for the scu-pd, the genpd
> > framework has been continuously improved. More preciously, using a single
> > global power domain can quite easily be deployed for imx platforms.
> >
> > To avoid confusions, let's therefore make an update to the comments about
> > the missing pieces.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks for the update.
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
>
> BTW, I'm still uncertain if the new approach can finally work well for i.MX as SCU PD
> also supports multiple low power state.
> I could investigate it more when I adding multi low power states support.

The multiple low power states are currently only supported per genpd
and not per device. So, yes, in principle you could have one genpd per
device as you currently model it, to support this.

Although, thinking long term wise, we probably want something else
that doesn't rely on the device to be attached to a genpd to support
this use case.

In the past, I have been talking to different people from various SoC
vendors and it looks like the use case is there, but it's kind of
messy to support it. I would certainly be very interested to hear
about your use case, would you mind sharing some more about this?

Moreover, note that, there is a limitation in the genpd infrastructure
when you build a hierarchy with parent/childs genpds, when each genpd
has multiple idle states. That is, a parent-genpd may be allowed to
enter any of its idle states, no matter what idle state that has been
selected for the child-genpd. As a matter of fact, I am about to fix
this problem quite soon. Is perhaps this something that could be
valuable for your platforms too?

[...]

Kind regards
Uffe
