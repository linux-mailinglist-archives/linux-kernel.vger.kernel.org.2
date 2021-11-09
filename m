Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10544A5DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 05:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242758AbhKIEoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 23:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbhKIEom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 23:44:42 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1831C061767
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 20:41:56 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bl27so28709866oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 20:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OSA7N9mCLquT1rd2wImQ3Ami6xqCzBhYDYxbfoazN4k=;
        b=Y9gyFDzcL9BP1DFZxJI+XpovLOx5lPURxi5EvHj8XntBd5CfTCfGFPnKETmHqHJvsE
         1qasAijOOo0MAzsLcdhx+uyaoSgidb9FHy8Hm+lhm9HGRqf+YySiPULFw60CfAhXamc8
         /Qm7bZSGVcSMuxp+eVRoa1g1Eb3JCuus4RNx9FHetRRhXHiuG34spSb3D0P/aAElH/ZE
         OhwCpI9ss9uoDf3FH4LE+++3g4FeBJ5uul7TayckUQk9Hv2VONcyxUZqeSVhPVFfl4vu
         Q22MPO5PkKbFoSxuBE8VeagXLPknXtmLmnxju71dTgfbHFvu0GSIwUa2CWCElyOFhpZS
         W9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSA7N9mCLquT1rd2wImQ3Ami6xqCzBhYDYxbfoazN4k=;
        b=0YJrBq+X3TLAEeX+x3dvpKlBUW5gUpPpO8BLaD9/SNnbO6wtDYcQkwbXlnB0hDz6As
         0l16IzF+4rG0II1KJvv0eDRl559V+KO7dd+4KG2L4v8yThg/8M6gnReX2p+9r7acdmoY
         xG1wyk0+H5YPPYdt/UeirY1M3oMRZBZ5hTE4WiJtTc6ibzDeicPuCLlgLmsi9YJZcW05
         0YXgItqjDJCZLP+mlUjA/wWRe//4/4EO+21QR5KxIKCETR4Orng1i9yePYhpNorXdJSq
         m/IbsGIqh8EFxIlHMjQ6OpTQ1zlh0I8QGIdlZSVthujqfpL1dHfOgebVAr3FcLJ8KFZC
         EGFg==
X-Gm-Message-State: AOAM530SBVuVa6BV/zTBtJDN8M1ZkCQ4oXqLCXhpRk5i7dwVWSe6EzS0
        ri3M5JUSzWP3RJrwUiz79jlNbOwzvzas/CUbsJuoKQ==
X-Google-Smtp-Source: ABdhPJzvkyEHDjEXckfkD+M8/nBngNkvmoi95rRujcZk7+h5VicjnIaF5ti9YLbEY8bDbU7657FdlwK3LXVVQP4CYt0=
X-Received: by 2002:aca:120f:: with SMTP id 15mr3116254ois.132.1636432916285;
 Mon, 08 Nov 2021 20:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20211027181350.91630-1-nikita@trvn.ru> <20211027181350.91630-5-nikita@trvn.ru>
In-Reply-To: <20211027181350.91630-5-nikita@trvn.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 05:41:44 +0100
Message-ID: <CACRpkdZOPz1uCCnLMKJmivVFXW4YLbFF0PXe=LhyCTtXGtf9hQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] input: touchscreen: zinitix: Add compatible for bt532
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        Michael.Srba@seznam.cz, broonie@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 8:15 PM Nikita Travkin <nikita@trvn.ru> wrote:

> Zinitix BT532 is another touch controller that seem to implement the
> same interface as an already supported BT541. Add it to the driver.
>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
