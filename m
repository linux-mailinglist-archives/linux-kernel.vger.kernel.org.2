Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027ED366338
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhDUA5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:57:36 -0400
Received: from mail-eopbgr1400054.outbound.protection.outlook.com ([40.107.140.54]:51328
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233836AbhDUA5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:57:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/O2jNTkcKBJDUhZJuj5uoVVhmZQ5gaOKrCJblw0QSTwZefeqzb+3SHm4Kkw9BSzfmvtcbs9IJo3EoAJb8j3FApvKstTRVD/V8mxRa8UfBzxh9X5BT9i52LOT6U310VG4OAootJz2/3niOZQTTeR/o6mb15LrKFOxAFjOqRhf1Gk/2bYwlLCqpWO71Qm9YQ+YWlPF8RjT9AtjbG7wCOA5VAZ8R0HVtRKx4R578MrHG32MlfOzrNpjgw3Y9z+OGoSOqYsQbKePaEOONQWz/TgSlzNOoom5n601zjBSRSvOpUKwH8oZZg2ZXI6tmDyWuimMrD9h6UeD7uLR4k0QSHutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUCumuvt9VeIhJ1T6utEt2CD8IP2QhUr7vPzq0jHX+U=;
 b=HC56fL8QbNwi8BxGYA+WO+pnxIqVERcx3h5daVC3yNBa6fLBc3qP92LALnRlx312OPVkTXmIkEWqI8hWn/tTRgz+9Mm67JwTevRkH5L5W+guzjn/tJSCKoEsG72HlE/sAmyGHLRPaOW3m8cwq+88c363fA6lnh9zaAx8Jobvd3DwqTlWl5l8R82ZG0E0nNosgSMAMTskBAbQbYzRcGIQHFXJ3m3FdT4r5X/Nx+Mg7DNbiSW61LD0ucsi7l3A85I4GhfQ14Z4l9nCwaKHYPW1rGIsjQbFwDxQlkVclsywx8Bpf6OjjMXUzgcP86V0TmaCEhvENikLpw1tr7EcKy4yvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUCumuvt9VeIhJ1T6utEt2CD8IP2QhUr7vPzq0jHX+U=;
 b=Q5GuRAAZ1BtdIYKPOnKQj6XcQBohQAKrixdBxvZ5avtYqJZxbeYtmKkv0GZpm1NgWgHTT01XZwHUaSXCdgFzLFn0C0RpKJVO8sufpyriB0OY4fEuZsDzc2UQaalxOHDF6t6/A0XhEZZmSXNJhsXIAI7j1qEI98NSQTzfylfj/aI=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3965.jpnprd01.prod.outlook.com (2603:1096:404:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 00:57:01 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 00:57:01 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Thread-Topic: [PATCH v1 1/3] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Thread-Index: AQHXL+1ETVXNtZ717UymKkytASjJ46q8HJYAgAD2FoCAACoPgIAA9eGA
Date:   Wed, 21 Apr 2021 00:57:01 +0000
Message-ID: <20210421005659.GA24391@hori.linux.bs1.fc.nec.co.jp>
References: <20210412224320.1747638-1-nao.horiguchi@gmail.com>
 <20210412224320.1747638-2-nao.horiguchi@gmail.com>
 <20210419170538.GG9093@zn.tnic>
 <20210420074625.GA24451@hori.linux.bs1.fc.nec.co.jp>
 <20210420101657.GF5029@zn.tnic>
In-Reply-To: <20210420101657.GF5029@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 679d6399-b9d6-4aec-25a7-08d904605f5e
x-ms-traffictypediagnostic: TYAPR01MB3965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3965B7D91CB4CF5AA704F933E7479@TYAPR01MB3965.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUyAdrUvQ9sGxyElGqLhpn9jWnF1IqewzViHlB1LgUZJD+o/jg+TJ7E/NmTptsdejjOc4jUuHx+aRYpbNOkGkVXJZPoHlWaHtUnkjowaEduRZswrInfoATRGHPJ21+mgTOOhXZuGZqyuw2svaI8Tad8JRN1SzQ2ydmB0a5UVUQFfgbAtrOMqrk4gmQsuk5CccUOdcN3qMiu8FAk2fl1cQe3s2AZV1zQV9cPILRp2m6Taho+rcK5Rvl6774SqAS4jEy6kyYpiaoWIlYtjlh2IGk+7TaW6idM+TXFfUWMmwV+GHcdyTX8UIXSbag0XaLnesUaZi9nWumCE5ws7NLApVmGg2htHeqkYX945aZgjjxwURwUj+AiZhry6HMXCDKCETEDfNk58RC/zcIl2yJf9lGhi0ZLyr+JbA76VRhUTdqWfWOKspQv8XGkVeY/44WtmCl+g3tf9FYq/DLgmAWQ3upV+bl9Igb4CextCjJ2mWjDBQDXqPK5uAI6w12FB4D8CRkBSw0Fn2TOtwXoCR++sIrisqujBLa0GuEh0zsMjX4XzpsrrdnjloQ8gFQO6zzqObU961tPS7KgbTNjah2wEUnZwj4vTdDpsNqKyV2Nq2N0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(4326008)(33656002)(26005)(76116006)(86362001)(186003)(478600001)(7416002)(83380400001)(66946007)(122000001)(85182001)(9686003)(38100700002)(2906002)(6512007)(6916009)(1076003)(8936002)(6506007)(71200400001)(53546011)(55236004)(5660300002)(54906003)(316002)(6486002)(66476007)(66556008)(64756008)(8676002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ejk5bjdPL2hzUzU0eWF1eVMxbDFlOTR4eG1USktKV3RrVkhQZWRzclJaelpn?=
 =?utf-8?B?eGxKSFordUMrRzNYTUloaGFNVXY0bGUrRDdaQkNFVzM4Qm1mZUZJcHdMdGJz?=
 =?utf-8?B?eU1ydmpKdSs5OFRWUGwyYlZUWEhJUlpWWk1KMmg0WUR1eHdUZFd0ZjV1R1FT?=
 =?utf-8?B?V01ZSHFuVDdtZnZGeHNyR21ITDNIekg0YnlvOXExWnh3bWwrWUVkOHVXaFgy?=
 =?utf-8?B?UHR1TGlKS0ZDRmZ6V0l1SFhHb2dkWXJFWUpBWGVVRWFhdkQzK05zYXFXMHp0?=
 =?utf-8?B?WlFQRFlad0hPY2x4YmhxUjZnSGdIL25VOStQbTc3R0F2MWZwT1gySnUyZXVi?=
 =?utf-8?B?ZDZNM3FrY3ozcDBnUTNaME1NNlNLLzQ4WmxPcUpXS2dWekMyYks2SUJjYU1P?=
 =?utf-8?B?a3AvNmkwdlpES0VHUURrM0RqS3ZTdFllWTN6MVhaZTZOUjVyYVhFbWo0NUhk?=
 =?utf-8?B?dUI3ZG9pOEZqcFlYWVYzOGI2cXBmbmxjWVY1RnJGMWl3V001QktWMkxnN1Nw?=
 =?utf-8?B?WTRoWWtEcTFJSUoyM3hwMkhPZzZRM3hXeGNLaXk0cExTMiszR1lQVG1xU3hu?=
 =?utf-8?B?Njk5V2t6eDNKK0x2QTRoNGFjTmEvYzNBUnNSS09Jci8xNGN1VHU1VzQxa3hO?=
 =?utf-8?B?NTI0aWh4dXpJRk9TUW44eUVVbmw4bnFOS2xMbi8vQW0rMERtNFRKR0xYcUZk?=
 =?utf-8?B?VHloczJvNmdxZmwzQm53TC9XTkxZTXJXVFF5UTRtdWtOVDloZFk0VlJoRjQ3?=
 =?utf-8?B?dk5acjNCdlViTUJKT2oyejBqVGZac2hRUUZKS3lxL2I5S25LVm9nRGRpL0RI?=
 =?utf-8?B?b2h2dUhCcUd0SHhoL1FrUE1pM0o2UCtTU2oxQXUwZTJFZ3lnbnRXdEtxdWkz?=
 =?utf-8?B?ckkwYkpKV0FwUlpoaGdSRTdpbXhaK0puYnBtYlc5VFlNaUZRRWJMWWYvdUl1?=
 =?utf-8?B?UWw0UkVYZmRaSEVNY0dRcXpkMTQyZmVLNkx4UHRoSHZUZGdxQzdneU0ramVM?=
 =?utf-8?B?bElrVEo1SkxNWFd1MDlvMStqblk3OHVtQ056NjhqUU9HOWt5VDJLUGRzK2ZS?=
 =?utf-8?B?SlRBSGxhTC94OWhZSXhUNGdtR2Exck9BaStHanJyb1I4WmdkU0cyZU5TTWVK?=
 =?utf-8?B?ZTljOWFMdHJIVC9lMm0vcVB1YVVKbDhxamk3WHJnQUgzc0FQZDdPUWtsaEpP?=
 =?utf-8?B?OS81NmttS01LcURNdVBhRzZQZmRaSFNJN3JaOXZyRzNabTcyNEdOSm5qYlA1?=
 =?utf-8?B?bW95WlJEdTFRZzM0U1VrS0dRMXE1dC9IMGRPL1gvUmEzdzA0UDVwdFRWMERD?=
 =?utf-8?B?RXJaVGJDYzRoU0pUUW81WGFERTJTT3MzSkNQUVVFY2d5OWZDSU1tUzZEUlIv?=
 =?utf-8?B?dlQ4TEgrMGpEMU5RZmV0d2Y0V09Vck1PZkVkNXJ5Q1FYaXlDWFBlTGY5WEdL?=
 =?utf-8?B?TU5UZDFYcEFjVkhtU04wS1ZKQnpObXZMYlhueE5aYUpPV2ttdXdWeWJNNWto?=
 =?utf-8?B?ZDhuaG9tSmgrNkV1ejlhK3ZHM1pzV2FMS2Q2dHFHRDRvRlUzblF5NTNybW8x?=
 =?utf-8?B?K2lGcVVUZERMSy9GY3lJbVJXbjdtVEZXSmRFRUk1cnVOVTBhMU8vODNvbmZ5?=
 =?utf-8?B?OWdSWEhTTHJjdXE3VXluS21Sc0NRVmhHVWFhWFpTTk9Wd2svTG5qZ2ZJaUxO?=
 =?utf-8?B?a3E0eFA0K1dkV3RxYnorMUU1QlBhalNkcHQzL1J5UUdjYXZ1bHgrbjdKZG9q?=
 =?utf-8?Q?Pq76af9OrzEdcOMEoh+4vGVqi0cESwdM5XLAgbD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28C232CC4084D04596F1914B372EC6B0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679d6399-b9d6-4aec-25a7-08d904605f5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 00:57:01.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZ9oII8iOkKgDtPCSoQdWck1wuPCWW7CM75WbfKQsDx3hHICPbvrOgLBYet9ISZS+hGsAlqIz0uZdASE4JJMHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMjAsIDIwMjEgYXQgMTI6MTY6NTdQTSArMDIwMCwgQm9yaXNsYXYgUGV0a292
IHdyb3RlOg0KPiBPbiBUdWUsIEFwciAyMCwgMjAyMSBhdCAwNzo0NjoyNkFNICswMDAwLCBIT1JJ
R1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykgd3JvdGU6DQo+ID4gSWYgeW91IGhhdmUgYW55IG90
aGVyIHN1Z2dlc3Rpb24sIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IExvb2tzIGFsbW9zdCBv
ay4uLg0KPiANCj4gPiBGcm9tOiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+ID4g
RGF0ZTogVHVlLCAyMCBBcHIgMjAyMSAxNjo0MjowMSArMDkwMA0KPiA+IFN1YmplY3Q6IFtQQVRD
SCAxLzNdIG1tL21lbW9yeS1mYWlsdXJlOiBVc2UgYSBtdXRleCB0byBhdm9pZCBtZW1vcnlfZmFp
bHVyZSgpDQo+ID4gIHJhY2VzDQo+ID4gDQo+ID4gVGhlcmUgY2FuIGJlIHJhY2VzIHdoZW4gbXVs
dGlwbGUgQ1BVcyBjb25zdW1lIHBvaXNvbiBmcm9tIHRoZSBzYW1lDQo+ID4gcGFnZS4gVGhlIGZp
cnN0IGludG8gbWVtb3J5X2ZhaWx1cmUoKSBhdG9taWNhbGx5IHNldHMgdGhlIEhXUG9pc29uDQo+
ID4gcGFnZSBmbGFnIGFuZCBiZWdpbnMgaHVudGluZyBmb3IgdGFza3MgdGhhdCBtYXAgdGhpcyBw
YWdlLiBFdmVudHVhbGx5DQo+ID4gaXQgaW52YWxpZGF0ZXMgdGhvc2UgbWFwcGluZ3MgYW5kIG1h
eSBzZW5kIGEgU0lHQlVTIHRvIHRoZSBhZmZlY3RlZA0KPiA+IHRhc2tzLg0KPiA+IA0KPiA+IEJ1
dCB3aGlsZSBhbGwgdGhhdCB3b3JrIGlzIGdvaW5nIG9uLCBvdGhlciBDUFVzIHNlZSBhICJzdWNj
ZXNzIg0KPiA+IHJldHVybiBjb2RlIGZyb20gbWVtb3J5X2ZhaWx1cmUoKSBhbmQgc28gdGhleSBi
ZWxpZXZlIHRoZSBlcnJvcg0KPiA+IGhhcyBiZWVuIGhhbmRsZWQgYW5kIGNvbnRpbnVlIGV4ZWN1
dGluZy4NCj4gPiANCj4gPiBGaXggYnkgd3JhcHBpbmcgbW9zdCBvZiB0aGUgaW50ZXJuYWwgcGFy
dHMgb2YgbWVtb3J5X2ZhaWx1cmUoKSBpbg0KPiA+IGEgbXV0ZXguDQo+ID4gDQo+ID4gQWxvbmcg
d2l0aCBpbnRyb2R1Y2luZyBhbiBhZGRpdGlvbmFsIGdvdG8gbGFiZWwsIHRoaXMgcGF0Y2ggYWxz
bw0KPiANCj4gLi4uIGF2b2lkIGhhdmluZyAiVGhpcyBwYXRjaCIgb3IgIlRoaXMgY29tbWl0IiBp
biB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+IEl0IGlzIHRhdXRvbG9naWNhbGx5IHVzZWxlc3MuIEFs
c28sIHlvdSBkb24ndCBoYXZlIHRvIGV4cGxhaW4gd2hhdCB0aGUNCj4gcGF0Y2ggZG9lcyAtIHRo
YXQncyB2aXNpYmxlIGhvcGVmdWxseS4gOi0pDQoNCk9LLCBJJ2xsIGRyb3AgdGhpcyBwYXJhZ3Jh
cGggZnJvbSBuZXh0IHZlcnNpb24uDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
