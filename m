Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3513573BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355021AbhDGR5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:57:45 -0400
Received: from mail-dm6nam11on2043.outbound.protection.outlook.com ([40.107.223.43]:50400
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354992AbhDGR5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:57:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grKYxVxGnn6aAF98FBP58OuZsle4vQHCTh3Y25Yr3TmBwYfPDtUjzXWzu7lpssXYb1JUI97yH8MCuWeNnIlEvEyVu7xEam+2xsEtnpxIfq01jxUprG82mi7DpGjXtAxOUMShf5Hro2AZ89QhqXZZidkj6fUi6sf1ceSzDjLz34ociQFjVMBvaIiYBGhZbQI/SkW6LVpDPcucluqsqb3cdoAjP0pjrxx5rr0KM8l5TQd1tM0hs5dsIFMsrjRweH9LS4mjgceMzX5OcNkxNwnB2Oe/tu3tf3we60XsgG/Oa4LVTYG/gT/rgFiSH1BzsP7Nw6RbK1TrXbfNW5LutRFR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWoAfBzWt9g5EE3WJW9HTz49rGQAZMqzIq76vvYE4RE=;
 b=jMtCSyoFMhh3rQtB2R9PjW0vpMDS6zI0b0/8uQ5WTTpeYOFEbEqORFMOet13HfwD+QqFbSkUu+1zXpb8wP7mdz/cBWjY+eC54WeJTRRWCGsmjeixETg7K7qLfB0HgQFf8XyHuCoEuZ6qiVVjBIEPLa4s3qYi5vxMNIuHSq3uveJSGZyB3/gyX4X6Px8bF6dOnrSjrggs1dlN+bt6iqxnxzwofzBgRTbGAHf0Mb8UTS/tZaPCpykf7xwhti9gquwoEOANbeaVB+Y8zDiQaQdbkSn6FOQEP8AX38JAr8fzb9OOuCQ1EB+moroxmANUWFTpiFfJlT68V4UcYNopm28p3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWoAfBzWt9g5EE3WJW9HTz49rGQAZMqzIq76vvYE4RE=;
 b=WKYKPt590dr+Uc+EJHh5vEuog36qVpnebp4rAV8TbemGlCAJpuljVsi2KTOJ6nuWs5kp8hqNnUzDwLm6jLtJgQScqFePBvL5vaHSXcdz44WLOY2aqXB3pKug+VNhf8bTaWrfrMyhtIDePrU4jK6OtiG2MjlFlqirMgE9QrFujwI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4247.namprd05.prod.outlook.com (2603:10b6:a02:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.11; Wed, 7 Apr
 2021 17:57:31 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::3160:ae0e:f94e:26b]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::3160:ae0e:f94e:26b%7]) with mapi id 15.20.4020.014; Wed, 7 Apr 2021
 17:57:31 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Thread-Topic: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Thread-Index: AQHXK5TyxLWX6NQ3A0yiL6P30rBhzaqpV8oA
Date:   Wed, 7 Apr 2021 17:57:31 +0000
Message-ID: <71C74038-943D-4041-B6FF-09A8C40CA204@vmware.com>
References: <20210323210619.513069-1-namit@vmware.com>
 <YG2C42UdIEsWex2L@8bytes.org>
