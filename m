Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDC2424D22
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 08:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbhJGGPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:15:39 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:49434 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240243AbhJGGPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1633587217; x=1665123217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qJ3Q+hQyTzz97/FaC2LkLA653brh0F/+oelpiZX4FdE=;
  b=ecEwcE4mtwGNPhbixtY5w/Stbv15ILu4mTqVLbSeqe+Oi4mgZMVfuPYj
   p8LBR4afG1w89+IV28tYmgtnIXhzyPMBJFN/kH3d87XwoXrjsHC7S9Oa1
   Wzg2Cy6u29xgNAe7K9Bg6/JrsGFMthVBa51VnFFual750ULS5cA2mi0I9
   LWFaHHZugOCU2xX7544bBJOtk6cTo2D0lHevPeVJNsqEytVpvP3rYQmA1
   B6VTEtWM3TtGfJy8T7G3lal9BL/s+n1gLGf7toeMtMP/OXedfgqQL0oWE
   en8r2BH7gftq1k/Qh2BMU8iFpk/OpB7xwOZGvjAtKdsIIY3tzMRt9v48K
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="40807732"
X-IronPort-AV: E=Sophos;i="5.85,352,1624287600"; 
   d="scan'208";a="40807732"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 15:13:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqVPizV5HXBkEIij/qDd0/uneHZ9SK9rHLsVVBsTZOTOzG2MJMT9YK8WpCefm1CMibBdl+xUuRN2+pvFKihX79enpUg3Mz1VMBvNsiv544fLX7Gd1jDuR4/YAWIf3chCztIoJ90tDElNWL/b5i6MRQLbci1a9oo6TJNr2l8U2Xr59tJuCvll7z38O86U/yCM/9e/YBLWItdGXg3AogjU94m5jrBpiSZAFni6E6FWVAXGBhH8I7aFDn9Vq68hVPyHXf5T+UTIwt04O7DoVjKNkazRRff9HTICmr8rX/CNz79KvG8PlP/Yh33I6FficFapxsRNDJewGb73nJxTXuDI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh2aVgpZFnFp7JCvnt1rVCd/3peMWj+l8ylNBW2wYA4=;
 b=Wne8MRNdIy59IELH5JKVt+M2afdJ2GFk/t+sFBnOa/EhMBUTRG/IWmGEf1YWEofDoHH8SADXP7JmhwJfz0Tl0q/jpAsoEVxZiSN0JSf/+Q4UvbmE9g6WitM/oPH6cvL8vMBasACpkAcrssw9b3t0SQ0udsjG3QqY5T7l6q7OsXgS+3uDARUq1WvGOPQobeq1FupXXVanG/lJTBkxlNHToI8epr7kGJQ2bxFWvQVWCfSo7KtacXLe6HGPH8giK1pQLsELqI+a//qhPJNyRQZlEZPY14ZK2h8adI1+rKl2gfuz5lHpzAKnr2nB4evQ62Kqu4ik/Cve1NylRrqGRzaU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh2aVgpZFnFp7JCvnt1rVCd/3peMWj+l8ylNBW2wYA4=;
 b=W2JoKZ6yR117z/G2zHaDOFdX+Sk5UJsXf6K6fZQFE8NOwXkFwRii902dGPO72wQJCy2STCVsaD+pQUxGLqBLwwOH6URsHRh5pBOM6B0/MHupDpBVru51E/9EgIKa0DZgxsQvQsB9qLItXuUN8GJYPp63V1daF3eeOr+My5loaQ4=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY2PR01MB2905.jpnprd01.prod.outlook.com (2603:1096:404:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 06:13:28 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::1db3:e397:d8ab:9948]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::1db3:e397:d8ab:9948%3]) with mapi id 15.20.4566.022; Thu, 7 Oct 2021
 06:13:28 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>
Subject: RE: [PATCH v2 12/23] x86/resctrl: Abstract and use
 supports_mba_mbps()
Thread-Topic: [PATCH v2 12/23] x86/resctrl: Abstract and use
 supports_mba_mbps()
Thread-Index: AQHXtt30LgJRp3eDk0K08FjK5T6b16vHEhBg
Date:   Thu, 7 Oct 2021 06:13:28 +0000
Message-ID: <TYAPR01MB633002CD0CC9019A98EB517D8BB19@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-13-james.morse@arm.com>
In-Reply-To: <20211001160302.31189-13-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9Y2VjOGViODctNDY5MC00ZDg2LTk4NDYtMTA2?=
 =?iso-2022-jp?B?ZDg1NTAyYzcxO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTAtMDdUMDU6NTU6MTRaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae882cb3-9f15-41fd-1ed7-08d989599472
