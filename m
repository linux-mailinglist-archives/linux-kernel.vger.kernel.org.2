Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A7F40D309
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbhIPGHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhIPGHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:07:11 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F46C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:05:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f6so6657858iox.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRejp9fBUz75pPpYulgRWk+QeXX34u+JOl4cIXv0kwQ=;
        b=Ak2Cz77sR13TPwLNmj+ejAQtCOz/tpJM5fKa5WU3P2XhhZ1SBjSoZpPzRyKtqaG4UW
         /Rw+8IS752mpR+6WXOLd8JORjuV/CeG9o1TMuRFFKusIO1Mhtwpt8I4vtmkaoGS0xrKz
         DSHXfqZKE/MU93UvjSuOnJtR0YqkWqkN7Qnso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRejp9fBUz75pPpYulgRWk+QeXX34u+JOl4cIXv0kwQ=;
        b=n2LjlFgiSmgp/RyH0zbsx6UhRJvvPQyadsrtaI8/hpAcWrdWYwunjTtdqrzIO9mCQz
         gMrA05JWuQo5hHrvTuYqxI51TRWDK7bUdoVOhSAHFDdUJ3igJdMNLQWO53z6NQZEu2FD
         UN1Aq7MgfGkOPDcMPQtlh+70HQX6ou5/1X3XMeoqAwDFEoWSIPC4YVN0Iil7q0wW1aTG
         tuDKv8KvJuuo5wEY76ONOYmthJP+CdgL4t0QmbqjdmL9/uwutuOjQeDhoZUC1GnJ1TtG
         3WlQx+M7o7RpiCBWo72/QWxMEig4D0WFiiojTCM2R71Rhv+iTS12R7JvMqZ42mwSEsyS
         3VEA==
X-Gm-Message-State: AOAM530HMhdkZXWB9hzQEo6NnMPPlHmnWbOlRuzQFP95V957WbCCb5xo
        8AmU6sW33ceGSKrgEI+4KH1QPfPyXn6tW1l47jVmwQ==
X-Google-Smtp-Source: ABdhPJzcMvw7GIOLJbLQphTJGnIr//LRcPOzFAAYapv3DkK0vkAJ/RP30k6cM5fcM0Rc4NCdkSmCSU5OA67W1fV860w=
X-Received: by 2002:a05:6602:1493:: with SMTP id a19mr3013814iow.55.1631772351387;
 Wed, 15 Sep 2021 23:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210825102632.601614-1-enric.balletbo@collabora.com> <20210825122613.v3.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
In-Reply-To: <20210825122613.v3.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 16 Sep 2021 14:05:25 +0800
Message-ID: <CAJMQK-iyE6myo4KVBYz-0V5HHXi89Eix8fB1CdfvXFRk0fJG5g@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] soc: mediatek: mmsys: Add reset controller support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 6:26 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Among other features the mmsys driver should implement a reset
> controller to be able to reset different bits from their space.
>
> Cc: Jitao Shi <jitao.shi@mediatek.com>
> Suggested-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>
> (no changes since v1)
>
<snip>
> +static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
> +                                 bool assert)
> +{
> +       struct mtk_mmsys *mmsys = container_of(rcdev, struct mtk_mmsys, rcdev);
> +       unsigned long flags;
> +       u32 reg;
> +       int i;
This variable is not used.

> +
> +       spin_lock_irqsave(&mmsys->lock, flags);
> +
> +       reg = readl_relaxed(mmsys->regs + MMSYS_SW0_RST_B);
> +
> +       if (assert)
> +               reg &= ~BIT(id);
> +       else
> +               reg |= BIT(id);
> +
> +       writel_relaxed(reg, mmsys->regs + MMSYS_SW0_RST_B);
> +
> +       spin_unlock_irqrestore(&mmsys->lock, flags);
> +
> +       return 0;
> +}
> +
<snip>
