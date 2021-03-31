Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91C0350195
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhCaNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:41:41 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40484 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbhCaNlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:41:05 -0400
Received: by mail-ot1-f48.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so18926433otb.7;
        Wed, 31 Mar 2021 06:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=aTBIHPsVXRONiKFVCQ4rm5968LVQVqkaiMrcfjuQapw=;
        b=CeTn5eLmOrjDe9xUgqdglnKhfrr0joaGboH0arSVhVCXAFj7lsuiitCrNZpT41Gx/w
         RBntiXRAwZ5lxbxcgS6NyVc5+pAia3OJf0hjzRYIUO7PGA15E+xM3iiMltE9tOjnGg80
         vAGkSkqfV8w03Z6g+HKwikz4bqquDRL0rXyBDK7FT7h0pEiLbxaTLBVIipgXqAtHYkOM
         BP9ov8J9HYGkMsXLq5guluC69Fv8ytiQaOTWBrg55E8UVKLP4EKvDDFZlU/cUQ2pmnDx
         +guksUbrg0s9Vd6vNKKzQWqrniG7ym0OVhCzx0Q1Sd3CvZYSSjigeX+Q0WtNbfKuoIoM
         u3wg==
X-Gm-Message-State: AOAM530hbdPHaK6shMzSVy+r6iBAodvKqx8ai+Rb7XQocgmXaJucDKLX
        HiiU5xzch9yMWFtgfB9VUQ==
X-Google-Smtp-Source: ABdhPJzy3SsAO2JNoicePD84R9N8XZFDjn1ywgiPiF4SS2F2kCj3aGWUxkXkHIoNeDi+ORtuPIFuGw==
X-Received: by 2002:a05:6830:1658:: with SMTP id h24mr2573272otr.263.1617198064313;
        Wed, 31 Mar 2021 06:41:04 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l26sm474234otd.21.2021.03.31.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 06:41:03 -0700 (PDT)
Received: (nullmailer pid 2074859 invoked by uid 1000);
        Wed, 31 Mar 2021 13:40:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Ofer Licht <olicht@cisco.com>, Rob Herring <robh+dt@kernel.org>,
        xe-linux-external@cisco.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20210331014603.2496983-1-danielwa@cisco.com>
References: <20210331014603.2496983-1-danielwa@cisco.com>
Subject: Re: [PATCH] arm64: Add support for cisco craw64 ARMv8 SoCs
Date:   Wed, 31 Mar 2021 08:40:59 -0500
Message-Id: <1617198059.598213.2074858.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 18:46:02 -0700, Daniel Walker wrote:
> From: Ofer Licht <olicht@cisco.com>
> 
> Define craw64 config, dts and Makefile for Cisco
> SoCs known as Craw.
> 
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Ofer Licht <olicht@cisco.com>
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/Kconfig.platforms                  |   5 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/cisco/Makefile            |   5 +
>  .../arm64/boot/dts/cisco/craw64-dopplerg2.dts | 239 +++++++++++
>  arch/arm64/boot/dts/cisco/craw64.dtsi         | 392 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  7 files changed, 645 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/cisco/Makefile
>  create mode 100644 arch/arm64/boot/dts/cisco/craw64-dopplerg2.dts
>  create mode 100644 arch/arm64/boot/dts/cisco/craw64.dtsi
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/vendor-prefixes.yaml:238:3: [error] duplication of key "^cisco,.*" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/vendor-prefixes.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 420, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 121, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 714, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 435, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 253, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 284, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 19, column 3
found duplicate key "^cisco,.*" with value "{}" (original value: "{}")
  in "<unicode string>", line 238, column 3

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/vendor-prefixes.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 67, in <module>
    ret = check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
    testtree = dtschema.load(filename, line_number=line_number)
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 625, in load
    return yaml.load(f.read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 420, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 121, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 714, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 435, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 253, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 284, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 19, column 3
found duplicate key "^cisco,.*" with value "{}" (original value: "{}")
  in "<unicode string>", line 238, column 3

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema-examples.json'
Traceback (most recent call last):
  File "/usr/local/bin/dt-mk-schema", line 38, in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 587, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 561, in process_schema
    schema = load_schema(filename)
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 126, in load_schema
    return do_load(os.path.join(schema_basedir, schema))
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 112, in do_load
    return yaml.load(tmp)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 420, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 111, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 121, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 714, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 435, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 253, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 284, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 19, column 3
found duplicate key "^cisco,.*" with value "{}" (original value: "{}")
  in "<unicode string>", line 238, column 3

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

make[1]: *** [Documentation/devicetree/bindings/Makefile:62: Documentation/devicetree/bindings/processed-schema-examples.json] Error 1
make: *** [Makefile:1414: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1460305

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

