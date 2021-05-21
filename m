Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45F338C962
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbhEUOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbhEUOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:44:04 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E52C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:42:40 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d21so19818763oic.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Z2KkwCEfM/BotE4mJLxeXlSEUL4YCagVaLjGTvy9fg=;
        b=vT57+LogiFiec6wgtvPzqP6wwylRI+H3RY7Yz247iK9wZws/fiqF12NsNQp4BqIbHZ
         TDsvykaL9rSu62USDGS+LufAkxWR5hZ2ykz2EInJ7msEAyM2gVjcr9qjIN/Cp8j29bpO
         jR9+fo3hhoUy6JsiZ162qXXS8bw4fZMF0lTzImjiXJtxTKdIrmnWz62BDhUqU4EUkLA6
         nz+Ry/eundYbkEnNQp38dxhU17Tk27tiv9Lk1WRlLhNzrqhXwtRywi7nQrgeSjmeL2Tu
         OuJM5VVMAW9jE4krg+HwJP/K42KgoBH4IylPXbHa1Rm3mXZDljPnh1sw2/sIqbdyWaLY
         tiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Z2KkwCEfM/BotE4mJLxeXlSEUL4YCagVaLjGTvy9fg=;
        b=AjZHAZdcUsSa8a06sUEO8nMQYL97ox5TE61sc/ADboswpsMmUAw5+LfC0S/ouvb0NP
         9k8rIzek/VBZ3OyJ43a4+SyoHaWe6E4rDC9YZzgvIxk0mtkLhMeNOhknX+yfOCI9WKm3
         MIfcvGxHP6he8q5HC3MgOekCf67HTw1oU0rMwZpnb3tNMbrTWjRr0YpqhcUSyg+u+iQy
         SoGM2gu6gjpNeSSbcwXVp7+whDjkKeYmR8PLRraXlb8g7i0xRD2/3tgnb35v+OvfEGjv
         sGtDgx9Fkw9HYcoKEB9a5l95F5J9zJH8jzsb+iifmQM0hxC+NJPApq4xbLelRn3A7oyD
         /1GQ==
X-Gm-Message-State: AOAM530XJFtfI4FM+Up6pjD8hLWKyhFRlxvcxNa+MfQDazPef7kBkagZ
        SmBMnPnXp73tuIVsMVsCY8d9hA==
X-Google-Smtp-Source: ABdhPJwnIJOU+D/nOQmEzRVwv3lT8IqqVtQca3zuNpPqbOdtvyDqSMrLplRNdstZzXFnadfmsqO24Q==
X-Received: by 2002:aca:2417:: with SMTP id n23mr2376892oic.111.1621608159986;
        Fri, 21 May 2021 07:42:39 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r10sm1164085oic.4.2021.05.21.07.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 07:42:39 -0700 (PDT)
Date:   Fri, 21 May 2021 09:42:37 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 02/13] dt-bindings: msm/dsi: Document Display Stream
 Compression (DSC) parameters
Message-ID: <20210521144237.GZ2484@yoga>
References: <20210521124946.3617862-1-vkoul@kernel.org>
 <20210521124946.3617862-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521124946.3617862-3-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 May 07:49 CDT 2021, Vinod Koul wrote:

> DSC enables streams to be compressed before we send to panel. This
> requires DSC enabled encoder and a panel to be present. So we add this
> information in board DTS and find if DSC can be enabled and the
> parameters required to configure DSC are added to binding document along
> with example
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../devicetree/bindings/display/msm/dsi.txt       | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi.txt b/Documentation/devicetree/bindings/display/msm/dsi.txt
> index b9a64d3ff184..83d2fb92267e 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi.txt
> +++ b/Documentation/devicetree/bindings/display/msm/dsi.txt
> @@ -48,6 +48,13 @@ Optional properties:
>  - pinctrl-n: the "sleep" pinctrl state
>  - ports: contains DSI controller input and output ports as children, each
>    containing one endpoint subnode.
> +- qcom,mdss-dsc-enabled: Display Stream Compression (DSC) is enabled
> +- qcom,mdss-slice-height: DSC slice height in pixels
> +- qcom,mdss-slice-width: DSC slice width in pixels
> +- qcom,mdss-slice-per-pkt: DSC slices per packet
> +- qcom,mdss-bit-per-component: DSC bits per component
> +- qcom,mdss-bit-per-pixel: DSC bits per pixel
> +- qcom,mdss-block-prediction-enable: Block prediction mode of DSC enabled
>  
>    DSI Endpoint properties:
>    - remote-endpoint: For port@0, set to phandle of the connected panel/bridge's
> @@ -188,6 +195,14 @@ Example:
>  		qcom,master-dsi;
>  		qcom,sync-dual-dsi;
>  
> +		qcom,mdss-dsc-enabled;

To me the activation of DSC seems to be a property of the panel.

> +		qcom,mdss-slice-height = <16>;
> +		qcom,mdss-slice-width = <540>;
> +		qcom,mdss-slice-per-pkt = <1>;
> +		qcom,mdss-bit-per-component = <8>;
> +		qcom,mdss-bit-per-pixel = <8>;
> +		qcom,mdss-block-prediction-enable;

Which of these properties relates to the DSC encoder and what needs to
be agreed with the sink? Can't we derive e.g. bpp from the information
we have from the attached panel already?

Regards,
Bjorn

> +
>  		qcom,mdss-mdp-transfer-time-us = <12000>;
>  
>  		pinctrl-names = "default", "sleep";
> -- 
> 2.26.3
> 
