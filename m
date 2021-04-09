Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEAB359756
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhDIINw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDIINv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:13:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEB9C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 01:13:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so2485844wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DnCibJ7jXF/NmEn+QdQ6xpNdxPjEP53xLfmAcIWLsE=;
        b=XY6duv67QcyAzpBJZrAT0PTK2f2SmqNQDBccPIsyYoBGN7SCb7B2oLG1OGFyRS0ME9
         cCyPNhh6cEokGPohy2fSCbqXlC6TRVshmNMx3lvwQ95r2Fz7WsVYreaRnqnb0/2u7xcd
         S1fXAFx77qhG2jgcJxZQDwNjJkxTtWvgrcTJ3j6fIHXiDQZi59mwX4fjLEstPXl/eRxa
         BtDQU2hiVika1Cdnc1o/y+e9h5lEBRBnS2ZUC7pUZHAoxjTNybvRvMgUkEXFPa1gOBB6
         4fn0DP3wNedUwjx317Ji42ZLYI4ykBb5/nF/oDKxhG4BthJSE8DR7YlvTlL1hy3nfjGk
         TX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DnCibJ7jXF/NmEn+QdQ6xpNdxPjEP53xLfmAcIWLsE=;
        b=nzJFo3pTgBL7MCm6hN8zYQVGAC3FPBrfL8FbpI+eBxCrSbbiLgBqoAo5mO/WjrQTuu
         8pmv/+etPSuPRpPlQVJgeLjmwIKdPNBP6p4ESYJgVxyON2bIaH3zeHMgjjnj1gvUzagP
         alxnRh1p/6L5GZYQ0Xj/gns5YsUP5RbTg/i2lX0sgNMEYehSE6+o7gpCVu+0glgDU36C
         7E4OLU25esMkOQ4RioZXMEymh7+tbiMdb775ER0nDCfCfT/kyWdj9FiRbyQiwfJ4HcJG
         pVzeDJTUU61V5PGMvkmAiFRS4GkL4ELm89RO+xP+mdx2OC8H7P4gvtQlIlcY3Pf9C9C1
         3Y5A==
X-Gm-Message-State: AOAM531qxrTOIXfW1WXfuOpLwu4pSaoEPr7aKMaEC0722ibqCu95fe+3
        yrwzltT9IF1WwDGaI7rZbuPrFawATzJx6KI8K/aWcQ==
X-Google-Smtp-Source: ABdhPJyDugk7+S1C/TussRC1Mhp2lpGfMHdDokyuY8GLs6M9zv3fcILHus+BpUyxAxo2Ydy064KEK2HauWmszijcV0o=
X-Received: by 2002:a1c:e912:: with SMTP id q18mr12679195wmc.59.1617956016200;
 Fri, 09 Apr 2021 01:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210322033846.39882-1-ran.wang_1@nxp.com> <AM6PR04MB54134144991AB746382FCC0BF1769@AM6PR04MB5413.eurprd04.prod.outlook.com>
 <CACRpkdbh_kn9SjjSqS32m5VNy5k=j6eLCVJDJxmiWVQnYC0ZJA@mail.gmail.com>
In-Reply-To: <CACRpkdbh_kn9SjjSqS32m5VNy5k=j6eLCVJDJxmiWVQnYC0ZJA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 9 Apr 2021 10:13:25 +0200
Message-ID: <CAMpxmJXqAZBXEsvGfonG8bbTnk+LW0-0kEhh8zLR_4QAY283fw@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: mpc8xxx: Add ACPI support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ran Wang <ran.wang_1@nxp.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Walle <michael@walle.cc>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 9:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Apr 6, 2021 at 3:49 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> > Could this version be accepted, or any comment/suggestion?
>
> Andy says yes, then it is a yes :)
> FWIW
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

Applied, thanks!

Bartosz
