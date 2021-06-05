Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3049F39CA8A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFESkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 14:40:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61046 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFESkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 14:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622918302; x=1654454302;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wSq75EYqG2s95aDux1UTBECBoowcZPRtNg08b82OvTo=;
  b=DUVoad+MlE9pIxuoJe6d5Vljm54fbaGbmR71sg4Jh59I/fIyl2QUmdam
   5r46nOWKf++WLSyk5FiNOkgLuFIoDB+RGtfEppEwt1ZOERO0w4rkDIe4E
   lBe4RgGnDcYLf6DweX+yYRrwMla3UoxUv+T0fr/j19mBGlQKEj6JuU0tI
   mIj0MXgmMWsO8zCPbtmcdX9mKzFpPRWng9DbTXnmDUGCp5d+BBwCxBhIn
   NpIC6X36ynMTnxWtbgrBEDG0WSIONk9I7/cxJlDAyPAzkuGeCNB4RT9W/
   xMn72salN+DpmgzHzvC3KLwqZh/abLIv2RnYUiWsq7eYmizhN65a5BGS/
   g==;
IronPort-SDR: xncuawgFPc8HConMqGFk2c3aSY/IsnzjEw0wxHhL0uzY/AGJNSmt8RxL5jHPs+IuvEEfUnHqD2
 mV9JFknHdGa9GEGfcDWztYPkRNqsbh2VsuJ05mqtN1zerQin/aul3Ag8cSOC82bY9YxXZ0nMpv
 safnXEBFQxUKqdZzvLzujmdwy6qPL+x55L4xHHU4BgVCpLSeKdms5S8/l5vPOFc+CgHJ49f27G
 2jySF23yVgfJDaZ/KI+pVPBPasLieMJdFZdBMZN8zubBAwv3rQzdV9LMaoYarePqmKrz1sy7RN
 RbA=
