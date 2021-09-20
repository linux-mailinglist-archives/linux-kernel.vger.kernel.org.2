Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528254129B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 02:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbhIUADY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 20:03:24 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45603 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245362AbhIUABX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 20:01:23 -0400
Received: by mail-ot1-f48.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso25888818otv.12;
        Mon, 20 Sep 2021 16:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EPn9nNxZV6jBcv30FwIswDGQiCPMJkxAR3OPFjs7bc8=;
        b=pd6+7+WtEYO5VN2pdDt1Yy+nWG1zPE4X9IU+DbQFh86kCZQ7Lji24eubBffZ4hiA+S
         VR0ua4M27OnDFYA3p4OrSX0eq9XPybjn5dRqHiMM7OJPeq/5SNsrLz57k9RnYc5q2QMX
         vkWQAWwxg+x97RN9w55h0fG5YPieQbGrPywHQUJoQFAvt3G3d1O41qEEMcpGkhdHUVy9
         jLCoVX+0pAh4dbFJdpjXjeAjQHMw4gZ+ieNDkfzcBaVX2fKXLOav+bpRGE4IU8Qljqc+
         mu7yY83JWI/dLz772GhbjnwXT3Dp44iJluEMX3uauH9A+xr+BZoNxNLLi3NGDYabxQoo
         d3fA==
X-Gm-Message-State: AOAM53300/nFtUCjukUaQPwrpdMBrE6geVENKOy3h3QFyuwNiHcwP029
        SHdZ+1cFtP9sV+41fJ3olw==
X-Google-Smtp-Source: ABdhPJwUMGNPaGIricjINVuyeYjR8PrMjEMI03ragheL8E6tT4HBsAluE3ijRo+w44fKWnEhQqAGjw==
X-Received: by 2002:a05:6830:19d2:: with SMTP id p18mr23766211otp.250.1632182395309;
        Mon, 20 Sep 2021 16:59:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j4sm2472214oia.56.2021.09.20.16.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:59:54 -0700 (PDT)
Received: (nullmailer pid 1075561 invoked by uid 1000);
        Mon, 20 Sep 2021 23:59:53 -0000
Date:   Mon, 20 Sep 2021 18:59:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/5] dt-bindings: arm: airoha: Add binding for EN7523
 SoC and EVB
Message-ID: <YUkgeedFfKnod288@robh.at.kernel.org>
References: <20210908141606.136792-1-bert@biot.com>
 <20210908141606.136792-3-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908141606.136792-3-bert@biot.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 04:16:03PM +0200, Bert Vermeulen wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add devicetree binding for Airoha EN7523 SoC and evaluation board.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  .../devicetree/bindings/arm/airoha.yaml       | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/airoha.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/airoha.yaml b/Documentation/devicetree/bindings/arm/airoha.yaml
> new file mode 100644
> index 000000000000..f2661ba81109
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/airoha.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/airoha.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha SoC based Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Felix Fietkau <nbd@nbd.name>
> +  - John Crispin <john@phrozen.org>

Blank line.

> +description: |

Don't need '|' here.

> +  Boards with an Airoha SoC shall have the following properties.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:

Don't need oneOf with only 1 entry.

> +      - items:
> +          - enum:
> +              - airoha,en7523-evb
> +          - const: airoha,en7523
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.25.1
> 
> 
