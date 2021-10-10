Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7069428356
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhJJTd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 15:33:58 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:45590 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhJJTd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 15:33:57 -0400
Received: by mail-ot1-f47.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so1593720otq.12;
        Sun, 10 Oct 2021 12:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cWA4thfRpC9JsQdj2kZ73hl8NdQGG+l8ud3pEKKtYfY=;
        b=wUg62mo2fkJt3FY7R8KCPHcjMjtZA5ZTR5/BCc9DRjw+dAFYESJvNcKmWRZVDBwwmO
         44bBHl6L7JdE4KzMCoY1UXYacX19r1wmIC1np1YTjCKZwS0d3QPvEf8b7/KxlsDx1ywN
         X0tp/pQfIyd46M13mb7PzwsXQYLCFlNfpdcYGCcsyS+PwildRHhZ7gKiOwzA2Tkoszk3
         tJCMuDwYebDbSpuGdlNt0Xri/3LXwvwUxV64+Xkayer3b9v3EDQ5rUk/VhzthRx5Wbh1
         Rk3Jju7z9oBdJb9nQbzjImsg8lpZ4+0f9OfNSmR632q5Dm6maUWVxE8KfQlIHZEkPo6x
         g1WA==
X-Gm-Message-State: AOAM530Z4WGpssZ4wnrVjNRXZs+MgK9UT2+Z5iBv8sa4Y0Vp6fo5YkxW
        Q9mI3ugRFJCJ/ffzqQ7f5Q==
X-Google-Smtp-Source: ABdhPJx7Ub8dkm7GsUrJHSYqZjTpKDAD8SZnxLqoL+59h25CUTga2ZDZ294pPf+JP7OAxIMi7fbGug==
X-Received: by 2002:a9d:728a:: with SMTP id t10mr10019092otj.198.1633894318212;
        Sun, 10 Oct 2021 12:31:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r184sm1240588oia.38.2021.10.10.12.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 12:31:57 -0700 (PDT)
Received: (nullmailer pid 3158659 invoked by uid 1000);
        Sun, 10 Oct 2021 19:31:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>, aford@beaconembedded.com,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211009162700.1452857-5-aford173@gmail.com>
References: <20211009162700.1452857-1-aford173@gmail.com> <20211009162700.1452857-5-aford173@gmail.com>
Subject: Re: [PATCH V2 4/9] dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
Date:   Sun, 10 Oct 2021 14:31:56 -0500
Message-Id: <1633894316.378588.3158658.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Oct 2021 11:26:54 -0500, Adam Ford wrote:
> Add the DT binding for the i.MX8MN DISP blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.example.dts:30.26-27 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1538808

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

