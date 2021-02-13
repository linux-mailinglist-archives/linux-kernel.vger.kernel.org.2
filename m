Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E2C31A9D6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 05:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBMENB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 23:13:01 -0500
Received: from mail-am6eur05on2083.outbound.protection.outlook.com ([40.107.22.83]:41504
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229650AbhBMEM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 23:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo/mwwYMVVd45SPJlljwhLt8aeVG7Twnx4Advj8BOA8=;
 b=g6CT8XMuzjYAgTFIQ9Ln/jEWtxkQxy7M9vOfe1XNRzLvUqCJilrs9ejbhND7xna85KoHIfkfprqzDyLjK6D6nrs1Q7hcMOVs2a79Hgsn2KsVQwOB+IsAylyttJCVz+6vCjsXbok3/3nXm/nuKTs2uTI/vim6DK/bNILtLYjyliU=
Received: from DB6PR07CA0050.eurprd07.prod.outlook.com (2603:10a6:6:2a::12) by
 VI1PR0801MB2014.eurprd08.prod.outlook.com (2603:10a6:800:8d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.25; Sat, 13 Feb
 2021 04:12:03 +0000
Received: from DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2a:cafe::ef) by DB6PR07CA0050.outlook.office365.com
 (2603:10a6:6:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend
 Transport; Sat, 13 Feb 2021 04:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT061.mail.protection.outlook.com (10.152.21.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Sat, 13 Feb 2021 04:12:03 +0000
Received: ("Tessian outbound 4d8113405d55:v71"); Sat, 13 Feb 2021 04:12:03 +0000
X-CR-MTA-TID: 64aa7808
Received: from ac18dafde195.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7D84270D-603B-4BDC-A2BF-93FD33EA3B9D.1;
        Sat, 13 Feb 2021 04:11:58 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ac18dafde195.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 13 Feb 2021 04:11:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVuQQnjjzbOkZBrPJGWP7608pkw4+1jUQyrI8Q9Uukc7KWYiiAukoMJFhIz9ZoE+baDnbCxKADLk8A2KTiJIcfsk0BBiB0Ss9FBh+IBzDjoZJZV3tCVcVV2xgGUQi+wWk+gV4v4YHHvUsBiPb2aNcqD8o732Y4M7q/Hzlut8gAA+CLrRSaDXuPJIxB+Gakbv/dWVdFGpz3Ew+11oxGzsp4olf06X4P3BthGg9AJZojTSgXQQo+Awl0R+BJZaEfX9BBlLoiiN6Ax/O+gcDprIQg8YAGzXXArDpxGNDZM/1UN9qnktPs5QqNzPADx4KMctq+xgGBRRtiGGjP/9AEt5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo/mwwYMVVd45SPJlljwhLt8aeVG7Twnx4Advj8BOA8=;
 b=F0lTllUy4Lu3NypEUjgjn2CR6C6zMJYqZwBAHqoso9vM2F9H4BKucf8qPSOW9j9BQoZc1+tVz1NRr+xifXz6/hOd97fKHO0zdOUrmwjvXbqP2qYzZdEwbhFVo6NBzdjo+z8GOeadcMoIINA6eTVKiEIAGwmu1zNrurdX6ymEU7cwpUZc5vApGmAEDuNqUUP8g2lAN9OGkz/VauKEl/w7jiyAZTZhL2YujcA8bs9pi8ljhzbx73aegoBnQDMTj/GQUNplimAVIbfdCs/LGZvp73I7up6D2PpdmOribmmEv5VJXaWNu8koSzqA+94+XZevQMk2QZySaBULEWrR2J928A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo/mwwYMVVd45SPJlljwhLt8aeVG7Twnx4Advj8BOA8=;
 b=g6CT8XMuzjYAgTFIQ9Ln/jEWtxkQxy7M9vOfe1XNRzLvUqCJilrs9ejbhND7xna85KoHIfkfprqzDyLjK6D6nrs1Q7hcMOVs2a79Hgsn2KsVQwOB+IsAylyttJCVz+6vCjsXbok3/3nXm/nuKTs2uTI/vim6DK/bNILtLYjyliU=
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com (2603:10a6:20b:46::17)
 by AM6PR08MB4312.eurprd08.prod.outlook.com (2603:10a6:20b:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Sat, 13 Feb
 2021 04:11:45 +0000
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::d4d5:2dd2:1ac5:ba34]) by AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::d4d5:2dd2:1ac5:ba34%4]) with mapi id 15.20.3825.030; Sat, 13 Feb 2021
 04:11:44 +0000
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "fche@redhat.com" <fche@redhat.com>,
        "irogers@google.com" <irogers@google.com>,
        "sumanthk@linux.ibm.com" <sumanthk@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH v2] perf probe: fix kretprobe issue caused by GCC bug
