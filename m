Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140CD417DED
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 00:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbhIXWsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 18:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbhIXWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:48:48 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD67C06161E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 15:47:14 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so15179958otq.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I9u2fLn+ZPe8iK9QXUAKNTnuENv/p85Wj7jzDDXa8Ro=;
        b=fPbsej9cE3BqE1NW/7GZazdBAIpJwyAnhohBgNJHjwEdAHac9NTh6nM6TR4x79S5MK
         /0PYK9wFKzqykqfyWqrF62XB3kxLqXNEOy5ei0gsdA/aNtq15xzY8Z5EMpPh0Z9U0VQv
         sZshNrNE0C9/m80SX3l+XU/qg68zpjt+/2cIBbhwukI0kFK9gxMHkm6ZKTLJZyS29Q8b
         FaKABMPZN66sHRF2SXm4na4tzZF5uYjvghSXAQYoandYhEc7n+XUrhS5r94ITVK+oCgv
         KKiJ1RSS7+AR6NUy5EO9doo4U7q1A0HoYmdIASbCfA2y766CywAOxNRSoiG8MzQ/YcJA
         PUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9u2fLn+ZPe8iK9QXUAKNTnuENv/p85Wj7jzDDXa8Ro=;
        b=3bqryLCaXqfOW4kgzl0qflBSvhnzF5aQna73VRhiE2X4eai5Osaq0F7pYUMbFLmlDW
         ctBG4DoR85uww89rBce/cWEn/9Bf+EbYDLiCTyiNyJ+TPprBzVT6zz0oT/xZ7K00wwSr
         duDwACMYrVj0VvC0PDaE57pfftQ19i2iILAUby/6HfLxDIKBKT2cKSdhg1UPqdYXBhAr
         cHRFiZ21VgHreWZMiPbEbZS0OfzBA8qMcuCH2gW0KjbZfXINRnlFIhqJHIzQFOHa8Fbc
         1/giX0lTJ+EqLjDBeXY5i4U7DLak2fz7xPOAixLepNHdZwgey9ySatOoIXghszC5pFo5
         A7oQ==
X-Gm-Message-State: AOAM532O1uQz0LgZyS7g0k/Muuty/85ZQkOgzmjmkbRYKd0F3MdVnqRu
        y+vzwb2vp9gfKpgwBKwrAp/63A==
X-Google-Smtp-Source: ABdhPJzaanlkMWDf2F1GBLhbn1IwvShqjljYe0iALC2MB/ERVkmZ0/QlCQ/n1F/2VtloHzpVaytvOQ==
X-Received: by 2002:a05:6830:805:: with SMTP id r5mr6147337ots.209.1632523632492;
        Fri, 24 Sep 2021 15:47:12 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v16sm2462663oiv.23.2021.09.24.15.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 15:47:12 -0700 (PDT)
Date:   Fri, 24 Sep 2021 17:47:10 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajesh Patil <rajpat@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, sboyd@kernel.org, mka@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH V10 1/8] dt-bindings: spi: Add sc7280 support
Message-ID: <YU5VbmVdSuFE9syi@builder.lan>
References: <1632399378-12229-1-git-send-email-rajpat@codeaurora.org>
 <1632399378-12229-2-git-send-email-rajpat@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632399378-12229-2-git-send-email-rajpat@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23 Sep 07:16 CDT 2021, Rajesh Patil wrote:

> Add compatible for sc7280 SoC.
> 
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Can you please pick up Rob's review tag and send this patch out again,
this time including the SPI maintainer (Mark Brown <broonie@kernel.org>)
among the recipients.

Thanks,
Bjorn

> ---
> Change in V10:
>  - As per Stephen's comments,
>    sorted compatible names in alphabet order
> 
> Changes in V9:
>  - No changes
> 
> Changes in V8:
>  - As per Doug's comments, added "qcom,sc7280-qspi" compatible
> 
>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> index ef5698f..09aa955 100644
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
> @@ -21,7 +21,10 @@ allOf:
>  properties:
>    compatible:
>      items:
> -      - const: qcom,sdm845-qspi
> +      - enum:
> +          - qcom,sc7280-qspi
> +          - qcom,sdm845-qspi
> +
>        - const: qcom,qspi-v1
>  
>    reg:
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
