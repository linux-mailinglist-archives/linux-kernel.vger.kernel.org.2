Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84F83AC08F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhFRBfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:35:08 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:20394 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233475AbhFRBfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1623979979; x=1655515979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cPBV/3QBz3ewjDQ9mfjBGyOLvvHEsDp1S1aoYBaGTAo=;
  b=JwBhGtLcbtys4j4+0HrTZim2MjKpV7kSKaEin//6mZtZmvLMYRJ/UTzv
   NudCw8LWjJVCvtv+QHo/mI7WDLp5Hlls7G1uiFIfMEZXI0M0QK8HulX0t
   nRDCT+EkgQf68qD6e5Rmt6f1EHYs+AstlTctUh0Sig8hrQkG66g7YMb7S
   RisGgouvB4nmQelTgjjqUpK1FkTeHNhjUzCw3KLk3e2TDPBukeWLMp/Yi
   4b2q8uWnbs+l2DEL+XDv3+oG/aCHnNK7cEJVaHDP2jWlLrDYjO0XzidMk
   pRd8RcxJsGbVXH7jLNdD11kjv3ob2wwSbksOB4a1rB5hvKNcCWwuBgYmn
   Q==;
IronPort-SDR: j/dHic9ptB7bxEaGYPg3QSNNiND9SGerjy2YHpWIAOITgYdDqicnkLTuAx8DtSaHv4SBew6HB7
 Or3nG3wSg9NqACKWg9JkyOLO0V/Bz1uPuxi4/AWsK33Cfx6JWPNXD7B2KAno4kIrcdvxdXyNy6
 K0mUULdcztQs8hK9dfn9ZvE8qrH5E3twZTIcXOknMQgOm2sX4wBJpXZ5EvC2CFiO6/7szCjjYv
 CsbXZpM6a9KNwW8JQ08yDhaeNgU2xy1rVTyas916J5UdAGYVHndE79HUByy6nVYI8a47ozhnJb
 Qxc=
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="33255839"
X-IronPort-AV: E=Sophos;i="5.83,281,1616425200"; 
   d="scan'208";a="33255839"
Received: from mail-ty1jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 10:32:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXqkspL6MlernroyAAwuqzfkFrRikuYKjNiOCZGQaDtvZwF9L0xOj3PIdhYVWdEA8GLBubwinQPW38mOJ7cmUTNEM2NeElJhJvj2aQyZzR2B+5Pmu0AgI/dCZdzbpn6TJsOvyH0Ok40ZtJDv9ev1Cs6s+UIVmAQdVEM1UgOv58zi9BMIAOBGYzb33h+LAHwM2vOsYT804dkq+TH/IMiz/GIRtIgvR6S+azOnosuNThpLnJOJtlXVamGLmayvFGox/K32PNJcz5uk8ZWbfesIMRKsXgO8Lamlz2pebpn78m3rwE3EuZx4jmrAcARSWUzb+rfBS9gNFRvzBsWNlYYdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPBV/3QBz3ewjDQ9mfjBGyOLvvHEsDp1S1aoYBaGTAo=;
 b=ksMyRvnZ8taK1pdOOmsbBAhpvb2LSzV23hctzlWROkTisTmOsbMyUBsaedQpijWyKb+aHHhLuc0csO2EXfgwYoeqEGBYZMLMOzyBo1ckfDzO2Na1/NcXc/w6jlmmlsURhImjpRjPtVhBHgCfJQgP+2B7HdN6/V0kxboGMVUE3C8CMXZuMET7S9xbd9Ht6CJnn6vHPBqwkQnrJG+PUQxh3ORNK+BO9xII/sqBZT7qgDcyKqMgT9vQ6SxC2i/ENc8cSQ4OG0Pr6WVzFZjofIMtGta1fMhVpQScs6myXpDBgBGaXWfJCVlD0NWV3NPkUUyREn1bIRMQPX37q+7Es7tolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPBV/3QBz3ewjDQ9mfjBGyOLvvHEsDp1S1aoYBaGTAo=;
 b=gP5OV+CYzTwu6rVMQZZDqHWdk/IjNzVDQxkV2j5xLbtRZ6m22EFj30okB8wLNdKozsu87bg1LVtwkBd0/hnwnBA4fSEVg10KMyi2hP8CtZ6JlQ+84g1+A+gDZvxCfPaSK/2BEKH5IOyLKg3vW615qTZ9sg83JkNfz/uO/XSfsTQ=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OSZPR01MB6216.jpnprd01.prod.outlook.com (2603:1096:604:ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 01:32:51 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::551c:359a:332:906a]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::551c:359a:332:906a%5]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 01:32:51 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'James Morse' <james.morse@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "'hpa@zytor.com'" <hpa@zytor.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Will@kernel.org" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [RFC] Adding A64FX hardware prefetch sysfs interface
