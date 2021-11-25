Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9538645E26B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbhKYVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:31:18 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33611 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbhKYV3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:29:17 -0500
Received: by mail-oi1-f169.google.com with SMTP id q25so15039484oiw.0;
        Thu, 25 Nov 2021 13:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=4t8ocAbb9RSagDUoAU33jv1dklB0bRzIRuKEQG6jgJE=;
        b=CRs33wTXae0ndWXMuCv/Fc5mAY2+BVKfPvR0GF95wBAUzwQAdSxVGv19spBQp16Qnm
         ssImvU3AdYJcXx98tMQsBuBCTSdvUhmsgvA8dGdGAY9rILF8FtHokvnmDZsk15sPFMxY
         FZOvUFsPubvCaeHt/JyX9IUnxfYpvyNFkIf5dhk8DNcPO8irS8FtVtoqMH4KMfwWpvI/
         f/hYRQVEiBK/vvTw41PlxR1/vd35o4oww7K8FWiibaKN/VTkOeWBy4Hi8lXz8Wk3E5Rt
         U6/6ZZQ9/vEyKAf/saJoDmLkBcSk3q0obF0Jr1kCYam5kVpqotXZa9byBEBfBkuWt9Id
         4+sw==
X-Gm-Message-State: AOAM531aUG6/sangxRjh1RVw/L+lD7Q84REm9RhAi/ZM7ODbZ7V0H/qT
        pveNZlY+m11dDtWjMy0Vf0MgCG9PjA==
X-Google-Smtp-Source: ABdhPJx4vDUvwnCthNffPUNKpAhfHsE4MMgasd0FAy5ggI+9jiyrNxdsNn69r11sgn5fQ53/Iy64ug==
X-Received: by 2002:a05:6808:d1:: with SMTP id t17mr18565416oic.161.1637875565229;
        Thu, 25 Nov 2021 13:26:05 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bg38sm946554oib.40.2021.11.25.13.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 13:26:04 -0800 (PST)
Received: (nullmailer pid 2858304 invoked by uid 1000);
        Thu, 25 Nov 2021 21:26:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20211124084620.628-3-caihuoqing@baidu.com>
References: <20211124084620.628-1-caihuoqing@baidu.com> <20211124084620.628-3-caihuoqing@baidu.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: staging: Add the binding documentation for ZHOUYI AI accelerator
Date:   Thu, 25 Nov 2021 14:26:02 -0700
Message-Id: <1637875562.214167.2858303.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 16:46:16 +0800, Cai Huoqing wrote:
> ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
> such as Allwinner R329 SOC.
> Add the binding documentation for ZHOUYI AI accelerator.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  .../bindings/staging/arm,zynpu.yaml           | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/arm,zynpu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/staging/arm,zynpu.example.dts:23.28-32.15: Warning (unit_address_format): /example-0/soc/zynpu@03050000: unit name should not have leading 0s

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1558953

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

