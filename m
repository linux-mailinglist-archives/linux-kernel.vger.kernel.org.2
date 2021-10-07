Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7BD424D49
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 08:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbhJGGct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:32:49 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:29872 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232418AbhJGGcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:32:48 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1972qEnK013553;
        Wed, 6 Oct 2021 23:30:46 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bhrg28rvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 23:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM8t44SwiYMgUksrX1HQYfxvtHDc+fgWyk4UdfhBoCk8k14txoi9AO5R+RjT67ed90d7LYtGDutNwXkdBwRj/4AkziQNXIYZ04IJfy9Yv+2aBlFvezOgM7FDsUOnj+J0yB66eDCYcRW0ZDm8rcvCHn2bpMXjD3j8sKptR4XBp9i33Lcj8zkj0rZJkIUfTI/ZS/RfMC28Whq2dXvj971DcY+9KDvn+/90lvZ6yMnTwbs7BPiHWm3UwwucdNBeuHYc34InPN4IZ68Kguk96fmIOcPvlmJ+9SPE2jyaX0zeq3ObQlJCuUtylbnoZE3zQqIn2tlBxBjZIhq0Zjp7pC392Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUuxlxIMPkCN3aLp+zDnOw4iS37DjMJkEzVTGpvC3ic=;
 b=QBoVx708PX1fQz+irH4bkrbGages+c4zR/nbxdeg2pLoIr5trE8HDkr0U5ax6mEDF978NP2gvzD1jUdplIbkQah62kiEH+8VBkYCA8VEYINhHGj43tvSI4q/+8UqwWt0DshZ2YZjnwvgA1/4EfK26wVbY7DwJ6HHIe/T0z4YiJdzX48VsKton5fZosu3Wmsxkw/VooBKt2QNT14c25vV619b0L9ir9JjKDBFacbnUvnMyXKtfn29PEtVpujt1A2IydKjKb7CmuQVfkNLOFrecBbmIMBsaKGZQvhWhr91ANBlMBApHq/ec0BGHEGLPRnU9NAKbn3CSj3v9fo70bfEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUuxlxIMPkCN3aLp+zDnOw4iS37DjMJkEzVTGpvC3ic=;
 b=C/VP6UhmfNUyqCulpQgd6TMNwL22bufHdM5/wOHrAwGoGsFFipcP8Cj0L+sCnqw/Z+Lp7q2BDXQuxN2LLhOuxcKSkTsso07BxEZZRJ4rRGxlyP0xkCgIiEHkJfhqux/cYdcYDKHGc+05H2kFaPxjnp0773VPZB5sWbI3ChJVFOg=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1429.namprd18.prod.outlook.com
 (2603:10b6:903:111::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 06:30:43 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::a5:2895:8ddf:e726]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::a5:2895:8ddf:e726%3]) with mapi id 15.20.4566.022; Thu, 7 Oct 2021
 06:30:43 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu
 driver
Thread-Topic: [PATCH v5 0/2] drivers: perf: Add Marvell CN10K LLC-TAD pmu
 driver
Thread-Index: AQHXpKmvLbIyd1MMTUy5i5BlP65Pnau8ahDwgArTNAA=
Date:   Thu, 7 Oct 2021 06:30:43 +0000
Message-ID: <CY4PR1801MB2070E39832569F339D8F9439DEB19@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20210908120425.10084-1-bbudiredla@marvell.com>
 <CY4PR1801MB207038FD04A714BF15DA88A3DEAA9@CY4PR1801MB2070.namprd18.prod.outlook.com>
