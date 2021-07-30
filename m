Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441FA3DB688
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbhG3J6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbhG3J6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:58:22 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E197AC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:58:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u3so16755343lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyrbkmHOA0DIVtaygrrXFXeSWnHWmi9ZxmLgrolpzQU=;
        b=Cao3LkkbkgZIVVzitNJjFZvjA5O2oYwvjcnjOQgcqVmkzMtf6i/GhZNE09z14UUt3t
         DpsNxx7JVqaz4Rrnqkhqbqz/xr5WjTPEqAbLBa4pER6jv2+w/S4V6ri2gtuhUZBpEOos
         hDjNC+BA+83Vffw5itToU0Wnr/WqsKcwi8peBWY5zPupKm7/7z62Nuw0skYjDWdmYDU1
         dB9BVaDQsLlnmKsvPTFVzzLqVvhaR34KiBYFiYCuO7204mAYpYF7u9qeDGwdZUNYF9Zs
         kERbVRfJOQ07AxXRZ8Uc+SlDCoSGek5oAftn2pyfSIQ29E6lH/rb359nGkbL5zQQTQbZ
         uOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyrbkmHOA0DIVtaygrrXFXeSWnHWmi9ZxmLgrolpzQU=;
        b=ERxOdgKls/3WSRV8xlFxf1O1mXnsr4xp8k3gmZ9fYALURTuVUUlNVd/b25y5NhDgA6
         TvRAKai7P0zEOFaq2a3Ulv/MgcxNX0i8at3JjpNXOYxvO8ONV6mhV+Vk8K2709ShT36M
         AwjR30Vcd3/AnooDZQxFV3ErkOi1IFOQRt3stjvQ/233FfoiQz/EyYyb6Qyj2/a6FpJw
         Y9tn/EP0cYydZLdgDqSQGuSduFg3qpzgu2k7Vdl5wZor/DrysEVCABZy3TreQWdZ2oUH
         +Tydk2xEerdUf/iUT02cJRB82obLemBr/A04/xr0nl8NB4A5lCiiIvh3ywsRdOR9i57D
         L5hA==
X-Gm-Message-State: AOAM533uahDGTZdUaYK4OpidqBzMAWazJhzAEA4eXqC+L+/SYopQoTsz
        8Uh+I+SpcXRPR4uB+4IRwV1QaRDWbBDyB22I+jgJzA==
X-Google-Smtp-Source: ABdhPJwdzJR0AVnEwRE8QIJSIeBOPQQpqcJoSOXQyWmGuQLYn1tiSkNoxa89W+BStyntqZDWqamudEvQCXJV+or9OPg=
X-Received: by 2002:a05:6512:3696:: with SMTP id d22mr1335599lfs.586.1627639095287;
 Fri, 30 Jul 2021 02:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <1627029074-23449-1-git-send-email-skakit@codeaurora.org>
In-Reply-To: <1627029074-23449-1-git-send-email-skakit@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 11:58:04 +0200
Message-ID: <CACRpkdYsDNDcCYWOygN+V=1LFBZ6-PHYaePy5truR9ybVzkMUg@mail.gmail.com>
Subject: Re: [PATCH V7 0/3] Convert qcom pmic gpio bindings to YAML
To:     satya priya <skakit@codeaurora.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

On Fri, Jul 23, 2021 at 10:32 AM satya priya <skakit@codeaurora.org> wrote:
>
> satya priya (3):
>   dt-bindings: mfd: pm8008: Add gpio-ranges and spmi-gpio compatible
>   dt-bindings: pinctrl: qcom-pmic-gpio: Convert qcom pmic gpio bindings
>     to YAML
>   dt-bindings: pinctrl: qcom-pmic-gpio: Remove the interrupts property
>
>  .../devicetree/bindings/mfd/qcom,pm8008.yaml       |  13 +-
>  .../devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 288 ---------------------
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml           | 239 +++++++++++++++++
>  3 files changed, 249 insertions(+), 291 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml

I tried to apply these patches to the pinctrl tree but there is a conflict
because I merged these patches (I think):
0ac2c2aebf82 dt-bindings: pinctrl: qcom,pmic-gpio: Add compatible for
SA8155p-adp
ffdf4cecac07 dt-bindings: pinctrl: qcom,pmic-gpio: Arrange compatibles
alphabetically

Can you please rebase the patches on top of this branch:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

then resend so I can apply them?

Include Bhupesh on Cc so we get confirmation that this ends up as intended.

Thanks,
Linus Walleij
