Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82D3391818
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhEZM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:57:47 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35818 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbhEZM5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:57:43 -0400
Received: by mail-oi1-f182.google.com with SMTP id v22so1376068oic.2;
        Wed, 26 May 2021 05:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=fs7e9A+XJ/srQYYXIBNRC8+bt0OfYmMIoJPIdWXMl4g=;
        b=d37/VCape08p9aZllka1AxS8CuwZExMdWFQWYjTeFBvZXJ0n0lDEi3teLYn7nVjoRX
         Cqn+qH+VlRT0AfHAjGKLXSyjZP4n3CUDT1ZcT+zh/QfZmsk2g8z/64xOMWY+Ajg+k2k7
         xA+4+mEmapCgzfrLOjZaExfo95B/PTGNfh+FdcZx18/2xNUC+BDNeyW8p8xOWPemuFED
         zNBxRpEwgmqc5/eAz044xQ9jTQc4mDLEF1gO+wLUOsx9HcVx919/FohOcPurFQpmlpIg
         wAS6HSwz7T19AZk66W58QlMCnxUbOZv0EGUOMuPm0qlMMuKgz5Z3ZuEcPmsck5j4xFoq
         fblg==
X-Gm-Message-State: AOAM53069TTUfbgRn98PtqmDaaGP71lIeLihh5RYh5AufdppcRsbpu6g
        Sr73smUQi6SQfkWigFL5sc6pVbhlYA==
X-Google-Smtp-Source: ABdhPJz5cSxik7of9vtoK0dE8Ba6tx8iuXcA/g2LpwT/q8f/f+dFRALbWORv7YbDdm7Uk4poIQ50+Q==
X-Received: by 2002:a05:6808:187:: with SMTP id w7mr1858125oic.108.1622033771014;
        Wed, 26 May 2021 05:56:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x63sm816645oix.47.2021.05.26.05.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:56:10 -0700 (PDT)
Received: (nullmailer pid 2377041 invoked by uid 1000);
        Wed, 26 May 2021 12:56:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, srv_heupstream@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1622025344-31888-3-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1622025344-31888-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1622025344-31888-3-git-send-email-hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v8 2/4] dt-bindings: spmi: document binding for the Mediatek SPMI controller
Date:   Wed, 26 May 2021 07:56:03 -0500
Message-Id: <1622033763.799295.2377040.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 18:35:42 +0800, Hsin-Hsiung Wang wrote:
> This adds documentation for the SPMI controller found on Mediatek SoCs.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
> changes since v7:
> - no change.
> ---
>  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml           | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
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
make: *** [Makefile:1416: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1483989

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

