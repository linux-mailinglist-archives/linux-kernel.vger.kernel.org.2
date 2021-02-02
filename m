Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0706630C854
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbhBBRs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:48:26 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:35386 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbhBBRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:45:38 -0500
Received: by mail-ot1-f42.google.com with SMTP id 36so20644024otp.2;
        Tue, 02 Feb 2021 09:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=JTlXOdBngJ1YJUbwfAUG7x6kg6XjEmBq9/mlkFXBIug=;
        b=Kz+SAOpPDF1xLgseQ8HrofURsQGu8MLyoq3Ore5Xrv9EXb1zS6bIF8O+74pWzHckoQ
         rhiFFNzHJgJo1BrUA0oaRJkV5c4NaORRevwI/Lpv1+RDfW+E+QCuCqyaWTC4OHRnhbXG
         qDG9uGLlKsxQVpWXvTbdTOjamALKMxZ9PIuOJftvltEJFh0e6K+AH7qg1bgsko278DrP
         b5hUqsG5crFQ+e8fD6D+ffFhLvYyQ8I6C0mVnvdhmEa8lv0Ryt5WX2lh+yzFRqumPF6c
         UhfdMN1FPCs1kg0RS1XCzM8E3+xHR3ZxOagbnEx68CQpAw6LKjIZxoIH6of9RApwnGro
         uITQ==
X-Gm-Message-State: AOAM5330Wm8y2R6cLuuBk0980h/UZFNa8Uq5rr2nuMW3WqQrzsaq7Riz
        HkBGXkrw72a9FgOxOVV77g==
X-Google-Smtp-Source: ABdhPJxG354Fp569hTYJNvqu/3BDjRzPg3XgNq8Y/835+LrvwJGubs6mr2k1CNdj094klpMzHCN7CQ==
X-Received: by 2002:a05:6830:185:: with SMTP id q5mr16809793ota.359.1612287897139;
        Tue, 02 Feb 2021 09:44:57 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y24sm4824050oos.44.2021.02.02.09.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:44:56 -0800 (PST)
Received: (nullmailer pid 3887345 invoked by uid 1000);
        Tue, 02 Feb 2021 17:44:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, balbi@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, gregkh@linuxfoundation.org
In-Reply-To: <20210201194105.32673-1-jbx6244@gmail.com>
References: <20210201194105.32673-1-jbx6244@gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: usb: convert rockchip,dwc3.txt to yaml
Date:   Tue, 02 Feb 2021 11:44:54 -0600
Message-Id: <1612287894.993003.3887344.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 20:41:01 +0100, Johan Jonker wrote:
> In the past Rockchip dwc3 usb nodes were manually checked.
> With the conversion of snps,dwc3.yaml as common document
> we now can convert rockchip,dwc3.txt to yaml as well.
> 
> Added properties for rk3399 are:
>   resets
>   reset-names
> 
> Generic properties that are now also filtered:
>   "#address-cells"
>   "#size-cells"
>   ranges
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/usb/rockchip,dwc3.txt      |  56 -----------
>  .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 107 +++++++++++++++++++++
>  2 files changed, 107 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/usb/snps,dwc3.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
Documentation/devicetree/bindings/usb/rockchip,dwc3.example.dts:31.11-18: Warning (ranges_format): /example-0/usb@fe800000:ranges: empty "ranges" property but its #address-cells (2) differs from /example-0 (1)
Documentation/devicetree/bindings/usb/rockchip,dwc3.example.dts:31.11-18: Warning (ranges_format): /example-0/usb@fe800000:ranges: empty "ranges" property but its #size-cells (2) differs from /example-0 (1)
Documentation/devicetree/bindings/usb/rockchip,dwc3.example.dts:21.33-38.11: Warning (unit_address_vs_reg): /example-0/usb@fe800000: node has a unit name, but no reg or ranges property
make[1]: *** Deleting file 'Documentation/devicetree/bindings/usb/rockchip,dwc3.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/usb/snps,dwc3.yaml'
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/usb/rockchip,dwc3.example.dt.yaml] Error 255
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1434297

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

