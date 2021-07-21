Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37EE3D0A69
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhGUHf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:35:29 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:53037 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236263AbhGUHbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1626855104; x=1658391104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d4yj0kyaxvuYS+e/lF3PeRxKIHC776Ilv+VTNHthMyY=;
  b=wccgAnRBLxy1G/xSgxTZmzqLMbuGxb3Eqs/+u1HTfRyab5jXZurTY0uL
   /B1IcAttm43X0eV3M41uIPlhhVpruohJ+64K8tC54HcdfJ/Mr19WdL5km
   ViR7LeQFhaU0yRKVet9Xvz7xCzyP2m9qgAcJEjW4xkMHKSd8uikhByAvG
   KBDQM1kOi/CEtOuxtM4vlo/f5No9mq824rPWxWfUtPAJvbwkMljdPKswL
   Bd6+4zUFTIpz+jjtrR5OtVd5D18ML5yJvKW5Asoax5OKmVe10EzrD6VDN
   vXJwgn+Zj4p3Pm6sZB0+LxMfeijQExtfF/SIDfeaZS5ZBMRpc/iaxkgpj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="35340923"
X-IronPort-AV: E=Sophos;i="5.84,257,1620658800"; 
   d="scan'208";a="35340923"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 17:11:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuSHbZwT09TaUHqRbnKJ4YqXqJGGd8Ef+eIzRhPfMpIkQCtWam6jsZOOr7QINmUvjOrwqCkvwlsRlgO9cHZ1tD1G1iXgk2UTjMDonLq8ggh7vQ1BicBOPseIDjC+TNSCu1ukGDuR6bIR74dPSv10nTZgCfjC4JJFW8feg+czMrXLTqtP2/EY32DgNrTE18cvK1nYZABR8NyrkvzpglxHi7FXtu6XcVgoSzfZoNDMt1w/THgBsVEC4gqPEBsktDRvDur4vScbW+ULiUn33tNe3yf5Me5M1HhpemydkJmFAn7/JEK8dIuP0HhUnPHk/IznLTw2h7NLwku4wMqZtDis4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvkt9LjTGASuHWpKo+mSReRZYyKy7IhQC02pKzRx++I=;
 b=SusyKhk2+mD2Md0S49FyrGeFmvBS/Js3lazUDnXbNzI6mNt8pHSsw6/w2rAjcQzazUU2iZ4tD6s0mZFco3+rABoP7iXSMCRXKe+pJ4eem11xfOLHkBEIOcdDKvbMpdRDQQuYDPE4YvvNEheNzJ/3bTntXYUaXEdQFBkRriskNdkox1mbs8wIGZVpFJVV7e4qRIg+8E85hUECvjSc76FKMcpWWilMUCBOiiFMWx5M589IvlQ+05bIRp1w5ShaB+UH0JcfSHugQNoSaycu99iAaKSe1NJD2KeiYAxoRV8NyWzhRAg2dTr7uUMUDnSdDx0EAnUBVGK0c5JHqopc6yFKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvkt9LjTGASuHWpKo+mSReRZYyKy7IhQC02pKzRx++I=;
 b=iMKynjs0oYKib3eMdjFWGNDSqN8wP/JESAmQnjh3/wuOIv50jNQ5LnGahFKDZ9h8aTSdMofOg0+3raC8y0oTM3NGzv/xk4kzV+SHxqvGc5JUY1gfmdzCVQzlJhS5weQaqbr3gcaIdq1K6gXZLVCwHTOlduhLdEvG1ZZ4D0stOlE=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYAPR01MB6489.jpnprd01.prod.outlook.com (2603:1096:400:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 08:10:58 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::3856:85dc:d6ba:ec90]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::3856:85dc:d6ba:ec90%9]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 08:10:58 +0000
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
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AAABE+WYABTmUCMABGH4GAA3M648AA3z+sgAC1LKkQAEYGy4AIMyy6kAJ0u2KAAERBzXA=
Date:   Wed, 21 Jul 2021 08:10:58 +0000
Message-ID: <TYAPR01MB6330AE181BD8D6C18A36200E8BE39@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
 <TYAPR01MB633071CD547B0AAF818520E48B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <f53b9bfd-0d55-4cf2-fabb-82b3ec86e52a@intel.com>
 <TYAPR01MB6330758A49FECF90B5290C768B259@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <89416df1-4e91-8ad2-981c-827808a65229@intel.com>
 <TYAPR01MB633085C894CA3B064BB637E28B1A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <26ffe50f-7ff4-2c4e-534c-edf23cb88df1@intel.com>
