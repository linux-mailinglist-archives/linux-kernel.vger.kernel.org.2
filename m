Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1850433BEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhCOOtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:49:13 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:44304 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbhCOOXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:23:06 -0400
Received: by mail-il1-f171.google.com with SMTP id v14so9461456ilj.11;
        Mon, 15 Mar 2021 07:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=oLOVDEMXUd0z7d7GNWysLdHA6uYR45L2692BI1BuF8k=;
        b=ZvydnG44NeVKU1PHF/suVK926wELD/EBu9mB80jhgBVHS6OXbRygcpJEE6iqnYaEWo
         fyVt+fjeCa6F8+B9QaLSLtJWMN0QNZUdQ7Y2V67jahb/V7W4/QJPCb3LOanSym3Ims83
         YDJj0IxfFWQ+XozinvvO11NcFCsA2j6JRWZmGWei1ZalkiIMGrtDybE6jhvn8a7OStQe
         I0g2yHjHr5u2TYJRwZtD2TcK+TOSrCigeRmCLfJR9i6Yiw9+wUhoWiApfs0vCF8+rjvw
         bjq2dZ1TIUFXN/BjRLHF1QzGRCWExANRhyU4Hr6RSIvxQ2aQRDddlZbRB2dSx4BGkt+I
         6l5A==
X-Gm-Message-State: AOAM5310PoProQ6XNG3fV+MHTHtbtjyCO975OF0GLGryGInTTxhILsfq
        UDSa6ls0r37+V5zu1L3xgg==
X-Google-Smtp-Source: ABdhPJyJaLzWwqZ0e33L04X+5XOEtJ4gyAKByRO3upILfxDT9jfNp9xwndSgJLLkoSLLkeNBmf8Xng==
X-Received: by 2002:a05:6e02:489:: with SMTP id b9mr11999835ils.37.1615818186233;
        Mon, 15 Mar 2021 07:23:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b9sm7132643ioz.49.2021.03.15.07.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 07:23:05 -0700 (PDT)
Received: (nullmailer pid 876374 invoked by uid 1000);
        Mon, 15 Mar 2021 14:22:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1615658453-3989-3-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1615658453-3989-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1615658453-3989-3-git-send-email-hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v7 2/4] dt-bindings: spmi: document binding for the Mediatek SPMI controller
Date:   Mon, 15 Mar 2021 08:22:57 -0600
Message-Id: <1615818177.192018.876373.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Mar 2021 02:00:51 +0800, Hsin-Hsiung Wang wrote:
> This adds documentation for the SPMI controller found on Mediatek SoCs.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> changes since v6:
> - no changes.
> ---
>  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dts:19:18: fatal error: dt-bindings/clock/mt8192-clk.h: No such file or directory
   19 |         #include <dt-bindings/clock/mt8192-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1452529

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

