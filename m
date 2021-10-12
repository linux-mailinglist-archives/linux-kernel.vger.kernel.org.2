Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7898042B094
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhJLXuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhJLXue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:50:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC644C061749
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:48:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z20so2425731edc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vc3CH5v4CBSXLkSVO9jLX0r7Nwhcrzxe9j4W7AySQ0A=;
        b=YiYwmX9uZwhLPGxi7YYAyH1b7YCNSdYLJBQQQo8XkaUlp5MBhCvNlkmvNNKwGAVb/h
         XLZ/+Bt5Y7JVQQG6o5ysOyO1NeB32cFZWCLGBzYvXDwmeCLZMH9TW2eHtHUN2esOJrBc
         1nJr05dIxcDvBSDU2wE4relg4p6aNfdPOQyL2G3b2l1HRHJXL29/LA6zeQreq3Yevwzn
         3vR9BCW23XkQZRExUHQsvigdweyc2Y2gXO032aEFxF2dXmT4lDEolY/k4LIFNU92ZCjo
         q43xIbAHyyosboB4j+OEMwt1RJjxoqn4dY9xb4SilxHsQz12Cz6WGSD+vUIsfwepnire
         DWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vc3CH5v4CBSXLkSVO9jLX0r7Nwhcrzxe9j4W7AySQ0A=;
        b=Ss9iQq/ydOzDjBgZqE4XYVqqtS/LcSQygcyofmV06seXmDzEs7odBlZMEhgAl/SrxV
         2g9ABWnM5tR8hoNnsfYeXeR44Z/6wven1/dJalJd5QEKV1Uz6qf3EnQFMqfQvkBWa0TN
         U/AILCGevn8a/JAJ6NC891jaYKmuSV9sgNzAmkeU4XN+LGCuQt6nPrKYJfs1Sys45jaI
         j4NX4VUztTI0Qtqd+l0xY72154LRy2GV64sdlhxiZj0/vXjdSjEtx6vhGtZwDxJUDtM1
         zzTtASfBJvvhiTBNL2SYU2/zEVrJl4HheVp0+EfELTHu5yxX36jNDBOBqGU5gPOnCm0g
         iMbQ==
X-Gm-Message-State: AOAM532sFSUuB40ROcLbzGUEpIraxbMgP2ySgJL91X5xvffYwa7jfmRH
        h68pSboSemH6P2TXRCJRVzX+rcpcCBtbU6aIwdTJmg==
X-Google-Smtp-Source: ABdhPJz5Gqo2ypBZPFh79sWzBRrMyiHHhGRW+TvFqxOmmo8tMMyafTzE6U4WIDqmviR4WoadTP4iD5T4YS9aBr8UrDQ=
X-Received: by 2002:a17:906:5e52:: with SMTP id b18mr23544441eju.560.1634082510434;
 Tue, 12 Oct 2021 16:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211007212444.328034-1-luca@z3ntu.xyz> <20211007212444.328034-5-luca@z3ntu.xyz>
In-Reply-To: <20211007212444.328034-5-luca@z3ntu.xyz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Oct 2021 01:48:19 +0200
Message-ID: <CACRpkdYPh-fHi-MkZRn4jq4J9oaAiHDSe-0vTokJZCfv4osnLA@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] dt-bindings: pinctrl: qcom,pmic-gpio: Add
 compatible for PM6350
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 11:25 PM Luca Weiss <luca@z3ntu.xyz> wrote:

> Add pmic-gpio compatible string for pm6350 pmic.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Patch applied as obviously uncontroversial.
No need to resend this one.

Yours,
Linus Walleij
