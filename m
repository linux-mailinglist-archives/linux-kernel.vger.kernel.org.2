Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDCC3D0502
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 01:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhGTW3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhGTW3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:29:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25A6C061767
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 16:10:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y17so121867pgf.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 16:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HmZtI1xpEI+ek1YEEmTrQH173EtPkZuQKAG16jfYelI=;
        b=WWsHNFpumMchKKqPUZYeL3Q0MRwuhZGf1N5qizIbIoaqwSqsI0GRnaLgjtlY1VxNid
         JskTU9X0Ts4uhfdYP1vrKcn9yRMbvUZXKCpzJ9wL+wUzJntjupv2qYxPwjCUS1MD9U5o
         XjkDCRYBRTor9KRM7GkV/2bKjF3vPkwL8/YnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HmZtI1xpEI+ek1YEEmTrQH173EtPkZuQKAG16jfYelI=;
        b=DIVO6weDSbbYk+3UA1rF60GhMgVhszS1LqQ/ZBI1/+/Kk6qJMSIlz8eInlZy8aisN6
         271D+fZ/X5FV8fEXsKPJPxu9TOL/Q8UsseZMYS+/9r/oxEkdOdZFDsIbVRJ7tnCUU3U1
         iG/r2Eo4quhpiyuFBWa1TlGaZtVsq8meM4QKl9V0vKtePDMg2ZQPP+sle4IrU9kuQbl1
         xl+BV63opM9WN9kCFuSvLh8xinQv6UblGYpNS88hWh0609brTRTQVBihoBplmCiKdSpe
         eLaRr2lrjQHzOGWvzCGM205gYVrH+appob2uU11uTarI/NFJ9fLhy/eoSmM2gSUVBmuU
         e7wA==
X-Gm-Message-State: AOAM530f0lRBrChlbVvSvpCr3QvGBKfpAjRBC3B5JSJw2ECDkvuRNNG2
        ngwW7zJxt7sLRPt30ti5Y+TrOQ==
X-Google-Smtp-Source: ABdhPJxXibVoBqbItv1ED8m4kpKScTx/Sran0ivRFpDT+e0xLPrsaQZe1F9x4oWRAU2XI0LZzmyyUg==
X-Received: by 2002:a63:1f0e:: with SMTP id f14mr28618978pgf.65.1626822609238;
        Tue, 20 Jul 2021 16:10:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c9c3:db46:7281:8e32])
        by smtp.gmail.com with UTF8SMTPSA id u24sm26397365pfm.141.2021.07.20.16.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 16:10:08 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:10:07 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     swboyd@chromium.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        agross@kernel.org, ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v4 02/13] dt-bindings: remoteproc: qcom: pas: Add QMP
 property
Message-ID: <YPdXz1T89GcIYmJO@google.com>
References: <1626755807-11865-1-git-send-email-sibis@codeaurora.org>
 <1626755807-11865-3-git-send-email-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1626755807-11865-3-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:06:36AM +0530, Sibi Sankar wrote:
> The load state power-domain, used by the co-processors to notify the
> Always on Subsystem (AOSS) that a particular co-processor is up/down,
> suffers from the side-effect of changing states during suspend/resume.
> However the co-processors enter low-power modes independent to that of
> the application processor and their states are expected to remain
> unaltered across system suspend/resume cycles. To achieve this behavior
> let's drop the load state power-domain and replace them with the qmp
> property for all SoCs supporting low power mode signalling.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> v4:
>  * Commit message change and sc8180x co-processor addition. [Rob/Bjorn]
> 
>  .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 65 +++++++++++-----------
>  1 file changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> index c597ccced623..1182afb5f593 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> @@ -78,11 +78,11 @@ properties:
>  
>    power-domains:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 2
>  
>    power-domain-names:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 2

It seems maxItems should have been 4 in the first place and should remain
unchanged after removing the load state power domain. With this patch:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,sc7180-mpss-pas
    then:
      properties:
        power-domains:
          items:
            - description: CX power domain
            - description: MX power domain
            - description: MSS power domain
        power-domain-names:
          items:
            - const: cx
            - const: mx
            - const: mss

