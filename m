Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A632B305DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhA0ODQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:03:16 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:36834 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhA0OBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:01:05 -0500
Received: by mail-oi1-f178.google.com with SMTP id d18so2220639oic.3;
        Wed, 27 Jan 2021 06:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=y/x7h2/Tlf0NCV9O9EgPMrRqhsMDU2V0T/uDOYfMhr0=;
        b=bVuMm0RxfD5Z7tmIFZgilRhEtqUpY2d6q7X9EW29CWqKtwrdJLEQ4ocfr7h39+rnpU
         8SP+YKbCCOxNct5IDodzQs+wNTL7OpQazmLaaGFGg6F4+N1vDXT64FO2jfDWCl6OFXFf
         UpG1DAIWlLR37kJX2Ak2CRj3AH/vGVzzNIbdDKIHaTduT3ApDKACzjuL4kBYLvZTIgLd
         2gQ8Tqyq3euh0UTHTk/xxPIh+HzmiFA2OJeUHVcASaHdMbwyv2n5Cd3d79og+byyr5gp
         ryVKagc7rrjb7EgMNCvNKC5DTBO0iK3Qq8rzI6U4fGqIxCi6T/kNZgFNuOOXKyTaIlJ0
         Hvog==
X-Gm-Message-State: AOAM533mk7RP8Y+yCo5WqsUBbg0Tt70cUMr9wSOJNr17hBkUMbBO2Zqk
        +zB0+m6eqFo9Ee3XYSTSP66Z0qf6sQ==
X-Google-Smtp-Source: ABdhPJyuQObuCHMCQ4jgeoAWt/Yii6rkM96cP9bWT0FdrTRLZbrrQQOt/5i37+Ih/99k5vGKfoOUWg==
X-Received: by 2002:aca:d14:: with SMTP id 20mr3343402oin.157.1611756024766;
        Wed, 27 Jan 2021 06:00:24 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s69sm436896oih.38.2021.01.27.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:00:23 -0800 (PST)
Received: (nullmailer pid 1429686 invoked by uid 1000);
        Wed, 27 Jan 2021 14:00:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, bp@suse.de, shawnguo@kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>,
        palmerdabbelt@google.com, gregkh@linuxfoundation.org,
        corbet@lwn.net, jassisinghbrar@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dragan.cvetic@xilinx.com, peng.fan@nxp.com, arnd@arndb.de,
        paul.walmsley@sifive.com, robh+dt@kernel.org, damien.lemoal@wdc.com
In-Reply-To: <20210126054036.61587-20-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com> <20210126054036.61587-20-mgross@linux.intel.com>
Subject: Re: [PATCH v3 19/34] xlink-core: Add xlink core device tree bindings
Date:   Wed, 27 Jan 2021 08:00:11 -0600
Message-Id: <1611756011.206606.1429685.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 21:40:21 -0800, mgross@linux.intel.com wrote:
> From: Seamus Kelly <seamus.kelly@intel.com>
> 
> Add device tree bindings for keembay-xlink.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> Signed-off-by: Ryan Carnaghi <ryan.r.carnaghi@intel.com>
> ---
>  .../bindings/misc/intel,keembay-xlink.yaml    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml: 'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml

See https://patchwork.ozlabs.org/patch/1432165

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

