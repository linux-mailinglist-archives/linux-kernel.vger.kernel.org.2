Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D732D38270B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhEQIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:31:01 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:45765 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhEQIbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:31:00 -0400
IronPort-SDR: FywzQcURE34FrLu3ujgPReKuzpAHf1zsePXdt1a51ju3OW5ZcqyQoVDBAurXGjgldje19rwkNu
 dRqo30zdAmK0APBaizAWeHc0ceR1QiX+gJ0B49W7QQciGKEwKRGw5ui5DwUNEOVpIA/LSpxjFS
 9CVZLLMO1LioWcqephauNMGLYDU5V9NwA6RbKs4gESFTWhDZ6rP3PQQVImhed8+oOnZKhd8/W1
 6jRfq5LKcvbb2IqwOLNBfw0fK0UO+UrIZEO0uEdYOmt00RtCRZ8SFAzntyvR20ILHbpAXNLk+A
 dpw=
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="31362177"
X-IronPort-AV: E=Sophos;i="5.82,306,1613401200"; 
   d="scan'208";a="31362177"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 17:29:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei8sh4FBPvZXSKk9tBB7pMF3aNeIsSSJ1u1HlXsknafMeNcIpqFzi78t9rSOVzlxATqQrIzWAQpzafJUjAFsiVtL/I6YqHJsHe7cSHuQQU2t8MY7Hktfmzau2jRHKnYjZlTS7XMX2vx9x4XxcJdic4EEZWxWjTPe4sm9ikXgDeCrFgAxA9L2Q3OFI+AOQsymOK0mfBOS56HeU+dPnFBIsP1fuKtwJZKBXMEY249gY3KmVkSkHU6NOLegVN7wbVxxOlkmKhaI8nVkT1loCNMUl1MPjBISNWuqozCXeQptjqNwlPdKVdovkkNk345ojlsmAMoaYcgICAJcuCgrJa7prQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRhUzwXMCNBArx2NeIyU5iirLuy6N+fpLtXafQbRMNg=;
 b=TqL0vOdtXdWo8eETA8PlNZVcqBK01UaAjrKha147X1rpWb3yGQ/u47fGygFhOfPAw3dL3oyY5Ke1woR4817anaJngFsgsdds3z+EVQJUYJWMueugTyQkZjyjgq3jF+M27ntiWS54uygQOaNM0CiYGoYI+rLEH8o1YZU/RryuLtD9DzRWQeXcWvlW0DloikLw6NxM0BpASeAiaJ8hQoQMi+PAIIMT3IrrKi89pCZ4adGM8/TeHF7JjWzENu9sCLbpKXi3ioSNW3BKWEh3zd2Hf936PVIoZzrPtqXo4QPU2CyQ5AKG4v5kRU3YICXtU7HeDFmWlrA2KUv93O7E4dIPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRhUzwXMCNBArx2NeIyU5iirLuy6N+fpLtXafQbRMNg=;
 b=cRkU00F3NHeDaoR9Q3c93YqZ7IOdWYq3BVfOcdXcD1pW/5QgaFdOAMx0PJHCJzOWaJmch9kIM/k52tQjej6y+l4kjR8HoSNcQH8PgxHSaK9vQyma5ibgfz1x+IFIXj9hNG0qyVPKOEn2iRsNeJO0P2h6p1hbNHWs9YFQxz7kMUw=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB5450.jpnprd01.prod.outlook.com (2603:1096:404:8037::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 08:29:38 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d496:4343:e4e6:c49b]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d496:4343:e4e6:c49b%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 08:29:38 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Catalin Marinas' <catalin.marinas@arm.com>,
        "Luck, Tony" <tony.luck@intel.com>
CC:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: RE: About add an A64FX cache control function into resctrl
Thread-Topic: About add an A64FX cache control function into resctrl
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AAABE+WYABTmUCMABGH4GAAABHrQAAJZX6AANNKoOA
Date:   Mon, 17 May 2021 08:29:38 +0000
Message-ID: <TYAPR01MB63306067FB5BF24BE15B3E3A8B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
 <49cdd0b707194148915e2efe2ab5d707@intel.com> <YIvuGLmcJcw2jLT7@arm.com>
