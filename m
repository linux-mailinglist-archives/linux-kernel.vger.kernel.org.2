Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5509C3348D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhCJUXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhCJUWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:22:47 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877FBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:22:47 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u6so13221591oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 12:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D8SkSZfMGXJVIfaUeTUQvpEkKL8sz28snPjNoCNenZw=;
        b=qpWz1LjPnx1hSMJDBB6JANgDDazEE0rhaF7aZ5rQOkzH+3UH7AM6sZeWEm4dNvhJ+5
         S9RISrPfsCXsBQW5BgyNPEubQ9XPzeiKeQQP7fIWldv4M/MuLyoLJ+H6W0Q+fruqen8q
         FGgsIFz9M5VU/kq3rZU7r4Y/e8vgLqLVdtXZBtKVWkULiuPl9mb9joJpuvLKsTHIyZZg
         VS9QrdlK6GotbQH6rFMZ0/4lNYrS4yEtdmTNC0IQQhGT0vUA6b1DT10ujkzFE7S9nByO
         fNt5sqo2DSVLhM8kcoWC1bDhY4wBJKjrEF+QRXvAtTlUj85jxIcJEr39573JvVbNEPGj
         glEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8SkSZfMGXJVIfaUeTUQvpEkKL8sz28snPjNoCNenZw=;
        b=FuR0pjPTQdYMVueyTD7yowofu0IcGfti5eJj6Q2f7+Pb10JhQd0FI11bAYIJ9VLyCT
         xR4iqACKWhh5grXgy7RlW4XUxWUYfi3ors4iHil/Db53YofiUutFrj0usePDXSZLBji3
         ZE9So/seOqd0+SqVQamf9rX9xrkq3JVe96o2F8+UTiA1y5omYpQ2qilz2r14SQeh75s9
         BO5djrrslo67t5jyFcRadEWZOLCI0NMSQ02QnZgkh7qciDp0HEDWhE7ZV+iZ+QiQFQW1
         cvLzqmjweR1RY8H12uwYt31hnWYutv4V1XeL2dhyubGXhPtYb+8fIzxMhJGP5oS2frWM
         k4RQ==
X-Gm-Message-State: AOAM531Wa7n7c8UDnK7up/SYBE8koQtZho/f0qFnhY9I2KIafFLn1FTd
        SK+X4iKmDlnvZEq4j1aqPsYVIA==
X-Google-Smtp-Source: ABdhPJwuhQf/CiQdQHwfndVeox8BnSom2fzRXWd5x+FWfd7FNm2K7HDiZpZA43HCAyWedtQrMYAtsA==
X-Received: by 2002:a05:6808:10d3:: with SMTP id s19mr3709652ois.70.1615407766960;
        Wed, 10 Mar 2021 12:22:46 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v66sm174506otb.16.2021.03.10.12.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 12:22:46 -0800 (PST)
Date:   Wed, 10 Mar 2021 14:22:44 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Souradeep Chowdhury <schowdhu@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        sibis@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, vkoul@kernel.org
Subject: Re: [PATCH V1 1/6] dt-bindings: Added the yaml bindings for DCC
Message-ID: <YEkqlIuphaEe3+8h@builder.lan>
References: <cover.1615393454.git.schowdhu@codeaurora.org>
 <e33318b1b216bb0cb0a854e8d9cdd18dd5faca97.1615393454.git.schowdhu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33318b1b216bb0cb0a854e8d9cdd18dd5faca97.1615393454.git.schowdhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10 Mar 10:46 CST 2021, Souradeep Chowdhury wrote:

> Documentation for Data Capture and Compare(DCC) device tree bindings
> in yaml format.
> 
> Signed-off-by: Souradeep Chowdhury <schowdhu@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> new file mode 100644
> index 0000000..b8e9998
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/msm/qcom,dcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Data Capture and Compare
> +
> +maintainers:
> +  - Souradeep Chowdhury <schowdhu@codeaurora.org>
> +
> +description: |
> +    DCC (Data Capture and Compare) is a DMA engine which is used to save
> +    configuration data or system memory contents during catastrophic failure
> +    or SW trigger. DCC is used to capture and store data for debugging purpose
> +
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,sm8150-dcc
> +      - const: qcom,dcc
> +
> +  reg:
> +    items:
> +      - description: DCC base register region
> +      - description: DCC RAM base register region
> +
> +  reg-names:
> +    items:
> +      - const: dcc-base
> +      - const: dcc-ram-base

Please omit the "-base" suffix from the reg-names.

Regards,
Bjorn

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dcc@10a2000{
> +                compatible = "qcom,sm8150-dcc","qcom,dcc";
> +                reg = <0x010a2000  0x1000>,
> +                      <0x010ad000  0x2000>;
> +                reg-names = "dcc-base", "dcc-ram-base";
> +    };
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
