Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9012741A31D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbhI0WfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbhI0WfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:35:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC77C061765
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:33:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b15so82827737lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zM4fBOa/Cc+NJs4yahzMxnuSKuzGDGiVwQrXYFaw3GU=;
        b=ICqqWiLqBDT0t9jn6SdzLmBUmYs8DPRMcEdkG/ON8LnfK+o2owAjxRZT39rfh4QrLn
         p22YxgnEJr3UTYZjIE2c4ZOCvY09SBymnqCl6tPrRSPnZbYlV6juugSp0gNhHH6URqyL
         mbHSiB74bJwO4un0kQa2UBlAo6OMSw5/ngEY5oIMd5yn504Kut5DolDmWvlYd3Kx9rZk
         Uq7xSNHzr/9qLjG/aYPN6a57oIh/mWVxMqOo0x4qamWtNyEP6MSPvLZ3D7roH2Ns6x8M
         u4FB/+gGQ9WtalJv/uQK8Po9mlTNNOT+9BBzObVeGwvqef+kMMCxbGe/I+NvUU1JWk/3
         31Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zM4fBOa/Cc+NJs4yahzMxnuSKuzGDGiVwQrXYFaw3GU=;
        b=iT57u3WHzWD2sv+oj8d4AwDm0LY25Mm1JE0xoeMzjd9dS3q2qGsBp3CNvPDmHXgMda
         Yq2/BjzoUQ2x/8RYYfV3hCa+3mkXLNrgzJ3GKoiEfrrhGi/N7GXsLMP3IfU0FqthvlQO
         f2DIJqKu+mFGO9D3VBwqLRqMryQbvmwuhABb3aSThpD4Tcd2GLO3t5poL5fLjKZBuc4t
         vXUBs8a1G7fFU0PIE/Q/qU+idgsu1KY2jKe0cc0rF86th5GpI0nsfjOfxBgX0uuUPMUx
         QcdS3E5b7AtkW7VtBku38I5KQbLpLCL4bnyHQnqbDivWRQ5rRMnBTCq5YAWTycjXN9VK
         WZxQ==
X-Gm-Message-State: AOAM531S8+h4eRbKb840TZMscoRP/ckZXyKYlOJZVAHQXluEjsTbgsSF
        KJxUUDR1JY3II129InqlpcE2cY/Miw97KfzuYKFEpA==
X-Google-Smtp-Source: ABdhPJyCkbS2MXhhj2GEIsJRQHChM3/s/YxU0WZXM/5MxIvupi0dl1BoN6G6RUeYG8MNAmtmUhre/M6FEpZgurOihS4=
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr2166459lfv.358.1632782000629;
 Mon, 27 Sep 2021 15:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:32:44 +0200
Message-ID: <CAPDyKFpnd0TWxvdbivkNUN9YrPyWWdiQkLLp94MNWh8pXXqxdA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: mmc: cdns: document Microchip MPFS
 MMC/SDHCI controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 14:50, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The Microchip PolarFire SoC FPGA DTSI uses Cadence SD/SDIO/eMMC Host
> Controller without any additional vendor compatible:
>
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible:0: 'cdns,sd4hc' is not one of ['socionext,uniphier-sd4hc']
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible: ['cdns,sd4hc'] is too short
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes since v3:
> 1. Adjust commit msg.
> 2. Add tags.
>
> Changes since v2:
> 1. Document vendor compatible instead of dropping it.
> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index af7442f73881..4207fed62dfe 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
>
> --
> 2.30.2
>
