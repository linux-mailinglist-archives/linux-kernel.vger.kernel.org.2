Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1C388254
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352577AbhERVqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbhERVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:46:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB53C061760
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:44:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r5so16005511lfr.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDa4WHcFdueIrXi1rhrqppN7ZdRyzonqmDM/tclsxk8=;
        b=Lozegdgl3LLaiS0DXMtRyh+aYAHSn61Q/FZlftfF4LWfmAT2SnDWl/kDnCvxJ0+HCg
         C/UczA06CvIaQwdsRrA0MRbAP18/vKmY3tp8abR4BWTx9vExf4998RxT+wY4EjVlgIA3
         P9dMcEWNlvtU8tJps7PF1fbPzPLKjRrQZRlLFdFw6rcl1zMBoUuEMfuET28VQgrrUP5a
         zwmFBQhStoj5cxp+N77Qu61+4FJNBwaqNjqQzeHhjNFz4RjCmNxRDaZv4ycSqK8WFUq3
         oCwDwaGi5gelGVkpHyD7wSJJNXcQbKeOxVM/azsA+biQ6dJ+wa7qS1e7YAxhFKyjyM/X
         1QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDa4WHcFdueIrXi1rhrqppN7ZdRyzonqmDM/tclsxk8=;
        b=oXboJOsk+ue7kHqJELBaPcIGokgBkG6pjHqyTkxih7f1V2pQxOkDYSkdM786Wq8qqI
         MTHWbw+C30lf8lqL3vFHGFBHvpoB/T4BVuIbyvaAvZ5+L+6qazEPGgX6HojceKiSaOiK
         UIOTdy7d9CtTtVQCk6C3oRxeFHHLIRXxNTM7+QeEYxOatprH6B2iP6ZeRPv6GHQTW5Em
         cgWt6CjfKONz+HvnhCp1ZMGBwrMhHl83ocSxRgxZnULbV0A3LyjvCqeat0A2XDT6YOoS
         eEnZcfCVsJQQI2lA+wMo5lKNUkJT+Z8cpQFcBF5wCL6TTPsTkACnPGn1dADfCIrujMgr
         Rimg==
X-Gm-Message-State: AOAM530CSRwzZ42LFrisp9+Qthqff0rJZnjLeKkFeKGGr6WBjwx0QTM6
        1JmkjVMeo9qarPWv0G/3zt2FQfUKBBkWxhubKcKJbA==
X-Google-Smtp-Source: ABdhPJyv4BLDM+5oyevoFet2Ve5mvZ0YIVLNRIwIVT5044vGftDZlD8yee6eNLuaQFvmk1PTZxkoGk+fLfCys6C7K6o=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr5678712lfq.29.1621374288547;
 Tue, 18 May 2021 14:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210518151655.125153-1-clabbe@baylibre.com> <20210518151655.125153-5-clabbe@baylibre.com>
In-Reply-To: <20210518151655.125153-5-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 May 2021 23:44:37 +0200
Message-ID: <CACRpkdaP5eGe+afaDd29hYy=_drH-245OTcdUFgq0Sz8nZxajw@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: gemini_config: enable sl3516-ce crypto
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 5:17 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Enable the crypto offloader by default.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

I'll apply this once the driver is applied to the crypto tree, I need to
update the defconfig for gemini in some other regards as well.

Thanks!
Linus Walleij
