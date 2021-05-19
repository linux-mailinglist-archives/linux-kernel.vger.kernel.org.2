Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E220C38867E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbhESFZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhESFZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:25:01 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149BBC061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:23:42 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w7so724874lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgekGujD0L3/nuy0lfC+9c6pRyC5gvzSw48ji+1o7eY=;
        b=BxXwbNi9geW7T+UQxXc7H28320kvwfeHhK6Z/pd+0AYTKV/reJlbzKJC4H19m0YnoU
         iFW1hqFzgcsSMO9x503aMETpWJfSZP1YRNossqQlHRVF3YwT6NpR35ZR9ioalX8zjyLC
         VRhwJtGk99MfU9GmkdCBAIaYcg8r5cKy5Aa/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgekGujD0L3/nuy0lfC+9c6pRyC5gvzSw48ji+1o7eY=;
        b=llzkhdayqaKxdgOqlRlcqcsA1f4GdeMScHx0pZVAIlQ+kN0Fgc1RyFyB5jG9F+CppP
         QB7auXPvzqyY69MBtHx8QaQZA/3PZyMWYeJlFHdXOAUBdwRh68gAAHeurLrDpkSG88uW
         qzQ0silv/YP2gI0CGhAElmECVlPIWney7DR+cPqnuq/1YOukUSLKsjkZGv0+JYg+kEZO
         u1j7vq1sNiMCENj588lg20ZxDSlV6wGOeTp/ieWac7hzd07eu1y4CGYqD1V3LgeDWcBo
         siJHSTL1g/nrRcvtJJQ1Dz9F/85HvphKfrL5GXbOHKYKPLvga0V4SFe/5hA1PXMTGmgy
         YBrQ==
X-Gm-Message-State: AOAM5316CgOsjJBlJh++lLOeF+5/7YhzEOVxLH7YGIelEHxW2v9wxhv2
        DWSDggizEyPIijzDAhVjkzjZ0R+Svwk/DA==
X-Google-Smtp-Source: ABdhPJwhLxOvUkJKVktlyWKBJcJ/ZBAToMQoSHqkN5GGP1pr6Eem40OZ8+TtTd8qZkthQiecvcAEvg==
X-Received: by 2002:a2e:501a:: with SMTP id e26mr7104278ljb.260.1621401820268;
        Tue, 18 May 2021 22:23:40 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id q127sm3578645ljq.88.2021.05.18.22.23.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 22:23:39 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id v8so12178820lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 22:23:39 -0700 (PDT)
X-Received: by 2002:a05:6512:33c8:: with SMTP id d8mr7286426lfg.614.1621401818561;
 Tue, 18 May 2021 22:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210427111526.1772293-1-acourbot@chromium.org>
 <20210427111526.1772293-8-acourbot@chromium.org> <CAJMQK-g=bnr9bAkvN61sFapX_XOKmUF8LPivtCEzUhP-LjoHUw@mail.gmail.com>
In-Reply-To: <CAJMQK-g=bnr9bAkvN61sFapX_XOKmUF8LPivtCEzUhP-LjoHUw@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 19 May 2021 14:23:25 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXgG2fENJXgCrKoUxaeV6H0Azo7BWpwf9-4ZyJZ9JiSTg@mail.gmail.com>
Message-ID: <CAPBb6MXgG2fENJXgCrKoUxaeV6H0Azo7BWpwf9-4ZyJZ9JiSTg@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] media: mtk-vcodec: vdec: add media device if
 using stateless api
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 1:35 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Tue, Apr 27, 2021 at 7:16 PM Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> > From: Yunfei Dong <yunfei.dong@mediatek.com>
> >
> > The stateless API requires a media device for issuing requests. Add one
> > if we are being instantiated as a stateless decoder.
> >
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > [acourbot: refactor, cleanup and split]
> > Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >  drivers/media/platform/Kconfig                |  1 +
> >  .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  | 39 +++++++++++++++++++
> >  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  2 +
> >  3 files changed, 42 insertions(+)
> >
> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > index ae1468aa1b4e..4154fdec2efb 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -315,6 +315,7 @@ config VIDEO_MEDIATEK_VCODEC
> >         select VIDEO_MEDIATEK_VCODEC_VPU if VIDEO_MEDIATEK_VPU
> >         select VIDEO_MEDIATEK_VCODEC_SCP if MTK_SCP
> >         select V4L2_H264
> > +       select MEDIA_CONTROLLER
>
> Should this also select MEDIA_CONTROLLER_REQUEST_API config?

Yup, it probably should. hantro and rkvdec also select it, so let's do the same.

Thanks!
Alex.
