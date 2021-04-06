Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FFE355034
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhDFJi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:38:56 -0400
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:45505
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230434AbhDFJiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t1Vu3nf+Ne69v8FPmyuYbaTAEKKVzIQNhQiH4QQrm8=;
 b=5rR90IaLwtHcFLYN9tXU9lU1Wj0Rz3og+kunie13f4wmW9ueuvYk+3DLjHLiWpU3aVS8HNcgQPCpLhzeTL2pT8rvoZLBr+Ge/LsViYjmopI1HWIznc6nmd8KWkiQcTsRgcmsOgSeaxn/mcP3UI1He3WohuM7PHixe/gr06vNYO8=
Received: from DB6PR07CA0178.eurprd07.prod.outlook.com (2603:10a6:6:43::32) by
 AM6PR08MB3830.eurprd08.prod.outlook.com (2603:10a6:20b:80::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Tue, 6 Apr 2021 09:38:45 +0000
Received: from DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:43:cafe::6b) by DB6PR07CA0178.outlook.office365.com
 (2603:10a6:6:43::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend
 Transport; Tue, 6 Apr 2021 09:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT023.mail.protection.outlook.com (10.152.20.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29 via Frontend Transport; Tue, 6 Apr 2021 09:38:45 +0000
Received: ("Tessian outbound 4ee49f77c636:v90"); Tue, 06 Apr 2021 09:38:45 +0000
X-CR-MTA-TID: 64aa7808
Received: from 16962d8c1076.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 154D95FE-2CC3-4DF2-96FE-650DBCB7D5B8.1;
        Tue, 06 Apr 2021 09:38:35 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 16962d8c1076.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 06 Apr 2021 09:38:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV65fbfHpnqHEq2/kUSs69SUShaZ6MW3G+8CvkhxgIfAikobPf4ogv3AD0gwu393DRS6iVFOKkR89GBIRUaEEGmm7r7m7B0Rw8S6U0PAYFXEH9usj0+a8RyLiDH23NfgHEvgFjAkj6X2YF1f3AKJDUMulFcyH8k65czBGQV3yGityda3wDERHXlLCCWsORtjQ409pr1RGsrUJ850wZKEtBMPpJZz+TOx5aeo5kAH6pSSC7nj6pGVEyOi/eJvhpwN72syjd1BjXUf3kMGrQ8bP2UjKJ+UCtGXb7PwE/LS0wBMnCJbRTnBCl7TsSZR05DAeiuFuJurnHeOqL6snkqyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t1Vu3nf+Ne69v8FPmyuYbaTAEKKVzIQNhQiH4QQrm8=;
 b=cz2091WFTqHz9/TKK9QvGbm8NIY5IuVam7OU+ozOocojwe3e7NOkhYWSg8XXMlRUpwA4hMDYfkNv4zYLNLVW7TbfIRQY3DrqkrnjYP0sHW8590Tq9b5k2d5oPdVLgI2OqOgTTiza9Jj2vskecufKJDj29H0crUMPO4S9l3nuTkHf7Nb5KTtbw7xz7gXSQaCPfMuxf5jhGk8/0OFYbLEv0m71SbyTf9eNBxPcOGxckhkWrDt875xk4QGou2oMU5M/sAL7ne3GeoMuQ+PABLEMLHN4y2JT0PeH89hw1Juq4yGgjG9qTI1WWxlzJ2D2t7TRflM45NzSax9esSNPbWtklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t1Vu3nf+Ne69v8FPmyuYbaTAEKKVzIQNhQiH4QQrm8=;
 b=5rR90IaLwtHcFLYN9tXU9lU1Wj0Rz3og+kunie13f4wmW9ueuvYk+3DLjHLiWpU3aVS8HNcgQPCpLhzeTL2pT8rvoZLBr+Ge/LsViYjmopI1HWIznc6nmd8KWkiQcTsRgcmsOgSeaxn/mcP3UI1He3WohuM7PHixe/gr06vNYO8=
Received: from AM6PR08MB3351.eurprd08.prod.outlook.com (2603:10a6:209:48::20)
 by AM6PR08MB5063.eurprd08.prod.outlook.com (2603:10a6:20b:e3::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 09:38:32 +0000
Received: from AM6PR08MB3351.eurprd08.prod.outlook.com
 ([fe80::bd2f:20d7:b8d9:b78e]) by AM6PR08MB3351.eurprd08.prod.outlook.com
 ([fe80::bd2f:20d7:b8d9:b78e%7]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 09:38:32 +0000
From:   Al Grant <Al.Grant@arm.com>
To:     "leo.yan@linaro.org" <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "leo.yan@linaro.org" <leo.yan@linaro.org>
Subject: RE: [PATCH v2 0/7] perf arm-spe: Enable timestamp
Thread-Topic: [PATCH v2 0/7] perf arm-spe: Enable timestamp
Thread-Index: AQHXKFpYNmFc4ZHFWkChYgZy5NQMtaqnPijA
Date:   Tue, 6 Apr 2021 09:38:32 +0000
Message-ID: <AM6PR08MB335124DC0080EA95A817D71786769@AM6PR08MB3351.eurprd08.prod.outlook.com>
References: <20210403072346.30430-1-leo.yan@linaro.org>
In-Reply-To: <20210403072346.30430-1-leo.yan@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 5884BD795B75F94AAE13EDCA3CC48E80.0
x-checkrecipientchecked: true
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [86.151.121.54]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e367f87d-abb3-4e35-1315-08d8f8dfc5e2
x-ms-traffictypediagnostic: AM6PR08MB5063:|AM6PR08MB3830:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3830A3A997A636A0BD2AC8F286769@AM6PR08MB3830.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GVzl9Js6fJUZ20oPTcZaz8gS9K7SfI9dsIi6j6ZdV+8mpGZARRt5RHcv2UdR/hSW4JOARxGFTV3AQSkxZeOgSsiVfCW1Uob7PEm0a/XqY8Yzu1iyFH8QBWnIoNkUXYud6Lbr0Lz0Rk6bRcRM7AfksHmo2RDEMOIs8X8d/Kb4z386cjTgPrefpqcEEm2qZJ374g0pJORGVVQGk3mZszhRswYIQkSnh9mErSFsbX1h1B4If+YPTTlkUxsa5tmEzakKDMVgjNiBprX8o9tdKf/eMRCkWTGEkzhIEAJfLt09wGvJteISdn6CcDrGbDlLesOYKwiePDSi4P2Ts2RBUmwYjpwE19bGNBrvcVKXU2QZTzMDQTXp79yJB4QAS3FcIrWiPj8flDN0ni+m/3guKH8AhL9tUwmFXHwq7xvVEMagX8z5sOFAYqD0vFMVbrG8Ds+tgVoEkIpztEOfO405F50NI0fTa7T6YtqG1KIbhrFxXBSzZ8UEBfVXnkZhJ4wMltdguxeKYHrIVhJ+NICh++tah9L9ogw7SCxMPExOCi2hJVxdN8A50/7itAlrX/wMbHNNnHGRJg5W4+PIVVaNdxCfqhwf1H+v8d6RZj8qUEtWOxpqHXa6UnZyp7F8VT1/Uo5B7K6cJpzGFAOGk1B8CIhUp7QttiIcQ0gEUTRF9uyMjRA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3351.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(76116006)(55016002)(7416002)(9686003)(5660300002)(71200400001)(478600001)(86362001)(316002)(66946007)(7696005)(83380400001)(2906002)(186003)(33656002)(26005)(53546011)(6506007)(8936002)(66476007)(66556008)(4326008)(64756008)(38100700001)(921005)(66446008)(52536014)(110136005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mgNqBlxtySrEltaNfaLQFvlO5gOGBkdFmE/kwiqZJoGQyRQ5RsIpa7RZTorK?=
 =?us-ascii?Q?+UuIOZHmgirXz2+jCOy+AJxribdjod3IbAUPlXMMu12z2+XPv86G/CJoApQH?=
 =?us-ascii?Q?cvsW9OTSA9HV6Wv9a9Ay/48SAAIGtHiqfxZyxtYzogZ492N71YwBglomW5UP?=
 =?us-ascii?Q?RVnGYeKOR9laJayYtUMvGOEjQT6foLu7MzJ42CqVMAAawV1YR3QPGBZVG2HT?=
 =?us-ascii?Q?yVqmvycrY4ueieQUIEkqY/UcBCJy3wCX4pJeMDaTs6MDP8Q9a5pFHQFWDV5p?=
 =?us-ascii?Q?5RP+kbJGKFuTuVAI2lm4PR74wHHQb4QllSt96O9B2dTu5TKqpg+KdJtiqtFH?=
 =?us-ascii?Q?B244aKkomsmk0Lw4aXiEGP03g9DMdla7OGm0gkJOwjiYTyqLDElpRNXKHc9A?=
 =?us-ascii?Q?XJAYD9Rdqk3ZLIzUYMQn0wfDiw6GjlkitoVrPVM4K4hKkv0Wpj4VcKpsa5Ue?=
 =?us-ascii?Q?xNFucSwsN17k7AoDPV/b0HRD/uAzppqHYQp44GIPt3Q3ygXX4K+YnEqhyTiX?=
 =?us-ascii?Q?x4/BWgT46hdrOtyn+sP6xzkPZqMGTOPCqWxx3yz7eq8JfDOO/GBlbBXmMCSl?=
 =?us-ascii?Q?deTqoJSdN01u9PsG7oWPwerD9VEGbRLxgMIhLQcEjMOhW1qNYxUEM+u3VTFu?=
 =?us-ascii?Q?PwODXHNQrUzPJUunsjkPEuU8XY5Qk1v/DEunVxYo5GEJPW+3fWqNMF6rPj4B?=
 =?us-ascii?Q?0lJaRSrTgndhKaK8i6wNWASKT07QEYKdytH5u2EXs9mwENTocHn8OWVRYnst?=
 =?us-ascii?Q?hhg17O3IAnCyKx9E5YmUyi5UMzXOh30GcrSUWGOnyhTHAKhQR6AzhO+LIABz?=
 =?us-ascii?Q?wMOCuLNaIDxTjOXcFI8rAaj5xgcmWlkMW8nlo9w9mMDFfUZB2EpxyD35eBwx?=
 =?us-ascii?Q?tKzGVnihy+m1QmQ5Xwx2k0VYG7fw2bDc+w8x1WYip9qfphAfNdYfHRs8pZr+?=
 =?us-ascii?Q?l196Cy3JwpzmBrR+0c4jt7OlMn5LrfWbTiqUsrG62DhAtJIQbfSf2SJqoVL7?=
 =?us-ascii?Q?tZbcT39XH5zk2zyxtIc9tjHemb6P+kbKvrzHGXjh5XVYhXms0WDX6qDcGWNc?=
 =?us-ascii?Q?JYCWwHqVkMevpA1sG1QevpKQu5LrLtKwMS3IcJ3/zqgSqeg++Bt9HKZEa5Hm?=
 =?us-ascii?Q?v9uoQ57rHQ4Wiarb50T6ttinavTuD5z6sl4A8jBFXlTr1Cl1eDHpxlE++U3G?=
 =?us-ascii?Q?3E6kryuTqJOSoi3H2zk5KH3PRuiJDPifonso2QjAjQ9RI4xUlb9TgUSoYe8y?=
 =?us-ascii?Q?rzaOe3UXpGR0r7jq+0Ig/X1SD3lk/bheeAj6KL1tzFcZDQOqHmMtArN9WKeX?=
 =?us-ascii?Q?g2VBQ8W2XarfbgKt+cd464Oi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5063
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 962e7992-e2c9-4999-af1f-08d8f8dfbe4e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKwfSmcsrPxlTEzT6pKU0v4t4PUftva84FKM4mwI5oRY7qF7RJpBGC2vDpsnH9fOASVuT9Yr6JUejl2eg+Crj3hNDVxO4IjkK0ANnteQEooB2Q9fvElSyfbeVF1w3t0hh8oiTDtXJPuZlbD20AeS/zejzIrVFePnOZ5c3LXZ8QhLg4dDSFiJqovMNfQsE2NRrtmLuCLHYw01gooouh0Ghklo3W8/ylfuJgj0Mv7Pdoid7ErZjm3AGeCxuxUXxcAiiuLzFLBOYlOGZjMaJOd3nYYLwLjVWhnmEwKTt1k64Yb+TRCw+FFzZP4s3j64JFCb4EmVD/8w18UB/yuDTgYqz+W27lG0oRpklL8IrDVo3SvyaDY1/UK87D77/Ju04ZjTZrokPnPewkbbXtWylmM0DyLRYWUaMt42mwFmyO1SLL5GmAqdWZ+T96ydfu5xGcRC9ilxl1VAIIzNKi4zM+x1X7jSG7iqQ2NlgXYpZUy6ZqAjMeIohboJ2mZKAMuqhr6kR3aY/P0XmjPfZihI+2awYRTtB+rr/mZpLVl+2w54YEBgo/tMB+bXmZcHFrWkpiKxcqIXHlaLL6Y8Y12PMzQixSk6lcnDp2NtMzZU2NfTBBROdF/IwiqcKDWqbMDYD2/2/+qbj7neM0aSHCYY1C1UQhRp155gd9GyvkP0gASe488=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(8676002)(6506007)(53546011)(55016002)(316002)(110136005)(33656002)(478600001)(921005)(8936002)(82740400003)(81166007)(26005)(82310400003)(356005)(83380400001)(70206006)(9686003)(36860700001)(70586007)(186003)(107886003)(86362001)(47076005)(2906002)(7696005)(52536014)(5660300002)(4326008)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 09:38:45.4178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e367f87d-abb3-4e35-1315-08d8f8dfc5e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3830
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Leo Yan <leo.yan@linaro.org>
> Sent: 03 April 2021 08:24
> To: Arnaldo Carvalho de Melo <acme@kernel.org>; John Garry
> <john.garry@huawei.com>; Will Deacon <will@kernel.org>; Mathieu Poirier
> <mathieu.poirier@linaro.org>; James Clark <James.Clark@arm.com>; Al Grant
> <Al.Grant@arm.com>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> <mingo@redhat.com>; Mark Rutland <Mark.Rutland@arm.com>; Alexander
> Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@redhat.co=
m>;
> Namhyung Kim <namhyung@kernel.org>; Adrian Hunter
> <adrian.hunter@intel.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Cc: leo.yan@linaro.org
> Subject: [PATCH v2 0/7] perf arm-spe: Enable timestamp
>=20
> As we know, the timestamp is important for AUX trace; it's mainly used to
> correlate between perf events and AUX trace, allows to generate events wi=
th
> time ordered manner.  There have several good examples of enabling timest=
amp
> for AUX trace (like Intel-pt, Intel-bts, etc).
>=20
> Since the conversion between TSC and kernel timestamp has been supported =
on
> Arm64, TSC is a naming convention from x86, but perf now has reused it to
> support Arm arch timer counter.
>=20
> This patch set is to enable timestamp for Arm SPE trace.  It reads out TS=
C
> parameters from mmap page and stores into auxtrace info structure;

Why not synthesize a PERF_RECORD_TIME_CONV - isn't that specifically to
capture the TSC parameters from the mmap page? If a generic mechanism
exists it would be better to use it, otherwise we'll have to do this again =
for
future trace formats.

perf_read_tsc_conversion and perf_event__synth_time_conv are currently
in arch/x86/util/tsc.c, but nothing in them is x86-specific and they could =
be
moved somewhere more generic.

Al


> the TSC
> parameters are used for conversion between timer counter and kernel time =
and
> which is applied for Arm SPE samples.
>=20
> This patch set can be clearly applied on perf/core branch with:
>=20
>   commit 6859bc0e78c6 ("perf stat: Improve readability of shadow stats")
>=20
> Ths patch series has been tested on Hisilicon D06 platform.
>=20
> After:
>=20
>   # perf script -F comm,time,cpu,pid,dso,ip,sym
>=20
>               perf  2408 [032]   168.680297:  ffffbd1253690a3c perf_event=
_exec
> ([kernel.kallsyms])
>               perf  2408 [032]   168.680297:  ffffbd1253690a3c perf_event=
_exec
> ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680317:  ffffbd1253683f50
> perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680317:  ffffbd1253683f50
> perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680319:  ffffbd1253683f70
> perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680319:  ffffbd1253683f70
> perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680367:  ffffbd12539b03ec
> __arch_clear_user ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440
> kmem_cache_alloc ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440
> kmem_cache_alloc ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440
> kmem_cache_alloc ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440
> kmem_cache_alloc ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680376:  ffffbd1253683f70
> perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680376:  ffffbd1253683f70
> perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
>    false_sharing.e  2408 [032]   168.680376:  ffffbd1253683f70
> perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
>=20
> Changes from v1:
> * Rebased patch series on the latest perf/core branch;
> * Fixed the patch for dumping TSC parameters to support both the
>   older and new auxtrace info format.
>=20
>=20
> Leo Yan (7):
>   perf arm-spe: Remove unused enum value ARM_SPE_PER_CPU_MMAPS
>   perf arm-spe: Store TSC parameters in auxtrace info
>   perf arm-spe: Dump TSC parameters
>   perf arm-spe: Convert event kernel time to counter value
>   perf arm-spe: Assign kernel time to synthesized event
>   perf arm-spe: Bail out if the trace is later than perf event
>   perf arm-spe: Don't wait for PERF_RECORD_EXIT event
>=20
>  tools/perf/arch/arm64/util/arm-spe.c | 23 +++++++
>  tools/perf/util/arm-spe.c            | 89 +++++++++++++++++++++++-----
>  tools/perf/util/arm-spe.h            |  7 ++-
>  3 files changed, 103 insertions(+), 16 deletions(-)
>=20
> --
> 2.25.1

