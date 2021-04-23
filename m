Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF17369518
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbhDWOvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhDWOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:51:06 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54939C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:50:30 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k25so6113804iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMcmdkM2gVl581eh1B9ABdRu1Z5YC42G/lU2iC/THzU=;
        b=qIlJIcsi0187qWtovyfGsZz8n53uJAkk180sB7FQ42Ul/t11paPOues0+jxUAYj71q
         z9RsmX6RKBf39KKb9QGFgnqmtQ7PZMoCIpjl9NvVNFTOHDaKm3xNbifQmiPvB3BoKhM9
         oGed1Yz0Y+WAC5hQh+W1uT6+jX9Lnt6k5z6R2IEEs5a3tP0zSuJ/B9zBKgMHXfcvw1Ky
         Q+kAkEb73gv+KUaxPZ5cw0mr2D/Y+2KVPp2MmheSH/cAnbOr5Lp49FAvpgMEzl+Wpruo
         rHjvxIQGw+E2ol8Xcd3waYnlj44uZ/Vxjgrw87E7HxtMO+uKHh4OfOSlNhGpNjLBnsEN
         UwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMcmdkM2gVl581eh1B9ABdRu1Z5YC42G/lU2iC/THzU=;
        b=fQ5RnafqEAnP5+sZgeOzWGF5Nm3FMSZR0eh0pdWsnMJvB6Q1qqwS1lWLZF6HUkzvO2
         ZTxYsAnElYRgTggvu4MN4BnCSfAu3jTzfOpKpmdTLkZcP6s+XANfy2kJaqVt92Kjqxx0
         qPceo6jMX3tu3NBk7ednWxhcdni+h8SoYd8Q2acTYb8qEW5I1qGbghkjZuseR+iRqIep
         E6HHN2CHzxt/pB1WSA3B1jyhleK9JjTRTonaxG0YMAcoTyJvNec7SKtjuXW3w6FzPdJK
         nSj7A24S9B7i4XNiNSNBbKWIdJ64GvMlt+kU/aJeq+NHP1q1wF25CazesKVcEUxOQ2IG
         0J/A==
X-Gm-Message-State: AOAM5301XF0msu1cRrGttyUgz9WMIIAzL3rpJBNnAXKtLo0hwssFYARZ
        qMbFUBsjxoyBBWZtATao7OARgxiJWONTLm90Ml6SCg==
X-Google-Smtp-Source: ABdhPJxCd6YQlgpzhXf6G9ZW9tJeJzvk3SgMyJj1x3xNVufTbvCo+nBbuDER55PCMLE0EGzTJ070ebIaCle6mrVMvZM=
X-Received: by 2002:a05:6602:81e:: with SMTP id z30mr3618410iow.90.1619189429739;
 Fri, 23 Apr 2021 07:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <1618971622-30539-1-git-send-email-peng.fan@oss.nxp.com>
 <20210422165634.GD1256950@xps15> <DB6PR0402MB2760E471A0391FF8A31980BA88459@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB2760E471A0391FF8A31980BA88459@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 23 Apr 2021 08:50:18 -0600
Message-ID: <CANLsYkwoS+3qYq=FHRLMjrJSr5cj_PiHaU+a+M17C+8-VJ+b9g@mail.gmail.com>
Subject: Re: [PATCH V5 0/8] remoteproc: imx_rproc: support i.MX7ULP/8MN/8MP
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 at 19:01, Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Mathieu,
>
> > Subject: Re: [PATCH V5 0/8] remoteproc: imx_rproc: support
> > i.MX7ULP/8MN/8MP
> >
> > On Wed, Apr 21, 2021 at 10:20:14AM +0800, peng.fan@oss.nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V5:
> > >  Add R-b tag
> > >  Move the change in detect mode of patch 5 to patch 7 Per Mathieu's
> > > comments
> > >
> > > V4:
> > >  Typo fix
> > >  patch 4: take state as a check condition  patch 5: move regmap
> > > lookup/attach to imx_rproc_detect_mode  patch 6: add
> > > imx_rproc_clk_enable for optional clk  patch 8: use switch/case in
> > > imx_rproc_detect_mode
> > > V3:
> > >  Add A-b tag for Patch 1/2
> > >  Fix the checkpatch warning for Patch 6,8
> > >
> > > V2:
> > >  Patch 1/8, use fsl as vendor, typo fix  Because patchset [1] has v2
> > > version, patch 5,6,7,8 are adapted that  change.
> > >
> > > This patchset is to support i.MX7ULP/8MN/8MP, also includes a patch to
> > > parse fsl,auto-boot
> > >
> >
> > One of the request I had from the last revision was to explicitly list what other
> > patchset this work depends on and what branch it is based of, something I
> > can't find here.
>
> Sorry, that patchset has been merged, so I remove that line.
> I should mention that that patchset has been merged into Linux-next tree.
>

And what branch this set should be applied to is missing.

> >
> > As such I am dropping this set and won't look at another revision before May
> > 22nd.
>
> Ah. Is it just because that the dependency patchset not been mentioned or you
> have issue applying the patchset that delay the patchset for one month?
>

Both.

> Thanks,
> Peng.
>
> >
> > > Peng Fan (8):
> > >   dt-bindings: remoteproc: imx_rproc: add fsl,auto-boot property
> > >   dt-bindings: remoteproc: imx_rproc: add i.MX7ULP support
> > >   dt-bindings: remoteproc: imx_rproc: support i.MX8MN/P
> > >   remoteproc: imx_rproc: parse fsl,auto-boot
> > >   remoteproc: imx_rproc: initial support for mutilple start/stop method
> > >   remoteproc: imx_rproc: make clk optional
> > >   remoteproc: imx_rproc: support i.MX7ULP
> > >   remoteproc: imx_rproc: support i.MX8MN/P
> > >
> > >  .../bindings/remoteproc/fsl,imx-rproc.yaml    |  11 +-
> > >  drivers/remoteproc/imx_rproc.c                | 196
> > +++++++++++++++---
> > >  2 files changed, 173 insertions(+), 34 deletions(-)
> > >
> > > --
> > > 2.30.0
> > >
