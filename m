Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767F8337A64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCKRFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhCKREv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:04:51 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23BFC061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:04:51 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id t83so13883064oih.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HcdutmO19zaKE2AyPz8/OHl7hJh6xIt+CzDBadJIgpw=;
        b=OSr6XHSRLkmL8Q4c2CFZXveBS/Yh/p8ICQ/NhU9qbY9OJhhPE9c7uvJZ1oy7e3nV+Z
         +6Bc2NusSzrKGF38S7s5qUxQVcJWvysrPceGUb8W6YxPOhrHgTx3qWsTfp2kK2BJu8aH
         +8VcyJoX3Ys+t6QwxoVDtqcD6i5Fbzmr6kGzIi2DPyErRYrfMimHxq9OayvnXGScRo+l
         WckR0IyJLx1G/vyoolIVXDjc1gCBvC0XU9ZQXqPd11t/ReVFDvW8HObxKynn8+8GfBrs
         /4PGskZGth1xcWzHTPxhVdGoS9vliWcxXTUdUIhjbInZgDWSMVHI0spxg5dTLrjak6c/
         TTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HcdutmO19zaKE2AyPz8/OHl7hJh6xIt+CzDBadJIgpw=;
        b=kUfK4xY+eJD0oAg2rB6xCgoGnu8XNe6R5LmJyZ1hJAlZdYcUZUJ+V3y1cohTIV/Fcl
         33dkkPbF/JMgTp2I4Rdr+QbWfXQyaKey2zWYSV0gYpC1Jcq8eApeAd4IAb8AQ0bH7E1F
         ql7z0qcaWV/0Tgxf6Dm0h7PfbBrjli//cYeLL23n/SW8eiJTkTfXw/L74drzw090Qmf2
         ushAYGd1KUyAPTMe+aNwvjsJSVAvGryJxu8JJTl1iqKWnYhYY/5mHdpAqVUqrPB6I35n
         tLG3S+0QImLCaS1vGgmRJlXgGAjQDjKQFitm4R9AVPxroyD5DAyMil+B+U2/DuuX7Glq
         AgZQ==
X-Gm-Message-State: AOAM533RMoVcmzSCpeCop83otq8L2cptUng4WtCUHAkQOXiyXsbzi1r0
        H1IMw+lMtNm0qhOwnkWdCtqEtA==
X-Google-Smtp-Source: ABdhPJxI9F4kUMfFp6wDmThTzTexYwb0MQbi2g9FnYzIaCxAj0tdzNLUsGozYSfCaH2+Xwisb7r3Tg==
X-Received: by 2002:aca:1818:: with SMTP id h24mr7425260oih.44.1615482291102;
        Thu, 11 Mar 2021 09:04:51 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e2sm747632oti.8.2021.03.11.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:04:50 -0800 (PST)
Date:   Thu, 11 Mar 2021 11:04:48 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-rtc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH 3/3] dt-bindings: mfd: Add compatible for pmk8350 rtc
Message-ID: <YEpNsNqcyE+oj6OR@builder.lan>
References: <1615447798-6959-1-git-send-email-skakit@codeaurora.org>
 <1615447798-6959-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615447798-6959-4-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11 Mar 01:29 CST 2021, satya priya wrote:

> Add compatible string for pmk8350 rtc support.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>


If you add this before doing the yaml binding migration it might be
possible for the maintainer to merge the functional additions while
we're still trying to figure out the yaml...

Regards,
Bjorn

> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> index b4892f1..676decc 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> @@ -53,6 +53,7 @@ patternProperties:
>            - qcom,pm8921-rtc
>            - qcom,pm8941-rtc
>            - qcom,pm8018-rtc
> +          - qcom,pmk8350-rtc
>  
>        reg:
>          description: Specifies the base address of the RTC registers
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
