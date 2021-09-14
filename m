Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC640A290
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhINBfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:35:15 -0400
Received: from mail-eopbgr1300102.outbound.protection.outlook.com ([40.107.130.102]:42313
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229460AbhINBfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:35:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+ahLMUE+5pUE5ieFQaTuFKsXf/ZwYe67e5bRticvrfhqmStma5RGLXh3XoKbOTxwnVksr3GCv2YPDBdK+jANqJ74GQC3udLgGHDDsr2tY7wsD/1i1hasomHgLXG55YsjqhtmIOs+8meQsdGwEbAT3HBsfDfkN45+5Fag+iN2RT/N/mucvaTFyYP4Zu/stmoCxDCfPmmYb1QPA37L+UErzhGemYsERMBL/MJ0fq0W0fArKD8rZOEfdBGEXQtRT4DGCiFKsGjpx24pMv+mtiTJ6D3/oYwrjtP1MXEAwyNv1kRinXaGgjsB9CdCdhsvJCO6oQQ6w9h4Ae1zYXywBrEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AH2m0yaNZ+2o3AVuz9TiZLBuK5Rff9+45oOES2sUOxU=;
 b=RAQW3LjSb/tp7z2hZjq9SiEAD+IvU/C8ohn9yKZpB0laBhsPLvqLGv1J22t7k3+4AchLn+GQgJeFgj+CPy7G9ND8YSSTHbr3lB88Hlr+1clUczVwybcEEUwHZ1npA2+ypiTpyLXtnhjDGTnweTjl108wL2L50uVo/uByKAcsaK7ErIvy1FHZz7mUVtr/zdWnzBxqX4xlYdpixndUrgi9CP+nYiimcqMS0oQzP+EMIj3afT2R8JLxNpFEGFGP+BdbsMwdfJQua0rjS2dC6gcPQX3+VltrNMtFCCjyJqRxwH9yjkUeQH9JWcAc8K1eREVzoqv1H1p4kqEXSQEFAbn8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AH2m0yaNZ+2o3AVuz9TiZLBuK5Rff9+45oOES2sUOxU=;
 b=GjqGh+uOYlLKZJm38RhXoq1lBEy78D2l9SaLUn3ufmBI1+xzcH/N38/YslR0gXXGIYvelexlQHOdpClXcBLz6GD+aOhb3HFo0P2pKnA+gLhq4MnIUeX5liluqMCcObpDqhChneLtKF+QY4BSPt2DNneLs3NCIdY6maw4Mafgrx4I0cvB/u+M31Pcm91TKwiOuwbwuhJuQ2U68cQ2UQLdWvthD8YECwUdj2AgtTbKozFtytw0qUWcKj2MgSLyH7yjZM7cQWkq0gelbyTW6KYrsxLn2nBYFloPN2pn1zik2ta578fjPounc4zLI6CdLpwG+urMvIBynKUllfk3cOsYKA==
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com (2603:1096:203:b8::10)
 by HK2PR06MB3347.apcprd06.prod.outlook.com (2603:1096:202:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 01:33:54 +0000
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::3517:6c51:50d:1a55]) by HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::3517:6c51:50d:1a55%3]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 01:33:54 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "osk@google.com" <osk@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "yulei.sh@bytedance.com" <yulei.sh@bytedance.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v4 1/4] dt-bindings: mfd: aspeed-lpc: Convert to YAML
 schema
Thread-Topic: [PATCH v4 1/4] dt-bindings: mfd: aspeed-lpc: Convert to YAML
 schema
Thread-Index: AQHXqGUb1g4D5otybEGl5hNrtwUyU6uh4jKAgADbMMA=
Date:   Tue, 14 Sep 2021 01:33:54 +0000
Message-ID: <HK0PR06MB377931A31F7A51B443AC3B3291DA9@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20210913060231.15619-1-chiawei_wang@aspeedtech.com>
 <20210913060231.15619-2-chiawei_wang@aspeedtech.com>
 <1631535523.196891.444718.nullmailer@robh.at.kernel.org>
