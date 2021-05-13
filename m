Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F324737F153
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 04:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhEMC3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 22:29:42 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36719 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhEMC3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 22:29:20 -0400
Received: by mail-ot1-f45.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso22485889otn.3;
        Wed, 12 May 2021 19:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WM3wqjbZ0uWUsYgTc6vUqFiP5RXGtVRH28XdkWq9dp0=;
        b=Jd9sPSELLL0Zi/K5cv7w1i3o+v7bG5I6mwet6D1AS+6dMDdqDZk/MP97p2j7fepYTl
         C98JAz+f/irjjGEb7P8ZbKN26CbDIGA7vFPXjBn8UH8xorl2TfIKCXYcCN5cPBpnJSzi
         uhDhAU0Uw1/JPkIinlV+vVZbMxigF1VgFAFqeH7plL0/tzUHnpfi3QXMDquaDPBEbYWz
         osv+uhNEU27/b+ro7c5AdTy5pTg0chIORzidAIyk4C+nfy3gfl/j/fsFcOfh29X9pRLU
         +1W19yq67y9ALYiak7s1R1aNR2xQfcjgeF2wJXz7jZwm519DMGpMLx/qPDhIni9QD4cU
         BkxQ==
X-Gm-Message-State: AOAM532XILAvbH34IEHXNXRTJP6ayR6qt9aQzZhQEzSKU/6iR0v6gBKN
        GSNL69O9DVrvs/WPmu3JIQ==
X-Google-Smtp-Source: ABdhPJzDrlevnOEgIPO65TeRK+k0GXi9QHGUAlJ5o92znRn3uqMrp3SjO26UMzEtCS+trS7DZGXSsg==
X-Received: by 2002:a9d:1ac:: with SMTP id e41mr33575541ote.166.1620872891436;
        Wed, 12 May 2021 19:28:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h9sm386817otn.56.2021.05.12.19.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 19:28:10 -0700 (PDT)
Received: (nullmailer pid 908108 invoked by uid 1000);
        Thu, 13 May 2021 02:28:09 -0000
Date:   Wed, 12 May 2021 21:28:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, huangtao@rock-chips.com,
        cl@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        jay.xu@rock-chips.com, heiko@sntech.de, david.wu@rock-chips.com,
        linus.walleij@linaro.org, zhangqing@rock-chips.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        robh+dt@kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 2/4] dt-bindings: soc: rockchip: convert grf.txt to
 YAML
Message-ID: <20210513022809.GA907945@robh.at.kernel.org>
References: <20210512122346.9463-1-jbx6244@gmail.com>
 <20210512122346.9463-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512122346.9463-3-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 14:23:44 +0200, Johan Jonker wrote:
> Current dts files with 'grf' nodes are manually verified.
> In order to automate this process grf.txt has to be
> converted to YAML.
> 
> Most compatibility strings are in use with "simple-mfd" added.
> 
> Changed compatibles:
> "rockchip,rk3066-grf", "syscon", "simple-mfd"
> "rockchip,rk3188-grf", "syscon", "simple-mfd"
> 
> Add description already in use:
> "rockchip,rv1108-pmugrf", "syscon"
> 
> Add new descriptions for:
> "rockchip,rk3568-grf", "syscon", "simple-mfd"
> "rockchip,rk3568-pmugrf", "syscon", "simple-mfd"
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V5:
>   changed compatibles for rk3066/rk3188
>   add rockchip-usb-phy.yaml
> 
> Changed V4:
>   revert separate schemas for each 'if' subset
>   add additionalProperties
>   move properties to top level
> 
> Changed V3:
>   remove select
>   change unevaluatedProperties
>   add separate schemas for each 'if' subset
> 
> Changed V2:
>   add rockchip,rk3328-grf-gpio.yaml
>   rename grf-gpio nodename
> ---
>  .../devicetree/bindings/soc/rockchip/grf.txt       |  61 -----
>  .../devicetree/bindings/soc/rockchip/grf.yaml      | 260 +++++++++++++++++++++
>  2 files changed, 260 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
