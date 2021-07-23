Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406023D3225
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 05:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhGWCbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 22:31:09 -0400
Received: from mail-vi1eur05on2060.outbound.protection.outlook.com ([40.107.21.60]:41919
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233454AbhGWCbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 22:31:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HntRG3a74LPt0RW8QbNXlUegDcnsD3SNo1nHgWqCSEEWM9jJQmibfCrU2KYjBo1+YLewytfgb5HcC6+cihVBNC5Cy8J/M4dehwl1/qzh/L3TiFuBH7Gny3juEabcuAkEMVy8/0SNIcOWq2AHC0ERC3TqqXe3+RvukxbaOt9TA0M9cEDXISCxfBmrBMLGEj7ME96XuZZoZQ+7v1z0Ue+hL+tbpjFBbMcUEWJNIXVC/VSa9I0d5mztIzV3KY3DHJ1FainJWIj77LlG5dRkSaEu+riCCT3rk4MQtzqDNbf76ri5IXKPRWO6OGgpAjefySBXvwXS3v2pfjQkR3igXNikHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uMrhHX6T77h/V8kYIbS3rCJmW7ZiA5ucTk6W/LvzVE=;
 b=ZuZpFi1RGO+FWipiuNBu0o0x0Lr0yx+HDtzLiTl7mr3kKYlxjxHA1VZc3RH3yneFu6HEXoW4Gbc+gC9eXzPPpdId/WRRRR7W6MtKmXXbhORQOvsTopB59wn2M31Qm8oRPekAfcDcD1FKrUhAoUUZtu+bdOw6rb16a2NaeGNMFA5kHOLYvIL/n62qWB/PzmaCNnoGR3Ip7W8u0FvJgJTBK9tH2oDMLAJUuAHY9++z/jsnMuLfritlwgxnOQAHQgrAKEqYrYma0AfeHrfNpGkoBr4WizWFe+mAxAC2km4O3rNGgT4tQSBxN/U1qe4pxNy9rpT4aFXvErPA9A+X/WtTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uMrhHX6T77h/V8kYIbS3rCJmW7ZiA5ucTk6W/LvzVE=;
 b=sREwHbNYO9Vs0apIQKW3q6R4ngphBgwB2g1UQRyjXzQsYIAVB2ZaURZ/52/Mbcbvl/CYJ4SHpMCiAFpfy/jor1Ju/r3bbDMTd0qN3hTH7zV5bsfEn2HXOZF87qXEdlINO6en3s8TkMcWXmQXce+zQdQ3UbzaB0fDXfnQSOh4dDw=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VE1PR04MB6704.eurprd04.prod.outlook.com (2603:10a6:803:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Fri, 23 Jul
 2021 03:11:40 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::50a3:f548:9c83:b50d]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::50a3:f548:9c83:b50d%7]) with mapi id 15.20.4352.028; Fri, 23 Jul 2021
 03:11:39 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC 1/2] dt-bindings: PCI: imx6: add fsl,imx6q-pcie.yaml
Thread-Topic: [RFC 1/2] dt-bindings: PCI: imx6: add fsl,imx6q-pcie.yaml
Thread-Index: AQHXftWTjxZ6H2iQ50qnn5J+AaCrS6tPEHIAgADSXYA=
Date:   Fri, 23 Jul 2021 03:11:39 +0000
Message-ID: <VI1PR04MB5853419B5BE2236E38AFB6918CE59@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1626942155-9209-1-git-send-email-hongxing.zhu@nxp.com>
 <1626942155-9209-2-git-send-email-hongxing.zhu@nxp.com>
 <1626964632.949777.4183870.nullmailer@robh.at.kernel.org>
