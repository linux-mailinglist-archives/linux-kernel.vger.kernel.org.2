Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB88245A805
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhKWQiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:38:07 -0500
Received: from mail-il1-f173.google.com ([209.85.166.173]:37508 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbhKWQiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:38:05 -0500
Received: by mail-il1-f173.google.com with SMTP id h23so22293494ila.4;
        Tue, 23 Nov 2021 08:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QxKTz0uPcRgTU3M7Im7hWxB0L2741jFJDTYakDawPhk=;
        b=eeCaQxFTR3cgrDKv6rDS1qA+parP0wpzvPwlVO3Y9wZ1ZOVd0+4MYaM+WoWyjp0qj8
         0cWZqPMkDs+mtCaPoHYyrWOXeEUGE3Tq4OAtYA1F5qEwYaaOKPpHuwG3JeIGs4o2/JL4
         JK+F4EtwWMGkIfd8AgFWWgTk5yUv7nnrsdqbMMi+2xfqI39CDiMUnndB2bfTUguyNifu
         V0pkLPNTfoVg01Ed22svrSN5Zuiolw46feZ3r0yZ64QV6+uNidKYYPrWfBhYQWGVrr4P
         bz5+fkS8a+gd3j8BREghU4qO263dZw//XlJpVao3GFbVg7vt4nKabHagxi+fzLknammi
         qUYg==
X-Gm-Message-State: AOAM53133LxgVytl0GGo9dT/AjaYNhAOl/oIMEsIgo1fAVoqov6i1HLE
        2+CNJGJx6FYLm1SopRdYzQ==
X-Google-Smtp-Source: ABdhPJx9muI2pfMbgouTcfdaSQmH5+KKltsBDuiSE/x+ATmUUXRUs/yotC4IR7EsxK53036o/hIICQ==
X-Received: by 2002:a05:6e02:2166:: with SMTP id s6mr6446960ilv.170.1637685296438;
        Tue, 23 Nov 2021 08:34:56 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u12sm7558958ilm.1.2021.11.23.08.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:34:55 -0800 (PST)
Received: (nullmailer pid 3442914 invoked by uid 1000);
        Tue, 23 Nov 2021 16:34:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <49e5f47c79c0fc1d2b52ffdf7f5872f0adfa5ba5.1637669927.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1637669927.git.Adam.Ward.opensource@diasemi.com> <49e5f47c79c0fc1d2b52ffdf7f5872f0adfa5ba5.1637669927.git.Adam.Ward.opensource@diasemi.com>
Subject: Re: [PATCH 1/2] DA9121: add DA914x binding info
Date:   Tue, 23 Nov 2021 09:34:29 -0700
Message-Id: <1637685269.668492.3442913.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 12:19:27 +0000, Adam Ward wrote:
> Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
> ---
>  .../bindings/regulator/dlg,da9121.yaml        | 85 ++++++++++++-------
>  1 file changed, 53 insertions(+), 32 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/regulator/dlg,da9121.yaml:103:46: [error] empty value in block mapping (empty-values)
./Documentation/devicetree/bindings/regulator/dlg,da9121.yaml:106:23: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/regulator/dlg,da9121.yaml:  mapping values are not allowed in this context
  in "<unicode string>", line 106, column 23
make[1]: *** Deleting file 'Documentation/devicetree/bindings/regulator/dlg,da9121.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 119, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 889, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in _ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.scanner.ScannerError: mapping values are not allowed in this context
  in "<unicode string>", line 106, column 23
make[1]: *** [Documentation/devicetree/bindings/Makefile:25: Documentation/devicetree/bindings/regulator/dlg,da9121.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml: ignoring, error parsing file
warning: no schema found in file: ./Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1558524

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

