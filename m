Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C89245F75B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 01:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245653AbhK0AJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 19:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245611AbhK0AHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 19:07:52 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2EAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:04:39 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so16051386otj.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qagjaLe0+mgZO/dqxZIxDY3IaXwjOkrK58v2KkFmB+E=;
        b=NtshkIQf4BLSevm2Yiyyd3GPdcEsmfV5UHfYF42Pii3KFGU/oZFrvASS2zfW71mwR/
         O7t7z27ok8o3+n8cuDNuDdYwy0BEpLfiUzOardasMOCtWNBaUsoDFseASuGoRMoDe9bi
         kUVfpNMjtpWZS7tDcOeopCYWERrS7twJYUFxIZY2ELZS70p5yfo5G/BRwx7jZsqekpN8
         p6deXwlFxUjgnpU4fAN6yAReU+zbhHu2KHtT8stXKJYTROF1w/f8K+ecT5eYlMV4Z3Ob
         /2xpdJP9eZB1QmjjMoPUUwRLasQLOOxNvOlTgxh7N1gokKp6/tcOCdz9mgGHiNd6dPzy
         C5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qagjaLe0+mgZO/dqxZIxDY3IaXwjOkrK58v2KkFmB+E=;
        b=8QbtKpRoO9qpoiTE606cmD5na6p5uRQ1XgPAkZo6oSTze1/ThKeQOBKPuUVU9t8YMz
         r7Mfi8hGdf+lyx4EjnjefSZgSWiGHOARMi2mACEp6kq6MaJY8mP+j/ZK2SHIW0DZ9ZB5
         pk4gMFBgXx5j3Tf9YI0sAVhel/jZ9LoKlBaUvOnhedPClL0LB2AcKW4QHrd3tQh/gFYh
         E0zhn1PZYWIoV3RT4KeN/EVaaNdi7Pde4Z+TEIo2j/Lz+ey2KCQPMg9yxIMIrsltB/IR
         6nJh+mjqARF4Zf7PzSLTAzD6DzOwltlKoqMJ9QpKbIIgKz3jUwhqo8lqM3BdX0LN/t+E
         XSnw==
X-Gm-Message-State: AOAM532jrcW1UjFvk/xIxt6b1k1kDpBrLG2O+tWvcHoNmnErSlloi3ab
        1cm3GYMA5rswM9Zp4RqwLx/Tpw==
X-Google-Smtp-Source: ABdhPJxhjKRHR64gxjRhzOzzkGtqHAmp6E6c2FEHyxEKL8Zb6sJShF+NfMB1QByLUYGVFdLBWxaChQ==
X-Received: by 2002:a05:6830:2a8f:: with SMTP id s15mr31316764otu.33.1637971478610;
        Fri, 26 Nov 2021 16:04:38 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c3sm1602135oiw.8.2021.11.26.16.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 16:04:38 -0800 (PST)
Date:   Fri, 26 Nov 2021 16:06:16 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     quic_vamslank@quicinc.com
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, Rob Herring <robh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v5 6/6] dt-bindings: clock: Introduce pdc bindings for
 SDX65
Message-ID: <YaF2eBKMkIvGapCY@ripper>
References: <cover.1637302009.git.quic_vamslank@quicinc.com>
 <538438f41153587043741747db5218e9f575c0f5.1637302009.git.quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538438f41153587043741747db5218e9f575c0f5.1637302009.git.quic_vamslank@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18 Nov 22:11 PST 2021, quic_vamslank@quicinc.com wrote:

> From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> 
> Add compatible for SDX65 pdc.
> 
> Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

Sorry for not spotting this before, but as you can tell from the path of
the file you're changing, this has nothing to do with "clocks".

git log on qcom,pdc.txt shows that $subject should be:

  dt-bindings: qcom,pdc: Add compatible for SDX65

Also, as this is unrelated to clocks, Stephen is not going to merge this
patch. You will have to repost it, with Marc Zyngier as recipient to get
it merged; per get_maintainer.


I think it's fine to keep the reviews and acks while adjusting $subject
and reposting this patch  - separate from the other 5 patches.

Thanks,
Bjorn

> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.txt        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> index 98d89e53013d..ce631d853db4 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
> @@ -23,6 +23,7 @@ Properties:
>  		    - "qcom,sdm845-pdc": For SDM845
>  		    - "qcom,sdm8250-pdc": For SM8250
>  		    - "qcom,sdm8350-pdc": For SM8350
> +		    - "qcom,sdx65-pdc": For SDX65
>  
>  - reg:
>  	Usage: required
> -- 
> 2.33.1
> 
