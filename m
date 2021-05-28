Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229AE3945C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhE1QXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 12:23:30 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:43878 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhE1QX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 12:23:28 -0400
Received: by mail-oo1-f41.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso1055675oow.10;
        Fri, 28 May 2021 09:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=eOXPQ48/DXVLMOpoDbToX5Y11nDnIWdQtOvWb3iJBV8=;
        b=Rgdy0Jt6gu/TEJfsnH/L7FB7bryqrAEPICSX9JIYKhUc4W16Alnx1yUitIS4cnwQ/J
         IvXYe/R6m6BUfuyAAUwnR/pvqOlX3Z1YymO4NlLrU2M4ENKS2qtkfYgxdMcL3uFxI1y3
         oSoxKAxLYZdRLiTYm0P6pvrHxT2e0ERy4Sh2q9Zy+FdEfX7wLcHVtWGFOoOgTQf2E6M/
         cI+cy/fB+BvREWGvqH5HZ6KBblFj63XtCpfEFhQBFBwH0hOMF65B6fPatkWxNRYRIuJl
         zHSwKrgFJRjOlC12SlMIeTfYpW5ikjQ3gy3ElSILefOXpTe9WT0CyD/dZRFowc4WKOx1
         2bpA==
X-Gm-Message-State: AOAM531iMe1Ff904frx0KRB/aYPSdGItZx0xeMx5kbhoRDS1AsuuPW6+
        XR7ewzaMIhMWbiuExeotdA==
X-Google-Smtp-Source: ABdhPJyPlDwwdt8cwOPHjYqDx51qPFnU39rXzfFZt4NHP1klQ0MpX6ssBEjK1u5zsW02weskmbzdmQ==
X-Received: by 2002:a4a:b4cd:: with SMTP id g13mr7530007ooo.4.1622218913320;
        Fri, 28 May 2021 09:21:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l23sm1202791oie.52.2021.05.28.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:21:51 -0700 (PDT)
Received: (nullmailer pid 3720613 invoked by uid 1000);
        Fri, 28 May 2021 16:21:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
In-Reply-To: <20210528072351.1639575-2-hs@denx.de>
References: <20210528072351.1639575-1-hs@denx.de> <20210528072351.1639575-2-hs@denx.de>
Subject: Re: [PATCH v1 1/2] mtd: devices: add devicetree documentation for microchip 48l640
Date:   Fri, 28 May 2021 11:21:50 -0500
Message-Id: <1622218910.743539.3720612.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2021 09:23:50 +0200, Heiko Schocher wrote:
> The Microchip 48l640 is a 8KByte EERAM connected via SPI.
> Add devicetree bindings documentation.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> I must admit that I created the file
> 
> Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> 
> by hand, looking into other yaml files...
> 
> Is there a way to check such a file to its correctness?
> 
>  .../bindings/mtd/microchip,mchp48l640.yaml    | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 67, in <module>
    ret = check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 33, in check_doc
    for error in sorted(dtschema.DTValidator.iter_schema_errors(testtree), key=lambda e: e.linecol):
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 723, in iter_schema_errors
    meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
KeyError: '$schema'
make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema-examples.json'
Traceback (most recent call last):
  File "/usr/local/bin/dt-mk-schema", line 38, in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 587, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 568, in process_schema
    DTValidator.check_schema(schema)
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 738, in check_schema
    meta_schema = cls.resolver.resolve_from_url(schema['$schema'])
KeyError: '$schema'
make[1]: *** [Documentation/devicetree/bindings/Makefile:62: Documentation/devicetree/bindings/processed-schema-examples.json] Error 1
make: *** [Makefile:1416: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1485038

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

