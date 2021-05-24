Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FEF38E864
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhEXOM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbhEXOMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:12:48 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D67C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:19 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x22so6279799vsn.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kY6jyrsjJi+HRe/mQv1siQhxLxlSd/Eu9JyaCf+aU6s=;
        b=IXs1jXps0iRBX4YK9sEw4oHXipJS2Vdcqg8JktkfHSIi5jU2oVnIJyIAzOS7eZcYNw
         o5mQqMSbTrVSYXiNmkgb0meO+JonZ1dPBDOVINXK2+9ItmqFWGyVdMbhgZwgJLiArKJQ
         vme5ZxZkosQY3pAdTR1TV4i1TkPBo7lCLx8I1moZEsxTAtfhMYwytO4EnwYpgJ88/bO5
         Inh2i9pYEld/fb+HBFPhty7+WIUSjWjNfL1o9SWOmWowtK+9L75wswYYxZdw2SC0KmgP
         BCf8MKMOK6BGch3AhVUMN0zBUIOqiKqKbaiOu9JBcy6MXM3W/dcOrvoTlR9yF5TcNblt
         jVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kY6jyrsjJi+HRe/mQv1siQhxLxlSd/Eu9JyaCf+aU6s=;
        b=oIDrTyec+y8IEJVl9aFSOUNrgSoMYk9xcKEMULsT192s9DsA+AQQTH7JdXSIsd8Ta2
         9geWLtRy05TshTnUlwUB6a7LNE4a3eUcO1fESVn7XW6kzUznNtaABaLWV2guCOtrW8SH
         GXNOUA7SzsaU+wpsjXo3uLWcnASAoWnoS++/bg2Ay58GTcPv+nCYsnYz1LE5M/1jpEWh
         rtNyqfmXFnkYGH1NaskWZ78vuKIu/EeURnsf6sewB71ENDLgUHN6vF0KLuEehU281N21
         NHz6D8MS5VuzWcM9mGNUeKSXJHNqYA5eKfThteInhSsw5AdrQta5RovC+HttOCqoQ/Q/
         i71Q==
X-Gm-Message-State: AOAM533aNBn1a443/HcmR936OELQkjyVPb9EyRHx0YE2rWWwpOoaLHeF
        xrAitroup4G8lrusJmPOv8Wz3r83V3k+oUNeauclgQ==
X-Google-Smtp-Source: ABdhPJzy5pWzjYOdI2C/JAdvDJO42gMZKBOGSCRG9HkPRjrjrvdlF4IEcTEM2E/bQlE0mUc+P4Djeej/ypqMDjf5eb0=
X-Received: by 2002:a05:6102:7c1:: with SMTP id y1mr22086341vsg.34.1621865478143;
 Mon, 24 May 2021 07:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210519153712.3146025-1-robh@kernel.org>
In-Reply-To: <20210519153712.3146025-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:40 +0200
Message-ID: <CAPDyKFq-dFj2sS3gsh=oBywmoTKkxojYCq8B8Gn5kXyEiFChKA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: Clean-up examples to match
 documented bindings
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 at 17:37, Rob Herring <robh@kernel.org> wrote:
>
> The "sdhci" compatible is not documented though used as a fallback in a
> few cases. It is also not supported by a Linux driver. Just remove the
> example as part of ridding examples of undocumented bindings.
>
> The "brcm,bcm43xx-fmac" compatible is also not documented. Update the
> example to use one of the correct ones, "brcm,bcm4329-fmac", instead and
> use a device class based nodename.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
>  - Also fix "brcm,bcm43xx-fmac" example
>
>  .../bindings/mmc/mmc-controller.yaml          | 20 ++-----------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index e141330c1114..646ae768d625 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -357,22 +357,6 @@ dependencies:
>  additionalProperties: true
>
>  examples:
> -  - |
> -    mmc@ab000000 {
> -        compatible = "sdhci";
> -        reg = <0xab000000 0x200>;
> -        interrupts = <23>;
> -        bus-width = <4>;
> -        cd-gpios = <&gpio 69 0>;
> -        cd-inverted;
> -        wp-gpios = <&gpio 70 0>;
> -        max-frequency = <50000000>;
> -        keep-power-in-suspend;
> -        wakeup-source;
> -        mmc-pwrseq = <&sdhci0_pwrseq>;
> -        clk-phase-sd-hs = <63>, <72>;
> -    };
> -
>    - |
>      mmc3: mmc@1c12000 {
>          #address-cells = <1>;
> @@ -385,9 +369,9 @@ examples:
>          non-removable;
>          mmc-pwrseq = <&sdhci0_pwrseq>;
>
> -        brcmf: bcrmf@1 {
> +        brcmf: wifi@1 {
>              reg = <1>;
> -            compatible = "brcm,bcm43xx-fmac";
> +            compatible = "brcm,bcm4329-fmac";
>              interrupt-parent = <&pio>;
>              interrupts = <10 8>;
>              interrupt-names = "host-wake";
> --
> 2.27.0
>
