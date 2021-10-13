Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD33642B286
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 04:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhJMCLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 22:11:31 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:37509 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233544AbhJMCLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 22:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1634090968; x=1665626968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2JX4UGboZd8eUtJUuR0xA2MEgFcX7ohsyerCxck5r6c=;
  b=wN8KO5kNgNcVS1iU33/Ld+rAJ8A1aYohx1LjKIAYYvP9GLHKDLbL1WK/
   L8Jxw5k34qwGQGJErBwtV1LQfYqdPkHkVH/twsIG1YBfBUAY6sePe5VKK
   nKvd3qO07TIG0LmOiM+Wt2XAyHsZ5SPPytBQj2HDXxKVwCrPEm08+ICoN
   /vwcLljcLPQZVVDKx33P18OeEg5moTKHoCidr2RbUScewpRKGxTH0yQaD
   Bc7WWscYUNvFVuO0dqeWWnTZMR1/g5eXHPdm0gXB6tV9LC7lW/rMVVgTs
   SQGTaOc0ZYgBD++vW140oNYCMPiMRbUJ2X7dY0b6m0ybW4oFhAjf3jsKZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="41201487"
X-IronPort-AV: E=Sophos;i="5.85,369,1624287600"; 
   d="scan'208";a="41201487"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 11:09:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na3zu3x+yPJbtONuO+uhZP9bjQ6JvNiIldg4cy/e9JjVABWNhjaAB5H2HkGCSwTuD8HVoYj9v/xqfWI52E5GTbRWMpmr49tF+BK71IZNwr+/ff3qY2AOGX77BWi0xnBfZUIupNZ9SNMVf0tLmsxi/YmlCpOuhpVIy/G/JDHf9iI455J5JJ34jd5DiGilbg7BW0irfmwgZeioPn01Bqcsd1UdLaBgxw/6tSuqCFftMBAYQC1YqzPoDlsSxgBUVQrvRidBvI13DbccWzdZPsuv+Jjwi4yY1Oc3iZaNr7+HwDDA4t4OivrtUasOiEElz/KGEc8ODKYHZvWzDKRmOLlg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JX4UGboZd8eUtJUuR0xA2MEgFcX7ohsyerCxck5r6c=;
 b=V6HmvKsKwWTR58CR25M1jwPha+JeETNp1jQiPBygT6+xEBsgvYpX6zo8bU8ZWMirwzy6OiqSBe9k7s0erMCOkRacthrnrHx9nYl3pWvgwnxnq0kkZWtas+YjaCUEy4Z/MjSYoa6nlpkHKrvhrZ3sTPHMzQhbQNMNdbugmXkoGmZulxGEDZ4VYbaTvwTljD0oYs5H2me3ivrRJaHtMDK7l8J2xI//B+zuonTUgpRH902OLxEEoT90iVVjRnz8YIbBZV8vj0EboJOTFOnIybJaBJjOCO+703Se+ANHi7XhILCx6c6Ss3QdS9eQD7QdZ4HAGWaOweJ7ylWZE887kqDx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JX4UGboZd8eUtJUuR0xA2MEgFcX7ohsyerCxck5r6c=;
 b=NL+iB/vAvEVSLnAAunt+iCNfFD3lQkxKVi+sDB09m/kpVsSrY8NmgRD+TiPSCDIpJYCokKzNNiUT3mSeY2fCQIe2b8CoXliU6EsfF6p2U1t2pOHwk1ysX6TL3MR6widk4/pVMnnJcLf1JEtHRXZ96Q0W5dtVOfaXKNTvsWyrZK4=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB5230.jpnprd01.prod.outlook.com (2603:1096:404:130::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 02:09:19 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8cc9:c0da:ecaa:697f]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::8cc9:c0da:ecaa:697f%7]) with mapi id 15.20.4587.027; Wed, 13 Oct 2021
 02:09:19 +0000
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
Subject: RE: [PATCH v2 00/23] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Thread-Topic: [PATCH v2 00/23] x86/resctrl: Make resctrl_arch_rmid_read()
 return values in bytes
Thread-Index: AQHXtt3gmA1LOJGKlUmBCVtVc7PKZavQP8vQ
Date:   Wed, 13 Oct 2021 02:09:19 +0000
Message-ID: <TYAPR01MB6330E91C3C58827D4F1F4EFE8BB79@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211001160302.31189-1-james.morse@arm.com>
In-Reply-To: <20211001160302.31189-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9NGEwMGRhYWQtYWRiOC00MWZiLWFlOGItZjk3?=
 =?iso-2022-jp?B?MGUxZDc3OGRhO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjEtMTAtMTNUMDI6MDU6MTVaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e66184d4-7aa0-4d23-6358-08d98dee7745