In-Reply-To: <26ffe50f-7ff4-2c4e-534c-edf23cb88df1@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-07-21T07:59:48Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=6a951e12-861b-454b-82e3-d181a3803c60;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 277c2292-1c20-4e20-886c-08d94c1f125f
x-ms-traffictypediagnostic: TYAPR01MB6489:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB648934E1BBEB083AD1BA28BC8BE39@TYAPR01MB6489.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++OS2hG99ZbckQqkMd6DBVwesWkHcaIkbNRHsYSRYXLUuXm6b8eCCTiWqePJkOzWYOsbJYvF6ukEV7ZeWaUSy0iOYTAp1pVMcd5LImFhnwtaZEeMvZclCzo6xAmD7a9s1EITri8nl0ySEhh/0LMaqcrQPWUAt5Ft2hJP2e6XYv5bTiqxLyMfzoLMYEKsS+SSKgQb2fjCD9h5QkwqJx/LmOWa6XhotHKr9YFOsfuD+dxT8I2ZpzW9P6ff5soSMBjnyy87h7gPyWf7yufwXEqCRMC7Cy8ufIhUjRWUm9u3MX+SnF9vIxghUZdoPIMOHAqwujFLPG4zE1JPQUC25duZ/OH+5X59T+oN3XJq0fOQ7txcP5VIrz9floVYOPbayjvtGJQo+pR4Q61Z2T9eQuEGfQxd3vsLoDo5EsO6DLaGRSlY2AHU3edmqAinlBoBxC7G/S/BC1ppdemPk8D1356uecz4HA1A3J5trKLXMJS7f4sJyWs8zjYIrM8VB6bKClIXp/yAecLCP93wZc6AilVP0QlgyIR5T6gXwkYaKY9o1OZg9d4ZevJHJiwdL0d5xttvFWbd5rKkiOaQ405VSpqPDFV8I34qg/vHrtBE7TERDKw5B1EkqaVPjoIbKSUbpbY7KvbkmpWSp6WL86zYkmIPVigWYCSoKLR5aCd7RpilbtEVTJ1xf5p4MpJaAWmAOrVZkqSa8apB1+GlNyXOsY+k8q7u3qsV8B8J2LY+/obSlpk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(122000001)(66476007)(71200400001)(54906003)(110136005)(8936002)(2906002)(64756008)(66556008)(66446008)(52536014)(33656002)(7696005)(316002)(30864003)(5660300002)(66946007)(38100700002)(9686003)(55016002)(86362001)(186003)(76116006)(6506007)(26005)(83380400001)(85182001)(4326008)(8676002)(478600001)(53546011)(38070700004)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?OVVqVmtTN1VvQlpiZllZWW9CVUt3aTdUZ09SNG1kYStudnBQNXdQTE01?=
 =?iso-2022-jp?B?TktNUDZRenlna1oxTkorTko5ZnA4S1RtZFJHdXJVUVBQdFhJSnEyeWQ1?=
 =?iso-2022-jp?B?Z0FTU0IrR21WMFozQzhWMG9UNW15aGN6cDVacWc2cFhTL2FEMGFtRWM3?=
 =?iso-2022-jp?B?RXZLbHJsTWJhQmdXRGpoTExaamRpc3lQQ3dHTUdWWXkxV3FZMWRVc3Vh?=
 =?iso-2022-jp?B?aWgreW1IVzhZNEt4RTVEbTk5aldHWlN5K3ZHb0Q5aCsxcWRtUDBhZ1c0?=
 =?iso-2022-jp?B?cXJkcDJES2hSYWhWK1pFeVZmUUt0eWI0cXhGc0lPVXRiN09lSEEvakZE?=
 =?iso-2022-jp?B?c1ZIMjdXZ21yMmw2K0piWExUajFZSlpFcFJRczlkS2lIOEJMajdJczZ6?=
 =?iso-2022-jp?B?QmZocFV0WnFvb00zdmROUFBsNTNjdmpneGhFWmsrTlhWMERQTm9pbi8w?=
 =?iso-2022-jp?B?SkdSYm5LTDJlbDVacElDTWx3NXg2dzRTWEZrVXFKR2Y1eEk2R015TGl5?=
 =?iso-2022-jp?B?RDJCeUc2cWFIVlR2TmpPNGR3NEkrK3JSU0NHTzdZOGlicWs4TVREYXNB?=
 =?iso-2022-jp?B?bEcxMFE4eEpZNWxsYXVLRjFsYVovbWQ2M1JqbkNQWUpYb1cvYWVBaUVP?=
 =?iso-2022-jp?B?eGx2OHZqem5xWkV5eU0rZE1hVU5iUnlIdjBscHp1VnlWY0wzVzA2cDRr?=
 =?iso-2022-jp?B?MVBnQnFlVWxqcTNCaGYxeFl0Zmhad0VlTG1Ubnd6aG91V2NKU1l1MnlZ?=
 =?iso-2022-jp?B?Nm9FOER0aGxuTG5lSEp1ejk0YzVBS3NwMFhVbFF2QVdtcG5PMjJ3RzBI?=
 =?iso-2022-jp?B?NnpmSkNiOFE1MTQwTHVmT21uUFVvbFQvTTEwTjNOVllZV3JhN1UyR2Jj?=
 =?iso-2022-jp?B?elkrQjlKeWtZSlpDV0Q1VDI1c1RmQ3FFcW1kS0NzdllNbWQzc0oySUV6?=
 =?iso-2022-jp?B?YUJCR3I0eDdxUm1sMGpiWEJVZS9vRWZJN3BkT3VNRzZRanhzczNUWTY0?=
 =?iso-2022-jp?B?VXBTak9BY3Z1UVhVeVhUcEVrN3RYTVJlZGVieGJqOXlJSlR4TDgvamc0?=
 =?iso-2022-jp?B?dUNVeFNQMElzWFF6MjlRQ05JNHhCTitiRG9kZ1FQWHZJWkswRTBGeXVl?=
 =?iso-2022-jp?B?d1JLUXV3MjR5UjVoZ0NiZDAzTWhWckI5UUY1dGF4WnpmTzRtMmZLc0pz?=
 =?iso-2022-jp?B?Z0wyTlEzaEZxSXVQd09aQlZ2L0lKT0IyaVRFOEU2TU9ScTVpa1VmQTU3?=
 =?iso-2022-jp?B?a25OSGNvdXdPc1RjOEVPTjdyYjNoSEx3dFFTQzFwL1VWekFhV2pLeGpa?=
 =?iso-2022-jp?B?b2pzWGVvUDZ6bnFoWkpnR0ViWXhPMkFkcFphNHBPRld6MnZkWGxWZkg4?=
 =?iso-2022-jp?B?aDBRSkpZdndoU0cyVTNKWHlzT0JUTklsNTk3OUVaNEMwamJ4eTVOR2g2?=
 =?iso-2022-jp?B?a1g3QnQ0S2JYQ1ViN0FtMlNseStEdUZJOWFsMGN6aXhueHJiK1dVVFk4?=
 =?iso-2022-jp?B?em1HQThCR0VDNXRaUDVBWjhodlFCV3k2bWVKUERPWU85UUJxc3U5Uldk?=
 =?iso-2022-jp?B?OXZwZjI4M0tEWHpCVGxPQnBueG5BYmFLOFUvTFQydC9RcFc3TzltdzEy?=
 =?iso-2022-jp?B?V3VLSk9jVFBLR29zc21IRzFlNGUzRzRoMmloR2MrdXBlejJ6YlFlVFA5?=
 =?iso-2022-jp?B?QlV3Q3IxblNlSDlWZUxJNVMxNUFpVHpHUkFzTDQ3U0xJWFpnbGc2aFJo?=
 =?iso-2022-jp?B?ZmFPKzFPdG40R1VOa3J4VTZ2Nk5kL2lKY2syNm9FRkQwb1dkRGw2d2wx?=
 =?iso-2022-jp?B?UENFOTRQRzlPeTJlQ2JxK042VkFjTW1Pem41aGpDT1owNWMwcTQ2QVlE?=
 =?iso-2022-jp?B?aGtyMmF6ODVBdmxCeEVlM3pydkpVPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277c2292-1c20-4e20-886c-08d94c1f125f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 08:10:58.5125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiywnOOijf8Pw3WQdxnruaDBi/qYTX+q/j+LvLg0X0DC7auWkHu4+Xej87F6nZxUzhc6uZDji8fYEvUrvrqwUUF8l7Qe00x2rOQH9T451Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6489
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

