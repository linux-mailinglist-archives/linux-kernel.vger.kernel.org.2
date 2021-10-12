Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D35429F48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhJLIGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:06:06 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:7130 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234831AbhJLIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:04:26 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C4UeSk024079;
        Tue, 12 Oct 2021 01:01:19 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bn3d58sd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 01:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlHwqMwRdvpP9Cs9VjIceQM/ooECZHurt1efV9mbP0CRWN7Wvb7Wfjt8ppDHVw3eMkPGVhMd/sEu+kK/r7nt1FPIBthVGin46pS/cuS6CY/3vZKARyoURd+zq0fxNvawHJuNhWNifNRfbuDJXfi1AW5KU8CeHlPdlYDa+lMQ2X/BipDkRvjqWNzrp2zXRmnVIJTX44wTkQCP56hRSqd9QpTbpaNQkufEdhfE9vpckXhtCj6j/txG1J1fcecGgL/wlwyVEZJBpT78CFzF9Q/uvVuvgDuTZAdKE2l0Aiwayw06HBWJC9pRq7dLZMqt954sdkH6mAbLjDVj37GfLaxKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HHAOHPoK0m03bIuBX1soeFD6sG4WnSXyUJv1OKLrLE=;
 b=i6w/tgBSA71+gYYS0zINSh9jhFn0BsLD0bC9t+ZeQQ+F8iym1R4lgi0QMAaiWaUQCsgks0EPyfJpN1wXCp2v5RDpM2dIYfY6q+rPYA/xsbzfcWisVPdYzB24YlHSjbRTlDcLNmUKDhnr+A8bGNt6FHBf/89dCNXwbtCORRShzOWJurkDw8Fx3HymPYppkLupXtGTwH7zqUz0XrW3xjA8c2vX1sS96lIwBY0GPGxcGvi8/O/axnNjZJzZBmuuXWU64ybfJLTz/7E9q4ghqbzQdCETFEjfNQ7AnxK3hI5iPLKytqPSNGOu1Yb+niEMMxIlQWXN+EISd/HOdCtKIds3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HHAOHPoK0m03bIuBX1soeFD6sG4WnSXyUJv1OKLrLE=;
 b=o/7/Pvb+zcGQsGWqfnkkwUnkjlGartfFtOYx4t6P9R3lnNnWLE8o5GbI9a8E1MYY9ls3EarlcwlHLt+4I6gGk6vqvgqDgQAN2CJ+GozFwmA+SdYoZlOpxkIyRwymX+3fyl7oAsDRuhMkl0xTUooXLsedU9T2PqYjoe0YPYWWY8E=
