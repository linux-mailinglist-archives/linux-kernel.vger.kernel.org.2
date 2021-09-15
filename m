Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B297A40C5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhIOM56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:57:58 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:33534 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbhIOM54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:57:56 -0400
Received: by mail-oo1-f53.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so873003ooe.0;
        Wed, 15 Sep 2021 05:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=eNJrp4hkkii6jSrN5pnjt5uJ56GHQYA0aPuGCrBxI38=;
        b=1ObBBnr/2CWp52EZTTdPfhABFCla6jCX44IVKzZVUXeFy4KYsYFtdoAtlWym3HEFY9
         NLCbFlW9OoKHQyke6JCwwusdA5SxqbhNeGjXvOE03THjFjYSftGZcToTPVMW/OMZ370C
         S4cfq49h8GmhXVqjSV8Dp1sYRPnLUjZq8+KeJ7XGARUajqsyijbNfjz9p3vbuxrRKdwS
         GdXbiTZM77YwtxWnZLBBXO5Hqm/Dg7ZHxuqP8ZfYNYhfeqp2jijUfrRwyA+xn6qyKXdL
         CZQGK5T8dFimYk3yPuURF5FNNpyqKrdYyVn00jxnt1mpoEDZ2z7CgQzrhuE9uUHvS9nv
         IlNg==
X-Gm-Message-State: AOAM532UrVLoWdM/Fgc8MX2A1vRFyMA0aFSO5MpcRcZDti/l4lqGsRtk
        ufpLtntcJEzjH7GxjQiFUTlMQFDxcA==
X-Google-Smtp-Source: ABdhPJzp3e1pp9Lsc7MCgmkwuRwGFXmv0jtuzCmDwFtPZNWP0m1xO3VgLzrqd10S/HkZQ6dlvYS0Sg==
X-Received: by 2002:a4a:de90:: with SMTP id v16mr18232123oou.42.1631710597319;
        Wed, 15 Sep 2021 05:56:37 -0700 (PDT)
Received: from robh.at.kernel.org ([12.252.7.226])
        by smtp.gmail.com with ESMTPSA id y24sm3394365oto.40.2021.09.15.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:56:36 -0700 (PDT)
Received: (nullmailer pid 935948 invoked by uid 1000);
        Wed, 15 Sep 2021 12:56:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210914200539.732093-2-paul.kocialkowski@bootlin.com>
References: <20210914200539.732093-1-paul.kocialkowski@bootlin.com> <20210914200539.732093-2-paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v9 1/4] dt-bindings: display: Document the Xylon LogiCVC display controller
Date:   Wed, 15 Sep 2021 07:56:34 -0500
Message-Id: <1631710594.961761.935947.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 22:05:36 +0200, Paul Kocialkowski wrote:
> The Xylon LogiCVC is a display controller implemented as programmable
> logic in Xilinx FPGAs.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/xylon,logicvc-display.yaml        | 302 ++++++++++++++++++
>  1 file changed, 302 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/xylon,logicvc-display.example.dt.yaml: logicvc@43c00000: 'display@0' does not match any of the regexes: '^gpio@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1528119

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