> On 7/7/2021 4:26 AM, tan.shaopeng@fujitsu.com wrote:
> >>> Sorry, I have not explained A64FX's sector cache function well yet.
> >>> I think I need explain this function from different perspective.
> >>
> >> You have explained the A64FX's sector cache function well. I have
> >> also read both specs to understand it better. It appears to me that
> >> you are not considering the resctrl architecture as part of your
> >> solution but instead just forcing your architecture onto the resctrl
> >> filesystem. For example, in resctrl the resource groups are not just
> >> a directory structure but has significance in what is being
> >> represented within the directory (a class of service). The files
> >> within a resource group's directory build on that. From your side I
> >> have not seen any effort in aligning the sector cache function with th=
e
> resctrl architecture but instead you are just changing resctrl interface =
to match
> the A64FX architecture.
> >>
> >> Could you please take a moment to understand what resctrl is and how
> >> it could be mapped to A64FX in a coherent way?
> >
> > Previously, my idea is based on how to make instructions use different
> > sectors in one task. After I studied resctrl, to utilize resctrl
> > architecture on A64FX, I think it=1B$B!G=1B(Bs better to assign one sec=
tor to one
> > task. Thanks for your idea that "sectors" could be considered the same
> > as the resctrl "classes of service".
> >
> > Based on your idea, I am considering the implementation details.
> > In this email, I will explain the outline of new proposal, and then
> > please allow me to confirm a few technologies about resctrl.
> >
> > The outline of my proposal is as follows.
> > - Add a sector function equivalent to Intel's CAT function into resctrl=
.
> >    (divide shared L2 cache into multiple partitions for multiple cores
> > use)
> > - Allocate one sector to one resource group (one CLOSID). Since one
> >    core can only be assigned to one resource group, on A64FX each core
> >    only uses one sector at a time.
>=20
> ok, so a sector is a portion of cache and matches with what can be repres=
ented
> with a resource group.
>=20
> The second part of your comment is not clear to me. In the first part you
> mention: "one core can only be assigned to one resource group" - this see=
ms to
> indicate some static assignment between cores and sectors and if this is =
the

Sorry, does "static assignment between cores and sectors" mean=20
each core always use a fixed sector id? For example, core 0 always=20
use sector 0 at any case. It is not.

> case this needs more thinking since the current implementation assumes th=
at
> any core that can access the cache can access all resource groups associa=
ted
> with that cache. On the other hand, you mention "on A64FX each core only =
uses
> one sector at a time" - this now sounds dynamic and is how resctrl works =
since
> the CPU is assigned a single class of service to indicate all resources
> accessible to it.

It is correct. Each core can be assigned to any resource group, and=20
each core only uses one sector at a time. Additionally, which sector=20
each core uses depends on the resource group (class of service) ID.

> > - Disable A64FX's HPC tag address override function. We only set each
> >    core's default sector value according to closid(default sector
> ID=3DCLOSID).
> > - No L1 cache control since L1 cache is not shared for cores. It is not
> >    necessary to add L1 cache interface for schemata file.
> > - No need to update schemata interface. Resctrl's L2 cache interface
> >    (L2: <cache_id0> =3D <cbm>; <cache_id1> =3D <cbm>; ...)
> >    will be used as it is. However, on A64FX, <cbm> does not indicate
> >    the position of cache partition, only indicate the number of
> >    cache ways (size).
>=20
>  From what I understand the upcoming MPAM support would make this easier
> to do.
>=20
> >
> > This is the smallest start of incorporating sector cache function into
> > resctrl. I will consider if we could add more sector cache features
> > into resctrl (e.g. selecting different sectors from one task) after
> > finishing this.
> >
> > (some questions are below)
> >
> >>>
> >>>> On 5/17/2021 1:31 AM, tan.shaopeng@fujitsu.com wrote:
> >>
> >>> --------
> >>> A64FX NUMA-PE-Cache Architecture:
> >>> NUMA0:
> >>>     PE0:
> >>>       L1sector0,L1sector1,L1sector2,L1sector3
> >>>     PE1:
> >>>       L1sector0,L1sector1,L1sector2,L1sector3
> >>>     ...
> >>>     PE11:
> >>>       L1sector0,L1sector1,L1sector2,L1sector3
> >>>
> >>>     L2sector0,1/L2sector2,3
> >>> NUMA1:
> >>>     PE0:
> >>>       L1sector0,L1sector1,L1sector2,L1sector3
> >>>     ...
> >>>     PE11:
> >>>       L1sector0,L1sector1,L1sector2,L1sector3
> >>>
> >>>     L2sector0,1/L2sector2,3
> >>> NUMA2:
> >>>     ...
> >>> NUMA3:
> >>>     ...
> >>> --------
> >>> In A64FX processor, one L1 sector cache capacity setting register is
> >>> only for one PE and not shared among PEs. L2 sector cache maximum
> >>> capacity setting registers are shared among PEs in same NUMA, and it
> >>> is to be noted that changing these registers in one PE influences oth=
er PE.
> >>
> >> Understood. cache affinity is familiar to resctrl. When a CPU becomes
> >> online it is discovered which caches/resources it has affinity to.
> >> Resources then have CPU mask associated with them to indicate on
> >> which CPU a register could be changed to configure the
> >> resource/cache. See
> >> domain_add_cpu() and struct rdt_domain.
> >
> > Is the following understanding correct?
> > Struct rdt_domain is a group of online CPUs that share a same cache
> > instance. When a CPU is online(resctrl initialization), the
> > domain_add_cpu() function add the online cpu to corresponding
> > rdt_domain (in rdt_resource:domains list). For example, if there are
> > 4 L2 cache instances, then there will be 4 rdt_domain in the list and
> > each CPU is assigned to corresponding rdt_domain.
>=20
> Correct.
>=20
> >
> > The set values of cache/memory are stored in the *ctrl_val array
> > (indexed by CLOSID) of struct rdt_domain. For example, in CAT
> > function, the CBM value of CLOSID=3Dx is stored in ctrl_val [x].
> > When we create a resource group and write set values of cache into the
> > schemata file, the update_domains() function updates the CBM value to
> > ctrl_val [CLOSID =3D resource group ID] in rdt_domain and updates the
> > CBM value to CBM register(MSR_IA32_Lx_CBM_BASE).
>=20
> For the most part, yes. The only part that I would like to clarify is tha=
t each
> CLOSID is represented by a different register, which register is updated
> depends on which CLOSID is changed. Could be written as
> MSR_IA32_L2_CBM_CLOSID/MSR_IA32_L3_CBM_CLOSID. The "BASE"
> register is CLOSID 0, the default, and the other registers are determined=
 as
