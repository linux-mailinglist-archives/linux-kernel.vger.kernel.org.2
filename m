Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DB041D8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350438AbhI3L1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350428AbhI3L1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:27:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5EC061771
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:25:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m3so23607414lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQ6FUBIM9thJqbhUS63FKjztr/wXj8cgKR4tXqEtQ7s=;
        b=M8ozWpEVoGJuI2AqrfnJ8grrWDDy3hICF7yDn5elT2VNODPrJYZq/1dUel6ac/46xP
         zEa4ct8ihuroQLVWvo/qmmiMqiX2DggNre9oKvXc0vf24Ebz0M/HbGz3afSH4J1u6rq1
         LyhocEM49mPnbbAhmz7moVfZIjEkUNcoD8waWv58fPfoTi9DLf8ARV+yVPP84jkM673V
         a7SKJ6LbWZg+qLSc4LiPoVIEpr2ItJFRHI+diEDfYRfSylO8ZIfFfFZI7yW55YzYx7qB
         ubm3BkG7OWuXVr/J/RAsf20oczo8MMbv3w6DZSbx+LpER/VdzfgPMcX47k/RzsPVfrhY
         X/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQ6FUBIM9thJqbhUS63FKjztr/wXj8cgKR4tXqEtQ7s=;
        b=bvitRyWkoDTkSxBxDwIlLJ5YtGX24mFM0Movz5nZ5q0Z0ee2uSMf28wJopdlSyZ4aa
         0+cn9kjWoF7fv6ekeY0OldmS7Yj2BzzXajX3UEjTgFWPpMYUecYWEe/DMzbIpqk8aY9j
         B2NEnvE5MUP4a7v6ZBX1GbmfwKqojPnX+1PkcT+5PoxY4xQrVkK4jyhyrxFhDbWwsvzU
         WFKanSI0iSolwGAu2HjAKYvdr9ZI2Tnt0YltEneuSlZpEYMItRaeiezImQSUQUH2OhAa
         cAlVl01g7Z6068nXnCW/IJ7QaQjBMp8Jzo5luLHgGnFDt/uLwXTKIEFrVFqYgGppgt24
         u96g==
X-Gm-Message-State: AOAM530jPjqYq+ICEcoA8Q2TfSIe9zLTTCi6K6SRGpVDPi0xyscyc5jg
        nUe5SFb09DJgk5sTRxa2o3B30rsENaDiKrKmvvIkFw==
X-Google-Smtp-Source: ABdhPJyMnk07HkEmQ5T4dxMeflUqucQ/Q/tgaQvW78ey2NbZe+7L8S68QtEOQeKSrxWS+FGbmyyMpqTTZw1YJPCMLqM=
X-Received: by 2002:a05:6512:3fa5:: with SMTP id x37mr5618301lfa.233.1633001124808;
 Thu, 30 Sep 2021 04:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210928082346.22398-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210928082346.22398-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Sep 2021 13:24:48 +0200
Message-ID: <CAPDyKFrWTDe83Thbf_JGLGmfKbJvFyCLEXgoOgg-=ROvV8yJrw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdci: drop unneeded clock-cells dependency
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sept 2021 at 10:23, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The meta-schema already defines dependency between clock-cells and
> clock-output-names.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 23abb7e8b9d8..dd70431df0b7 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -158,10 +158,6 @@ properties:
>      description:
>        The MIO bank number in which the command and data lines are configured.
>
> -dependencies:
> -  clock-output-names: [ '#clock-cells' ]
> -  '#clock-cells': [ clock-output-names ]
> -
>  required:
>    - compatible
>    - reg
> --
> 2.30.2
>
