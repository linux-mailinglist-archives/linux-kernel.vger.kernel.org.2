Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A04351E68
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbhDASlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239537AbhDASQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:36 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FFC031176;
        Thu,  1 Apr 2021 10:08:22 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso2804560otp.0;
        Thu, 01 Apr 2021 10:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v1CvosrFQKNygk9iPp7GICKpxnzjtFNAnQPCNVGqrl0=;
        b=nUFN5VDLYQQFUp8ArIWsB5HpnTrc9LOR1XMhauLTxNbHsfFVkCaCR3Q37AzFtIDxOy
         0FyLnVQtPFa+tQiKoNcxF8CtX/PktYqKGyJ5FUOPE4A1g6VfJuJEXYILS7ijTgmHcMV7
         uw8juXhSX5N3rzHZy0U1qPBp2Tm8jjDQmuS1IDnQHTxcdGVZdQe3/2syJ4r35DG1SY3R
         Kauh0TR92LJCKKumh8nNJotOqYndkrUO8HYNvZhUnIKME5LnYsjP8blMkMtOANBGhm3h
         98e2Gm1pgH5/4UChNtztSkbWe7CitnuEXk3IMGSl2sBSNiXYe+y84QTzx3otY9kedres
         iGNA==
X-Gm-Message-State: AOAM531bm8B6kPRrwnK3ABvGTLxGXiTg1HEVvxQQKVFiDTr7o95mjxgZ
        uTF6E4eU5AkRaOVYAZXyuw==
X-Google-Smtp-Source: ABdhPJznlqY3GZ+uckg8+w2KWwohxH+Kgi2cfwaRzEej6nKtI5cTKS3z+5FX87q2Akc1J/otBJ8mlQ==
X-Received: by 2002:a05:6830:2050:: with SMTP id f16mr7397558otp.182.1617296899631;
        Thu, 01 Apr 2021 10:08:19 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h18sm1178721oov.43.2021.04.01.10.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:08:18 -0700 (PDT)
Received: (nullmailer pid 621699 invoked by uid 1000);
        Thu, 01 Apr 2021 17:08:18 -0000
Date:   Thu, 1 Apr 2021 12:08:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: soc: actions: Add Actions Semi Owl
 socinfo binding
Message-ID: <20210401170818.GB610119@robh.at.kernel.org>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <15da0257b10aa62bfb7046437915d05a614c01ee.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15da0257b10aa62bfb7046437915d05a614c01ee.1617110420.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:48:17PM +0300, Cristian Ciocaltea wrote:
> Add devicetree binding for the Actions Semi Owl socinfo driver.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  .../bindings/soc/actions/owl-socinfo.yaml     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> new file mode 100644
> index 000000000000..01e4a8b4f5ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/actions/owl-socinfo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl SoC info module
> +
> +maintainers:
> +  - Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> +
> +description: |
> +  Actions Semi Owl SoC info module provides access to various information
> +  about the S500, S700 and S900 SoC variants, such as serial number or id.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - actions,s500-soc
> +          - actions,s700-soc
> +          - actions,s900-soc
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - actions,s500-soc
> +          - actions,s700-soc
> +          - actions,s900-soc
> +      - const: simple-bus
> +
> +required:
> +  - compatible
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    / {
> +        compatible = "roseapplepi,roseapplepi", "actions,s500";
> +        model = "Roseapple Pi";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        soc {
> +            compatible = "actions,s500-soc", "simple-bus";

What's the actual h/w for this bus? Still looks like abuse of DT to 
create your virtual soc_info driver.

> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges;
> +        };
> +    };
> +
> +...
> -- 
> 2.31.1
> 
