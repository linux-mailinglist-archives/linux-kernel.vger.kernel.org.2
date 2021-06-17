Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0103AB367
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhFQMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhFQMVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:21:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88055C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 05:18:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x10so2840113plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7j6ui82C3Q+yfIJpsh1KXzxS70VcWmmv393YkvqCZis=;
        b=G861an8PtYU5auXGhG8k2swCfG9jZxnfO0wXUcvlpxtxvtkIo7i9XEs833CWUiGshA
         Hh6IAJUgmv8dHBx7cFyDVz5XP+3Odki7vDb1o1WorMofp4kRUJQnHld41KWid24BQCpE
         bAPG3sxef84fdRafJo/ska7qYaFsRVjQoSgFk7APUu6/oxYupIj0x2V5t23+56mtKRjL
         FmrODWJKY7pukev5bI7SPpFmKkfJ5wgE0Vux+p9UKP+6uOOV4dnvbVJ3W7O82ar8SUkV
         us7/GGTLw+l4UzZ3UJWQgSv9KEIYxCDSm0YzC0Fe31yC+pfdFv1VLMH0zhK8u0jQpS1w
         oKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7j6ui82C3Q+yfIJpsh1KXzxS70VcWmmv393YkvqCZis=;
        b=CrAAMINdYam3roKyfRN962G8yZnLFO+lrB50t7nB1C+t6U1S9MCJGpLuXePzYbc8Hp
         NJEJd5OK+JXBH1pu/LwdibEnCGnVKQ6h9CaACekoEg3lAiCce2cwOnQJVXObzMdctAGl
         qZDQc387vCRdOY0JOaZ9A2K6aVdZU76cvnc1A3PxoDLG44KS8yndOQyBnUXnDDPLowN4
         oFbdt4Shte/bqaQf+57uOeaG9RTOs1KG+q64XRNSfLV1oE0wwOFiaF1Ax9LhjpDt6tms
         kEfLvxU/U+3qgIphLDVNaKny6a8LM7RO6M5pA9+suno2bDTQ1+dquYCkmzwvSnOxfoSi
         JPCQ==
X-Gm-Message-State: AOAM530yrActQNHG7+fiQD/nc6Dz876qQBZFz5PMIIxP9KJJdDqIfFaV
        ySQC6zRolSl5oLp19isXau7n9L+C0AddZ6qIOA==
X-Google-Smtp-Source: ABdhPJxaI//ySQM/6KClcEDFG8whdVkseChcSlm+tz1wGgj2pKzs5Z0Xx+xk3J0xI2gBrDLpboMGAhCMPZdcijM56bY=
X-Received: by 2002:a17:90a:aa98:: with SMTP id l24mr5343340pjq.156.1623932334117;
 Thu, 17 Jun 2021 05:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210615130326.2044-1-fengzheng923@gmail.com> <20210615132207.GG5149@sirena.org.uk>
 <CAE=m61-kHPeKNvEEc08w8DeUwssGPWNf5UaYojRPNZRJ0v=arw@mail.gmail.com>
 <20210617104828.GA5067@sirena.org.uk> <CAE=m618Gtx_RQ4+h=8+TFvbcuSTpNWVcx1bry+8OggL6uDCzfw@mail.gmail.com>
 <20210617120747.GB5067@sirena.org.uk>
In-Reply-To: <20210617120747.GB5067@sirena.org.uk>
From:   =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date:   Thu, 17 Jun 2021 20:18:43 +0800
Message-ID: <CAE=m618zRgqd8vP=ugyZv0RMcENY5ZCmznrFOR6SoovKNpMCag@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        p.zabel@pengutronix.de, Samuel Holland <samuel@sholland.org>,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8817=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 17, 2021 at 07:50:42PM +0800, =E7=8F=AD=E6=B6=9B wrote:
> > Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8817=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:48=E5=86=99=E9=81=93=EF=BC=9A
> > > On Thu, Jun 17, 2021 at 03:42:43PM +0800, =E7=8F=AD=E6=B6=9B wrote:
> > > > Mark Brown <broonie@kernel.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:22=E5=86=99=E9=81=93=EF=BC=
=9A
>
> > > No, that's what you have already make the entire thing a C++ comment
> > > with //s.
>
> > I don=E2=80=99t understand. For example, sun4i-codec.c sun4i-i2s.c
> > sun8i-codec.c and sun4i-spdif.c files are the same as mine.
>
> Other people doing a bad job is no excuse for doing a bad job yourself.
>
> > Which file can I refer to? what should I do......
>
> Make every line of the comment start with //.  See soc-core.c

Thanks, I understand, I will fix it in v2.
