Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42693D114E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbhGUNqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbhGUNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:44:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D7EC0617A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:22:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id t3so3251498ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxH3J+Eoh7kaNaXSHILbrEKptNqW5XNSkT/LEfhorfw=;
        b=np3T/tKhWSs3xDEU7MtFijZp9knPrBJjhodCGPOhu6WamYYnmI0gWgLGwLiNBVO5Cv
         PY1SoZQb+Yd3SboBPYmHKlddwz0Qh7RS4ABDPEFwe+7cPUmCuN7+IY5A/hWgkSBr2lMX
         j5/t1emiw10+TGpDl8R9AGk0R6trQrmcKoEZ7ZcoQsKlqecQZu+WjhXR8he0+NqXegso
         4j8UZUofI2jkgKlTt5CnguAr5JSdq8A7kgzUkaQ1+2bwoj3MHdKoPFbJYCkI2+zkhmPO
         2AKw2+7SY6NIuFDUZ8U29hXdJ4BRQcYUrQLeC7Kzmo837X3mqcFFVJNz9cBQFO4GYJWV
         hfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxH3J+Eoh7kaNaXSHILbrEKptNqW5XNSkT/LEfhorfw=;
        b=amRh6dWVTKszUz20gMOH+yZkziZZb8jhmqaF1o/fsU5DzbrG0WDq1wQBfsWonWtGL/
         5K+ccxQPUA0tW/xyKHEB4VlCKvyuGfazpogFGoZGeleG1n5WtRrOEUIBCjMJiKxYvf3w
         7qxukuh/uhbxq4yT6LVIO94REFMijGa7Of+3vB1AmJ4qCGMf3k3scll6QKUvaK+hjd03
         aFEMDab5bE6T4QLpgxkvfwXZEwA73cIBKG8t3GIEwrW8LjPFETxaA+kS9CH5jUZkeEvv
         ++esr6w7M4LO/cT0ZMn0k/ftzuI0uiRp7SI8icOWaWnzBHecvrATd2Hk8r2FtVZk8Ci1
         f2tw==
X-Gm-Message-State: AOAM533StglEzpr7U4VHh3QntvciHp3R0ApWrf5xHUATy2fPLWwKn/5T
        uSOwyEUX/GJDLUXlB2kP4seAJmM3nnwXsuloZF6KQQ==
X-Google-Smtp-Source: ABdhPJxRKXD+U0XQM/F7sLwpZwFlzVAYL4bWalqIvOAZRJl36XOz1b+yigg+oOm5a+edqTSoFlwCiEItIcz7ltih25o=
X-Received: by 2002:a2e:9d15:: with SMTP id t21mr31738197lji.200.1626877364224;
 Wed, 21 Jul 2021 07:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com>
 <1626853288-31223-2-git-send-email-dillon.minfei@gmail.com>
 <CACRpkdYerVu_LyNOJoxMTqhuNd9QBSFWTM7bfRnrsOyrxqE_kw@mail.gmail.com> <YPgsl5M6P86iJADt@ravnborg.org>
In-Reply-To: <YPgsl5M6P86iJADt@ravnborg.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jul 2021 16:22:33 +0200
Message-ID: <CACRpkdb14g+cn1hKi+gF6oOLMSNLffvuuJbVqR95pmuCtgjHEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: display: panel: Add ilitek ili9341
 panel bindings
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dillon min <dillon.minfei@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 4:18 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Linus,
> On Wed, Jul 21, 2021 at 04:00:35PM +0200, Linus Walleij wrote:
> > On Wed, Jul 21, 2021 at 9:41 AM <dillon.minfei@gmail.com> wrote:
> >
> > > From: Dillon Min <dillon.minfei@gmail.com>
> > >
> > > Add documentation for "ilitek,ili9341" panel.
> > >
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> will you take care to push the patches now you did the review?

Yes but uncertain about patch 2/3 which fixes a DTS file.

Normally that should go through the SoC tree. I'm fine with
applying 1 & 3 but don't want to cause excess errors in schema
validation so I'm a bit ambivalent.

I would prefer if patch 2 gets applied to the SoC tree and
propagate all the way to linux-next before applying patch 1 & 3
but I understand that will take some time.

Yours,
Linus Walleij
