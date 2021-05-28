Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3539427B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhE1MZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhE1MZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:25:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5930DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:23:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i9so4987585lfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G3Q2tksrkhJxdvwhNQPoZFzNaFf4kubWs5c1nK9+kN8=;
        b=go3a0/QldXwLUCsSTRpbFZ8KKeW0RPYh5QJ3Wnsw2S8BJIvnzKSMDOABlCZXC032Yn
         Y6cjXU/fvNXI/J6bLEYNA2lUU9/Vcv63xjhqBhkKQhn8v8dO8gythQqEtfQ1wsedwsZn
         SrUsXCgC44fWU7SNCmDWBwNdv/yMiNyGtcYRM9ATua43XblVjvKYQLqH81wNe51rVgJL
         JOKKPj4XAHE2Rxd6vLKAY+2A+FYRpK+XWs+RoJoKrJeM8TrABZY3z5t2iJsZVr87yjjn
         3ctC552sZTl4wFvMXcK+93OWsBfzpCs9bM3e/Gw0KDZD468Jo/FjdscYpw+klYplKoCz
         wV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G3Q2tksrkhJxdvwhNQPoZFzNaFf4kubWs5c1nK9+kN8=;
        b=kGIFWmJw6jMVtZiZWux8PsIx6kve7GYXq794iSr/itZoow31c67DYT0mv65JAesT5A
         Ylz7mPHOi5qai9U02XVbRocN9sy66br8bhFxPoZcEiRIZ41ib98WJLAZ06AQ4Qwb6ap8
         2SFtcHBCtGxuCxgsHuWi9dbMfUjTg9nwdSntmNb3NdjxOSwcpZ1hYucMgNscfHi6rQkD
         1T9jm7I3v5WxJr7HYFzyvvnL2gyFt4P3QX27J3H68xR+BM5O4MdCMBkhgJVrwSZGz5Z7
         6f06z2y1FUlOK9I8T4Le4I/jSoqH7ueNA5s+MxGEuO1DaE4KjqHWjd8iW7hX+Sv70FE9
         3M3w==
X-Gm-Message-State: AOAM533ygtkvwtuCe5pmu9AoA/kdPFPpHfMyHCwJOBes+bMn2WrGuzDE
        mLeAMaoqgKGb2tPSGcWXLB+il+IngUOffTNwiH4sbQ==
X-Google-Smtp-Source: ABdhPJz5+pz0FCkYumJbEZ2ldKixmZ92VlhWiia9pBi/RAIyoShGa1yO7X5Tgko1t6nf+oXETJwWL0HyK4ajxCvE0i4=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr5674797lfn.465.1622204614193;
 Fri, 28 May 2021 05:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210518120633.GW12395@shell.armlinux.org.uk> <E1lmZT6-0005U2-8e@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1lmZT6-0005U2-8e@rmk-PC.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 14:23:23 +0200
Message-ID: <CACRpkdZmDrw6mp_ZeF8xaT5yyfrs9MuOXkVeccpwMuv_-f_Rgg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ARM: use "* SZ_1M" rather than "<< 20"
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Yanfei Xu <yanfei.xu@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hailong liu <carver4lio@163.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 12:11 PM Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:

> Make the default vmalloc size clearer by using a more natural
> multiplication by SZ_1M rather than a shift left by 20 bits.
>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Excellent, thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
