Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5989F45A803
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbhKWQiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:38:04 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:43922 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhKWQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:38:02 -0500
Received: by mail-io1-f43.google.com with SMTP id z26so28656739iod.10;
        Tue, 23 Nov 2021 08:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=tTDqJqEpn3lJVr9hvHIdnLnM0QZTa6cWxZTxlXqyveI=;
        b=k7LHsX6aQ2eCWCZZfFAgueDjw/g6pwpeBHA0RRogSlpBJYnjXpGZlU1we7qdN3PQ5+
         MBm5TLreto7pzWemVA8GD6F31MGI6RKGLZo6qkg163Fp7mOrG5CxmLiKpvoRvFBMq9tE
         zb+ODZGOV0zyLIAXTCNdiqyLibXZjIAfva1WSGL2k+FD+kWg3qelwdhRBEv7xG9/3Afu
         rcHit2zaxdyDK0/7anSww/ug+ThmCuhqDL47cP7BcBWR12SsTa22nfKZ+azSsA7e9Hc7
         PHL8JBtUz8ZbHyIcCaqkGwNwqwot/I/IfzjMfoDCqH4YWJ6lbM0XVjz45XnPBT/c677C
         nh3A==
X-Gm-Message-State: AOAM530/0jkfJZxj9uS44+dDy5L0j6nEVrrDy8haCJjp8sdX8gXhZScT
        KdCLA8o1sYW7KFU01giRkA==
X-Google-Smtp-Source: ABdhPJzpKxUJnoCa0cAVi7P8tqEKN9cFnfuz6QPVzyOgjxBNvvRZQNUJPZWW6WEKX50SRbXuuf9lzg==
X-Received: by 2002:a02:cc29:: with SMTP id o9mr7751315jap.116.1637685293477;
        Tue, 23 Nov 2021 08:34:53 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o22sm8929890iow.52.2021.11.23.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:34:52 -0800 (PST)
Received: (nullmailer pid 3442912 invoked by uid 1000);
        Tue, 23 Nov 2021 16:34:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     tfiga@chromium.org, - <devicetree-spec@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, senozhatsky@chromium.org,
        iommu@lists.linux-foundation.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20211123112104.3530135-3-hsinyi@chromium.org>
References: <20211123112104.3530135-1-hsinyi@chromium.org> <20211123112104.3530135-3-hsinyi@chromium.org>
Subject: Re: [PATCH 2/3] dt-bindings: Add io-tlb-segsize property for restricted-dma-pool
Date:   Tue, 23 Nov 2021 09:34:29 -0700
Message-Id: <1637685269.659918.3442911.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 19:21:03 +0800, Hsin-Yi Wang wrote:
> Add a io-tlb-segsize property that each restricted-dma-pool can set its
> own io_tlb_segsize since some use cases require slabs larger than default
> value (128).
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../bindings/reserved-memory/shared-dma-pool.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml: properties:io-tlb-segsize:type: 'anyOf' conditional failed, one must be fixed:
	'u32' is not one of ['array', 'boolean', 'integer', 'null', 'number', 'object', 'string']
	'u32' is not of type 'array'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml: properties:io-tlb-segsize:type: 'u32' is not one of ['boolean', 'object']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml: ignoring, error in schema: properties: io-tlb-segsize: type
warning: no schema found in file: ./Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
Documentation/devicetree/bindings/display/msm/gpu.example.dt.yaml:0:0: /example-1/reserved-memory/gpu@8f200000: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.example.dt.yaml:0:0: /example-0/reserved-memory/linux,cma: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.example.dt.yaml:0:0: /example-0/reserved-memory/restricted-dma-pool@50000000: failed to match any schema with compatible: ['restricted-dma-pool']
Documentation/devicetree/bindings/dsp/fsl,dsp.example.dt.yaml:0:0: /example-1/vdev0buffer@94300000: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dt.yaml:0:0: /example-0/reserved-memory/dsp-memory@98000000: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dt.yaml:0:0: /example-1/reserved-memory/ipu-memory@95800000: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.example.dt.yaml:0:0: /example-2/reserved-memory/dsp1-memory@99000000: failed to match any schema with compatible: ['shared-dma-pool']
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dt.yaml:0:0: /example-0/reserved-mem@52800000: failed to match any schema with compatible: ['shared-dma-pool']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1558503

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

