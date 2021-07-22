Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F163D25E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhGVN4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:56:48 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:34334 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGVN4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:56:45 -0400
Received: by mail-il1-f176.google.com with SMTP id e13so5589319ilc.1;
        Thu, 22 Jul 2021 07:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=0sqJFubb00G2gchT2j7KYDo+ZwAgZGmihvS5vAzsofs=;
        b=QaHYi06d76PeznIApfiAw2yR9J7XgPY2Ibtdbyn9zYfeJ8TX/2uv3Gw4pRLUbyCe+A
         7uzZ1mYVzwItM5Vx55NhOhPkDoPxb1BX7sE4C4D8BZF3vyE92yBHXK3ci6PX96klom0q
         Ewyy83z0m7QAAMzoNPq2ohwSN0DpOjdr4T+QQPQ1k1+mHgWOzONk9JcIB7d292YYqy9B
         La927uT/3dJOIqlQ8w/SP3Su72aKt8ef0smxcNEh22J2TuL1Ld38Vjx30glnUCRxji0s
         tgehwrebQYFD0/ZPUkMNf9BAHbfOpPb6QDgwBQzNy+TfWucykIeao5YY+8lmUhEZ/RRi
         tn2g==
X-Gm-Message-State: AOAM533pUZgjsCehSu6Cqy/E9y7X6M3yTEBi0nMaMBCNvFzn4eSIE3wN
        hxEmjQHhivKQO2mZKANKtyX9F5Djfw==
X-Google-Smtp-Source: ABdhPJx2Q0ApUjerQPacSDhKZ7qKQOr6fu3iIk6SsiaUX0J0U0TRi0+ZnPK2lTs97vMLnc/0/4AspQ==
X-Received: by 2002:a92:d303:: with SMTP id x3mr138720ila.212.1626964638655;
        Thu, 22 Jul 2021 07:37:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a9sm10753550ila.23.2021.07.22.07.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:37:18 -0700 (PDT)
Received: (nullmailer pid 4183871 invoked by uid 1000);
        Thu, 22 Jul 2021 14:37:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <1626942155-9209-2-git-send-email-hongxing.zhu@nxp.com>
References: <1626942155-9209-1-git-send-email-hongxing.zhu@nxp.com> <1626942155-9209-2-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [RFC 1/2] dt-bindings: PCI: imx6: add fsl,imx6q-pcie.yaml
Date:   Thu, 22 Jul 2021 08:37:12 -0600
Message-Id: <1626964632.949777.4183870.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 16:22:34 +0800, Richard Zhu wrote:
> Convert the fsl,imx6q-pcie.txt into a schema.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 212 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 213 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts'
Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 122, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 132, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 722, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 446, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 264, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 22, column 5
found duplicate key "const" with value "fsl,imx6sx-pcie" (original value: "fsl,imx6q-pcie")
  in "<unicode string>", line 23, column 5

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

make[1]: *** [Documentation/devicetree/bindings/Makefile:20: Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 67, in <module>
    ret = check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
    testtree = dtschema.load(filename, line_number=line_number)
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 623, in load
    return yaml.load(f.read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 122, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 132, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 722, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 446, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 264, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 22, column 5
found duplicate key "const" with value "fsl,imx6sx-pcie" (original value: "fsl,imx6q-pcie")
  in "<unicode string>", line 23, column 5

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

make[1]: *** Deleting file 'Documentation/devicetree/bindings/processed-schema-examples.json'
Traceback (most recent call last):
  File "/usr/local/bin/dt-mk-schema", line 38, in <module>
    schemas = dtschema.process_schemas(args.schemas, core_schema=(not args.useronly))
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 585, in process_schemas
    sch = process_schema(os.path.abspath(filename))
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 558, in process_schema
    schema = load_schema(filename)
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 125, in load_schema
    return do_load(os.path.join(schema_basedir, schema))
  File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 111, in do_load
    return yaml.load(f.read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line 434, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 122, in get_single_data
    return self.construct_document(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 132, in construct_document
    for _dummy in generator:
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 722, in construct_yaml_map
    value = self.construct_mapping(node)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 446, in construct_mapping
    return BaseConstructor.construct_mapping(self, node, deep=deep)
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 264, in construct_mapping
    if self.check_mapping_key(node, key_node, mapping, key, value):
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py", line 295, in check_mapping_key
    raise DuplicateKeyError(*args)
ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
  in "<unicode string>", line 22, column 5
found duplicate key "const" with value "fsl,imx6sx-pcie" (original value: "fsl,imx6q-pcie")
  in "<unicode string>", line 23, column 5

To suppress this check see:
    http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys

Duplicate keys will become an error in future releases, and are errors
by default when using the new API.

make[1]: *** [Documentation/devicetree/bindings/Makefile:62: Documentation/devicetree/bindings/processed-schema-examples.json] Error 1
make: *** [Makefile:1418: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1508586

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

