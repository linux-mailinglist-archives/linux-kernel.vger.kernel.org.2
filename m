Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC844D8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 15:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhKKPAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:00:32 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37647 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKKPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:00:20 -0500
Received: by mail-oi1-f178.google.com with SMTP id o83so12017014oif.4;
        Thu, 11 Nov 2021 06:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=R7zk+o5f/F0OgLbsWoxwuTgZGcESXnxoCctVtMNWdEU=;
        b=8Ga8gKvtN/UWwRsrDaJdgTCIBzSMhEOIB7zWXrfaNEpNDVMZjFMRECkQVC4jLL6FLv
         hEVednquoOYLI8BO0d1Sgj3XVxC6D5ULVxthkRmeWYRfLD/D5Op4/CTvSCqLi3bqnInE
         bZUMUxmial8nP/LWSgf6FwK48lnZpItYtsQLOFULMlJNEYcpsbE6JSavdi3jZiJUkb/x
         2sZmVP3zEqbYRrNLh/le8NScujS/ovK5VqYvJmr9Fq9RcCTnHpymuv2Yp+WYXbRGNORl
         hConr8v2fFW6lGMzxxak67odI8qqctTV+xK7TrxcOzU2d3p5mYgcmNFcI+CiZ08xqk/L
         drKw==
X-Gm-Message-State: AOAM532txqzHzg/COLGWujkkhHfoWpojte5gxsSR73FIuip+q8UFsR/+
        SUAZNcMFY1v6u7a5px/7C9VcssV6Pw==
X-Google-Smtp-Source: ABdhPJzuQbo38UpOM4K4zoxHNYkhMhMKbgGcvAsCg6RfNTOyr1EfdkDGQE+UrYFETFyfrMEtwdQx4A==
X-Received: by 2002:a05:6808:f08:: with SMTP id m8mr1649495oiw.5.1636642650538;
        Thu, 11 Nov 2021 06:57:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q10sm807331oiw.17.2021.11.11.06.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 06:57:29 -0800 (PST)
Received: (nullmailer pid 3774085 invoked by uid 1000);
        Thu, 11 Nov 2021 14:57:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     michal.simek@xilinx.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        git-dev@xilinx.com
In-Reply-To: <20211111085939.21769-1-shubhrajyoti.datta@xilinx.com>
References: <20211111085939.21769-1-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH] dt-bindings: mailbox: zynqmp_ipi: convert to yaml
Date:   Thu, 11 Nov 2021 08:57:26 -0600
Message-Id: <1636642646.899407.3774084.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021 14:29:39 +0530, Shubhrajyoti Datta wrote:
> Convert the ipi doc to yaml.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.txt       | 127 ------------------
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      |  91 +++++++++++++
>  2 files changed, 91 insertions(+), 127 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.example.dt.yaml: zynqmp_ipi: 'reg' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.example.dt.yaml: zynqmp_ipi: '#mbox-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.example.dt.yaml: zynqmp_ipi: '#address-cells', '#size-cells', 'mailbox@ff990400', 'mailbox@ff990440', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1553827

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

