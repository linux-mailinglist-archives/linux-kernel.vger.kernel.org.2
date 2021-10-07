Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF56424D40
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 08:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbhJGGZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 02:25:15 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:10334 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232340AbhJGGZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 02:25:13 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Oct 2021 02:25:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1633587801; x=1665123801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aySz4+A3i218aG9/pNE+5lqNPtN8GquDBcApO9nosPw=;
  b=mTl/oc8vGEOKgYY9e2G+8Y+faedl727qP2oxHWYV0Tz4FgyoKTYIH9GU
   D87o1S/grrSNJ7w2AT2SZf/HachV6rmz+CTP6HauYwm9b6JIUkLMUO2CF
   Ta8AfsL0XVnRJ9Jn+nKP44UaBr0+88tEPOgmUzg7ZXbENAQkLvKhGJB2Y
   AbG+unPpt2Cm3V4jVZm9jk2fay295LdAxReue0Uhuk3SC9qDZIoze1twz
   G/XTLQRgrZWrTxr0tgiftRtv1cTihraqqmf7/L3Yuj4QblDDgRMcHWfrg
   nr1ZK9Y8ojY0RLI8o1SDX+TCj2v4sTqVcIG8hAUb1ILsgttUAidm2zYWl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="40612635"
X-IronPort-AV: E=Sophos;i="5.85,352,1624287600"; 
   d="scan'208";a="40612635"
Received: from mail-ty1jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 15:16:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4rABqr79HLgPoj+Nqs2ehjW7agnh6Dz/jPfFmCWV//tnhK4USMMHxdVoakZFOVQrxH2FNo79N31VhktiSVJIskyOgwDAxu9sRsnb7dABpxvSFaChe1yN8sWj8OIPLeXJkzyEiks5+2fFHeI7nVSPyKKI685JolwiIdxSdlslu/hoI4mQvDPihXZXUdpayXTRAeIaCCMlWgMOgJgoIQ4gTfxXSZFpyuuJJyEt6KptsU+9R6VlFMmsSo3JnuJf8GdisQh1chS8hROqDlvq2+xs3o91ZeXFoCcpzOLd5kIBlDbH8sRkxVgGuiynvAAYyWQKRNtAidZNea0aNacX1MaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Zt+n20BmdNHQ3jTymjQ+ZMlIun2ASbhWErCtG8+FY=;
 b=Hx4+Gj6Oq3gOMrDXRZGJQj+mGZcbuqVCoxTmdkrQX467mMtWi9tEMY39cNySQDrCrqVWucNV1+8jCUgK46XxiHPN8BofkCr24VlP/6PwkHDyldCanrpFQuTn8MBHoSOn/Wz7SUNSAdyT8Tt/YRVZw4IUD9XM6lI+bfNk5DmALSpMV6qhFuy7gte8MA9Fg54xFyx74O54JzKF/kDPKD7ru552OxTvakUa4bKC/D60qp74OwtWEcPHua0cK0oU4TgcJlRG5b0IOwHcLhCLgEBBllLzR6NgNUMmhLgtstb8tjdxFvZ8QqnVe+Q2wG6tUx6V+e4vpUcrUQ2YxIISFiuC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Zt+n20BmdNHQ3jTymjQ+ZMlIun2ASbhWErCtG8+FY=;
 b=qo7AXro58zgWuAeS4kk28KLv2Y9LfaRcRB0kQteEI18zY0NA4wscp9p7ytQYGxca7kykNlV8n2LruDqczdFXAdi3Ri8tRgIxvFecwn+A7ijpjFFuMwRWPV2n/MX9aZlzmgJiN22QVkDGa1gikaPqIbZwinCst6aXRji2mo5v8SE=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYCPR01MB6494.jpnprd01.prod.outlook.com (2603:1096:400:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Thu, 7 Oct
 2021 06:16:03 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::1db3:e397:d8ab:9948]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::1db3:e397:d8ab:9948%3]) with mapi id 15.20.4566.022; Thu, 7 Oct 2021
 06:16:03 +0000
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
Subject: RE: [PATCH v2 16/23] x86/recstrl: Allow per-rmid arch private storage
 to be reset
Thread-Topic: [PATCH v2 16/23] x86/recstrl: Allow per-rmid arch private
 storage to be reset
Thread-Index: AQHXtt35NMJPHGax9UGH8tJjDKBliqvHF3rg
Date:   Thu, 7 Oct 2021 06:16:03 +0000
Message-ID: <TYAPR01MB6330720B5F1F3549D034D5318BB19@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-17-james.morse@arm.com>
In-Reply-To: <20211001160302.31189-17-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9MmI3YzVjOGItM2JjYi00ZjcyLWFiNjEtYWYw?=
 =?iso-2022-jp?B?ZmZlNTgxZjBkO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTAtMDdUMDY6MTQ6MzdaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76b5b1c2-2b1f-4823-9f02-08d98959f10c
