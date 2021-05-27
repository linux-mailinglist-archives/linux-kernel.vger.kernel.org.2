Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B69392A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhE0Iyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:54:37 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96]:63565 "EHLO
        esa13.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235324AbhE0Iye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:54:34 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2021 04:54:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1622105583; x=1653641583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3G8L8gmk24cx8oeLLbCfB/ytGh2n5U2disn9YWXjRnA=;
  b=yWKCrrTcQSNTyRpOjg27vBcVCG7u3CzQpYfk2FlI7nGiVMjt73jJBFRJ
   o796prlpte081hi+aZdPMJLYXtmhdBVQlTL1sSX5epqZ+du0soP58X9Tl
   Xn5uPzHsDV/PT7JrOVbvWJtIl20YDMQGb2hpQnX9MuDkqNSjvBEWpOsf+
   QV4ilsups91cP7pb0NFsilS9ILtJ0huYAOHw/b6lu5s7HrtgkHH6YweU2
   X0ifi3yKIwQoHvHItcri2uIyYzlKgnn9nAsD7E8s8B4Iy7iZLMclQ3kmS
   ouMwwVwAbxMSg9SCFcMTCuD4MGN8UKw7j28IzZSeVnPtrEBqxVljj0U3B
   w==;
IronPort-SDR: nRWTZDV0Dnvm33wDm2gkmL79Zs+9Qasv0FaWlovH/dGUQObNJnLVMsQGTfGXR7l4T3a11SIjg1
 ZxjtH4VSu+pGYWiWmhzRyzBG27/dtJo+q5PJjwpyFNwu4uKDorzRKsA1v95KlSWsviDRQ0HUJ0
 H6UioPsq9iR3PdAsWNWjt83KDiM0eSjC4+dq25osuNeRgIipG1SCl58/rDzewKAhHckWkpi8lX
 2W/J7GF4mkDHbQn4zH5xH85V3ePyoV2sbkrUXV/R7Jqnh2Ni3KjI42ITlDY/dI4z7AWFHjQM1q
 g2w=
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="31811683"
X-IronPort-AV: E=Sophos;i="5.82,334,1613401200"; 
   d="scan'208";a="31811683"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:45:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSft1RiieBmguWwzFR8UckYNO9ONPOpmTrjzp3GeseaKoVMqq29vEN3U3bt09p7MTMPIvEJA9xRaihKYkpQGr74tK47ET99pMYjBRvU7AjVjGuHcJxh2VVKhGvEvI9oGFYflKD2q6bwG5yJNrfDhNeub6H+MBhxbivmDtHxGPOMy7H51YaHbMUeLh9vDWSc3FtJMZNyvYUYOJBab8/E3jK25dYGJsxcMNtF2LA72Fc7KJAE3h19BXFEynlVU+9IvpZzgg/f/s7JMyQ3F3x533iCp3OhK6khJBsFkgrqJJueRGTsODw0kjOJRdIRtrOPBIhz7W5lKBL7wsdTJF3teVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmiaUHWUO46fDFonELzvT4JWAL/sx5VV7s1+boKLX8E=;
 b=h2IB2Dypo4jP2es19XvfOylSrwdG7h5en0HFnVccv43dxsOexCGttBXLXhUZhpMXkX+G3D0FcH72qcMBwyzMG7+Da7RzmTCez3uUT26sF8v/+O0IySe78IJaVWy1JEH9Ojy93QbvPAIHK3Kvl0ervFtenIYNERnR7FGTptWeDXxGWyMqXrWTMWuSd44sBmOWQZ8kygrb65IQVWEm7fxH9MjjtAqxF5K2UGHQ4wNFdtfJfZYxXx9DYTCtAmgxE2AiPylX31nsnblQpAclcHPH8wBb426ngIYgKSD+t4rP1DecLNIVLaWXqwqn3wze/IGTFM5J0+xxqQ25p9uID6l9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmiaUHWUO46fDFonELzvT4JWAL/sx5VV7s1+boKLX8E=;
 b=A9VkEFlQxmGXdMbHUGiEzKI01Jln2n6ezJSJPm5e8rVE39FiJDIXMF7QAivVMzWHOS7vAa7pp4Qbk8lb7AI4Frk1K9cTup4qAUNwWB+ZAQatdvL4Rh1M1U3O3kjrpyubHqBA0buSA6/54oeBywz6sZ49mUEw3jSudC3dt5CiOyc=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYYPR01MB7118.jpnprd01.prod.outlook.com (2603:1096:400:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 08:45:49 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d496:4343:e4e6:c49b]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d496:4343:e4e6:c49b%5]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 08:45:49 +0000
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
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AAABE+WYABTmUCMABGH4GAA3M648AA3z+sgAC1LKkQAEYGy4AAH1dN4A==
Date:   Thu, 27 May 2021 08:45:49 +0000
Message-ID: <TYAPR01MB6330E119C33C0349EB6622308B239@TYAPR01MB6330.jpnprd01.prod.outlook.com>
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
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b27dcd05-08ba-4e9c-08e6-08d920ebd3de
x-ms-traffictypediagnostic: TYYPR01MB7118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYYPR01MB711854C68B3FD6094A0E09DE8B239@TYYPR01MB7118.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XqK+ZZXxLoydf1NLsBLBwBkCjWaeCx0IPvrgYUqLB+tfIwbfOvu6G4kKt0v6jDZmwL78IscVjpPeCs74O7P9nowXnmA5/5WBwq68dIilJxJ7JmHEZ143Hc69G5B7U5f0od5J3EBHRRC+tgXG29FIgQ6sNS0Lho4Qy44EJvrRJRDpkYbGJelch+k2n5nT9gK6UzaZoN8Mds50ejytuGXf17Lm6PEhD7G5EF4vYJExqplISj9dF9T2mZxPlwaCf2gHF10u2P+nJM6R8kosK3h/6ermUsvjjhNz86n0CRu+u9XmtIN0a0N63vUKNBVZisBy1wEIYnXbXz8S8JTFXPH4fc71RVnFYatUhxLvP2hvDIQ9cImjTCuqbIvo8nDAwShLfszGCBrPBXAzmML6vhfacn03ParOHViwM66MRDswmv6wiRmTQsGTroKIZXl6HDxv4Qispv4qwRpF3JraN2CXZoEst+WeHFKHvPQ/C0D9uuvcJBiKnRY3UGOrRT81r4nFf8vv12PRIGZ8PU3ggGPJNDwBziF5MhMrNYdzNpKWR73ADTSA0/i2np0e6FdHvAVNhQURVGuh/HFT3yGOLSCImjqOB5AgO9svYS0kTbbuT3/+Jn1wh5hkkytKFWgsKwn8TcO8Mn6PhNo5/lr671skxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(55016002)(122000001)(53546011)(64756008)(66446008)(38100700002)(316002)(6506007)(66556008)(186003)(71200400001)(478600001)(86362001)(66476007)(4326008)(8936002)(110136005)(8676002)(54906003)(83380400001)(2906002)(52536014)(85182001)(66946007)(26005)(33656002)(76116006)(7696005)(9686003)(5660300002)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?YjZSckRYbDRuNE92RGNVY2JlR2ljbDE0bzNTZDFnUDR3ZmliajBIU1dF?=
 =?iso-2022-jp?B?STFWM1FoVFhjMlRZZGxFakl6K2xCWWY0MlZEbGtQL2ExLzNPdVRIU3Zx?=
 =?iso-2022-jp?B?QmU5K0psVlYxK1FTZ01ZRDNjQmQ3bHJkc3lZYXlHWVZCTjdRM0xhbmFS?=
 =?iso-2022-jp?B?Y21XUWVIazdLbW9CL09BSm41MnFHNEM1aHpXWllZM3poVFZhclloOTN2?=
 =?iso-2022-jp?B?akZlcnppcTNJUTlHSnZ6VzJMaVNKL1ZTMnpqMkk5OUxZR1BGWDBwWFQ4?=
 =?iso-2022-jp?B?ckpJQjh1VUZuYjhnb21QMEgrb2daZTNINVhVdkZxL3BIMmgwNW5pSlRT?=
 =?iso-2022-jp?B?WDVvVE9OdnBMdCt0STd3TGZUT05PNks3bmhENUh1ZkFzOWlMSlFHUC9F?=
 =?iso-2022-jp?B?akR6UVdDdFlER0hRWklyK1paSExRVmc1eGVpUlhRa054c21EOGRrQW9m?=
 =?iso-2022-jp?B?dEdZTFBtMnY3V1RqRmsycUpGK0lIUGxpcnJVOEE2dHdhSGZjZVgyMkxF?=
 =?iso-2022-jp?B?bFB1dE1ab3dGM2xnTGhLai9sbk1yQmRvMzliQzBUbnZmbC9Yd2NKRUhx?=
 =?iso-2022-jp?B?Vm5yRVBzVGg1Z1F1b0FUOWl6OEJnSkg4VzRDR3NmZWE3NHFmWEtzdGZU?=
 =?iso-2022-jp?B?Nlk1S1MxNUpTUWRGblVxVDJBS0NpMzBzWUZUOGNkdVBjRVNyYU81dFBU?=
 =?iso-2022-jp?B?ZUxPZ1lwY0Z3eU44bmpLNmg4U0R6WDdsN1ZnM01JNFBTK2JySXA2SEcx?=
 =?iso-2022-jp?B?dXZGMlZXa1plSDRMbHpWQW42NjZiUGdGQWowYU1NcWVucGhyYXpOcld5?=
 =?iso-2022-jp?B?cHgzUWNVZ05hUDF2RXFvVmdXcW94Sm03REY2VGovdHZ3WVNYWEs0S1V2?=
 =?iso-2022-jp?B?TUdwcGJ5cWNtVUIwMndzcXNYWmJ1UExYcTJNUk9DMjB2R0lxTFg5Rm5l?=
 =?iso-2022-jp?B?WFJXL09wSzEzdlJ1TmthV1ZIVGpZWFpNV3Iwd0Jvei8yeXBabFVrZWcy?=
 =?iso-2022-jp?B?MWo4d3crUHB5QmwzQ2lXUnRXVkxVc1JqQmQ1cmVBSTZUZWJpZUsyLytX?=
 =?iso-2022-jp?B?SVU0NDAvaWVkM1Z3cDRhakNXUXV0QzF6aFpUUm1SVG00ZnpSKzIwcDg3?=
 =?iso-2022-jp?B?eEt0cUZYY2pVaGpFZ05UZTNJTHQ3QlJtSGV6NWwzV1dEMTZ1Zk1HUmx6?=
 =?iso-2022-jp?B?eWhtR1VwL1NVRFZ3QW9TTUxIMTZscU52VGFYQ3JoN3d1dlVsZEp3Y2hC?=
 =?iso-2022-jp?B?L0NFT0RQMW1GSEwyNVhUY2VaVGc3WDZxbDNMMXptRUZUWERzN2lKbEww?=
 =?iso-2022-jp?B?NzdTbTFQVUR0cHhlaEtKM3Faa3FTUXRhaFJWRFZZdzIvVDFVcmxVbVdK?=
 =?iso-2022-jp?B?Z1h6MVVYME41THBlQkNLaEdyeTVvVGNSUXUvVm1kMldDRGFaOU9CeW8y?=
 =?iso-2022-jp?B?UmRZcmVvR08vVHNsbllKYU5WSlpkdjhtSEZHbkVlKzdEMkJRVnZqVEhY?=
 =?iso-2022-jp?B?SWorS0p4MHhHeXJBZStuMVNveHBwTlNlZU4zczV2dSsrZlFMMTdjY2Nu?=
 =?iso-2022-jp?B?ZzRBY0NKY3ZWMEdFRElCTHdxMm9LQWxyT3JqNGpYdlgwY2JkNC9SRTda?=
 =?iso-2022-jp?B?WlBYd1E2d1F2dFN0OTVyUEtkT2tkTzBrdTg3NDBlQWpQdG9NUER4QmxP?=
 =?iso-2022-jp?B?SmtSMkdsWlltSE9sOHgxUlJ0TnIwc3dMMEVYQUFnd1BkNkh4Mm1YU2tL?=
 =?iso-2022-jp?B?d04vNXJuL2FBMW9XVm1CTHF1WFlIMTh1eURCNGhhanp0SGlabTdqNlJX?=
 =?iso-2022-jp?B?V0Zjekx4TERIUEQ0dHFPQUliNjRBRmxwQmFpa0NmeTQ2WTdyalV0dDBE?=
 =?iso-2022-jp?B?aitKMGx4Nm4zL0FybjZGcEVHVE1nRmVCRy8zMWVnaFVXSEFQczNFYUxx?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27dcd05-08ba-4e9c-08e6-08d920ebd3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 08:45:49.2816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aihk8XRxa6j5ivnn1vjJy65iyRX/rSrFmU4jOowx0p8EyazfTzTiPBPkkQldAYDnqiU+XO2HTDIP706ca0ZnJJVJBrmTywfKPxEpVKP/cyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

