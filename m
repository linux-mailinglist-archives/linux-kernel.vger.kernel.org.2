Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DC240D9CE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbhIPMXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:23:30 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:40583 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbhIPMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:23:29 -0400
Received: by mail-io1-f54.google.com with SMTP id z1so7631686ioh.7;
        Thu, 16 Sep 2021 05:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=v3euXLp738T6azy0GiFk2D3abOLmLgbiKaC1a4iOzp8=;
        b=BvdE0TWV/9oTOE8C7VeAJdtt00XvLFBJdbTUXAlT/GNMUBN6N6lererFd4lMIAozVw
         6oRXbR2KEDb63MnK2yimxdRcKQsGgembibUriooOAA/7FEFlWkOfceTj8rQKbWtiDBIx
         JSoG8hEHQKFGkT8sNd7FFrQLQEA0yLBot848jptTUXjEEjXGyxzNFbpYpdYxwGVk/TpK
         CGk6mpHJNHUQPTkTVhhKjpUvH4wDecpF/L/5ZI4m9ufNUR/E5JYT3adlJaEBwFz9GIWa
         HFWWJsf2PfLKrENAv1m68oj+GZLFl5CkVGNkUkJBpgBE4dvtHx74+2BfIhrnrjaI7m4w
         yjYA==
X-Gm-Message-State: AOAM530JLT05tOYrvLKpOzXDxNl0sWEnCHPA28600qkrEO2/XhZrHYZo
        aZQDV6/ZiKJLmzy6/DDzpg==
X-Google-Smtp-Source: ABdhPJzmbQl+zrU9lv/3dovKA4P564DnLW2Yj00HM0HTXfMPkKhnL/7Rbc4MNmugR9La+k/sr1wM1A==
X-Received: by 2002:a05:6602:22d4:: with SMTP id e20mr4056514ioe.203.1631794928568;
        Thu, 16 Sep 2021 05:22:08 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id t25sm1566474ioh.51.2021.09.16.05.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 05:22:07 -0700 (PDT)
Received: (nullmailer pid 1119420 invoked by uid 1000);
        Thu, 16 Sep 2021 12:21:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
In-Reply-To: <20210916084714.311048-2-zhang.lyra@gmail.com>
References: <20210916084714.311048-1-zhang.lyra@gmail.com> <20210916084714.311048-2-zhang.lyra@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
Date:   Thu, 16 Sep 2021 07:21:53 -0500
Message-Id: <1631794913.500942.1119419.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 16:47:11 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
make[1]: *** Deleting file 'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml] Error 255
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml: Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml

See https://patchwork.ozlabs.org/patch/1528691

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