In-Reply-To: <YG2C42UdIEsWex2L@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05564657-13d1-4c8e-1492-08d8f9ee9daa
x-ms-traffictypediagnostic: BYAPR05MB4247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB424705B73AC45EC0A8E91451D0759@BYAPR05MB4247.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sgK+KOhz/td529rBW5y96j5BzS73MTQaKn7Vtklnq2JfhWneFy/0FKGxRZ8Z5JIBwPMDut5x1qafkSVNW5/nWOvJdbuWMWvR01X5Ccvi1o9+u6PkkvKqr1SIy7U4cnDZ1Zibs3Ojfq53IGC9sJV1pX8MU2McHOr47ydmfquz9drSxMipwsMgR7q6ZsZcfnnmcx01p3irskkBzXUE36FakvXWm1l23r/PwGcBnmrVYGuQuEPa0sr9hMNA/p5PPwktQaL4T5RFNQNCXvnn8ZtAv4SYII5k9TS3h6EYnFCtYWIGgaQ/TDuMX5arilRzeZi12afGrf8J9nhViPDbTdXiuAVvcHkRdR8xf0ql/BvTX7py9J5EQfwEj2kw4QUfhgDhtv70aGHghY+O9KQNZXQ2UrnlTsmvm05c05LlQ3p6WSe4f1fe1iqlWAZFcxqXOj/DCLVrFITPIQHwI0kBCO93JpCyjiPfJWzFYbjF9w6WDKs6/TcFTsEpxArOJH5PXgRUNkMc4lCdikoLCSBF5KFVOlKQQ/yTigonu9PPfBvMCuK3YBfZAPSW++zf0TDA25O7zlP5JZjwp8yvntiioXx6nOsar8jcptsXH6BgZXIk1WJ/LVsCLEnzhkaxw9+bxJNkDMtULCLdPKESVuqMueQW7lUNNLlzJ7waZMs0LLlvctwemMfN29/v1APaOIwQnJab
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(6916009)(6506007)(8936002)(53546011)(186003)(76116006)(54906003)(33656002)(6512007)(2906002)(6486002)(478600001)(38100700001)(86362001)(83380400001)(26005)(4326008)(5660300002)(66946007)(71200400001)(66476007)(66556008)(8676002)(64756008)(36756003)(66446008)(2616005)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EMDXjLAMER9JNNfzxBoHqtkg3AcefHoY7MWRQUHmj15ubR7INLFtJoYx+FBs?=
 =?us-ascii?Q?8Lvk1FRjzTK6TzFreyr/0CiDuwG7juc4SUwD0msE8f/Svu/PraXCKb251JEJ?=
 =?us-ascii?Q?3dTHeEIkqvZe1NXrYJfrEtkneP9qS8KKMKej8f00v8Qvu+COKs8b6hAlGscL?=
 =?us-ascii?Q?YiUWEruf9Zzn4drxD66B640jdYDXzFJULV7MeTL253NYBUmDcIu8b9NmcRqH?=
 =?us-ascii?Q?XE1yH/ChCprcrKFJrbMe4qamRdj6C4qpwEnvmJcbHJxUgAPkB7o+cU9EyfKm?=
 =?us-ascii?Q?nZjjW8JfjpFESjat4TSHpcOrxCW4882ZnwB7uTDKamlPLkH4CWz+l0R8DFmK?=
 =?us-ascii?Q?hQvRIV/yS2wZuhpjtx2XSijIlzKG7P2PUtwH9GimSMXw1I9iT5z4KR0equzE?=
 =?us-ascii?Q?WcJu9OSPbktLpnniPQcOHZZKcJAtPeagwApRfLN2z0VzpMdiQOBldCkW8pDV?=
 =?us-ascii?Q?JTh1QsDF0Plm923iuQKua6Ap0EOBISMuQjQ9ZuynVgHG9iSilipkgATa8jAi?=
 =?us-ascii?Q?DvfR08helHT1JerOx/9LL5rEgHZZoV/juD113uqioDSpClfCDbcvsBL0jlLA?=
 =?us-ascii?Q?9whesgOABig6tjwXvfhgER2ZfT3STA4rkNXy1Tv0Zr3sM+eymOyBPLORNhbH?=
 =?us-ascii?Q?qdmBbP49/o+LmN2brIoJwaW7UUAvxfswYpJWfyRceURzJ4GS3kyGnz7GfDtj?=
 =?us-ascii?Q?aJGYQDFXqnk+NiQJsUgqPNm+7KrrYtN/lMmqYr6ko7XM8KvosuQUvZJomMVG?=
 =?us-ascii?Q?qjv7+yZbevgfmRIaOM/2HxYCie7Nv4jTFidtvs/UAKugfOFPxZO5O42hqEfM?=
 =?us-ascii?Q?QY6+doIy8mU2sJ9AkgMfTNbITV3ZCcmBUo6Qhxm8IaznAStmMCVzhhcayuf6?=
 =?us-ascii?Q?/s8QV9EGFouiZY5aLuMe0lDnWUKiKGBbHA0X5qF03B0F7fCUYsojrP1lrnZ4?=
 =?us-ascii?Q?MzI2kMoJuZo7OLcd2IqFOL69BtefUQ4c0jyBKPx1CHF5jL5FoImZ452gl42k?=
 =?us-ascii?Q?OqpsnJ9KrkjYJrj1xneyIq2g/1QgLe9V2ccO078edwBbx8M6+WmY3CiU8M6Q?=
 =?us-ascii?Q?RxMLeruPUda1oEJPduxQTKFQ74xbgvDlDmQJqkhO8yqK7m5o6Db+b2CFV4IS?=
 =?us-ascii?Q?wPA05476OWYMP5k0b31+C2mu5MlfK/Uz3BiD4aKCTHGFWQjbS2LPc3hRVOgR?=
 =?us-ascii?Q?gVeiFB/8Dbjr0k4lz46cQEZOPVliGCMe9/fdn4+IlrM5yacUa4yqyWqhRjsj?=
 =?us-ascii?Q?c528AxgwzTDLwLG3grtPgiWIj/56FUwTPcTCghORoJDOdaQZjbKNcp9T3Ntc?=
 =?us-ascii?Q?pahWHcbKJ7qJB6n0+gv6Lqof?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <467294B44FA1614E98EE78DE5B06327F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05564657-13d1-4c8e-1492-08d8f9ee9daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 17:57:31.4897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sumJMsr4qg/9ZKeMQ3MtWyFImrkZBbIQhHelErrgYMc7nwvW/MUdBLAN8XPn/9BgQBAbH/ewoALI+a69J642wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4247
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 7, 2021, at 3:01 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> On Tue, Mar 23, 2021 at 02:06:19PM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Currently, IOMMU invalidations and device-IOTLB invalidations using
>> AMD IOMMU fall back to full address-space invalidation if more than a
>> single page need to be flushed.
>>=20
>> Full flushes are especially inefficient when the IOMMU is virtualized by
>> a hypervisor, since it requires the hypervisor to synchronize the entire
>> address-space.
>>=20
>> AMD IOMMUs allow to provide a mask to perform page-specific
>> invalidations for multiple pages that match the address. The mask is
>> encoded as part of the address, and the first zero bit in the address
>> (in bits [51:12]) indicates the mask size.
>>=20
>> Use this hardware feature to perform selective IOMMU and IOTLB flushes.
>> Combine the logic between both for better code reuse.
>>=20
>> The IOMMU invalidations passed a smoke-test. The device IOTLB
>> invalidations are untested.
>=20
> Have you thoroughly tested this on real hardware? I had a patch-set
> doing the same many years ago and it lead to data corruption under load.
> Back then it could have been a bug in my code of course, but it made me
> cautious about using targeted invalidations.

I tested it on real bare-metal hardware. I ran some basic I/O workloads
with the IOMMU enabled, checkers enabled/disabled, and so on.

However, I only tested the IOMMU-flushes and I did not test that the
device-IOTLB flush work, since I did not have the hardware for that.

If you can refer me to the old patches, I will have a look and see
whether I can see a difference in the logic or test them. If you want
me to run different tests - let me know. If you want me to remove
the device-IOTLB invalidations logic - that is also fine with me.

