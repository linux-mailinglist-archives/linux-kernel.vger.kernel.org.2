Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC4D380302
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 06:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhENEob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 00:44:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:62796 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhENEo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 00:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620967399; x=1652503399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DCliY7c47itGt4akZuGPVCj+w7+6M6EpMyEECuznLds=;
  b=ey/5sSNCrMBZSrT8Oc7iqOv8f8Vein/aYCNaBNbposgzY8aCQvNdWlXl
   FCjJdjdEiKrfRtaHagpPRwaID1EOkq5j9m1o87UtAli4Z3Dv/Y1D7GITw
   sQ7xq/btfcuvmglqLblQbXeb0dgvcDTLhQHj9hwBIIdxWswBPBlm2gZUH
   Bix7D0rjdFwgg+IZIJu70Yu6g/g+B91GrF+RpYHd1T/8DIywTC1qhiWNw
   V4E3FdKKFE8qp5m9jpqZyodQm/yFDSXWNYFyFj/ChZaBgOgL27INo2Pwe
   IKFD/CxAk++3tBa1lEqYy0c2B+D1lTSYJypsOgJYdgIDjI6O4Xyfg6VHS
   Q==;
IronPort-SDR: 3EyPWvbJ32If7xknzgNyj5VZ4GhtVac4qaeOfVDi85LBD+cY5g0S1uA0+iAQTJfuhNnU6QWAcp
 K/X7cByXt+OdKH4x48uUrZCIFXbZ/6U/BFrk4H9EKILXD68mKbordB0/v9p+tqKU/8s+F/HCla
 d6WLxKGG3Qjf0aXWy2e0OMGZiI3fOp6Zaq34uRODS/QbxKW5cCm4qxxeFgB/iPtcSS9MTnFcgb
 THPSZ50Y45jXSCtS1dzLGYzQJ8x2qx12Ur5uXEzFzRETHUgqms11YifZCPS5Z49o2MGBZRxM6V
 gxo=
X-IronPort-AV: E=Sophos;i="5.82,299,1613404800"; 
   d="scan'208";a="168697988"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2021 12:43:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhhJ6I+iXBn44aO0ZpOqU/VHFuXYZRFDg+awE13hCytPYkSZ35mftBmWV5rIbZwAp0qArq4juUdIKBZlE/tZ341G/I5zG0a2bUEtEiZOji0pk6rdnrC/ga0DcBipSorVGF4nPyfCSZCve/bbJCgm1JxJbER5/MkEjDv6ojRE0iEf9Fg5Qm5TjJW0S6/HqftEc2SLqXdm4H8rWjvejcN3iOakk87/FjG7zXLLZqgGfvwXao0KUPoXofRAUyRkpedKsgyP+wR/iZYCscKU9Cgbs18JhWRX2sVqHhmdSJtgEm8CEwrfC46MJGcNdCguG733KXTDwa1mU24U2rxprc2iJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsiQQo24KeG8PLUfbV4DcI09KlvHYv9rbMJRve3cPRE=;
 b=eMUBDvj4k21cc68jV6xtHhqIKUH1DkaoDykkoLm21YR+a0nJdvx3DX/1+3rkYLT0TmWogCxX06MaFm09QFEmDN+gQtPMi17IGeIzjZXghTBcsbo/qU2G/1p611aezWJKYXjqot0Au4IUb3HBSkDX5b/5Xt/zkIgL3HObVXDUUuRsXUpedNuwTxRB6EfA21+aYLji35C7eP5np5ApgDS2z1UGeZKYrB0Yhe5/x3xRMjTO0KxLiEZWEllE23MGW7Dujhy4ppovkwmifGOWQGXPsg6eaOfEzP8EUq4OW30MujqBazcXeHH93DPTMeQlWGfvIHbyXhaJPiUiKI3UZ18IWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsiQQo24KeG8PLUfbV4DcI09KlvHYv9rbMJRve3cPRE=;
 b=Zk45WCqO9bPV9poFOSl9/6xd0KwXtMGSXQj+LznTR9jLWCCLGINfFSaTg6xVX+v9EYjCLVjnKujKrDldq+2tldHwlgdo/OzhI0wHbTa1oJXuCNuXUEiIMfAO0UJSID6MMhW0l24FRhhwv1bsv6Ypk/8VuKyr/kawlwdSp6myADY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 04:43:15 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 04:43:15 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Colin King <colin.king@canonical.com>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: remove redundant initialization of variable ret
