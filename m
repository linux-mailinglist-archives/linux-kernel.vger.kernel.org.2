Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDAE309735
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 18:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhA3RYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 12:24:41 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:37205 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhA3RYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 12:24:33 -0500
Received: by mail-ot1-f53.google.com with SMTP id h14so11952977otr.4;
        Sat, 30 Jan 2021 09:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=DdK1ql4BtQUHDf72ebWy5mhjufhGtSi4TltGehBEYLU=;
        b=JC9S06PrUSAtmh2orNJJq7ZCyxqa0x+B8tAzJEvNBU4fuZ3hWDWffzYUYoFnD2Iqmb
         lgRlmSYE/hxi1PQUxfEbv73QwlUPtYp3O4az4pSq4wof0NVzhMEwFbfl5MNQ195D9wTO
         kun0ABZR2N2C2Qx5WbnTXTopS+BHCeeKkI9osK8qnnxFF9dHLzMy8rjH3x6+SwcglYc3
         yzwMw0GAnZMejvKdhfn6VD1uIWOcsU3dn06UqiDkrBcnhF0ufz/FqXkOR8dxGS/5BIeg
         W+9pPMS3RGBUeczHzkQd3rES8RwLH80MB71IG7a1Q0jDM7QOQTa0GZQeU1zrHPwBfYGP
         sZjg==
X-Gm-Message-State: AOAM533nwN5C+kjdwt++9u4fh9XW9vN0AtC+G41UB8zo0Y6JuuEQEIUD
        0oTJDStyehqWpnNlIbWGKA==
X-Google-Smtp-Source: ABdhPJwUTJc3stv3ppW29wWQfDyi82coFP2qm27KGkGsZzU5vUq1eu0QCq5kv4jThzlJAw5PK5Qk0A==
X-Received: by 2002:a9d:5f8b:: with SMTP id g11mr6724425oti.327.1612027432338;
        Sat, 30 Jan 2021 09:23:52 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a76sm3288159oib.45.2021.01.30.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 09:23:51 -0800 (PST)
Received: (nullmailer pid 1419430 invoked by uid 1000);
        Sat, 30 Jan 2021 17:23:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     jassisinghbrar@gmail.com,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, corbet@lwn.net,
        dragan.cvetic@xilinx.com, palmerdabbelt@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        damien.lemoal@wdc.com, shawnguo@kernel.org,
        paul.walmsley@sifive.com, arnd@arndb.de, robh+dt@kernel.org,
        peng.fan@nxp.com, bp@suse.de, markgross@kernel.org,
        gregkh@linuxfoundation.org
In-Reply-To: <20210130022124.65083-62-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com> <20210130022124.65083-62-mgross@linux.intel.com>
Subject: Re: [PATCH v4 26/34] dt-bindings: misc: intel_tsens: Add tsens thermal bindings documentation
Date:   Sat, 30 Jan 2021 11:23:40 -0600
Message-Id: <1612027420.847882.1419429.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 18:21:16 -0800, mgross@linux.intel.com wrote:
> From: "C, Udhayakumar" <udhayakumar.c@intel.com>
> 
> Add device tree bindings for local host thermal sensors
> Intel Edge.AI Computer Vision platforms.
> 
> The tsens module enables reading of on chip sensors present
> in the Intel Bay series SoC. In the tsens module various junction
> temperature and SoC temperature are reported using thermal subsystem
> and i2c subsystem.
> 
> Temperature data reported using thermal subsystem will be used for
> various cooling agents such as DVFS, fan control and shutdown the
> system in case of critical temperature.
> 
> Temperature data reported using i2c subsytem will be used by
> platform manageability software running in remote host.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Acked-by: mark gross <mgross@linux.intel.com>
> Signed-off-by: C Udhayakumar <udhayakumar.c@intel.com>
> Signed-off-by: Mark Gross <mgross@linux.intel.com>
> ---
>  .../bindings/misc/intel,intel-tsens.yaml      | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,intel-tsens.example.dt.yaml: example-0: tsens@20260000:reg:0: [0, 539361280, 0, 256] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

See https://patchwork.ozlabs.org/patch/1433609

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