In-Reply-To: <YIvuGLmcJcw2jLT7@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53c1927b-8e81-4f58-5ef2-08d9190de943
x-ms-traffictypediagnostic: TYAPR01MB5450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5450745E7E45E23D56CF99028B2D9@TYAPR01MB5450.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7m+iUJ6plRGPtyRA7HxhLijjBKE4c+3NGGWjuLy7Q6qAG9o8h3Bo89lZPuc3tC+DDU8TBCEg18eepE/aU+VRx5F9eMdnOCXTBw3d3d8vWSoX1/F5+mOWnKb83fwYm19oWPzekQgjmhgJ34bbhEVhZv9hofo26ym2thjFz1RMBSqiO9NWiHIV3ZvTJndfU7dltaEoR7gLjlAsPIFGEBfMavD+/9Wpr4uQjPdQuQWRpur2uUrqrz3/3aQ76SYJxCOrR3J6XS8VyMjXnvzOKrXWvxcSGO7Z/mTYRoc673XsNFe+QprjlB6vUE0o0Yx4iiBX6e3VGzSz2xjqEQI7l/0Gq6MNkYMOW1aDDyAuYq5B6BTWQFM5+onKae39IMfzSfNfC5ZiPFmeonX6mGkuhReBX/Z2LW6X8k9T24mmHdUojv02gRGi6t9U9kNK+p+LpXutrR15TlrV4TcS7pmkMPBuZBNLKQX93VIOPUJx3ZzwZYqjFGMAN/UnNOS+kWmn6qCU7wc6X9nKzNoE1TMT0b/TIrhda56TDAbvF4E2iN/4AZzFhsyGRbPejCxY+r1lEkXljA9CrvhOlhAwV+6YVxJOqw5CRkPTSEG2dgjgczg9/Go=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(4326008)(107886003)(186003)(2906002)(64756008)(66476007)(66946007)(71200400001)(66556008)(66446008)(110136005)(54906003)(316002)(55016002)(86362001)(9686003)(76116006)(5660300002)(38100700002)(478600001)(26005)(33656002)(85182001)(8676002)(6506007)(122000001)(52536014)(7696005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?Yk1TWXJ5OWxOeEU3MVNlV3VPWVdwc0d5Y1RiQkZKdWdITEdHMWcvbWVa?=
 =?iso-2022-jp?B?NHhia1gxSFl2UHVTbUg4MFdtT1BqN3BmbEpMRXJtVWN0V09XM28rajJo?=
 =?iso-2022-jp?B?UHd0U1VVcWZLT2drS1hEdEkrclBKOExMNGZxVVlTSGFKSTRyRTUwSzY3?=
 =?iso-2022-jp?B?TlNydDBDcWlSN3daTG55NzRDKzJYQktQbFNDbytwN252UzVHcDBjWlFk?=
 =?iso-2022-jp?B?NW1tR1BiNkozZzV3K1B2Y2xmNkdJYldySFB2ZUJjSng4d0NvYWlwLy9D?=
 =?iso-2022-jp?B?OFZsUkhJREQ1NVhmTTdYMXdOUWdubGtYUmhlVUtKNG1LQmFjaUt3aWxE?=
 =?iso-2022-jp?B?RFVKRHpmZnE2d24rZjlPc05aMk1icFJSNnllaVlNbERmRzdLMDA3WjBH?=
 =?iso-2022-jp?B?ajFhM1VXazB5Y0Vydkt1eEwxc0xHN0U2SVZVWnNIQW5iV1I3RkhNYUFw?=
 =?iso-2022-jp?B?S3o0cW40aHhYWjA5WDR3WUpYNUZGNW9EY05qRCtSVXJwTkNlQ1lpdFpG?=
 =?iso-2022-jp?B?UW5Xd2htVVI5MHVuR0lieHRVenl0YUNNdWtOV3QycGkxTjMwejdNM3pl?=
 =?iso-2022-jp?B?aDdsaHZmcGFweWFSa3FXMU5IRmVYTVhCemR2QWZKVzUySVBQeW14a1l6?=
 =?iso-2022-jp?B?NldaZkdtSEI5T2t0UUFCSGZzNExMa0dqVGQrbldMZDVmamRFQUVsWVZF?=
 =?iso-2022-jp?B?TTNwYWNDbnYydXUrT2Y2VkFHS2Y4UFlrMTlMS2c0RnY4ZllzaG9PMmxn?=
 =?iso-2022-jp?B?M1Uzb3hxV2phb01JSTdkM2VKbGcyKzZkQ2o0QUpVK3Fhd1hWOVBqRUxk?=
 =?iso-2022-jp?B?VlpEOE02Nll1Nm5kdndVOWE0ZVpvYm9OU0hBcjN4TXlqanZ4eE0wT1Zs?=
 =?iso-2022-jp?B?a0pRVDlWbzAzZHl3U2ZicGI0QlkvMFdON216MHpzWVNZc2ZjNFF6V2Ju?=
 =?iso-2022-jp?B?MzJQY0RJYm4rRlFJeWJMV2g2M3g5QTZyTVdzU1FXdXh6UCtCeFlNdlhG?=
 =?iso-2022-jp?B?T1RTNzBmbGVpWGhpQURqSzVtbmtnTHFLcVVnZ0cxd1ZJNmJ3d2tQQnps?=
 =?iso-2022-jp?B?Q2JmWlFINml4MW5kNnJuWG81NTBTSFRLTVl4YWMwOVMxYUtMS3RFZDEr?=
 =?iso-2022-jp?B?YzhIaEU5bFdjVjlKVVdHOXN6Sm9iWVQ3Y2dVTVdoZ1JFaUhuZ1ZKcTR6?=
 =?iso-2022-jp?B?eTRGYVo3U0U4eU81RHkwMTJYa3U3djFEOHRZazg1UStuWGxySFp3UENp?=
 =?iso-2022-jp?B?WFcrQ2RkOXhSOTc3NWRWSnJKc1dHQmx1ckpuVnRXbXI0RGd6R2JBcmx2?=
 =?iso-2022-jp?B?ZG9MKzBDdDc1R1h4eFFsWUFGQzBVYk9ZTmdXV0RXbXJnS3BEY21WaVhK?=
 =?iso-2022-jp?B?RXFyZEtqNXRaa2hTME5nWUh1WTRCKzNwZjZ1QXJjaGJ5NXFrTkNjQlNm?=
 =?iso-2022-jp?B?b1RkNnhDSDRPaWZNYWFoUVdUS1hzeVdPaXZ6OEhsL0lFZURMWjFkMXQy?=
 =?iso-2022-jp?B?c0lmY0JYUnVmRGRIY2IrS0k1OUVlaWFYc3VWdnB1QmkzMFVUVnJKUllk?=
 =?iso-2022-jp?B?Vm1kMlAwUm5mRXVndlI2QmR4Yjh5c0JsbFQzciszLzVmVE0wOUhiL00r?=
 =?iso-2022-jp?B?U05EVG9JK1Q1MWozdXhTc1g5cCs5UmltNjdkc3I1UDg3R0p6TGQxWis4?=
 =?iso-2022-jp?B?SEZjd0htUGZmMEhzcmlRaXpvUzVubW56NzQrZ2FxTE9hQ2RQZ3o2OTEz?=
 =?iso-2022-jp?B?dngxeE1DRElLLzExOUtQaVFvRFZ3cFhZdlVJRzl3aHphNEVlaXZickVB?=
 =?iso-2022-jp?B?UDkwS3V6bDluZGZrOFA3QWdBYk4wUm5RUDlSY3JxQ3gxOS8xKzZaSXUy?=
 =?iso-2022-jp?B?QWxNZXp1bWdKQVAydlFuWFIyT1JhMlJyWTFqb2JGeUNBWkxmZE96ays4?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c1927b-8e81-4f58-5ef2-08d9190de943
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 08:29:38.7167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZiPsZ8G10kOjszUruZOqqO2Xz4I9hm7+mv2tbj9rKLp24EWbevQQvcw59NzSujZlLRizEo+XTshLunJcyaPjEJF9kUywVQVltBI7TtE/c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5450
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tony, Catalin

> On Thu, Apr 29, 2021 at 05:50:20PM +0000, Luck, Tony wrote:
> > >>>> [Sector cache function]
> > >>>> The sector cache function split cache into multiple sectors and
> > >>>> control them separately. It is implemented on the L1D cache and
> > >>>> L2 cache in the A64FX processor and can be controlled
> > >>>> individually for L1D cache and L2 cache. A64FX has no L3 cache.
> > >>>> Each L1D cache and
> > >>>> L2 cache has 4 sectors. Which L1D sector is used is specified by
> > >>>> the value of [57:56] bits of address, how many ways of sector are
> > >>>> specified by the value of register (IMP_SCCR_L1_EL0).
> > >>>> Which L2 sector is used is specified by the value of [56] bits of
> > >>>> address, and how many ways of sector are specified by value of
> > >>>> register (IMP_SCCR_ASSIGN_EL1, IMP_SCCR_SET0_L2_EL1,
> > >>>> IMP_SCCR_SET1_L2_EL1).
> >
> > Are A64FX binaries position independent?  I.e. could the OS reassign a
> > running task to a different sector by remapping it to different
> > virtual addresses during a context switch?
>=20
> Arm64 supports a maximum of 52-bit of virtual or physical addresses. The
> maximum the MMU would produce would be a 52-bit output address. I
> presume bits 56, 57 of the address bus are used for some cache affinity (=
sector
> selection) but they don't influence the memory addressing, nor could the =
MMU
> set them.
Yes, A64FX binaries are position independent. Arm64 supports=20
a maximum of 52-bit of virtual or physical address. On A64FX,=20
the [56:57] bits of virtual addresses are used for some cache=20
affinity (sector selection) and set by user program instead of MMU.

Best regards,
Tan Shaopeng
