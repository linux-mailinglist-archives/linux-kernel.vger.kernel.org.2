Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017383FD3E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbhIAGle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242238AbhIAGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:41:32 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0725CC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:40:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id j12so3011025ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epJdN4f3MfJWPEsQ1/2NvR+leSyxvmf6Ol/q7Sv91t8=;
        b=mRVlvuMlRKfisqKuC3luRtD+7lHZt9EoAXjdWbTWH6cNuQQC6mg1w29lzT09vielVb
         I2Obog5PZudIXYal36CZLEgxg9Fw4Ix5JiTMy8r1Hwukl5bZ6CPXUGdD7YGLZoaLdSu/
         8Iki5swJ0F1Lhp74MeQCyy+v58G/u1o7jLxgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epJdN4f3MfJWPEsQ1/2NvR+leSyxvmf6Ol/q7Sv91t8=;
        b=Aj/mJwSjjnZQaHjXgYRg/6ZK8V151TeEsK/EFdT3QftJB10LrYZRp9UzFcSaiCTq20
         g98TjM11vUiYrvyl859iT4B88hxbJ+hml0RBUa2T00BHHveC7iAuRECS81USZFpCGcGL
         zp9KJzP/KmaeYPGt8hPGAHS3gjs3XzblL00E5ig7mTpzmTMIEF7qTmjgZxL09n03+bj1
         PXUZBPM3RFkfwiDuA8D4eq7SJRm0fY0V8V5HynnQl8Stkwj4J+Oc7F2BZ95M+jodyTSh
         GtdwC1bnLwzpuh+vwIb91N1pnFWZVGAf3y9J3RBhoD9AqW1D3xzXieIajaxrL1W4Ljx/
         uEEQ==
X-Gm-Message-State: AOAM531vzinVlgomCxN2BkD1LfH/02LouQtnRkJe1wP8wWfxb6gw/BeF
        hOCjuAaVkEEAwvEnhHuFXWG2WhgLn3Fo+V2wOwb50g==
X-Google-Smtp-Source: ABdhPJxj9wv3Q6Dl3qKpne3tkDBgA3ZLpglT9zE4jEZ+fPT/uXAvjzBpHCDwCs+0syRRHL3naD7W0r8tTExh0x6HsH0=
X-Received: by 2002:a2e:b0e2:: with SMTP id h2mr27468860ljl.23.1630478434422;
 Tue, 31 Aug 2021 23:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <1627890365-22992-1-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1627890365-22992-1-git-send-email-yongqiang.niu@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 1 Sep 2021 14:40:23 +0800
Message-ID: <CAGXv+5GNbx6jJ2MuCtmMF=ABuoqtS84OvhYoGr_nOrwqCs392A@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] support gce on mt8192 platform
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 3:47 PM Yongqiang Niu <yongqiang.niu@mediatek.com> wrote:
>
> Change since v5:
> -rebase on linux 5.14-rc1
>
> Yongqiang Niu (3):
>   dt-binding: gce: add gce header file for mt8192
>   arm64: dts: mt8192: add gce node
>   mailbox: cmdq: add mt8192 support

Looks like all the driver parts are in -next, but the dts patch is not.
Can you resend that patch after the merge window?

Thanks
ChenYu
