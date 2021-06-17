Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C223ABDF2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 23:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhFQV2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 17:28:45 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:36760 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhFQV2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 17:28:44 -0400
Received: by mail-io1-f41.google.com with SMTP id s19so4764385ioc.3;
        Thu, 17 Jun 2021 14:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=5eq4f8x/PBXQ0L0KWI8lbvRWrLgR98TD03TAWNAHP0I=;
        b=RLZ8baUGn3mMwxscg1PB4BmaGhW+cpemNE1WAt9OhJkJbgRix9er3lhRYjV++OlFc5
         16Q4XoGuY2VSFyi1P9yIjk1DmLB0bpvkDcablA71OWY9n7WyRzyzyl/WihnCcJ/mgPCo
         pigiczyNJXa14brZKgfNITY0pUp4cpcQMWG4QkBOR0EgNA4SybRxE7td+vYP0t8RAfSX
         Y6vUnVjMU8d6YyCZmE6c4+85/qVDxi8XmtoZHx/uN5tCLtWYAIV69xWcm6ysdnzT+Gog
         mi2L7pJXaZ8P9XwTnUBfp8giVeeJ7Yh1sMJ2810C0VN71djsEPJNmaiVo8UZ9EVXNQ1A
         JEOw==
X-Gm-Message-State: AOAM533yAqzqXIDCK/lieo0xl7Ns9/XyguEFnhAw/8A084qA7ol6Zrmb
        lAUQjnRA3Fhqu3I1PRQXzQ==
X-Google-Smtp-Source: ABdhPJzKYftIYW1nBl+6hxGS0Ti9h9zAzlQz9WsWpBDeaZqwQntNxz3ul/G3t+wNmMg4w6xTU/xNXw==
X-Received: by 2002:a05:6602:581:: with SMTP id v1mr5561875iox.192.1623965195650;
        Thu, 17 Jun 2021 14:26:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 6sm3685511ioe.43.2021.06.17.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 14:26:35 -0700 (PDT)
Received: (nullmailer pid 3336117 invoked by uid 1000);
        Thu, 17 Jun 2021 21:26:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, cychiang@google.com, tiwai@suse.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, jiaxin.yu@mediatek.com,
        bicycle.tsai@mediatek.com
In-Reply-To: <20210617054740.8081-9-trevor.wu@mediatek.com>
References: <20210617054740.8081-1-trevor.wu@mediatek.com> <20210617054740.8081-9-trevor.wu@mediatek.com>
Subject: Re: [PATCH 8/8] dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1019-rt5682 document
Date:   Thu, 17 Jun 2021 15:26:24 -0600
Message-Id: <1623965184.524304.3336116.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 13:47:39 +0800, Trevor Wu wrote:
> This patch adds document for mt8195 board with mt6359, rt1019 and rt5682
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../sound/mt8195-mt6359-rt1019-rt5682.yaml    | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
./Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml:17:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.example.dt.yaml:0:0: /example-0/mt8195-sound: failed to match any schema with compatible: ['mediatek,mt8195-sound']
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1493198

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