Thread-Topic: [RFC] Adding A64FX hardware prefetch sysfs interface
Thread-Index: AddbPDa/0dTuSZ8EQoejgzf2ST6z3wAOHlgAAN3YDYABPVAOkA==
Date:   Fri, 18 Jun 2021 01:32:51 +0000
Message-ID: <OSBPR01MB20371014562980857F550EE3800D9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2037D114B11153F00F233F8780389@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YL3UpAZ6wZi6GyAx@zn.tnic> <fe05554f-74a5-175b-73d5-ff20b8d3abde@arm.com>
In-Reply-To: <fe05554f-74a5-175b-73d5-ff20b8d3abde@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ODBmNmI4NTQtYjliNi00ZGUwLWI5YmYtODZhZDc2ZTdj?=
 =?utf-8?B?MjgwO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0wNi0xOFQwMToyOTowMVo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [208.127.118.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cf92d8a-8d07-4122-22b8-08d931f8fd21
x-ms-traffictypediagnostic: OSZPR01MB6216:
x-microsoft-antispam-prvs: <OSZPR01MB62167F2A1B75E4A656090CA3800D9@OSZPR01MB6216.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5SJcircTN1KLZqTS5caNyboibSarmtii5LcsMOQ8eoKXuWjMXFUBxT+qaPVqatbmLurRtt68T6Cb64YmpNP3QxDvauP5OcJe0AXH0JDCJ//Jx4ptd/9IQvzp2V0LiVlhBm8WLAk6XLnUSmjk45tGNfOmmicY6JpBSLfQ2QZHmwZdhRK6iXNp/1GANEc2U5wCi/1Hcaj+6AGU5oynU5zvuP3jRMgZWCev+d8/x8q9UfK3F05cop1CtSHGPa6gRaNpnNN12iMz6P2UGWOIekIKMRbHiwbjvFZqz9Rz1GbnuiKqn4AaiLAtMxrzv/ABve1MxgONb+C4S/Lw05dvRVIOpvlw0g+Sh5w6livdgH4jwaQrbOIeg8uDMUFE8vP3inlCGO5RIHdcL2bA23rYbD1OFZDx02h7lHV21Q+aYRnJixphq+Sw0nicBNi4FvQHk8BLSrQ+DyMtUsDEXRk14GgPxP+CUXfyrvgZA9gow5yqN3vbCfJZi6+1nHaAb4r3jMCZG61EEBIPW9eJ8bJv5qxklDBExQL2Tqz5A/ryg/u+gtMwdy4ddouk84k23c8tmLVxo8G/6g3w7KdNSCTQzRpuRMQlyGiaxTI9SDUgngLDiMcKLDkyuaWhK5yIrJ5GsoZAmj8x6wGvTDuLu90g40DyAdnA2biQJg4eZBFrE2dy/KFWFtwGPzyHsUMOXR3l0ZAFKbyV4sPSd58J05PlxUXerw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(376002)(366004)(136003)(6506007)(38100700002)(83380400001)(85182001)(54906003)(186003)(71200400001)(110136005)(316002)(66476007)(66946007)(66556008)(64756008)(66446008)(7416002)(76116006)(2906002)(478600001)(9686003)(8676002)(7696005)(4326008)(55016002)(52536014)(33656002)(8936002)(966005)(122000001)(26005)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEhzemJGL1pOWlprdmdndkQ0STRhVkdLTmxXZCtHYi8xZ2ZNcGRCRVBuejlH?=
 =?utf-8?B?OG1KZXA2bVVhT005bnNLQnp5clc4ait1YnFJSDdGQlB1b1BDdTdja0dvSzZy?=
 =?utf-8?B?QVkwYldlRnQxOVdzR3RFc3NDaXhQOU4zMHNwMWR5M28yZEtDSk16eUhaT1lV?=
 =?utf-8?B?NXJ3RUtCTUJBZzc2R1hXTk4yOHlqYkhseDIxUGdBSjFrVmFYd0RuMFV0MHZM?=
 =?utf-8?B?UVVocnNkQ2x2b3pka1RRMU0welVqLzVnU0M5SFMzUHpHN3czSzY3K28wb2x1?=
 =?utf-8?B?eExEdXlvRUNodW9ITWlzdUsvMXZiVkhvbG9pSEpaMCtjeG01a3R4ai9EdFZa?=
 =?utf-8?B?MFRzbnpHM3JGbURpQk4wNEF4ek5VejJwYWtHRnYrQ2JFMHlWaklod2lFVWVy?=
 =?utf-8?B?OHlWTDh2ditpM1Z0YVlLRXR4UUxXVlFmb1crZUxHcThBT0RPZUZPOGtjejZY?=
 =?utf-8?B?NGhiQnZBdEhORzlxdFhtWng4L2xMWGNrZVhKZkRHRzNPdnB1UHpLOUw2UEln?=
 =?utf-8?B?ckhFNVFYVTVld0NZZkFMRUJJTlJaaGNObzhvWWhaM1NETWc2Y00xeGp6eHVp?=
 =?utf-8?B?T0NsTjAxL3hjSmtvSXVHMDYybVJRTlpsaXNFMHJIVXFLdlBBNWQ5MWo2di9R?=
 =?utf-8?B?RFpWeU8zeitKb2pVSG81RWRtbXMzL1NLNDVWVGs0R2daSis5eG42T09JMmxF?=
 =?utf-8?B?S2I1YTAyeklwRzZOM0VkdjgvMmhtQ3czQ0lJNzIvZnU0MjNlVVplZEtWWkZj?=
 =?utf-8?B?bGpLT1ZPM3VobkNmODBIOFFBcS8xd0dZRHUwMjh6NlZGbFVJRmNTeHRZaVY0?=
 =?utf-8?B?ZUZHU0dxVGlLNk9MMXUwWGhTRFdEQzdML01iZVdqM05MU0VDL0hjUjNpbHRO?=
 =?utf-8?B?M1JEekdiNXovQVdZcG9rYzNVK21oUzVXRTEwMXRhczQ2OVVHL294VDhwWmgy?=
 =?utf-8?B?dzJCRnMyUjA2QUZxYjd0U28vamM5NHRMcDYxNTJiS0NKSktMUG1mQ3dEZGpl?=
 =?utf-8?B?eUQ4UHhDaW9TZEN4MFA5WTFMVlNNUC85N2g1SkdPMkhOaXRXRTJsQmltdWdB?=
 =?utf-8?B?bWp6WUViczR3VlNreU9aRXhSS2h3ZmNXKzIyWkF4VnRzZzhCMkVUTXFSTXBK?=
 =?utf-8?B?VzZUeWtmQmtsT1lEY0hBR0JOSFhiVWdmUzltUXpaaVpZZjlhNXhiT0w1MkJk?=
 =?utf-8?B?V3ljdWVVZlloK3NQQTRXY0JnQmgyZmxqSVBLbHRyL1hKUmJKa1hTcFBHQ2R0?=
 =?utf-8?B?alh0ZmkxTjFqd3FLY29jZzZXdVV2VDBJWlcrRjNPa1k4SUMwRU9vRE01azZF?=
 =?utf-8?B?QzByemFmSU0wOWYwVEdMWC9aRllLaXRHakRIQy9KejhreTZqV3dRa3dVZWZZ?=
 =?utf-8?B?UmJWZ0RXeW5yOU5VaTREZjB5UVpPUzFNMHdMMGNQVGFxbTRZcTlldU5HWEF2?=
 =?utf-8?B?ajdFWS9RZUdKSHVUSzkrNENFNUNiSzZOOUk2QmdweFF1NGRnclR6UGF2bTJW?=
 =?utf-8?B?dk1OREN3Q2xwWlNabWpkaGJtOW1ubzBkZnFWOE83NnFRV1VuYlk0M3BaSGhu?=
 =?utf-8?B?VEdhMC9EV1Q0QzdoRGtTTjlELzJyd3BxY3kxV1JuWC95VzhXdGhvZnB4TVph?=
 =?utf-8?B?Y1JKN1psLzdiSGdWMHhjOGFHYnBtRTRQVVk2c21CM0luaFJHT0VCME9BOHJo?=
 =?utf-8?B?OFgzQ0Fwdkg4YU9GdldlTnIvMERMTm4wdTJ2a2E3cXFxZmx5SDZ4YVRrdlNX?=
 =?utf-8?Q?HdqV6Lf/t+3NWZ9TZ0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf92d8a-8d07-4122-22b8-08d931f8fd21
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 01:32:51.6964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rhk+sBI9MpCqdBUHjpzLXtqcjHofLSc4AOgztGyzk8fFuRka+Mp6WvHAgLZ56B15Ury8Am2Ym7xFxZz2/Lli346J7TgTicJ3pPuC8/rptJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphbWVzLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4NCg0KPiBXaGlsZSB0aGlz
IGlzIGluaXRpYWxseSBhYm91dCBzeXNmcywgZG9uJ3QgeW91IG5lZWQgdGhlICdIUEMgdGFnIGFk
ZHJlc3Mgb3ZlcnJpZGUnDQo+IHRvIGJlIGVuYWJsZWQgZm9yIHRoaXMgdG8gYmUgdXNlZnVsPyBJ
IGRvbid0IHRoaW5rIHRoYXQgZmVhdHVyZSBjYW4gYmUgbWFuYWdlZCBieQ0KPiBhIGRyaXZlcjoN
Cg0KSXQgaXMgY2VydGFpbmx5IHVzZWZ1bCB0byBlbmFibGUgJ0hQQyB0YWcgYWRkcmVzcyBvdmVy
cmlkZScgZm9yIG1vcmUgY29udHJvbC4NCkhvd2V2ZXIsIGVuYWJsaW5nICJIUEMgdGFnIGFkZHJl
c3Mgb3ZlcnJpZGUiIGhhcyBzb21lIGNoYWxsZW5nZXMgYXMgeW91IGNvbW1lbnRlZC4NCldlIGhh
dmUgYWxzbyB2ZXJpZmllZCB0aGF0IHRoZSBwZXJmb3JtYW5jZSBjYW4gYmUgaW1wcm92ZWQgdmlh
IElNUF9QRl9TVFJFQU1fREVURUNUX0NUUkxfRUwwIHdpdGhvdXQgdXNpbmcgJ0hQQyB0YWcgYWRk
cmVzcyBvdmVycmlkZScuDQpUaGVyZWZvcmUsIGZpcnN0LCB3ZSB3b3VsZCBsaWtlIHRvIGltcGxl
bWVudCBzeXNmcyBpbnRlcmZhY2UgdG8gY29udHJvbCBvbmx5IElNUF9QRl9TVFJFQU1fREVURUNU
X0NUUkxfRUwwLg0KDQpBdCB0aGlzIHRpbWUsIHdlIGRvbid0IGludGVuZCB0byBlbmFibGUgIkhQ
QyB0YWcgYWRkcmVzcyBvdmVycmlkZSIsIGJ1dCBpZiBuZWNlc3NhcnksIHdlIHdvdWxkIGxpa2Ug
dG8gY29uc2lkZXIgaXQuDQoNCj4gJ0hQQyB0YWcgYWRkcmVzcyBvdmVycmlkZScgY2hhbmdlcyB0
aGUgdG9wIGJ5dGUgb2YgYWxsIHVzZXItc3BhY2UgcG9pbnRlcnMgZnJvbQ0KPiBiZWluZyBpZ25v
cmVkIChhcyB0aGV5IGhhdmUgYmVlbiBzaW5jZSBkYXktMSBvbiBhcm02NCkgdG8gaGF2aW5nIGlt
cGxpY2F0aW9ucw0KPiBmb3IgdGhlIGhhcmR3YXJlLg0KPiBJZiBJJ3ZlIHJlYWQgdGhlIGRvY3Vt
ZW50IGNvcnJlY3RseSB0aGlzIGFmZmVjdHMgdGhlIHByZWZldGNoIG1vZGUgYW5kIHdoZXJlIGlu
DQo+IHRoZSBMMS9MMiBzdWNoIGFjY2Vzc2VzIHdpbGwgYmUgYWxsb2NhdGVkLg0KDQpZb3VyIHVu
ZGVyc3RhbmRpbmcgb2YgJ0hQQyB0YWcgYWRkcmVzcyBvdmVycmlkZScgaXMgY29ycmVjdC4NCklm
IGl0J3MgZW5hYmxlZCwgdHVuaW5nIGFjY29yZGluZyB0byBjaGFyYWN0ZXJpc3RpY3Mgb2YgZWFj
aCBsb2FkL3N0b3JlIGluc3RydWN0aW9uIGlzIHBvc3NpYmxlLg0KT24gdGhlIG90aGVyIGhhbmQs
IHdlIGNhbiBzdGlsbCBjaGFuZ2Ugc3lzdGVtLXdpZGUgc2V0dGluZ3MgJ1ByZWZldGNoIEVuYWJs
ZW1lbnQgKGJpdDogWzU5XSwgWzU4XSknLCAnUHJlZmV0Y2ggRGlzdGFuY2UgKGJpdDogWzI3OjI0
XSwgWzE5OjE2XSknLCBhbmQgJ1ByZWZldGNoIFJlbGlhYmxlbmVzcyAoYml0OiBbNTVdLCBbNTRd
KScgdmlhIElNUF9QRl9TVFJFQU1fREVURUNUX0NUUkxfRUwwIHdpdGhvdXQgaXQuDQpUaGUgbGF0
dGVyIGRvZXMgbm90IGFsbG93IHRvIHBlci1pbnN0cnVjdGlvbiB0dW5pbmcsIGJ1dCBhbGxvdyBw
ZXItYXBwbGljYXRpb24gdHVuaW5nLg0KQXQgdGhpcyBwb2ludCwgd2UgYXNzdW1lIHRoYXQgb25l
IGFwcGxpY2F0aW9uIGlzIGJvdW5kIHRvIG9uZSBjb3JlLg0KDQo+IFRoaXMgd291bGQgaW1wYWN0
IHVzZXItc3BhY2UgdGhhdCBpcyB1c2luZyB0aGUgdG9wLWJ5dGUgZm9yIHRoZWlyIG93biBwdXJw
b3Nlcy4NCj4gRm9yIGV4YW1wbGUgaHdhc2FuIHVzZXMgdGhpcyBmaWVsZCBhcyBhIHRhZyBpdCBh
bGxvY2F0ZXMgaXRzZWxmOg0KPiBodHRwczovL2NsYW5nLmxsdm0ub3JnL2RvY3MvSGFyZHdhcmVB
c3Npc3RlZEFkZHJlc3NTYW5pdGl6ZXJEZXNpZ24uaHRtbA0KPiBFbmFibGluZyAnSFBDIHRhZyBh
ZGRyZXNzIG92ZXJyaWRlJyBmb3IgYWxsIHVzZXItc3BhY2UgaXMgZ29pbmcgdG8gaGF2ZSB3ZWly
ZA0KPiBwZXJmb3JtYW5jZSBlZmZlY3RzLg0KPiANCj4gVG8gbWFrZSB0aGlzIHdvcmssIEkgdGhp
bmsgeW91J2QgbmVlZCBhIHBlci1wcm9jZXNzIG9wdC1pbiwgYW5kIF9fc3dpdGNoX3RvKCkNCj4g
d291bGQgbmVlZCB0byB0b2dnbGUgeW91ciBJTVBfRkpfVEFHX0FERFJFU1NfQ1RSTF9FTDEuVEJP
eCBiaXRzLg0KPiBCZWNhdXNlIGl0cyBhbiBpbXBsZW1lbnRhdGlvbi1kZWZpbmVkIGZlYXR1cmUs
IGJ1dCB0aGUgY29udHJvbHMgY2FuJ3QgYmUNCj4gY29uZmluZWQgdG8gYSBkcml2ZXIsIEkgZG9u
J3QgdGhpbmsgZW5hYmxpbmcgJ0hQQyB0YWcgYWRkcmVzcyBvdmVycmlkZScgaXMgdmlhYmxlLg0K
DQpXZSB1bmRlcnN0b29kIHRoYXQgdGhlcmUgYXJlIHRoZXNlIGNoYWxsZW5nZXMgaWYgd2UgdHJ5
IHRvIGVuYWJsZSAnSFBDIHRhZyBhZGRyZXNzIG92ZXJyaWRlJy4NCkhvd2V2ZXIsIGlmIHdlIGRv
bid0IGVuYWJsZSAnSFBDIHRhZyBhZGRyZXNzIG92ZXJyaWRlJywgdGhlc2UgY29uc2lkZXJhdGlv
bnMgYXJlIHByb2JhYmx5IHVubmVjZXNzYXJ5IGJlY2F1c2Ugc2V0dGluZ3MgdmlhIElNUF9QRl9T
VFJFQU1fREVURUNUX0NUUkxfRUwwIGFyZSB0cmVhdGVkIGFzIHN5c3RlbS13aWRlIHNldHRpbmdz
Lg0KDQo+IElzIHRoZSBzeXNmcyBpbmZvcm1hdGlvbiB1c2VmdWwgd2l0aG91dCBpdD8NCg0KV2Ug
dGhpbmsgaXQncyBlbm91Z2ggdG8gdHVuZSBzeXN0ZW0td2lkZSBzZXR0aW5ncyAnUHJlZmV0Y2gg
RW5hYmxlbWVudCcsICdQcmVmZXRjaCBEaXN0YW5jZScsIGFuZCAnUHJlZmV0Y2ggUmVsaWFibGVu
ZXNzJyB2aWEgSU1QX1BGX1NUUkVBTV9ERVRFQ1RfQ1RSTF9FTDAgaW4gbW9zdCBjYXNlLg0KVGhl
cmVmb3JlLCB3ZSB0aGluayBpdCBpcyB1c2VmdWwgdG8gaW1wbGVtZW50IHN5c2ZzIGludGVyZmFj
ZSB0byBvcGVyYXRlIG9ubHkgSU1QX1BGX1NUUkVBTV9ERVRFQ1RfQ1RSTF9FTDAuDQoNCkJlc3Qg
cmVnYXJkcy4NCg==
