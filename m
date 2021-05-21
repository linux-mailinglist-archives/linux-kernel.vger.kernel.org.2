Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23EE38D226
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 01:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhEUX45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 19:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhEUX4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 19:56:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC83C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:55:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j10so32036170lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 16:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4JwRZa9StUOWu+uyIm0h+xDZPb2Vrykvc6o8gtd0B4=;
        b=rHb3lfBJCE9Mx9n/BYp/yEvxrIMlWaV76KfBsLya5hGpYMabhQMZjasOO8SBTpTWbB
         37GqY4Is7No6tTOFPfP1lGdL0I59ID7eYDDyLdxdxFAQyOJ4glisq8UR+7usNrLwFRZk
         doPUwXGMspXb1+iofsgvrbbPaHND9OZqFq+R3sIynxXjQecSXX1Y+DFRE5qv07/PUpck
         86hCcuNrTcc2d1hiUPF2Nkv4TcwhmE+ZOi6oJjf/5lapvPTDA4xq05aMe7RGEC3PmsgG
         uiLEqDZmRCdu2UJ/sc7jjCnr63b2LUapGlRqh/qrg4mPNJOacp+WR0xNbhYX964Yjk0b
         /gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4JwRZa9StUOWu+uyIm0h+xDZPb2Vrykvc6o8gtd0B4=;
        b=RZIkOAuYICcPiYmu5TjxEKiK0C1gWeMiH36N9rZL67X+gF7u5+pNtuoz3QOD5ttm52
         mwCuRa/E66gGAzEhC2YjZspBK4JotC4y6vrFtmtRSaj8lJSmlWG7DzFZVsG70LX9xiJA
         1I+lQ9IfvWyRnFIUDtDz5b7zRbThrrYAE1OK4rB0DSg8qQOZqt+GJ/ptkH+59EH1v1zN
         XxYVyptIxn6DJ8ooqOO3fPGGVs+phDWNeue2TADqi9qGIOV8AXL1wj78PNZ+Dy+D7Ovh
         YaKjoiYphTZgqYbQVUYdr0wsiCjcY8gzqAJ2gXWPBPljFj0tjP7YL4OBJ6MqOT1+rrBC
         0anA==
X-Gm-Message-State: AOAM533s4HcCQlEF3h4Hxw2KI2/I9M1CmDLL+CPmNg8fovo88qub5xUR
        vcGmR3xk/3HV8vdUOdoN55krW8EjmRGhDBw1EufiSA==
X-Google-Smtp-Source: ABdhPJzBChhkZ2/JZvtrSi2TQkgxeb22PAkXYeeuXJXqQtZsukhS8dZ2Ju4vf2tQzzIuCuUgHNvltdsgfT9slARBr7I=
X-Received: by 2002:a05:6512:1185:: with SMTP id g5mr3779084lfr.586.1621641326966;
 Fri, 21 May 2021 16:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210519203547.837237-1-clabbe@baylibre.com> <20210519203547.837237-2-clabbe@baylibre.com>
In-Reply-To: <20210519203547.837237-2-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 May 2021 01:55:16 +0200
Message-ID: <CACRpkdYACsLcJMD96vxrmOrJFjb675y5t3SXQF6YEOyfeoGekA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: gemini-dlink-dir-685: Remove address
 from display port
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:35 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> The address and reg adds no value to the port node, remove them.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Patch applied to the Gemini tree.

Yours,
Linus Walleij
