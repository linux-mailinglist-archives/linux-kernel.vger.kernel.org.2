Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2243D38C78E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhEUNOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:14:11 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:45793 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhEUNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:13:57 -0400
Received: by mail-oi1-f182.google.com with SMTP id w127so15765899oig.12;
        Fri, 21 May 2021 06:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=F5/FDLp99kYvDUFQHD2N7h0ExV2sVgHTRXMIb5zlU0A=;
        b=JRUIuLhpwYK5Hk1RPhAH2otIXsDsRFsCK0G7mv98PYKNWbvuBc8CvXy31g6HudXWtf
         c8cw3xYNOEuMii9vlXR4niBHv5KS/kng4BaiVmS6jEJsvcK4t0MsI8QPnmv+D9kTfBIC
         ZoNA5mqbxZpf/BXnq9fOHA8JSPBlJLdcvG9pY0Uv1n5MXguY0HiismToPKxAE1t2YlaQ
         glk3QKuZmZYnHgXdjC9G7jkMzCMyTu7pQvybSQViGqIPwdn0RtWuvrMUh7iBVVZ6rWkA
         0oAGHlvKVEKMBRXn/nIvbC7BaFBMfmUpRhHMLWuDlFT0upKcuP0ejoO6hdWa9lkhQOSf
         QvBg==
X-Gm-Message-State: AOAM530L6UJ219BV1SbehsOakxnSq5Q8BtzGqIS2uJXHXcr3uzVJ59+O
        rCCo1BpufN1yaAxtGXj1KRHAYeZo4Q==
X-Google-Smtp-Source: ABdhPJy6cVgU2la1V7JAKJtCsrt8M8thmK+xhj1dCw7mcPs57IkquhQXoo9A6yq0bJujKlFT+Zp4Hg==
X-Received: by 2002:aca:4fc2:: with SMTP id d185mr2073811oib.123.1621602754559;
        Fri, 21 May 2021 06:12:34 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q22sm1235945otl.11.2021.05.21.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:12:33 -0700 (PDT)
Received: (nullmailer pid 3780504 invoked by uid 1000);
        Fri, 21 May 2021 13:12:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210521122129.1371-1-o.rempel@pengutronix.de>
References: <20210521122129.1371-1-o.rempel@pengutronix.de>
Subject: Re: [PATCH v1] ASoC: dt-bindings: Convert imx-audmux binding to json schema
Date:   Fri, 21 May 2021 08:12:32 -0500
Message-Id: <1621602752.149998.3780503.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 14:21:29 +0200, Oleksij Rempel wrote:
> Convert the imx-audmux binding to DT schema format using json-schema
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/sound/imx-audmux.txt  |  28 -----
>  .../devicetree/bindings/sound/imx-audmux.yaml | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/imx-audmux.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmux.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/imx-audmux.yaml:16:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/sound/imx-audmux.yaml:17:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
./Documentation/devicetree/bindings/sound/imx-audmux.yaml:20:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/sound/imx-audmux.yaml:21:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1482202

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

