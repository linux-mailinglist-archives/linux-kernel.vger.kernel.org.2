Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538353F7F51
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 02:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhHZAeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 20:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhHZAeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 20:34:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 128C1610A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629937995;
        bh=SbycQ9kZqssax3PP+kHq0IDJta79FNerEMDO87wY3QM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n9GhZ42ev+K3L8aZKa5NSttM7oT98wtFhKL2i5OgqQy7x2QJADHrUhgisvMKEb8Da
         006maSkL7oNvIaxWdePEmBp37JAZ/RUTm+d2r++UGsCe1lg1V0DFUCU/T5VM9tH5Yt
         Uy3l13oK2R1CmSmOWUF8KZ2/9INRPgvyug8zTaWkn5FaytsG/854/A0ub6wzs+RXto
         Oa4VFBwJVlABrDUvn2gyhKl/L95HSttYDW8gQTm/VX4YQGrO3e93zyJ/9uzc2FDhuq
         VCEAHbZomI+c0xNM3ied2ceWgM5qs7HULhNYG9DAaI+4xinD27aB6EYoLRnqIKuORN
         uYzEqBcDmFwmw==
Received: by mail-ed1-f52.google.com with SMTP id i6so1848498edu.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 17:33:14 -0700 (PDT)
X-Gm-Message-State: AOAM533BTrwmiznSWpWzIyKhpku0omuoFC/7bI9Nhw1N1iPeWgjjxwfI
        JKomlCgjdRtyYMUC2qVMDcRu8NRHC2qnLhk8MQ==
X-Google-Smtp-Source: ABdhPJyBPuQaGp8lfnXeBg0U5q3Cqp6INUxGUp0eCq4GNnGDtFawyemhfYjZTPeZHt4IH5oA9wNJxuhramUAwgIbgtc=
X-Received: by 2002:aa7:d351:: with SMTP id m17mr1303182edr.72.1629937993715;
 Wed, 25 Aug 2021 17:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210825102632.601614-1-enric.balletbo@collabora.com>
 <20210825122613.v3.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid> <ebbe37cb0188a7ea23608569ab083e65e0f95df6.camel@pengutronix.de>
In-Reply-To: <ebbe37cb0188a7ea23608569ab083e65e0f95df6.camel@pengutronix.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 26 Aug 2021 08:33:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY__wg+dWi-4v4evyuWp1EVfj2bap3xtsHZdGET4Jf-MgEw@mail.gmail.com>
Message-ID: <CAAOTY__wg+dWi-4v4evyuWp1EVfj2bap3xtsHZdGET4Jf-MgEw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] soc: mediatek: mmsys: Add reset controller support
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Nancy.Lin" <nancy.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Zabel <p.zabel@pengutronix.de> =E6=96=BC 2021=E5=B9=B48=E6=9C=8825=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:46=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, 2021-08-25 at 12:26 +0200, Enric Balletbo i Serra wrote:
> > Among other features the mmsys driver should implement a reset
> > controller to be able to reset different bits from their space.
> >
> > Cc: Jitao Shi <jitao.shi@mediatek.com>
> > Suggested-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/soc/mediatek/mtk-mmsys.c | 69 ++++++++++++++++++++++++++++++++
> >  drivers/soc/mediatek/mtk-mmsys.h |  2 +
>
> Cc: Nancy - this patch clashes with [1], please coordinate.
>
> [1] https://lore.kernel.org/linux-arm-kernel/20210825100531.5653-11-nancy=
.lin@mediatek.com/

Enric's series is all reviewed or acked, so I think Nancy's series
should base on Enric's series.

Regards,
Chun-Kuang.

>
> regards
> Philipp
