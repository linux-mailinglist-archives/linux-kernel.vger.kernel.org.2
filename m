Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B8D30F66B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbhBDPd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:33:59 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:35172 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbhBDPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:21:47 -0500
Received: by mail-oi1-f175.google.com with SMTP id w8so4082453oie.2;
        Thu, 04 Feb 2021 07:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=oZGNs7nDtUphRDqGl7ohIJDPCE6d+t9/b/EDhVvQ54c=;
        b=BCnySCurRtJ47ZvicmY52iqFTu5Fsnc4SUhNxsF+o3cEXRzjLkkOd0XAwcKXsAKSh6
         +J8smvm0HT+of2bUy2HtkuXHpWtgB6qVqFxKUiTe+6HrtP9ii1aDlVLoamkP+GK3eSkF
         sxdebAIQDwxVA6DJiyJRCWPcbQJv2Ya+Jmd3dHKBHfj5YkVqjWVnsPx8GkrMxc4zRgVP
         NLte0wUwu9bc84gyDB7CVDR0x4IiHxdpvgHblAa458WEQ8+Q1uT1oBrENDeMofZ+DgpG
         9ZEFCA+Ql/zYcDtiNui4TdAEEiYOEDmD392LVVbKnElb7cgvZ3q7wG/j63meNMPgqyC1
         3ZAA==
X-Gm-Message-State: AOAM530NxZYAJvGOg4wypjZRJCdyBmjsVM228xDE3uEw2niYeeXRhLuj
        s4TQLdrNgUM6omT3hqPCSg==
X-Google-Smtp-Source: ABdhPJzmWXw4pcODtvLNukgjmc7B4wfiFPEAQGPUlYnM0+PkwlQXIRZiIHbcH4hj4u6Wx4RDAlnugg==
X-Received: by 2002:a05:6808:b03:: with SMTP id s3mr40824oij.40.1612452066140;
        Thu, 04 Feb 2021 07:21:06 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s123sm1142562oos.3.2021.02.04.07.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:21:05 -0800 (PST)
Received: (nullmailer pid 452040 invoked by uid 1000);
        Thu, 04 Feb 2021 15:20:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     balbi@kernel.org, heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org
In-Reply-To: <20210203165233.22177-1-jbx6244@gmail.com>
References: <20210203165233.22177-1-jbx6244@gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: usb: convert rockchip,dwc3.txt to yaml
Date:   Thu, 04 Feb 2021 09:20:57 -0600
Message-Id: <1612452057.718435.452039.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Feb 2021 17:52:27 +0100, Johan Jonker wrote:
> In the past Rockchip dwc3 usb nodes were manually checked.
> With the conversion of snps,dwc3.yaml as common document
> we now can convert rockchip,dwc3.txt to yaml as well.
> Remove node wrapper.
> 
> Added properties for rk3399 are:
>   power-domains
>   resets
>   reset-names
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../devicetree/bindings/usb/rockchip,dwc3.txt      |  56 -----------
>  .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 103 +++++++++++++++++++++
>  2 files changed, 103 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml:13:7: [warning] wrong indentation: expected 2 but found 6 (indentation)

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/usb/snps,dwc3.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
make[1]: *** Deleting file 'Documentation/devicetree/bindings/usb/qcom,dwc3.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/usb/snps,dwc3.yaml'
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/usb/qcom,dwc3.example.dt.yaml] Error 255
make[1]: *** Waiting for unfinished jobs....
make[1]: *** Deleting file 'Documentation/devicetree/bindings/usb/intel,keembay-dwc3.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/usb/snps,dwc3.yaml'
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/usb/intel,keembay-dwc3.example.dt.yaml] Error 255
make[1]: *** Deleting file 'Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/usb/snps,dwc3.yaml'
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.example.dt.yaml] Error 255
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1435466

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

