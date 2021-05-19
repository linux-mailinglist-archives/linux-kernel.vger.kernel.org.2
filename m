Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8735389A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhESXp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhESXp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:45:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4609DC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:44:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w33so13707548lfu.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wM5mCzM82gGvfQBTJBh8mxI48tmx7HiqO3orq8kFG8M=;
        b=LXr5MO+utZ/NzeTIfmH9hyM1jISMq06v3IDaujQpMqszcM0701ZSs8bHFywI/8QidO
         v1xGKx8SJoezcA76OFolfG4S4Jn+VjCZhpiROe9tgvN52DLstdRQGTVxhkHzM8o3ou8x
         WVfJrMKMlyMrY/vdNVY4I7bZ44wChX0YqYbOH2hJ7pVkR/6QH+i1HqYwnyqDYyJlBeEr
         CSKtcqKxo/Orhd8WmGlUnikhiFWAtB3I8/hpMb+S37xlmXZ9ljSAQhxzhaV00xkWZT32
         TVOtZ2o/F3h6urKDDm5iTanJJSULolcBG+WiTgxH+jSW5a9vINs86YRi8dcJ16eAG2sY
         bGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wM5mCzM82gGvfQBTJBh8mxI48tmx7HiqO3orq8kFG8M=;
        b=lZOqpnHP+If6Bti+blu6pytnlP7jZinrxPRV4D1e/BCErIGH/OFqFM6ObVNA1AD82y
         0pSzvA5qe3aNBYydKY7+kCQQxtm4DWLNP+fYEYWTRJ9A83BUfiV3lrPx0t71PX6NZ80F
         8WvvQGE+Ryeud094CEctyXJmq3e8DEozWHmQWGpthlOlb9TSY6Va1pHsXNBmOU2bq9Ej
         iGCKUtbmsZJPS8WuShwZ4iebaFQ+9GGMiqJ3xkDbzXhh77o15ox/c9BrItaz8SZIrFfp
         A0uD7njTZSUkPI/OM038jabzYLKL70Ys6Hdp5Sej7e8F/+rKdrxn0nQhh+8vNpLzInu6
         FUsw==
X-Gm-Message-State: AOAM533sH1O0U9XggRNWhbv7Rp5OGNSXwOZTpLrlSFMo7vdrdfq+qT21
        vMKsWMVzeTeqh64r3g+YZvNvk25O8L/1VRngJ9LT5Q==
X-Google-Smtp-Source: ABdhPJyo49ywD7L+dYbgOEUpr1fsXLuMJaPoe5Fi+hfuegcGmM5nkNGHmm41Em3f/9YVuOYk2ii36sKpxCMY+Gm9nNM=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr1339795lfn.465.1621467874570;
 Wed, 19 May 2021 16:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <1620817988-18809-1-git-send-email-skakit@codeaurora.org>
In-Reply-To: <1620817988-18809-1-git-send-email-skakit@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 01:44:23 +0200
Message-ID: <CACRpkdYB9QSsj-23EPyX2+T=GLxjMPN8dcRopErSaA0gmuZE4g@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] Add GPIO support for PM7325
To:     satya priya <skakit@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 1:13 PM satya priya <skakit@codeaurora.org> wrote:

> satya priya (3):
>   pinctrl: qcom: spmi-gpio: Add support for pm7325
>   dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7325 support

These two patches applied!

>   dt-bindings: pinctrl: qcom-pmic-gpio: Convert qcom pmic gpio bindings
>     to YAML

Now you only need to iterate this patch.

Yours,
Linus Walleij
