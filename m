Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61607439E53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhJYSTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 14:19:30 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41832 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhJYSTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:19:25 -0400
Received: by mail-oi1-f175.google.com with SMTP id bk18so16733940oib.8;
        Mon, 25 Oct 2021 11:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=VYgEzAUK5vIV1/XxJDtu0CYzc2fCSzuI3jM+a9IYaoE=;
        b=REBkkxfNmEjz5iN2X3jGRN6HX+jDMFOxx0bDUb3WlC252BiYwG5I8BzfQMqYQOImfD
         a9z//G5Jh6h3gqSIP28I6C2OjKfsMKgF+PDtAQEd47LPajeR0SX91hZsnZK90gQ7t8G9
         YaeLlDQxXYgIHXKWnJptY6/468Zm6AjWcnOhExKz2ZFiYNUEYJg+JHfnVhABNIwkg9cA
         ElEtuhTqvuYYmPVI2U2ha3BfTl0mtju7rpxod28S72z+KULGRgzOQg4Y6+nB4XLJh0lR
         jjQ340eaIPdwfTxM03+K8mx0CzD+kqYi67zDTBx8Ip8jfy++LyLc1AmjmcfZ6oQPF3I+
         QTzA==
X-Gm-Message-State: AOAM532bIuexBjHZw0dzoXq0wyQUvTLOBB3dtf/Akt2LwoCjk0JQEMcl
        ZB0lAT4skBcLKBA7BCqJYSsWpgQriw==
X-Google-Smtp-Source: ABdhPJz6Op3Td2UudmGFBbTzhGZK2ivGUlles/1gbzOCetL2pcQaihRaGCR7veAF5Wey/GcUQAPesA==
X-Received: by 2002:a05:6808:2185:: with SMTP id be5mr23996700oib.139.1635185822201;
        Mon, 25 Oct 2021 11:17:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n107sm2952195ota.40.2021.10.25.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 11:17:01 -0700 (PDT)
Received: (nullmailer pid 824872 invoked by uid 1000);
        Mon, 25 Oct 2021 18:16:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     thanushree.sreerama@emtrion.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org, shawnguo@kernel.org,
        robh+dt@kernel.org, frank.erdrich@emtrion.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
        festevam@gmail.com
In-Reply-To: <20211025161509.37305-1-thanushree.sreerama@emtrion.com>
References: <20211025161509.37305-1-thanushree.sreerama@emtrion.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Add support for emtrion emCON-MX8M Mini
Date:   Mon, 25 Oct 2021 13:16:53 -0500
Message-Id: <1635185813.782599.824871.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 18:15:09 +0200, thanushree.sreerama@emtrion.com wrote:
> From: Thanushree Sreerama <thanushree.sreerama@emtrion.com>
> 
> This patch adds support for the emtrion GmbH emCON-MX8M Mini modules.
> They are available with NXP i.MX 8M Mini equipped with 2 or 4 GB Memory.
> 
> The devicetree imx8mm-emcon.dtsi is the common part providing all
> module components and the basic support for the SoC. The support for the
> avari baseboard in the developer-kit configuration is provided by the
> emcon-avari dts files.
> 
> Signed-off-by: Thanushree Sreerama <thanushree.sreerama@emtrion.com>
> Reviewed by: Frank Erdrich <frank.erdrich@emtrion.com>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  arch/arm64/boot/dts/freescale/Makefile        |   3 +-
>  .../boot/dts/freescale/imx8mm-emcon-avari.dts |  23 +
>  .../dts/freescale/imx8mm-emcon-avari.dtsi     | 141 ++++
>  .../boot/dts/freescale/imx8mm-emcon.dtsi      | 645 ++++++++++++++++++
>  5 files changed, 812 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/fsl.yaml:714:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/arm/fsl.example.dts'
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
  File "_ruamel_yaml.pyx", line 773, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 852, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning for the next token
found character that cannot start any token
  in "<unicode string>", line 714, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/arm/fsl.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/arm/fsl.yaml:  while scanning for the next token
found character that cannot start any token
  in "<unicode string>", line 714, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/fsl.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/arm/fsl.yaml
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1545835

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