Thread-Topic: [PATCH v2] perf probe: fix kretprobe issue caused by GCC bug
Thread-Index: AQHW/3XNvm0aeC2DrEW7u2Af0oYL66pVDqeAgABthgA=
Importance: low
X-Priority: 5
Date:   Sat, 13 Feb 2021 04:11:44 +0000
Message-ID: <AM6PR08MB3589C4AEE6A498780DBBFC76988A9@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210210062646.2377995-1-Jianlin.Lv@arm.com>
 <20210212213405.GM1398414@kernel.org>
In-Reply-To: <20210212213405.GM1398414@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: BED7862F2A6C9E46AA60087890BFAE30.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [2409:8a1e:6f2d:b50:7014:e115:bf10:1974]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28b9c29c-4445-4eff-4842-08d8cfd584a6
x-ms-traffictypediagnostic: AM6PR08MB4312:|VI1PR0801MB2014:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB201421EEF2D0A6D9B75BEFD7988A9@VI1PR0801MB2014.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:397;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mHCFwCi5nYef3/V6SaxVlXgRxHZsGlYrZOjDR7mUQN4NiugfKTUzd7KgqhUaoRae2Srz0hCQcFUntVDg+kMvv1PTpQX6lLGliX5YQ5VasZQJXZAgaj5bm4UVT/LCxaKeQlvjHHxAx/mVGQQV/9Gvi1IE0nhM1th6YUKijvSmS3LVOnT/RaCyuUeR4mI1RKKgWGPNGRWTKElxe4BpsgCYWImKLpzJIACs2SfFRLfgldVTwrdI9K+3iF6TmGiITW7ZLD4b/p15UNGQpthWaT5A5fFR78S7shVl3vaclbjjulv5Fk2PndDX7Vy59ETwMazUe2DhacgvHzBHc/9CKbZ5i7j6HmyHU6qC7qh1l0SA7hk6GcnQSJaiuUXNUni3Yi2K+0+awaBekTFLlk++1IBINtqJPxEZxek/5XhIi/bE5FY/YKhfnsOqXmyn6HaF0eG90ymZk7vrRYk01mk/bYgE+GtrlZCbB1N+m8mU6vuHikB1YUAdPrALyuGe1W2FVfaRTms4WozLGV/k8nUIfVHGWIu8qaxm3F/PrKe4jkVEFP4OfFKeOLryA5N0DIqNjUhGY7ENR2PD/+SUznVsR3gpfvuPvtGMFarlvCHz0WYFzhY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3589.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(64756008)(66446008)(52536014)(2906002)(186003)(66476007)(6506007)(6916009)(53546011)(7696005)(66556008)(66946007)(8936002)(86362001)(71200400001)(498600001)(76116006)(4326008)(7416002)(33656002)(83380400001)(9686003)(8676002)(5660300002)(54906003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SISJujBrVrF/dt+rEFeTGA05adJUYQDdo7le6/5qAXOWyWwEORg55QZ9Lcwa?=
 =?us-ascii?Q?tB3CKAvrbGqgwRnL+yBeLoFtjDrGneaxgsciIr879alP61j6hRUR4fDgvf9K?=
 =?us-ascii?Q?9T6nTTY1IMCJ7TunhjCnRa7Ax/8atQrrcgQy5bWsKHeKsfzP3/ImRk7Jb1+U?=
 =?us-ascii?Q?sIZDYCMg1f05A1q/vnawuPj6ejHyy7Zpfe8GZTVAez/mA/WX0tH0fG16O8C1?=
 =?us-ascii?Q?i9Lk9cmj2S18HksY/6As5gBud3pgUCFLjL1SFMRxuCF34Xr24VuSaearcnyi?=
 =?us-ascii?Q?2IDdoJ/jK5D9Ix0q/X0bAN+SCorMwksUOsg7SYcNd9dCI/KS/pcsy2YpsikM?=
 =?us-ascii?Q?9cosOf1qGAaqi/QiFGCTaxj22Ng1FDwPO9gy0YhbRmPBFrjTmoX9gtfR7ikS?=
 =?us-ascii?Q?+bstg8hbfW4x+nl5yP9o2414Yod6xX/tdoog1WiBD+WjTiR/dfHQV81Od8l/?=
 =?us-ascii?Q?OYqgpZMTOoxZP1H2oIq1x4BIzSrorEMdRTA+USCsdOJRKjLg3syCvF4+gcsL?=
 =?us-ascii?Q?KQ2bDCud3mMGWLCs0Aum8Fh8Vl4A3h8YlViEIPj/wNWaWoEAXXsaLXHMI8Fn?=
 =?us-ascii?Q?FEYq8alWI9HDM89txlS6cxrfN8C9bSSndwqInVpDbGEsyO9bz93ow9gmI8Wb?=
 =?us-ascii?Q?HptjiqziM5LlIXAvh0yAlVdpvCK1SVg4glq4fRzcBkj3koD8z6ps9Sg0vU90?=
 =?us-ascii?Q?2AhvQWsiyilCSP6ekXsuv0mEtAZ33KrUFudtnVtrLHdPg/Hqm6X7+6qKujWO?=
 =?us-ascii?Q?/FMQMTwj7YiawwLEcl4omee68Awv5R0Gl9SDyczXk4N+F7ZjQQk9gnaZOZNe?=
 =?us-ascii?Q?6RBcboy7A8QRyZByfJuQ+bX9aJona1ggXjAWOPCiDUB9X5m/qZJ4TmvyTBy4?=
 =?us-ascii?Q?DO1fmlSAp7v2udNbD9xaFaWXwBoejm3BhfJKqQTibWTTCFAQZ48keEmDACX5?=
 =?us-ascii?Q?5VjNTRS7Uf35JIFlGodJ8kKRnq/Dr+UwT8PWuy5NPyUZI9V+X4VRGOiX8W3s?=
 =?us-ascii?Q?lvCqfqU4xH5MuUFTSxcvF2mg5I2RB/WKl1DhCoydcRl5B2gBuvIs2MfmASsj?=
 =?us-ascii?Q?glI8zObWAEOFnAqQZkA4oyYv3PQr02qCNH1HFH1oRHWVK9iTOtOOp9tQ9jng?=
 =?us-ascii?Q?Eu5QPWcx/eflWfvvqBfts+T2lKCNyE77JtOcDeea2XZxhcy5Sdpfd1d78HIX?=
 =?us-ascii?Q?yTsPK+27xdAk+2e6nZU7KOoUzVfKTN8bodAYLPyxixGN6zC0t9cgofxx2DuH?=
 =?us-ascii?Q?zXXYJNbf6l3lfuiJaaYJGuTV6M/bT23qeNJO6Q3tqo40Ic0pP+ce1lb7GDVU?=
 =?us-ascii?Q?CgfLtcqCAYe3vIEDeRmKj2jiLFaGwnH/vOZAkOJm//THLb+eCus5hMXxGtxL?=
 =?us-ascii?Q?OIzSEOh5l0OyfRAM6lMt3+0aysjQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4312
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 14c70cfa-702d-48a6-0adc-08d8cfd579a2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1r7fl78dV59bt1BsvKX68g2m42/ZuIydI8809KI6fNjbu7vwTHglxe2+RCtcaGoc8V68SjAPn0p5I0kefdBbZEIsf9Hs+SqHuIHWOfJtu7P6HDUDMJYsFjY9SLjRxvFjGzPyAyycQQvkdTwmM1VpKsfWSPPN6V+ZIUKC6EODEBPiHLSA11JIaMuahuK3vSdbcqljJT5LYM6GuUrC+wJy+o/tHdA5RCSfoT8Iqr61h05rX0CQdiY9oxx9o0B8F3paoVbDm7hwBcyzWB6RjT25y8uej5p8HE/SFmhQs9kjwDHkia5u0ZcM9RGwfpdu94iJBSnPJqUtzY6/wuDB6PJPzQcMmvqnDWjIH5Sy5HWWcvuorvTCs2YcS5ftyEuERAXC4NAsQpLj0EfvckzRqFNEHY/uqIxjszNaoeZv4cuGGUd37VALXPceCjuQ8Mvucc2XgXyTxv/IRUEypHGDzcfUJ4A/9rGFewuw0D3uJLXu7ovFEcRp6ewZF2oscef6/03KboRvR/Ckh7VWsIJtCT1BAE9yskNmvjzv0naA40x1EDKHY4MRe0uzCn2pXhlNR6FQVp1k1xXiA2fkxyb6rpCU8GmOrKTWYLrCkLMto+dOOuyXvswufnDRHlVtYKt5xvpsWIDi8+cSpEJ6JlSFKwz8HNmWQRRGsIZvs08904wqM1kcOdAPckxCAY4cic4eZXbTgk22TTnqfi83SVXkBUyH9AhT7ZOU7FADIallZhe0uA=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39850400004)(36840700001)(46966006)(33656002)(316002)(107886003)(82310400003)(336012)(70586007)(52536014)(8676002)(2906002)(47076005)(6862004)(9686003)(5660300002)(55016002)(4326008)(966005)(54906003)(6506007)(356005)(36860700001)(26005)(86362001)(82740400003)(7696005)(53546011)(81166007)(83380400001)(478600001)(186003)(70206006)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2021 04:12:03.3338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b9c29c-4445-4eff-4842-08d8cfd584a6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2014
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Arnaldo Carvalho de Melo <acme@kernel.org>
> Sent: Saturday, February 13, 2021 5:34 AM
> To: Jianlin Lv <Jianlin.Lv@arm.com>
> Cc: peterz@infradead.org; mingo@redhat.com; Mark Rutland
> <Mark.Rutland@arm.com>; alexander.shishkin@linux.intel.com;
> jolsa@redhat.com; namhyung@kernel.org; nathan@kernel.org;
> ndesaulniers@google.com; mhiramat@kernel.org; fche@redhat.com;
> irogers@google.com; sumanthk@linux.ibm.com; linux-
> kernel@vger.kernel.org; clang-built-linux@googlegroups.com
> Subject: Re: [PATCH v2] perf probe: fix kretprobe issue caused by GCC bug
>
> Em Wed, Feb 10, 2021 at 02:26:46PM +0800, Jianlin Lv escreveu:
> > Perf failed to add kretprobe event with debuginfo of vmlinux which is
> > compiled by gcc with -fpatchable-function-entry option enabled.
> > The same issue with kernel module.
> >
> > Issue:
> >
> >   # perf probe  -v 'kernel_clone%return $retval'
> >   ......
> >   Writing event: r:probe/kernel_clone__return _text+599624 $retval
> >   Failed to write event: Invalid argument
> >     Error: Failed to add events. Reason: Invalid argument (Code: -22)
> >
> >   # cat /sys/kernel/debug/tracing/error_log
> >   [156.75] trace_kprobe: error: Retprobe address must be an function en=
try
> >   Command: r:probe/kernel_clone__return _text+599624 $retval
> >                                         ^
> >
> >   # llvm-dwarfdump  vmlinux |grep  -A 10  -w 0x00df2c2b
> >   0x00df2c2b:   DW_TAG_subprogram
> >                 DW_AT_external  (true)
> >                 DW_AT_name      ("kernel_clone")
> >                 DW_AT_decl_file ("/home/code/linux-next/kernel/fork.c")
> >                 DW_AT_decl_line (2423)
> >                 DW_AT_decl_column       (0x07)
> >                 DW_AT_prototyped        (true)
> >                 DW_AT_type      (0x00dcd492 "pid_t")
> >                 DW_AT_low_pc    (0xffff800010092648)
> >                 DW_AT_high_pc   (0xffff800010092b9c)
> >                 DW_AT_frame_base        (DW_OP_call_frame_cfa)
> >
> >   # cat /proc/kallsyms |grep kernel_clone
> >   ffff800010092640 T kernel_clone
> >   # readelf -s vmlinux |grep -i kernel_clone
> >   183173: ffff800010092640  1372 FUNC    GLOBAL DEFAULT    2 kernel_clo=
ne
> >
> >   # objdump -d vmlinux |grep -A 10  -w \<kernel_clone\>:
> >   ffff800010092640 <kernel_clone>:
> >   ffff800010092640:       d503201f        nop
> >   ffff800010092644:       d503201f        nop
> >   ffff800010092648:       d503233f        paciasp
> >   ffff80001009264c:       a9b87bfd        stp     x29, x30, [sp, #-128]=
!
> >   ffff800010092650:       910003fd        mov     x29, sp
> >   ffff800010092654:       a90153f3        stp     x19, x20, [sp, #16]
> >
> > The entry address of kernel_clone converted by debuginfo is
> > _text+599624 (0x92648), which is consistent with the value of
> DW_AT_low_pc attribute.
> > But the symbolic address of kernel_clone from /proc/kallsyms is
> > ffff800010092640.
> >
> > This issue is found on arm64, -fpatchable-function-entry=3D2 is enabled
> > when CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy;
> > Just as objdump displayed the assembler contents of kernel_clone, GCC
> > generate 2 NOPs  at the beginning of each function.
> >
> > kprobe_on_func_entry detects that (_text+599624) is not the entry
> > address of the function, which leads to the failure of adding kretprobe
> event.
> >
> > ---
> > kprobe_on_func_entry
> > ->_kprobe_addr
> > ->kallsyms_lookup_size_offset
> > ->arch_kprobe_on_func_entry// FALSE
> > ---
>
> Please don't use --- at the start of a line, it is used to separate from =
the patch
> itself, later down your message.
>
> It causes this:
>
> [acme@five perf]$ am /wb/1.patch
> Traceback (most recent call last):
>   File "/home/acme/bin/ksoff.py", line 180, in <module>
>     sign_msg(sys.stdin, sys.stdout)
>   File "/home/acme/bin/ksoff.py", line 142, in sign_msg
>     sob.remove(last_sob[0])
> TypeError: 'NoneType' object is not subscriptable [acme@five perf]$
>
> I'm fixing this by removing that --- markers
>

Sorry for the inconvenience?
Should I commit another version to fix this issue?

Jianlin

> > The cause of the issue is that the first instruction in the compile
> > unit indicated by DW_AT_low_pc does not include NOPs.
> > This issue exists in all gcc versions that support
> > -fpatchable-function-entry option.
> >
> > I have reported it to the GCC community:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D98776
> >
> > Currently arm64 and PA-RISC may enable fpatchable-function-entry option=
.
> > The kernel compiled with clang does not have this issue.
> >
> > FIX:
> >
> > This GCC issue only cause the registration failure of the kretprobe
> > event which doesn't need debuginfo. So, stop using debuginfo for retpro=
be.
> > map will be used to query the probe function address.
> >
> > Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> > ---
> > v2: stop using debuginfo for retprobe, and update changelog.
> > ---
> >  tools/perf/util/probe-event.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/tools/perf/util/probe-event.c
> > b/tools/perf/util/probe-event.c index 8eae2afff71a..a59d3268adb0
> > 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -894,6 +894,16 @@ static int try_to_find_probe_trace_events(struct
> perf_probe_event *pev,
> >  struct debuginfo *dinfo;
> >  int ntevs, ret =3D 0;
> >
> > +/* Workaround for gcc #98776 issue.
> > + * Perf failed to add kretprobe event with debuginfo of vmlinux which
> is
> > + * compiled by gcc with -fpatchable-function-entry option enabled.
> The
> > + * same issue with kernel module. The retprobe doesn`t need
> debuginfo.
> > + * This workaround solution use map to query the probe function
> address
> > + * for retprobe event.
> > + */
> > +if (pev->point.retprobe)
> > +return 0;
> > +
> >  dinfo =3D open_debuginfo(pev->target, pev->nsi, !need_dwarf);
> >  if (!dinfo) {
> >  if (need_dwarf)
> > --
> > 2.25.1
> >
>
> --
>
> - Arnaldo
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
