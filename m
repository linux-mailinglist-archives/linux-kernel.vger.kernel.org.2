Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639E63CB240
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhGPGQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbhGPGQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:16:45 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DAEC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:13:49 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id r18so4385900vsa.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaWOg4i1QyFovhcvCT5O/tinkkoBzWCthCbXwwL19/s=;
        b=Gpq//oAZWIx4e5//RMNF3P0AZmL3DAqBXSoas7dyXNiARwlJ3YCeDmk+iP/iiN5f3R
         J9Sw7KU9sF2OLf7L5bU0T61owRSw7AGbii0Q4W2lDibUyyQi248Oamvf07qvDxxhLNu7
         QExc5vWjhHp5kPZB3JFxt5GGYbmOjWOynZ1v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaWOg4i1QyFovhcvCT5O/tinkkoBzWCthCbXwwL19/s=;
        b=XL2e550J9VFelyTLOTfbgvW3XKxpYsVQY+MTrJWhVUMjgDRGdYuN9Mse3y+ozxrF9B
         +CLkpKjuSHbChMzG7vUC2vMrR2x0mpwfC5C5qy3g8x+WntARa6lR+g3t4Iv/fTQ5t24Z
         tsu4d9/uVQwCpkvyq2NkuJR/tjog+eY2GXv+E4BuzD66xO06JPpGvAGNYiRIHkSSldrj
         byL2fcL/Kfx3KL35T1rr5TAODa+rHhrkWofPr0zxSyIhItG4X0sWi1x6q2too+/FNYmX
         iCvFVuhDZFrKgCo1dAf4iv1caiXXfINkjotOzSnuPs/7UaeJiKCmr4Nf/b/tmMHMxFWk
         UMsQ==
X-Gm-Message-State: AOAM532kRW+6YstBSady/mRKRuuBqHF1eeLp8hf3PZwBz9gGRUe0k6GP
        p1K/tglLbX7xTvHcE3ImPmUgABrTfHYfAHDquduaeg==
X-Google-Smtp-Source: ABdhPJyUCBVFTZ95KegdcIpYpw6fUVW81J7XQ+o86thpKF6Pwc143zDeg+GjOAmfOak9O9kcvzTMOFLOWOswj5GjunU=
X-Received: by 2002:a67:87c7:: with SMTP id j190mr11270602vsd.47.1626416028582;
 Thu, 15 Jul 2021 23:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1624349479.git.xji@analogixsemi.com> <308427448195e2db37a32997c6d32905c96ca876.1624349480.git.xji@analogixsemi.com>
 <CAG3jFys6D=-L-Aez4aWuE4nM7qJCtn4wPws3TKxbkRzcAoFR0A@mail.gmail.com>
 <20210707073051.GA936385@anxtwsw-Precision-3640-Tower> <20210713221010.GA916196@robh.at.kernel.org>
 <20210716053215.GA1121520@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20210716053215.GA1121520@anxtwsw-Precision-3640-Tower>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 16 Jul 2021 14:13:37 +0800
Message-ID: <CANMq1KDprHg2eVN6p_PBOt4O9uw6Qt+5o0QasxhO9oPD=w5CAg@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] dt-bindings:drm/bridge:anx7625:add vendor define flags
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Zhen Li <zhenli@analogixsemi.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bernie Liang <bliang@analogixsemi.com>,
        Sheng Pan <span@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 1:32 PM Xin Ji <xji@analogixsemi.com> wrote:
>
> On Tue, Jul 13, 2021 at 04:10:10PM -0600, Rob Herring wrote:
> > On Wed, Jul 07, 2021 at 03:30:51PM +0800, Xin Ji wrote:
> > > On Thu, Jun 24, 2021 at 01:57:22PM +0200, Robert Foss wrote:
> > > > Hey Xin,
> > > >
> > > > I would like to merge this series now, but this patch needs a review
> > > > first. Maybe Laurent/Rob Herring are good candidates.
> > > >
> > > >
> > > > Rob.
> > > Hi Rob, I get Laurent/Rob comments before, and explained why we needs
> > > these DT properties, so far, I didn't get any response.
> >
> > Do I have to go dig that up? If it was more than a week ago, assume I
> > don't remember. This is 1 of 100 bindings a week.
> >
> > Justify why this is needed in your commit message.
> Hi Rob, I'll give more detail description in commit message.
> >
> > > Hi Rob Herring and Laurent, for the DT property lane0/1-swing, Google
> > > engineer has strong demond for them, they don't want to move DP swing
> > > adjusting to kernel, thus may cause change the driver code in each
> > > project, so config them in DT is a best option.
> >
> > Where's the ack from a Google engineer?
> They didn't give the review ack, but we discussed it offline. Nicolas
> Boichat known this.

Yeah I suggested this here:
https://lore.kernel.org/patchwork/patch/1359670/#1564682 .

I also looked at the ANX7625 datasheet at the time and it was pretty
clear to me that this was not something customers could tune without
ANX's help, but it'd be great if Xin Ji can describe a bit more.

>
> Thanks,
> Xin
> [snip]
