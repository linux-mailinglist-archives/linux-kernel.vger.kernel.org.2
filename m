Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0008B422668
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhJEM2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:28:39 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38779 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbhJEM2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:28:33 -0400
Received: by mail-oi1-f181.google.com with SMTP id w190so858693oif.5;
        Tue, 05 Oct 2021 05:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=yIgUhu7G6czXFO6ebeJdfMc193Tu4/8LB2OpU0TT3Ns=;
        b=3UoFEa7CDUSup8u2giBbzjUMT2leQkn3rxYFaIGKyRuh9KMcx3yS6NUvi6TTpHAsNo
         mI182Q7v25UoOyRBzT6v7EGiwz8wJzyXho4lo04nK+7xX+RbOXlVzTngmwMeI6MGYLJB
         5yVPPIHlyLl5AFFIO587/uPz8qfKh3jcZsq6dJjrEWeq5kyrJrNAad8l1+LAnGqGWEEQ
         bTxKnIIe4LoFrXiaFb32LYEkzj8+W7uCW/qCNol2bgLUzB+PJyHUBUuM3anBfcg2e6di
         QncvscylB11N7nTT6gxk+MOx6MQmdok4zsCaDP0IAunw358P5B4sX/bwjgLnziV8/Sao
         cP8A==
X-Gm-Message-State: AOAM532vW5UZmWHAVqftBvUW/Er1JVrlEJx6R5ze1aQUJopcnt8QZRBu
        Emu6kBO57lEMHHHvWh79XKzOQT14uw==
X-Google-Smtp-Source: ABdhPJyG5fdOJLbVr22TivKYurISzS9pyWYFd8K412AFAxNwLKZMEoRo8Zed3HzbfPI5Sw5Ua+torA==
X-Received: by 2002:a05:6808:1912:: with SMTP id bf18mr2292547oib.118.1633436803179;
        Tue, 05 Oct 2021 05:26:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e12sm3528754otq.4.2021.10.05.05.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 05:26:42 -0700 (PDT)
Received: (nullmailer pid 3226823 invoked by uid 1000);
        Tue, 05 Oct 2021 12:26:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1633399842-1402-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1633399842-1402-1-git-send-email-hayashi.kunihiko@socionext.com> <1633399842-1402-3-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 2/3] dt-bindings: reset: uniphier: Add NX1 reset control binding
Date:   Tue, 05 Oct 2021 07:26:38 -0500
Message-Id: <1633436798.721139.3226822.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Oct 2021 11:10:41 +0900, Kunihiko Hayashi wrote:
> Update reset controller binding document for UniPhier NX1 SoC.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/reset/socionext,uniphier-glue-reset.yaml       | 1 +
>  Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml  | 3 +++
>  2 files changed, 4 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1536452


reset: 'resets' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/socionext/uniphier-ld11-global.dt.yaml
	arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dt.yaml

