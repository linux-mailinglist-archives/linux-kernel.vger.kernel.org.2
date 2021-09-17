Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F252540F24E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhIQG07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhIQG06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:26:58 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECFCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:25:36 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so11547976otq.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ICEs66mzOrWw5DoGNjzQDzMrnyfZ+Z+NkVU0FU1eIqM=;
        b=ffB/SHZAlTYkRT/UiB9ZGJAejN4vLBrCabhGLPTmaUVzTGPciu7V/RhWZ2Ppcswr7L
         EFLXxWZHPfm6dA0V6y1vovBZH/lwgO66e/TDYrfCFOi0lC0uLSPap141TNp0R5Jn4h9P
         MnX7NdiUb/ajqWy+cZqQcA1GSznY+yOkhMW5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ICEs66mzOrWw5DoGNjzQDzMrnyfZ+Z+NkVU0FU1eIqM=;
        b=S33ulmke0Ff3VFTxqYHT1d1qEcS5sS0MNqIFNCU6DvnnwnQEeQRAMEpPyar6pcFFHz
         fzfxAJDDdFLJIj55lgytAX6KiEiOxtBZdHVN9bMTwmaoSVPWCANwiIutKgU4IzLJGMoP
         da8ICM0YygNEKcXeMRYuasSgJfvT/mB5076DlsU91/+vgDW9VpFu0ghTH4z3yfKnypVB
         rqC7lNUF/GqqxuH3ZUuhgmfZzS9a0TR8vRYgKltYfNdZXHR+XIFFvzn73faDAQKntel0
         MLioB5q57ai+QhYIruwr+oEfZQVGqpkOAOkWDTt5IdvbYHU9U+RWHI0e6xYfwH4BFU85
         ikIA==
X-Gm-Message-State: AOAM532RASO97xOaCYwsZ4eAvjusELEUVxfxnWDJ8Wwtmwqe46tIkuVQ
        sDosSNi+pW8Yh5rY6hkyTYfo1BJKXIXEyuF2DREi4Q==
X-Google-Smtp-Source: ABdhPJyDW1VAO7a/TQ1CU2vowcY3A3hOPeoUkpVMQrtweBg2luyz25xyyE+y6zVDUbyY0eP6EHeblTMoRnpczu07QOc=
X-Received: by 2002:a05:6830:719:: with SMTP id y25mr7949091ots.77.1631859936068;
 Thu, 16 Sep 2021 23:25:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Sep 2021 23:25:35 -0700
MIME-Version: 1.0
In-Reply-To: <1631811353-503-3-git-send-email-pillair@codeaurora.org>
References: <1631811353-503-1-git-send-email-pillair@codeaurora.org> <1631811353-503-3-git-send-email-pillair@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 16 Sep 2021 23:25:35 -0700
Message-ID: <CAE-0n51KBYjZvwGNy06_okmEWjEfRLQO54CYaY6-JnbBk6kOhA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: remoteproc: qcom: Add SC7280 WPSS support
To:     Rakesh Pillai <pillair@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        ohad@wizery.com, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sibis@codeaurora.org,
        mpubbise@codeaurora.org, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rakesh Pillai (2021-09-16 09:55:52)
> @@ -78,6 +84,10 @@ properties:
>        Phandle reference to a syscon representing TCSR followed by the
>        three offsets within syscon for q6, modem and nc halt registers.
>
> +  qcom,qmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the AOSS side-channel message RAM.
> +
>    qcom,smem-states:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: States used by the AP to signal the Hexagon core
> @@ -117,6 +127,33 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,sc7280-wpss-pil
> +    then:

Honestly I find this if/else to be a huge tangle. Why not split the
binding so that each compatible is a different file? Then it is easier
to read and see what properties to set.

> +      properties:
> +        interrupts-extended:
> +          maxItems: 6
> +          items:
> +            - description: Watchdog interrupt
> +            - description: Fatal interrupt
> +            - description: Ready interrupt
