Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C971934E87A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhC3NJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:09:00 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:39717 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhC3NIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:08:48 -0400
Received: by mail-ot1-f43.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so15512228ote.6;
        Tue, 30 Mar 2021 06:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=d0esxVlzEhb3JH+b3fgvU+zO38K7IQvBZ8HUtZrPwqE=;
        b=ql1M/f7idsn7GnEJPst/Guj1O8GFPepxOjwJ4zKMNW/clChd58QAF61TOnfXd0ixgR
         83EJxj7L2YeFU/GzRgIVV0mV3JDOdC8AxZq2G2xifnczMJWiRPC2vLIhFm7X7OaGKQkx
         J8b+IS2zxeyV2qoNmc+4nv/gFpu+kHPJzgUOJdy/o5ppdXGOtH0zCQd1Jcz3lPk3o/DD
         e+Af5yVZw4H7E+eHxdcSls3/AW2K9UODLScR5Fq4817Bu9HT6/eWkol+rYlcn4ScUNFp
         D4BOPrJ3p7e6nrGcxnOdeHt7w43VIqFuROUcv7/2Y792Y0IBkLqozIZ7qpWJuo+4q2li
         ZeKg==
X-Gm-Message-State: AOAM532HonB3kPPZ3I+ifm5nuvzFnzJXWbaM99SuS1znPn/ekPGyk7ni
        I7TYtKyw9OV0tkp0U2qdpg==
X-Google-Smtp-Source: ABdhPJwxcg8UuZxNUy96UlZZyR7nZyaAJx7lXDRmu+lHPciAUFsa1hvxowVArjRKxWpIKB0EMpcBtQ==
X-Received: by 2002:a9d:37b4:: with SMTP id x49mr27206389otb.237.1617109728396;
        Tue, 30 Mar 2021 06:08:48 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d206sm4119179oib.56.2021.03.30.06.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:08:46 -0700 (PDT)
Received: (nullmailer pid 173737 invoked by uid 1000);
        Tue, 30 Mar 2021 13:08:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Po-Kai Chi <pk.chi@mediatek.com>
Cc:     wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Loda Chou <loda.chou@mediatek.com>
In-Reply-To: <1617081731-7408-2-git-send-email-pk.chi@mediatek.com>
References: <1617081731-7408-1-git-send-email-pk.chi@mediatek.com> <1617081731-7408-2-git-send-email-pk.chi@mediatek.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: memory: Add binding for MediaTek Common DRAM Controller
Date:   Tue, 30 Mar 2021 08:08:43 -0500
Message-Id: <1617109723.726939.173736.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 13:22:08 +0800, Po-Kai Chi wrote:
> This patch adds the documentation of the device-tree binding for
> MediaTek Common DRAM Controller.
> 
> Signed-off-by: Po-Kai Chi <pk.chi@mediatek.com>
> ---
>  .../memory-controllers/mediatek,dramc.yaml         |  155 ++++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.example.dts:43.3-44.1 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1414: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1459879

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

