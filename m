Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0483F4001A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349568AbhICPCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349566AbhICPCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:02:05 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B324C061575;
        Fri,  3 Sep 2021 08:01:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so3805949wmq.0;
        Fri, 03 Sep 2021 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PsMI7gL+pJyK2Fy7ieNnAa0j9CEtX/Te/MusU7XnP0Q=;
        b=CiW/wStBwAnSfwQ3ZzUS1mhcZpGMg2thecIfQZlaoPvhHzyjrQIhl8KBB2QkqovtDZ
         zd+OG2GHHe5MguX6ynAFz0FCWViy8wE6lhD94vWV71raepi1/EdUY6vSRy9vS2Jjt52s
         F/FXFbR2GoazR8IDoILVuqq1qjyK6MCv/AjJkBeNSKmn5gbF99ujfxm94syvkUHhPGWX
         FBLhjML7QnPedn3YPY6OQEDjhEKieA5AdMLOQnIKbCzoErlFkFtT5eAng52GmDe5h4WX
         rZP55hufBNlPlFuDfGm6uyJTWrp+xAqL4rutd6rm4wzDIpMahCMo12rRErtPK3DP3d+b
         BX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PsMI7gL+pJyK2Fy7ieNnAa0j9CEtX/Te/MusU7XnP0Q=;
        b=fqbmc8vI97RlSaAZGMCdFMT/ELZkothR8/rkVXMjl8m1ZdsCLjHjkz9PznXj3KMt3b
         zQqxv3nNHfblcJnBl1Du9Wm+dEskyLkb+jqrLIiLwBEsL3ZgF7vf2CSBBR3Ow8dDqaDk
         tyQ76i/6zZY5OOCq7/tr7a5A/XtOZnGYwod2SNvkQcopoVi+KZHGkuu8qhXYqyj90NWZ
         /pDpOomJqHdC/0yJrhqtTeruqnMHZnW2bqFd8K9WC3mYjlPcF04RWgN5IvzSwLsP1SFl
         R809mJReBSRrcYLF6zX2k3RGady4sX6hXpzCcktM6TTJpFK3iyKDgzSCjConML/N7qT+
         xnHA==
X-Gm-Message-State: AOAM532BVuSCnMgSkgo0myJF6cotgD4ltdHyzjb0Az/6MTHs8mNs9swj
        d6zdDU1medfAd+oSQDuKilpNkSw/cXLZmu6afR8=
X-Google-Smtp-Source: ABdhPJwq5LxbGRRTDY59rAzLY7dbuYJkXpaAFBEQt834jskgt6cC4b6dM02XFgqniOOGBkFe7PAeL2EnXkAGcbiSx64=
X-Received: by 2002:a1c:3b05:: with SMTP id i5mr873059wma.136.1630681263727;
 Fri, 03 Sep 2021 08:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210902123216.787025-1-daniel.baluta@oss.nxp.com>
 <20210902123216.787025-2-daniel.baluta@oss.nxp.com> <896baddd-5bd7-8f85-91c3-0a4498694d77@linux.intel.com>
In-Reply-To: <896baddd-5bd7-8f85-91c3-0a4498694d77@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 3 Sep 2021 18:00:51 +0300
Message-ID: <CAEnQRZDExjuj1eL4dRKXk-uyeKo3Mo24=CdmTnDz5EeAkYFDVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Add code to manage DSP related clocks
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        s-anna@ti.com, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 11:02 PM P=C3=A9ter Ujfalusi
<peter.ujfalusi@linux.intel.com> wrote:
>
> Hi Daniel,
>
> On 02/09/2021 15:32, Daniel Baluta wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > There are two types of clocks:
> >       * DSP IP clocks
> >       * DAI clocks
> >
> > This clocks are necessary in order to power up DSP and DAIs.
> >
> > We choose to enable DAI clocks here because of the way i.MX8/i.MX8X
> > design handles resources (including clocks).
> >
> > All clocks are managed by a separate core (named SCU) which communicate=
s
> > with Linux managed ARM core via a well known API.
> >
> > We parse and enable the clocks in probe function and disable them in
> > remove function.
> >
> > Future patches will introduce Power Management support so that we
> > disable clocks while DSP is not used or system enters power save.
>
> Unfortunately this patch does not apply to next.

Yes, because my patch is based on SOF topic/sof-dev branch and this small p=
atch

https://github.com/thesofproject/linux/commit/b56c58b5938a626fb08fcf1d5e38d=
687b520ab89

is not in linux-next.

I plan to stay on SOF branch and get the review tags so we can merge
it in SOF tree.
>
> I might be a bit too cautius, but I would also add "&& COMMON_CLK" for
> the COMPILE_TEST in Kconfig or select it from where it is appropriate?

Maybe add a depends on COMMON_CLK for IMX hardware support? Altough,
if CLK support
is not selected clk API transforms itself into dummy wrappers.
>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >   sound/soc/sof/imx/imx-common.c | 77 +++++++++++++++++++++++++++++++++=
+
> >   sound/soc/sof/imx/imx-common.h | 16 +++++++
> >   sound/soc/sof/imx/imx8.c       | 32 ++++++++++++++
> >   sound/soc/sof/imx/imx8m.c      | 33 +++++++++++++++
> >   4 files changed, 158 insertions(+)
> >
> > diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
> > index 30624fafc632..482c25ab15ce 100644
> > --- a/sound/soc/sof/imx/imx8m.c
> > +++ b/sound/soc/sof/imx/imx8m.c
> > @@ -23,6 +23,20 @@
> >   #define MBOX_OFFSET 0x800000
> >   #define MBOX_SIZE   0x1000
> >
> > +#define IMX8M_DSP_CLK_NUM    3
> > +static const char *imx8m_dsp_clks_names[IMX8M_DSP_CLK_NUM] =3D {
>
> static const char *imx8m_dsp_clks_names[]
>
> + ARRAY_SIZE(imx8m_dsp_clks_names) instead IMX8M_DSP_CLK_NUM ?

Yes, this is a good idea. Already fixed in v2 I sent eariler.
