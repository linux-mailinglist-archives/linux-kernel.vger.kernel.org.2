Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EBB3930C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbhE0OZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:25:12 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37749 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbhE0OZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:25:09 -0400
Received: by mail-ot1-f51.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so369518otp.4;
        Thu, 27 May 2021 07:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cAYbEBVO41pPeY8bh55UYX2lkNaNSE4J1N93ZC37MH4=;
        b=d/zDfJYMMHzzGwxn0k32VXT0HMcDGAW9IU0dXzCAh43nhv8w0EXJUAeYBVTtH5WYP2
         50yH2qjKeZduKO5NWdKPgXmRPhjJWZ+oidWIQDy0KoL2qe6oyQcJkRJT+kKwsSEwoWoN
         fQCJB8G1UjsXNZXQorGVRDU1lXLYJr+u7xm6G2A5kCASQGyz2Qfhpz590yUuegbAPivK
         5ZwCFhghQoX74s3YEOiY6Vj2XoCXI0SthdgBj1X/hYspUQvL4sIXQP3GU8cmPVIScf4Y
         UiDT5r6uo54D0VtMBQIqCxJifqvGdKPpQVySPgqsllclOO4/yZVf7XZzfUNstDsrhuTI
         Xh+Q==
X-Gm-Message-State: AOAM5311DwM/1AcPZIxYeO0OwuwuCgKBt1utYbjSxYBtdnXF0VnhkUws
        4f+5N519yplmJpgL7Jf7og==
X-Google-Smtp-Source: ABdhPJwI6N9HRRGnwxmBhqtCjiDJgmQ8vHKe6nUJBYkaRjOWH87S0oYGeVfXuEO4fIChEEkaQUI9NQ==
X-Received: by 2002:a9d:39e3:: with SMTP id y90mr3093636otb.257.1622125415948;
        Thu, 27 May 2021 07:23:35 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o14sm498437oik.29.2021.05.27.07.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:23:32 -0700 (PDT)
Received: (nullmailer pid 731794 invoked by uid 1000);
        Thu, 27 May 2021 14:23:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     devicetree@vger.kernel.org, heiko@sntech.de, lee.jones@linaro.org,
        linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, jbx6244@gmail.com
In-Reply-To: <20210527082905.1447591-2-jay.xu@rock-chips.com>
References: <20210527082905.1447591-1-jay.xu@rock-chips.com> <20210527082905.1447591-2-jay.xu@rock-chips.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: rockchip: convert io-domain.txt to YAML
Date:   Thu, 27 May 2021 09:23:27 -0500
Message-Id: <1622125407.801041.731793.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 16:29:03 +0800, Jianqun Xu wrote:
> This patch moves the rockchip-io-domain.txt from power/avs dir to soc
> dir and rename to io-domain.txt, without any change in the step.
> 
> Then covert the io-domain.txt to YAML.
> 
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
> v2:
> - first version
>  .../bindings/power/rockchip-io-domain.txt     | 135 ------------------
>  .../bindings/soc/rockchip/io-domain.yaml      |  45 ++++++
>  2 files changed, 45 insertions(+), 135 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/rockchip-io-domain.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml:17:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml:36:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/soc/rockchip/io-domain.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 421, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 109, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 32, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 36, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/soc/rockchip/io-domain.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml:  while scanning a block scalar
  in "<unicode string>", line 32, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 36, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/soc/rockchip/io-domain.yaml
make: *** [Makefile:1416: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1484505

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

