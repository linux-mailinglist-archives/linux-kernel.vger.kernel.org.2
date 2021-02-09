Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3403146A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhBICwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:52:38 -0500
Received: from mail-am6eur05on2048.outbound.protection.outlook.com ([40.107.22.48]:42464
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229774AbhBICwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHN9nGaDeq+Y/SQPCw0KMI8YNTIkAUczqKMlFFPCq+Y=;
 b=i8tubMtARa86tdYdEbo7ZvYMkdgKUYs1MzBcKqC4MpEO7oDwc4CBnA2QmLG+liz585Q7TY6dEvutE7i97W+SQXlpuyfpH7nsSb1Nv2kom57/UpJtMP10wM6i+SNmcDZWCGCApU726ovy+a+ihmct/aLDMU+ieBcRgtF0TBxT6GI=
Received: from DB7PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:10:52::31)
 by VI1PR08MB4207.eurprd08.prod.outlook.com (2603:10a6:803:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 02:51:40 +0000
Received: from DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::7b) by DB7PR02CA0018.outlook.office365.com
 (2603:10a6:10:52::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Tue, 9 Feb 2021 02:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT003.mail.protection.outlook.com (10.152.20.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Tue, 9 Feb 2021 02:51:39 +0000
Received: ("Tessian outbound 4d8113405d55:v71"); Tue, 09 Feb 2021 02:51:39 +0000
X-CR-MTA-TID: 64aa7808
Received: from bb900bb8f867.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E2C8C9CB-EFF7-4CE6-85BC-1D2752EBD556.1;
        Tue, 09 Feb 2021 02:51:34 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id bb900bb8f867.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 09 Feb 2021 02:51:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR/jQC8bOS12CxO96E9f6LIvIS2FHUV8B8DsWmCnuU3niHt/e8xHB9zbAVcX5WGXwpVOYDLxmWk+srqsq6U12My5uG0MPLg7mDXk7LRQMTqXaOgCLtwJ7RnZpbnxQRKTTTs19H8oYPEqZs9LRaKWIXLAXLxst5FeFzyrAQuogCeoOC6WTrH3zNDI1OtHwLukP+Slm3WDCX3Hltvk23KVKp6txwhBm7q+tns0Mpe/g30XHKjsZTGgRWiv5H3gvJoIFmiWr8rY8GcOUmqVlDwCrRcz3K7hh+3F3YrIiRhRbJEWuyr3RNFxIn5JeWZhFOXU1591kMwIWVcToRGOo2RXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHN9nGaDeq+Y/SQPCw0KMI8YNTIkAUczqKMlFFPCq+Y=;
 b=acOFcGXejDPgCDoL0T0DZ3o9wDEyjoEeC3RdSsvq2LGYdjEHst3v/u1V/ksj9GjSuhYW1mJP+DAI7vQVNe2fBjmfnygCbbdTyQkRq23AQ5HqlYV5bVl8Or91hKgP7FkJPiytd3Yrl6tzbDJ3ish1uFe/Nsy2PIHoj3xvyFVSWI5i+ZRXDHIG6RbCiGHtdUizlG6OCwoutfCcZ0N6pyuSxQN0R5uPzXmJpIOQHUmom+moPyqIZJzfRsuNHf2yKr+v1lpJgCZZ+S5vKws8wfA2jtss4eeKq2tGL6dQjKC+t/YK8T86Et+ZNxNoVVOfGK5WSg52u0fTmC1nkSMD5bUFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHN9nGaDeq+Y/SQPCw0KMI8YNTIkAUczqKMlFFPCq+Y=;
 b=i8tubMtARa86tdYdEbo7ZvYMkdgKUYs1MzBcKqC4MpEO7oDwc4CBnA2QmLG+liz585Q7TY6dEvutE7i97W+SQXlpuyfpH7nsSb1Nv2kom57/UpJtMP10wM6i+SNmcDZWCGCApU726ovy+a+ihmct/aLDMU+ieBcRgtF0TBxT6GI=
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com (2603:10a6:20b:46::17)
 by AS8PR08MB6104.eurprd08.prod.outlook.com (2603:10a6:20b:299::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 02:51:31 +0000
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::d4d5:2dd2:1ac5:ba34]) by AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::d4d5:2dd2:1ac5:ba34%4]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 02:51:31 +0000
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "fche@redhat.com" <fche@redhat.com>,
        "irogers@google.com" <irogers@google.com>,
        "sumanthk@linux.ibm.com" <sumanthk@linux.ibm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] perf probe: fix kretprobe issue caused by GCC bug
