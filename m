Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC3356E91
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352878AbhDGO23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:28:29 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:40698 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348448AbhDGO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:28:25 -0400
Received: by mail-oi1-f172.google.com with SMTP id i3so18928313oik.7;
        Wed, 07 Apr 2021 07:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=oUxybfgsa0jBAyR4P005wIPk9RSEkhGXSWLM7IOREgI=;
        b=ocVh57EK5CEIisWy0rNCwLAmTcWBeqYTNPKrm+xsngZtBylJXJM1HIgH9HdKIlRK9o
         MMf3xXHu1+n+NQ3qDSm/9+sV4VszeN9kwcKkFnBoH1h79nvA5LFpXqdfmMbVXHPmF+D7
         86uX+URgUfpkGwZiK7sHRyA8G8mePhrUroyvKMljgklLvZU5xYKPRcC1oLRTpl1jjmIs
         b277cda19CzT3iHzMEXvRBmBlC3H0c+/8FDrYG6cieVOX0SQM8n229vZgTilY9faSrEc
         ytQsvmc/j9dBHdt8yS1FXJu1Tgjz2SWu6ITio4mXDrp7ZdQltIG3Az2e3YTvxdUo+0oW
         cCLw==
X-Gm-Message-State: AOAM533UwbWtZNhJa7TmOEYDNwCYZvmoLXKrN7pvGpW3GONZQpyIAwtE
        KQQ37hdtuiXICuxN1c9rDA==
X-Google-Smtp-Source: ABdhPJwbs7vhzPFfmzF6cXYQom7hIAFl/luDz3uevTicpkI3Lpn+qMolfXbgd74PF9sOhHfzv4kwgQ==
X-Received: by 2002:a05:6808:904:: with SMTP id w4mr2431870oih.1.1617805694429;
        Wed, 07 Apr 2021 07:28:14 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r20sm5425207otd.26.2021.04.07.07.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:28:13 -0700 (PDT)
Received: (nullmailer pid 3696994 invoked by uid 1000);
        Wed, 07 Apr 2021 14:28:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Flora Fu <flora.fu@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Mark Brown <broonie@kernel.org>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>
In-Reply-To: <1617766086-5502-6-git-send-email-flora.fu@mediatek.com>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com> <1617766086-5502-6-git-send-email-flora.fu@mediatek.com>
Subject: Re: [PATCH 5/8] dt-bindings: soc: mediatek: apusys: Add new document for APU power domain
Date:   Wed, 07 Apr 2021 09:28:12 -0500
Message-Id: <1617805692.253379.3696993.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2021 11:28:03 +0800, Flora Fu wrote:
> Document the bindings for APU power domain on MediaTek SoC.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  .../soc/mediatek/mediatek,apu-pm.yaml         | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.example.dts:19:18: fatal error: dt-bindings/clock/mt8192-clk.h: No such file or directory
   19 |         #include <dt-bindings/clock/mt8192-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pm.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1414: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1463115

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