> offset from it.
>=20
> Also, the registers have the scope of the resource/cache. So, for example=
, if
> CPU 0 and CPU 1 share a L2 cache then it is only necessary to update the
> register on one of these CPUs.

Thanks for your explanation. I understood it.=20
In addition, A64FX's L2 cache setting registers have similar scopes=20
of resource/cache, and only necessary to update the register on one of=20
these CPUs.=20

> >>> The number of ways for L2 Sector ID (0,1 or 2,3) can be set through
> >>> any PEs in same NUMA. The sector ID 0,1 and 2,3 are not available at
> >>> the same time in same NUMA.
> >>>
> >>>
> >>> I think, in your idea, a resource group will be created for each sect=
or ID.
> >>> (> "sectors" could be considered the same as the resctrl "classes of
> >>> service") Then, an example of resource group is created as follows.
> >>> =1B$B!&=1B(B L1: NUMAX-PEY-L1sector0 (X =3D 0,1,2,3.Y =3D 0,1,2 ... 1=
1),
> >>> =1B$B!&=1B(B L2: NUMAX-L2sector0 (X =3D 0,1,2,3)
> >>>
> >>> In this example, sector with same ID(0) of all PEs is allocated to
> >>> resource group. The L1D caches are numbered from
> >>> NUMA0_PE0-L1sector0(0) to NUMA4_PE11-L1sector0(47) and the L2
> >> caches
> >>> numbered from
> >>> NUMA0-L2sector0(0) to NUM4-L2sector0(3).
> >>> (NUMA number X is from 0-4, PE number Y is from 0-11)
> >>> (1) The number of ways of NUMAX-PEY-L1sector0 can be set
> independently
> >>>       for each PEs (0-47). When run a task on this resource group,
> >>>       we cannot control on which PE the task is running on and how
> many
> >>>       cache ways the task is using.
> >>
> >> resctrl does not control the affinity on which PE/CPU a task is run.
> >> resctrl is an interface with which to configure how resources are
> >> allocated on the system. resctrl could thus provide interface with
> >> which each sector of each cache instance is assigned a number of cache
> ways.
> >> resctrl also provides an interface to assign a task with a class of
> >> service (sector id?). Through this the task obtains access to all
> >> resources that is allocated to the particular class of service
> >> (sector id?). Depending on which CPU the task is running it may
> >> indeed experience different performance if the sector id it is
> >> running with does not have the same allocations on all cache instances=
.
> The affinity of the task needs to be managed separately using for example
> taskset.
> >> Please see Documentation/x86/resctrl.rst "Examples for RDT allocation
> usage"
> >
> > In resctrl_sched_in(), there are comments as follow:
> >    /*
> >   * If this task has a closid/rmid assigned, use it.
> >    * Else use the closid/rmid assigned to this cpu.
> >    */
> > I thought when we write PID to tasks file, this task (PID) will only
> > run on the CPUs which are specified in cpus file in the same resource
> > group. So, the task_struct's closid and cpu's closid is the same.
> > When task's closid is different from cpu's closid?
>=20
> resctrl does not manage the affinity of tasks.
>=20
> Tony recently summarized the cpus file very well to me: The actual semant=
ics of
> the CPUs file is to associate a CLOSid for a task that is in the default =
resctrl
> group ? while it is running on one of the listed CPUs.
>=20
> To answer your question the task's closid could be different from the CPU=
's
> closid if the task's closid is 0 while it is running on a CPU that is in =
the cpus file
> of a non-default resource group.
>=20
> You can see a summary of the decision flow in section "Resource allocatio=
n
> rules" in Documentation/x86/resctrl.rst
>=20
> The "cpus" file was created in support of the real-time use cases. In the=
se use
> cases a group of CPUs can be designated as supporting the real-time work =
and
> with their own resource group and assigned the needed resources to do the
> real-time work. A real-time task can then be started with affinity to tho=
se CPUs
> and dynamically any kernel threads (that will be started on the same CPU)
> doing work on behalf of this task would be able to use the resources set =
aside
> for the real-time work.

Thanks for your explanation. I understood it.=20

I will implement this sector function, and if I have other questions,=20
please allow me to mail you.=20

Best regards,
Tan Shaopeng
