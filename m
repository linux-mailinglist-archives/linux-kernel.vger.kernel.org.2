Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6737525F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhEFKdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhEFKdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:33:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EE5C061763
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:32:13 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e12so6407013ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CO6hp7+jjo2iwhz+Us2x3qq2lqayYac9jn7GVF93Eck=;
        b=Z+WdpPau49MhZKAmAk25uSLdLiGwVy1svhI7afA3PnRv89a2AEjVovgOWVcbjwN0qs
         IiXBuqy787YTMXnI2OxbsMh/WgGk78teisS+phOimTwSWC2fLLicJ1vDbiq6zhC8aZTi
         fI7ydRXm8tafcwpBV5EkuIW1+lxr+81DKNi3utImROo8kWDivJRY3KSLKFTtDlGZTMDf
         2Fs7p3+XQurndEZqkM9DhEHBqTfbEntk18Fs4365MtrV9/h5kyA6RRu+65NJqGLX9WFb
         BqsW2ofsBcNI2yh3HQlFi7qHfGQPnnhL+xBGm6mbQzExtl1G13cxmzDfAwRdj88cQ3cS
         0+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CO6hp7+jjo2iwhz+Us2x3qq2lqayYac9jn7GVF93Eck=;
        b=RqU8LCQcKRVoOA5CTwGf28eP5RxqEgJM8bhmUFLVL2GO6a0sKzTE3UlDcvYoRIJkrR
         Y9Il5KSJTrvDQpgyn6Rxt6TyGiFfrogC0FZoIBvny1Ehfl1cQbnAvXQ8sI14FS/Q2gjn
         m9oxrL2Gr2u8dMH4T8VqTc1+1+0lgOSpLDXBvFSTaB+FHK4rN4rjLXJtnS8dD9PVkqKc
         jo88IHVOa3YoANorXAVoiQFO+yHHyZ3SBwcWPH98b/wSTt+eg0dYDQil+kyvaQVUeAUM
         dXeGCPkonyYdGtS5m1Iwqif70VlATIgH/L87xf2OhHIFUpCd8ptAxgfgR18XzS/rQxX6
         qJiA==
X-Gm-Message-State: AOAM531CERMooADAbWKel0cfeUxhoPhgbw/lHK2w+NbR2AHgLCLyMDcT
        qEe1mklllQEnnr+a5G0JzE93YRegEhxM0AdI6MNLQ6CeOkA=
X-Google-Smtp-Source: ABdhPJy629XqkraW6pK+wU+groCxJVkbvvEqgSn24Im7YzBJunJPs/1AUsNWtNhGA5pM58sSUnawA/uUHqauyvN65hk=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr2954883ljg.74.1620297131799;
 Thu, 06 May 2021 03:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210503185228.1518131-1-clabbe@baylibre.com>
In-Reply-To: <20210503185228.1518131-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 12:32:00 +0200
Message-ID: <CACRpkda4cMaDKU7ro4-q=-A3Y_AhiniV5=wK-3cnFynRxttavw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: convert faraday,ftpci100 to yaml
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 3, 2021 at 8:52 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Converts pci/faraday,ftpci100.txt to yaml.
> Some change are also made:
> - example has wrong interrupts place
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Looks correct to me!

> +#I/O space considerations:
> +
> +#The plain variant has 128MiB of non-prefetchable memory space, whereas the
> +#"dual" variant has 64MiB. Take this into account when describing the ranges.

(...)

I would just move this in under the top level description. YAML
has this funky syntax for pre-formatted text that you can use,
but I don't know it off the top of my head, Rob?

With that fix:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
