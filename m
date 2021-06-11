Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2023A482A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFKR5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:57:37 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:37426 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFKR5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:57:36 -0400
Received: by mail-io1-f45.google.com with SMTP id q7so32097491iob.4;
        Fri, 11 Jun 2021 10:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=GhKdnmG1yoizS3pbpaYv+va/QoVsK+02BeSi6TEeUTM=;
        b=RBZCpW1DzAS9c5zu3M41JpW6vrVEWUH7d5m+bPssKfc213HSugJe2fCpd1K3uIYRHa
         WML8LZoTpauJfKMgQ+ZrsjQnuOkatrjU5gwyPu7RLeYrjMvvL1/XGhUyJ/jNhQzznSc4
         NQ+jD7ivsXTn3FrLx+S7cJ0KlqRCduIeGZ+RsuKn2oGpuNoeHPEMXjZ+msvZb0wxN4Cf
         JyTqZc4q8JnU+2B1km6j3Bv/D0qySuc/26sLdxbWpobA2Tq1QOnpBt7nY6efxUeFcytB
         oKfphjURdKFSBnXBSpMzSnaTyPfWV7PrLYUy/RA2F3bWXHACwYlM3ayIcKuGQUqehKyY
         uihQ==
X-Gm-Message-State: AOAM532KtExKFVBB4Rklmd9lTIFIGzlT6MvcvsWT1zBrLani/JEhusHW
        M0kITSLBfN56DgmYmNrxxw==
X-Google-Smtp-Source: ABdhPJxEbCBQmiSq6AHrgssN4FV0oH72srYnZQkN+Cl5siXxMrk0oag94/p2zTbOs2Ggbqg9LxkD6A==
X-Received: by 2002:a02:a318:: with SMTP id q24mr4962093jai.100.1623434138203;
        Fri, 11 Jun 2021 10:55:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j12sm4251068ils.42.2021.06.11.10.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:55:37 -0700 (PDT)
Received: (nullmailer pid 1208940 invoked by uid 1000);
        Fri, 11 Jun 2021 17:55:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        maoguang.meng@mediatek.com, linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        yong.wu@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210611112009.2955944-1-hsinyi@chromium.org>
References: <20210611112009.2955944-1-hsinyi@chromium.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: mediatek: convert mtk jpeg decoder/encoder to yaml
Date:   Fri, 11 Jun 2021 11:55:33 -0600
Message-Id: <1623434133.955843.1208939.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 19:20:07 +0800, Hsin-Yi Wang wrote:
> Convert mediatek jpeg decoder and encoder bindings to yaml.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v3->v4: split adding mt8183 into another patch
> ---
>  .../bindings/media/mediatek-jpeg-decoder.txt  | 38 ---------
>  .../bindings/media/mediatek-jpeg-decoder.yaml | 85 +++++++++++++++++++
>  .../bindings/media/mediatek-jpeg-encoder.txt  | 35 --------
>  .../bindings/media/mediatek-jpeg-encoder.yaml | 76 +++++++++++++++++
>  4 files changed, 161 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:

\ndoc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml references a file that doesn't exist: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
Warning: Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml references a file that doesn't exist: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
MAINTAINERS: Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt

See https://patchwork.ozlabs.org/patch/1490913

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

