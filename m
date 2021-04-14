Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3035735F6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350083AbhDNOzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345308AbhDNOyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:54:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435DBC06175F;
        Wed, 14 Apr 2021 07:53:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u7so8436319plr.6;
        Wed, 14 Apr 2021 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YMvYEtHewROZOpFAlE+YVnTRwtmI4sbne6ZZ7QNqKw=;
        b=gk1viNQDK7ATXpkM7+FeLIsLNRfFMGyp0/r07qHCpZQpPF0CpIQj0R5blR/OdQwqB2
         qpYJWOLGJa9ewSlnMr7wdEuxSxp1AfJ0Hjlpj1S1XFdpI/G2togUKr+loeuKgbgn4xFE
         8Rr+gnWPuVitTPdq41lvXakBF6WbVHCpY+lhCb3AElHcbMRVoE1KfmagE6u06IuQdFB3
         A9gK+4mFF66bDX416YCsn4iJ2j1XzECIGaECKtv7xaOkHwEkcCpxqocCfZK+BTgXmAnt
         G2CFuNYv2k/qwJeLyXFeuPlTxHZtUEX3jj0lqdCDjc6u/eNvjcxcGqubjgwI9DFU8uDn
         7SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YMvYEtHewROZOpFAlE+YVnTRwtmI4sbne6ZZ7QNqKw=;
        b=oDabDPxx9RX26y1ge4T3P3FW/1JHRqqF1v4TiZaEmEYU5SIFdZY9PoYdd0qp9HWgTV
         TKYdCnxW9uoGySdPB0eRcmlLEMWQPfqxdUq+2HfF7EG5U1joevAOVMW74EqkrwYUDkbe
         sLZgp1YAfQJP+9DNNfbDLKiSqsgbDnVKq+BRxKnJpM8bqGhymcxHjAjVPE5AnrMkI0tD
         lbdJyc94KZ8FjViVvFcjGW6Q3j42U9j9ycLSFrHpXjuxuoNPq3QKjtmTB3psfI2RUL7V
         VYwMMud47eHC18kY1c7ublQz4TcnNrKpBRSCxy1s8GlIcD9A90v3ID78AvHlq+hMwbSY
         +P4A==
X-Gm-Message-State: AOAM533wxJZOXUFK1i4qSEOOIADB5mkCYFC2Q27EtUneSK7heH8u40pH
        YHXFZ3NL44WncnZR+lI4xn2UtXnvS3tN0zjsLR4=
X-Google-Smtp-Source: ABdhPJxoTj72BoWiQQAL0hug/P6L4J7UqtuVV3Zj6//58oTaD2XEZzKaiijbRgpI7vJRshL+1CdfH5CNLg1PCWSM5ac=
X-Received: by 2002:a17:902:ed14:b029:eb:8e3:bfc9 with SMTP id
 b20-20020a170902ed14b02900eb08e3bfc9mr14876376pld.54.1618412008841; Wed, 14
 Apr 2021 07:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <1618226325-31927-1-git-send-email-yongqiang.niu@mediatek.com>
 <CABb+yY1b9wD0hoBx=aYzpLcF-=EEG4QTrV68sZj8+rtf5J1aJQ@mail.gmail.com> <1d946d1c-1626-33ed-26ba-f840729d63e7@gmail.com>
In-Reply-To: <1d946d1c-1626-33ed-26ba-f840729d63e7@gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 14 Apr 2021 09:53:18 -0500
Message-ID: <CABb+yY2ar8LcYMUrOTP8gH+DhNdV3aL7nuod4Uc_fuQq2A8K+A@mail.gmail.com>
Subject: Re: [PATCH v2, 0/5] Revert "mailbox: mediatek: remove implementation
 related to atomic_exec"
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 3:51 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 12/04/2021 17:29, Jassi Brar wrote:
> > On Mon, Apr 12, 2021 at 6:18 AM Yongqiang Niu
> > <yongqiang.niu@mediatek.com> wrote:
> >>
> >> This series base linux 5.12-rc2
> >> these patches will cause home ui flick when cursor moved,
> >> there is no fix solution yet, revert these patches first.
> >>
> >> change since v1:
> >> add mtk-gce.txt and dts modification
> >>
> >> Yongqiang Niu (5):
> >>   Revert "drm/mediatek: Make sure previous message done or be aborted
> >>     before send"
> >>   Revert "mailbox: mediatek: remove implementation related to
> >>     atomic_exec"
> >>   Revert "dt-bindings: mailbox: mtk-gce: fix incorrect mbox-cells value"
> >>   Revert "arm64: dts: mediatek: mt8183: fix gce incorrect mbox-cells
> >>     value"
> >>   arm64: dts: mediatek: mt8183: add gce information for mmsys
> >>
> >>  .../devicetree/bindings/mailbox/mtk-gce.txt        |  2 +-
> >>  arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  5 +-
> >>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  1 -
> >>  drivers/mailbox/mtk-cmdq-mailbox.c                 | 80 +++++++++++++++++++---
> >>  4 files changed, 76 insertions(+), 12 deletions(-)
> >>
> > Please break the patchsets (this and the other 3) into mailbox only
> > and platform specific ones.
> > Also, it would help if there are some acked/reviewed by some mtk folks
> > especially when reverting patches.
> >
>
> I'd prefer to have DT and mailbox patches together as otherwise the burden on me
> to find out which patches in the driver are needed, and to check if these got
> accepted, gets higher.
>
I meant the patches that need to go via mailbox tree (controller) and the rest.

thanks.
