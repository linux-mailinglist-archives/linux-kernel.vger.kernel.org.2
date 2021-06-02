Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67B9398568
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhFBJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:40:51 -0400
Received: from mx08-002d6701.pphosted.com ([185.183.28.62]:40640 "EHLO
        mx08-002d6701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231998AbhFBJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:40:49 -0400
X-Greylist: delayed 2838 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2021 05:40:48 EDT
Received: from pps.filterd (m0132501.ppops.net [127.0.0.1])
        by mx08-002d6701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1528hPNH003458;
        Wed, 2 Jun 2021 08:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flex.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-transfer-encoding :
 mime-version : content-type; s=dkim;
 bh=KZADgBN8J8JzfOelwSBd5Jt1cvW38plidzl5FPNnMKk=;
 b=TfAPFLPv6E0BkWlxsYOSGjbV2UlZD4OavdbiXLh05vIaTxnubs4JgAEFw9xi4C1+0HvF
 nWsFewivU708mlDhNltJhgx2bSzPBGcRJwJA/rU+QsPLZfD4bVs9WM8V76Y7A2C+pmHn
 F6TPzPFcUgSt/J0isUvmnNHXABR5uSxi7mGiENRYQj3EteEYdOemAONGV5jY6exWNbJX
 c5eq4rL7m64PmaLsrmS4BShAdI2EkWKMLLefiaEfT8iArPKqH6BbjzWbkTy9igXcysB0
 IlLnJ82qUsJ52uxTlA3gPWmjLTt3V+1MBIVpqNxccjcwo2s5Q3CG73WQKcAwQFCDVyKM bg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx08-002d6701.pphosted.com with ESMTP id 38wwej2mc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 08:51:25 +0000
Received: from DM5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:3:23::18) by
 DM6PR08MB4155.namprd08.prod.outlook.com (2603:10b6:5:8b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Wed, 2 Jun 2021 08:51:21 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::2f) by DM5PR13CA0008.outlook.office365.com
 (2603:10b6:3:23::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Wed, 2 Jun 2021 08:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 144.49.247.24)
 smtp.mailfrom=flex.com; metormote.com; dkim=none (message not signed)
 header.d=none;metormote.com; dmarc=fail action=oreject header.from=flex.com;
Received-SPF: Fail (protection.outlook.com: domain of flex.com does not
 designate 144.49.247.24 as permitted sender) receiver=protection.outlook.com;
 client-ip=144.49.247.24; helo=mail.ds.dlp.protect.symantec.com;
Received: from mail.ds.dlp.protect.symantec.com (144.49.247.24) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 08:51:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMFNgP+S8NdPxTig8vYyRHBx9jTn+wWkcvvwxnM02rpCBrJ+yMUPOrBQbe87rZ48fKcU/8PlSKj9NPdrqfa9lL4CwHl4XRoOpMSbRF8DI/rxTeMVfggbeN+HsekNeqGkzmEYt6E3Askzn+3P5Sqb1JtmIMGuxTx2TqQCsu66h0PSC98y400ND1SsuShS8QqgA2kUEWbmAglTKMKrltJxVV0WGc0lclaB8veF4Rm0Ai4AluzAKTLiNQFV43Z3IHK3pmdDcYpI67mENZ6jA2d4cKKRAUgG22Stgf2Y7kvdWeP+z1ZTUx6azyJ14l8/onDl9IevXOfE730tSb4q3Uhi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZPvnl4N7BrW/XPb8DdXJ9qItZsSfB93XhTn+4mSv2U=;
 b=LeAMyumjZhvyRudRtqBqZ3/doWugtSLFMtvb3ss4WSPExnCXGdqDVv0rvjXpqcc6tm5cuyUeXHupuKz5uWBFdwK9BhSseOphjScL23O+GHjD9dQ+2KHZwJBDPP/4nDnAIn7llhSc4Vj53Hlk6eP6ihv6UZs9B22x5Ao7cziHEZ/IC+WXzcPhxGJeVS4d3elv4jXkUDcUA1L7Ml44MrOloEx6LB5xrDEfgrCRKEdLRAJabEc5yenm5QNeSvh9rVlSWK+w58eMY+WQLphaNIhm5KqDcdtqB9JC+huxPAwtF0OQ3c2cFeslxs/h5QJ33fCmHrKFiUwrdYcMt2Kj8j4yfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=flex.com; dmarc=pass action=none header.from=flex.com;
 dkim=pass header.d=flex.com; arc=none
