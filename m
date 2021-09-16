Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF20540D9C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbhIPMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:23:21 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:37692 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbhIPMXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:23:19 -0400
Received: by mail-io1-f44.google.com with SMTP id b7so7655634iob.4;
        Thu, 16 Sep 2021 05:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=r2Gi7GVurxdnZa4aokRrldHw3a9bYWUhzacjzfNJQfs=;
        b=WrUFGkG4nhXG5WJAdTAlIq0ODEzlLgsR+OJvrdS6ZoDoCnuQtG7KTZzDw7fcGFRWxg
         fOtq50SjTmxdh/ikqPdhKtFWLnMEirsbVw6JdavqrY7XJriFt/nkSEj8H34Yc3JVPR7R
         btDJiKMDG9/UH2P8QX/sYZZZqVZfYVhao48JSQx+JH2TqNW6f6CcU5ejz2o9LipgWS7m
         +xxn2IzW3y0BGTGRT9j/Lrd71dFVk5LwFguRvJiDDcq6pBmEZNcMhx00HAFszb5+Pf6o
         +YzLCLd/o5UaWTATyQEdHe7cSipz1Pg4l36ZynyboW4Lc17AJbToURhO+u0NW1I67Zq6
         sT+w==
X-Gm-Message-State: AOAM53105j9oHVM7qp3iDpCJL6NtUlKU+xNI6kjcLG65oaFb7LlrKsg8
        Y6/LT1r55FrN4/vs9a8quA==
X-Google-Smtp-Source: ABdhPJxgFASZVMub/cVWsMUumpBXd4GRs+TYka+iRFr4JhlOCSqa9qL0+QfDTzzVEQ7tUCjAvJCkTA==
X-Received: by 2002:a02:cc21:: with SMTP id o1mr1131382jap.110.1631794918864;
        Thu, 16 Sep 2021 05:21:58 -0700 (PDT)
Received: from robh.at.kernel.org (96-84-70-89-static.hfc.comcastbusiness.net. [96.84.70.89])
        by smtp.gmail.com with ESMTPSA id c11sm1653985ilq.26.2021.09.16.05.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 05:21:57 -0700 (PDT)
Received: (nullmailer pid 1119415 invoked by uid 1000);
        Thu, 16 Sep 2021 12:21:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20210915121937.27702-2-nm@ti.com>
References: <20210915121937.27702-1-nm@ti.com> <20210915121937.27702-2-nm@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: Add missing compatibles for j721e/j7200 evms
Date:   Thu, 16 Sep 2021 07:21:53 -0500
Message-Id: <1631794913.472895.1119414.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 07:19:35 -0500, Nishanth Menon wrote:
> Add compatibles for j721e and j7200 evms to allow for newer platforms
> to distinguish themselves.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dt.yaml: /: compatible: 'oneOf' conditional failed, one must be fixed:
	['ti,j721e'] is too short
	'ti,j721e' is not one of ['ti,am654-evm', 'siemens,iot2050-basic', 'siemens,iot2050-advanced']
	'ti,j721e' is not one of ['ti,j721e-evm']
	'ti,j721e' is not one of ['ti,j7200-evm']
	'ti,j721e' is not one of ['ti,am642-evm', 'ti,am642-sk']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/ti/k3.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1528330

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

