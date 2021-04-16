Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7B3627BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbhDPSa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:30:29 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45633 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbhDPSa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:30:28 -0400
Received: by mail-ot1-f54.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so21467569otf.12;
        Fri, 16 Apr 2021 11:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=7ik3lAidwtHhkf3Xyj/o6l3nqO/bT8lkQxD5nRQd/OU=;
        b=HVkMFN7/BGqwsB0DT8xUdcQ1gALhoZgX7kFaWdVt1QvO/Z7UbH2gdEShlC0Qu7XX8X
         mslF08y4wU0/2iEw2FiPq6mAYkkUlWM6HN/OEepGgklWR0Ra4a15V3ozLWjMoz8yqvM3
         McMzzHTBKSTEawcX3XYVxKLtGnhwnLL+d8kpl4mx9Ji48mF/bM0Naog31Ez4KFSGmKh/
         Lyo14ccIEwAsvUT0IFUC3fKYcZDbT9mlrUtzxXfexEXsHZlOkbYWJ5E8SM14s8G9ci3G
         wSoBSs8Ah8IH2eLy3CapaVTDK8vQtWIzv+GNi8XDg0HwWX6/SOXTRYlydxzSNmjmxMf+
         03sA==
X-Gm-Message-State: AOAM532hbDfPraTxwjDQUNoZbdnupLUjamHYMhgiqifRGKbZQorWFIA8
        hZjHhvIbvMxLUeZeRFP1Og==
X-Google-Smtp-Source: ABdhPJyaDUF531HINEkRNssuyylOYZJ7EjNyx/ySlLTGLQp/KWESkd5iadSSQJqG3VD/Utr1tGu1xw==
X-Received: by 2002:a9d:30c6:: with SMTP id r6mr4697946otg.270.1618597803154;
        Fri, 16 Apr 2021 11:30:03 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s131sm1480363oib.14.2021.04.16.11.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 11:30:02 -0700 (PDT)
Received: (nullmailer pid 3708339 invoked by uid 1000);
        Fri, 16 Apr 2021 18:30:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
In-Reply-To: <20210416114928.27758-4-michael@walle.cc>
References: <20210416114928.27758-1-michael@walle.cc> <20210416114928.27758-4-michael@walle.cc>
Subject: Re: [PATCH 3/5] dt-bindings: mtd: add OTP bindings
Date:   Fri, 16 Apr 2021 13:30:01 -0500
Message-Id: <1618597801.604723.3708338.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 13:49:26 +0200, Michael Walle wrote:
> Flash devices can have one-time-programmable regions. Add a nvmem
> binding so they can be used as a nvmem provider.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since RFC:
>  - added missing "$"
>  - dropped first example
>  - use real device compatibles
> 
>    Please note, that this will lead to an error without patch 4/5, which
>    introduces that property for the jedec,spi-nor. Should I keep it
>    seperate or should I squash that patch into this one?
> 
>  .../devicetree/bindings/mtd/mtd.yaml          | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mtd.example.dt.yaml: flash@0: 'otp-1', 'otp-2' do not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

See https://patchwork.ozlabs.org/patch/1467024

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

