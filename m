Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B573B4B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFYXyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFYXyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:54:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:51:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j2so19053052lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNvprdUsOPKu5qiHa61DeIoD17To05xoRs5N6OXIiHw=;
        b=XeaoFTTfpfc5MQfQ9tPlOUzzSUJtMTvOoqj62LMJDjEL7/VRI3w++Bu61kIZ+lJmwK
         UBqrBXQBDO9a9UQxToHDHenU4FDFK5NPPnXdLACcQkj+paBUYM7EqXo94pR64SWRKi4H
         iRgrjhz7xDqfeP5xvZMwfieXdBj3Pte+F5RHNZLNoOoxT21uXqqFcCEppLHyQacQN4Fd
         9usgEMkXoVJeTkEprBTBsPcdBDYAD7MwMlHOIeWZPofesOjivGq79+zvVMO5WP6yGdXW
         IQDhY0WP5/EeE8LoM12IoMyK1hFW+6cNsDlcIRs2UxZdWbo3rU7cMcTOLFDnhLt1SP7+
         XZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNvprdUsOPKu5qiHa61DeIoD17To05xoRs5N6OXIiHw=;
        b=NMcJ0hXLWmGZ3ZpktJcXOEDsIMCDDDmrg7Lf0uGFbqbJlPM1/8CXVmtQ3yeoEMKkqr
         tXCGO5lpZ71YM4nCytYUCYzEqy3Nd2be1PMyHpKBUk0vdCvWF++nslGI/niXXfsrnWtq
         U21cH59efHmItaULx2F/u1n2vOvCfoDiLjkDJoqIUgQgKjU3r+XaznksWBnqqkyl3iPo
         vYYvGMW8gbMXOSHxbpxos4BBAlF75m4v6rXd3/+v8a+zw8/jPAiwlUiMEw2QyfMv2Da1
         xjgfpOaaSo/QMc6tBFmsz5mcgYq6GpjrgcHJ+R5SjU+WTAEg8K550YJVKUyZLV8aEBlU
         YdaA==
X-Gm-Message-State: AOAM531gt/D/eJRfPtRzpsa131YeQr8cFE3LfLyS9DDFan51P/HLq9PO
        M4BhMpDZu4LIjn+Yf5qShm9nfB3/I23C+zqMYylzEw==
X-Google-Smtp-Source: ABdhPJzriZY34bCDHuL4b89gYeFPZHgtn6NxEtvgC6rAg9/MEavzCB5MewSpa90qaJDoQfgbhqHfzSVctplxy1gj2kw=
X-Received: by 2002:a05:6512:1508:: with SMTP id bq8mr10130305lfb.529.1624665112943;
 Fri, 25 Jun 2021 16:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210617053432.350486-1-bhupesh.sharma@linaro.org> <20210617053432.350486-2-bhupesh.sharma@linaro.org>
In-Reply-To: <20210617053432.350486-2-bhupesh.sharma@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Jun 2021 01:51:42 +0200
Message-ID: <CACRpkdY9=Exgaqf4KdsfwH7gK=KGh0HVJSWD_FTqLtwd+pOBYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: pinctrl: qcom,pmic-gpio: Arrange
 compatibles alphabetically
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>, bhupesh.linux@gmail.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 7:34 AM Bhupesh Sharma
<bhupesh.sharma@linaro.org> wrote:

> Arrange the compatibles inside qcom-pmic gpio device tree
> bindings alphabetically.
>
> While at it, also make some minor cosmetic changes to allow
> future compatible addition to the bindings simpler.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

These patches do not apply on the current devel branch in the pin control
tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Please rebase and resend!

Yours,
Linus Walleij
