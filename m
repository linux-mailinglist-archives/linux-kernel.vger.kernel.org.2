Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207B83EF1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhHQSS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:18:29 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35679 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhHQSS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:18:27 -0400
Received: by mail-ot1-f48.google.com with SMTP id f16-20020a056830205000b00519b99d3dcbso4987608otp.2;
        Tue, 17 Aug 2021 11:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=NAXgyIbRzbTu9mKb6Zt/CWOSEYX5VCJlC2wVw0DwXxs=;
        b=sTmTQpfrtzE1ZCLgOmKRX2vAe06qMqX/46PKNWYtse6q/p/3u2Q7hoPBGg5GPl1Ve+
         MFm/qAg3BCdtmZ7kwyFJvjRQtdONPpuMvX9qlodTfWQ0gSKv4VcZ8slSQx/KHc9EruR7
         jPU00AtQxpjVba4G6UaoRMhUDJioRgrknW+Wc/pcyQ4RKhW1Vfcl3RB/a/5DLY0AM7D4
         smxEZuW5+fhvpBqcaJkUwn3nsTBzWskp966j98+7Hqa/2EHVFaScLpqiq8LnhGuH2Ja4
         TwFL9slOsX3TmyTNVNbEXnuDysYFtOOQFn8PUZdbdLx5SAIT5d0v9dy2O1jRSRTngaCd
         GufA==
X-Gm-Message-State: AOAM5339D4k6glcvyWk8z/sFICKqbbjwmC6gwsQ8jFP6fY4OGyrZ4L9o
        5L8XB2V1FUTy7ZIWsT3eBw==
X-Google-Smtp-Source: ABdhPJxwzhRAJ6gV8q/8dqOneXSlq4wvUdH27pleH4Nxmcvvag/vbAXNeIuDITKWAjtS/LPQIRn98A==
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr3622248oto.295.1629224273805;
        Tue, 17 Aug 2021 11:17:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j6sm583874ooj.11.2021.08.17.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:17:53 -0700 (PDT)
Received: (nullmailer pid 589515 invoked by uid 1000);
        Tue, 17 Aug 2021 18:17:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>, linux-kernel@vger.kernel.org,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Nishanth Menon <nm@ti.com>
In-Reply-To: <20210817152005.21575-1-sinthu.raja@ti.com>
References: <20210817152005.21575-1-sinthu.raja@ti.com>
Subject: Re: [PATCH] dt-bindings: remoteproc: k3-dsp: Update example to remove board specific
Date:   Tue, 17 Aug 2021 13:17:50 -0500
Message-Id: <1629224270.777170.589514.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2021 20:50:05 +0530, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The example includes a board-specific compatible property, but developers
> need to add the board name each time when a new board is added to the K3
> J721E SoC list. This grows the compatible string-list. So, drop the
> board-specific compatible string and add cbass_main as a parent node to
> avoid parent node and child node address-cells mismatch error.
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml     | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 120, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 852, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.parser.ParserError: while parsing a block collection
  in "<unicode string>", line 135, column 3
did not find expected '-' indicator
  in "<unicode string>", line 182, column 5
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.example.dts] Error 1
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
./Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml:  while parsing a block collection
  in "<unicode string>", line 135, column 3
did not find expected '-' indicator
  in "<unicode string>", line 182, column 5
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
make: *** [Makefile:1419: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1517765

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

