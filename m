Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702AA424676
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbhJFTKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:10:10 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:36643 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbhJFTKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:10:08 -0400
Received: by mail-ot1-f44.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so4425003otx.3;
        Wed, 06 Oct 2021 12:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=3flmeFTtK50jBy1sd7u96vAnvkYzGiMbNOeFLQczGgE=;
        b=7MYZKLh0meW6LCI51yo1vGtCJAc5z9wRwqU4xuf6O7S29R/dRzJ1Qp8XJaqJP6bwnV
         DvlGC3PSjII7JE/DthqY8iMcMqhg/CAFg/T+aX+t14/k1VcdPZT63aOHve5/FVYBFNSW
         N45A/dYE/E8cNADINzlnG8PX0oMRjFHjFoU2ICc68AiWlBArQDEwQqRRpkkmdThl63qe
         zcqMtHPq63H7/yWB2IWNM6sFeR3hC5PGAuGIwGJH69/XpzH3DB0kD3uDYBg/mk7fHcuD
         Jw1eOHgWgWReEGNGS/30vM8Nx85b0F6wvelbNyvczvaEPoLZJO501vNn9lr6Bassr5Q4
         gzgA==
X-Gm-Message-State: AOAM531m4rVGTgIe9WQDye5eHUtM8bpSv/6pgrW331vIKX9tJqHZj0dk
        3sPAO2S5op/BNCOIyO62RA==
X-Google-Smtp-Source: ABdhPJzSOlmbu7vtSuxS0zm9FxYUsJ0u5rcivP5wp1X1pGDsd4V2fzO+v0Ui0n45a6zuFUUYv9hwhw==
X-Received: by 2002:a05:6830:79c:: with SMTP id w28mr371114ots.332.1633547295394;
        Wed, 06 Oct 2021 12:08:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i24sm4165829oie.42.2021.10.06.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:08:14 -0700 (PDT)
Received: (nullmailer pid 2218061 invoked by uid 1000);
        Wed, 06 Oct 2021 19:08:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <1633518555-8195-5-git-send-email-hayashi.kunihiko@socionext.com>
References: <1633518555-8195-1-git-send-email-hayashi.kunihiko@socionext.com> <1633518555-8195-5-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: uniphier: Add clock binding for SoC-glue
Date:   Wed, 06 Oct 2021 14:08:13 -0500
Message-Id: <1633547293.518535.2218060.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021 20:09:14 +0900, Kunihiko Hayashi wrote:
> Update binding document for clocks implemented in SoC-glue.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/clock/socionext,uniphier-clock.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/socionext,uniphier-clock.example.dt.yaml:0:0: /example-3/soc-glue@5f800000: failed to match any schema with compatible: ['socionext,uniphier-sysctrl', 'simple-mfd', 'syscon']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1537058

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

