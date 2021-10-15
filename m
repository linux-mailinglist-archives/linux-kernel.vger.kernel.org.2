Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78DD42FD9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbhJOVrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:47:46 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43702 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243184AbhJOVrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:47:43 -0400
Received: by mail-oi1-f178.google.com with SMTP id o4so14942145oia.10;
        Fri, 15 Oct 2021 14:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=y230wbruUO278KEc5ibVVtXYhkQ0A+OdNtSa2bP4utE=;
        b=10LkF2PQgCJ83lm9HJbxPFWhXnxVwprZO3KizY+J1Mt/sN2legGavT+QFbz4mFALex
         XwonrdMd90lXJbps7TJibuprxLPFEMurZbqK7stxlEMCCFO/MXVQFQaIo93p+bthaMA/
         f2QJqzqUdqVf+aKBMkbblDyvPr4rHn62CPRWCzBwE7lPOvDoBOD1CeI19F5VxHs2X7as
         dA9XnF2cCBil3uRfZaTAzIIfViJEkC7w8rX6yak0S+KcBcOI6laSsRnwCFutchE7FJd9
         a3MFPPQq6RdbceR0Ppw8aHXHw/o26C+iTomfzNMSsDQAfF9DAdMtzeI21QS5JZapxr5x
         XYWg==
X-Gm-Message-State: AOAM5318pal/DCjH9Xa85z+A53XpsPJ5AIVLORpotJ1RGv12b5qsBI3y
        lgLccAXNP7zJ6vCEbjvLNdBry5k/9Q==
X-Google-Smtp-Source: ABdhPJwt7GgQZCmeygfLarqNYmCXA+GZUidu6mgG0L5mNIjv29t+Nr4qM2fGE8qBBV5xIdnKzv2aFw==
X-Received: by 2002:aca:4283:: with SMTP id p125mr18034071oia.81.1634334336304;
        Fri, 15 Oct 2021 14:45:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v24sm1232483oou.45.2021.10.15.14.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 14:45:35 -0700 (PDT)
Received: (nullmailer pid 2254015 invoked by uid 1000);
        Fri, 15 Oct 2021 21:45:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-kernel@vger.kernel.org, neil@brown.name,
        devicetree@vger.kernel.org, john@phrozen.org
In-Reply-To: <20211015191741.12963-1-sergio.paracuellos@gmail.com>
References: <20211015191741.12963-1-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH] dt-bindings: bus: add palmbus device tree bindings
Date:   Fri, 15 Oct 2021 16:45:31 -0500
Message-Id: <1634334331.609042.2254014.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 21:17:41 +0200, Sergio Paracuellos wrote:
> Add device tree bindings for palmbus controller present in all the MIPS
> ralink based SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../devicetree/bindings/bus/palmbus.yaml      | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/bus/palmbus.example.dts:22.13-14 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/bus/palmbus.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1541885

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

