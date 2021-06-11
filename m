Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD373A39E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 04:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFKCuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 22:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhFKCuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 22:50:07 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA82C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 19:48:10 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so4347995oig.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 19:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ET0Wo9pMUsI9hBiKex+wY6Ul5+CPxPf28986pbN/EI8=;
        b=Iseiym3XfDQgP5PW7eJN1GwuNhwtjrkNSyfsk2d62Gjx6tZlaIQBmsm5i4cidk+odv
         e16sKIQ7BwJOk2C4LEALXoIAxEjHgGi62G0yRCUotsSccwggOlHDSkweK+zPSVp6O+/9
         gNnhRuw0jWJgwnE67tYQGX+sq2Ei2FoYKop4iMuR0ZURcFhtMK90C8H8fN1wVhdV7Vm7
         aiFbBiZFSsTqU0vS9vST8xfcTR3QkeIqdU1yEJf1NqmZjiZXIB2ue1EXxFCVbZ+GQkq+
         d9Ze2RSacRNjcGo6V9XjIlO82Bo4tPP9iluGBiZKJCYJfLYtUyrF74r18DHSyhxAeHPF
         gqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ET0Wo9pMUsI9hBiKex+wY6Ul5+CPxPf28986pbN/EI8=;
        b=JVLeh1/ZlVXRWWEW0izePnLX4fAXVl12qFitgT5MpKWzU+HYn1XsNpIitoj6ZGd8Q/
         /tcz4Ha2YDUjICwufI+XTl9gyJBI3vwk4VGszdtBKkkdtnJNu5Mk7eIRPBccX+akbs7K
         AUdiRfaVDWSWFdjlrLaXR0xWkWW2Jc578swjwDdilFpFioOe7Bj2N1qRFbx39kd15EIL
         aAdlebQxKKbGRzOZM/CR71QU9xCmg2Pu/KfmedzUz1hJWy8dypF8HrLICf6bu6zgCasv
         +hBXcGD7jfpfdEyC9gnqcA3edgZRCXjCvGQIURD6nbI5bDP7je0IEG1uJKfaKBwoLx6P
         eOvg==
X-Gm-Message-State: AOAM533/wn30CyRKn4hIwuLRbeMnMqaNH1fMgHaJ6ibU4Sqric0yGKdA
        Z95JzwCEIV8seLehdpO7R8HD6w==
X-Google-Smtp-Source: ABdhPJz04W/K9tQFYJrLbGW31b3a6sL0JI96PcarTWMMiRhX4hwe2np+7ggxBmcFSUfQkfxWI4JNNA==
X-Received: by 2002:a05:6808:999:: with SMTP id a25mr938976oic.123.1623379689633;
        Thu, 10 Jun 2021 19:48:09 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a74sm929046oib.21.2021.06.10.19.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 19:48:09 -0700 (PDT)
Date:   Thu, 10 Jun 2021 21:48:07 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: Re: [PATCH 1/8] dt-bindings: qcom: rpmh-regulator: Add compatible
 for SA8155p-adp board pmics
Message-ID: <YMLO56Rr7UGUy8vo@builder.lan>
References: <20210607113840.15435-1-bhupesh.sharma@linaro.org>
 <20210607113840.15435-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607113840.15435-2-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Jun 06:38 CDT 2021, Bhupesh Sharma wrote:

> Add compatible strings for pmm8155au_1 and pmm8155au_2 pmics
> found on SA8155p-adp board.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: bhupesh.linux@gmail.com
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> index e561a5b941e4..ea5cd71aa0c7 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> @@ -55,6 +55,8 @@ properties:
>        - qcom,pm8009-1-rpmh-regulators
>        - qcom,pm8150-rpmh-regulators
>        - qcom,pm8150l-rpmh-regulators
> +      - qcom,pmm8155au-1-rpmh-regulators
> +      - qcom,pmm8155au-2-rpmh-regulators

Looking at the component documentation and the schematics I think the
component is "PMM8155AU" and we have two of them.

Unless I'm mistaken we should have the compatible describe the single
component and we should have DT describe the fact that we have 2 of
them.

Regards,
Bjorn

>        - qcom,pm8350-rpmh-regulators
>        - qcom,pm8350c-rpmh-regulators
>        - qcom,pm8998-rpmh-regulators
> -- 
> 2.31.1
> 