x-ms-traffictypediagnostic: TYAPR01MB5230:
x-microsoft-antispam-prvs: <TYAPR01MB52305F84CFE71C6890E93A6D8BB79@TYAPR01MB5230.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGMDSluh4Mdg61GXT95d9SDZ2oxdQkHcK7iyKlkvY+ESpaBKtZvDdpE9LYsJdmwQrxv45wU54dAvjem9Wz5RhL5JUiOxgW9NgRJDAti443//TTNQu1WtoHMDKtvqg4qQOGuctI8lmryP+dGilGIx8QnEfwdIX2MW9YwMqeXznt3Y8r40vMsTGr9ZjyzDWDqy1GGCJMVrYLWgmirom2nri5N9LFNz4S/XV3j3C+faVgr7xKIhZd5zdNlbDEM3G6R9PBLSC4sKdcwwNgaoP3s8SuJcwYTZ2DjmrQbzQ+++5WD9AdC0z3Qkiv9AOm55Y6nsotT9LZkV4aXVuaFngM3oxBVrbNxTl1MWfmBSR64HILNZTW/UHQBVtXoOdCiSdImgjqWfMmhpi3olIDByQnBogRySQspa+U3xmXPjCrDG7dSrOvXA+ZlkZg5MJhHlFeqXh8yGKtkaAa+cwbKNg1GHCnxuy8EXmQn2H4CgEZYrOGxm2yBK/5fNK8G1k7iITS5ytL8hJmFavEBXYrqoHw3u1JF1HX2zrZ36UHWwtx7GWHFeF3IvMSCbasFbEcdNglIidv/mTnLb1dpt1Ch/jlyMLGKOzfu8MUTiBset0muQ/PT9QhCu8FQmeJte3Etc1/DN8GQ6scb4Gd8pN62xO4H0oIJkwBGaIfpH6o0Dv5nrL3BSFLOsxgsyy5hKrrz9d92a53vOxZM4c9Of/yryEs49eHvlF0f+KtOaM2hfXHC1AZfEpHTXHg82scWxGR0TP6v8D8x5+W8XNGAc9C2K94MOj9UMl296lror/ByQSin6907JrlGhI9jnqX88eR33GimyU/QQff+Ht+K2bZ3wF1QLPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(71200400001)(8936002)(122000001)(82960400001)(33656002)(38100700002)(86362001)(76116006)(186003)(83380400001)(85182001)(8676002)(66446008)(26005)(66946007)(66556008)(64756008)(66476007)(508600001)(9686003)(7416002)(54906003)(4326008)(110136005)(7696005)(2906002)(52536014)(55016002)(6506007)(316002)(5660300002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Nm5Zd2NGcFhQRDI3ZG9QdEt5OERXYm5hUzQyTFBiYnVTL216SC9YTmFk?=
 =?iso-2022-jp?B?cy8raEFNWnFaZ2xpOHVOVnlONDhYQWFhNlFKeldQZ2IyZFA4QjJPbzBK?=
 =?iso-2022-jp?B?ZWVXNkozUU9RNUYrZXh4ZEtLN0ZkRnhIRXZoa3BZdm5HbmdDdGl2UkVa?=
 =?iso-2022-jp?B?cWlEaXJ6YjRCcTY5WThYV3VDNWxtQjczWEFNQlc2NUVFUzQ5NjROMUpx?=
 =?iso-2022-jp?B?QldLMVBVZ1hMNXBCTEtUSzRQUTQyL0U1S1A1ZkxwVGRoL3ZzbHJoazZS?=
 =?iso-2022-jp?B?VUc0Mlc2bzVBM0M3ckorTHV0RWNQNzd0eStxTXlOaGNQVENkN3lnR25D?=
 =?iso-2022-jp?B?YWovdEtPZ2Y1Z2J3ZUtBeGcwaytmQlNHUlJRa1pveTFxVnA2VVV6Y2J6?=
 =?iso-2022-jp?B?MzcyclYwREpISzNSVUtvQ05CWXBxdnU2eDl3TmxZZGhhMU5BeW9ZSkYv?=
 =?iso-2022-jp?B?V0ZLbTJOWTdZblpvcmprMldybHR6NFc0OGJUSDJ4Q0J0aHozY2VIME9j?=
 =?iso-2022-jp?B?cDVMTllTSXpKZm5UcHZvYldmRzdJZXBRWTBCVFEvb3ZlVHpPaHlsa3dH?=
 =?iso-2022-jp?B?ZzQ0R25DSjhaYUJoZnFrdmY2RTZ1aFlsb1owRlNwUEFxK2trbHVRNmEw?=
 =?iso-2022-jp?B?SVo4TU53Q3lmUDVNalJaUldWdlVSK0VLRFNhZjdkbnNrOHQxQTVIZTZ6?=
 =?iso-2022-jp?B?Uk15bThIcjYwNmZtcXFMTVVKckRHeTdsNnJ1RG04WitwOG4rbVNJVUpz?=
 =?iso-2022-jp?B?VHQ4N0N4VG1hTVRqNHhwT3JwUk9BT1ZyR0w2V2pQMjgrUGdvQkcyZGs4?=
 =?iso-2022-jp?B?RU1KQU9EQkQ3L2l5SHYxQ3QyRVFJelpyRkJtOXV1OWxsMlZTamYyb2NT?=
 =?iso-2022-jp?B?MUlwRURWTWFpdXZIc3dDQmlqbFYzT3RTYlJXUHRTUGMzWFJZVFdjQjhw?=
 =?iso-2022-jp?B?ZXlPUTY0WDRmN1l4S1A5M3hackFpY3JVVWV3QmNxeTR1UWNIdU5GOVJE?=
 =?iso-2022-jp?B?Q2NlNlN0NHJySm1rdEgrNWZ1TkE0Tm5jckdwY2x2Y2hZZWlhbm5QYVVP?=
 =?iso-2022-jp?B?VWtWSTgrL3Zsakw3L2M2T2hsdDJjQ243TTU5amJlWEpKUkVvdkl5NDhF?=
 =?iso-2022-jp?B?K25PTGV1Q3AzdVUxWGdsNytjbFFLcDRJc1dNclcvMytvdzRSdEhkL2p6?=
 =?iso-2022-jp?B?cjdOdWJ6ckRWdy9aSnRWTnVHcXJnWnlId3BtVnE0R2tCamRqWDIrcjhn?=
 =?iso-2022-jp?B?Qk04VUw3S2g3R2ZUQWlYY0x2UXZkQ0JTRHZrenVOUjhyTjB3MTZzVzli?=
 =?iso-2022-jp?B?R1B5bHlTQUtzRVlJOHExbVhxcSt2ZWw3T3NUOFY3eXVzNVJ3YldFZjVP?=
 =?iso-2022-jp?B?OC80S3FTV1p3TUNDMGdJeCs3eGY3bTgxMFAwYWVuRlIxaGNYYWxlYWxL?=
 =?iso-2022-jp?B?UEpJb3RQaEVOT1VCN3ZNT29JSGE4QXU2S0RGd2pseGtFS0w3aUN2U1I0?=
 =?iso-2022-jp?B?YXJ1bWJKN2dScmRwd2RIWVJOTU15TDVVbVBBTlA2TFV4Y0krYVBuZlY1?=
 =?iso-2022-jp?B?N1VmWnlmL3QvbVQwdm1VbjYzMEJUeXhsa1o0dmk4UU1lb0Vjam1ZeUhH?=
 =?iso-2022-jp?B?ZWhmRDhIS2swdHdtNHBpNk5nMTBMNW9ySVl0Ym1Lem9QbFBmRzBFTmpK?=
 =?iso-2022-jp?B?YnlIMytGcEdnaTZkSnZURjBOQWozYzBkWXFieUJ6R1ZNMmlQSThOQkRF?=
 =?iso-2022-jp?B?ZVVXbDloY2F2bUpybkxVREo3VVNPem9EZDM3dFA2NG5TMk9iQlRoRmoz?=
 =?iso-2022-jp?B?RmV6VmlIWE5QMnJEb1k4K25qKzl6NExiajFPa2pzaDBvSlBsNHhZRTdV?=
 =?iso-2022-jp?B?YmU3elRpY0hVUDh4MGRSc3g4U1dVNFdYUGxDbHRxVDNRYk5wNnowbWRl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66184d4-7aa0-4d23-6358-08d98dee7745
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 02:09:19.1090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RcHuf/Uyz75CXC4xj1Vbp0Trs/JM15FuyevPmkQ0tsI3QAPr24V7Xc6C2+vUHlbE3nLKp+FJN+T4mPULDp4MqLnjk3UGmoDXLoV/2xupWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5230
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> Hello!
>=20
> Patches 1&2 have been posted independently in case they are wanted as fix=
es.
>=20
> The major change in this version is when the mba_mbps[] array is allocate=
d.
>=20
> ---
> The aim of this series is to insert a split between the parts of the moni=
tor code
> that the architecture must implement, and those that are part of the resc=
trl
> filesystem. The eventual aim is to move all filesystem parts out to live =
in
> /fs/resctrl, so that resctrl can be wired up for MPAM.
>=20
> What's MPAM? See the cover letter of a previous series. [1]
>=20
> The series adds domain online/offline callbacks to allow the filesystem t=
o
> manage some of its structures itself, then moves all the 'mba_sc' behavio=
ur to
> be part of the filesystem.
> This means another architecture doesn't need to provide an mbps_val array=
.
> As its all software, the resctrl filesystem should be able to do this wit=
hout any
> help from the architecture code.
>=20
> Finally __rmid_read() is refactored to be the API call that the architect=
ure
> provides to read a counter value. All the hardware specific overflow dete=
ction,
> scaling and value correction should occur behind this helper.
>=20
>=20
> This series is based on v5.15-rc3, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/resctrl_monitors_in_bytes/v2
>=20
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/resctrl_merge_cdp/v7 [1]
> https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com
> /
>=20
> [v1]
> https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com
> /

I have tested these patches on Intel(R) Xeon(R) Gold 6254 CPU with resctrl =
selftest.
It is no problem.

Shaopeng Tan
