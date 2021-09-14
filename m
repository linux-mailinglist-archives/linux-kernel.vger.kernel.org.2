Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A240AC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhINLZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhINLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:25:56 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF379C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:24:38 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l18so23129854lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXbax/1bglMzgg6o47IyNakKQ88KE4K/hGwmlnc25Ko=;
        b=N4100R/sVYI9xB+3RNF629B4s5ko7wLFiA6IUtn0oKfdFh4s/DVlj2FjWpH4EB0GWf
         nSMDgFuOB1FxKtOSkpd4KpnVn64T9GkSKp0EvH+DldoiZ0rVEhMOPAJHkgb89JuegEgT
         hVS0D/Osme/N8neVgiEaMNrlnQFqwSccnIyfqqQPfVokx/xmcLh3RCXL52xiIJzY6ZRq
         uMDG6zYAqhpcYdy+xr46dMDyzOciUPXIix6C8+tsMUz/w5rI2L27oVpcTqN6+X0BNIqO
         PTdm9tL+nnkFsidR6SB0wS361pbbavkKWyVqdsTpBqhCe/DQMVtEr1A3eR2VmWTrUc/4
         +zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXbax/1bglMzgg6o47IyNakKQ88KE4K/hGwmlnc25Ko=;
        b=5UmGEpamRiGWhiT4zUDpgdU7xz9wUhEzSRi6NWElV9whj2C8lVe9FY4stE8K+UpZl3
         WlBRFvLT7tO/v6LQlaZLOKYiFSBaZ862bToJG37GFMOzGwORwUliL0zQzlDvn7Z6RESw
         3CP2XTGCvzBFMZsw+qKbnG9xGuKfy7BXXbcCSUzljRNnPJDFJzZVJGRNCyCO2ms17wQk
         RvTjp5Oz0Omma0bn6udJxHTikU4Utxfl3S0bnYeHFW4yN1oHnuEd8WeA6Ic1N+QFe957
         ppI4QMNKBj/altnageUQ1Phref96b/U7aLqUo0pZutmLeLwUBRsn6k2gF3rjXln2V18O
         XP4A==
X-Gm-Message-State: AOAM533Shr0fcqiMVmnr8hNMy+zLSgyDT23dbCL/TeWtCXPA+UBJaNBz
        Tbp3pHmTiFB8GW32yK2nzhK3BmK1k/POLu0wOOC9wQ==
X-Google-Smtp-Source: ABdhPJxNQjIx8LfDVzNm9Bxa8g8kduMXKBDzOD8rsarWhRJUMWWBpslN7FA28BAQA42mUmbJjsXpFhnu6cwrV9l1QHM=
X-Received: by 2002:a2e:9b0b:: with SMTP id u11mr14793392lji.463.1631618677115;
 Tue, 14 Sep 2021 04:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210911232707.259615-1-luca@z3ntu.xyz> <20210911232707.259615-3-luca@z3ntu.xyz>
In-Reply-To: <20210911232707.259615-3-luca@z3ntu.xyz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 13:24:00 +0200
Message-ID: <CAPDyKFr9k2dO8FJf4=ZUKZ6=WpDS2mOJ+BZbtK1m_-OWx_ehmA@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: mmc: sdhci-msm: Add compatible string
 for msm8226
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, bartosz.dudziak@snejp.pl,
        Rob Herring <robh+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sept 2021 at 01:28, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Add msm8226 SoC specific compatible strings for qcom-sdhci controller.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 365c3fc122ea..50841e2843fc 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -13,6 +13,7 @@ Required properties:
>                 string is added to support this change - "qcom,sdhci-msm-v5".
>         full compatible strings with SoC and version:
>                 "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
> +               "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
> --
> 2.33.0
>