Thread-Topic: [PATCH] perf probe: fix kretprobe issue caused by GCC bug
Thread-Index: AQHW+6Jrlcx5yjkUm0qR4w3YwhFFNKpONbuAgADor8A=
Date:   Tue, 9 Feb 2021 02:51:31 +0000
Message-ID: <AM6PR08MB3589E9CB66C12943CC93D559988E9@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210205093558.3057814-1-Jianlin.Lv@arm.com>
 <20210208213245.c302a2263a0816d705af974c@kernel.org>
In-Reply-To: <20210208213245.c302a2263a0816d705af974c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 06FB2045EAD8D84CBAC17983C6FB8C22.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb261d87-b2c7-494c-5a8c-08d8cca5a010
x-ms-traffictypediagnostic: AS8PR08MB6104:|VI1PR08MB4207:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB42078483CBDA9D9ED2322E66988E9@VI1PR08MB4207.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:4303;OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UkAhTil1hboy63M+1r7t/uzy1LPXkXRma94jEPSkaQLcsmhTHHLONUYB/NqtFMyPtYQ8oHMsBs8MKBH4OH3CZTgtFeL9pk/+1ptpxqBlMale170LCwWtCylsDpF3IHQMSPiunBzEE6pjuPh+23hGRiPqMb0DNGIzqQGrF5cwfWRKH1gvYIm2+15KZlNNL5cmd6J+x29O093i9IuNv5IX539CThOYGeH/MX/oKAa3SF7S3C9vFLI786I/HPBiby06UcTpD4DRgSa5YewAnJYo+9XrVO4F2NwCcrDBcLZ+HL8xTVoMh+Pfn1u7NWE2fTS8Rl+MAX3JxN5VNrFWiTXuwjDCCH+wSoHaRbzxTp8S9bBEZj3Krj05Jp4AKzpQ6tg1DH1ALUVoTq16JN3X9uMrxwKng7RWx+P7Isf1v+04sDkNGl8DWowpd5J0JPhYGjjMtYtZOWLrsDLM+KKxVsojC7b6od7QzTgXnpACLihHlNLB/oJ/VC9/eilcvigMOnFBreBgmpnR7Aa5o6NNad7dW/TDz2gVKiFWRmwuez3rs5FB9HFvdVzjJs2/DlTx+ptOrOb91c2ExsRGm+rmHx+wAuN63R2wnYxIvi7ij7I6ke4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3589.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(316002)(76116006)(66476007)(8936002)(86362001)(54906003)(71200400001)(66946007)(66556008)(66446008)(64756008)(2906002)(7696005)(52536014)(8676002)(30864003)(5660300002)(33656002)(966005)(55016002)(478600001)(9686003)(6916009)(26005)(53546011)(6506007)(4326008)(7416002)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?N34o4DSfCr5s1pTHs49CTSV4twG8RQWXFZ08pwFQ5UJXPTyGYNiingMyJEzQ?=
 =?us-ascii?Q?X2LKOtre2WJEHaacVUG590a1tb5cVDfHER9XuhX+XURX/UMJGct854npgTEE?=
 =?us-ascii?Q?FXiFwCbkfPMAYqcAkGMA2ERrP3zGsQRCrbasfCerjRpnxd78VDmir6NxoSAh?=
 =?us-ascii?Q?R7MHj459Agd6Bs5NTDp1+JkXZDM0M0fYkE+qA32dImMWoncq/uhDy8i9j0Ha?=
 =?us-ascii?Q?qUEC8rEBrA00j40VmRO+gZV8FTsqeIGtkb2ZnyXWCcOulgj9Hi8h7Y2Jjl0x?=
 =?us-ascii?Q?xorEJGImQvfuDXv6Y2a9azXfV4/UBjeEs4DI5ph4Aejs7VHc0xirIW41GA9D?=
 =?us-ascii?Q?U5k3zDrPqBxszY7xvJSyPtsXDDw3HeFn64ZT4FkZrxfZUiNhbQz9aJPqP174?=
 =?us-ascii?Q?87Tyn7CnqUKBeSepa3jqRlgUt+VfdXuEjukHDO3q9tk1Zc1uM4HzyJckif2Q?=
 =?us-ascii?Q?IxWAqoDDDJXTldgg0tKG5cvpLJfiyH67BtvyRVjxnzSUkPbNV6cej5PuFa/v?=
 =?us-ascii?Q?iX4oHG3U2dYY1m6F4eUQyAsRfLE9ob/FKvAvuZQMmdQkKm4r+Gc3v6OWUluj?=
 =?us-ascii?Q?TNAYKJZC4kXSIzqV+Kr32/53mLYjI5xN/4JoXa0W5ZXyGoguWTv3IZLICF2k?=
 =?us-ascii?Q?/0yNK68H0TCsbadMED9jqljJI2TyoH4jQbVm1u53ql0b0SWLjkzapTs201Vf?=
 =?us-ascii?Q?MC/bur/wlpKeIMdP2ZVusJfPdKXYW847ox294hJW22utgRNSXbnpN0ZJKCOp?=
 =?us-ascii?Q?la2lQZFvut5uqATsj8Fic/HDpgk21rBV4GfjrVG+zflBBT+g+InUHKKkOP1D?=
 =?us-ascii?Q?bp1++p7f3rfKj2KR0Bi/GDz1I3SKPOSh0nzHRyVHgeJtzLgoNBNbc6sA3+pC?=
 =?us-ascii?Q?HHkfY86d7jUpEU9Y+FtYszYREp0PvAIS163k6GdMz7c4oIPBHWVTq+koYTqY?=
 =?us-ascii?Q?rTu/hnXJXwmG53aVX53z54KnFS5pwFWluEKYXSfi3e79Py+E7F9tGlIsEQIZ?=
 =?us-ascii?Q?oxQ3zxdH66h07sT5uipaOV7/WIjwD7Dk7Y77Fy1ES95u1HMTSgJd5rOBZs8W?=
 =?us-ascii?Q?oVaH1gvuzk5Vds9kMf+jfDlLcyRBYJksjwy4A/IeHrLz6GvtE0+sWfR+Iagq?=
 =?us-ascii?Q?xOTVeKu5GWq7rOCme7uFxOlLxfdYc98+H9gFaNR9IYTUcBTmWRIqYOZcypFs?=
 =?us-ascii?Q?DWEkUxlw9sRva3gAGnoU6AwFfsUGkWUtFS14920lZwgkUwid+Oze3gUTFBTB?=
 =?us-ascii?Q?7TlKXyW3LUCcIzS1aBWeghjiRklKdpagFVan3jyhNLDOMJ8VxycPkTzniOIc?=
 =?us-ascii?Q?1aYQqWKtDhfaw14b6/qewWDE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6104
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 95937c46-849d-4c2d-8d8c-08d8cca59b0f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEdn2Mfg5ffrYgtKg9U13edivrRc483IhvyBIttC4UMvXYdbX9//8lhiOeosPZFfMt/GhobeQuZO/kWNil+NGwumBqly/XCpDQ4XzeoDLZuGobIksknXoTXSbCX+asreYU7q1OCsN2BAi8Pu5tTsIZYoYxB7wJrJASAk2GKj4gwJ7nbg4kMUdAld+UP3GiG/mCeJQ1n+4wEvCo/kSrSkXsC0j+Lrrmzvfc/25b/gCpvEMQLLyrmVhhtOhLoPCuiKlcJ4AVrD6I9b6pgLeuc4cbR2CwObEGwMCB9qrkqvbOeA7ClP0N8yzHS+N4IeVG1+Umq1NAUSZElmJr95To74wTZTBoVv7kdrfBjUatYiX4BkjCGEFuCgLKiDq7J7IxOh5EMZ3zxg25g6Di31zJc0Btmg/A1zWT/rWdYc2zH8HZqmGvS1rzd+sXnSN71d3LebG+ibaH2eI7gPAO2l/4Ne8JkqFRXHDSIziCsYWnvVuuA6wU3n4aBM86cKAnSubGiJbjqvYyLVt1yO/hZ/1NenGmLN9n1df2XgVmM5p0Ocs+/ISeplZ0/g5jM9pcxDh8GtH8IbPeKs3jZaXz0znsb1XG7L+vbarsDTF62kd7l0ImuzvmlqgJhs/NBrfVFrbb4gbHeg9Bp1LX50abEtFJm8FwUHikcjkTMl43jEFA4JunXxiRJ85DfiYzM14Pikugp2XTMOC1LGhtHALExMYIJgjSAWgmi1upNYThW9lJLPXak=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39840400004)(136003)(396003)(36840700001)(46966006)(6506007)(53546011)(36860700001)(8936002)(54906003)(83380400001)(7696005)(478600001)(9686003)(86362001)(5660300002)(8676002)(55016002)(47076005)(316002)(26005)(6862004)(107886003)(81166007)(966005)(2906002)(82310400003)(70206006)(186003)(336012)(70586007)(52536014)(356005)(33656002)(30864003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 02:51:39.9951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb261d87-b2c7-494c-5a8c-08d8cca5a010
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Sent: Monday, February 8, 2021 8:33 PM
> To: Jianlin Lv <Jianlin.Lv@arm.com>
> Cc: peterz@infradead.org; mingo@redhat.com; acme@kernel.org; Mark
> Rutland <Mark.Rutland@arm.com>; alexander.shishkin@linux.intel.com;
> jolsa@redhat.com; namhyung@kernel.org; natechancellor@gmail.com;
> ndesaulniers@google.com; fche@redhat.com; irogers@google.com;
> sumanthk@linux.ibm.com; adrian.hunter@intel.com; linux-
> kernel@vger.kernel.org; clang-built-linux@googlegroups.com
> Subject: Re: [PATCH] perf probe: fix kretprobe issue caused by GCC bug
>
> Hi Jianlin,
>
> On Fri,  5 Feb 2021 17:35:58 +0800
> Jianlin Lv <Jianlin.Lv@arm.com> wrote:
>
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
>
> Oh, I had faced similar bug for fentry.
> 3d918a12a1b3 ("perf probe: Find fentry mcount fuzzed parameter location")
> GCC dwarf generator tends to skip this kind of function entry information=
...
>
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
> >
> > The cause of the issue is that the first instruction in the compile
> > unit indicated by DW_AT_low_pc does not include NOPs.
> > This issue exists in all gcc versions that support
> > -fpatchable-function-entry option.
> >
> > I have reported it to the GCC community:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D98776
>
> Thanks for reporting it!
>
> > Currently arm64 and PA-RISC may enable fpatchable-function-entry option=
.
> > The kernel compiled with clang does not have this issue.
> >
> > FIX:
> >
> > The result of my investigation is that this GCC issue will only cause
> > the registration failure of the kretprobe event; Other functions of
> > perf probe will not be affected, such as line probe, local variable
> > probe, uprobe, etc.
>
> Hmm, it can affects the perf probe with local variables with ftrace
> infrastructure.
>
> Now the debuginfo (dwarf_entrypc(DIE)) will return the actual symbol
> address
> +offset (offset depends on -fpatchable-function-entry). In this case,
> if perf-probe put a probe on a function entry, it will be a bit shifted.
> So, the probe always uses SW break instead of ftrace...Ah, ok...I recalle=
d.
> Before discussing it, I need to restart the kprobe on ftrace for arm64.
> It has been discussed last year, but stopped.