Thread-Topic: [PATCH] nvme: remove redundant initialization of variable ret
Thread-Index: AQHXR/CdYFyxz/KackyUCDK8JH43mqriZ2wK
Date:   Fri, 14 May 2021 04:43:15 +0000
Message-ID: <AA283AE0-3520-4FC2-86E9-7471CC3B9635@wdc.com>
References: <20210513115952.58482-1-colin.king@canonical.com>
In-Reply-To: <20210513115952.58482-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:2710:3900:a1e0:5823:85a9:27c3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 791a9686-6a00-4770-19e7-08d91692c9a2
x-ms-traffictypediagnostic: BY5PR04MB6849:
x-microsoft-antispam-prvs: <BY5PR04MB6849C476541A9DC5AD0C2B4F86509@BY5PR04MB6849.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gwUG902hoH9RI43XO2Bi1s0ByNlIXLKFeu4CS8SQiIRfd02SkA9K4a+Cn87ZC3oWXv4PDH09EBwvn/Z2lH3P0bAxRBYSJGxx2zFtrVuNOxGRwg753RtZggW9AsCuK8pkpufk80styANtZV47O4PjCOUgbVw1tKQadM2cAiHIKYzyiUSUrBVzyhTvfYerbMmqEmkYGvWkM1DOP0226Qm/wm9GPfljKwgQSQgCTjdJZ9QoOXu7i2QJ25TEg7LKQltWcNvW1rh7CUKHyaQnKttrbOoEP8fPmQN0wDZ7RQUXFiLR3i01pvyUvqQaA0+jhhEnqOjaPqkeczGp05974EkzOacvLJ3w9lNbQNbhib80DgKoGa162sQcsOaDK9HkAurqZ069VmXj4hfbKlfmhfjbCiTHjXMO0npJU7YeinjDCD9lyKU9rI1SoVPGmErzVpZV2oeSdGaGJ8yApihDM7QcrekLF1TJOgkdFeukKSW3b4Fj3Q5Ss0aGX8GNhYMVPoVRVnBgxF1Pxzq6x1vIb2Eti+wP/3gReF/qoDeI4YgbNlap6yvDPJ6RNcpSM3J3BnZc3PQbQr4Z+mTPmx52L6wM6l6HWbU+MhHMlh/PLAjGhzhAtZSlFh4xAKieyRiBcyl2lFyAOVIwykUrSCl7VyDu1wdsGo/PbSkIpRewNcqC5Gw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(136003)(376002)(396003)(2906002)(66556008)(2616005)(33656002)(122000001)(54906003)(5660300002)(316002)(86362001)(66446008)(66946007)(186003)(71200400001)(38100700002)(4326008)(8936002)(36756003)(6486002)(6916009)(76116006)(478600001)(558084003)(64756008)(66476007)(53546011)(6506007)(6512007)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Vfu1ujt8PGXZPgCM8Xvo3w2Oxl/QhdzaAOY0MnQbN2B1pSnbXPdrUKXyiQ3P?=
 =?us-ascii?Q?e94ig677F8uYAUdDKAjKHogIhuYYCFFcpFW7znlLXWy7k30hnvRMHFszpoum?=
 =?us-ascii?Q?DNU1eFwlRl7oVG38fRPRmoctfkfL9JMe3lL9HOWAFaZq8FsDBZrWBteN43C2?=
 =?us-ascii?Q?xMbgXujwsYgjHG0b9KpML6rpJenuW3xZHYXdw5kVqF3+Xbc+8uIbgRLMHKtQ?=
 =?us-ascii?Q?Du1aMWbq0HMgA0M8l9jpJ5Kj1bZYFZn4uFKn40VfzyLprH4vH2FNYqjuWgf/?=
 =?us-ascii?Q?G7/lM0kx01k9dUJZ3jlbYLJOC/8cB0J2LfgOKvJnmI9ZPqX83Sho7EpJ/Udf?=
 =?us-ascii?Q?gHRC3ZSF/FfxGDRbcgu2vXP9TZyxmGuNVQUzsxqreX1MN2w50OdrishjPLx0?=
 =?us-ascii?Q?H9FtpQPhWHHTkJvbmKrc2jeA3IDuBUCxa6eF5eS04D58WGSu8iLj5Pp1ufcw?=
 =?us-ascii?Q?BwWWYHMoBxroRNfJBxEqmGEsg9Vj5dCSzbVPG/ks8LfMawh0wBwAXyjoCkVw?=
 =?us-ascii?Q?gntXB7l+DOGWVk6wJ+cKSe9CSWCYJwdd4KUrNxWvglpnYqQeJydpj5zskCIJ?=
 =?us-ascii?Q?u5elKkvTs6sCmwcuelSZez7DOBySq4MVdZdoqmW0Hz9aKwn+G1RTtiXCS84G?=
 =?us-ascii?Q?aN3kTtrbwJ4JWN+m5unXNCvarGU0wKmF95waCQJEwiOGZHGFdh79GxpoU4Nh?=
 =?us-ascii?Q?6KLUoRbiiHXOjzUQWZH+u1D8NSUbn4+opYSN8K/LVZPI7rxEdKXENfKRSTBn?=
 =?us-ascii?Q?cRvvrZVYswxBHknpi0PDXjT6XZPRJgLhPW83P4TDLhgI9LScZeeIyf8PaA3K?=
 =?us-ascii?Q?WgWCt2ZnLySQm67j7+c6mZbwsqiLfDZs/Pc7x8n4+604kqzQ+8whhIGosjGU?=
 =?us-ascii?Q?/CHHg3zzvrNmFfn7DwSYBRLpvmgN5lMlh7e1fOM+7gmOmUbRalSAuDxgFhCS?=
 =?us-ascii?Q?2O2KFd2Geh7pW+lO9BBnvx9XptVJynONPcH+/QCsTKcYHAwStrcPgqLPd90A?=
 =?us-ascii?Q?NAMEEcBPd2JDdRLiS/W0llQYDsab/pJI7M0jvz6SiZQjCtCuOLk0XLLmgkPE?=
 =?us-ascii?Q?GtI++HBbwU1uFy/XBfkkkO0pP6xPjrFOnwSpt2+7LoiKwjZUCZNBf5hyCb+Y?=
 =?us-ascii?Q?Nwj2beW9rdN4/LaKq7NtqGaOpxmZWgKTt9V5clhLBp1SQGvncInQcIQlhF2h?=
 =?us-ascii?Q?M4/oAelloXcbNFVvQj3X7hMhBFBY6wcrOvwA2QG1FT2+/JDQ5XyTOCK9qODT?=
 =?us-ascii?Q?RXtr3i9kEsHuI+IQJ1QA95+Xo/c+iSlgp2dQGf7oKZshxzBdD9HCYC67BS15?=
 =?us-ascii?Q?fwF9XNLrKD7yvmu4nDyz8z3gTymGQxdvB18ZCWrnDmB9QJexOtEvuFfTXtaY?=
 =?us-ascii?Q?ni9fUTLvjj/6LgswHup4uOhwJ/bH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791a9686-6a00-4770-19e7-08d91692c9a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 04:43:15.2376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0q+5Dvxw3oUgNCzr7rEPDObvWDf4H2kVovHquZGQ7XG2daF97iPcKEoHUVYEaU4Xs78K/JPuA4eBiT0mIqn1k9fizRNIYxX0hsAxm7bXhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 13, 2021, at 5:08 AM, Colin King <colin.king@canonical.com> wrote:
>=20
> -    int ret =3D -EINVAL;
> +    int ret;
>    bool changed;

It'd be nice to move ret declaration after book changed.=20


