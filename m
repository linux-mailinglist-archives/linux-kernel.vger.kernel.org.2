Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24B2360425
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhDOIUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhDOIUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:20:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECE7C061574;
        Thu, 15 Apr 2021 01:19:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j18so37893803lfg.5;
        Thu, 15 Apr 2021 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FfnqRo/ZbtdxVGZff5uYV7HooY4ykDd6sr4h4ImhvwQ=;
        b=N6ZsqXWlokRSDYCT4+xA6odNxdJnv7grSWwu0sxH4elIwp7jQ6MPiwZZuCO2fTU59v
         rnLylYpfOHfv0AQjYQ/KPNDosT2vGm+Nqy0OBHKuT3ZhgCH/+ZK7mOEZlaTOwZmzya/u
         U/lgzKFdEwK6KwdxaRYfFNpXa2DBCwgn93RaUKeivGYNXzwSD650kY6H+M4gPAVye1HL
         lE/tXudQTuHTo/JF/3VdfvR7JPQ1fr1PXbyMHtlvprJqct7EYtkY6F03g32R7i+NPxXC
         pJMWQ8L+qrqsF7Pc3E0TTfxlCvQ2RZ6Nl9H1sfo8OKJ2pL03AEYeKHggmfjmMpluverF
         uBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FfnqRo/ZbtdxVGZff5uYV7HooY4ykDd6sr4h4ImhvwQ=;
        b=Pq6V7ggX74IP05Jp2xusYZLbRZLwE57rWG7LZqNDJR83nhBLBx8NwgQlayvt9M3Pja
         UtYavdTOPi9Un1O9hx5JIKZkq5XT4XLIwYSKXb7N6rigjaNlOKLMSQ2B2byN8Fi46qiG
         koGN0Evia8tv2+U27pHqgDBsI4naeU7Gg2DnRSkNARIChDmgOa72ajP0Z9nfsJ25C0Cb
         AhHnkrTyAEEQaoeKYQ65Rr6TpHcN/fLxkiz7/ugZY48M+WjRqz4Q2gJ96U9/7tdXr5pZ
         bUeCM211aeYVOOCTXdRvf3kOufLSRqO3SOUeONxIHimWKvnG9R7xLIKZH8Ne9WEXW4Gg
         qG+A==
X-Gm-Message-State: AOAM533ImeOl1QnKVT58ihbUdCLVYfnkD6BjrQB9guRFF7aW6z7Ajw1t
        5UmdoKyf1j0KBFhpQ+tlGoGscEyG6PYd4QjhQa0iHAnS
X-Google-Smtp-Source: ABdhPJyxWDC9p3efVyUxwazeMnyrL0/ToYsX1iaQQo8kZRbCfX6/ATFc5gfc1kCCW7fV3A8PYyjwxikEp2L07Fv0Fpo=
X-Received: by 2002:a05:6512:1050:: with SMTP id c16mr1866048lfb.295.1618474795857;
 Thu, 15 Apr 2021 01:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210222132822.7830-1-kevin3.tang@gmail.com> <20210222132822.7830-7-kevin3.tang@gmail.com>
 <20210324112745.n76qhrbhzyfunmkd@gilmour> <CAFPSGXYK0Hi2-eYkukO2pNhHrJVZ=f79sj_hjXnGBZ_meVmkFg@mail.gmail.com>
 <20210407104854.fgn67pvau7dchcm2@gilmour>
In-Reply-To: <20210407104854.fgn67pvau7dchcm2@gilmour>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Thu, 15 Apr 2021 08:19:44 +0800
Message-ID: <CAFPSGXbJwNd47UAwVu4c1t5K7j4sgMtTLtDZ15woHZbRTghVfA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] drm/sprd: add Unisoc's drm mipi dsi&dphy driver
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B44=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Mar 31, 2021 at 09:47:12AM +0800, Kevin Tang wrote:
> > > > diff --git a/drivers/gpu/drm/sprd/Makefile
> > > b/drivers/gpu/drm/sprd/Makefile
> > > > index 6c25bfa99..d49f4977b 100644
> > > > --- a/drivers/gpu/drm/sprd/Makefile
> > > > +++ b/drivers/gpu/drm/sprd/Makefile
> > > > @@ -1,5 +1,8 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >
> > > >  obj-y :=3D sprd_drm.o \
> > > > -     sprd_dpu.o
> > > > -
> > > > +     sprd_dpu.o \
> > > > +     sprd_dsi.o \
> > > > +     dw_dsi_ctrl.o \
> > > > +     dw_dsi_ctrl_ppi.o \
> > >
> > > So it's a designware IP? There's a driver for it already that seems
> > > fairly similar:
> > > drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> > >
> > Our dw dsi controller is not a standard synopsys ip, we have updated a =
lot
> > on the basic ip version,
> > the entire control register is different, i have cc to drm/bridge revie=
wers
> > and maintainers.
>
> You should make it more obvious then in a comment or in the name of the
> driver. If it's fairly different from the original IP from Synopsys,
> maybe you should just drop the reference to the name?
Thks, i will be fix it.
>
> Maxime
