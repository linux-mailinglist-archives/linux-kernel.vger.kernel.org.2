Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F55840BA49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhINVfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhINVfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:35:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3707BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:33:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so1441622lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwuHDYNEaiDI/aJEYO2xr/nSBBGTBZpvXVgQmkrcsw4=;
        b=rROH2yzr3S6kbYtbxlVIiG1Pg69xIb8Kbsm161Is9tg1HWufjgKO3B2nEhqdtj0XBB
         osAH5gX+ikNi05X6JQof1N4a3dv9mkRZm3X3FzRyObuRRAG3CLrPrZMwRrl+Y1TU0JeK
         gSLoNA74Iv6y796VP5/RDVzEgfbPQGKxIgxDrwQb4fhxKiGip94r5rvLHA4SzeTmbINQ
         e7MmK5ClaYzvNFlnk3/CRNXA0l+wbt6ORlLIxzcvtlRKWulOAtMOYfufj1bhq8Bex/7+
         Mcf/pnGLh5REmUYqxgR09GCD2NJ+9aQBDs1zzKJOW+800VUwgvkjU8X0WMbdPxJUxHsX
         15NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwuHDYNEaiDI/aJEYO2xr/nSBBGTBZpvXVgQmkrcsw4=;
        b=7EOW0pTVW+v7NFo6aRh3nCivmUbPVgyuW0NjWKOoAOXTxV9n0OLK2DmgDbdrhXhcEA
         /8PgPkbvhptt6k4yOgzosOi9hLbAcYp4NN/RkOhjq6dIYJ2tNiivtPdGf9040hnj5ifD
         3KPkdwo/1XFlabRXlQa++lQa6qcWniVe2LqfVpubcK7/HdN4syklZ5v9CPt1UMYWKsRb
         a1iFpkOpfyUunSkEjUCMI1YkT+Nw6893rjw1NwyB9iMRcRdsgoIJo2pzWl/nmB/nLIIW
         fC8k2xdw8oSx/m/xDKEklAuJEA+AHynxpyjfr40JiVJeazMv1d8OyduFcgy4Pq1Sqe3Y
         GNiQ==
X-Gm-Message-State: AOAM5313bhFIAM/V45oDdq+28Q7R88bLwuTHewbhdiud8LWbNXA0zNqq
        I55sxfpUDsqV61q50WHpz/pmaMICFFzWGn2zH9nWwg==
X-Google-Smtp-Source: ABdhPJzyeXehdl1YBv7AvRkykyWGNMCqmr7nwNJqITROIDypxvK3KPx57OOXA57Hayl6aCDTXB4lSC9WZJmrT4RA2yk=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr14692217lfu.291.1631655221446;
 Tue, 14 Sep 2021 14:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210906140256.113860-1-wangborong@cdjrlc.com>
In-Reply-To: <20210906140256.113860-1-wangborong@cdjrlc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Sep 2021 23:33:30 +0200
Message-ID: <CACRpkda3R6aU5+GE_V_1nCNFCAh3kehvEeFPuRL6y2u5cCQdwQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: Fix typo in a comment
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Hailong liu <carver4lio@163.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 4:04 PM Jason Wang <wangborong@cdjrlc.com> wrote:

> s/there there/there/
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this patch into Russell's patch tracker.

Yours,
Linus Walleij
