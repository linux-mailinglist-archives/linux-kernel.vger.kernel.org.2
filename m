Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0CA36FDB7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhD3PZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:25:47 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44826 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhD3PZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:25:46 -0400
Received: by mail-ot1-f46.google.com with SMTP id z25-20020a9d65d90000b02902a560806ca7so6022241oth.11;
        Fri, 30 Apr 2021 08:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=5FfXtxbf2+1RT69S9AA6R5xDes94gPxdY4zFREGjPU4=;
        b=WOt+IL0LHraVcxQOdGW2R25jZxIoCRCNC36S+Addb5j4Ke6repENJFe+3+vpCNz+zo
         /9fl2UomzrisMaTBkY2T+c97Fa41xbQ24ZubldKNEhFOIpXC7zyT/kzHGsV1oLeRi31d
         AjMEcXo/iz9vyyK8OAJrTnD2oxdoSLNPtO5sQfrFOKPDhlCGTA7A39Ssqe4lWRAuhedj
         411H3pVr7QfNvbVLZYzzvixCN/BYuZFVw4XNfhY5qlIU9XjGWpdw54hKLkiR9NuHVDXK
         ulSC02pKUUH7SyzGIO1Pgm28RiBF9O7nTwY9OtkwSqIhODrYVXt9hpNi3/nkZoGl9nXL
         MWTA==
X-Gm-Message-State: AOAM532Vza9eSge13PHGBC7LeKvn8hSdLAk/dw3q1r711EmGpLT8l73a
        HnBwu4yalFhFHJQOfyo35Q==
X-Google-Smtp-Source: ABdhPJzl7TZAjS/JHU4Kn3ojk7o8O0fWkXJU/cjLK3k6oupxy5IcPcWakw/i3Ek1NYI6k+ruJyHyyw==
X-Received: by 2002:a05:6830:4111:: with SMTP id w17mr4111512ott.99.1619796297875;
        Fri, 30 Apr 2021 08:24:57 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm803077oot.42.2021.04.30.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:24:57 -0700 (PDT)
Received: (nullmailer pid 3353973 invoked by uid 1000);
        Fri, 30 Apr 2021 15:24:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210429170404.3616111-3-narmstrong@baylibre.com>
References: <20210429170404.3616111-1-narmstrong@baylibre.com> <20210429170404.3616111-3-narmstrong@baylibre.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: amlogic: add Banana PI M5 bindings
Date:   Fri, 30 Apr 2021 10:24:53 -0500
Message-Id: <1619796293.730307.3353972.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 19:04:03 +0200, Neil Armstrong wrote:
> Add bindings for the Banana PI M5 board.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/amlogic.yaml:167:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/amlogic.example.dts'
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
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 850, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 850, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 731, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning for the next token
found character that cannot start any token
  in "<unicode string>", line 167, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/arm/amlogic.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/arm/amlogic.yaml:  while scanning for the next token
found character that cannot start any token
  in "<unicode string>", line 167, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/amlogic.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/amlogic.yaml
make: *** [Makefile:1414: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1471788

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

