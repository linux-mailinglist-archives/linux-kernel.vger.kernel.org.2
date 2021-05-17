Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7030D382714
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhEQIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:32:56 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:1736 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235406AbhEQIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:32:54 -0400
IronPort-SDR: rak3RM+j+Ym8eVIFSqjG0UXKoN4uhY1nRSetlQ7YjWuVeF685k4GzZVrzM5qKeQ4Kp4HKpcmfK
 vspiRI4Onap3MbUhPxCCm/DqVEtUpRxiz92r2GY7UPkInym5FfvCR+rv76PJrlODJmMNja3Ao7
 SvCmc0RdqbRHs+PYRR+zO2apP+Y9dxm+ObTrPavp8wd3rNPaf6ohCaM0xEO3t3VDRgjWfdRuNA
 KzlhjKZrGKM4kaES7RY7FjLYAtkwVRA9iVL++DoskUt32DjCkbqG722J/lAVAbVfgL7+9Uc3MY
 X1k=
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="31415712"
X-IronPort-AV: E=Sophos;i="5.82,306,1613401200"; 
   d="scan'208";a="31415712"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 17:31:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zp4wYsw3dwUfOgdpnMY4tnnDu1F7YMJ+nnxWojU6zBbehIeislZe8CII/yK0r9WpgO8NoR4Ih/xANY4fk7YSOUpHmtSuDQ/xLfet9eMEYaBD+HoIYVrMj4fI3Qqzlgx0/+LATsq6OU8gOAWm2m8VJV9SRLIRAD7cVWLNp+HCRkQptYp/zH9xCKRE+rox9wlRKR4/NDDUtptWt9DOTwfkTHYWYRIhugE/XsxJpApo6ph+rydhE0yENZ6q8RQfcxLrdhynvX3Y233DeBRAHFR8Y9Cr44/U/ZDJrI1ANIAHk05c3W5dGi5kP4Mg76i0nZhJsYcotNvvjFGzowYqdTb3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnsZurJhXEIRMhtkCtqxgy0yGnrPcDZqXlH0A9xYvUQ=;
 b=WIJ6lG6qB8NPg6DNY9Nso3IBlZzvFcX+KJ6Ndo1i/Lg6aqgKdFoAjCZS//Q9G+ZkwixZp8x95O5zll35V3LLH7lFIxxWnc7LxVTg0NWQfKMNjNGs4SxN7sttarZyDmmA5ndE9tU8cGFjvziEuCVXmy6klG5SDA1Wtirx7Dh82982MpEJZoq1VIse45vd2EnbKvWvnS1Gh3HZNHO9Top1vaOGIvhvjB3vPG2uCMnLqXG8qiyxgIxQHorilQ3E0b1UtJNjI4BNuINXnGaBjEOhZ17oOANInH2VgyK6eRD4O1SqhVTguKPpVJW0B6Spe5GqYsJ1Q2PmDVewPnL5+f88fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnsZurJhXEIRMhtkCtqxgy0yGnrPcDZqXlH0A9xYvUQ=;
 b=TEbeLFuwP+z/WOg0d1azLYKqieEgSTI5t0bR07FAAtkYh/eaWw5sorMEle9NVsk6OdBaajayqYG4ODR2HMRNTzJBLDlM7d0xCbk80E5vQkfS7xjlZEANp6djRrvPRMU8ZQEiOXrAp0faQ2QIge8/8OYJRaj2ir2+Zggqz11KvYI=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY1PR01MB1883.jpnprd01.prod.outlook.com (2603:1096:403:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 08:31:31 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d496:4343:e4e6:c49b]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d496:4343:e4e6:c49b%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 08:31:30 +0000
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
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AAABE+WYABTmUCMABGH4GAA3M648A=
Date:   Mon, 17 May 2021 08:31:30 +0000
Message-ID: <TYAPR01MB633071CD547B0AAF818520E48B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
In-Reply-To: <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 218750a8-5057-4450-6460-08d9190e2c1a
x-ms-traffictypediagnostic: TY1PR01MB1883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB1883280BFD38437BF46E3CC08B2D9@TY1PR01MB1883.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IINc30JdSppsK6qK4myYmvH8fOutnkUqG60da68+YIRcZuzsApyeyEyAcOGKv1vO8i9pkhL/45hp6Os9zahApkQJE/2GUBCKA6q/RxEIcBox/vYP9nXYu9O5yXAXAtwOcu41QGjME+XmSdkcCiAHbXVe5KdSeFPakYwi2B6b83r0eHZuXP8ePs/8Xah17lM+1jUpYVviwrxUb6W2M7PlI4iVD54CfI3hyhJ70h2UkumGsmd7qUng5x6fdK2j3BT/7y/yvMdGUKh57TTPT7o6HHBUVoV8mzlTj++YSJWTlXaUcfRqceFXIaaeuRBKiTOZklolij4YisS0jmKokp8XgqZtXfSzXRQILCO/5r2WG52jSZkLmXN8XtwyLfgsBhyjsMUqGraq/axNVkINLmttPAwXVa0nPmHRXKm/mT9dxiSLT0SiAWZlXYvPslvvBoPphoekXfHH4rWTJfgktoiTQLbQa6CMyOY1KedawaFbK4DaD2MqaP+wZ4+cAmv8CaitfxXBiq4zpov05vU+VFBx6/Yd8mzMl0ZjOH2nYu69KK58bEGrd6bZ6ZiYWvzapNHZrR1xMBUVgVdP5ygryJ3F60guI87qQRiwxBpAVedTsF0sIkI+perI2ibN9tmNkD4kbe0t1/vSFLoGCBJD4U/qGkuD55nkoDH4w/mgNfm6kzLGBrd8yaw0qusKcElgUIvHdQbJ/x9UtdT4FrZJIyqlsI8Y9mdndmsNx4UyM6DaNe1YPHHK0GBsc5vxNHlYrbfNYHn2mXAtXkjhp8hiw4gCCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(110136005)(83380400001)(66446008)(66946007)(55016002)(316002)(76116006)(4326008)(64756008)(8936002)(54906003)(9686003)(26005)(66556008)(8676002)(38100700002)(71200400001)(85182001)(2906002)(52536014)(478600001)(186003)(7696005)(5660300002)(6506007)(33656002)(966005)(86362001)(122000001)(66476007)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?bnIwU3grTW9xSzNKelBwdXRpbUdRUVh4bldSbEtFT0h5eW9UOGxWcytl?=
 =?iso-2022-jp?B?VFZMcHFCekdFU0gyWUhHQ3ZUVjRrdGdIdWU2Kzc1bU9pQU04dnc4S2tF?=
 =?iso-2022-jp?B?MmdWRmk0b2hrSWN6d1FFYlRiM3RqWlp1bUhNcmE0QW5xN1hZMjFCZVk3?=
 =?iso-2022-jp?B?M2NqZmZFTVJhVHY3VlRBa2lnazFCaFJ0SnV0M1FXdWlJL2d6bERkOHd6?=
 =?iso-2022-jp?B?c28xNXRZRE4rcU1Cbkd5WktlWVg3Q0RnaENLRWo5clJpei91aEFOaU54?=
 =?iso-2022-jp?B?L2JVUlZkVVk4eGxyWWRsZUMyQzIvMUNmZFdnbmdaaWpYOE01d24wVnd0?=
 =?iso-2022-jp?B?WEFYSjFtQ3pvWmVBeU9kenlyV1BGTHprdXZkWWtneVBjZTZkUTBPWjlQ?=
 =?iso-2022-jp?B?a3oyTTZqRWpmalNMYlJwY1FjWTAzTFhTR1I2V1l3Q04zMFBld0lFYVE2?=
 =?iso-2022-jp?B?aktxRW9jTElIQXpWc3JXZ1FwVEZmNmtlS2thY3Q3Zk1oQ3BPOXBiYndm?=
 =?iso-2022-jp?B?ZmVhTjV3Smo4L2d1ZW9sSmVta3VNTUpGeFIxU3NJTW9nQThUN0ZqUWZN?=
 =?iso-2022-jp?B?aWZoYTgxSnRrUTJvRnVFQXIxQy9vL3l3dCtoYlJJK1lFQlY1c01IS2U2?=
 =?iso-2022-jp?B?eTY2all6Z2VRUlBOdHNTMUl5QVk5b0VrV1RtQkp2S1dON2dYMFlMWkNI?=
 =?iso-2022-jp?B?bGcxMUlQVG9TMVorZHRiZkdOVjAwT3FnNlVXVFFIQjA3YnRmaXFLSWdO?=
 =?iso-2022-jp?B?MFZkS2kzbzZCVHVmWEZxN0FTQmozdU5NMXVKNDVzNjA5NFIrRGpOTWVC?=
 =?iso-2022-jp?B?N3JXY2RwS1IrWDVBQnRYd3RkVWU0aXZvMGNMY21ac3pEUTNQUG9kOTZM?=
 =?iso-2022-jp?B?dXUvc1N4UlBhemxpcXMyaFNmTTdTTUxRSVFIZlRST1pKUXp6M1NOM2FP?=
 =?iso-2022-jp?B?L01pU1RlRXQwaGlhdzBRK0NSblh0aTBma3pGRVFLeU1qQjNwQnJTOTBO?=
 =?iso-2022-jp?B?RjZxY1kyNGF2MllndWQ1bGxtVUhsRlVuWml5Y0NMdnd3ZGg0cGFiTENZ?=
 =?iso-2022-jp?B?MHZXYmV1dDh4eEw4ODVTcEFzWCs2ZjQ5Smttdjg2dFdnV0EycGw2K21C?=
 =?iso-2022-jp?B?cFh0bTRMeE9YS3BvdHo2YURyY1dFM2NKYWRqbDc4SEhIbGFDcCtmWDN6?=
 =?iso-2022-jp?B?VXNpZ3ZCaXNnemFVMG12RHV2KzFlQ055eXlVV2dWOVV4bmNlVFF3ZmR5?=
 =?iso-2022-jp?B?WmdUMnV6YzZ6dHgyblFXOFdXQit6czhZUkJNMGZMbXpLTjcycldGV2Nn?=
 =?iso-2022-jp?B?ZlBZUFBQcXdGemNGU1NPMGtEcnNVMytsSlBQSWVRNm9HbW1VUFBhL2xZ?=
 =?iso-2022-jp?B?SklQMENZRzhpNWFLZEpzRUtYeGpiUDNzN21xTzRtL3p0aHpmM2ZoTnNT?=
 =?iso-2022-jp?B?T0pDeXFpR0dncTJvL2QxanRxMTIvL1lMdU5hdDFseEpQYS9qSEdNQnFH?=
 =?iso-2022-jp?B?cVVoVVA5MTl4MEhnOVhlMzBwWU1IMk43UlZVWTA1LzdFd1oyQWZRTXJn?=
 =?iso-2022-jp?B?T0EvS3VwMkpKbkZtVkN2SEl4WWRPSHRFOVE4K1pKMWo0M3lLSldpY0ly?=
 =?iso-2022-jp?B?TDNvR0dmRWZEOFNzZVJYbnlLdWtGbnJDdlIyQ3VkSUVCMmYxUzYwNENm?=
 =?iso-2022-jp?B?MURWMGEzQTU4SC9PbHp4cEhUelQ1RzVHc3RZZXUvUS9MZkZUb3dFQnhC?=
 =?iso-2022-jp?B?Qk9XUDRZSnB3dFpTcGtBNmFacjBQMER5NFpoUTgrRTZYTVJxQ0FZSlBL?=
 =?iso-2022-jp?B?aFkyblFNL0s5WE1HVUkvRHpMUnBxUE0xV2RoVlFwNHg1OEhzVFlGVTNO?=
 =?iso-2022-jp?B?RjNUbTNkSjJrWXRqSTFSbDhZQlUyK1hQdnJaQm90OGc1a3lSUlN6cGdv?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218750a8-5057-4450-6460-08d9190e2c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 08:31:30.9520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hS1krldgLwk/iqhKnv5GGYlYczxYClO75CBnSi97nkW2I0+g7GijDh4w9XTsVQ56Qt7iL1gPFGImEjsZ1bGac40jwmal6J0GE5exSCo2SXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1883
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