> On 5/25/2021 1:45 AM, tan.shaopeng@fujitsu.com wrote:
> > Hi Reinette,
> >
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

Thanks for your mail.
Sorry, I=1B$B!G=1B(Bm wrong in understanding how to use=20
/sys/fs/resctrl/p0/cpus and /sys/fs/resctrl/tasks.=20
I think I have not understood resctrl yet, and I will learn more about it.
If I have questions, please allow me to mail you.

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
>=20
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
>=20
> > (2) Since L2 can only use 2 sectors at a time, when creating more than
> >      2 resource groups, L2setctor0 will have to be allocated to a
> >      different resource group. If the L2sector0 is shared by different
> >      resource groups, the L2 sector settings on resource group will be
> >      influenced by each other.
> > etc... there are various problems, and no merit to using resctrl.
> >
> >
> > In my idea, in order to allocate the L1 and L2 cache to a resource
> > group, allocate NUMA to the resource group.
> > An example of resource group is as follows.
> > =1B$B!&=1B(B NUMA0-PEY-L1sectorZ (Y =3D 0,1,2...11. Z =3D 0,1,2,3)
> > =1B$B!&=1B(B NUMA0-L2sectorZZ (ZZ =3D 0,1,2,3)
> >
> >    #cat /sys/fs/resctrl/p0/cpus
> >    0-11 *1
> >    #cat /sys/fs/resctrl/p0/schemata
> >    L1:0=3D0xF,0x3,0x1,x0x0 *2
> >    L2:0=3D0xFFF,0xF,0,0 *3
> >
> > *1: PEs belong one NUMA. (Of course, multiple NUMAs can also be
> >      specified in one resource group)
> > *2: The number of ways for L1sector0,1,2,3. On this resource group
> >      the number of ways of all sector0 is the same(0xF). If 0 way is
> >      specified for one sector, this sector cannot be used. If 4(0xF)
> >      ways are specified for one sector, this sector can use cache fully=
.
> >      If 4 ways are specified for each sector, there will be no
> >      restriction for using cache.
> > *3: The number of ways for L2 sector 0,1. If L2sector0,1 is used,
> >      the number of ways of L2sector2,3 must be set to 0.
> >
> > All sectors with the same ID on the same resource group were set to
> > the same number of ways, and when running a task on A64FX, the sector
> > ID used by task is determined by [56:57] bits of virtual address.
> > By specifying the PID to /sys/fs/resctrl/tasks, the task will be bound
> > to the resource group, and then, the cache size used by task will not
> > be changed never.
>=20
> This completely ignores how this directory and files are currently used.
> What is missing how this implementation maps to the current resctrl
> architecture.

Best regards,
Tan Shaopeng