x-ms-traffictypediagnostic: TY2PR01MB2905:
x-microsoft-antispam-prvs: <TY2PR01MB290581021992946AA469A97D8BB19@TY2PR01MB2905.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:411;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dgJ3XzfICZY0JdDXBU5Ro/R6zUSScdgUpuCuNKqcW2iRhCerIpNuvudgBd7lkMTQ3qfoHgq/VeO+tMvzN6JrAxZM9CHcNpi6g04MulZTkBP25zQ+nas6vDcPIa2DMyFIzPsWibMx4gwFGPsRC/C1UG5avSELJxm8SrvYoUU2xrPku3i2UnORYOVbSsODBgiQSWuv17iQok4lCoxs42mWqyMeF9NdBNaVuw8zjxhTGG+3yzRxtmqymelKECSbXY6PgY6CZYKWvLEOAYvcVwz+OTJVIw9yHH+U5LE/C9BbeaaebWLotL89/YHdAFLuXa5Z7T1qGn3wLIGczR88fczejtmUpuGwT4zNm6xvxPnIenEuwDLO+ciHddjlaUPGQHzHV2h14om+KkWFFplDVdjqdSwKSROzVBZYLWHC19gxMvjWuS+53ABqBC2uMf9bUNkDp52IKNHq8CX0xt3aHk+jQpyufTQjwVvCsD2SyNaEK9cXJs/dhFBJrW7UvCgnJ7FIepJDfzOJYkjRoYpCoqvfSkPKCLZxw1+pbhqXrpxHtfgyUkXbj9gujldKIM/SPYTGEaQ7f5Qmhe8cLCwy3vFrLGKxzjbHZZGe3pja27TTIN02x9Bgxe7bSY7vsc45B1yGPoWgLa238y+qc75OGRmHgyVJ9DAAvAabJqCKbjwvjAV9iDP0CHMvPbX9bwfBkWYvt1b3HXPdYVgdeCfSiVXngQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(8676002)(83380400001)(508600001)(55016002)(52536014)(71200400001)(7696005)(122000001)(38100700002)(9686003)(186003)(85182001)(66946007)(66446008)(7416002)(33656002)(4326008)(66476007)(86362001)(316002)(38070700005)(66556008)(8936002)(64756008)(54906003)(6506007)(76116006)(2906002)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZFFUU1ZBNzIwM2RDblY4cFNaVDRqNVZ3bGJkdG8xdUw4SEtvTlhqZFdW?=
 =?iso-2022-jp?B?dytBTzlRU0NXT2FtMWtqQm1Ca2lVK3huSzRhT0xBSmhpcUJ4elpVM2N1?=
 =?iso-2022-jp?B?TUdVZ1lPSlREUmZXUXBCdVVBOCsxdFpYQURwenpFbFlJejZqSGd0Y3c0?=
 =?iso-2022-jp?B?a2ttczEyYlNJemFjak5uMEUzYmV3Tnc1a3J5dWVIaXNBY0cwYVVLeExk?=
 =?iso-2022-jp?B?V3YybHc4dnpZOTEva2djelRJM1haKzdmRjU2d21mRVZPNGY1ZGlCODA0?=
 =?iso-2022-jp?B?UStuaUV3TlY2NnBsamtQWkVWM0Z1eWtULy9KeXptazFsem5WUWVadmZB?=
 =?iso-2022-jp?B?czVUNjFBYlU3REQ1NFlrQU9IbWVFWXNmektjcG5WS2lXT3hIRU83VCtH?=
 =?iso-2022-jp?B?RmsrZk5BaGhEcU15ZEFXRWx4MG4xbWZTQ2tad0FTQXdteGYvNlpKV0s5?=
 =?iso-2022-jp?B?RXVPd3pXNnlnYnFXbFN0SERUUklmLzkrYkk4bHJWekxUSnQzLzJ2ZG1l?=
 =?iso-2022-jp?B?YUcvb3dkMEtBUkZLWTdUSlJzakJTLzBjYm5ScndFd1A2ck1DUHFpVHBo?=
 =?iso-2022-jp?B?Qmtya0dEenBLUjhLSXdsTGRkeTl5dzh1RHhBRlJHSHpXRnJWSzVYQ3VK?=
 =?iso-2022-jp?B?elFHOFRKckNUZkl4RTdEZWN0MDMyLzhxV3NvSHFXS2hMaVVFVmNzS2p6?=
 =?iso-2022-jp?B?bzVrWTBZRXFQMGRFUGgvSEFGS25JVXFDT3dOL3k0OGVrSWwzSUE2cWNt?=
 =?iso-2022-jp?B?Z1hDOC90NGJKMHhSTm5vdHc5V1l6V1Z3R09DS0ZMTHNBVGxObGUyV3Vt?=
 =?iso-2022-jp?B?Mm93U3BudmUrL0R4L3lsbTJUb3ZZYUtQcExxLzFkT01EWXVoeEJudzlO?=
 =?iso-2022-jp?B?UERnK2xrOWhxY1QyR1dLdW0xR0ZLVGF1OG9MTUU2TElFTHNtV1p3cm9B?=
 =?iso-2022-jp?B?RmkycjlUbVk4ZU1iUmdwK3Z3b1U0dHYzZkxacFozZ2treitqT2pCMnFZ?=
 =?iso-2022-jp?B?WmN5YUxXWEZFWmZUMnZCd1ZMUVNGNWtFUHVhMi9BK1JhSEk4M3hveU9I?=
 =?iso-2022-jp?B?VitSSnBnNXBnNkdDL1FoUmFNT2tvYWhTVXdMaTBINUtMT2Jibyt0MnZn?=
 =?iso-2022-jp?B?QmVLaDJLZ1dkUzk2TEFUQW1IbGhNMTZkUlFPdlk1Y2xmUllDY3RTRSt1?=
 =?iso-2022-jp?B?eW05MURWTWJUMkhGMTF5OE5QZzR3enQzdlU3NEdZQnU2SHBCZURYUmZ4?=
 =?iso-2022-jp?B?WjloZnByZUVEbXhFTHAyZWhqUkpYNHRwMnBuVkU0VjMzcGdKVjMraHZh?=
 =?iso-2022-jp?B?UTJITW93U0k4UTltbHEwZEpmTFJHS1F4c0tiSUdPK0czbTdDS2tRV09J?=
 =?iso-2022-jp?B?NFpmaEJKOHpnVE85S3dUSkd4cnJtL1NZOW1GeW5vQmc2T3lyQ1VEVzRU?=
 =?iso-2022-jp?B?ak9PbWJkZG15amk2T3RxSTNZVlRLU0JVZFg2dGdPU3JkSC9FOXljdGtl?=
 =?iso-2022-jp?B?Y0tTRTNpTmpxcmw2WXROVEYwK2JmMldTbTRaYWxZSmNWRnovRGsrenRZ?=
 =?iso-2022-jp?B?aFlzT0oxYXlUZkVqMUZpVHZCL1Mwb3dvTzNBbmZJUURneWIwK0JsWWp3?=
 =?iso-2022-jp?B?NENLcEtvdzg4b3JkUUFYUE5YL2JWM014VVNDd3J0QmFYZ0tNaW4wQjJs?=
 =?iso-2022-jp?B?Um11SFRhazZLTmNqelVMYk85R3pweEdOMHBkRmM4emsrYzV2ZEVDeVhX?=
 =?iso-2022-jp?B?dzJkaVZmY2JGWE1ZUXk3UmJBOUFjYVdRenUyNGlvMzhWS0FGT2ZTaWpV?=
 =?iso-2022-jp?B?ZnJUalczQ25lOHJKNFdkeXZzWHl1SzhlQnRIZWppNjk2U25oL0psTFdF?=
 =?iso-2022-jp?B?NndLZnlIMjdQTFlodWkxdk83bE5PYmpDUFR6aUJtQmZLY01yTDJnVGFY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae882cb3-9f15-41fd-1ed7-08d989599472
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 06:13:28.4291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOkg7t6/zcTAwDCd3i0GzlgnX1FNV19V1BrHj8mxubCKuHN4B1eZbi1gpTWdBSH3C44DHR3AjcziX9HKR3PIdrc/AmEUPAcZcsH5u8/viuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2905
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> To determine whether the mba_MBps option to resctrl should be supported,
> resctrl tests the boot cpus' x86_vendor.
>=20
> This isn't portable, and needs abstracting behind a helper so this check =
can be
> part of the filesystem code that moves to /fs/.
>=20
> Re-use the tests set_mba_sc() does to determine if the mba_sc is supporte=
d
> on this system. An 'alloc_capable' test is added so that support for the =
controls
> isn't implied by the 'delay_linear' property, which is always true for MP=
AM.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>

