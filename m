Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127994378A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhJVOFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:05:48 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33710 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhJVOFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:05:42 -0400
Received: by mail-ot1-f46.google.com with SMTP id 34-20020a9d0325000000b00552cae0decbso4546874otv.0;
        Fri, 22 Oct 2021 07:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ruomGZWulywzz0DW4LCulUIbelTIOWKA2nEOcoXqZVQ=;
        b=HBQDAiS1vAoLDFStjMPQv7jFaIwYktbcRD+C4pTuICHC+DBngi1GYnqdJPjVWA1RE9
         3y1REAoytl8Pi7Z2qsW0TGL5H8pv2CqlyMa7paJg+P0C/aDVvCWU0aL1lwPUeEtZJ1ls
         eggb+5/Czk8t4pvBjKtKJAe/PKq0oKrZxtRJYydwaEzR9e3mI06ciVEJMrer/eAUijlm
         1lIYQThg4MqWDvsglelXt6MciBoOtPze2rduuRuaCBnyqTvz7+oJoW+swe+yRhSDVAsq
         xBESuqsywoyY7T6PQAM5k0lImRmmiwTTD7pbhtKaPkNN33fRt4CcgraNW3tRf2hB7CHX
         37jg==
X-Gm-Message-State: AOAM533ZkGXku2eVnTP2LHU9D3X7az16CiDOkE3fLR1uXOSzs3zGmhXY
        0DKBhCuuPgXBnOl+uG06HA==
X-Google-Smtp-Source: ABdhPJxkMg/NZ5wUa6Nul/xYxYkUKtq6kFY+pO/P1RKtbuibdALy7J5ZE2ubhQGOb8Tl3mh6ADQ53Q==
X-Received: by 2002:a9d:490e:: with SMTP id e14mr73853otf.194.1634911404119;
        Fri, 22 Oct 2021 07:03:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n12sm1675885otq.32.2021.10.22.07.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:03:23 -0700 (PDT)
Received: (nullmailer pid 2582197 invoked by uid 1000);
        Fri, 22 Oct 2021 14:03:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     qinjian <qinjian@cqplus1.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        tglx@linutronix.de
In-Reply-To: <20211022060737.281116-1-qinjian@cqplus1.com>
References: <20211022060737.281116-1-qinjian@cqplus1.com>
Subject: Re: [PATCH 2/4] dt-bindings: interrupt-controller: Add bindings for SP7021 interrupt controller
Date:   Fri, 22 Oct 2021 09:03:22 -0500
Message-Id: <1634911402.732539.2582196.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 14:07:37 +0800, qinjian wrote:
> Add documentation to describe Sunplus SP7021 interrupt controller bindings.
> 
> Signed-off-by: qinjian <qinjian@cqplus1.com>
> ---
>  .../sunplus,sp7021-intc.yaml                  | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  .../interrupt-controller/sp7021-intc.h        | 24 +++++++
>  3 files changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
>  create mode 100644 include/dt-bindings/interrupt-controller/sp7021-intc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.example.dt.yaml: interrupt-controller@9c000780: reg: [[2617247616, 128], [2617248384, 128]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1544791

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