Received: from BN7PR08MB4113.namprd08.prod.outlook.com (2603:10b6:406:92::11)
 by BN3PR0801MB2258.namprd08.prod.outlook.com (2a01:111:e400:7bb8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 08:51:19 +0000
Received: from BN7PR08MB4113.namprd08.prod.outlook.com
 ([fe80::f55a:e2ef:e21b:c3eb]) by BN7PR08MB4113.namprd08.prod.outlook.com
 ([fe80::f55a:e2ef:e21b:c3eb%5]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 08:51:18 +0000
From:   Daniel Nilsson <Daniel.Nilsson@flex.com>
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 5/5] hwmon: (pmbus/pim4328) Add documentation for the
 pim4328 PMBus driver
Thread-Topic: [PATCH v4 5/5] hwmon: (pmbus/pim4328) Add documentation for the
 pim4328 PMBus driver
Thread-Index: AQHXVwVZZFCC6z1+CEuAuG2gFdeHBqsAX9Ng
Date:   Wed, 2 Jun 2021 08:51:18 +0000
Message-ID: <BN7PR08MB4113324AB919FD76F8F30FD3ED3D9@BN7PR08MB4113.namprd08.prod.outlook.com>
References: <20210601164320.2907-1-erik.rosen@metormote.com>
 <20210601164320.2907-6-erik.rosen@metormote.com>
In-Reply-To: <20210601164320.2907-6-erik.rosen@metormote.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: metormote.com; dkim=none (message not signed)
 header.d=none;metormote.com; dmarc=none action=none header.from=flex.com;
x-originating-ip: [158.116.250.30]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ca79f0e0-7756-4065-7a03-08d925a39835
x-ms-traffictypediagnostic: BN3PR0801MB2258:|DM6PR08MB4155:
X-Microsoft-Antispam-PRVS: <DM6PR08MB4155F4B46EFCBCB369C0C601ED3D9@DM6PR08MB4155.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9oFmikdY7mTHGVv5kCaD7X46P74WJiu7c4sJXHmSHW6k1kAez3VVgzQ2tNEuBVFGboAr1/AdVi4Oba8pD0HqqXoNCQUedQJacF5zrw9wYefuAi1vOn4UEWBKvn+gRIqATI9I5U5qnq+eqIR5cIHrjUljchoO7bV78i1usfhQoad5ec1S58zZTnH+f2z37S0ya6yvVW1QdO5KliHnqYXOd/tMbRDZDvc9v0kxcGeePnC5nHm801utTuz/To+EMKOBh7YAda5L36HQrre/Xz0Pm3b/oBvKKq7r+gR2F850F2b5qyAC8jy9c2FNXZRH/iyvA0j4uqBMa5kdx1VnFsPgSt5dwpA2W4hnK9Ulna/NAXNSsygaYWRrv7O/y/yQjWU2RpQqEdcydYqmeSuc43vME+5JmMbQLRl8AlCXu0+1z9pcuWtwEATEJ5ga0tSnSZsaGuW1YdzOkgrDjMEWAE/MlAhG1Q3G78qqUZxaGhJv3mfZB9qrdY647rFC/lPCrQD1rJAUv38lKhyQTkXCHvk+IQ0FWM30Av6AgUFdf3ZXOpgujNTXGx7S4Xa9/pJxLYjggdKDcjrkMvvPy91+9F/jrNJiJGxMaM+WUfeu9dJMNRo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR08MB4113.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(396003)(346002)(366004)(7696005)(478600001)(66574015)(83380400001)(52536014)(66446008)(6506007)(66476007)(316002)(64756008)(8936002)(71200400001)(9686003)(8676002)(33656002)(186003)(26005)(2906002)(5660300002)(55016002)(76116006)(4744005)(122000001)(110136005)(38100700002)(66946007)(66556008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?3qp85F4RUnjdp6AnUJnLr/bxqyzUuUSLe3u1/J2hk5rnpMGxNARM8lROYW?=
 =?iso-8859-1?Q?ehW3P0F8Jua7BjiccI/ijneOYJi5H+CG1ZLygx/1k3x3F3Hm5+pzMV72GZ?=
 =?iso-8859-1?Q?fGOCvpyl8H4Bc2ZpiX1K7fODvBPq+aur+WpVLEp3CJdzlsAn1WCRAsnSda?=
 =?iso-8859-1?Q?mnBvKeMlFxjFQAyvHOhAbIKNd2zgcihAw3sVlc396NHE2NJGUGo57VQlwi?=
 =?iso-8859-1?Q?HrxLo7cko3oI4fZZFsWL5iG5lTSy5lDDoK/WupD87OLOBC7+i+ONGpSRYu?=
 =?iso-8859-1?Q?xDj345XQqD1Gr8fiQHsDMaMT/mCFOswhwSaVOPA1MOjaU7qt1o2j71KkC5?=
 =?iso-8859-1?Q?jrpAsxVcW36J8UFW0i8nJbDwgJgI91ZdHeZIb9VXBAU74fojKHHj024AtD?=
 =?iso-8859-1?Q?waV0O2fLVA07BqIO2+IQ2rJJGF5vXHoh+okiiCJaWFOJOShHkgHllSBknX?=
 =?iso-8859-1?Q?6TSN1SfdeG30P9sTN2rC3a5vIpIkQow7p57w8BpNJsVDIVP+oHQ5VRNzwV?=
 =?iso-8859-1?Q?BitIk3zMwaMr2j1H+KEKiRMBcC9XR5J7NEOtlrb1XCqth9HV0cQnenkKAD?=
 =?iso-8859-1?Q?HcFdakpBhZ7TOIkNLFPeM6d5FoBkIyZ+YWHg+JZ9zi2hiTeOMj4TxyWb0Y?=
 =?iso-8859-1?Q?/aOwpHjohB5jRbsjB3OgH+zRpLU4KmwL1q6Cu4+uHU37sjah7hUSaGs1D9?=
 =?iso-8859-1?Q?G7vFfnrMjygOvjylbyYy4wmCrLc713HkJwaC3FsK6J+CAWw5jBaTNGXiW/?=
 =?iso-8859-1?Q?QtwMtpP5BEJnnDJeJQSZQksEsRe6dRShFGMmj8kIeyRaZNITD/5RcpzAjT?=
 =?iso-8859-1?Q?v6pJnWHV0B4nM7fVGxYLXF7vFvxXMMnvF81+jeVo8UHfLIRRBhBk8pJWhj?=
 =?iso-8859-1?Q?7XlIJZeKLacCK/WxN28QnK9sXQS2SSJ9YByGDNIEK4kOvdmZzc40vED4nd?=
 =?iso-8859-1?Q?w9bgnWIXW2I2fziLjNuYyk+MzsOl+5iFC2jR4P64WPKd5uxw1Uu+72enDu?=
 =?iso-8859-1?Q?853HaDcnQQRnIlfDo8mozC/4cJfJAUwqSEArjEkxV+61SgSjyK43vb+j7b?=
 =?iso-8859-1?Q?HZUjbrc74rKbfwubBHkTZA8RPLXEKP8XqPDSeDG5YZCra9ZrGfEHfplJGX?=
 =?iso-8859-1?Q?bxiYPYbxawQQM9OjgjP3E6/4aGB4nQSl/pO4r7Jn2svuuwfow/WYpbxHwU?=
 =?iso-8859-1?Q?WYq/L+8hgiUYzeRVCuwqE2OJXEHeqmo9Jv5jzNxWGpUYBqZ7vV+gfVJV4Q?=
 =?iso-8859-1?Q?zQYn1by+c5O6bvbpbxG3BLXDLnV2R0I2BN+hxHEORwFp0kHTJ4t5WeQw4V?=
 =?iso-8859-1?Q?yAdZU1DceUsq0i4Vj+WFLD80J9uOydjOHsPHN7RPn1G2yig1k4NituF3h6?=
 =?iso-8859-1?Q?dmxcjCNRY4?=
x-ms-exchange-transport-forked: True
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2258
X-CFilter-Loop: Reflected
X-DetectorID-Processed: db4f4c5a-5dd2-4f21-956c-7ab15d947193
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 55db632c-8aa4-4196-98c9-08d925a396c3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zviGechTwrr9myTVaewfTkZB01+s9NRD8UcZRJJy+7Fnou3IqGhHutbMBNFxW4U+EizLoHzXp/8FkMP5BqvaIGyzdpi27gnq1GBlQCgOhCkjfMLcthigWO01ivl2qDT5AwQf8FlyuuLR28l4aLAy03PRyiikzvWCwNglHcEBEQSe3LT1eZDAVY0iIXRsI6mKQ09BRwJkXPPH6TNinLZr9Onx96qWhztLDwbSJKy/kcOfsewLMlCetemsjWmOrZ4VdeqEiNqzjwlsAG0Lg+R5saQtOfc8ftNm5xFb//c0QhLfVI698pJJUyXhXMZ3st/AdKye0GK6KxzS7zBfZRSYBys2ubm8tMpRuBtrMnS/zjqXuZlH2QCxFqp4/d+gydlnkcLPgQFh977rL/mLAIpteM3zJZjIQytvhEG0goZPC3+VOgiDUEDfbr8PacM1WX6tNnlQ42ggfCIJ+ketvhSyXWVyh89dXh0RdLYoEWqO/LyNpzi/16gfpwAs6hbspcFh/0q0BVctzstEtY0hYfnREVmTIQNRTbATsp6PCIykHsegZmnUhPkUVjU0Uq1X+gIcSsGUJHLS2nA4ruk0jp4jrRJIaVwlqS4u/XL9NRATkj/inRA+XpgmK0cYGIsMStSachXsDKPjTsLI4kZM+DPbvkasPaGHq/LaHmFFKyo1uyO1+14xdC+fR5xCoge9C0ZJ
X-Forefront-Antispam-Report: CIP:144.49.247.24;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.ds.dlp.protect.symantec.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(110136005)(5660300002)(36860700001)(7696005)(4744005)(70586007)(81166007)(86362001)(356005)(82310400003)(82740400003)(52536014)(6506007)(70206006)(33656002)(316002)(186003)(47076005)(4186021)(83380400001)(8936002)(8676002)(478600001)(55016002)(66574015)(2906002)(9686003)(26005)(336012)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: flex.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:51:20.8407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca79f0e0-7756-4065-7a03-08d925a39835
X-MS-Exchange-CrossTenant-Id: 3f0e69e0-eb38-4eb2-b4ee-52919719d31e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3f0e69e0-eb38-4eb2-b4ee-52919719d31e;Ip=[144.49.247.24];Helo=[mail.ds.dlp.protect.symantec.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4155
X-Proofpoint-ORIG-GUID: xUpytm8AelqLZ6BVx29iWUKqX_g8OEq2
X-Proofpoint-GUID: xUpytm8AelqLZ6BVx29iWUKqX_g8OEq2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_05:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=973 bulkscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020056
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Ros=E9n wrote:
> Add documentation and index link for pim4328 PMBus driver.
> Update MAINTAINER file for the driver.
>=20
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> Acked-by: Daniel Nilsson <daniel.nilsson@flex.com>
> ---

>  K:	(?i)clone3
>  K:	\b(clone_args|kernel_clone_args)\b
> +PIM4328 DRIVER
> +M:	Daniel Nilsson <daniel.nilsson@flex.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/pim4328.rst
> +F:	drivers/hwmon/pmbus/pim4328.c
> +
>  PIN CONTROL SUBSYSTEM
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  L:	linux-gpio@vger.kernel.org

Acked-by: Daniel Nilsson <daniel.nilsson@flex.com>

Legal Disclaimer :
The information contained in this message may be privileged and confidentia=
l.=20
It is intended to be read only by the individual or entity to whom it is ad=
dressed=20
or by their designee. If the reader of this message is not the intended rec=
ipient,=20
you are on notice that any distribution of this message, in any form,=20
is strictly prohibited. If you have received this message in error,=20
please immediately notify the sender and delete or destroy any copy of this=
 message!
