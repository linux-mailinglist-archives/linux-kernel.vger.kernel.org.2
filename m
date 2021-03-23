Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700C73469B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhCWURO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:17:14 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:38497 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbhCWUQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:16:54 -0400
Received: by mail-io1-f42.google.com with SMTP id e8so19104834iok.5;
        Tue, 23 Mar 2021 13:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=D9YiSRrs2fw2afTTENd+WaQd259uaLT3vYO3ElQUi/o=;
        b=CO3s8OO5CtktsyREBpaneUIqmKQ3gTML2mTN2JjQtvlbnyT8Iwje10XIrlUzKlbJzE
         VuuezY2eKtFLN8ePMALEHNcXek+i2owOvcsmbyb4ePL+ND93P5E/eRi0R0+BjKrTv4bw
         Y7ZHmv9D699CJ+4nyBx77rgB9HwnhWZZ2IEmTmhHca/ZdTuf2aaoHs/RAdcuUi5L9pTT
         Clb6IzZDL9WOYzrJ1G+VY7cqcfIs8uw3doK7GYIoh5TGlo+jPWvx8ibVNFyMkGLPb/N8
         P5aiZhWzooFnUZzTN6Xq2A5SLArOO9rkWhUyLjEgNDoBvwBzSAiKv5BYd3qx3r6eU5jc
         eJzg==
X-Gm-Message-State: AOAM5308HGEfpoba3xOOFePvCR5ShKsnwzXeG2TRfSSW9A4SZ2YMOxow
        3wvOkYb/niRaPDaptsAkHA==
X-Google-Smtp-Source: ABdhPJzYfWvKVsiIzkecMWnD+0zHO4VuZZq2JJwNcfzKfx/OWaPuu2kWkkJaoJm/v/G2sBf3SkCcqA==
X-Received: by 2002:a05:6638:2209:: with SMTP id l9mr6114752jas.13.1616530613847;
        Tue, 23 Mar 2021 13:16:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g14sm9384335ioc.38.2021.03.23.13.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:16:53 -0700 (PDT)
Received: (nullmailer pid 1244767 invoked by uid 1000);
        Tue, 23 Mar 2021 20:16:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     tony.xie@rock-chips.com, huangtao@rock-chips.com, heiko@sntech.de,
        linux-kernel@vger.kernel.org, finley.xiao@rock-chips.com,
        kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, cl@rock-chips.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210323082410.22818-3-zhangqing@rock-chips.com>
References: <20210323082410.22818-1-zhangqing@rock-chips.com> <20210323082410.22818-3-zhangqing@rock-chips.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: Convert the rockchip power_domain to YAML and extend
Date:   Tue, 23 Mar 2021 14:16:47 -0600
Message-Id: <1616530607.412616.1244766.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 16:24:09 +0800, Elaine Zhang wrote:
> This converts the rockchip power domain family bindings to YAML schema,
> and add binding documentation for the power domains found on Rockchip
> RK3568 SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
>  .../rockchip/rockchip,power-controller.yaml   | 259 ++++++++++++++++++
>  2 files changed, 259 insertions(+), 136 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.example.dts:19:18: fatal error: dt-bindings/clock/rk3568-cru.h: No such file or directory
   19 |         #include <dt-bindings/clock/rk3568-cru.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.example.dt.yaml] Error 1
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1457096

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

