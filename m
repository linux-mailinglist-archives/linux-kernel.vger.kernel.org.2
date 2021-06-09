Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CF63A1AB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 18:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbhFIQSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 12:18:50 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34473 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhFIQSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 12:18:49 -0400
Received: by mail-ot1-f54.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so21378633ott.1;
        Wed, 09 Jun 2021 09:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZGT8NJquSdH6KtVZ4l+/GumWl0Nge0pj1zfQnG0ePmI=;
        b=CaG/BrjLwyZoOCTcjKPpFPf8SbBlDJRrYYzH5yne/H0h3sYN5HTlshWGbT6JySufFw
         BTi+Hlh4fCIl8SbIGBnZrefHcqp8mubKtiVsACYGoW/yqO+m85tYwAqh3hzR9muRIft/
         y+WDyQxPUIzx1b9bxiYtwn9R7/ePzVF5zQW9rwgqfYoAV2Hrz8DgRUpCSdaPJ1Q5SyLC
         cmHc1KYvUFGhz7h9lJJhJrHzz0qqrx8xgcTgcdTjbL5sqnZRtVSYs81aDelnzK4Kyexv
         rk+SsUjxTqSklZ9w1MyJjYNeaA66hgdyc+xwF+hIg7LwVrja5hWAjPbO3dWZ6eYYDMfY
         y6lg==
X-Gm-Message-State: AOAM531kmcfzEIRWf7M9NOF5C0cGFu9SY+wgVt6OJvRxE7G9u5so7gDw
        mrJ2bXqm7dT2OVTBF3t8VE9t15u3Tg==
X-Google-Smtp-Source: ABdhPJwx20JacrP/HkOOmyVQLhIJvaerf0sB1n7gTBKsltZSgssSDfRDiaAlkWgtpw/1AbjRIWSNlA==
X-Received: by 2002:a9d:65cf:: with SMTP id z15mr181376oth.250.1623255414065;
        Wed, 09 Jun 2021 09:16:54 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t15sm54602oie.14.2021.06.09.09.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:16:53 -0700 (PDT)
Received: (nullmailer pid 3763294 invoked by uid 1000);
        Wed, 09 Jun 2021 16:16:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     maoguang.meng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, yong.wu@mediatek.com
In-Reply-To: <20210609104053.617751-1-hsinyi@chromium.org>
References: <20210609104053.617751-1-hsinyi@chromium.org>
Subject: Re: [PATCH] dt-bindings: mediatek: convert mtk jpeg decoder/encoder to yaml
Date:   Wed, 09 Jun 2021 11:16:43 -0500
Message-Id: <1623255403.610773.3763293.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jun 2021 18:40:54 +0800, Hsin-Yi Wang wrote:
> Convert mediatek jpeg decoder and encoder bindings to yaml.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> mediatek,larb in the original file will be removed after this series[1]
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20210410091128.31823-2-yong.wu@mediatek.com/
> ---
>  .../bindings/media/mediatek-jpeg-decoder.yaml | 73 +++++++++++++++++++
>  .../bindings/media/mediatek-jpeg-encoder.yaml | 65 +++++++++++++++++
>  2 files changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml:23:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.example.dts:23.25-26 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1489789

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

