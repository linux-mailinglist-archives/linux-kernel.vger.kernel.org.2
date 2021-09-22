Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B319B413FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 05:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhIVDKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 23:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhIVDKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 23:10:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2A5C061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 20:08:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m3so6051719lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 20:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvDHJ7BpWxgug9U9vBbLk1VQrGHUm2D+G+8DLCbP+bY=;
        b=Sfgsur3unKHCxqZ719aFss9Iu86/cxn/VrdBaa7t0sVfZbZ04ROT6DUvvF3it4orPq
         3LhMVXZA4pU7CBnxGrS9DyBiNXXr8/bOw7ZL2Uij+QQ8/Clst6kCbXd+thMELOx3WWFv
         hoOf9UsOV81dDEkVI1gPR5gR17doBuWVXzTDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvDHJ7BpWxgug9U9vBbLk1VQrGHUm2D+G+8DLCbP+bY=;
        b=IvlUFucFBO1W9k8gKN00uwwsR++XVHz5pl6h3p6KLbdY6CgWScXYS/tVZZbvkkOT3I
         aSYVfu2EVeJG94+VktNHBtUmToZiQVZUIP5u5V22oLnyJ+eQMySgnl9p27H91rzGw/S5
         yXPZ3muaX1fbHpSHidZ87xc4/yG3OH5QPJJ1xuGpW1WkdgaVwsvO8HOwwlJca1ubMqCh
         kGBZ9armGGnGeVWBHUH4JTy8OHUFFi649vGDV9uP47fXv/YsoDPzXmx7GIHuxh8Lfagh
         sPQ5ZkCxFgoFTbm1ftXlBVNz07y5hNyLzyt6dJ09DoPHT2Re37rAnr82nUNF29iz5lqx
         Y4yw==
X-Gm-Message-State: AOAM53069GWRUtJQ73R2dIngBr5carFnSddC9Y54RHxQ7MENadq01Ntb
        3aM01XZrvU6jk12B0Et+bs33RKsURyGJBBlMInG+mg==
X-Google-Smtp-Source: ABdhPJwXu6UxZE2/bkKplxqrHu28gVpzzYxNZSK+7DKxIotOikhK8OfyyvyApfd/1hOqHv5/p6JsHHkF9q5bI3DOZ6s=
X-Received: by 2002:ac2:4c4e:: with SMTP id o14mr27470353lfk.482.1632280125364;
 Tue, 21 Sep 2021 20:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210922025640.11600-1-zhiyong.tao@mediatek.com> <20210922025640.11600-4-zhiyong.tao@mediatek.com>
In-Reply-To: <20210922025640.11600-4-zhiyong.tao@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 22 Sep 2021 11:08:34 +0800
Message-ID: <CAGXv+5G9cW8uNnaUDzoAOWdy4Rw1Kgm6D7jFhHY2rE_vW4JGFw@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] pinctrl: mediatek: fix coding style
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com, Light Hsieh <light.hsieh@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:58 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
>
> Fix Camel spelling coding style to avoid checkpatch
> warning in a following patch.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