In-Reply-To: <1626964632.949777.4183870.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51f87b7b-612d-4740-ecb0-08d94d87970c
x-ms-traffictypediagnostic: VE1PR04MB6704:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB67044E3A9D12EF9C093C5B1C8CE59@VE1PR04MB6704.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SCsTqYgszzebdL/z1k0t6m5R+7w6DZjLAhwYfHRrBTJbrjolB87CQWG4Bc/ByQEkVBnEoUsX6DoXJDB3xQDS9Dz+jNxyekPUAyo4s2L/olvtwqFjC6Vp+pjX2/6P1GTPp/PyaihR//HyU4LommpL+bDqlKAPv3NtSBNyhBBgir6hxbSGrD807BmuXMhN+dwMQ72IXBd+NgIp75eok1+w/+L4hJuCjKqu87rc0RvBwgQez+Epjbr4gCtdDRc2co09BaO9kAbN77fNhpWaC6mZTLqNw303+r2J1vjGtUANkL4Qj7DRhjdxyV9s6ie0XAGwfQ+yYHMzKKayJPEUOPBRcIu4fMnpyxDcggmmwC3dJPissCVyRigsN6Xjho57ymTR6a7V2iWdfx4070t8ye9Lci5JgsAR2HmpaIW5elvAzeH33qcQcCDD9ixzRrewvRGbCqj07CwbO8bBXav6iu4qe4Z7yeNNP9495AvQ7QYWQ/UtLPGxEqVWWNeOC9jABKE9NBdGyUVYI3mflAIoTbd8hdaDwrzp9qqzbwW+fEvSnFLEwBO1GhUvQPZ4zsnShDXYJ1VAVIPgwcvyl0KmsL+wC/PgHTYQDJlCaJAIbpqrdoCb3ZfNfFfOBc7B1Ex/mIuShFx0ZejvtuDMZ/137CU0ZizwN+dR8sgmB8vH6WUjMHfhsZ/hmriSLHUTTrFezJw0pbAuxtJf5soDvTXQXytT+Rk6jMtlzez9JMKG7Fzvlj3ctb+yvk/6KkA52aU4fvVjtoZ8n8/oBkZ9oH0EXF9ImUhSCF7yF9pfsMy5rYsmx/k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(6506007)(33656002)(54906003)(71200400001)(53546011)(45080400002)(2906002)(966005)(8676002)(5660300002)(316002)(4326008)(66446008)(66946007)(66556008)(66476007)(76116006)(122000001)(6916009)(8936002)(86362001)(52536014)(7696005)(26005)(64756008)(186003)(478600001)(55016002)(38100700002)(83380400001)(9686003)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hG4PrnIjLyn2Y45AedzNRIPQdgW+oKEx+19gFArnbBqj8RmtcYiyJ5XUIvLM?=
 =?us-ascii?Q?oHYIrk1FOQMHYhHKot2rzZ9daBvHZA/QpQM3kgCvFex52nocjh2zJnNtXZ2z?=
 =?us-ascii?Q?tjSFZsKVSrXk2brA9LDZkIQkLq5OV10mkR0mrI6hvq0hdsHTd9AvfUYCos/i?=
 =?us-ascii?Q?+oSBTI3ujW9iROXtcu9u5QPI1vRtYrOKLbzRJjMBrFMUKEBXazAxnk7SjINR?=
 =?us-ascii?Q?k2Jv4Nf4WtNk6xJVLzxdC8TXvT4EkRvacjh7iYvulRv98RnUJ6stqTmuix/+?=
 =?us-ascii?Q?itUMIjOF+RCLSVdBEQ+SroLIPvuSY0BQbvZ82ch4v+BfpJ76JzOKo/zmhneB?=
 =?us-ascii?Q?xcUMj+PZ7fCkCBKYdGLWalZMvPkOP2KbuSbFB/FUxQsFnFdtO/T5KFE7f+VF?=
 =?us-ascii?Q?xqwxWTGClTphy0KvJn4vTdFxKmWpnn/jc1PA5SuSt81MYcpI0PK/8tz7ZA4d?=
 =?us-ascii?Q?KaIr1P44iO4ITM2CKg6WErMTtVl9zS+7ruXPlsUcJfP98iZCGTEAiS0LAp7N?=
 =?us-ascii?Q?wq6YwYrE77TwafTX/sZGykbtpYTxDhgPsswKAWv9PSvX+uL73dApxtK8sHQA?=
 =?us-ascii?Q?VkUnhCZoUPntFvhvmv1Cl/cKhXJ4wqEnfcx4hJpqzbTNBRKkvtCroRXijV/3?=
 =?us-ascii?Q?dpwXCXihvJQdjUOwfWZaNUN4dmjsNBsyeoQ+5Fo+I3s0wyFCSa+0M4BMbQQU?=
 =?us-ascii?Q?0wupVPN6YXkLSBkbVqwij7/x4vZMO6lWOVHZXs+nEEC74fLq9K5p+nE5Mb14?=
 =?us-ascii?Q?sXSJ5TGU6V0IaoSJo8s9GSr2yULgKmlOOyUyVkckxOQsUT91Yp62rkTUb1fQ?=
 =?us-ascii?Q?Y5d32IuQhBx9dZW5tku5tpdJPU90kf6JszPeCIk6cHSyktl7VVYTT9KIwyDz?=
 =?us-ascii?Q?VrB0kRv1y+B8VUpAUT6Gsii+LFWc4KB/8qkze3N0puGg4FgORbVHISlt4Bc4?=
 =?us-ascii?Q?m5bheMbiPRmI4LRW5K/r36VApeJZ9hFJ24MCMZK1WX7V5xbSTanJr8+vK2xf?=
 =?us-ascii?Q?jT0vF2ymqKLHTpyF4ZE6bV6lhV6qZuZFyM0Ovw1713+yMJsKH0fUC1lfsVSQ?=
 =?us-ascii?Q?M58Dz65g0faOoyllBl3tFdNZY0dTVYySnWC9yeE1YItwlOF+a0lzrggrnG6D?=
 =?us-ascii?Q?cqi09kcmxZpp7V4/qpc7lY1qJk+QsaVD1PAH+maP6Kw1qfmRTHCOPqTgvFN2?=
 =?us-ascii?Q?kNzbSZS71UOYbe8fRlG+9eTiUzC7SJs1BSiNIPRHhqtR5LDu/whucQVYEM5F?=
 =?us-ascii?Q?cXQKvf6ymGCHDKjd5gD+KoFF7y1VqDQyjv1/gFAN25HtZWxiGb7lGhapofck?=
 =?us-ascii?Q?cutrQP/C8trIrJ5KW+vcK5pr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f87b7b-612d-4740-ecb0-08d94d87970c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 03:11:39.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agogNYq7+ebu23Bi/ren0WOBckV/AYAUNc8lm7FMhVdDrXeNF6QCgiFRb9wXXaV70FToWTnlBNnlT161eP9Xlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6704
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, July 22, 2021 10:37 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.or=
g;
> l.stach@pengutronix.de; galak@kernel.crashing.org; shawnguo@kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [RFC 1/2] dt-bindings: PCI: imx6: add fsl,imx6q-pcie.yaml
>=20
> On Thu, 22 Jul 2021 16:22:34 +0800, Richard Zhu wrote:
> > Convert the fsl,imx6q-pcie.txt into a schema.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          | 212
> ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 213 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file
> 'Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts'
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-extract-example", line 45, in <module>
>     binding =3D yaml.load(open(args.yamlfile, encoding=3D'utf-8').read())
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line
> 434, in load
>     return constructor.get_single_data()
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 122, in get_single_data
>     return self.construct_document(node)
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 132, in construct_document
>     for _dummy in generator:
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 722, in construct_yaml_map
>     value =3D self.construct_mapping(node)
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 446, in construct_mapping
>     return BaseConstructor.construct_mapping(self, node, deep=3Ddeep)
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 264, in construct_mapping
>     if self.check_mapping_key(node, key_node, mapping, key, value):
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 295, in check_mapping_key
>     raise DuplicateKeyError(*args)
> ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>   in "<unicode string>", line 22, column 5 found duplicate key "const" wi=
th
> value "fsl,imx6sx-pcie" (original value: "fsl,imx6q-pcie")
>   in "<unicode string>", line 23, column 5
>=20
> To suppress this check see:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fyaml.r=
e
> adthedocs.io%2Fen%2Flatest%2Fapi.html%23duplicate-keys&amp;data=3D04%
> 7C01%7Chongxing.zhu%40nxp.com%7C6171b22cdb104315be0d08d94d1e36
> 3f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6376256144309
> 20703%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D4Mu4S%2B6
> KeTg4gaCCL2Q%2ByjO7FbENp5LGHVRPuBhtvCc%3D&amp;reserved=3D0
>=20
> Duplicate keys will become an error in future releases, and are errors by
> default when using the new API.
>=20
> make[1]: *** [Documentation/devicetree/bindings/Makefile:20:
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-doc-validate", line 67, in <module>
>     ret =3D check_doc(f)
>   File "/usr/local/bin/dt-doc-validate", line 25, in check_doc
>     testtree =3D dtschema.load(filename, line_number=3Dline_number)
>   File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 623=
, in
> load
>     return yaml.load(f.read())
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line
> 434, in load
>     return constructor.get_single_data()
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 122, in get_single_data
>     return self.construct_document(node)
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 132, in construct_document
>     for _dummy in generator:
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 722, in construct_yaml_map
>     value =3D self.construct_mapping(node)
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 446, in construct_mapping
>     return BaseConstructor.construct_mapping(self, node, deep=3Ddeep)
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 264, in construct_mapping
>     if self.check_mapping_key(node, key_node, mapping, key, value):
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 295, in check_mapping_key
>     raise DuplicateKeyError(*args)
> ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>   in "<unicode string>", line 22, column 5 found duplicate key "const" wi=
th
> value "fsl,imx6sx-pcie" (original value: "fsl,imx6q-pcie")
>   in "<unicode string>", line 23, column 5
>=20
> To suppress this check see:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fyaml.r=
e
> adthedocs.io%2Fen%2Flatest%2Fapi.html%23duplicate-keys&amp;data=3D04%
> 7C01%7Chongxing.zhu%40nxp.com%7C6171b22cdb104315be0d08d94d1e36
> 3f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6376256144309
> 20703%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D4Mu4S%2B6
> KeTg4gaCCL2Q%2ByjO7FbENp5LGHVRPuBhtvCc%3D&amp;reserved=3D0
>=20
> Duplicate keys will become an error in future releases, and are errors by
> default when using the new API.
>=20
> make[1]: *** Deleting file
> 'Documentation/devicetree/bindings/processed-schema-examples.json'
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-mk-schema", line 38, in <module>
>     schemas =3D dtschema.process_schemas(args.schemas,
> core_schema=3D(not args.useronly))
>   File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 585=
, in
> process_schemas
>     sch =3D process_schema(os.path.abspath(filename))
>   File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 558=
, in
> process_schema
>     schema =3D load_schema(filename)
>   File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 125=
, in
> load_schema
>     return do_load(os.path.join(schema_basedir, schema))
>   File "/usr/local/lib/python3.8/dist-packages/dtschema/lib.py", line 111=
, in
> do_load
>     return yaml.load(f.read())
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py", line
> 434, in load
>     return constructor.get_single_data()
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 122, in get_single_data
>     return self.construct_document(node)
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 132, in construct_document
>     for _dummy in generator:
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 722, in construct_yaml_map
>     value =3D self.construct_mapping(node)
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 446, in construct_mapping
>     return BaseConstructor.construct_mapping(self, node, deep=3Ddeep)
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 264, in construct_mapping
>     if self.check_mapping_key(node, key_node, mapping, key, value):
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py=
",
> line 295, in check_mapping_key
>     raise DuplicateKeyError(*args)
> ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
>   in "<unicode string>", line 22, column 5 found duplicate key "const" wi=
th
> value "fsl,imx6sx-pcie" (original value: "fsl,imx6q-pcie")
>   in "<unicode string>", line 23, column 5
>=20
> To suppress this check see:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fyaml.r=
e
> adthedocs.io%2Fen%2Flatest%2Fapi.html%23duplicate-keys&amp;data=3D04%
> 7C01%7Chongxing.zhu%40nxp.com%7C6171b22cdb104315be0d08d94d1e36
> 3f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6376256144309
> 20703%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D4Mu4S%2B6
> KeTg4gaCCL2Q%2ByjO7FbENp5LGHVRPuBhtvCc%3D&amp;reserved=3D0
>=20
> Duplicate keys will become an error in future releases, and are errors by
> default when using the new API.
>=20
> make[1]: *** [Documentation/devicetree/bindings/Makefile:62:
> Documentation/devicetree/bindings/processed-schema-examples.json] Error
> 1
> make: *** [Makefile:1418: dt_binding_check] Error 2 \ndoc reference error=
s
> (make refcheckdocs):
>=20
> See
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.ozlabs.org%2Fpatch%2F1508586&amp;data=3D04%7C01%7Chongxing.zhu
> %40nxp.com%7C6171b22cdb104315be0d08d94d1e363f%7C686ea1d3bc2b4
> c6fa92cd99c5c301635%7C0%7C0%7C637625614430920703%7CUnknown%
> 7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D1x%2BNE6KyvoYSRAPFxPVXKYu4
> Md59o%2F9CtEKqaCsOwuU%3D&amp;reserved=3D0
>=20
> This check can fail if there are any dependencies. The base for a patch s=
eries
> is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.
[Richard Zhu] Got that. Thanks for your help. Will submit the patch-set aft=
er the errors are fixed.

Best Regards
Richard Zhu

