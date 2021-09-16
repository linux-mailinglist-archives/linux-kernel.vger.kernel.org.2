Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109BE40ED1D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbhIPWJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhIPWJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:09:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:07:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq5so24498232lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LX/6UT+dJXRQHVIf1nMEFEDSPJwBk5BvPEZvykJ4WCA=;
        b=tydJ+FLATXrTnw8dqjYnppGeXQ4oUSljbD9pKvbN3sINUGzSRKUuSD+sWemE7SM35X
         D5fAq+WVW0PYSfQT2mS8wHBED/+myA4CKhRXNiX1fP050wFJlgwpIXdXsxziTGmsfpkZ
         JDqe9/nH5OWfuVOItTTWOn0m9/gcTvElC1jWbJT0JP1GxHMGhXYsBR7AG+5baofjNq6B
         sJZBgk4RH+XKOWMJDVxdJJLO9rNINj2EJXS3Dbo/DpIpycj+02DwMg37GvrO5X00xjNl
         faJiDriA39b6fuJkYtCJQrpnaUn1PG/byQmQvvLKAX0OVDg1EkKixHCILbH9i4eLFZ3z
         aCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LX/6UT+dJXRQHVIf1nMEFEDSPJwBk5BvPEZvykJ4WCA=;
        b=l7szwv3aCze3jllbMJjmynUUTRIY8pW4UG89WvoqViOzOwLRkOHu3GobeBi5xNyB1E
         UsoAIj/NvYwrkPXpRS0mXR29tPML1iRdnKJNJfzdc3gZxPosDiegXjdKdtwMZUX0XIX7
         5kmA11C8u8Ibt1sl9uXa1Aggxg9IhQJzCyJ5UbFGcBcjUxAkxFZCoVfFYu4AiOYnhKbd
         UH/+OA1iEP+K1c2eLg9NmWRqOnsV5lQ9J4ClG/GKxGOvEpKwSZVcgscjT7m04Sd0PfiV
         2x0xRLhxyEhOBiRQGg2AjvrYDiioke4kzt+5/v8JPHSx12HUgFMd3lf9Dx/Yqko77idv
         1Tzg==
X-Gm-Message-State: AOAM533ukTHoJhJSV8388VfjLgZXvtMM0Rerd5dEbnqVKDWhelpiRSuP
        kDKIFx0wUDqRd9KwA6tu89W7Euu1kyFpc6kJCSoCPg==
X-Google-Smtp-Source: ABdhPJyjIV8xyB9mwbXecJOK4a0zQXVDG1YRjztqIzLaavdMteKIYK4Iu4wrIxTByxRDFe0OmnkhrtUkb+rfnewTdhw=
X-Received: by 2002:a2e:5758:: with SMTP id r24mr6787101ljd.432.1631830063490;
 Thu, 16 Sep 2021 15:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210825082251.2484-1-caihuoqing@baidu.com>
In-Reply-To: <20210825082251.2484-1-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 00:07:32 +0200
Message-ID: <CACRpkdYekS+2WKoyT5ssSp28XR4pxb+4yMZnP9PPRXpG+UE-LA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: freescale: Add helper dependency on COMPILE_TEST
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 10:23 AM Cai Huoqing <caihuoqing@baidu.com> wrote:

> it's helpful for complie test in other platform(e.g.X86)
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

It seems weird to only enable this on a few select subdrivers rather
than all of the Freescale drivers?

(Also: the Freescale maintainers are very silent, some feedback
would be helpful.)

Yours,
Linus Walleij
