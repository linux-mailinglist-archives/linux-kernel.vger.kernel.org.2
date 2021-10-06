Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F13423E7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhJFNSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:18:54 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:34794 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhJFNSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:18:53 -0400
Received: by mail-oi1-f169.google.com with SMTP id z11so3977456oih.1;
        Wed, 06 Oct 2021 06:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=j+HFuJa5yucfLsRf45OhrZ28a63h7uv0Y638CH2xCvw=;
        b=YKt2YWeQK1mWmRyDc+iTLfaMem5WajdFTGZ/Qg+0aKI22oQpPVuJF7P51w9SZAjn+I
         5Z6wwR3YPPjilEDzoAl4/wX2abU7o37i4/Z2mg6sdTIVAi91eo6eSPOR6UFxZbtSkHGj
         m3xLcZUexWPSgO6P0rd5O0gHKKnnvtaAjWXtqR2GIfM4Rk1g/60M1mxMnjPn5JZnvtET
         ZnkC6bkqxdmnNqH0a+zcRkng+p2r1ffnH3PrthbNiO43zO1l+9nQ1QjxJomLmRJyWmyA
         dl8ebzvowhr3g5gTpI7kllp8hU/XBOFl/OrimP24Ve4zdJwt2PsSf2zGoHbaRePQLRym
         MY5g==
X-Gm-Message-State: AOAM532Cv5+QAwojU2dp+zfRdOkHoQHjLX61dWg8kDFrtMnGkdoABjlc
        VQzV4Y3Bs34jR/QuTGP98w==
X-Google-Smtp-Source: ABdhPJyZqA5OnhJJ2UaAStzRyrYktRE55ALDXgJcv31JiEZ05hmPf6VwtcdNdXWEWUXE8KgdMv+D2A==
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr7034701oib.69.1633526220915;
        Wed, 06 Oct 2021 06:17:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a18sm3475581ook.41.2021.10.06.06.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:17:00 -0700 (PDT)
Received: (nullmailer pid 1513509 invoked by uid 1000);
        Wed, 06 Oct 2021 13:16:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aford@beaconembedded.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211006000505.627334-2-aford173@gmail.com>
References: <20211006000505.627334-1-aford173@gmail.com> <20211006000505.627334-2-aford173@gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
Date:   Wed, 06 Oct 2021 08:16:59 -0500
Message-Id: <1633526219.066849.1513508.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Oct 2021 19:04:59 -0500, Adam Ford wrote:
> This adds the DT binding for the i.MX8MN DISP blk-ctrl.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  .../soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml     | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml:78:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.example.dts'
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
  File "_ruamel_yaml.pyx", line 848, in _ruamel_yaml.CParser._compose_sequence_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning a block scalar
  in "<unicode string>", line 70, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 78, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml:  while scanning a block scalar
  in "<unicode string>", line 70, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 78, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1536963

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

