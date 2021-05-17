Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0CC383930
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347090AbhEQQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:10:59 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:34529 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243083AbhEQPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:47:23 -0400
Received: by mail-ot1-f52.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso5954393ote.1;
        Mon, 17 May 2021 08:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=BpisGO1EY/OutI+0r2Ss3WkR4guRrGoWKpsaAn3hDH4=;
        b=FPEFUc5qSrQs5eGDOD/z1TM60PN18/GuZjvIBb+UVKGk+/31lE2LKElxXQyMx9thNl
         lHbQU8Xt4dauKN2vC4GFHkvSIMUQnN+b6McDixVKTyusb8xN4RP6hQri78lv6W27RR9T
         A4dl9+TUCq4QRdOibVDGXlpShzScoH3g2imFLQf7WwUVzbnM2P4VsSXCxDOQhRRPeNGH
         Wfxajgzvil/eCkHJyQXs+9DfEUR/oFJb+1SvZn7WGebtaRJwNjGWummda2cfj7hBbS9b
         INfAMxY29VBOuU/CG1nWd+S5iQimw2QIwi3RrIfJ8oS1jbxF7FGMXmF29Io7EhNuJ1Xe
         92Iw==
X-Gm-Message-State: AOAM530iwaYVfaezlmUoMXqHiF9XeOLRC3UfCiU1ulEbCyZV0tGxskHz
        zapUSYcqDXDzU9T5Z+OFXg==
X-Google-Smtp-Source: ABdhPJwIursDMrlVj6a1IbFbqh11nlxKUw0DMAjHBtI58RXtKtoGhAMJI5Mbpw5HNgeWBknepQj0iw==
X-Received: by 2002:a9d:2aaa:: with SMTP id e39mr170906otb.169.1621266365457;
        Mon, 17 May 2021 08:46:05 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a23sm3246571otf.47.2021.05.17.08.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:46:04 -0700 (PDT)
Received: (nullmailer pid 2631254 invoked by uid 1000);
        Mon, 17 May 2021 15:46:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     a-govindraju@ti.com, Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org
In-Reply-To: <20210517061739.5762-2-kishon@ti.com>
References: <20210517061739.5762-1-kishon@ti.com> <20210517061739.5762-2-kishon@ti.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: mux: Convert reg-mux DT bindings to YAML
Date:   Mon, 17 May 2021 10:46:03 -0500
Message-Id: <1621266363.910480.2631253.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 11:47:34 +0530, Kishon Vijay Abraham I wrote:
> Convert reg-mux DT bindings to YAML. Move the examples provided in
> reg-mux.txt to mux-controller.txt and remove reg-mux.txt
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/mux/mux-controller.txt           | 113 ++++++++++++++-
>  .../devicetree/bindings/mux/reg-mux.txt       | 129 ------------------
>  .../devicetree/bindings/mux/reg-mux.yaml      |  47 +++++++
>  3 files changed, 159 insertions(+), 130 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mux/reg-mux.txt
>  create mode 100644 Documentation/devicetree/bindings/mux/reg-mux.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.example.dt.yaml: serdes-ln-ctrl@4080: 'mux-reg-masks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mux/reg-mux.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.example.dt.yaml: serdes-ln-ctrl@4080: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mux/reg-mux.yaml

See https://patchwork.ozlabs.org/patch/1479231

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