X-IronPort-AV: E=Sophos;i="5.83,251,1616428800"; 
   d="scan'208";a="171428608"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2021 02:38:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXbxGwuyjmS2GXNbPGuvgsKdgL9+/dGKCBH+D6efs85qDeb8UNVhOYZBK/n32+GIk5DIoEfyl/2lVb+ZCj5OK/e3JW+ak0y+K1p0sUXxdh6Xj4euGl+SwLJkddYwE9cEZ/Nixh3YxYSJi4lu713gSfVhTjpyyMFdIE8SHeqwvZMZiN7XqMwOb8jVVpy+3z7qayRgBHFJHFkpEYltkNThRB4A/POKlO7+xa5epDM4sflLiAM1LgGMHkiX1FLUNuLDQlSDVEQRs9XIvdrQtrUYSNj4ZNZG+9T94Lk0tYlKQZVVjrpnZ1bUQouHrVLUIhVNMVRiK/m+aaGjMAOwvtoTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSq75EYqG2s95aDux1UTBECBoowcZPRtNg08b82OvTo=;
 b=hsgv/pDa+LpN+cwmxEz4aiZadizLEUCC65SNkds0jpatl3KRW5Sx+qarX2YuPGwQlUIdoeCDijXdEy2yLtb8Gv90Oo/oNBTsRDFUjDUgDWAdUWJ2Vn/jQbabmQ2hZHBVmMNRpl5tINgdvbaCGFQrJtdNcekuy1OvLkKQElCbSs9CZRpSYG3g5wFuUDzBBjWDm9UXRqWPPE55dqHSY2vLz5T9HBN8rfGF2EY7KDcPM+h4VgK+q/hEI27VUHH3+AV8pixM7NR0JX8xssBYb6/kwQScS6e9u235RiVw//mHzL19cooiqL7u0S3G0vYlw4s7s8rpc/cSMhkMZNyg+t+7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSq75EYqG2s95aDux1UTBECBoowcZPRtNg08b82OvTo=;
 b=t0MEN9+Euce5wB3jetqTczuAHqSkG6JAtiqL8g2sETMl6GNHuQ6XH93Rgil0Xt/oAZTShqZ7YrHPNqltm0dLEGo8zVajmag+6F9BQbQ0ZBPoODp/WXlJN6C36xFzDA+9r7gztOOPhLo2w1fyO/tjOuBKjykLfwQHl4VoTTWVgw4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5591.namprd04.prod.outlook.com (2603:10b6:a03:101::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Sat, 5 Jun
 2021 18:38:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4195.027; Sat, 5 Jun 2021
 18:38:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Keith Busch <kbusch@kernel.org>
CC:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Roy Shterman <roys@lightbitslabs.com>,
        Solganik Alexander <sashas@lightbitslabs.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()
Thread-Topic: [PATCH] nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()
Thread-Index: AQHXWgkrFsyLmW/LEU2L67fb04ZRGQ==
Date:   Sat, 5 Jun 2021 18:38:16 +0000
Message-ID: <BYAPR04MB4965D9BCCF0AF010D283986E863A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <YLtykIn+Or0l08oV@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ec912e1-9bd1-4fdf-4a5e-08d9285115b5
x-ms-traffictypediagnostic: BYAPR04MB5591:
x-microsoft-antispam-prvs: <BYAPR04MB5591E86B0DD9D286A951125F863A9@BYAPR04MB5591.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7aEDGjd6sxBfABXq7yNr5OWHphCdANY+itYcRjSuEbHd/f3ki7JlSGvADG5bc6tPMAHG+FnCFqwUqOQwDZc6wNOXYVG43An25EX53PRZYUjAAajOQy+d0z0ndZMQ98Fy/OQsj1Q8ZcmFAO7+igeAG3hGCDghdq3jlTv7xB9jrV6KMU6LVJ78zegh1zf71Rl+/Rbb6T525ve6eEZGMEJJ4PZGSMqlz8nEoISoywDC15jOXAqD+MnuckvaCUFdu18XJZGiRgUk5qmQbFJ1IiAFNAXgCP/9dubXeu+SNhWvbuz8+QVyij7PxCNbblanSpJD74/ZY1CmqF2vKebYSO3qG4Zu87UcqUEKQdwwmz0zIfLYy8CU2qCSLg8Vv0J/tWj7XftTFngGMbp08JqKiGgqaqIr51vMNNDxdm2BTaHa9D3iN0lmBNVhY5l4ffMR9tM/6xKaR08AriS82oOy4u1VHh5UGchdiGfLt9aff+IFZg/bFXPjMRrRj2jDHno6ZJ08Jt+aNzmC/QD3DXZGPDRczoaScEjOiTnKU2FFnsw89WKptY0V82mAhrPqeHDQzOB2MN6t0ZFntsz97rYNC+h3VV+i4Z6pU4cbyaXbCnpBhKg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(86362001)(4326008)(7416002)(33656002)(110136005)(316002)(54906003)(8936002)(478600001)(8676002)(55016002)(186003)(76116006)(4744005)(9686003)(53546011)(26005)(71200400001)(6506007)(66946007)(38100700002)(64756008)(66476007)(66556008)(66446008)(122000001)(2906002)(5660300002)(7696005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yuQo0AfQVaWg3ksS7RLcBaAtk+7DrtJQygiqxbWIe6BHLZ2L6FzLvIODJoX0?=
 =?us-ascii?Q?Cb2OKrdJXNyRipFTCPSt7ttCpXBufThYgAMyG5Z1ppEOw5npTIlTJUt4Nbmk?=
 =?us-ascii?Q?6nJTa+qLLvj9y+EHbUFhxhwynzRjd+NOYGBZErCi4XIpXm7bRdlfRJx/mXnU?=
 =?us-ascii?Q?gUYWQKqiMzoNC9jpT6HeBe/axlMYueC/cjZn7F/PCU+ww98j9FCk1h5r1Bd5?=
 =?us-ascii?Q?OWgmvTk7o4+7AORmHih+hpjNjy9fxPtlpesMqg8DwjLRYa8+KUjMfZ4sxClb?=
 =?us-ascii?Q?eKFnj8hyb7ze8WsKvKfjP6V+96Jn5hE1eO3QZOHzYqZiYAit738ql47Z6ebY?=
 =?us-ascii?Q?8f+MxsIIpqf8Z//WmC2pKLf+lr8YSti89TorWLhT1+p9Wp49qLAB4uJcDkE6?=
 =?us-ascii?Q?uoK+eSwq2QP+NC+p+Ap7yJRQLlLz6k4DMXLCXDo7AlHEir4ME8GehPL8Ki6M?=
 =?us-ascii?Q?xcqZ5NxLDelNrjv81SY/Q2qvUmhprajun8iUZVATED3oke6mma7nT68GumTg?=
 =?us-ascii?Q?O4x95Z5TEccGp07VQ1hHA4q6My2mb/eiz9KEDgGrJtP11mPksl2iyhHnF21j?=
 =?us-ascii?Q?uFO6mi8UEqRtjBfi79FSyVOIsKKIqStTnEx0hYuFiGM0DImKbkXSWZMtmelo?=
 =?us-ascii?Q?jChwQTkkEeLX09/BVR+zs7rHk1Gc/jKbSHjGtU7bliAudhrNbG6Dgymzc9qp?=
 =?us-ascii?Q?IU9S9P9SQQ56B0GF+RVhNcq3hHBL9KfP0nKzD6Gb5rzXQaTUcwpqcQoz86Bi?=
 =?us-ascii?Q?Tbxolc6ypOCLwpA16//FzWiuDUut1THak7Fe8sxpvJckzwWUv+pDnSx4Qq95?=
 =?us-ascii?Q?m5VQKpqTHGiH1e+tmyUS6yv3vKezzdVOoZg0E4UXGqND9Smz4otY+6hSjJH3?=
 =?us-ascii?Q?DTcFtp9H+4kmp3w8rgOWe7sIDPGcjL3kMJkvcoNZvyudb+9NL5yGIn9/hpLI?=
 =?us-ascii?Q?Eot+5Tzi0iiRvJKjPlG6jKX8SsQO9WTCEbxr+jbab1mHfv1c7k+wz47JhzB1?=
 =?us-ascii?Q?aYkKqPkfDJwmTv9UVnVeAqtTzt4KdWEPXEsJtMF/JcgVsTsfkWLhY9jAFRMS?=
 =?us-ascii?Q?HU0hEdQLeaEjECi1acC7xl4O1JsllhdtwBNrmL+plm52dLGrI0JtuAycdCIy?=
 =?us-ascii?Q?lYAPUzoCTkg4yu+qeqZwoLCiaLS3n4OLIXmswxNcizsjZkYkQptHyr/282xd?=
 =?us-ascii?Q?cQwV0s/NRDsjOL8M9pVk2nUY7ZkktRqQnMAVJ6np+McUp2OrXEQyoePkNkBf?=
 =?us-ascii?Q?wCFv4JsncPJCve3o4iDI6DUqVSFQzyG6NloiCozS2gUgyBCFnmLIN755n7TM?=
 =?us-ascii?Q?bOa2CccxrYPKJVEQzdRYE9CV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec912e1-9bd1-4fdf-4a5e-08d9285115b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2021 18:38:16.8661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvDhb63c16SS26gl5w0ggTUdqRsV4ThjDxMlxskoWcrziI2OhKykZNKyJspiFP3+l8m3T7H4P/jBEmNXUjcSVcQSbfR+oCK78KpbOLUjSpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5591
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/21 05:49, Dan Carpenter wrote:=0A=
> These error paths currently return success but they should return=0A=
> -EOPNOTSUPP.=0A=
>=0A=
> Fixes: 73ffcefcfca0 ("nvme-tcp: check sgl supported by target")=0A=
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")=0A=
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
=0A=
