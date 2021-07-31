Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5D3DC842
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 23:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhGaVX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 17:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhGaVX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 17:23:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D84C061798
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:23:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y34so25729230lfa.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFuagbB68OTvddF9Xywx7UrDN/I21A6uFb3ydrSsaG8=;
        b=CRqwWc7QBYs7ycsAgYE5p59uP5JVARslAuqr+wmJA6jVq8VD76RE/xwkyEuczrL7y/
         qYSvp1fOFmy8Nx+lYlnUKnZLLwK9WdJ77KXwxtjV8b4TLO7LGkEQ3cqidhda96VJomgh
         P9ON+IGk+7tfgw/4t6+joWkbp0yXfGa7NORIxMegHLyEXWrHxTFf5nXnA9PVZ6LVKcC0
         tkpjQqi+m/+t5CygOoFF9YlqixGOBWaQemI5sZnwY8qSHelPfj5HAOcx+nYtkJxVp++Z
         2/Z+et95YgDXFLfI+9N5Yc57rewWnvBMlJCJSvT9uKuW7RF7Z53fakh72OQsEsypGe8M
         jOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFuagbB68OTvddF9Xywx7UrDN/I21A6uFb3ydrSsaG8=;
        b=bhcN0K76zZX1CVLD6ECF+tH1YSLn2nxtN+uW8ma2yXvQdu/Wk4QfI5DrwReYfZpTF/
         KxzsPRWwje6rd3twH/bG5W1vzdqy1MAaMXea37FNrN61FJ6+5AY1JDE+5ANI4wKybRuT
         JDpGe+J0hGuAkGdZoEngG1aWW6SsC4weoHmrQLLYuuv4ZJBZJvPBrKsVwd8SlvbNg0MV
         fdO05drdMLYNoIVc2lGKqUDyWKhfVf5qdt/+7exBMfA/g3R3k1g5bWxnlxnLhX39J+aU
         ysdS2HV3U2yBRkyJNMN42IBC01j9fAHLYOVvvd1QPY+pgOXmO+3tTDkBuBvcVf4uDQUp
         Th+w==
X-Gm-Message-State: AOAM531O8gbgLzPKY0Ncb0ew3Senq2JUa7eY8C/ZRK1S5ftofICmy8iu
        lLcItwICCde13UyapjPQ27TcGE6DyP/bgTpdvoW3gA==
X-Google-Smtp-Source: ABdhPJx7Q9x1W9R0NDVhm+5e93isK61FmR6LCKivpcqNcKWU0TYWxJ+S9YQgwYa7UlNcmN4iPwiV5tUP5zTz9VvOfOc=
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr5925413lff.465.1627766628769;
 Sat, 31 Jul 2021 14:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210723192352.546902-1-iskren.chernev@gmail.com>
In-Reply-To: <20210723192352.546902-1-iskren.chernev@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 31 Jul 2021 23:23:37 +0200
Message-ID: <CACRpkdYVX+AZWto15Buq023cPSodQuyYXr8Fq64-RP8SQ2b0bg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add Pinctrl for SM4250/6115
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 9:24 PM Iskren Chernev <iskren.chernev@gmail.com> wrote:

> This patch adds support for the TLMM block on QCom SM4250 and SM6115, codename
> bengal. The code is taken from OnePlus repo [1]. The two platforms are
> identical so there is only one compat string.
>
> [1]: https://github.com/OnePlusOSS/android_kernel_oneplus_sm4250

Patches applied!

Yours,
Linus Walleij
