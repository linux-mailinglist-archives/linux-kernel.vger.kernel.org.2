Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3773A8C93
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhFOXgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhFOXgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:36:22 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FBCC061767
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:34:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so648877otk.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hxB6H8+aCeSUiBG1hifYHdZhYWkj0hk7sQxa3V/kpLg=;
        b=oqYQ+Aa6KfsGyCXv/4GfHLloW6n1iYOM58VSQSlxcux9dXPsWCqL9A5m1MD79d5HfK
         SI/9op63b0fYQrLDPT7WfehF+7UQEu+SAZ8v85wLD5HMwxYZ5R945ocA6QwJjcd6hjME
         AWiH7dgiP56ZG0mpDaNtk9EQZCglWsV2aYz6CiqAJc7erz7svMz4v1wO5PvybdJjYIgA
         kMjuzFIKDdLkZWoCZ/9Z33QTiC00CNrib0p2M4b5QOF0dGHKMJZPDAOmiyMkndK+LqaJ
         YSSU3l+PzQpmmaaC+PAe7VcwVq6ylbnMpBMkvM0AVyc9d2hagJiPIw5PHQRPuR62ltdi
         N6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxB6H8+aCeSUiBG1hifYHdZhYWkj0hk7sQxa3V/kpLg=;
        b=C/7ohXcYiJbQ8X4aaQnPjAmpvxV7f7S5KpT/PJKTKj4YlVRcUNsroXY0jiV5ViQr9q
         98Q5Q+VQWjthq2hpZ1OYZFsXs4Jqq1Bl7uFvIBTME1lBDULxUCG7uhBJ0ca6++KHQSdy
         YYCCiF2kK+vigi8iEr7VFRgkdGGRRkF0LYEfZSnJ+XvyfYVocyfLbPmqcOBRDsm8dBKX
         a2x55eCqhbPpOgNmgAzScupm704My2yo27V8/vpU8Pjni0LiN7tCWFzlCTVRdforfHGQ
         ALA+Q6ybEryIlacpMSGJHeETRFCIDJFSOPLL65Dzjy1HAV+fS+bWwSKkbdcmc/IZ2iNN
         YF2Q==
X-Gm-Message-State: AOAM5316BiC5G7O2BPle7kHXKN373YxFOrrIqejv+8dirR/hN3ubEBVD
        C0S5LS4uvpU1MRZQH5AOpnB5SA==
X-Google-Smtp-Source: ABdhPJxJuEmlFW1DQj0HWiLK6p7P5TX62qHB17KKKwUlZ+JyyEyuSs5idLJAall5Elt35b3sxV6fNg==
X-Received: by 2002:a05:6830:245c:: with SMTP id x28mr1377082otr.169.1623800056132;
        Tue, 15 Jun 2021 16:34:16 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x31sm111764ota.24.2021.06.15.16.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:34:15 -0700 (PDT)
Date:   Tue, 15 Jun 2021 18:34:13 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: qcom: gpi: add compatible
 for sm8250
Message-ID: <YMk49VN4CgEa41w8@builder.lan>
References: <20210614235358.444834-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614235358.444834-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jun 18:53 CDT 2021, Konrad Dybcio wrote:

> No functional changes, just adding a new compatible for a different
> SoC.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> index e302147e53c6..e614fe3187bb 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> @@ -21,6 +21,7 @@ properties:
>      enum:
>        - qcom,sdm845-gpi-dma
>        - qcom,sm8150-gpi-dma
> +      - qcom,sm8250-gpi-dma
>  
>    reg:
>      maxItems: 1
> -- 
> 2.32.0
> 
