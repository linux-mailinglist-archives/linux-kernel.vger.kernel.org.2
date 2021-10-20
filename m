Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4962434CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhJTNwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:52:53 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41644 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhJTNwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:52:40 -0400
Received: by mail-ot1-f48.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so6150555ote.8;
        Wed, 20 Oct 2021 06:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PEZXkD74SyZdIyV+d+cp0filvFd2Rp3gOD7po4nsWqk=;
        b=E1QbG5V+O58rcE4dqtqqt2TxWHTlYeZwOWaGIBd2krIROaKms9/7ZpHfZFDwe2ovru
         ZrD0UEf9JhizKPWjtjfsi+FpRtwg00eJ+u2NZfXXlPJnUwc40kpxxxYkhEnbL+8yDyaa
         58Kstb+7EmdYy/o7maCatU/i94XMyoJWgVsyeqO+/gX/mKXCvM6FNNnEx2LFnzgo7B6V
         hc9cwFwP7DVc/8l5fp2ccCnr8JpuE1EAUTqqTxr3UsSpLrURQidf3eWIyCaKae/RYbGc
         2Xcve09qRcAl/Ww+Xka2u7JOmsoKJeVesS8dhoqqAsJtjUiNAWAePwR1CXIPYPTpebu/
         5iuA==
X-Gm-Message-State: AOAM531C9zrS1bwJ8dsIJtxmQrwd4+NNIEsZ0kCU24ecmT1Wts1PSwc4
        d9DwhTW5P8lRHENOlgsXIg==
X-Google-Smtp-Source: ABdhPJzdpE171vomgu71sUM77D67pYolOFhrMZHKHtjQ7wm0L0/GqcC4cBU6sXFt2kOXSyTrvHgcGg==
X-Received: by 2002:a9d:715c:: with SMTP id y28mr11044070otj.362.1634737825626;
        Wed, 20 Oct 2021 06:50:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x12sm423235oot.6.2021.10.20.06.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 06:50:24 -0700 (PDT)
Received: (nullmailer pid 2259917 invoked by uid 1000);
        Wed, 20 Oct 2021 13:50:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        opensbi@lists.infradead.org, Bin Meng <bmeng.cn@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Xiang W <wxjstz@126.com>, linux-riscv@lists.infradead.org
In-Reply-To: <20211020093603.28653-1-heinrich.schuchardt@canonical.com>
References: <20211020093603.28653-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] dt-bindings: T-HEAD CLINT
Date:   Wed, 20 Oct 2021 08:50:23 -0500
Message-Id: <1634737823.662456.2259916.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 11:36:03 +0200, Heinrich Schuchardt wrote:
> The CLINT in the T-HEAD 9xx CPUs is similar to the SiFive CLINT but does
> not support 64bit mmio access to the MTIMER device.
> 
> OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to indicate the
> restriction and the "sifive,cling0" compatible string. An OpenSBI
> patch suggested to use "reg-io-width = <4>;" as the reg-io-width property
> is generally used in the devicetree schema for such a condition.
> 
> As the design is not SiFive based it is preferable to apply a compatible
> string identifying T-HEAD instead.
> 
> Add a new yaml file describing the T-HEAD CLINT.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> @Palmer, @Anup
> I copied you as maintainers from sifive,clint.yaml. Please, indicate if
> this should be changed.
> 
> For the prior discussion see:
> https://lore.kernel.org/all/20211015100941.17621-1-heinrich.schuchardt@canonical.com/
> https://lore.kernel.org/all/20211015120735.27972-1-heinrich.schuchardt@canonical.com/
> 
> A release candidate of the ACLINT specification is available at
> https://github.com/riscv/riscv-aclint/releases
> ---
>  .../bindings/timer/thead,clint.yaml           | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/thead,clint.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/thead,clint.yaml: properties:compatible:items: 'oneOf' conditional failed, one must be fixed:
	[{'const': ['allwinner,sun20i-d1-clint']}, {'const': ['thead,clint0']}] is not of type 'object'
	['allwinner,sun20i-d1-clint'] is not of type 'string'
	['thead,clint0'] is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/thead,clint.yaml: ignoring, error in schema: properties: compatible: items
warning: no schema found in file: ./Documentation/devicetree/bindings/timer/thead,clint.yaml
Documentation/devicetree/bindings/timer/thead,clint.example.dt.yaml:0:0: /example-0/timer@2000000: failed to match any schema with compatible: ['allwinner,sun20i-d1-clint', 'thead,clint0']
Documentation/devicetree/bindings/timer/thead,clint.example.dt.yaml:0:0: /example-0/timer@2000000: failed to match any schema with compatible: ['allwinner,sun20i-d1-clint', 'thead,clint0']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1543771

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

