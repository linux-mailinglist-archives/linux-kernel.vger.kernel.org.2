Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5034A40D9D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbhIPMXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:23:33 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:44636 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbhIPMXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:23:31 -0400
Received: by mail-il1-f178.google.com with SMTP id x2so6354521ila.11;
        Thu, 16 Sep 2021 05:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IFftwoDUAHs9Nz4h9MoROct44Y+LsTp6P6HEC2g+7PI=;
        b=KQw0ou/RCLOyURHpSJzxKWGZ8+Se1gLOa6Jhsj96RLHeaeK8BCp1RGZUWS/U+UTgPl
         xRa/Bk/LcEnGiElly0qs5XAkyTW2iVGPESObHZx0H9Ci+8K7pmYfH2VfOYS4/kkJWatW
         xz9mWztp8Rghrb0TyPe9/1NZ8f//hhnG+sWWUG4NBodv0PpyXtYZdKaWg7rufaKnJj4W
         7QVKkVRQmU4dKfNo7EaRAqFmY7EAQxqfPaeVR7PnqZK0NRXp31/+izn2vbYc5Q1xfHtW
         xc3bPtn6NnjqH9ZPRKefXl2bQDbPWOsUwR9KvIDiDzWaDjE+ql2jyb3hVXlBq6+pa+n7
         eZZA==
X-Gm-Message-State: AOAM5339Wd3dJAfV0JJ6tYnA9DoPM0oOu5pSwyQ6fchJVS5xurwIY98l
        9E0VcJzhcdsMyk2vMwtbuA==
X-Google-Smtp-Source: ABdhPJyM21Lfun7gEMOg6IfXLhT7D1Exg4DZsflUvLg259E9u2BpDENkfoIlSfCgxYHOA6gj7Pq+6g==
X-Received: by 2002:a05:6e02:1a0e:: with SMTP id s14mr3658426ild.47.1631794930759;
        Thu, 16 Sep 2021 05:22:10 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id g19sm1799388ilb.84.2021.09.16.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 05:22:10 -0700 (PDT)
Received: (nullmailer pid 1119422 invoked by uid 1000);
        Thu, 16 Sep 2021 12:21:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20210916084714.311048-3-zhang.lyra@gmail.com>
References: <20210916084714.311048-1-zhang.lyra@gmail.com> <20210916084714.311048-3-zhang.lyra@gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: clk: sprd: Add bindings for ums512 clock controller
Date:   Thu, 16 Sep 2021 07:21:53 -0500
Message-Id: <1631794913.511855.1119421.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 16:47:12 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add a new bindings to describe ums512 clock compatible strings.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,ums512-clk.yaml       | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/sprd,ums512-clk.example.dt.yaml:0:0: /example-1/syscon@71000000: failed to match any schema with compatible: ['sprd,ums512-glbregs', 'syscon', 'simple-mfd']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1528692

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

