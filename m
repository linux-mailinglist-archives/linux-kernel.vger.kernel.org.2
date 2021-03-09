Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5333235B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhCIKuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:50:12 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:62578 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhCIKtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:49:47 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 129AllaV028458;
        Tue, 9 Mar 2021 02:49:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=UI5cl9kvTeJXHodnbX4E3W6uLrn6+1FO7ZF1yiSTgqo=;
 b=LGjgc/U4l6zfm9SJpXE1lg/AgAb+upYTqqDZmYMA4RM4WPUy2R/EjTrmP4XWBjvg6O24
 Rs57ee+oWtTznk7u9ijneesBdYMQ4UIlYZub32g5qkg9IXCd0TY1yJHfFZ98FvmzBpvC
 Isp4rRjSrShsY1Lh8wK/VrjLdPEVsB+dtmBxSiLQWGeFabw00818WRkoHrS6tryIxZfh
 GAZSFCAmfbsH18ZWyhf0wSebMK4lhyjh0CTf0Vw59SeCPyKBjpOjmX3nQnNX3D5EFJ/U
 Ry7Kfh2n6VuRaCbdKFj+ETYd1qAmYr7i64xoj43tJ48Oc3Te4z1bIGrZ1cp4+ruASMCH HQ== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37476308dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 02:49:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lILwgDKWkoN7jvGRW1TUn/h/tMk1DWwREz7ShcFhsfwRQxfSZ9vyxgQevQPpfBpeKOSy4wnVTSbDKo5nckQ5RveKGhu0GuH/DCFNDGS6EMa/D1RiuDnEWF550xrAZ2YmhNa9jO36RLYyI9C+lBDLc9UccNMkUr+xMJKJxvBTWCT/PwNkqxgwVS7nLxX5lujXlhHpV5AdvoTF1mwmC3TEab7FM3qnQ/EJIl4Vd18RDuADtxj/tY/gF/MYvQSfGllVT9I7UZFVOv8iTb+yMbasGIt+acKvLjjuB13J3xDP/mMUhUR0T2+soWIxR9V6udmP+WYCpY0QVCtHPsKTwP21Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI5cl9kvTeJXHodnbX4E3W6uLrn6+1FO7ZF1yiSTgqo=;
 b=L//53bynF1aeMqhTxQ8aVQ2kjxB81Wp64QkbJt49mETPd5isy89lMpVIZlBcjrtg+hhIQW7pqM55wyxmCbKRG/h2g1GP+dabVisJ5A2cOROyQXb86/b4KigeGs2bgoTR4lCmL1Jkt8sVeHv2qhfirZhk6dsdPXyoKs/2w8L+EdNy6YgmVv6cf2DDCALfKMB1kwHxfTdBk/wi03Yxs6bWJKUpqzHmvVN4UlzG5w2nCwng+o8DWMBFgWcUPpXgokIn37njlDmrb6ccogLEpdUk5dQS0b074vZlLFhVRHxiCAvb5Ei8N/afHPe59zuv3lfi+eKBjh3fQ2WkMKEsjnTbxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI5cl9kvTeJXHodnbX4E3W6uLrn6+1FO7ZF1yiSTgqo=;
 b=mrk8TNLDclYkYXpj2+MlSjby0O08LGDfq1kyr9Q74aywkgLZLlo/iaODvMRvg6x1S0CXFrA+ld7Sh0HxKShiMJss6ZMrOXPm3AN1znGYzR5mkCuMD/Krbjcewl2A3HFgNK/gtccssSz+OwCAclVOAK9nTpWWuEdrdd4WK0JqdWg=
