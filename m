Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956573A8BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFOWj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:39:26 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:45985 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhFOWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:39:26 -0400
Received: by mail-io1-f45.google.com with SMTP id k5so868829iow.12;
        Tue, 15 Jun 2021 15:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=AapX0dNT59T/SI8VAeevcD55A+AFG5MSeNuhN4FA4aE=;
        b=LU9Dvl5sKyrKaFulywb7QF73ShLVaX3gbpZb0Bp9JafFM4k6kGwpY3ewh5FTB/mMHL
         kp4T4koEtihpnzJ5LYxkyC8f/rb227N8YYnwA+adUAc3TW9xwnCq4h7QW01WZehhOmZ+
         INqeQaznwYnoWRqN0cLMdvrLhw0eILwdgNG55juzBQ9cQxAoxWozXsd79QOrQQe/sAFq
         A/BWrIwXcT3NAfYzLMZA173/vogOvvP3riN0VAx6tdGqo0OvW+/v60rUyJonwCiwLJnX
         1FIZQiVRUlpYnwd8+VaGdy0xWwU/+CaRNoo7slF/eObHSj3H9Fdd/bhevEzHJ8zlDttg
         sYSg==
X-Gm-Message-State: AOAM530ppIBy5p8XytiLABIzdk51TvTMn5mhsnJi/EdHRfIcKmWbT77o
        TyAu7oSMeZd8OufG0e9qj8n9VWX3Cw==
X-Google-Smtp-Source: ABdhPJzuul7DIME4umceda7UcrTrdVy5BGMY2MljyjNdecdHBWYZbkGdJhgM9V3oTSLQxsk8AGq6aA==
X-Received: by 2002:a05:6638:2583:: with SMTP id s3mr1244891jat.92.1623796640213;
        Tue, 15 Jun 2021 15:37:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h6sm215234ilj.53.2021.06.15.15.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:37:19 -0700 (PDT)
Received: (nullmailer pid 1415996 invoked by uid 1000);
        Tue, 15 Jun 2021 22:37:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org, mripard@kernel.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com
In-Reply-To: <20210615130737.2098-1-fengzheng923@gmail.com>
References: <20210615130737.2098-1-fengzheng923@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Tue, 15 Jun 2021 16:37:15 -0600
Message-Id: <1623796635.726367.1415995.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 21:07:37 +0800, Ban Tao wrote:
> The Allwinner SoCs feature an I2S controller across multiple SoC
> generations.
> 
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> ---
>  .../sound/allwinner,sun50i-h6-dmic.yaml       | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.example.dts:23.28-29 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1492163

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