Received: from CO6PR18MB4465.namprd18.prod.outlook.com (2603:10b6:303:13b::10)
 by CO1PR18MB4731.namprd18.prod.outlook.com (2603:10b6:303:ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 08:01:17 +0000
Received: from CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441]) by CO6PR18MB4465.namprd18.prod.outlook.com
 ([fe80::9da7:4d20:98ff:e441%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 08:01:17 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: RE: [PATCH v4 1/4] dt-bindings: perf: marvell: cn10k ddr performance
 monitor
Thread-Topic: [PATCH v4 1/4] dt-bindings: perf: marvell: cn10k ddr performance
 monitor
Thread-Index: AQHXrd2QAeaFlYZ6v0i1CQLBIKe2qKvPIuMg
Date:   Tue, 12 Oct 2021 08:01:16 +0000
Message-ID: <CO6PR18MB4465DED5DCC796015DC59006E3B69@CO6PR18MB4465.namprd18.prod.outlook.com>
References: <20210920050823.10853-1-bbhushan2@marvell.com>
 <20210920050823.10853-2-bbhushan2@marvell.com>
In-Reply-To: <20210920050823.10853-2-bbhushan2@marvell.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e92416d-1196-4c1d-7e9b-08d98d56782b
x-ms-traffictypediagnostic: CO1PR18MB4731:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR18MB4731A0F67784A0EBAE87CDB8E3B69@CO1PR18MB4731.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +5OYdMd6of1EbP8ekp/W/H0cdShheCm7blanjKglkemGWsu0wYv1Cb8R5RPtdaC9PzSb7NPVP7DuMq+KQG71ME0FkSbtC2cy3MH1qzyMcIyZa/f+fVEc0wmWdu0Mh8vMNVLrnf7s52/h0VFwbeahWyOdDxruzGcwByd8VUnls2/EPy6XqbT/ANDFjObewr/PP06H7gz9EjSgZYg8sHXE4Krv4Wpok4xGsTmKFXBUlJD8Hc1nDzyRGvkkd3+RyBYNMIPR2Tz/vvmdXRW07lJKSbDFxPj0NnA+BF1T2SIFhJI4zEyPdBHfHuvgVDxeKwLfQSzdQlZeTuS57IC0/6x1PBhZ9Wcx9W94zcVmmdOWcFI40ipDTRsSxfz6LDmVEVZGxihm7/7pPVyVREu3oeCKZO7U/7dL6tjLTpQO7IK10J0053phsVQPplVwu/2j4QPpfK6E6gcHGCRn/Luy5bFy9TrhnYmvkKh6YBfiNfkWsgOtyhbKBp00eTA6a+hIciTd/kBWxllCldAZR52V+ZxtuHnvecUDyeh98mz2wkYX1iCDEpfh5yeZsVn0EUXM1tiDb6s5OE/n5G75kZ8B/LzZOyk2/eCnTfL1cvr7M6GwLVZFiZxAw3CXvxTZWtBJXQiigx5DapMIo1Va2wNM8IzrG20heIzj2QiSeA5ZzLj6rgG1lYkUI1xEf+JwXxUaBd39jRtJN9EvwLv6Os6Tw7VrNHQ+TN6t8WQBERW014modUWUEc1H4isnczW2dUSG83YpfGwZkYLFe8IUL9NpC4VFDTxdZvzLALddFmbdxaWDBQXuzPPc1nQoX2J9EhMcL/kMishE5h19LXXifnfiKpIcfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4465.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66446008)(64756008)(66476007)(66556008)(38070700005)(66946007)(122000001)(71200400001)(86362001)(38100700002)(9686003)(55016002)(83380400001)(5660300002)(966005)(26005)(33656002)(6506007)(8936002)(186003)(53546011)(508600001)(7696005)(52536014)(2906002)(110136005)(6636002)(316002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lVJX19wBc5gUHpkpdncaAMaVhXw26znz5zUvlo5Moi1WWegbq3pDP2dsXoio?=
 =?us-ascii?Q?O3+mfZ2tRNqjDqWf3CosI2wTlPxd6BXTy+RH9DMtzZptGnDBXjWSwkvrS1dU?=
 =?us-ascii?Q?pnr3tGh/UcwgphAC4RlLRtOgrlHV+/mMEnR9yLxkHR7btZv224iXE+p4HOwB?=
 =?us-ascii?Q?BtYfHcn3bPY5N0+b8pnOZgI+83rMFkS23YvOR9hyi3vF1YohtblALCGwTwME?=
 =?us-ascii?Q?6PYMCDrKoDAej9EeFPo3QM6l/815W0a5IWFPv7va8g0VOK5nS8v6NJ3/ZLMa?=
 =?us-ascii?Q?HKk6VjSWNtPX4vrSXAJjpKqNDcQFziKyTPWY0U+5OPXVrTl5ylT4PxI9CKzY?=
 =?us-ascii?Q?yZySsh+yz23Dg2kMUGV2qMfBMrOAHxttcphz5CBWAwZ4vlwpP3nUA8eLbmit?=
 =?us-ascii?Q?rG0PKTY20rt+EZ4l0UEOBs1xgW4iu1snHkLbSyZmdsVZTxECjIeGns2lucmQ?=
 =?us-ascii?Q?Xw3v/vG3ceH+Zb5WAwuBFzwShqRGXD+8N7EdBLAKTf6nz7f2VCBuK2MHEp9a?=
 =?us-ascii?Q?Ozso6Su/WGWtjBAxhK2iOpni8CTK4yQ5/CvOtgzP0jaUaNdCLg5B8FLIB/Km?=
 =?us-ascii?Q?ayFLGQOS7Qo3ONQxNRLYqlWtOwBs+v1589HKxehJuhw8WRZFTKOJGaKWIdGJ?=
 =?us-ascii?Q?tngB/ip/iSHgO4gsC09FTHYWd536ZDBdo4bvE6E9KVsYD248hcF6splp41Pp?=
 =?us-ascii?Q?lNesv6aEW2zPwvGzefae63ZkHFECHP2uHqOnETykQUwX5SGyaRC9rEZJBP0s?=
 =?us-ascii?Q?A371OKDTC0q1sFJGpcgnzMrDiz3PUvSDtDgZiX10/lbInzYTwuNrnrVbNlhn?=
 =?us-ascii?Q?BOjKKHfIENAgRDid6egypjxVsNS+QjEpgaa58+QvCF0OjDQimWTYJaRSHB1V?=
 =?us-ascii?Q?yz1yo7aQceVmyMhKZIZbMN5klQ2fb7rF1OOWZuUaPIZlFE75K37tJFMtqAGS?=
 =?us-ascii?Q?689cE/l3p3eyKg/pIpOq1nm6U5Zlf/zKcfeDKlWA4AoUW3r+28KFqU1Cr9R4?=
 =?us-ascii?Q?asSB0+Dnus/vj4gZmZvv6VPIgdUMlK6K0Pr2isQEWbzpYPzaW1AIlQbgH+BT?=
 =?us-ascii?Q?QIlHrMiXBPNtot9fkmsmlMY4OCtTsEcLoh8RUS84KVHoh0iiuXZNXoAzLbeM?=
 =?us-ascii?Q?Ir0ZrMmPZd53XnYwFvCZp2a9rw/32j76e3JWbgESwWiUxjBHmfeN/WZvBTod?=
 =?us-ascii?Q?giFhKgOEHkTQnk58qN0fjxY1HFfkeyAVand4usR1sALzGZlTB7IP6do5plvp?=
 =?us-ascii?Q?mgVs0+U4roQy+p42i9pg5MmrT4O/uP3BD9CjLe8Ht41I5T75lXJ92C0VtR+m?=
 =?us-ascii?Q?RFtIYAQSBW/20RJUJp8tyDyL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4465.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e92416d-1196-4c1d-7e9b-08d98d56782b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 08:01:16.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SvLFty9wsM8EanZnSACQJi1Tkh8gyjqToeH3VS/zFRzpQLMAd7+A8kFB8mQka/iKeHGNI7dv97akASFXD14neA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4731
X-Proofpoint-ORIG-GUID: nMgyWkJ6I_C6faHHJlLeTfSBYWOEvIRB
X-Proofpoint-GUID: nMgyWkJ6I_C6faHHJlLeTfSBYWOEvIRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_01,2021-10-11_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Bhaskara

> -----Original Message-----
> From: Bharat Bhushan <bbhushan2@marvell.com>
> Sent: Monday, September 20, 2021 10:38 AM
> To: will@kernel.org; mark.rutland@arm.com; robh+dt@kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Bharat Bhushan <bbhushan2@marvell.com>
> Subject: [PATCH v4 1/4] dt-bindings: perf: marvell: cn10k ddr performance
> monitor
>=20
> Add binding documentation for the Marvell CN10k DDR performance monitor
> unit.
>=20
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v3->v4:
>  - Added Rob Herring reviewed-by
>=20
> v2->v3:
>  - dt-binding, ddrcpmu@1 -> pmu@87e1c0000000
>=20
> v1->v2:
>  - DT binding changed to new DT Schema
>=20
>  .../bindings/perf/marvell-cn10k-ddr.yaml      | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-
> ddr.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yam=
l
> b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> new file mode 100644
> index 000000000000..a18dd0a8c43a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/marvell-cn10k-ddr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell CN10K DDR performance monitor
> +
> +maintainers:
> +  - Bharat Bhushan <bbhushan2@marvell.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - marvell,cn10k-ddr-pmu
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        pmu@87e1c0000000 {
> +            compatible =3D "marvell,cn10k-ddr-pmu";
> +            reg =3D <0x87e1 0xc0000000 0x0 0x10000>;
> +        };
> +    };
> --
> 2.17.1

