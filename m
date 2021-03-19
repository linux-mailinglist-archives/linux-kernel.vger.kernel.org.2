Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E249B342825
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCSVts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:49:48 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:40733 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhCSVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:49:17 -0400
Received: by mail-io1-f54.google.com with SMTP id n21so7639851ioa.7;
        Fri, 19 Mar 2021 14:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=fkKLG/uVB75TRHpEJhq5M/a3yUCD2nHnE8bqwd4TUUE=;
        b=InhVwZ8EEn0UylNcmgNJth5LPzdN83o1rgGRn6x08C8iLuGlJRsp6M/yGP/4tyDW+9
         jI21oG6UpbXYifBIWR1qpu8JrZfF3Dvstut3n/2gkxDdTvz6LZ4IMn1VFjGGZEitQbP5
         tVlVfzNmfSKBUMZWHJvOo89tDXQyHcrPHzpR+5i1zRsvBNfqSqN1oscjEvTNrpiq0/YV
         z0QisH1pc9ndoYBz89lRB/+UewXQdYExDukyKlh34QVe5i0QuLCygMm49C/GNnYcuJLU
         3v1HR7gfXyhCN0TOLKSuHbnx96r6KXc2TkFSSFpp25H0PgjOyOZyKSHiICI3LlsGbiSF
         KHwA==
X-Gm-Message-State: AOAM531ZVCg3hfpGCC5qtHJ6+8VHF3KdX+TLvSL3D+7H81FVIGbkzIxW
        YTnXGwJzLcInX8ITvEr40r7p5XABNw==
X-Google-Smtp-Source: ABdhPJx6l5rWYKE3yxkxEjzt97f76s0cVjPiaDdBYIbG/3M1ZWeLln2M9CnGhJ/EYBEGw+I+SR4G6g==
X-Received: by 2002:a02:230d:: with SMTP id u13mr3113524jau.53.1616190556701;
        Fri, 19 Mar 2021 14:49:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d10sm3133370ila.47.2021.03.19.14.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:49:15 -0700 (PDT)
Received: (nullmailer pid 1647631 invoked by uid 1000);
        Fri, 19 Mar 2021 21:49:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     devicetree@vger.kernel.org, huangtao@rock-chips.com,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, kever.yang@rock-chips.com,
        finley.xiao@rock-chips.com, tony.xie@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        cl@rock-chips.com
In-Reply-To: <20210317025159.2248-3-zhangqing@rock-chips.com>
References: <20210317025159.2248-1-zhangqing@rock-chips.com> <20210317025159.2248-3-zhangqing@rock-chips.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: Convert the rockchip power_domain to YAML and extend
Date:   Fri, 19 Mar 2021 15:49:12 -0600
Message-Id: <1616190552.552444.1647630.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 10:51:58 +0800, Elaine Zhang wrote:
> This converts the rockchip power domain family bindings to YAML schema,
> and add binding documentation for the power domains found on Rockchip
> RK3568 SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/soc/rockchip/power_domain.txt    | 136 ------------
>  .../rockchip/rockchip,power-controller.yaml   | 196 ++++++++++++++++++
>  2 files changed, 196 insertions(+), 136 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml: $id: 'http://devicetree.org/soc/rockchip/rockchip,power-controller.yaml#' does not match 'http://devicetree.org/schemas/.*\\.yaml#'
./Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/soc/rockchip/rockchip,power-controller.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml: ignoring, error in schema: $id
warning: no schema found in file: ./Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
Error: Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.example.dts:32.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1454404

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