x-ms-traffictypediagnostic: TYCPR01MB6494:
x-microsoft-antispam-prvs: <TYCPR01MB6494A0DADD0A1355208623038BB19@TYCPR01MB6494.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eSBKtIM8/+K8Y//wQOvCvrAMnKyTPbpUDUPeSHwmN6Mr37MJOEKtvtm/K3Bav70Ye3RTUIrdXm5qwodUBNgpbfPSfPt7NWZeukFj/rAlAm99P/j4bNgnXkXu0z+4r10Bnnor84FGdTq5yujNB9BChH1GkkgvkuPuGniCYVRBqd9wvExsbKMJxA5wdRHW2aka2Bg1fvTxDTnw418QCh4SHWaqIVpKoxolzdgBn9qWjs0jM1Uyx7bhlcOnW9fPkNB29IXBg72ROMhXo3Ln9d1Zz62mM/VGowkHyISwc3AJkcXUa67t5BYRpWlDLXM7yu9GYoxEAFZb2LTW3Oj6VwcuMKDvQJTxfmy6sPFSxgdeJANIQ4mpBuDtbUKGe8MqK6wUPyP7zHXyecJB02YmHcds11kC+d2n42fSdRFr7YvTExs0wscsz9SFUNpM76S5jkBzqV6nx8o2pbOd8RGoPWLcxOtVJSP+BEMrBZBEKNGWTe2or2w7wvQTWeH+NRaWay+MrdoMl5pZaxc7/bcXlXttKqkUpORFA9Wyk3Azm52TdPLvBY0nDBzghJNkAjoCoqRe04ieL0Gh90XqXTrAujS91bsTJD5a9ryPK67kKkYRc/JhYmOUgMt+EDb2TgVgJ7iVyNntLCuBbxKFXb3/k/n6jsJ88Ctd/vDqz3M8aJZgz5FC/M40qLywx6FASWgOSV3v/HqPr6LwIi5jb2TwMcOphA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(33656002)(26005)(5660300002)(54906003)(110136005)(186003)(38070700005)(55016002)(38100700002)(122000001)(9686003)(508600001)(7696005)(66476007)(2906002)(66556008)(83380400001)(66946007)(8936002)(4326008)(66446008)(71200400001)(76116006)(85182001)(52536014)(6506007)(7416002)(8676002)(64756008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?d3VVRGkyenFlYlRTd0Jzdko1UXVDcUkvaGkrd1ZSSUN2QkFRcSs2b1o0?=
 =?iso-2022-jp?B?b2dHYjFlNmRrczBxYjYwdk5wcXhUQ1JOVXlJUkJMbW9xRU5HTEZzZitF?=
 =?iso-2022-jp?B?cm1aMXc3cXNjMkZSMzR3YU5VeDVpT2t5Z3c2bHhxd2h4QllWTFRBekJ5?=
 =?iso-2022-jp?B?eTREdllvUHZrMFovaFFXU2FmZ1hNdFIzV2pESFdmNTk1VDdxV2NJWVNW?=
 =?iso-2022-jp?B?di8yckhKdVMvelJyMUVsc0pwQVdod2tuV1hNazBleGlOZTVFK2xwNHVv?=
 =?iso-2022-jp?B?ZEJ5OWdjQzdjMWVBSitRaXZjRUZCT2hNeHdLeTg4THdWV21iTCtqMDBX?=
 =?iso-2022-jp?B?K1pKMm1OTzJvc3dMdUd1RnNQRjFLNFo2VVM3V0JxbWVjK21Fb3E4ZmdS?=
 =?iso-2022-jp?B?Q2lDLzVHVEN1YTF2Nk5KYldxanVaMEk5Vmtvb3dtV2o1b29iYWVISnF4?=
 =?iso-2022-jp?B?VHdTT0ZpRXl6ZU5wSXJpL29WWEtlRHE3dnZ2SmFZeHlQbEN2SjE4cVUr?=
 =?iso-2022-jp?B?QjZCOTlTNSs3eXpUWVFRY2F1cTI3cndRcnJndjR3Mkt5K2c2RkU3WFJ0?=
 =?iso-2022-jp?B?UmQwWHZXbU5mZGY0aTQ5anV2eFJmQmxscGFHSDVWdURwMGwrdDc0TkdT?=
 =?iso-2022-jp?B?NVJ4eE1DcVFLcEsxRFR2Y0h5aGdJOGhtdHJIa2Y5cmpWOWpmV1lZUnRB?=
 =?iso-2022-jp?B?blFVR2JTaUZaeDFVSmV3eFNTVVFzcDU5TVdBb2QycTdqd0JwbDJ0ZmZw?=
 =?iso-2022-jp?B?cjc2UGZTVWRmRmMwSjZHZzVueTEzaVRZOVFvVEJzdTIwR0pleDhsY0Ro?=
 =?iso-2022-jp?B?dGtvUG83c2ZrVkFSb0tzc3R6MzUvVW9tQTVLY0RHemt5WTBxbFNUNVhl?=
 =?iso-2022-jp?B?SmlWSm5qUE0yMDNIWmRKNzArczkzOFp5V0R1TStVTnBEcXlxVGl2RUl4?=
 =?iso-2022-jp?B?QTIzV0VyZFkzYkdsUTR3aWR1QXh6YXhQRnBNWXMzVVpFOStReFpwdDJU?=
 =?iso-2022-jp?B?VytkWXFIMVdkRWNJeTN4WXY4U3JuWDBzNWVSTUxPRlhFRURqdzBuUFNF?=
 =?iso-2022-jp?B?L0EvNmE5bnlNMkk2V3IyTDA0V1RJblptNldhNWdpTlhaNEFSY0toVnRu?=
 =?iso-2022-jp?B?c1dZOGFQYUZheHpKTWZPMFFveUxuYmR0NXQrcHpXcGhKcjA1ekJ4TjJM?=
 =?iso-2022-jp?B?WEhxaXJoK0JEUjF4Vy9XR1RQMFVVSk1uNk9uNmgvbVBmWklsTnI4S2pY?=
 =?iso-2022-jp?B?VEgzTitDSUttdUNWL1MrOGFwTlBieVdPUC9YcXZqZTFldktPbWZmd1ly?=
 =?iso-2022-jp?B?NnU4cS9jYTV5ZkVoVWtYYkhGWm5FdVBxQ2tFeVFDaGdGUkRpVFdCR0kr?=
 =?iso-2022-jp?B?VmVVeTdSUEtmcXRFajdJdDNZOUpOY2dxTDIvcW5ka0VHb2tmZXZITmVM?=
 =?iso-2022-jp?B?VFlUclROK2RiUm5TdFlDWlAyQWNTeDkxSGE2OGpvVC8xRlVFTFpFeDFs?=
 =?iso-2022-jp?B?TG1LcXh0YmVHcXZkcFY0czBHUHB3d1ZiK2wvZzhLTi81c2RnTWIycU5a?=
 =?iso-2022-jp?B?dGd2RTBsVmlsdlMyNnZqcWw4b25IbDdYcXZiMEZWTUQ1cERlZnJRQmZ5?=
 =?iso-2022-jp?B?cnpZY1VaY29yNVJNbHJGSHpXNFlDM3ZsOWdvTDVlSnRJS1BmK0FBMU8z?=
 =?iso-2022-jp?B?L3NrK1I0SGE2dUVYaHJIZG4wZVdKMFdjWlpZVEIzbHdDVnYyTEcwc1d4?=
 =?iso-2022-jp?B?ZGU2aVE3ZzZsNXlXSUdRU0NEdytOZmVzcVNJNjJGOE4xRFlPWnJMdGp2?=
 =?iso-2022-jp?B?enp2aVArOUxGR1k2RTExWWV1N0hCWFJvSk5lbm05UzRkY014akEzTkdU?=
 =?iso-2022-jp?B?NGgzZWM4WFBlTzVrZ3FiT2dzSVVndTN4RThHQ05hWWFpZzFWUlNmY1Ew?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b5b1c2-2b1f-4823-9f02-08d98959f10c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 06:16:03.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKdrPiO9K651feoL3FIyVwnXrrXfXt93VVMqv/3p2qm4bASxGar3TyjQ4Oo2jV45W+b+tHtbvqfsE2E8CUQPGI8HWwD18U4fUuQX0lMN3SQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6494
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> To abstract the rmid counters into a helper that returns the number of by=
tes
> counted, architecture specific per-rmid state is needed.
>=20
> It needs to be possible to reset this hidden state, as the values may out=
live the
> life of an rmid, or the mount time of the filesystem.
>=20
> mon_event_read() is called with first =3D true when an rmid is first allo=
cated in
> mkdir_mondata_subdir(). Add resctrl_arch_reset_rmid() and call it from
> __mon_event_count()'s rr->first check.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>

