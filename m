Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEABF4052A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355367AbhIIMpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 08:45:25 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:34547 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350422AbhIIMeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 08:34:12 -0400
Received: by mail-oo1-f46.google.com with SMTP id g4-20020a4ab044000000b002900bf3b03fso509735oon.1;
        Thu, 09 Sep 2021 05:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=JB+SNLlfcpm25i4sSN9couzo+TEO2P9+BVL7k3+yKII=;
        b=raqPiIDAwgfW96mw2hkVFrtgBaHnnxaopPxtY5GB+53i4g+7OvOgQM/abE+rGKhBLA
         THbzZ2jq4Iwp4noz8RQEbEPPvWME7LC3weUmyBTL/ktoTgWQIh4PESdyOu5LHV1DcGeH
         6YNWiKia6is5UYJpzdLBEywYtZFkgFJXpLIS8lp/eko9ABg8Tfq2sv/Wmh5pTUIj99b9
         DiF9813XNe3lzsFuCVbVmJ3OvhhiAJCfXQ7HNRr8TdN4QheFqv4skHlPegp8NzK0NDld
         TLUcgicZKxWElfFc6nEwaNS06h3ybjpMBPxM1X2xWNX6vaJS540BfNDvUgq5o+Qe8Syx
         L0Xw==
X-Gm-Message-State: AOAM53030cCAELJHwz0il6d7/YGpfUMcmdBkojWYz8dMJnLNgBYXSVpN
        g2wdMoaGvescpUmcTP6YNw==
X-Google-Smtp-Source: ABdhPJy0XHmtcFAE2dZpjjWrUVCUjH89FQg2tjEgw63aJCweJIVoZOV4v+I/L15n0a2BOIdJD2bWuQ==
X-Received: by 2002:a4a:a509:: with SMTP id v9mr2241178ook.73.1631190780811;
        Thu, 09 Sep 2021 05:33:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c7sm411181otm.27.2021.09.09.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:32:59 -0700 (PDT)
Received: (nullmailer pid 200344 invoked by uid 1000);
        Thu, 09 Sep 2021 12:32:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     openbmc@lists.ozlabs.org, yulei.sh@bytedance.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        joel@jms.id.au, osk@google.com, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@aj.id.au
In-Reply-To: <20210909102907.32037-2-chiawei_wang@aspeedtech.com>
References: <20210909102907.32037-1-chiawei_wang@aspeedtech.com> <20210909102907.32037-2-chiawei_wang@aspeedtech.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: aspeed: Add UART routing controller
Date:   Thu, 09 Sep 2021 07:32:53 -0500
Message-Id: <1631190773.304300.200343.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2021 18:29:05 +0800, Chia-Wei Wang wrote:
> Add dt-bindings for Aspeed UART routing controller.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../bindings/soc/aspeed/uart-routing.yaml     | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/aspeed/uart-routing.example.dt.yaml:0:0: /example-0/lpc@1e789000: failed to match any schema with compatible: ['aspeed,ast2600-lpc-v2', 'simple-mfd', 'syscon']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1526149

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

