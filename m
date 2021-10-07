Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7AC425711
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbhJGPw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241884AbhJGPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:52:55 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517FC061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 08:51:01 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so3501479ote.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L11lLBT9TBwzBqz4SAuL8n75DIPYPGwgcKMPhOsJZgk=;
        b=OnRLuyfAlafC36pMoWrj2tQRIS5IYUNV8GRvrtj4WxwsRj70bi1oTiEb27RxF2BBLQ
         NqjAAR0evPS3j4QDSfc7Cj8kbVEqzUrGOjNZAA4pPnNmyao5UW2COU4rZYjqxNjGFIK7
         5ZI+dfJXVUZbVuwjF/OJeHD9TrTZEoemE5BgLNdgVMyjjhl9IdL2Yf6ZPBzI1HIPzEX4
         NiCIGeyaT7Wbs/Bd8SqNyubQFp9QCBjcTa32+mEgbF0AMXmLB+8e0NjfLICeUqUfPqp5
         O93cYPjN3A87Tgz+0hWLW9SohAQbjAm9BS9iY+Rq68QcK4AvJ/7hqJfI8FpgxkID8bOd
         2+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L11lLBT9TBwzBqz4SAuL8n75DIPYPGwgcKMPhOsJZgk=;
        b=qrYu9uE0sQf5MrPjEMft85vDYayLDZ6ldJ9exUz2jHlmEcrEspRJ2IyMciVDzWFt1b
         yXkSbDjd5c8DmRqBT4VsLA1xX4PDpBmcuBTdHRww1oAup3TxaR4N9lDU5uNzMXxK9xDj
         5Wr8AsoBy1Pv7/kyGnHvJwSdYqc9VtPqZIRQJYf62xsD3PeUJ9Me2FGTT/XClyozw7jM
         hFSiSpVCjwaIXp42peW62gVK0V5kLBhOzlsMSLRrZuKi8HSroLR1qtab0JSzLTb6ozQd
         Wrcw9DWohuqtC9v0++gpLCOpzLvA/m+9rwbIapIbXvAGpr9BIAV5n/C1sQI1LUTDYnPv
         bx2Q==
X-Gm-Message-State: AOAM5310Jp9ISnWDEU4/AfEFAUCIKIBbgViDHY8PolhmnPs4hp+Q4YuJ
        BgmeX23nXwX6u4pNzPBlTbelHol2VFtEcA==
X-Google-Smtp-Source: ABdhPJx2U1z29bjEFi3dM3JcCLN26FSV/ODRDygrsxx2nAOwodBN0QbwUU07aalJxIcvoFKT/AQwWw==
X-Received: by 2002:a05:6830:1514:: with SMTP id k20mr4124291otp.44.1633621860711;
        Thu, 07 Oct 2021 08:51:00 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id 14sm4676969oiy.53.2021.10.07.08.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:51:00 -0700 (PDT)
Date:   Thu, 7 Oct 2021 08:52:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: arm: qcom, add missing devices
Message-ID: <YV8XyG+j9D1PQK2V@ripper>
References: <20211007144811.14008-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007144811.14008-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Oct 07:48 PDT 2021, David Heidelberg wrote:

> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> v2
>  - lge never existed, use correct lg vendor-prefix
>    in -next, v1 patch must be reverted first before applying
>    other lge -> lg conversions are comming in different series
> 

Can you provide this as a fix on top of linux-next instead, so that we
don't need to revert (or worse rebase) the tree as it is right now?

Thanks,
Bjorn

>  Documentation/devicetree/bindings/arm/qcom.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 73c3ce877ba8..b0b4f9d72935 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -101,6 +101,9 @@ properties:
>  
>        - items:
>            - enum:
> +              - asus,nexus7-flo
> +              - lg,nexus4-mako
> +              - sony,xperia-yuga
>                - qcom,apq8064-cm-qs600
>                - qcom,apq8064-ifc6410
>            - const: qcom,apq8064
> @@ -136,6 +139,7 @@ properties:
>            - enum:
>                - fairphone,fp2
>                - lge,hammerhead
> +              - samsung,klte
>                - sony,xperia-amami
>                - sony,xperia-castor
>                - sony,xperia-honami
> -- 
> 2.33.0
> 
