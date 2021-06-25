Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690093B4026
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFYJU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhFYJUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:20:55 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D8CC061760
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 02:18:34 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id a6so11829462ioe.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88FCEyGY0ObH+JRYnSMOFbc8rSLjvc2FivRi/MWezus=;
        b=clmTQ6i02Tj8s8oVZQHWalhZCVnAixA5WTtIyAGQL9bFK9TDRU4WY9w6YLpuaUPd4D
         lVG1MDJ72xb36377gWaJzV0cuc/8vgda8HyXZ1iB5cBTZu+B3l8X7LRtkn05iB26eG5f
         E0lwNnLMnegvu3O/6c1qmkG5WKYdc7f4cQMZjCcyijNLMDc3tsJyr1x03Av8qjjmg/+q
         QrZ18UapyQ1AtNDXrm7q0vKY32eTvZmOOCD0ht1W15+SbDf8YakNDTvPTT6f/KZQp4yn
         JduvzNX+WegZ57QObIYIJXvc88Evh0qAEpin2ELCCg+ti2khYJcTecXfuiK4piU9Fixw
         fW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88FCEyGY0ObH+JRYnSMOFbc8rSLjvc2FivRi/MWezus=;
        b=XdQzxOkqAJj3pOyItNnF5rsfWGwYxv3Qhbecv7Xjed8V1TFlvBgUglWno6bdTTgi1K
         hSsCpeKguzA+2MRrxVkpAeLqnKK5yrymuQOwcBSEkzj+CFUDNcnykhJKLj1aZdxGtoE/
         TrjCB0GkLWtWtfjcLSWWP+i2dQkA1TJ8g4ylBqmQaVcknBEA7Dg0t/BKlACYX0jHICXC
         gPH/v8z9QpCA6GeOi4/9CmWHbj5Cq3HPdGdTpq2mImgSsScYcGy3FGKASI4ma+QUtb4y
         xgyEq4T0GmC2aGdboR94NqFfjr43i3pp67V5q7zx559fYtdjjysdGNNpxqSzH3QglHGz
         ozsQ==
X-Gm-Message-State: AOAM532jsJjsaQrTdwAFDOdMHMOi0PBE/w1Nd3qDRrW3vCtAEb7XWIms
        U0/OQxTRq/l4zipb1bVqR0H8FCqgMzJq4DmsF6BzRQ==
X-Google-Smtp-Source: ABdhPJxbt3pm/73VTwg6WDqxvFoGlsWZppVPiwv/xS7DVbmoMx3sJvxUADJW/Q03NqHJbGeQmuoHUyhzht6/MupEWr8=
X-Received: by 2002:a6b:7110:: with SMTP id q16mr7755529iog.53.1624612713653;
 Fri, 25 Jun 2021 02:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <1624428350-1424-1-git-send-email-kyrie.wu@mediatek.com> <1624428350-1424-2-git-send-email-kyrie.wu@mediatek.com>
In-Reply-To: <1624428350-1424-2-git-send-email-kyrie.wu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 25 Jun 2021 17:18:22 +0800
Message-ID: <CA+Px+wW6PrYihYo8F2Op8XPfVHMmO7ODRQrF75DQxc4gRM-qfg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mtk-jpeg: Add binding for MT8195 JPG
To:     "kyrie.wu" <kyrie.wu@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rick Chang <rick.chang@mediatek.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 2:06 PM kyrie.wu <kyrie.wu@mediatek.com> wrote:
>  Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt | 3 +++
>  1 file changed, 3 insertions(+)
Note: the patch won't apply after [1].

[1]: https://lore.kernel.org/patchwork/patch/1445298/

>  Required properties:
>  - compatible : "mediatek,mt2701-jpgenc"
> +- compatible : "mediatek,mt8195-jpgenc"
> +- compatible : "mediatek,mt8195-jpgenc0"
> +- compatible : "mediatek,mt8195-jpgenc1"
Why it needs 3 compatible strings?
