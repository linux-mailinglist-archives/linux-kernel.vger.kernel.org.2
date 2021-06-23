Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D463B1215
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 05:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhFWDTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 23:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFWDTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 23:19:11 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F92AC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 20:16:53 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id s19so1233898ilj.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 20:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gwyk7uli6oIz3rIWuS93ZiR/95eoNtAhejgjw8V2c7g=;
        b=avVKkKEQPXbX8szL6W+xHS+ytLCq2BWNqxMK9GEjcewzrreXGygKiJm008njmzuq65
         +SWBWp0oNN2jRB6aWjUJqcfuDXId0DEEV3xib0KEeE062n2iE3HNC+mFky2wDt54VNFL
         7rAnRH+0GILJJWCzxRk+sa6IYtUe3G8/ZGBZSXTUhUnRwuUjKVyQXyK13Te4BysOSy2Y
         B/HOnLH1aitT9UMUwhF2OPwwdIHrQFvesSrnHPz3noinYhvvJfqINRTYbq9l0X8COuSl
         549txwfUsNnTU8ZusF2GaQnQjAsgVwYxLt/h9mbhikUtKQjYpOc1TewyHWX7HmaYoVCR
         SLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gwyk7uli6oIz3rIWuS93ZiR/95eoNtAhejgjw8V2c7g=;
        b=M6xfaYGK6+P6OQIP9vMbemRyrTeKQnVz2/7UsnbUAgQ5dO8khmg8fhFE8vlbq/Ap3W
         kvFI0cON8ST8+WWvYu4/Jurp6Rdhzm4LeAi0kL6mxw/8yWhGqv3ZzrQoLn32/EkO08by
         JcQkWGUwchepUm6L9Dy/sGD9yu1rlkYd5a+2G6mUJKYmqhbup49xA9WmAPgA7ZRh6gnj
         baUS4pRfv+qYZcBm5fY3W83s40uNNh5DQLKUK0dY1sy5cwWb5ANR7s5V1NVVjf7te4J8
         gZB2C3RAmWYw+z4emrPqkQ35ES+RB79/OgQQSgfzhmbggQ+G+8NziUOUdipVPX+gS54X
         wtZw==
X-Gm-Message-State: AOAM530Asm/CDneZp5o8mHWfSdRWGXBADUgc3XBwMpCms+nTYEbXGZLL
        gC4qjSA2sUHp0WvkBsBs6iyWyoZQbZR9GKT9iqHGUg==
X-Google-Smtp-Source: ABdhPJwDUOZOr0sb7xGTIyDuC/tlmAEbEEUDUVcs8ySJRF91dcjveUjtvj2sMOPkvNe7zxFjvxgPTdywtnclmsqcv1Q=
X-Received: by 2002:a05:6e02:1be1:: with SMTP id y1mr1377528ilv.204.1624418212873;
 Tue, 22 Jun 2021 20:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210622151734.29429-1-Christine.Zhu@mediatek.com>
In-Reply-To: <20210622151734.29429-1-Christine.Zhu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 23 Jun 2021 11:16:42 +0800
Message-ID: <CA+Px+wV7fZ_8-GfdjshKcBV+VaiFNxTq4dcKUK8EoHxzyuZVww@mail.gmail.com>
Subject: Re: [v2,0/3] watchdog: mt8195: add wdt support
To:     Christine Zhu <christine.zhu@mediatek.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        matthias.bgg@gmail.com, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        seiya.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 11:18 PM Christine Zhu
<Christine.Zhu@mediatek.com> wrote:
> christine.zhu (3):
>   dt-binding: mediatek: mt8195: update mtk-wdt document
>   dt-binding: reset: mt8195: add toprgu reset-controller head file
See [1] as a reference, "dt-bindings" is preferred.

>   watchdog: mediatek: mt8195: add wdt support
If the commit messages in the 3 patches are sentences, they should end
with a period (i.e. ".").

[1]: https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html
