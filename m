Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349AC42419A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhJFPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhJFPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:46:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47EEC061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:44:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b20so12563637lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLrVITo26Q9Q7weH2zRlnHSrkqoVRNsgF3IljUMw/5c=;
        b=Vg8DOLDKNftBf2yy9dK6Xu1rxd/66jDMb60w1wudX13vfZa0M/6yuZ2L3Ygm2csCZ3
         jLcbL9E56EllkroBLM9jukgbbcSyD1QMRyBjepsQeTuJLlPrYsriP7jtOFmPy0sZmnJS
         7eWPrpin7ou2GbkMqFD0a4eoIoqGEczu4GoHJMi69TvCg9o3UqvP9klBSN/f7/JFChpI
         n3TyNm3ZH5czD+YCJExOTWay2kXUR2LaX6C4IijpAUGGMd4OJpGUFSAM/CA8LvYuL6kp
         /2X1gfVLCMCX6sI6icXWPlpWYyO737tRElmxRwaVexZ9D8+1CvERswsdnwx4UsrB6XK6
         j4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLrVITo26Q9Q7weH2zRlnHSrkqoVRNsgF3IljUMw/5c=;
        b=4qVrJURyR38u3NefAKERkLSR8ypTqsDHj14+qnMYHGq8kgfA9zupGNosu85zJs3Olb
         59mvAVrh3fFbWumOWr/C1FuWUhAjjM8/PGB1kl9BwHfoyU6ZordioDn+KkboKUxA1kTY
         HwZkcMJF68bDP5qgfdUDeVTNtSnxb9gBhkoxIafXl6qxcFVMSKTsXElTyMqBvfwE9MeC
         g7eR0CDzXyadRGMraVKTpN79KwoQ13yOWDGAqO+Vf1sv8TxeEswh/snWbirCWs/shPk3
         5nms40BQwm3JGfmQ7XTOpJNm9mVKFf8zakYK5y4/OpUMybJ8D4mYGxMXzK0tYiNitPzc
         TAOg==
X-Gm-Message-State: AOAM531FoAfYg0dLsElJ3y/UUAiDwdC1Rdcarnuy7AFPHmHLQ1S3iFoT
        nz0Bqoc2FjNyS2kW9DvHIcosiJf6KzJiO0W1tgtSYQ==
X-Google-Smtp-Source: ABdhPJzIWAUgQf7sZffi7dUYnaY6L0kMYXgI0e/0GVYqQBe6gtEhMBe5NQ6q+RSowbWaMfSxH4GzmhM9Xk70+dvXHcg=
X-Received: by 2002:a05:651c:4c9:: with SMTP id e9mr29848643lji.229.1633535089235;
 Wed, 06 Oct 2021 08:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211004151646.73599-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211004151646.73599-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Oct 2021 17:44:12 +0200
Message-ID: <CAPDyKFoACP79Zt4DuJJEyRPRb0yXhcNmfDJwVk-yBZt61Z88MA@mail.gmail.com>
Subject: Re: [PATCH next] dt-bindings: mmc: arasan,sdci: bring back
 requirement of clock-output-names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2021 at 17:17, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The schema defines dependency only of clock-output-names on #clock-cells.
> The dependency in opposite direction - requirement of clock-output-names
> if #clock-cells is defined - should be explicitly included in the
> bindings.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: 22ea8ab0dcc4 ("dt-bindings: mmc: arasan,sdci: drop unneeded clock-cells dependency")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>

Applied for next, thanks!

I took the liberty to squash this into the previous commit, and move
the reported-by tag into a reviewed-by tag from Rob.

Feel free to yell at me if there is something you don't like with the
squashed commit.

Kind regards
Uffe


> ---
>
> Fixes tag from the linux-next
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index dd70431df0b7..de6f076e0ece 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -158,6 +158,9 @@ properties:
>      description:
>        The MIO bank number in which the command and data lines are configured.
>
> +dependencies:
> +  '#clock-cells': [ clock-output-names ]
> +
>  required:
>    - compatible
>    - reg
> --
> 2.30.2
>
