Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD22C430E55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 05:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhJRDk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 23:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhJRDku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 23:40:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E68C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 20:38:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u21so61256127lff.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 20:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Viwd7ANX416+8/ScF5bPasbghx1RgTJkrR17d6lCqck=;
        b=cOss8UMjm8u5At7QCwBuCldQAuU81snSCUVfCFeWgKRMqSf0DCsQz7siTH0U1Ro1IT
         FIhT7D8sWKBuY3xAqgVXx8PvYWHmK1LT9Ad4iHeYSINobQbkGHRCTSat3nTnACQJHkHI
         z1biYPooBEMwIRTUxuhj/MLofDV280icyOCC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Viwd7ANX416+8/ScF5bPasbghx1RgTJkrR17d6lCqck=;
        b=xI6uZSbiz6pOZSHFGYTerJLKl3ACwgXtYCcoMIteWkiPlS4uDvReHHf0Uz6lhzFuRO
         h6G2zyJwsTHzC/xODxgVnt0DdZzCQhCyAl/Gvy0UUot+dTosa1Ldu59IrnMI6xTA/jNK
         3xnUhwYGD/lJ7XezlSn1e38Sz2IvYKTRMVAoq/oiz0mdDTSRvpk/Nh9Vvgrf09dlkM/o
         sJOcwUWzmPj88qj3FH3meL4JjWCEmGIAgGPjAwhKhJFRyq0XiTKf3aViAtBdXB/NEFyL
         fcbkC6XQycpKdU8SreKUw46l8QHXBGkt6LzOt1tRwfjfOChTKuD8+xPQVgmLvq7AXgZT
         9+xw==
X-Gm-Message-State: AOAM533FtDNh2k98HIrGbvcRvh0Ic0SQeDgRle4hKLzsp7pypxkb419r
        GSsp0D+4+6bCsxtIcwUy9ZXrRleS0pWllPNTUHlTbA==
X-Google-Smtp-Source: ABdhPJwbqTTbxycWuW5Xz1CaF6uHYs50lpEYQFXSNoEJO51YoQ1Hbke6gK1K0igAWLtI/xW+tGlUpkeJLW0OObOd3DI=
X-Received: by 2002:ac2:4c49:: with SMTP id o9mr28370086lfk.482.1634528317739;
 Sun, 17 Oct 2021 20:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211005065948.10092-1-mark-pk.tsai@mediatek.com> <163425869104.1688384.2477307279117424281@swboyd.mtv.corp.google.com>
In-Reply-To: <163425869104.1688384.2477307279117424281@swboyd.mtv.corp.google.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 18 Oct 2021 11:38:26 +0800
Message-ID: <CAGXv+5HM07is85SyBEQ07TbvpAsi72qYJXtFEsyFcK2WSO=SsA@mail.gmail.com>
Subject: Re: [PATCH] clk: make clk_core_lookup faster by using clk name hash
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        yj.chiang@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 8:44 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Mark-PK Tsai (2021-10-04 23:59:49)
> > Compare hash value before strcmp the full name to make
> > clk_core_lookup faster.
> >
> > It make clk driver probe 30 percent faster on the platform
> > have 1483 registered clks and average clock name length 20.
>
> Why is clk_core_lookup() a fast path for you?

Maybe because the Mediatek clock driver still does global clk name matching
to resolve parents?
