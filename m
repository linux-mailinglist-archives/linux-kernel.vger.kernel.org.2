Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18914404F9A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 14:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347350AbhIIMVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 08:21:25 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:17832 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1351193AbhIIMJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 08:09:42 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18981JdF015808;
        Thu, 9 Sep 2021 05:08:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=dVWw9UpHQyvHLVzF5iBPPnxRlxnxFnfL4TaPGT5kqgI=;
 b=RMCyyjGTX7/vBgUIcAmklwoMUfyEOjqykMwTzTvDE9NqbO34ybifTCWNOCyRiGV0vZUw
 D8TS8o7GqKKOncqfiwDemDyNAfDHsYiTNrxuG+qhF0zDBww3MYGZUqi5pcMKS2F9XpVW
 UkbKwRiYnGv8X25CcSE+0T85pCCCbZkqvMHykv279R7z6wYahnhAYruW0d8YD4iSSy2V
 +O71HFNSIkC8J9FFQ2iteOah9ab1OB2mPz5SR+NFA4aDSVgypR7TSrKAKprjF/SmxaHq
 IDsyRaiZgFfDBvpHqyS3c1wwyA+zSKLR0m7hLoCQnePmKD9ODU9GRJoCTXFC74TCLEui sA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3ay8hr1mpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 05:08:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQXnIQ2S8PBRyyu8DXpMEesRJNB3YY6U5XiVlXgDFeukRiyzzszCsO6pRmeobMxOSPhPa2ptoRJNnpGeqodGXbetl+Kw+vxn2iU9xQWSXJmcLXIRjQObuObZfaWIuKmPxPkNQ4YrILE8BJzeRK6QrKLFyyaBrY/rs1l7n5r+k0R6CQkaqIufeHfqwC5OQWplQFPfUjtiDGCcRWn+NK23y2kqhQuatySW/DRwdBr6+zxJrjzY023rU9x8BjyAZ2ys/sTZtGOVdDQz4PsWPiSGcVd93O5uAr9M8/up3CAUKipwjZ2q7r2ozURYGjiaBX8biI9xYiL966FOW292q4U8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dVWw9UpHQyvHLVzF5iBPPnxRlxnxFnfL4TaPGT5kqgI=;
 b=eiRvPVGLtdDBF8ons3VOSipTq4F3T92GwJS0xA/xlsV67WJwj9Zq/KQYswhDikZ/S1Si0vwgc/4bMWzxU/Jklh1+sj2CiB1QmHxGYFDdlIlOohYwHTVIDBfHwLvvtvJmrHVfbTduWlPgiJgRHi9yOEjqGkvFEYBeHKyfGKubUK1O/E8wSSAkrcU9DeIOw8o6mlg/FIx7yCPrMgLK/Z5l51ba8Bk2uIaaefOLXTTgbazZCLGSmQCcrx9ix1VxAGBHJX6XSRCavaYjy2RBZvA5pgoJ1ayCG1aPvDjtKAxLo+HTZ08QdXtVmEP6AmDGjYto9subc/uMhiL2IwG4fxUxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVWw9UpHQyvHLVzF5iBPPnxRlxnxFnfL4TaPGT5kqgI=;
 b=llsdgQcijQmh7FOGpv1VjdwLhVrmK5ZqjLD/eiUfnZOewA0KDGAr0iX1uau+HxHemfxZfOkkWSV3WaCwkg1WtUrCilUgZxFyFEWUrW/Hf5P1VBvLVwlkQz1wHwE9b02nDiFLizxwwlPJvtoP5k8Tgfm1lZCb/rvoe/DVOQO/iv0=
