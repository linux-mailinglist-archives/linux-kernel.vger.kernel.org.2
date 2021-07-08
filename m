Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B09C3C1BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 01:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhGHXZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 19:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhGHXZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 19:25:38 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F0C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 16:22:55 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i5-20020a9d68c50000b02904b41fa91c97so3184199oto.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 16:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=erPEQ5qusFdUetma23ocZGx6VyJVWOGasdNhx9ZlPas=;
        b=bbkWaV/PVCApTEkLGIr7Q6qml+NjjkYBHxxln82BTmc9cUbq9U+InpMo+ndTTLI3re
         WL7Wm7LTmXSpuVv4gxUVcRuj5nSDvJsiyxWOIsevLHq2HUmjbY2xoSTbSTrwGzGaqCrP
         GtK3nYsSsgjONgyB6ATgfpYs96JQF0wQPjR38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=erPEQ5qusFdUetma23ocZGx6VyJVWOGasdNhx9ZlPas=;
        b=ui4MHUiWzDR7Ce4BcOP6h/lr2F+OAdcPdJxH11vsWjo9Hk01MeQtnpGGVF/Rt3L+7u
         UTvvz1T8LEJaH1HPLn2F6oz6Dxifzmh7QIXAicbMBlF2pNjWaAupxcAkxHpYCO1mbU6F
         h/Wloha+Gxx0a0xdKHv8XT9hVSoQmEg4QqBsqLFnQiINEcpUSj9IpiIWbXDvGqJ5gHIY
         t2NleBzLo/pNAQw/oENaZZE+HeJojQFjnBme3IEpVV8NBKYdFRjusr6jd3pJLvOUwXLC
         VDaO9qqWClHmyUVmZKUOXz+gGeAtBdovapsBNlX8Vwo3vdc+tI814PAKvwgQ+ZcRff0r
         cnHw==
X-Gm-Message-State: AOAM533FZMdFUgW0rDIchjkHNAUFpNE1HWibLmmx3y9Z0MlSXkCAnu8l
        1ihRVvHOPLetmubESijyq/oEM5gGz2plo6Y9MF5DCw==
X-Google-Smtp-Source: ABdhPJwzNo2G5Ic4IAhAIUd0OQNH7pT10e/9fRFyYaiHj2yruNoCtHSEn6HGIP/M+B0rBbuqWBW4dXscBlQUrVRZXuM=
X-Received: by 2002:a9d:8c7:: with SMTP id 65mr26143667otf.25.1625786574524;
 Thu, 08 Jul 2021 16:22:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Jul 2021 23:22:54 +0000
MIME-Version: 1.0
In-Reply-To: <1624015734-16778-2-git-send-email-okukatla@codeaurora.org>
References: <1624015734-16778-1-git-send-email-okukatla@codeaurora.org> <1624015734-16778-2-git-send-email-okukatla@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 8 Jul 2021 23:22:54 +0000
Message-ID: <CAE-0n51btkt9ehEFrm+WucP90ZufKw1PEQqzNGVDRy51jByXkw@mail.gmail.com>
Subject: Re: [V4 1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on SC7280
To:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, evgreen@google.com,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Odelu Kukatla (2021-06-18 04:28:52)
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
> SoCs.
>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |  9 ++++++++-
>  include/dt-bindings/interconnect/qcom,osm-l3.h                 | 10 +++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index d6a95c3..9f67c8e 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -18,12 +18,19 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc7180-osm-l3
> +      - qcom,sc7280-epss-l3
>        - qcom,sdm845-osm-l3
>        - qcom,sm8150-osm-l3
>        - qcom,sm8250-epss-l3
>
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4

Can we base this on the compatible string so that only sc7280-epss-l3
requires 4 items? and then the others require 1 reg property?

> +    items:
> +      - description: OSM clock domain-0 base address and size
> +      - description: OSM clock domain-1 base address and size
> +      - description: OSM clock domain-2 base address and size
> +      - description: OSM clock domain-3 base address and size
>
>    clocks:
>      items:
