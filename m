Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA644D095
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 05:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhKKEDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhKKEDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:03:36 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785AAC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:00:47 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id h11so9427400ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yH8ja7VP8p1VDclBmMvhEHUQneOCn8LZqdo+2OSyMiI=;
        b=eIzx/Cbomp+USxMUIAGgS7bftEgwznfBZbwgi6p4YI3FRo9gi/vdaBoUWKoHxfuyPB
         mw/y2pXpzxA6+5/d3+P7aH4bDsvbQSASCDLhGn5I2TrT5CpqK6ecRSNkPQN28wcFGADP
         9k8FnQxcE8jpHpctExcK3AVkY4qB7d6gviJy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yH8ja7VP8p1VDclBmMvhEHUQneOCn8LZqdo+2OSyMiI=;
        b=3tHCqEjAVDZKgcX7NVnXMcw7dQ3dLkC39afc5EY7b/QlNEFd23r3Q5KoAcy72r4KCe
         AqejbKWEWOFtS8WMDSCnusRcS20pYgyapHh6ZfdDvd4yRMSwG2Cb9Y9M4Lu3KQ7X+f+p
         JOLZhx5aSlwzBg41E+VYs+UcyUMuqSi88iLrMWqpXw5oYzb85HJhkirfXbxdYEY8bd7x
         jemMP99gyuiyTYK5VuS0ZZCefWS63CRzWkvBw+MvAEfnnlXJWqfbKdQZPtZY6X39gbDG
         7pNNQTtD+PdC0nnqKCiodQLokLU3TNcD4gHGIiFadlPtkN5ubQL1zEp94MWxGBEdpf70
         fgWg==
X-Gm-Message-State: AOAM530zvqO5bnFxw3AlpJ+hw1fP/BBeNzmRLHc6sVjzyE7O1q3gWWib
        TeVGw8ix2CBTuNx8iCuqnA7fSfYHUv/l1ygmIRmERA==
X-Google-Smtp-Source: ABdhPJxlV4gGg9kn82P4bK9eQigBUtH7JDNyQemvY5ujecR55RWBtQDaP9XzaDlfxT0NgRx3QJkfO5CE0wqzHMnZrAc=
X-Received: by 2002:a2e:9ed3:: with SMTP id h19mr4294059ljk.392.1636603245859;
 Wed, 10 Nov 2021 20:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20211109125030.26299-1-yunfei.dong@mediatek.com>
 <20211109125030.26299-7-yunfei.dong@mediatek.com> <CA+Px+wXSFkK1o__7YWntGwFXtfWKH65VoSq=783fEPoEH-MwGw@mail.gmail.com>
 <19a4cb1cc774f98bd79a1b3e4d25acfbd190ae28.camel@mediatek.com>
In-Reply-To: <19a4cb1cc774f98bd79a1b3e4d25acfbd190ae28.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 11 Nov 2021 12:00:34 +0800
Message-ID: <CAGXv+5GYLSxrmqMEpDx0aE1N1Wp7vHdDFDp9Ly0c=2f+njVpGQ@mail.gmail.com>
Subject: Re: [PATCH v9, 06/19] media: mtk-vcodec: Manage multi hardware information
To:     "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 11:49 AM yunfei.dong@mediatek.com
<yunfei.dong@mediatek.com> wrote:
>
> Hi Tzung-Bi,
>
> Thanks for your suggestion.
> On Wed, 2021-11-10 at 18:30 +0800, Tzung-Bi Shih wrote:
> > On Tue, Nov 09, 2021 at 08:50:17PM +0800, Yunfei Dong wrote:
> > > Manage each hardware information which includes irq/power/clk.
> > > The hardware includes LAT0, LAT1 and CORE.
> >
> > The commit message doesn't explain the code.  Could you provide some
> > explanations about how the async mechanism works?  (e.g. A bitmap for
> > all sub-devices' readiness ...)
> >
> add more detail description for commit message.
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > Apparently wrong tag.
> >
> Remove
> > > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> > > b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> > > index b7a51e96d4ba..eb2af42aa102 100644
> > > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> > > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> > > @@ -18,19 +18,49 @@
> > >
> > >  #include "mtk_vcodec_drv.h"
> > >  #include "mtk_vcodec_dec.h"
> > > +#include "mtk_vcodec_dec_hw.h"
> > >  #include "mtk_vcodec_dec_pm.h"
> > >  #include "mtk_vcodec_intr.h"
> > > -#include "mtk_vcodec_util.h"
> >
> > Why does mtk_vcodec_util.h need to remove?
> >
> Put #include "mtk_vcodec_util.h" in mtk_vcodec_dec_hw.h.

If this file directly uses anything from that header file, it should
include it directly, instead of depending on some transitive inclusion.

This would avoid having to deal with breakage if/when the includes from
header files change beneath you.


ChenYu