In-Reply-To: <CY4PR1801MB207038FD04A714BF15DA88A3DEAA9@CY4PR1801MB2070.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cdb2d0e-2c18-4c06-412c-08d9895bfd5c
x-ms-traffictypediagnostic: CY4PR18MB1429:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB14295B4DA4889BAA9C8C9B35DEB19@CY4PR18MB1429.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uKziHFhqxW4jQk1vKyaJG7tCugAlhyGt9QlBkOeus0PXIoPs+sxtmIwc2u+DaM/K99DYds3IZ0XrlxLByp2MAE2HfjA+I/HUhsEBSjawBhqkK6faT71WaFJZ6WkMaRJOuJGzRrskP+SHpjQl5Bp4JYs8pdyeVjokokSIT+LKnpxLqbjrt3EEkm3VopxGykJRmJce4IZt6fykbBbt9IJDy0f/+bp3p+B7vNi7onn+3wT7Jxw/+jmqT4YtIQyLKaB0mIoN0QMDB9QUGPzS46RbaR9Fa+QtiqSG1w1v8/Fq1AHMX6HXMoEK11OOkyGADPZYidm2C2xHzc7VoeDZWNOLqU1glHcJwvfKBKAvhCLlGHEbD7XXKmavdQcFAzgybHTjOeGNA8NU28kWft2L7vEFnKSgtQOpOvpEw03jpS80war72lw8QgGEuGSw9SAKQmZTUFcV274ey8jlAh9TM9KrvK0INDRZS2g5cpzDHlgT60AQgPfZ8nk6ayVR4zhHcssB+YWspiqmQ8uFCDBAGsMhtsr48Uqwbb2v/ru6aGgog/o3DnjBT9bXbFQFOBGCKCUAXnuIEY8fLQ/hyjJ69Pvhk/8WT6pp1wFZFgwtmIoMYZ6nfYaX/15rvtNQd+Bu5IW0yygrtpX1FHxZvGrzp4SJgemJmoYai4XnEIKcS5CLFdcZnEACkD/BtxQGWMG1j5royBCNC0udNQn8Tk55U1lGQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(186003)(54906003)(508600001)(316002)(6636002)(110136005)(33656002)(38070700005)(122000001)(71200400001)(86362001)(5660300002)(52536014)(19618925003)(55016002)(8676002)(76116006)(6506007)(66556008)(64756008)(66946007)(8936002)(66446008)(9686003)(26005)(83380400001)(4326008)(38100700002)(558084003)(4270600006)(66476007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Jhz4pEZMZ3oTt+OSqzwdsat8fJcLohkG0YTv/9YCzMqhIYNYTRY6uyAPBdI?=
 =?us-ascii?Q?l4H7FXj7VHWpWATiPKChWdA9/oDQgWjbVea/TTROhAOtggieUvQzNmPKTypW?=
 =?us-ascii?Q?BvdU4rNdg7k0HwspFBOg2nSgZ/EJUY/LrK4hMA/tbkT1IsMLFFDaCLRzsGY5?=
 =?us-ascii?Q?BwLx/JxC9RZBGhQp0TJDTSWYCR7uu4thufXWeDbWlsrUmCOyc7UBxcLTLqoO?=
 =?us-ascii?Q?MdMDuTAAumsRH5QndWU4Tw8jkZaStDQLP091uco4Q8XEQbfjlnfAgtUQrLc5?=
 =?us-ascii?Q?UfdoJVpmYwzniDNzCuEPbtBIILRE72K+LVDO49nBAYz/sCHuSTGAueimsD6c?=
 =?us-ascii?Q?ec+r/bQNpIJRi0Sz578rt1g+IMqV4LASzPTu50RjXBa1J9Eoj/x1RzaOM/6l?=
 =?us-ascii?Q?Sy5l7Idcs91wr8H68SqMISNS3MOSdxIEaZJcL6jVTVjdwNBSEnAsHSLlcCML?=
 =?us-ascii?Q?tG74FswvyQU0PNYeUyhT7+U2PTXmdkwocPd9qrlK0mlnIk7HZN0UQvNTVkmC?=
 =?us-ascii?Q?4aYw4IQ+cXzccOawC119Ayqsp7FCK7FxA0CbSJ0AIn3yDjqli9EHbYDa6/mD?=
 =?us-ascii?Q?k20X5QPpFr5+abciq9kSm33nPVHO/3J+TSeLH8EjDJznx4l7UHhOjJRKADme?=
 =?us-ascii?Q?a16I2LZdx6RWsju/p96FcnPpbj/+GZFrocc/wIYihJ4NYTyeAFsfBzOmt9Kk?=
 =?us-ascii?Q?2Yw1NdVpyTy1YTWpsq4K6CB9DdSta8CqvsjhpmuALLbPNEzeCxhRjiKkRW5m?=
 =?us-ascii?Q?JJh1nlUwzyQCexJICQjR3QRLcfxhksX4n0K1xzAOrOWWnaDiO8BsBdNNxLMB?=
 =?us-ascii?Q?8pEeNY4izWxlmYIYUps+rUWB8yiaYd3QubgD8YvJFlKX+WOsbFpE1EzEX9OI?=
 =?us-ascii?Q?RErbgroUpGKm7Mwwm+NvhIxscbMbyKyyxtmVdyFhreP2zsganwz/vWjFLfzw?=
 =?us-ascii?Q?nF28opDgKkeSgnV15+eb3XG6pdGEHPZS4iV2gnIuW6orXqSVkKSKQ+39ONEg?=
 =?us-ascii?Q?e2UbDKvM0L7N2R1SqgUNJBaBq7lBZ3rblqEsSBeaTC1kgAxNVWgGwDDh2O5G?=
 =?us-ascii?Q?X4qx+wgMR8ZsiRXqQtH78y+v5epgUBlOCz7Ko2GBVlqFd8SVWhvNEZwfB7JO?=
 =?us-ascii?Q?jqCNu4jMrVlk4hdDYZkvRwaWHYjAx6blYQ0sZi1OJgN9E5TWUz4SO+RqU6Md?=
 =?us-ascii?Q?b6ISSPgHlhtymS06iJZl3wJyUBOpG7fE3HFEBtEwiA3MN22NJNIPxQ5dz0sL?=
 =?us-ascii?Q?ZR2T0iBSIwFT7fRulCaLvB/K4qzprjiECxzRAZT5FmrTTDXjrf0epr3HcSh/?=
 =?us-ascii?Q?N0yQZYaWK7W5ENT+pIutdzdS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdb2d0e-2c18-4c06-412c-08d9895bfd5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 06:30:43.4327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wceDRT9h0eUSR2IbjIAg9JgYnnB14myRgQgzcmufgyltgYE0XUpGlibVWGmt9cMG81F7JnyJg3/WOjd9OFB3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1429
X-Proofpoint-GUID: tIqepiqmV5pzrZWsq-U3p2cAtdWBSyZy
X-Proofpoint-ORIG-GUID: tIqepiqmV5pzrZWsq-U3p2cAtdWBSyZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-07_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Do you have anything to add?

Thanks,
Bhaskara