> ---
> Changes since v1:
>  * Aded WARN_ON_ONCE() for a case that should never happen.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 18 ++++---------
> arch/x86/kernel/cpu/resctrl/monitor.c  | 35
> +++++++++++++++++++++++++-
>  include/linux/resctrl.h                | 23 +++++++++++++++++
>  3 files changed, 62 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index aaae900a8ef3..f3f31315a907 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -22,14 +22,6 @@
>=20
>  #define L2_QOS_CDP_ENABLE		0x01ULL
>=20
> -/*
> - * Event IDs are used to program IA32_QM_EVTSEL before reading event
> - * counter from IA32_QM_CTR
> - */
> -#define QOS_L3_OCCUP_EVENT_ID		0x01
> -#define QOS_L3_MBM_TOTAL_EVENT_ID	0x02
> -#define QOS_L3_MBM_LOCAL_EVENT_ID	0x03
> -
>  #define CQM_LIMBOCHECK_INTERVAL	1000
>=20
>  #define MBM_CNTR_WIDTH_BASE		24
> @@ -73,7 +65,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   * @list:		entry in &rdt_resource->evt_list
>   */
>  struct mon_evt {
> -	u32			evtid;
> +	enum resctrl_event_id	evtid;
>  	char			*name;
>  	struct list_head	list;
>  };
> @@ -90,9 +82,9 @@ struct mon_evt {
>  union mon_data_bits {
>  	void *priv;
>  	struct {
> -		unsigned int rid	: 10;
> -		unsigned int evtid	: 8;
> -		unsigned int domid	: 14;
> +		unsigned int rid		: 10;
> +		enum resctrl_event_id evtid	: 8;
> +		unsigned int domid		: 14;
>  	} u;
>  };
>=20
> @@ -100,7 +92,7 @@ struct rmid_read {
>  	struct rdtgroup		*rgrp;
>  	struct rdt_resource	*r;
>  	struct rdt_domain	*d;
> -	int			evtid;
> +	enum resctrl_event_id	evtid;
>  	bool			first;
>  	u64			val;
>  };
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index a1232462db14..35eef49954b0 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -137,7 +137,37 @@ static inline struct rmid_entry *__rmid_entry(u32 rm=
id)
>  	return entry;
>  }
>=20
> -static u64 __rmid_read(u32 rmid, u32 eventid)
> +static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain
> *hw_dom,
> +						 u32 rmid,
> +						 enum resctrl_event_id
> eventid)
> +{
> +	switch (eventid) {
> +	case QOS_L3_OCCUP_EVENT_ID:
> +		return NULL;
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		return &hw_dom->arch_mbm_total[rmid];
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		return &hw_dom->arch_mbm_local[rmid];
> +	}
> +
> +	/* Never expect to get here */
> +	WARN_ON_ONCE(1);
> +
> +	return NULL;
> +}
> +
> +void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *=
d,
> +			     u32 rmid, enum resctrl_event_id eventid) {
> +	struct rdt_hw_domain *hw_dom =3D resctrl_to_arch_dom(d);
> +	struct arch_mbm_state *am;
> +
> +	am =3D get_arch_mbm_state(hw_dom, rmid, eventid);
> +	if (am)
> +		memset(am, 0, sizeof(*am));
> +}
> +
> +static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
>  {
>  	u64 val;
>=20
> @@ -291,6 +321,9 @@ static u64 __mon_event_count(u32 rmid, struct
> rmid_read *rr)
>  	struct mbm_state *m;
>  	u64 chunks, tval;
>=20
> +	if (rr->first)
> +		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> +
>  	tval =3D __rmid_read(rmid, rr->evtid);
>  	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
>  		return tval;
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h index
> af202c891ba7..04f30d80fc67 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -32,6 +32,16 @@ enum resctrl_conf_type {
>=20
>  #define CDP_NUM_TYPES	(CDP_DATA + 1)
>=20
> +/*
> + * Event IDs, the values match those used to program IA32_QM_EVTSEL
> +before
> + * reading IA32_QM_CTR on RDT systems.
> + */
> +enum resctrl_event_id {
> +	QOS_L3_OCCUP_EVENT_ID		=3D 0x01,
> +	QOS_L3_MBM_TOTAL_EVENT_ID	=3D 0x02,
> +	QOS_L3_MBM_LOCAL_EVENT_ID	=3D 0x03,
> +};
> +
>  /**
>   * struct resctrl_staged_config - parsed configuration to be applied
>   * @new_ctrl:		new ctrl value to be loaded
> @@ -209,4 +219,17 @@ u32 resctrl_arch_get_config(struct rdt_resource *r,
> struct rdt_domain *d,  int resctrl_online_domain(struct rdt_resource *r, =
struct
> rdt_domain *d);  void resctrl_offline_domain(struct rdt_resource *r, stru=
ct
> rdt_domain *d);
>=20
> +/**
> + * resctrl_arch_reset_rmid() - Reset any private state associated with r=
mid
> + *			       and eventid.
> + * @r:		The domain's resource.
> + * @d:		The rmid's domain.
> + * @rmid:	The rmid whose counter values should be reset.
> + * @eventid:	The eventid whose counter values should be reset.
> + *
> + * This can be called from any CPU.
> + */
> +void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *=
d,
> +			     u32 rmid, enum resctrl_event_id eventid);
> +
>  #endif /* _RESCTRL_H */
> --
> 2.30.2

Regards,
Shaopeng Tan