I=1B$B!G=1B(Bm sorry for the late reply.=20
I think I could not explain A64FX=1B$B!G=1B(Bs sector cache function well i=
n=20
my first mail. While answering the question, I will also explain=20
this function in more detail. Though maybe you have already learned=20
more about this function by reading specification and manual,=20
in order to better understand this function, some contents may have=20
duplicate explanations.

> >> The overview in section 12 was informative but very high level.
> >
> > I'm considering how to answer your questions from your email which I
> > received before, when I check the email again, I am sorry that the
> > information I provided before are insufficient.
> >
> > To understand the sector cache function of A64FX, could you please see
> > A64FX_Microarchitecture_Manual - section 12. Sector Cache
> >
> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_Microarchitectu
> > re_Manual_en_1.4.pdf
> > and,
> > A64FX_Specification_HPC_Extension ? section 1.2. Sector Cache
> >
> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_Specification_H
> > PC_Extension_v1_EN.pdf
>=20
> Thank you for the direct links - I missed that there are two documents av=
ailable.
>=20
> After reading the spec portion it does seem to me even more as though
> "sectors" could be considered the same as the resctrl "classes of service=
". The
> Fujitsu hardware supports four sectors that can be configured with differ=
ent
> number of ways using the registers you mention above. In resctrl this cou=
ld be
> considered as hardware that supports four classes of service and each cla=
ss of
> service can be allocated a different number of ways.

Fujitsu hardware supports four sectors that can be configured with=20
different number of ways by using "IMP_SCCR" registers, and when this=20
function is added into resctrl, the maximum ways of each sector are=20
indicated by bitmap.=20

However, A64FX's L2 cache setting registers are shared among PEs=20
(Processor Element) in NUMA. If two PEs in the same NUMA are assigned=20
to different resource groups, changing one PE's L2 setting on one=20
resource group, the other PE's L2 setting on other resource groups=20
will be influenced. So, adding this function into resctrl, we will=20
assign NUMA to the resource group. (On F64FX, each NUMA has 12 PEs,=20
and each PE has L1 cache setting registers, but these registers are=20
not shared.) There are 4 NUMAs on A64FX, 4 NUMAs could be considered=20
as hardware that supports four classes of service at most, and each=20
class of service has 4 sectors (4 L1 sectors& 4 L2 sectors),=20
and each sector can be allocated a different number of ways.=20
And, when a running task on resource group, the [56:57] bits of=20
virtual address are used for sector selection (cache affinity).

> The other part is how hardware knows which sector is being used at any
> moment in time. In resctrl that is programmed by writing the active class=
 of
> service into needed register at the time the application is context switc=
hed
> (resctrl_sched_in()). This seems different here since as you describe the
> sector is chosen by bits in the address. Even so, which bits to set in th=
e
> address needs to be programmed also and I also understand that there is a
> "default" sector that can be programmed via register. Could these be equi=
valent
> to what is done currently in resctrl?

Adding this function into resctrl, there is no need to write active=20
class of service into needed register. When running a task, the sector=20
id is decided by [56:57] bits of virtual address, and these bits are=20
programed by users. When creating a resource group, the maximum number=20
of ways of each sector are set by "IMP_SCCR" setting registers.=20
As long as the task is running in a certain resource group, the sector=20
and the maximum number of ways of sectors are used will not be changed.=20
Therefore, we need not consider context switches on A64FX.

> (Could you please also consider my original questions?)
I will reply to the original questions mail.=20


Best regards,
Tan Shaopeng
