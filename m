Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B3388399
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 02:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbhESALT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 20:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhESALS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 20:11:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C101EC061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:09:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i9so16318366lfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 17:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OuTM33XGtLwqa8MYciwrkAYfeQ5kekKTaJ8lI00J+rs=;
        b=h8O4DrZRkEIKrl/XUr78Ts7Z+5uTUkSBm2b+5q8n1o1rP5eMEsqe3JLY0RoalrthmN
         hFx904A+BhryeG5r014WnM3Ppb3ppkCbzLzH2yCCxevVIGIPrbxabKc4WEHvr1hDjdWq
         L/LVrgMDOlTc5LLNV02Y5nFswYHoZ5VQBrw1jc/Tr9If50zwJx+P5Y1yCzBki5O9QmoV
         jpsuQe/Le47+ZzAJ/OtWbMAAmrQXUAz2S+vcQfsEzEf0wfD0P5OU6toS75gEFj6v1Ew9
         9iBMry8hXEIvXdyzwh28L1Lk442e7oC4GWrHMsdBUKtvG15pRphJ+Qpmq6lB9ynjNzuZ
         ZBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OuTM33XGtLwqa8MYciwrkAYfeQ5kekKTaJ8lI00J+rs=;
        b=l7NRiDs/p8KkI5IT1uDvxZyi5eh/FxJNqRWg60TCJZ+fIuZOfv5t61xTv7dxHR/3pb
         hsMzCug4LqWBgy7Cw6RHF5pblBqXykrjHkNXjxAA+oQbLGhz3a04MXs5DHIM+0o64Zgw
         f2Bn0ibcKdkW1yeNxRTJdhRA/T0omLu95zcsnYo8yF/9CPi5fzn6IbOOzIqCrR2dKBbW
         CP8i2EYgIs7wKVWoR5W8vgTFVMpsoStIakIo9Q8AmxUbvgNcLTeRWVM/Wrk7M9IHwNxb
         kbVBHVuS+Ow9AukErtfJ6/+dVlr15ycT2hrTk6V/d+kkEBU8Ru7mvYP8oFXJAV56Ssxw
         nFIA==
X-Gm-Message-State: AOAM5313Nrohd+LDKTRaSUewv+mge8E/3mnxzi6XVN9pYBrlXTLROb9i
        cUB9zJlAnpv3xvZRg7eTgrFm0s9MnE77F+wRYlZ+pQ==
X-Google-Smtp-Source: ABdhPJzXvwNyBIFBAGkgV+vqz4OfOm7bjiZHvKaE/3qxTD4SKunmkPBqDuIYym7TgM9jIoYc0T7bA2xvseQYyURg98U=
X-Received: by 2002:a19:b0b:: with SMTP id 11mr5814348lfl.291.1621382997090;
 Tue, 18 May 2021 17:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210426024533.20840-1-zhiyong.tao@mediatek.com> <20210426024533.20840-2-zhiyong.tao@mediatek.com>
In-Reply-To: <20210426024533.20840-2-zhiyong.tao@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 May 2021 02:09:45 +0200
Message-ID: <CACRpkdaLhR9HgYNPZ_SQ-wi7RfpeT7iapXUfqf=bAwo05MBZqA@mail.gmail.com>
Subject: Re: [PATCH v7] pinctrl: mediatek: add rsel setting on MT8195
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, srv_heupstream@mediatek.com,
        hui.liu@mediatek.com, huang eddie <eddie.huang@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 4:45 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This patch provides rsel setting on MT8195.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

I am suspicious about this patch, sorry for taking so long to answer.

First explain what "rsel" means, because with no explanation I
suspect it means "rail select" which is what we already have the
existing generic property PIN_CONFIG_POWER_SOURCE
and power-source = <> in DT for.

Also add the custom properties to:
Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
(separate patch)

Yours,
Linus Walleij
