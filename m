Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACCE3ABDEE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhFQV2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:28:37 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:46916 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhFQV2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:28:36 -0400
Received: by mail-il1-f182.google.com with SMTP id i12so6620687ila.13;
        Thu, 17 Jun 2021 14:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=p45NMbcaVp4H9evUR08HW/+ZfqRoQVKi3z17BKOdh6c=;
        b=Vk7asWsd3856l7wS1T4f+miwEG3yDiIJg3niY2IHx6q23gtpzIke1nkuGkye9xW7D0
         6Y3xKOja+4XTQYNdqhgi4Obop5/1PKIc1ZxodF4eh+foiFGAEJjXGjgZP974VpZDjx/2
         tY7y6NkKIWsqB2BqnfmUi/KdIculA0h3cmzfqV63SIqWGn5JBw487kF4xdyMM0fK9zP2
         kx5NcGC3uysP3Awlo+c4yjfmw9GUiO+PJD9Igb4gZznRSXo/aPW3wgtCLQwIoiHG3rG7
         nPknGEP1fKBCs4nSviVsia1M4jT1As5g7JG0FKkFPD0mPXa8ksv/axSnSC6HWLfBGml4
         1C6Q==
X-Gm-Message-State: AOAM531SvG79uAdX5A0KCR7OJkMt46zXggP5Fwq+8y/zbYPqLxPrEbUM
        C1fFtVqWkzk/V3O2m7BVLw==
X-Google-Smtp-Source: ABdhPJwm3AS35eq/yoc+fK1o+R4mYlC3E5uJ1Rfsjp9EPZNVptpaddPf4yldQ69E3tTW7CyCyzsmPA==
X-Received: by 2002:a92:260b:: with SMTP id n11mr4925314ile.134.1623965187706;
        Thu, 17 Jun 2021 14:26:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q19sm82124ilc.70.2021.06.17.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:26:27 -0700 (PDT)
Received: (nullmailer pid 3336113 invoked by uid 1000);
        Thu, 17 Jun 2021 21:26:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, bicycle.tsai@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        cychiang@google.com, jiaxin.yu@mediatek.com, tiwai@suse.com,
        matthias.bgg@gmail.com
In-Reply-To: <20210617054740.8081-7-trevor.wu@mediatek.com>
References: <20210617054740.8081-1-trevor.wu@mediatek.com> <20210617054740.8081-7-trevor.wu@mediatek.com>
Subject: Re: [PATCH 6/8] dt-bindings: mediatek: mt8195: add audio afe document
Date:   Thu, 17 Jun 2021 15:26:24 -0600
Message-Id: <1623965184.501241.3336112.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 13:47:37 +0800, Trevor Wu wrote:
> This patch adds mt8195 audio afe document.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8195-afe-pcm.yaml        | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
./Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml:14:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sound/mt8195-afe-pcm.example.dts:19:18: fatal error: dt-bindings/clock/mt8195-clk.h: No such file or directory
   19 |         #include <dt-bindings/clock/mt8195-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/sound/mt8195-afe-pcm.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1493197

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