In-Reply-To: <1631535523.196891.444718.nullmailer@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cff41dd5-b8f6-4a81-5830-08d9771fb6a4
x-ms-traffictypediagnostic: HK2PR06MB3347:
x-microsoft-antispam-prvs: <HK2PR06MB3347ACC5077DFB2E72BA32B091DA9@HK2PR06MB3347.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +nZx5RzJV4JMemzZZ7MdtXgO1Y8OFSOSAJEJUZqSeU03PU6BCeGJvmZVVtwdYgocpBTqMcNFPKyCcbE+SDYLRMM97tlFKsMkU/6mCWVDDX3W03NKN7XKzOZ3YQR8vn5XfUhMR/iRxqSUtT5etd+Iv7gQ3fpJntvhgR1joow/BBMfTKjmywxKJFoDOjLZliaGxsR1G2LTi/v7i499gs7JQ4nqApXGfZ0/32wH1Cjiee276PW7aoj0drjhMrHY/+qNugg7nqT0pX/i2meAh941oBCovXlF6/KfAxUflfkAGY58bnyR1Gp93AoXmOmltdIdjVTh4NoEt1HVzORF4ghmS7zByeyPuGo3h4Yk7sY07EfszNGOghaqZr5R22yep/CZi0MP+14CsC2QDoEmqvXssU7/a2z/UyYPzqmAzGM6kIp/QlsxzRCGUrvPE9m9kL2ZYLx/YGbnUG2CI1xk32gsfx8/RiGaJLQllP5rveYGl0/uc9H18cSWvJIVzvEKJ9LBfvYQXmlkZplNVb+K45J4PluJmaoS2Fqo7kPpQO4Iv9gaqcXa6CDfjccWIgeQhlyO4qP3NYmZD+L3EuNKS3gm0Wc5ekCskZcTz0YmNxoHfjlm/UYRE3uQP7AhZcMKb3GbSegbAEoTGGaonn+1eWRFMfkBFtCtyUgeu9yw10IobtP8hzA1j1wJDLVXyrL4xQidrpVORZpGP0xlvcLfcyS+HVwF3U8Un68KlCkq9EILZ4RzhdB0tuMCmPoXmUB7HgFwE6oBISB9YCmAgtN2DBLsunCHhgQFxkDYeUTb7uvC6GQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3779.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(376002)(39840400004)(66946007)(9686003)(66476007)(55016002)(76116006)(66556008)(64756008)(66446008)(71200400001)(5660300002)(316002)(508600001)(966005)(83380400001)(54906003)(52536014)(8676002)(86362001)(6916009)(2906002)(7416002)(4326008)(8936002)(186003)(6506007)(7696005)(33656002)(38100700002)(38070700005)(26005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7kArccYmZ4THmhMd/tL8eSgb6mSF3CJI6V9UnGZK41StJ8SWuUS9ZMv2yR80?=
 =?us-ascii?Q?K72FsdQAhifrlSe7B+d7E9i9qncor7BSYsyYE5bmwjnguDk3mtrUbAtx/epO?=
 =?us-ascii?Q?xp4uReU6cDJ2Iaec5p4tvky52xDww92Bxgr3Ns6R9hYobliq+F7kehMGMF0P?=
 =?us-ascii?Q?XZ+FmogODYi1NXsglmWDfgqEXcm8/wv8pf3WXHClCl9v4zy1duIU0pj1xP+d?=
 =?us-ascii?Q?zcT1j0HGMuqZGQV/zUqKKmrCcOB9FYJqrNiOIjWFOamWf/BIix+k/QEQ/F8H?=
 =?us-ascii?Q?qwGsEJY4tImp0/vdo/mViKMESGtSqSXKlvsV3YVfyd20qBInd6EImCmaldBc?=
 =?us-ascii?Q?OtLo4UHf9JEG/rApj77RZDej/TiPt+WOgll3q9fVNFdfYLBjb/lrHCcgxIuz?=
 =?us-ascii?Q?Ayco51gqtWkarPAhKR1vKqoYhJlLDv8NtruIJ2Z/ZpyXhdB12PXSBOTl2kZX?=
 =?us-ascii?Q?gKxlx9AkX/az7IH8sZDTFhgE8KYHytlP7s++wpYZFUzyirE71f+TkL4ShXPs?=
 =?us-ascii?Q?Y3wqkXKY9O+e3LSVX0pPjl+NPRXFdMyfQp5tHTLTVl25KQl7OZRlok4x7dbO?=
 =?us-ascii?Q?+7B5nZ4hil87FAAqOQPVTFl3+paujC1mCNvxAZurbHLoHgtph4mJ6EapuZfY?=
 =?us-ascii?Q?uihj0VkG2efWEIKCqWcp3rv0FgCdyrHOyiPEbcRVducLaNztvTHAyGezLouv?=
 =?us-ascii?Q?2iI27dZVsPFFxMUz5A2KTHkP6bQh/6HWFQhAlgoJ5fumaVRIaQcakcjOJci/?=
 =?us-ascii?Q?zT3V5JAdE0C/rDQtV3QiMuP8B8S4AAcj0mM/dgx8ZnrMKXjkXPXYC3/3x/IZ?=
 =?us-ascii?Q?fIXanEx1dYUyoLmjESvBntWjLcvOYW+YFOANWsIeJ61n/SKZ9gtRH22DqDte?=
 =?us-ascii?Q?nj/10tih/IHCgxEFz040kBKOrD3HxqXDkSI/TphSo4Zv6UGlP5twhSE7RfRb?=
 =?us-ascii?Q?R3np5xurCi+VWWGfAjOOxbOcFwUSunZpkaQGD98Ufy/czy009God22SKVgm0?=
 =?us-ascii?Q?AJdle9/BgtKvcSONB6VDgsXI2dcns4eQtt5wwuGsk5g3LIH+lBs+63mx/ySd?=
 =?us-ascii?Q?SBYWHGQZxbpC2TvUUVvKHeopOtfMUSdT8xARAww4EBZwnTz1mEhxdBRCZ8k7?=
 =?us-ascii?Q?oMnLJDd8bcmZgUx9ed7USchwQr1cTOfJjOp2/pvTUH1RZY3ScCUpvsMV4vCz?=
 =?us-ascii?Q?+eIkPYbH3Run/8LshixLrtYjlPgx4R7PpwzdIQaqC7lFqlXxVq/A/pufiF92?=
 =?us-ascii?Q?IMliSEOigKh+ka4PeG75d6+NZwQ4KaMNCAHSBO7plVGtDfCgZ2irE16F3SDM?=
 =?us-ascii?Q?ujwh9RC/SI/I145vZDDMn6LP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3779.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff41dd5-b8f6-4a81-5830-08d9771fb6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 01:33:54.0391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hK/2nNFX3/wKLuI64RYgaZxw7Qbj5ht4HkwyehKm4EwsX8dWpEFE5gKdONs1ksd972xZqDGGoz3pq5uQHipJH79cHYTSirJSUBhR6WiNJrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3347
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Rob Herring <robh@kernel.org>
> Sent: Monday, September 13, 2021 8:19 PM
>=20
> On Mon, 13 Sep 2021 14:02:28 +0800, Chia-Wei Wang wrote:
> > Convert the bindings of Aspeed LPC from text file into YAML schema.
> >
> > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 ---------------
> >  .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 187
> ++++++++++++++++++
> >  2 files changed, 187 insertions(+), 157 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dts:30.35-36.15:
> Warning (unique_unit_address): /example-0/lpc@1e789000/lpc-ctrl@80:
> duplicate unit-address (also used in node
> /example-0/lpc@1e789000/lpc-snoop@80)
> Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0:
> /example-0/lpc@1e789000/lpc-ctrl@80: failed to match any schema with
> compatible: ['aspeed,ast2600-lpc-ctrl']
> Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0:
> /example-0/lpc@1e789000/reset-controller@98: failed to match any schema
> with compatible: ['aspeed,ast2600-lpc-reset']
> Documentation/devicetree/bindings/mfd/aspeed-lpc.example.dt.yaml:0:0:
> /example-0/lpc@1e789000/lpc-snoop@80: failed to match any schema with
> compatible: ['aspeed,ast2600-lpc-snoop']
>=20

I also encountered this error locally.
However, I couldn't find the root cause as these three compatible strings h=
ave been described in the same YAML file.
Could you guys help to give me some hints to resolve this issue? Greatly ap=
preciate that.

> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/patch/1527193
>=20
> This check can fail if there are any dependencies. The base for a patch s=
eries is
> generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

My dtschema & yamllint version:
dtschema-2021.7
yamllint-1.26.3

Regards,
Chiawei