Received: from BY5PR07MB8119.namprd07.prod.outlook.com (2603:10b6:a03:1d4::15)
 by SJ0PR07MB8565.namprd07.prod.outlook.com (2603:10b6:a03:35a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Tue, 9 Mar
 2021 10:49:27 +0000
Received: from BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::c03c:301e:5e82:8759]) by BY5PR07MB8119.namprd07.prod.outlook.com
 ([fe80::c03c:301e:5e82:8759%8]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 10:49:27 +0000
From:   Sanket Parmar <sparmar@cadence.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "peter.chen@kernel.org" <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>
Subject: RE: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Thread-Topic: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Thread-Index: AQHXFKPlwE5egmmpm02b66W+ylYqvKp7Y7sAgAAIZFCAAAlEAIAABGcQ
Date:   Tue, 9 Mar 2021 10:49:27 +0000
Message-ID: <BY5PR07MB811989E3A3568B0B787A610CB0929@BY5PR07MB8119.namprd07.prod.outlook.com>
References: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
 <1615267180-9289-2-git-send-email-sparmar@cadence.com>
 <20210309092804.GA76839@infradead.org>
 <BY5PR07MB81197BAC5B801816D2B2566CB0929@BY5PR07MB8119.namprd07.prod.outlook.com>
 <20210309103116.GA110148@infradead.org>
In-Reply-To: <20210309103116.GA110148@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3Bhcm1hclxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTFhOGY4ZDZkLTgwYzUtMTFlYi04NTc0LWQ4ZjJjYThhNTI5ZlxhbWUtdGVzdFwxYThmOGQ2Zi04MGM1LTExZWItODU3NC1kOGYyY2E4YTUyOWZib2R5LnR4dCIgc3o9IjEyNTQiIHQ9IjEzMjU5NzYwNTYxODAwOTk5MyIgaD0iM0F2d3M1TGNEVldLeU0vc0J3MDkrZmUvbU9vPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [192.5.98.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5133f37e-6ec8-4b3f-1939-08d8e2e9029e
x-ms-traffictypediagnostic: SJ0PR07MB8565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR07MB856597AAFB634A8C041A5726B0929@SJ0PR07MB8565.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MhuMc4OXCJ4vU4Eu/wycvBfAoFbjKTZUEIPEU6TkkZKrxo7XqvQLLjjGA89uCWXL3VXY5o2FKt4P1ahyFhMaanmX9WHhK9IGV4GaYTmUsw/reYrLNBR1zeAy6dDFSTKwnT34dG7haajdxBchr1JkICIVF7E68gTfJ5hEG+YMtxRODUk838q0oa2IS4KYolSKgsZGQNK00xi8Fl29BOn/8JxYdZiC5Xn+zeVSmcMnqDKthYU2Y5Jg5c1QqbX5y+UdOfe5guMw35XhjsGogcdB4B0DKWnE4y8itwhxAD6C6LThK8Pb+SNsJ4iuR92uOibwf29oByilfoqLNCQRjCz1LP2+y9uZUQ6f0zqC/E5BX9mFsiybj3DbJc91YupKDwG+BdwALbnNzrKzGnK3heBDuiysrbuOpPnI4WHeqLecFr6kVrcJVOKSbolwqwFiyBNGZK7KBI99Ff3VY5WWjq1LsM357tMcuOZqUmlC5tjeKKoprMdDfM2Z8sGWdKjugxvjclD0T3lRuQz0KuEz0YwdVa+DEVug7ZkL6Li64ShfO6kwG8jOxCP72BGi5hPHUdepmVLFQY1CooQZPhh1QI+sMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR07MB8119.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(36092001)(83380400001)(316002)(478600001)(64756008)(7696005)(66556008)(66476007)(186003)(8676002)(55016002)(33656002)(8936002)(66446008)(52536014)(6506007)(66946007)(26005)(54906003)(76116006)(9686003)(6916009)(2906002)(4326008)(71200400001)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CrQQOVIq4ZHIKNnGl4mGeRu9/WMWCXN8VVPjzdqMBSvfG5ZoIh9CEYRsIk8Y?=
 =?us-ascii?Q?KpVotze5borLSgd5J8WnN0bIM/N3EQELtCCqanP2F/ckXt07pNub55QM4Ho9?=
 =?us-ascii?Q?fQb1Ztzs8bnRdYr5DBxV+Y2Amd9lWoVUhysnYM/pjw8Zow6dbXUX7Xn1aSJJ?=
 =?us-ascii?Q?ZICQ0x059tqsz4Yd04PLHyJX6VsmbwDb0QUE7WdtMtPQmBSKeMFPN9b0syTS?=
 =?us-ascii?Q?z88LZziTfR17wgPgoNgztUVUNDdpPupYtc1MgTHP5eRCIQea1664Yd1IzLhh?=
 =?us-ascii?Q?2guKueYmA2cgYw4t+3VYfklvwtvp5a9lgBtlzmWfbwo3O+E71FA7PvRipckv?=
 =?us-ascii?Q?ynE8tE8BX2heTj7CG4zo6EuhX4extcgcCB2tPOPvZOZfNW5FpXOkAfgJ4rbu?=
 =?us-ascii?Q?+ZkPM4opzNJ/km1p7Ky+pMfbK9fslGNfFxbjdiAAsOoslqIsEosXL4qasj+J?=
 =?us-ascii?Q?ttFjxavm4lSyV+dIKMnxNAAdh0gYqZFAQ0n8XNUIcQm5dmnZ9+b3KWnfY53b?=
 =?us-ascii?Q?iDHtL6yy/6K2T2cTxGPR5t42EnPWOH618kkRECI+It0H5aIzyfCLVg0OFqyE?=
 =?us-ascii?Q?5Y5ODHmlLSa5nmQgsb2tfK2Ze8iwzJwl0wZyPUKGB5nDoDRY0SvQlFXgtvOl?=
 =?us-ascii?Q?mj13Iy7BKWZIHV1XXCQHmNT/KBleYfkY1Et5evINIImM9B3mRVAQ79fp+yHN?=
 =?us-ascii?Q?EEkTKKfHjpCLDnoypMv4reFYHJBItFkZCBPmdb0kVg3PK79uAaT6QZD0iibV?=
 =?us-ascii?Q?913VtiICLrJUVpvGyNC4/DDh66GAZtuL+Jn0L6pXUDF4a62hXn+Y7mdycfL+?=
 =?us-ascii?Q?JnXd16/abCw+pp5zKdeNLgRY4KikDRsD0x6XcCyqqhHlnajNFXs0hgjGiL40?=
 =?us-ascii?Q?FCgwxBHk+zIjK9gz5Hrv49m8VDoWPCmtMvFBSH9tFab9pYGV6+IGocqxEJlC?=
 =?us-ascii?Q?ITOr8HfxcU0wGYzKHwURnkhBfeVr1sfEH8qnTV+1z+Ek9hXcdXuHMJdvvSn1?=
 =?us-ascii?Q?YQJWDat3t75ACS2wwdUzvC/Leb5TZX8KKCKUrTr1tlidMiht1fgxt+PqQcUK?=
 =?us-ascii?Q?QnxlnzmlJaU6QXCejdjR/ylscf3H8sSMk1NOLYQ9UI7mzZ0K+SgYEil4OvQZ?=
 =?us-ascii?Q?v0T7YrwdgUVv6CiN293Ji9NTXdj1fv0/+JLgFCynr1+IcTdgfDSJdN0zZONd?=
 =?us-ascii?Q?eKidHIypKKjYDi6GjTsu9JA+IN9yoSjsOk8sqURc8HLWZYY6yvdzN86M/OdO?=
 =?us-ascii?Q?6LM3DC8hAoGSald7wiBICEJNlHe8cf9EDlGeGwuD0dIoZ3HJvf07JM0lGPsc?=
 =?us-ascii?Q?Je0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR07MB8119.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5133f37e-6ec8-4b3f-1939-08d8e2e9029e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 10:49:27.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3arfGRieFlMHDj5vAweisdtaPvJBrA7eUuNpj9MP+yf72WUf43mpcQLF9QxYFmULZhLPx+04CuXdZUh+lbjhPHBW8/pVKdVzjWhlOo5tRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8565
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_09:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=450 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103090052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 09, 2021 at 10:18:43AM +0000, Sanket Parmar wrote:
> > > On Tue, Mar 09, 2021 at 06:19:40AM +0100, Sanket Parmar wrote:
> > > > dma_alloc_coherent() might fail on the platform with a small DMA
> region.
> > > >
> > > > To avoid such failure in cdns3_prepare_aligned_request_buf(),
> > > > dma_alloc_coherent() is replaced with kmalloc and dma_map API to
> > > > allocate aligned request buffer of dynamic length.
> > >
> > > dma_alloc_noncoherent is the proper API instead of using kmalloc, whi=
ch
> > > can lead to unaddressable memory that might require bounce buffering.
> >
> > cdns3 device required DMA coherent buffer to perform operations. So
> > dma_alloc_noncoherent will not help here.
> >
> > Also all gadget classes(except g_ether) use kmalloc to allocated reques=
t
> buffer,
> > and device driver uses usb_gadget_map_request_by_dev to map the
> request
> > buffer. Similar approach is used to allocate aligned buffer.
>=20
> If you can use kmalloc and dma_map_single you can use
> dma_alloc_noncoherent per definition.

Okay. I was not aware of it. I will test it.=20
Thank you for your feedback.

--
Sanket
