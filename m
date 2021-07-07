Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6363BE71A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhGGL3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:29:43 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:43158 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231430AbhGGL3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1625657222; x=1657193222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6IQ7523/Zo1XGOq7fvtAU3Sn4zc+6T4wSLbeP+D0R+Q=;
  b=dwNSG8jaHS1SBw4rKI1dC5f1Y3Ai/n9TZC4E609m3JPEDXCs7hQRcBsd
   VDVzUUgF9DhHinEs6A3kA58+vIZ0P7Z+q1qyGZMOwTeNts4n0vAO3uXqj
   BVqCWpSBa5nZZmSfK/YsbXY41q152jlPZkg4DXzo4RGXsLVaoBZ7Ebsz0
   0lggl4VwvAMazE15SdtdM+L9NCPnXzE/79/qodxGXJSFtOmHFugGcozZH
   dTQBy2N+MJj4loRtTcyxVGd4dmRCJyZqQFABOtuCs7NYp3ih+DtxuFqIP
   cFl5Kb9ACksabnU48dCc67sUElW9Nb1+RputU7mqcjkTgWnJBJG7M+NUx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="34504201"
X-IronPort-AV: E=Sophos;i="5.83,331,1616425200"; 
   d="scan'208";a="34504201"
Received: from mail-pu1apc01lp2055.outbound.protection.outlook.com (HELO APC01-PU1-obe.outbound.protection.outlook.com) ([104.47.126.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 20:26:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTfqu/o9KPlaiOnPulToakMNrXjDH7BQGkAZ/bzdyxblgXhTPon3on49iWyEAhzvpQbGIGntF+hNADlwt5TTP6koj6LhwgCZ8620FvoQ/OsopjhlXmJvs5u0p8bTxVD2s2PaP9ZNzi3iG8gaDLvZ33jj+km8lSUrWBZOepb4gNGVg5RmsxxpM8qBa7sOLwbWAM1CLCedqo0OGjos7HbX9xLj+Oqwaun3MIXhmH1sKcQ5EK362SnHVia+WRR+7jrpG3i/SxGyS/VfxLBkFy043oEPjtV8KVUFIQXTvAERsRDeQmCKQ1A49Yn5y5LJsmYGkKjLH6YQ8ov1f4txcZX4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqc/Rw3rSzCTAFfmYHpsA4vE5PNK8c6RXaUjHbdHq1A=;
 b=cqJ/pXQiq/EsqetJW5JdAV8fcwriwn1IM9Q3cG8GMzu9WkGopn/0Lcw70CFsY9TqYlCyupPf6mcasl1sl+0mAypt38ejFpJc1tVcAoVDBeWfee4XkPR8SwnbRc5dxlOiveb/noUfPBV/uMviZBUdBHb9mqy7DFCJrz2lfWipSGj8VqDBLioLLRzIFanzIYEN3s8DbYqoswi3Io256XM2cQvuCxqj8Eo7SkHydbWbutvRtlQI98EWEOvRa1tldqVPQyN+13eBsoNqyBmstXnVOmDKL+j8rOQ7US4kqS9XNBbwFg/dB1F4EJXkq2FWMRzEtwtZ8na82IQV/RCcCtM4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqc/Rw3rSzCTAFfmYHpsA4vE5PNK8c6RXaUjHbdHq1A=;
 b=m8JKjYxjByzuN2/vm26VMwTN292Qw+MYeaZ79jBhbJtGajWSAWsJyI/MOSOy6lcYZv1V5Br4wr9uSJ9Z+BDFcoejUju0DatcbgVS6U8e4VdeSz5pG16ECh1jFlTIhZIKmxpVrZUG7t5M07jB7pgf36m6LgBFtti0EqPSDreNjB4=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY2PR01MB3195.jpnprd01.prod.outlook.com (2603:1096:404:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 11:26:55 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::3856:85dc:d6ba:ec90]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::3856:85dc:d6ba:ec90%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 11:26:55 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: About add an A64FX cache control function into resctrl
Thread-Topic: About add an A64FX cache control function into resctrl
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AAABE+WYABTmUCMABGH4GAA3M648AA3z+sgAC1LKkQAEYGy4AIMyy6kA==
Date:   Wed, 7 Jul 2021 11:26:55 +0000
Message-ID: <TYAPR01MB633085C894CA3B064BB637E28B1A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
 <TYAPR01MB633071CD547B0AAF818520E48B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <f53b9bfd-0d55-4cf2-fabb-82b3ec86e52a@intel.com>
 <TYAPR01MB6330758A49FECF90B5290C768B259@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <89416df1-4e91-8ad2-981c-827808a65229@intel.com>
In-Reply-To: <89416df1-4e91-8ad2-981c-827808a65229@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-07-07T11:22:51Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d4978975-b86a-4542-afb9-aa0b2e7d7ace;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b9e8ece-839a-496a-b4b5-08d9413a2048
x-ms-traffictypediagnostic: TY2PR01MB3195:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3195CC3C46BA799AF5D987F08B1A9@TY2PR01MB3195.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qCrKe7KcC3uFS0kZ5xh9Ha/xksl4ZsEqO1fd5K+/A7ndhkl7eOvuuTacTrDMD5M7T2z4JkZigzwUWB9owP6+aRvnc/pwKlLx1K9pdowQtp9nXYHUUyNnaPRp6l+czsKeBqBWem5DxFliqEsdzJNskag7e+76CWUqcPhatfi7ID6Q29r9d7I9DKEnUmsvpQgY0gY8yuorkvhLUk5ywlcKXcn+7mDsV2GDytsi0TmAcJlhV6Ybh6r0Uiit5lYxG+HVm/vJt3lQzd88QC1nZQw2U0YoKwhvIGHqih8yqWZe5BXk41LwYuc0P8Ag8In7MQm6dpwzSPHlZWrsNePUG35gvZVjfI93nJsxccUMSbc7rU4BtU0myiKDZ7JbNDw0M3SkxJJZSFbMzfq3SegoGSk/ymV+4xflIKgtgQF3Ty3OjPscLi/w9O3Ci9ew4UGKv8ZJ9ExSy/8gUFY2dhAhH3rfGnN4N74zZ3uGpvPTC779cekVGa8RJ3cgz0ZJ5KleLHVtJ/H2S79FOkamiHNIxrl+Ww6nKNlhdasNERxW+mO4ojUgiVej0VjF8H+TtimQOvhYiUax1YIZk2ute0AjwFgr090ZfK1xGQkpGVauy2EI0jE+2/kHdD0/qJzWs/ajruXklztZBOrpshgd6J6KkB13HC5vY8TbVfqzQTtazvbIREayjuX4Mp++y+Os4Y3Z3wfZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(76116006)(55016002)(110136005)(86362001)(71200400001)(83380400001)(8676002)(5660300002)(54906003)(64756008)(66446008)(66556008)(186003)(33656002)(66946007)(122000001)(2906002)(38100700002)(66476007)(4326008)(9686003)(26005)(52536014)(316002)(7696005)(85182001)(478600001)(53546011)(6506007)(8936002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?OFRBaStHVU42UmxFd3dUdUh1L0tOVmZKdCs1WnZUeDRWajlDQk5MTStS?=
 =?iso-2022-jp?B?ZE16WUxGNGRZWDRibmRScFZrK2QvWmRGeWJ0d01iYVZmYSs0bVBmeXdz?=
 =?iso-2022-jp?B?NG1lMXZmSUdqMURPbnFhNXAra2cwNTJnaXBDbWp1NThpT2ltLzVPZi9r?=
 =?iso-2022-jp?B?Nzg5WWZFSHhUYS9JUW5RSVBtOGZLTXd4U2JiR1JzR1ZzTmJZU0JWdlZ2?=
 =?iso-2022-jp?B?TU12WDNxcm9MYzhTcjgvOFNVdUVET3E5Y052aUxyTWNhRlB2eG5oV0xT?=
 =?iso-2022-jp?B?N0xKT0FQV0c2Mk9QY1hhU0J0VFBiWHBrNTVrR29CWUFTSU1GR3JHUHRk?=
 =?iso-2022-jp?B?UDdwVDVHVjFWb3F1WlQxdEZxa1JVOVp5SGFjTkdLWFF2SmM4NlhuZlls?=
 =?iso-2022-jp?B?ZFpGR3NxSHdRdHROejlZK2htMEdlUTc1Z0x2ZjkvTlpqU25Ub2pVZE81?=
 =?iso-2022-jp?B?b0h4aUhsOWk3NndzYmxuOTkvL3M4eVMwSGdtbllHTzZ5SDVNYVJwTGln?=
 =?iso-2022-jp?B?OXcvSXRKcjQ4MGNDNVdNcHFLelF6V1dFNnB0YXk5dVVWMU45RTZTYUgz?=
 =?iso-2022-jp?B?NmJLa3BxYU5NVHZjaUcxZDJndTFpWkc0TkZwSmZrU0wyWVhMVUNzMXYw?=
 =?iso-2022-jp?B?V015emxXaGovNGt3QTRzSTdYOTBUVndCUm90dTlNRFJmMC9ZOUg0QjNN?=
 =?iso-2022-jp?B?OGh4QkppUWg5UjVQdC9iUTZWRXkxSEFLS3UwWjVhRnJuWDVZZFJXRVZp?=
 =?iso-2022-jp?B?cWNVd0xpd0FWMUVZTTVYU2ZsRFcrNXJXTEhTU1VoME1OUDN0M0dRbEh6?=
 =?iso-2022-jp?B?SUlqbWpkMUU5R3FBV2o4eFBCZXpYbTY0SVV1R1ptLzhRaDBENGY1UDhp?=
 =?iso-2022-jp?B?OTE2NENnVmxoK1ZKMzZIZ1FKY1lwQ0VKKzgydFNTZDI5Zy9icnRsdXVr?=
 =?iso-2022-jp?B?NExOdTBCRXRTZVdXOXVaWmR6bDZHbUNIdW16M1ZkOXRycG9GNXdsR3ZX?=
 =?iso-2022-jp?B?bmtrR1RQMStOUDdVRURwWEh6VzNhNHo2N3pKbUQwaU9MdUI0SFM0MFV4?=
 =?iso-2022-jp?B?a2tNWVMydlZYV0RlS211aHN3OHZ4bkdsejBGQlkxaXVEMVZGWlhtSXJq?=
 =?iso-2022-jp?B?OXY3VUNYbXRQMloyczJWbUQxZ2VjUVU2M0hMcWVWeFg1Vml2U0g5bHdh?=
 =?iso-2022-jp?B?SUt1VnlBdTV4NlVjMFlqTHBqN1plM29WUXNXdkdLTkZSd3YxVW5jRnRr?=
 =?iso-2022-jp?B?b2srMnBmVWRoQUgzaDc3dW9UT05kT0hKTis2R25VaVg1eE5iSW9EZi9L?=
 =?iso-2022-jp?B?QTNYaDFaejkrRHBxamxSK3hiQXNKU1hQZmZBc1JTV1NOZ0RPMXFNVFh6?=
 =?iso-2022-jp?B?eTEwSkZFS2REdWJEMGJiUklMSWFvOGRpdmlFVDZYU29xUGVQRW1tSE5V?=
 =?iso-2022-jp?B?K3h4OE1oWFNPRWR2YVkxMXk3Mjk1bmhkbDdoQjBEY2lyOE5MQVBJK1B6?=
 =?iso-2022-jp?B?cDhSTlV0ZU1nMTd5UzcyMnBxeEk1cnozSUQwOGdiZGc3WEkvSWEwWlJj?=
 =?iso-2022-jp?B?Zm03S2JMbXBCUHU5MlYvbi9rTzlTL0g3bytuMWgrb00vK3NTK3VRSkhv?=
 =?iso-2022-jp?B?bVZjbFZKQXlmNGpuRVFQdFJUZ01lOXdnUndtL01oejZWRUtHTmNTZkY2?=
 =?iso-2022-jp?B?OHZaUlVTa2xTY0VKUVpBZ2V5UDlCK3hGSU9XVkoyQzU5dnNmUmZvOEI4?=
 =?iso-2022-jp?B?T21ld3dNbWpLMitkVlVNQ2NnSnh1aGt0T1RmTFhscEtBRmNMY3VkTFpx?=
 =?iso-2022-jp?B?OFcvZW9hejBaSXNDNmU5V2NwV282NEdaamVLMEJNMm5GVjZEWHhqWE9G?=
 =?iso-2022-jp?B?UEVsSUZvdzR5R2V3ZzlCNjgwYkpzPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9e8ece-839a-496a-b4b5-08d9413a2048
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 11:26:55.3826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cd6ToVSsSz1zm2UkzeLWGr4E+AtnRgNGCDj/XvXirbEjawmqh5J9HFGhh0/A3l38Dq70lyv9wAD7bNG9PSBJdH2+9URjtpMf8x55V4eGjJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

> > Sorry, I have not explained A64FX's sector cache function well yet.
> > I think I need explain this function from different perspective.
>=20
> You have explained the A64FX's sector cache function well. I have also re=
ad
> both specs to understand it better. It appears to me that you are not con=
sidering
> the resctrl architecture as part of your solution but instead just forcin=
g your
> architecture onto the resctrl filesystem. For example, in resctrl the res=
ource
> groups are not just a directory structure but has significance in what is=
 being
> represented within the directory (a class of service). The files within a=
 resource
> group's directory build on that. From your side I have not seen any effor=
t in
> aligning the sector cache function with the resctrl architecture but inst=
ead you
> are just changing resctrl interface to match the A64FX architecture.
>=20
> Could you please take a moment to understand what resctrl is and how it c=
ould
> be mapped to A64FX in a coherent way?

Previously, my idea is based on how to make instructions use different
sectors in one task. After I studied resctrl, to utilize resctrl=20
architecture on A64FX, I think it=1B$B!G=1B(Bs better to assign one sector =
to=20
one task. Thanks for your idea that "sectors" could be considered the=20
same as the resctrl "classes of service".

Based on your idea, I am considering the implementation details.=20
In this email, I will explain the outline of new proposal, and then=20
please allow me to confirm a few technologies about resctrl.

The outline of my proposal is as follows.
- Add a sector function equivalent to Intel's CAT function into resctrl.=20
  (divide shared L2 cache into multiple partitions for multiple cores use)
- Allocate one sector to one resource group (one CLOSID). Since one=20
  core can only be assigned to one resource group, on A64FX each core
  only uses one sector at a time.=20
- Disable A64FX's HPC tag address override function. We only set each=20
  core's default sector value according to closid(default sector ID=3DCLOSI=
D).
- No L1 cache control since L1 cache is not shared for cores. It is not=20
  necessary to add L1 cache interface for schemata file.=20
- No need to update schemata interface. Resctrl's L2 cache interface=20
  (L2: <cache_id0> =3D <cbm>; <cache_id1> =3D <cbm>; ...)=20
  will be used as it is. However, on A64FX, <cbm> does not indicate=20
  the position of cache partition, only indicate the number of=20
  cache ways (size).

This is the smallest start of incorporating sector cache function into=20
resctrl. I will consider if we could add more sector cache features=20
into resctrl (e.g. selecting different sectors from one task) after=20
finishing this.

(some questions are below)

> >
> >> On 5/17/2021 1:31 AM, tan.shaopeng@fujitsu.com wrote:
>=20
> > --------
> > A64FX NUMA-PE-Cache Architecture:
> > NUMA0:
> >    PE0:
> >      L1sector0,L1sector1,L1sector2,L1sector3
> >    PE1:
> >      L1sector0,L1sector1,L1sector2,L1sector3
> >    ...
> >    PE11:
> >      L1sector0,L1sector1,L1sector2,L1sector3
> >
> >    L2sector0,1/L2sector2,3
> > NUMA1:
> >    PE0:
> >      L1sector0,L1sector1,L1sector2,L1sector3
> >    ...
> >    PE11:
> >      L1sector0,L1sector1,L1sector2,L1sector3
> >
> >    L2sector0,1/L2sector2,3
> > NUMA2:
> >    ...
> > NUMA3:
> >    ...
> > --------
> > In A64FX processor, one L1 sector cache capacity setting register is
> > only for one PE and not shared among PEs. L2 sector cache maximum
> > capacity setting registers are shared among PEs in same NUMA, and it
> > is to be noted that changing these registers in one PE influences other=
 PE.
>=20
> Understood. cache affinity is familiar to resctrl. When a CPU becomes onl=
ine it
> is discovered which caches/resources it has affinity to.
> Resources then have CPU mask associated with them to indicate on which
> CPU a register could be changed to configure the resource/cache. See
> domain_add_cpu() and struct rdt_domain.

Is the following understanding correct?
Struct rdt_domain is a group of online CPUs that share a same cache=20
instance. When a CPU is online(resctrl initialization),=20
the domain_add_cpu() function add the online cpu to corresponding=20
rdt_domain (in rdt_resource:domains list). For example, if there are
4 L2 cache instances, then there will be 4 rdt_domain in the list and
each CPU is assigned to corresponding rdt_domain.

The set values of cache/memory are stored in the *ctrl_val array
(indexed by CLOSID) of struct rdt_domain. For example, in CAT function,=20
the CBM value of CLOSID=3Dx is stored in ctrl_val [x].
When we create a resource group and write set values of cache into=20
the schemata file, the update_domains() function updates the CBM value
to ctrl_val [CLOSID =3D resource group ID] in rdt_domain and updates the
CBM value to CBM register(MSR_IA32_Lx_CBM_BASE).

> > The number of ways for L2 Sector ID (0,1 or 2,3) can be set through
> > any PEs in same NUMA. The sector ID 0,1 and 2,3 are not available at
> > the same time in same NUMA.
> >
> >
> > I think, in your idea, a resource group will be created for each sector=
 ID.
> > (> "sectors" could be considered the same as the resctrl "classes of
> > service") Then, an example of resource group is created as follows.
> > =1B$B!&=1B(B L1: NUMAX-PEY-L1sector0 (X =3D 0,1,2,3.Y =3D 0,1,2 ... 11)=
,
> > =1B$B!&=1B(B L2: NUMAX-L2sector0 (X =3D 0,1,2,3)
> >
> > In this example, sector with same ID(0) of all PEs is allocated to
> > resource group. The L1D caches are numbered from
> > NUMA0_PE0-L1sector0(0) to NUMA4_PE11-L1sector0(47) and the L2
> caches
> > numbered from
> > NUMA0-L2sector0(0) to NUM4-L2sector0(3).
> > (NUMA number X is from 0-4, PE number Y is from 0-11)
> > (1) The number of ways of NUMAX-PEY-L1sector0 can be set independently
> >      for each PEs (0-47). When run a task on this resource group,
> >      we cannot control on which PE the task is running on and how many
> >      cache ways the task is using.
>=20
> resctrl does not control the affinity on which PE/CPU a task is run.
> resctrl is an interface with which to configure how resources are allocat=
ed on
> the system. resctrl could thus provide interface with which each sector o=
f each
> cache instance is assigned a number of cache ways.
> resctrl also provides an interface to assign a task with a class of servi=
ce (sector
> id?). Through this the task obtains access to all resources that is alloc=
ated to
> the particular class of service (sector id?). Depending on which CPU the =
task is
> running it may indeed experience different performance if the sector id i=
t is
> running with does not have the same allocations on all cache instances. T=
he
> affinity of the task needs to be managed separately using for example tas=
kset.
> Please see Documentation/x86/resctrl.rst "Examples for RDT allocation usa=
ge"

In resctrl_sched_in(), there are comments as follow:
  /*
 * If this task has a closid/rmid assigned, use it.
  * Else use the closid/rmid assigned to this cpu.
  */
I thought when we write PID to tasks file, this task (PID) will only=20
run on the CPUs which are specified in cpus file in the same resource=20
group. So, the task_struct's closid and cpu's closid is the same.=20
When task's closid is different from cpu's closid?


Best regards,
Tan Shaopeng