> ---
> Changes since v1:
>  * Capitalisation
>  * Added MPAM example in commit message
>  * Fixed supports_mba_mbps() logic error in rdt_parse_param()
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 069c209be1d5..1207271cce23 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1948,17 +1948,26 @@ static void mba_sc_destroy(struct rdt_resource
> *r)  }
>=20
>  /*
> - * Enable or disable the MBA software controller
> - * which helps user specify bandwidth in MBps.
>   * MBA software controller is supported only if
>   * MBM is supported and MBA is in linear scale.
>   */
> +static bool supports_mba_mbps(void)
> +{
> +	struct rdt_resource *r =3D
> +&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +
> +	return (is_mbm_enabled() &&
> +		r->alloc_capable && is_mba_linear()); }
> +
> +/*
> + * Enable or disable the MBA software controller
> + * which helps user specify bandwidth in MBps.
> + */
>  static int set_mba_sc(bool mba_sc)
>  {
>  	struct rdt_resource *r =3D
> &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>=20
> -	if (!is_mbm_enabled() || !is_mba_linear() ||
> -	    mba_sc =3D=3D is_mba_sc(r))
> +	if (!supports_mba_mbps() || mba_sc =3D=3D is_mba_sc(r))
>  		return -EINVAL;
>=20
>  	r->membw.mba_sc =3D mba_sc;
> @@ -2317,7 +2326,7 @@ static int rdt_parse_param(struct fs_context *fc,
> struct fs_parameter *param)
>  		ctx->enable_cdpl2 =3D true;
>  		return 0;
>  	case Opt_mba_mbps:
> -		if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_INTEL)
> +		if (!supports_mba_mbps())
>  			return -EINVAL;
>  		ctx->enable_mba_mbps =3D true;
>  		return 0;
> --
> 2.30.2

Regards,
Shaopeng Tan