Is there any channel to learn about the progress of restart discussion?
Very interested in this discussion.

>
> > A workaround solution is to traverse all the compilation units in
> > debuginfo for the retprobe event and check whether the DW_AT_producer
> > attribute valaue of each CUs contains substrings: "GNU" and
> > "-fpatchable-function-entry". If these two substrings are included,
> > then debuginfo will not be used to convert perf_probe_event.
> > Instead, map will be used to query the probe function address.
>
> Hmm, actually, the return probe doesn't need debuginfo since it has no
> information of the local variables when the function returns (of course
> usually all local variables are gone at that point). In that case you can=
 just
> stop using debuginfo for return probe.
> (for the future work, it should support recording the contents of  "point=
er
> passing" arguments at return probe, but currently it is not  supported ye=
t. So
> this must be done in another series.)
>
> e.g.
> $ ./perf probe -D "eventfd_signal%return ctx->count"
> Semantic error :You can't specify local variable for kretprobe.
>
> So, this should work.
>
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.=
c
> index 8eae2afff71a..10c88885dcd4 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -894,6 +894,9 @@ static int try_to_find_probe_trace_events(struct
> perf_probe_event *pev,
>  struct debuginfo *dinfo;
>  int ntevs, ret =3D 0;
>
> +if (pev->point.retprobe)
> +return 0;
> +
>  dinfo =3D open_debuginfo(pev->target, pev->nsi, !need_dwarf);
>  if (!dinfo) {
>  if (need_dwarf)
>
> Thank you,
>
>

You are right. I once thought about a similar modification method,
but it felt a little rough, so I added a check for the
"-fpatchable-function-entry" option.

I want a double confirmation, your opinion is to update this patch
as shown above, right?

Jianlin

> >
> > -grecord-gcc-switches causes the command-line options used to invoke
> > the compiler to be appended to the DW_AT_producer attribute in DWARF
> > debugging information.It is enabled by default.
> >
> > A potential defect is that if -gno-record-gcc-switches option is
> > enabled, the command-line options will not be recorded in debuginfo.
> > This workaround solution will fail.
> > Assume that this situation may not happen for kernel compilation.
> >
> > Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> > ---
> >  tools/perf/util/probe-event.c | 60
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >
> > diff --git a/tools/perf/util/probe-event.c
> > b/tools/perf/util/probe-event.c index 8eae2afff71a..c0c1bcc59250
> > 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -885,6 +885,60 @@ static int post_process_probe_trace_events(struct
> perf_probe_event *pev,
> >  return ret;
> >  }
> >
> > +/*
> > + * Perf failed to add kretprobe event with debuginfo of vmlinux which
> > +is
> > + * compiled by gcc with -fpatchable-function-entry option enabled.
> > + * The same issue with kernel module. Refer to gcc issue: #98776
> > + * This issue only cause the registration failure of kretprobe event,
> > + * and it doesn't affect other perf probe functions.
> > + * This workaround solution use map to query the probe function
> > +address
> > + * for retprobe event.
> > + * A potential defect is that if -gno-record-gcc-switches option is
> > +enabled,
> > + * the command-line options will not be recorded in debuginfo. This
> > +workaround
> > + * solution will fail.
> > + */
> > +static bool retprobe_gcc_fpatchable_issue_workaround(struct debuginfo
> *dbg,
> > +struct perf_probe_event *pev)
> > +{
> > +Dwarf_Off off =3D 0, noff =3D 0;
> > +size_t cuhl;
> > +Dwarf_Die cu_die;
> > +const char *producer =3D NULL;
> > +Dwarf_Attribute attr;
> > +
> > +if (!pev->point.retprobe)
> > +return false;
> > +
> > +/* Loop on CUs (Compilation Unit) */
> > +while (!dwarf_nextcu(dbg->dbg, off, &noff, &cuhl, NULL, NULL, NULL))
> {
> > +/* Get the DIE(Debugging Information Entry) of this CU */
> > +if (dwarf_offdie(dbg->dbg, off + cuhl, &cu_die) =3D=3D NULL) {
> > +off =3D noff;
> > +continue;
> > +}
> > +
> > +/* Get information about the compiler that produced CUs */
> > +if (dwarf_hasattr(&cu_die, DW_AT_producer)
> > +&& dwarf_attr(&cu_die, DW_AT_producer, &attr)) {
> > +producer =3D dwarf_formstring(&attr);
> > +if (producer =3D=3D NULL) {
> > +off =3D noff;
> > +continue;
> > +}
> > +/* Check that CU is compiled by GCC with
> > + * fpatchable-function-entry option enabled
> > + */
> > +if (strstr(producer, "GNU") &&
> > +strstr(producer, "-fpatchable-function-entry"))
> {
> > +pr_debug("Workaround for gcc issue, find
> probe function addresses from map.\n");
> > +return true;
> > +}
> > +}
> > +off =3D noff;
> > +}
> > +return false;
> > +}
> > +
> >  /* Try to find perf_probe_event with debuginfo */  static int
> > try_to_find_probe_trace_events(struct perf_probe_event *pev,
> >    struct probe_trace_event **tevs)
> @@ -902,6 +956,12 @@ static
> > int try_to_find_probe_trace_events(struct perf_probe_event *pev,
> >  return 0;
> >  }
> >
> > +/* workaround for gcc #98776 issue */
> > +if (retprobe_gcc_fpatchable_issue_workaround(dinfo, pev)
> && !need_dwarf) {
> > +debuginfo__delete(dinfo);
> > +return 0;
> > +}
> > +
> >  pr_debug("Try to find probe point from debuginfo.\n");
> >  /* Searching trace events corresponding to a probe event */
> >  ntevs =3D debuginfo__find_trace_events(dinfo, pev, tevs);
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
