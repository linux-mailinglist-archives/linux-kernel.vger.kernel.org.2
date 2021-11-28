Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4C7460B23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 00:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359695AbhK1XfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 18:35:01 -0500
Received: from mail-oo1-f46.google.com ([209.85.161.46]:37476 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhK1Xc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 18:32:59 -0500
Received: by mail-oo1-f46.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so5156867oov.4;
        Sun, 28 Nov 2021 15:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iJyhW1L5R24znXoEb4+7/BuxahWzHXAL1Wi9Y3yNAR0=;
        b=61YMd7p+M0m9/ziTjC95r6VD/uXG5+UFc9Xt21JuztG758Q06T0YCNX0iiaL0AIZgJ
         PzWECDjkQm9BK/2hFDMqFhll48m6bvRfUgtqqMdNJMieh4xvpOE/9TvzmETeAI731zk4
         eTyiX0fGEa3Z9a5Nc7o/ws5ZRV+36f4jzCn/eKZDZqxezT1i58TbsH2eIHgiutKyJBIh
         mBptEBAEpFGwdmF8eDw/ZR2E95yFvsPiHBWh5s+6NxyWg35gijF5FXXMAsRLBD6EDCpf
         ZDUftgbA3+f4v5v+aUbaR8TTM//kFNG8MdIv3KkHcag6emhhEoMHDTiAdPkVskkvVgYJ
         AvwQ==
X-Gm-Message-State: AOAM532Dxkyafv2xswvjlrq2VUO7/kkqVDD8sa6/xzlhVNDpXI03xHJn
        B0kze9cuTuyLfgCMeSAf4Q==
X-Google-Smtp-Source: ABdhPJzZZpA2h5KHrp4M77mN1fZf1onBneqDYgimjoLpYH1mR/W2yBruVKSOXa2MlYdjnGAyOQaknA==
X-Received: by 2002:a4a:dd93:: with SMTP id h19mr29084584oov.73.1638142182602;
        Sun, 28 Nov 2021 15:29:42 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fe7:4487:4f99:dbc0:75d1:3e27])
        by smtp.gmail.com with ESMTPSA id d3sm2361708otc.0.2021.11.28.15.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 15:29:42 -0800 (PST)
Received: (nullmailer pid 2816751 invoked by uid 1000);
        Sun, 28 Nov 2021 23:29:39 -0000
Date:   Sun, 28 Nov 2021 17:29:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-arm-kernel@lists.infradead.org,
        John Crispin <john@phrozen.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/12] dt-bindings: arm: airoha: Add binding for
 EN7523 SoC and EVB
Message-ID: <YaQQ4+zfuIKiAM5e@robh.at.kernel.org>
References: <20211125110738.41028-1-nbd@nbd.name>
 <20211125110738.41028-3-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125110738.41028-3-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:07:28PM +0100, Felix Fietkau wrote:
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

blank line

> +description: |

Don't need '|' if no formatting to preserve.

> +  Boards with an Airoha SoC shall have the following properties.
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - airoha,en7523-evb
> +          - const: airoha,en7523
> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.30.1
> 
> 
