Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399F83F19BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbhHSMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:50:05 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33643 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbhHSMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:49:49 -0400
Received: by mail-oi1-f182.google.com with SMTP id n27so8472633oij.0;
        Thu, 19 Aug 2021 05:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zg3VPS1fKrsY8XB+1ftfUYl3cw7kXB5wzWtSZiId8do=;
        b=Xz56Q8h7v4rJm5oVh6i6WU6SdWmDFcX1yS9Y45J4FmuxofAxdEp9i5tXMPxaR4GuNM
         MLsCMjf9uVxuO82qHM00MOSXnNfxL/B1YhxyfOUF3+r3F3b2pQSd/TyhMR4BSvaH945A
         wqd9A3RvjE7E+lRJRvq2TzOhPaH4gF/nX84mdZN/4c42sIKwHDcvvwlwxSVMyb8XcYGO
         m4wsSxJb+xj8zC+a4E9H5N4vw2XRnJfC6v8vsS6pEYTDONDaFXD+h6YSlyundjHU+Yd5
         KtQvQVdS6s2zrsVCyoLGCfFtLfHK+BsTqf+2jIdiZAxWgMcvWAhfVLXGQnoMOayPJdiK
         6LAA==
X-Gm-Message-State: AOAM531tBtNAET+oOia/xpwk/oXvWuccWebpdo2mryGxViieqsB0BT/P
        G8K18+4ttgeswoKJT9iXzA==
X-Google-Smtp-Source: ABdhPJxasodywzNSc6uJ4iwV43paF2LoulLSjp2aRVVDaH0jW5MB4naam6DRVd0hfPm4uL/TRc+LWA==
X-Received: by 2002:a05:6808:1390:: with SMTP id c16mr2490439oiw.123.1629377352689;
        Thu, 19 Aug 2021 05:49:12 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m16sm546305oop.3.2021.08.19.05.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:49:12 -0700 (PDT)
Received: (nullmailer pid 288211 invoked by uid 1000);
        Thu, 19 Aug 2021 12:49:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     devicetree@vger.kernel.org, andrew@aj.id.au,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com,
        joel@jms.id.au, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210819080040.31242-2-chiawei_wang@aspeedtech.com>
References: <20210819080040.31242-1-chiawei_wang@aspeedtech.com> <20210819080040.31242-2-chiawei_wang@aspeedtech.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: aspeed: Add eSPI controller
Date:   Thu, 19 Aug 2021 07:49:09 -0500
Message-Id: <1629377349.157361.288210.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 16:00:36 +0800, Chia-Wei Wang wrote:
> Add dt-bindings for Aspeed eSPI controller
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/soc/aspeed/espi.yaml  | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/soc/aspeed/espi.example.dts:35.35-36 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/soc/aspeed/espi.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1419: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1518493

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