Received: from MN2PR07MB7006.namprd07.prod.outlook.com (2603:10b6:208:1a4::18)
 by BLAPR07MB8241.namprd07.prod.outlook.com (2603:10b6:208:330::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 12:08:26 +0000
Received: from MN2PR07MB7006.namprd07.prod.outlook.com
 ([fe80::ec1d:951e:982:dabe]) by MN2PR07MB7006.namprd07.prod.outlook.com
 ([fe80::ec1d:951e:982:dabe%5]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 12:08:26 +0000
From:   Dhananjay Vilasrao Kangude <dkangude@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "kishon@ti.com" <kishon@ti.com>
Subject: RE: [PATCH v2] dt-bindings: ufshc: cdns: convert bindings for Cadence
 UFS host controller
Thread-Topic: [PATCH v2] dt-bindings: ufshc: cdns: convert bindings for
 Cadence UFS host controller
Thread-Index: AQHXn8XWQx/1YA1850ygYIrSCUw23quY9BeAgAKwEFA=
Date:   Thu, 9 Sep 2021 12:08:26 +0000
Message-ID: <MN2PR07MB700644C1A937C2078804FFC2CDD59@MN2PR07MB7006.namprd07.prod.outlook.com>
References: <20210826185135.26599-2-dkangude@cadence.com>
 <20210902063754.9509-1-dkangude@cadence.com>
 <20210902063754.9509-2-dkangude@cadence.com>
 <YTe1c7sxlL9HGxv7@robh.at.kernel.org>
In-Reply-To: <YTe1c7sxlL9HGxv7@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGthbmd1ZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1hMGY4M2NkNC0xMTY2LTExZWMtYWVlOC1mODk0YzJiMGE1YzZcYW1lLXRlc3RcYTBmODNjZDUtMTE2Ni0xMWVjLWFlZTgtZjg5NGMyYjBhNWM2Ym9keS50eHQiIHN6PSI3Nzg2IiB0PSIxMzI3NTY2MjkwMzcxNjAzNjMiIGg9Img4UEFNRWljdG05R1YzR09QTm9vRkZxbWErUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8a2b132-28b0-46e7-528a-08d9738a879b
x-ms-traffictypediagnostic: BLAPR07MB8241:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BLAPR07MB8241CAD3DA0E0C047FBA71C8CDD59@BLAPR07MB8241.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWh1E14RWiZCEFexGj7IJaj8u4QL8md1qBkpFoHPVZq0psiVCnwmvFCWaBbTt8FT1+qiHBsR6fcJ5OaeAzMPXFT5M9cSIqyAzRj3CwwGeZGVKafeYJuBiEyroHWyJhND0mDP6c62zrdpA5CUYwatH+GgxHLK8e8x2zmSglI9r0UMXRuogje4rEn3Cl0udClQ28/gssyS6sN/cuedjCUUhsyhHuIGExoBJfNV/wFAw6zxCsr1kdigQhfdeYNlMesnN0gCGXarr9VxjlJOa6Uy/WI2gaMBBB8R/vGZgiMuhHGG3Y1iN93BfE2wQAC83GMN6h5tzIIWKyrHx04Gw5qZo8SmgMvx9LKPWqimZ631WugiO5xgUijxw0QOSPnH6nSFvvl47lzF4350IPDzjq659NElK1XPN1m+hvqeAGV6zSgnq9MSAkl5r19bHkyGm0THJ2I6xJwiBY6+5IysTZVc4h+3g92rhUF5Ic5A/4XJL60yX9XViUCaNSb6iPjEQ1gM9SHdHDyp9cqAW9j0PpklcopkYmfDsjnQTcG9t1+S/yqEqKG34NrimwsnISaY82vK2NJdULk0tU2Y5QLqu6+nDS4PFNuGKuvZ88QHq86bMg1s/cBk/URQ2Di017SJCNpJtnMzT8vlQd5/eGvMRQynY52oUN/QPz34f4s32ohFz7Jf24I2crgpqAAJ396SLwsG3qGRdu7rHj5MjVkpfzb4/l+WIJAZMWR9gOn5cvOPfB+etGauTOXMzudSouF9oOIDUBBQkYJ9CQ1up7IMBJwFF6sOFXOpwhj2rRonObPIHZB9tIcjSAWW/VhBwDHYNfyc0+Wfhdnp8fooxRooqMYPt5oJbts8n8Lr0EIoCg+jSmc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB7006.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(36092001)(2906002)(8936002)(316002)(9686003)(86362001)(55016002)(6506007)(26005)(478600001)(7696005)(54906003)(33656002)(186003)(4326008)(83380400001)(8676002)(6916009)(122000001)(38100700002)(71200400001)(52536014)(76116006)(5660300002)(66556008)(38070700005)(66476007)(66446008)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZQFEXXgVd5JqsZ8RvgfBehgZj78xQB1FvMX2kHC455N/4GRk/qtEzYR9wWvx?=
 =?us-ascii?Q?t8W0hIXuWHJLhAOblKzX7GvRQJT1b7tG7UEqr48BV3Xw25WxUGbefKIdRWif?=
 =?us-ascii?Q?iVUBzZJUTRbUuWs6+9Qmdw5FQyHIObIYC+HO66r6aAXMC1riSNZ5fZ+DnPmc?=
 =?us-ascii?Q?+UUBVyKKrDwXJ6SunMFIvtKnMIt+wdHfiQ8kQuydhE7Fu6SHBNHVrmfiLqaN?=
 =?us-ascii?Q?2WToZ+eazhr2Xzt6vgntaIVBS1UYelrcvM9RLpHqW30NpEgrFhRcrm1SrzBs?=
 =?us-ascii?Q?jEibKml5dZgcv2PtALFl4QVDXtg7sEwkZX2KxcBPsUDpFXoz3diZgTQPcJAr?=
 =?us-ascii?Q?3jUVLN+HVI3odMg3025PY7zH4MkXq1cJC3BbkUDoysRooNxuWIs6wDxnzAt9?=
 =?us-ascii?Q?j4pViHXJ7kbIMjZDHugyua07tfmLtZI3x2inieThTFgkAxaCSevUiWjZjDx5?=
 =?us-ascii?Q?UiB4oom6UOrx6XI/4RwVFZzE3O7bNLTo3RpwEwIM8yXrzQlfNtB7SWxBGNKy?=
 =?us-ascii?Q?XzEl1CtIKzSPZrtg80U9GUIOr6fyK7zlmCuxRLOVddiKbPA5Yj/2RyG2HS2A?=
 =?us-ascii?Q?1Nd/s/CygFAjm/sG2CQ6OpfUticWxlgF0ued8+WdQ9nEgWNl+k3XzLTRHw73?=
 =?us-ascii?Q?RSaQsiv3f0dxhB7LiDtre85VA03Wj1fTnf+i7829ADgM9gTGsbhKXbg0Wy8Q?=
 =?us-ascii?Q?FnzPgnVJtg+oYj5rMmwVZ0PXDt5xUglygTVRgi8IoB9VTSxTYSHK4AWC0eMf?=
 =?us-ascii?Q?s8R32E6METkcuqWEBDspB7y55x2oW9byUBE0777G9hFjEyV0TngARZuKleNu?=
 =?us-ascii?Q?f8GU6dJ7Ie74sBbrsBwlSQkqKQgEbBicNH+soNziaOJSL7LZUFpsQtdhTRyE?=
 =?us-ascii?Q?gUjgOnCUX/ciXVLb6qpTG+EqK7mTu7fMN17rcoyw3hzUvhqBKRtZBSUqC263?=
 =?us-ascii?Q?xkTorybUdSq4Z2Za6SVhcCPE+8y5rf9IGXudWPfzznCyGpIVIqUVfqb3llVr?=
 =?us-ascii?Q?A5CWNAm2l7cFt9kFAbE7cUL0wideoykdKCoSBqtssuzLI7A+j9LikSIIRYcV?=
 =?us-ascii?Q?faPzcGUFJ7ORUxPJoa0GG01uAbiDjAXweDzSedQ0lvZkZB2uyO0tqHlNWd7B?=
 =?us-ascii?Q?DmdiVTfEMfiRqphFphAnExyHAkbdsCjT5JeKOtAJE34B+H3bBs7tN1lTekjG?=
 =?us-ascii?Q?xAiIJVUWIZxq/8gCk+QaFv5u2lfX3orIaQqjrgBomMYWDk3yQreclNZNuOYL?=
 =?us-ascii?Q?qxMNifzVLmQDwwd+hUbMDqpeCOPA6a4S7BNY/OwqT3kn7X5gWRwKQvB6Fksz?=
 =?us-ascii?Q?brEiyL71MGOA8z5Uh0ea/EkS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB7006.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a2b132-28b0-46e7-528a-08d9738a879b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 12:08:26.6414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHcOcfj3lhkroOwMDotlfveQckcdlkV6VwOpC7LHXNlDPn+NU6P6VprUIRBI8vmjZvkMKeg44xE7+cgi8FZlMWPk1l/xSRPyTua7J7voWvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB8241
X-Proofpoint-ORIG-GUID: yopjc2n77bkdxAOHGCUqRDyvv94_1tFX
X-Proofpoint-GUID: yopjc2n77bkdxAOHGCUqRDyvv94_1tFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-09_04,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109090074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Sep 02, 2021 at 08:37:54AM +0200, Dhananjay Kangude wrote:
> > 1.Converted bindings into yaml format for Cadence UFS host controller
> > 2.Modified reference to cdns,ufshc.txt tp cdns,ufshc.yaml 3.Removed
> > power,domain property from ti,j721e-ufs.yaml as it is not required
>=20
> Maybe not required, but should be allowed which is still not the case.

I got it. I will add the power,domain property as an optional in ufs and re=
tain ti,j721-ufs.yaml in original form.
> >
> > Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> > ---
> >  .../devicetree/bindings/ufs/cdns,ufshc.txt         |   32 --------
> >  .../devicetree/bindings/ufs/cdns,ufshc.yaml        |   80
> ++++++++++++++++++++
> >  .../devicetree/bindings/ufs/ti,j721e-ufs.yaml      |    3 +-
> >  3 files changed, 81 insertions(+), 34 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> > b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> > deleted file mode 100644
> > index 02347b0..0000000
> > --- a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
> > +++ /dev/null
> > @@ -1,32 +0,0 @@
> > -* Cadence Universal Flash Storage (UFS) Controller
> > -
> > -UFS nodes are defined to describe on-chip UFS host controllers.
> > -Each UFS controller instance should have its own node.
> > -Please see the ufshcd-pltfrm.txt for a list of all available propertie=
s.
> > -
> > -Required properties:
> > -- compatible	: Compatible list, contains one of the following controll=
ers:
> > -			"cdns,ufshc" - Generic CDNS HCI,
> > -			"cdns,ufshc-m31-16nm" - CDNS UFS HC + M31 16nm
> PHY
> > -		  complemented with the JEDEC version:
> > -			"jedec,ufs-2.0"
> > -
> > -- reg		: Address and length of the UFS register set.
> > -- interrupts	: One interrupt mapping.
> > -- freq-table-hz	: Clock frequency table.
> > -		  See the ufshcd-pltfrm.txt for details.
> > -- clocks	: List of phandle and clock specifier pairs.
> > -- clock-names	: List of clock input name strings sorted in the same
> > -		  order as the clocks property. "core_clk" is mandatory.
> > -		  Depending on a type of a PHY,
> > -		  the "phy_clk" clock can also be added, if needed.
> > -
> > -Example:
> > -	ufs@fd030000 {
> > -		compatible =3D "cdns,ufshc", "jedec,ufs-2.0";
> > -		reg =3D <0xfd030000 0x10000>;
> > -		interrupts =3D <0 1 IRQ_TYPE_LEVEL_HIGH>;
> > -		freq-table-hz =3D <0 0>, <0 0>;
> > -		clocks =3D <&ufs_core_clk>, <&ufs_phy_clk>;
> > -		clock-names =3D "core_clk", "phy_clk";
> > -	};
> > diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> > b/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> > new file mode 100644
> > index 0000000..4509ae0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/ufs/cdns,uf
> >
> +shc.yaml*__;Iw!!EHscmS1ygiU1lA!VP17yEajmecovQs1IfNiRJklavtRgx16eZXg0
> b
> > +G5re3EAQrSfmirkkVpagqs5mE$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> >
> +aml*__;Iw!!EHscmS1ygiU1lA!VP17yEajmecovQs1IfNiRJklavtRgx16eZXg0bG5r
> e3
> > +EAQrSfmirkkVpEHrPgh4$
> > +
> > +title: Cadence Universal Flash Storage (UFS) Controller
> > +
> > +maintainers:
> > +  - Dhananjay Kangude <dkangude@cadence.com>
> > +
> > +description:
> > +  UFS nodes are defined to describe on-chip Cadence UFS host controlle=
rs.
> > +  Each UFS controller instance should have its own node.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - cdns,ufshc
> > +              - cdns,ufshc-m31-16nm
> > +          - const: jedec,ufs-2.0
> > +      - items:
> > +          - const: jedec,ufs-2.0
> > +
> > +  reg:
> > +    items:
> > +      - description: UFS controller register set
>=20
> Not a useful description. Just 'maxItems: 1'.

I agree. I will change the property details.
>=20
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    items:
> > +      - description: Description of core_clk
> > +      - description: Description of phy_clk
> > +      - description: Description of ref_clk
>=20
> 'Description of core_clk'?
OK. I will change it.=20
> ref_clk was not documented. Okay to add, but mention why in the commit
> msg.
The ref_clk is used by ufs spec to decide ufs device reference clock and it=
 is part of ufs framework.
Usually SoC vendors fix this value by using this property used by core fram=
ework.=20
The details are already mentioned in Documentation/devicetree/bindings/ufs/=
ufshcd-pltfrm.txt
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    items:
> > +      - const: core_clk
> > +      - const: phy_clk
> > +      - const: ref_clk
> > +
> > +  freq-table-hz:
> > +    $ref: /schemas/types.yaml#/definitions/uint64-matrix
>=20
> Not the right type.

I have tried with different ref as single array but it seems not compatible=
.
The freq-table-hz property need the values in 2D array format.
for example:=20
freq-table-hz =3D <250000000 250000000>, <19200000 19200000>, <19200000 192=
00000>;

Could you suggest what type suits the requirement. Thanks.
>=20
> > +    description:
> > +      Clock frequency table.
> > +      See the ufshcd-pltfrm.txt for details.
> > +
> > +  dma-coherent: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - freq-table-hz
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +unevaluatedProperties: false
>=20
> Don't need both. Just additionalProperties.

I got it. I will change in next version.
>=20
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    ufs: ufs@fd030000 {
> > +         compatible =3D "cdns,ufshc", "jedec,ufs-2.0";
> > +         reg =3D <0xfd030000 0x10000>;
> > +         interrupts =3D <0 1 IRQ_TYPE_LEVEL_HIGH>;
> > +         freq-table-hz =3D <0 0>;
> > +         clocks =3D <&ufs_core_clk>;
> > +         clock-names =3D "core_clk";
> > +    };
> > +
> > diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> > b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> > index 4d13e6b..b8f73dd 100644
> > --- a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> > @@ -50,7 +50,7 @@ patternProperties:
> >      type: object
> >      description: |
> >        Cadence UFS controller node must be the child node. Refer
> > -      Documentation/devicetree/bindings/ufs/cdns,ufshc.txt for binding
> > +      Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml for
> > + binding
> >        documentation of child node
> >
> >  additionalProperties: false
> > @@ -81,7 +81,6 @@ examples:
> >                  reg =3D <0x0 0x4000 0x0 0x10000>;
> >                  interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> >                  freq-table-hz =3D <19200000 19200000>;
> > -                power-domains =3D <&k3_pds 277>;
> >                  clocks =3D <&k3_clks 277 1>;
> >                  assigned-clocks =3D <&k3_clks 277 1>;
> >                  assigned-clock-parents =3D <&k3_clks 277 4>;
> > --
> > 1.7.1
> >
> >
