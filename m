Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03E83FED72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbhIBMFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:05:19 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:46736 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344053AbhIBMFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:05:06 -0400
Received: by mail-oo1-f54.google.com with SMTP id z1-20020a4a2241000000b0028e8dfb83b4so438347ooe.13;
        Thu, 02 Sep 2021 05:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=qD/JwvmqRBtS1XdZshoHnEAUu284adMYEp3tjodfyAg=;
        b=el7nXiuSnVs4aLA3aC3ZkBTOmYt+7k5ZSK8chO6g1XujwL2yRPUNZzXO3xjqnqAYQL
         fTaHpA/zI2nyLGXTtTj4LK/gCpWuRpeuydoBRUt50Xo4alnYyftv9HfFWfhzNoWo0k8P
         RQjzMyKCEHUptOd3eqUJyuNxYiuohvZHNi7vOP9JqDmTU4Q6QhkTBjRuUm2/Fht5c3Ss
         qp+iMqZ0rGTVI1Bvnm/j5HYf4gji+IQRztc/a6p/6MKO/spC+KzlxPiAxQRg2PfThoYF
         e0/S/sdJJkA18AlTo33yi2xhUK7IbZ9lGuf1CEcXYGUlIukqFjQIO+PC67m9JhQi8jOz
         z+Hw==
X-Gm-Message-State: AOAM533gW2VOcZFwf7IrS0tESHfCQgQIpzkI2gWHKIKfT4VOUSq4ialN
        +koULtXBYCDOAKO5xhjIwA==
X-Google-Smtp-Source: ABdhPJx7f7/UQ6LovDjZ3k53D0TtryTlyUn40DyyPDvW82pU9Syq5rwgwEEGeA8B9B9Vweocahgwlg==
X-Received: by 2002:a4a:e3cf:: with SMTP id m15mr2270879oov.21.1630584248058;
        Thu, 02 Sep 2021 05:04:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y7sm329001oov.36.2021.09.02.05.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 05:04:07 -0700 (PDT)
Received: (nullmailer pid 685599 invoked by uid 1000);
        Thu, 02 Sep 2021 12:03:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>, linuxarm@huawei.com,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <f81388b12162702b925bf1a7d97836982b5cd785.1630498020.git.mchehab+huawei@kernel.org>
References: <cover.1630498020.git.mchehab+huawei@kernel.org> <f81388b12162702b925bf1a7d97836982b5cd785.1630498020.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: misc: add schema for USB hub on Kirin devices
Date:   Thu, 02 Sep 2021 07:03:59 -0500
Message-Id: <1630584239.088885.685598.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2021 14:23:37 +0200, Mauro Carvalho Chehab wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> This patch adds binding documentation to support USB HUB and
> USB data role switch of HiSilicon HiKey960 and HiKey970 boards.
> 
> [mchehab: updated OF schema and added HiKey970 example]
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/misc/hisilicon,hikey-usb.yaml    | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.example.dts:41.23-24 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1419: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1523123

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

