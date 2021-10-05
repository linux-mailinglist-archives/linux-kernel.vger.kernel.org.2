Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C57E422679
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhJEM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:28:51 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:43728 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbhJEM2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:28:41 -0400
Received: by mail-ot1-f48.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so25585527otb.10;
        Tue, 05 Oct 2021 05:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=srNcdN6u67VLuDVEjunal3mhVTK6oKtIKqVefAM5/zw=;
        b=spCXSUYuzlrKrxr+s87PaBG00jGlcK8sm+HcZ8o+ram9Cay6b4RZWt0t11GFbvA/Cy
         Ypie+a11Ra+ZS6QQ4EUlnOFaHuDdjwBj2sgXfLnEywGTXPdXMyyt/o4+XgB32FQNyiTl
         mzbL0+2k2G4VP9771hFf+ZbI7wsbrGJmCTC5LmH5F1HJza9BwPBkU+D80BIQew8Numdw
         sRueJ0H6oXNWwmFRP+lJ1GoTxPPigjYnZMJl4Dzz6yQlu4nBfgHaGilS/mI5GNAPK8gB
         lrZ1vN1w5PBS4Nh95RrXENmfIm4oYcdBZBc65IcH/fN5+6hl/EmrLzRT9O04b8FDIXKP
         CWKw==
X-Gm-Message-State: AOAM532eEA/GoqeAHW4uuV5sujAdk1MUS29bEz2g5L86Fa3GGAVsBk4j
        DbB+b/K11JhVaruYHL+nRQ==
X-Google-Smtp-Source: ABdhPJzGP0k7x9SJHnSA1WUxWsBg/ZNn8dg233m0CWHaSivAk8C7ANMMBUmCGX+ez61p7uivJLZDYg==
X-Received: by 2002:a9d:490:: with SMTP id 16mr13966857otm.184.1633436810361;
        Tue, 05 Oct 2021 05:26:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 8sm3274488oin.33.2021.10.05.05.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 05:26:49 -0700 (PDT)
Received: (nullmailer pid 3226802 invoked by uid 1000);
        Tue, 05 Oct 2021 12:26:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <1633399706-1251-5-git-send-email-hayashi.kunihiko@socionext.com>
References: <1633399706-1251-1-git-send-email-hayashi.kunihiko@socionext.com> <1633399706-1251-5-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 4/5] dt-bindings: clock: uniphier: Add clock binding for SoC-glue
Date:   Tue, 05 Oct 2021 07:26:38 -0500
Message-Id: <1633436798.596710.3226801.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Oct 2021 11:08:25 +0900, Kunihiko Hayashi wrote:
> Update binding document for clocks implemented in SoC-glue.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/clock/socionext,uniphier-clock.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml:51:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/clock/socionext,uniphier-clock.example.dts'
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
  File "_ruamel_yaml.pyx", line 731, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: while scanning for the next token
found character that cannot start any token
  in "<unicode string>", line 51, column 1
make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/clock/socionext,uniphier-clock.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml:  while scanning for the next token
found character that cannot start any token
  in "<unicode string>", line 51, column 1
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1536449

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

