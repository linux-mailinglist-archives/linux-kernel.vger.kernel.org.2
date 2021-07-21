Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE73D11D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhGUOXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239457AbhGUOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:20:08 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C51C061575;
        Wed, 21 Jul 2021 08:00:43 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id w22so2685487ioc.6;
        Wed, 21 Jul 2021 08:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iknMDrhct0ZkRYz3sqrxjrU836dktL9pH5wh23AxUt4=;
        b=TsfXQ3/0ZMrx26poBBp3lYWPWdgkda1Yy/2M9fGsTyD6nz2gXnkV/0rlkMZkdh3VuO
         lxWucouuXWidWOx80Rt/5GLLUwaRwHNMZBXzpzK2ykJQQm5sDNO7yKD7LBr16eERrIw8
         0hXLp8/G6t1F4jksSPenOU86bK411zWs/siZ/GQfMnARygpvoAXOXUdj8+u6HPtNpnu8
         w/VoNZi4Fgbm4df0H0DuMHSRQt7tHqiR2mI17s1tTjQiazoIs/qa0+bmfomBKJRbJjPv
         Ir4w10M3wILiDK26fTI6QXCfT/U1FALXNTkhDMgE5QAoFAuD2r78gIdZqUOACcypH17z
         29og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iknMDrhct0ZkRYz3sqrxjrU836dktL9pH5wh23AxUt4=;
        b=M2ziBkBDOv8sDbaruiTmtthnM/8yqI7RHK9ruNs72b/ferZPWC3xJ4iiQCuyVndQWG
         BYDxSf652mRbZcKtdT79WxbmnIm/JB6zqmrR3kc9f7o/4uON5bVtk1PPmoczXoVXrYgB
         8ZT5OeVx6M5WtZzJxhvZSicQIX6EEG5ryS5PGr+kFoMCTJwPYz2odsEXXAeZOriOg+KM
         bWN9BwSKY89f+WGuzJ3nRCvNvcb5QtMF2ZfyfkJ8FZJZejEFp1ZDKp3gcNQ8MGg/MieB
         7mR+72aAhvmcEFb4W1shF5IMQ43kCTjllMO9olmMAjvDiaPAQPnPZRmarikwBXmsk5UB
         MuKA==
X-Gm-Message-State: AOAM532yFxFjutV//hAGiph+G+LsnNZK7WtCRWFdSkARZrIwdFypAE3o
        BJQifg27Y781r8l7nT9EBHVflPdnlaRMd4Sp8i4=
X-Google-Smtp-Source: ABdhPJxkQLhypIjPoF3QHU2C29uQ6Xc/RLwToaslriF9WqJvR6ei9u4Cqs8YpRADZn5nCrA45yTZ6KJyTXddAZYaiEs=
X-Received: by 2002:a05:6638:33a6:: with SMTP id h38mr31612757jav.130.1626879642718;
 Wed, 21 Jul 2021 08:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <1626853288-31223-1-git-send-email-dillon.minfei@gmail.com>
 <1626853288-31223-4-git-send-email-dillon.minfei@gmail.com> <CACRpkdbkbbuHk2U8auXqzZbSs6eKnj2+0BySivHcuEvsY31kWg@mail.gmail.com>
In-Reply-To: <CACRpkdbkbbuHk2U8auXqzZbSs6eKnj2+0BySivHcuEvsY31kWg@mail.gmail.com>
From:   Dillon Min <dillon.minfei@gmail.com>
Date:   Wed, 21 Jul 2021 23:00:06 +0800
Message-ID: <CAL9mu0KnzLk+jmUFFJvgZCvM=jwg1c_T6OpsC1Hb_u5Otkw-ZA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: Add ilitek ili9341 panel driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
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

On Wed, 21 Jul 2021 at 22:02, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jul 21, 2021 at 9:41 AM <dillon.minfei@gmail.com> wrote:
>
> > From: Dillon Min <dillon.minfei@gmail.com>
> >
> > This driver combine tiny/ili9341.c mipi_dbi_interface driver
> > with mipi_dpi_interface driver, can support ili9341 with serial
> > mode or parallel rgb interface mode by register configuration.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> > ---
> > changes in v2:
> > - replace vcc regulator to three bulk regulators(vci, vddi, vddi-led)
> >   according to linus suggestion, thanks.
>
> This is a really nice driver.

Thanks, all the code here is inspired by your recent patches.
Really appreciate your time to help me.

Thanks & Regards
Dillon

>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
