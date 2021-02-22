Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03596321F81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhBVS7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:59:49 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:38775 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhBVS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:59:13 -0500
Received: by mail-oi1-f169.google.com with SMTP id h17so15075156oih.5;
        Mon, 22 Feb 2021 10:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=k/Tr83e07kUDjV2mdPt8HHeG/axFkBtTveNJhvZFiaM=;
        b=G4sJeLm1HKv0GiTd5ifD6QdcYrwirgnsohbMLQvHV87hIPaNQcBNgfsnPkYQwr86NE
         Im8xaXErK09hz0bhYM6go6jm5ThCW85Gn5bT3iBVWoynG414dtr8k8tswfq34/BC+WR1
         Sfj9lxtWC+/HEmCICCWRu0H8iCNywmhnMKRHFQVXKMZoDwccpbJcMc2AlZjXrdBtYl7f
         MYii0/uUMxY73iKEpo9dvUOSQBNS2BJDwfwbITNMYaCnoVeZkBOJcOMVRFur140RIHk9
         S8+0PTMbdy9xcEDaotppR3+V36DjCZJZUwLKtWCZwDVSx0M8Z2fEU+7de/iuTZXL/WMo
         ee/w==
X-Gm-Message-State: AOAM533MFhDVFM1Jo1Ul/mpg76ZZBFfz5a3xQQGziBGHq7QXbrZZ/qvM
        JjO2qx5x186Hf50TORAqFTaWJfVDEw==
X-Google-Smtp-Source: ABdhPJyItZocFcAaxt6taWYSRmGgSdWuWQwBBzMn5CanndOkqsRyk0swI5gSgKdbA3SNu9pvCqilZw==
X-Received: by 2002:aca:b389:: with SMTP id c131mr16869006oif.99.1614020311162;
        Mon, 22 Feb 2021 10:58:31 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a25sm2210235oos.6.2021.02.22.10.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 10:58:30 -0800 (PST)
Received: (nullmailer pid 1828596 invoked by uid 1000);
        Mon, 22 Feb 2021 18:58:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210221194427.1184208-2-liambeguin@gmail.com>
References: <20210221194427.1184208-1-liambeguin@gmail.com> <20210221194427.1184208-2-liambeguin@gmail.com>
Subject: Re: [PATCH v2 1/2] clk: add support for the lmk04832
Date:   Mon, 22 Feb 2021 12:58:29 -0600
Message-Id: <1614020309.337925.1828595.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Feb 2021 14:44:26 -0500, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> The LMK04832 is an ultra-high performance clock conditioner with JEDEC
> JESD204B support and is also pin compatible with the LMK0482x family of
> devices.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../bindings/clock/ti,lmk04832.yaml           |  201 +++
>  drivers/clk/Kconfig                           |    7 +
>  drivers/clk/Makefile                          |    1 +
>  drivers/clk/clk-lmk04832.c                    | 1286 +++++++++++++++++
>  4 files changed, 1495 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
>  create mode 100644 drivers/clk/clk-lmk04832.c
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/clock/ti,lmk04832.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 852, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.parser.ParserError: while parsing a block collection
  in "<unicode string>", line 149, column 3
did not find expected '-' indicator
  in "<unicode string>", line 200, column 3
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/clock/ti,lmk04832.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/bin/yamllint", line 11, in <module>
    load_entry_point('yamllint==1.20.0', 'console_scripts', 'yamllint')()
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 184, in run
    prob_level = show_problems(problems, file, args_format=args.format,
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 91, in show_problems
    for problem in problems:
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 200, in _run
    for problem in get_cosmetic_problems(buffer, conf, filepath):
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 137, in get_cosmetic_problems
    for problem in rule.check(rule_conf,
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 570, in check
    for problem in _check(conf, token, prev, next, nextnext, context):
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 336, in _check
    'wrong indentation: expected %d but found %d' %
TypeError: %d format: a number is required, not NoneType
./Documentation/devicetree/bindings/clock/ti,lmk04832.yaml:  while parsing a block collection
  in "<unicode string>", line 149, column 3
did not find expected '-' indicator
  in "<unicode string>", line 200, column 3
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ti,lmk04832.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1442868

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

