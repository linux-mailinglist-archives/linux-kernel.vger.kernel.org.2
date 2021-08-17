Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91953EF1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhHQSS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:18:28 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:38691 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhHQSSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:18:25 -0400
Received: by mail-oo1-f50.google.com with SMTP id m11-20020a056820034b00b0028bb60b551fso2012091ooe.5;
        Tue, 17 Aug 2021 11:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=DLWFI+GPG5JMvw8QB510k7IFEr+jZGWWgLmkQQbrRKo=;
        b=IiELC0NUrVbZ1yR7x8rchS6WGn82lWLNHWPpOm6V3gdlSB/zPHQZY8Ey/blCZ8u6fe
         sCrPUP1Uyb9fTps4AFjd1oq57806VE3iy3ueQnm2i9akd4boCb2lkbf8GjoKtyV2UUHW
         bRBu1xzjMf9+rEf/gOzIeO4FjL6MWwpUvGOx27fOIqea94ehoTOICjg8oYVVmO5u+9jf
         s+HnTcbqgYG2C4c3eP2of8okM410Kf48LWNMNf4IZkKwTlVDl2ZQTLC0Pq79xedcytQw
         3rfRXYcEF4mLOhe68r6ITuOayZmYML1S4pSwLCR0i8Zv7/owEWo/mF62WrniGU4HOYWf
         F4WQ==
X-Gm-Message-State: AOAM532WNNdNX0lEpXo6h5MVRGaraOXyS/yn9xq9Zs6axyn8C9VkgIq1
        7ME4FuCQQtX7QOVEWJrDYg==
X-Google-Smtp-Source: ABdhPJxKzWPRH2R4lMGCh2vpZEkEho1oQHFMv1Kw1X5iQCV+eQQriQ5tWlVqpdSC0eCYWsRUHu3sEw==
X-Received: by 2002:a4a:e874:: with SMTP id m20mr3537958oom.29.1629224272205;
        Tue, 17 Aug 2021 11:17:52 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e2sm526769otk.14.2021.08.17.11.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:17:51 -0700 (PDT)
Received: (nullmailer pid 589512 invoked by uid 1000);
        Tue, 17 Aug 2021 18:17:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, james.lo@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1629193630-19994-3-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1629193630-19994-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1629193630-19994-3-git-send-email-hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v11 2/5] dt-bindings: spmi: document binding for the Mediatek SPMI controller
Date:   Tue, 17 Aug 2021 13:17:50 -0500
Message-Id: <1629224270.762546.589511.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2021 17:47:07 +0800, Hsin-Hsiung Wang wrote:
> This adds documentation for the SPMI controller found on Mediatek SoCs.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> changes since v10:
> - No change.
> ---
>  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dts:19:18: fatal error: dt-bindings/clock/mt8192-clk.h: No such file or directory
   19 |         #include <dt-bindings/clock/mt8192-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1419: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1517677

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

