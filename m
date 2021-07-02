Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BABC3B9F23
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhGBKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhGBKgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:36:45 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8ADC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 03:34:13 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a11so9295843ilf.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3EPRF1pEN1wQqk7o7Umd29HQktIGf0pO66kMZbdGeo=;
        b=n7GF7qwgngIJQ+Wly8+ZE8j4351YUt1QljTVtcvz7EjxYgdErZmqS1MMFrLeuxSHIb
         7R6FgTwhdUfQv8hLKYXmgU9cXXGruseoDTatriaJ4JjPXgy6OL/Y9k56gfWeMflcDHEr
         Ot4+wO8yuLGwDUY2tbuL23zF1sy3Yqly5smB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3EPRF1pEN1wQqk7o7Umd29HQktIGf0pO66kMZbdGeo=;
        b=GdHIrFIPkia6XKiy2VkfCGW/SP9aSFhJzjkZor3UTBehHhtgYxMAvxYhUgV78xTQLf
         ViBCHJ5qOqjknc6QVp6bfcVk0ZPgTL7GwF0zRQ1zu4WSMuu9BlDHBh2ngvxK2Vv2hikW
         1lv1M1XRe1DY4hlio9d9A6BGX4YSR/fSGwnUrN4gl05jVbrE+dAQZiPIiJGw957bs8gq
         01Ei3Nzs7wNPc5b34ywdeYD7qReoJ2P6kHPLHXenFp9Shq4hPPhIlzb7SgZymMv0Skyb
         7elSZaDR3yYVCKzrL6oLz3syJtqCOQOMfOkCvis2+ElWiI1Ihda0zHfOfh8uoBtL3aFh
         TiSg==
X-Gm-Message-State: AOAM531L4mCfzjdIBQwn9rocjoQlcxW44LNtjt2KT5w2IpHOp9k9G/mk
        kNkx24WwWkz9KcHbvpoCPh5/IrM5/psSNOCWfk3EXQ==
X-Google-Smtp-Source: ABdhPJzxVN9HaXoMeRol98y3X1xzmiqrkgjuq/VatFVk0MZX+R5NP0ktmPrhdGsERlJXh8YVKe8mmCZXs/n8qMfGnCk=
X-Received: by 2002:a92:7b07:: with SMTP id w7mr896465ilc.308.1625222053373;
 Fri, 02 Jul 2021 03:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210504054612.3585017-1-hsinyi@chromium.org> <20210504054612.3585017-2-hsinyi@chromium.org>
 <20210506203124.GA753747@robh.at.kernel.org> <a573e490-44bd-d6a1-d0c0-075b6541f720@gmail.com>
 <CAJe_Zhcz3yPcyxHMtAYTY+wKAzWxt2LJsj-AU7QFneW8MTv1HQ@mail.gmail.com>
In-Reply-To: <CAJe_Zhcz3yPcyxHMtAYTY+wKAzWxt2LJsj-AU7QFneW8MTv1HQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 2 Jul 2021 18:33:47 +0800
Message-ID: <CAJMQK-jMWQErHS+5Uutre4yXzae_5=RySrFo4gsyuxei-_zPMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: mediatek: Add optional mediatek,
 gce-events property
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:25 AM Jassi Brar <jaswinder.singh@linaro.org> wrote:
>
> On Wed, 12 May 2021 at 10:55, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> >
> > Hi Jassi,
> >
> > On 06/05/2021 22:31, Rob Herring wrote:
> > > On Tue, 04 May 2021 13:46:12 +0800, Hsin-Yi Wang wrote:
> > >> This property is used by gce clients.
> > >>
> > >> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > >> ---
> > >> v2->v3: move definition to Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > >> ---
> > >>  .../devicetree/bindings/mailbox/mtk-gce.txt       | 15 +++++++++++++++
> > >>  1 file changed, 15 insertions(+)
> > >>
> > >
> > > Acked-by: Rob Herring <robh@kernel.org>
> > >
> >
> > Will you take this through your branch, or do you prefer me taking it through mine?
> >
> I see I was not CC'ed on the patch. So I can't.

Hi Jassi,

A resend version is cc'ed to you, thanks.
https://patchwork.kernel.org/project/linux-mediatek/patch/20210622030741.2120393-2-hsinyi@chromium.org/



>
> -j
