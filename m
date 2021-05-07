Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A98375F4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 06:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhEGES4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 00:18:56 -0400
Received: from mail-eopbgr1400074.outbound.protection.outlook.com ([40.107.140.74]:62446
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229666AbhEGESz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 00:18:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk3GXR0qbimWwcqsNIoLfPR7FBDeKmDW3PyZgdBxXAtY50gr5jCZi9E9J8vLE5zut98GfBvi3Kl3Z7CAQfu49CVk7dPIukVibjlpqcZ6uSdx0aZz98H2vJevLrNlfuO8cka9eZBShHD+7dCMG+OBVvBPCuGvgThxILoAoRuNH2kdVEKL/21dlS9SnmsZrPVSu9kEovcUgz3ZAZDJpsz3O1646LWuowemdI8kIRpaNe3UUOlOVqLnZMPND50Mj2us87MpDc9iogLCreQcxbeqhbB4oz3xYj1ud/jaayf1I2FeIiQVndf82EJ4nuUOVEUihJXQnwlO5SZPrnrWSxaY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGNkXJVaEq2pEKwoIvQnisccoMZwkO7inFS/Jik+okA=;
 b=Yd3UX1MTRj4vkRqTSXv9a7xk/KNZJBDSuXgdg3EW+KA/4yLvbmdCEaOkK0mC9JrWNF/8w8Fcm2RdxDoe6tda/NQ6yCcWpRklqhzBhTawcLOs1gPu7Yuz4sn5WSeNsau64G/Lza//CVlxl4UBYrWz5oPf6NgPlkE+a4IfrWWI9CYuNc0WTqxdBcTzObfL6bCqaXVJgok8dIWl7Dpq689ASDapYvN9t3lGixuxMAtCriaDh0nQsfCTEob0kN9pzcuNNyJVdpSpxFfJld20feNHH/ilVCvG2JgDgGCc2mI1afRy6o300HAHfjUGUOZVaBRHdleJ/hSaCHJWJ4iIRn5dNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGNkXJVaEq2pEKwoIvQnisccoMZwkO7inFS/Jik+okA=;
 b=YpFXL25oEML1nl1NdupH2LCIQqzd06ROzuFtqg3HuTq/up7Amqkf4YWfoatiAG81ttphFykSL7TfmjyZqlFgW4YsaSUtIhKj1SRII2P0gL3mgsRsR8yU59rMzMWY/kpnAUKSdXuL8NCiwTtGyN7hrbZCSvLVdpBRX2MHu6kNFTU=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB6817.jpnprd01.prod.outlook.com (2603:1096:400:b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 04:17:52 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4065.039; Fri, 7 May 2021
 04:17:52 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm,hwpoison: fix race with compound page allocation
Thread-Topic: [PATCH v2] mm,hwpoison: fix race with compound page allocation
Thread-Index: AQHXQhedEti0+MQkoESB1gZkUkj54qrWJdeAgAFF3YA=
Date:   Fri, 7 May 2021 04:17:52 +0000
Message-ID: <20210507041751.GA2158342@hori.linux.bs1.fc.nec.co.jp>
References: <20210423080153.GA78658@hori.linux.bs1.fc.nec.co.jp>
 <20210428074654.GA2093897@u2004> <20210428082344.GA29213@linux>
 <20210428091835.GA273940@hori.linux.bs1.fc.nec.co.jp>
 <20210506013122.GA2240524@u2004> <YJOuFeteYQEPY9WF@localhost.localdomain>
In-Reply-To: <YJOuFeteYQEPY9WF@localhost.localdomain>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a89e6007-0c4e-4894-d295-08d9110f14fd
x-ms-traffictypediagnostic: TYCPR01MB6817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB68179464F64450EBFB650A31E7579@TYCPR01MB6817.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wty+hmIqf+LFRpL4FnYw0C0MWa5XnSMkRSA5pzXjEIHEVlRcsCy/M3t7faYk3fuNAb4ES+wmn8l3MUT5K9cBONWde6lcfUelCSBRqq2BPZOgbDmFQMZw2qZ/67FOB1de3i/wNaJBpD8tZOX+06fniCKcwKPrwgjbNJWyd54YHCI0oUi9O+pF+Jn78KQ5o+aGLckmMcSlhIkMBeUi2/puEiL7s/DtncMKC9nLTZ23HdpqjRm2X6ahFrbUN7+6ts3tOlmtAAj0ovxe0xMtKWpm9jWXEk6tjAEkyZtp11k7lsOi8obu9f5JLcoeoXHW6Gyxy7CXso3v18XqHBG58f3uS2TDqbFnI5iGHAiXxGkqikm0xA3GMSv8pjGBBEjLof39IRfscxaR9sJ+9QrczutYhkysCHPPq8Imt5WTH3nrhVFGqUNFTA9mOSqPF1WgssW1nULy0GKzOm+eT9AOx8dCnwF7OBBIZH4xK3KP4v3K7mBbKc8tfOdqk7qS/hZy8WBNvqtX16Faz5HefHxT1RgMS6f1bNUBQHuemajjXjvdVp8QbKK7DPJQduszvRDP84NADHTUl+4aADK6htVIwSmnCP3qy2M7tf1tagggOCP4Krc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(478600001)(8676002)(83380400001)(6486002)(6512007)(5660300002)(9686003)(86362001)(54906003)(2906002)(316002)(8936002)(71200400001)(6916009)(26005)(1076003)(186003)(85182001)(122000001)(76116006)(66946007)(66556008)(4326008)(66446008)(38100700002)(64756008)(66476007)(33656002)(53546011)(55236004)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RjQ0TDZ5a0djMmlhajYwcWpJR0tpNzhkMCs1eno4Z0kzbml3OWk3bkhlSDFK?=
 =?utf-8?B?VDlhMlFHTWQ0VTFHYmQrRkx1SVlhWURwUEhlL0h1VkM3NEVqTlRjR0JaTFFE?=
 =?utf-8?B?aG4wR09mbW9xa1Q0NkZpdnpXbkhTZzQ1T2kvRXluZTVTSndKdVJpaW1mYmpT?=
 =?utf-8?B?OGlzY0oyYUh3TnJWdC9jZEcvanVzYm9BSGV0aE93NndNOHVTc1d5Y2Q2Y29Q?=
 =?utf-8?B?R0Z2SXhlTDV2OUxsUUxKRFlyYTl3bXZNOHRVZExCY2tWVFhWTW83V1JVSVhu?=
 =?utf-8?B?L2IrcTk0TFBKMVUzVTh3V0IwZ3JYQW9GOU0wbmRiN0dZdWZISG1SeFl5UVFV?=
 =?utf-8?B?OXMvS2RUR0tRWU85bVV0UzYweHYrRDRSUERLaEtDaE9tWkJpZzhNYms1QnF3?=
 =?utf-8?B?dlhtQmwxSVl5ei9MckNERXZxNENldU1tdlFhdzVmdGQ3NlNWc2R5bXFkYm1y?=
 =?utf-8?B?M2k1UEY0ZjdpVGE3S0tIcG1aQWxteHAycWtXWWNCMVlaRDZuRm5mMy9zck1i?=
 =?utf-8?B?L0lsdzZOUy92VmIzeUQrQ0V2UW9UMFVLNjVTRklma1pEdjVLQzNnWnN4MSty?=
 =?utf-8?B?bjNqMHFXb0Fxb3VXQkg2Z0Z1dVVUdjl5bks5SnJVZUF4YTdhSGpIRkVTLzlW?=
 =?utf-8?B?UmRTekpRTDh4Rjh0dmcrYTYvNm9GUlNJalRtVjVVVjd5Wmp6NUJrR0htbHpa?=
 =?utf-8?B?WTNIOCtIKzV3ZS9jRExjOEN5NDFxdmFDWmZRTHJlTVNnSytLSFlLKzdCMVhU?=
 =?utf-8?B?MExkNHJkS2dCVHd3czNJSW1zY0c1NXZBVVdFaHlhaE44eTllSk9GRW1CSEd0?=
 =?utf-8?B?ZCsreGd0blJFR3hXSk01emJzdnpseTNKRW9IRlR6ZVAwK1ZGclFoMFhyRFNh?=
 =?utf-8?B?VDAzYUZlalIvUy8xZzZ6aXJTMU8xdlg3S2doTjJDWE9TRVplbmVHcHJ2a1hC?=
 =?utf-8?B?WXhWODRnV3BTN2ZmWUFaQUJZRG5URlgyKzZHdjFUOXRCclRCblB0VnFXd3RS?=
 =?utf-8?B?MHh2KzNpYmhEai81OU9pWnlEd05RejRxVEhERWUrdFhvclc0bEU4NGdLb3ZD?=
 =?utf-8?B?SVYwd2NzUU5vanBDc2hXMm5YN1FkT1Z4d1NKUzR1MEVuVFRNOTJ4WFFsZ3RY?=
 =?utf-8?B?bnN0MG5lMFFWaGVVeG1YQ0VIbFFibTMvS1VCRTFMSkwwa21udUNvSFBmQUVk?=
 =?utf-8?B?eWt0ckRibjNDZHFSUVpXZWtyd1BWZnFLeERHU0hWZDE2ekVUbWlJQWkvaTdQ?=
 =?utf-8?B?WGZoM3dnV2JzeksrRytZdSttbldhWVVjSG5RSGNKQ1J2d085dXoyYVpLWVo1?=
 =?utf-8?B?eWlsa002a3Y1VCtQM3gzRms1aUQ2NkRXTTJXdXdaVE1JeUR5THJLblFSRlcv?=
 =?utf-8?B?QmRJT3VDaDJFYzBCTEFLNDI0VDdaeXF4ZGRLUW9ST1plYS9sWTZVSElIenVO?=
 =?utf-8?B?SDdyY0dnNmFKa1o4WjVEWFJONndtOUtaTVRyTjJ1UkxoVnNSbHBpc3pQZG55?=
 =?utf-8?B?N29lV3k1RjFGcEpMMUZMSGo3dEJrR2xwTDB4eXpCYktIME1SS0ZpMWoycHZn?=
 =?utf-8?B?cThxZGZ5N01wRmRhRzBLMlZialRrazM2U3ZDODJxa29KNWlhTUtGQklGRnE2?=
 =?utf-8?B?QnpKeEh5MW1CTkF3eDliYWx5Vjg2UTA1S1dyUElxWlNOUE5FRzM3bFZpWjgy?=
 =?utf-8?B?RG9meTh5ZzBYSlpUb1NaYkpnR2R3ZHdzcFBLUTcvOXJ2K0dSclJyY09TVHBL?=
 =?utf-8?Q?tQpxO5Z2JSreEX+d8HqN2k+9TzYMYKedsPbCFQS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <743251EC795EAD44A95DEE23DF8A4FFA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89e6007-0c4e-4894-d295-08d9110f14fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 04:17:52.3166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpTkyj+SUDLQ3/SXtFRUP8CruBvRCRCC7u7UMDAyhm5e1wYAZxvuItTpBZ/7i9yqcBeuvQkiQNQklpd07i6hyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6817
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMDYsIDIwMjEgYXQgMTA6NTE6MzNBTSArMDIwMCwgT3NjYXIgU2FsdmFkb3Ig
d3JvdGU6DQo+IE9uIFRodSwgTWF5IDA2LCAyMDIxIGF0IDEwOjMxOjIyQU0gKzA5MDAsIE5hb3lh
IEhvcmlndWNoaSB3cm90ZToNCj4gPiBGcm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmln
dWNoaUBuZWMuY29tPg0KPiA+IERhdGU6IFRodSwgNiBNYXkgMjAyMSAwOTo1NDozOSArMDkwMA0K
PiA+IFN1YmplY3Q6IFtQQVRDSF0gbW0saHdwb2lzb246IGZpeCByYWNlIHdpdGggY29tcG91bmQg
cGFnZSBhbGxvY2F0aW9uDQo+ID4gDQo+ID4gV2hlbiBodWdldGxiIHBhZ2UgZmF1bHQgKHVuZGVy
IG92ZXJjb21taXRpbmcgc2l0dWF0aW9uKSBhbmQgbWVtb3J5X2ZhaWx1cmUoKQ0KPiA+IHJhY2Us
IFZNX0JVR19PTl9QQUdFKCkgaXMgdHJpZ2dlcmVkIGJ5IHRoZSBmb2xsb3dpbmcgcmFjZToNCj4g
PiANCj4gPiAgICAgQ1BVMDogICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUxOg0KPiA+IA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdhdGhlcl9zdXJwbHVzX3Bh
Z2VzKCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhZ2UgPSBh
bGxvY19zdXJwbHVzX2h1Z2VfcGFnZSgpDQo+ID4gICAgIG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIo
KQ0KPiA+ICAgICAgIGdldF9od3BvaXNvbl9wYWdlKHBhZ2UpDQo+ID4gICAgICAgICBfX2dldF9o
d3BvaXNvbl9wYWdlKHBhZ2UpDQo+ID4gICAgICAgICAgIGdldF9wYWdlX3VubGVzc196ZXJvKHBh
Z2UpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB6ZXJvID0gcHV0
X3BhZ2VfdGVzdHplcm8ocGFnZSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFZNX0JVR19PTl9QQUdFKCF6ZXJvLCBwYWdlKQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZW5xdWV1ZV9odWdlX3BhZ2UoaCwgcGFnZSkNCj4gPiAgICAg
ICBwdXRfcGFnZShwYWdlKQ0KPiA+IA0KPiA+IF9fZ2V0X2h3cG9pc29uX3BhZ2UoKSBvbmx5IGNo
ZWNrcyBwYWdlIHJlZmNvdW50IGJlZm9yZSB0YWtpbmcgYWRkaXRpb25hbA0KPiA+IG9uZSBmb3Ig
bWVtb3J5IGVycm9yIGhhbmRsaW5nLCB3aGljaCBpcyB3cm9uZyBiZWNhdXNlIHRoZXJlJ3MgdGlt
ZQ0KPiA+IHdpbmRvd3Mgd2hlcmUgY29tcG91bmQgcGFnZXMgaGF2ZSBub24temVybyByZWZjb3Vu
dCBkdXJpbmcgaW5pdGlhbGl6YXRpb24uDQo+ID4gDQo+ID4gU28gbWFrZXMgX19nZXRfaHdwb2lz
b25fcGFnZSgpIGNoZWNrIG1vcmUgcGFnZSBzdGF0dXMgZm9yIGEgZmV3IHR5cGVzDQo+ID4gb2Yg
Y29tcG91bmQgcGFnZXMuIFBhZ2VTbGFiKCkgY2hlY2sgaXMgYWRkZWQgYmVjYXVzZSBvdGhlcndp
c2UNCj4gPiAibm9uIGFub255bW91cyB0aHAiIHBhdGggaXMgd3JvbmdseSBjaG9zZW4uDQo+ID4g
DQo+ID4gRml4ZXM6IGVhZDA3ZjZhODY3YiAoIm1tL21lbW9yeS1mYWlsdXJlOiBpbnRyb2R1Y2Ug
Z2V0X2h3cG9pc29uX3BhZ2UoKSBmb3IgY29uc2lzdGVudCByZWZjb3VudCBoYW5kbGluZyIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNv
bT4NCj4gPiBSZXBvcnRlZC1ieTogTXVjaHVuIFNvbmcgPHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNv
bT4NCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDUuMTIrDQo+IA0KPiBIaSBOYW95
YSwgDQo+IA0KPiB0aGFua3MgZm9yIHRoZSBwYXRjaC4NCj4gSSBoYXZlIHNvbWUgY29uY2VybnMg
dGhvdWdoLCBtb3JlIGJlbG93Og0KPiANCj4gPiAtLS0NCj4gPiAgbW0vbWVtb3J5LWZhaWx1cmUu
YyB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL21tL21lbW9yeS1mYWlsdXJlLmMgYi9tbS9tZW1vcnktZmFpbHVy
ZS5jDQo+ID4gaW5kZXggYTM2NTk2MTlkMjkzLi45NjZhMWQ2YjBiYzggMTAwNjQ0DQo+ID4gLS0t
IGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ICsrKyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4g
PiBAQCAtMTA5NSwzMCArMTA5NSw0MSBAQCBzdGF0aWMgaW50IF9fZ2V0X2h3cG9pc29uX3BhZ2Uo
c3RydWN0IHBhZ2UgKnBhZ2UpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBwYWdlICpoZWFkID0gY29t
cG91bmRfaGVhZChwYWdlKTsNCj4gPiAgDQo+ID4gLQlpZiAoIVBhZ2VIdWdlKGhlYWQpICYmIFBh
Z2VUcmFuc0h1Z2UoaGVhZCkpIHsNCj4gPiAtCQkvKg0KPiA+IC0JCSAqIE5vbiBhbm9ueW1vdXMg
dGhwIGV4aXN0cyBvbmx5IGluIGFsbG9jYXRpb24vZnJlZSB0aW1lLiBXZQ0KPiA+IC0JCSAqIGNh
bid0IGhhbmRsZSBzdWNoIGEgY2FzZSBjb3JyZWN0bHksIHNvIGxldCdzIGdpdmUgaXQgdXAuDQo+
ID4gLQkJICogVGhpcyBzaG91bGQgYmUgYmV0dGVyIHRoYW4gdHJpZ2dlcmluZyBCVUdfT04gd2hl
biBrZXJuZWwNCj4gPiAtCQkgKiB0cmllcyB0byB0b3VjaCB0aGUgInBhcnRpYWxseSBoYW5kbGVk
IiBwYWdlLg0KPiA+IC0JCSAqLw0KPiA+IC0JCWlmICghUGFnZUFub24oaGVhZCkpIHsNCj4gPiAt
CQkJcHJfZXJyKCJNZW1vcnkgZmFpbHVyZTogJSNseDogbm9uIGFub255bW91cyB0aHBcbiIsDQo+
ID4gLQkJCQlwYWdlX3RvX3BmbihwYWdlKSk7DQo+ID4gLQkJCXJldHVybiAwOw0KPiA+ICsJaWYg
KFBhZ2VDb21wb3VuZChwYWdlKSkgew0KPiA+ICsJCWlmIChQYWdlU2xhYihwYWdlKSkgew0KPiA+
ICsJCQlyZXR1cm4gZ2V0X3BhZ2VfdW5sZXNzX3plcm8ocGFnZSk7DQo+ID4gKwkJfSBlbHNlIGlm
IChQYWdlSHVnZShoZWFkKSkgew0KPiA+ICsJCQlpbnQgcmV0ID0gMDsNCj4gPiArDQo+ID4gKwkJ
CXNwaW5fbG9jaygmaHVnZXRsYl9sb2NrKTsNCj4gPiArCQkJaWYgKEhQYWdlRnJlZWQoaGVhZCkg
fHwgSFBhZ2VNaWdyYXRhYmxlKGhlYWQpKQ0KPiA+ICsJCQkJcmV0ID0gZ2V0X3BhZ2VfdW5sZXNz
X3plcm8oaGVhZCk7DQo+ID4gKwkJCXNwaW5fdW5sb2NrKCZodWdldGxiX2xvY2spOw0KPiA+ICsJ
CQlyZXR1cm4gcmV0Ow0KPiANCj4gT2ssIEkgYW0gcHJvYmFibHkgb3ZlcnRoaW5raW5nIHRoaXMg
YnV0IHNob3VsZCB3ZSByZS1jaGVjayB1bmRlciB0aGUNCj4gbG9jayB3ZWh0aGVyIHRoZSBwYWdl
IGlzIGEgaHVnZXRsYiBwYWdlPw0KPiBNeSBjb25jZXJuIGlzLCB3aGF0IHdvdWxkIGhhcHBlbiBp
ZjoNCj4gDQo+IENQVTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBD
UFUxDQo+ICBfX2dldF9od3BvaXNvbl9wYWdlICAgICAgICAgICAgICAgICAgICAgICAgICANCj4g
ICBQYWdlSHVnZShoZWFkKSA9PSBUICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGlzc29sdmUgaHVnZXRsYiBw
YWdlDQo+ICAgIGh1Z2V0bGJfbG9jayAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4g
DQo+IA0KPiBJbiB0aGF0IGNhc2UsIGJ5IHRoZSB0aW1lIHdlIGdldCB0byBjaGVjayBodWdldGxi
IGZsYWdzLCB0aG9zZSBjaGVja3MNCj4gbWlnaHQgcmV0dXJuIGZhbHNlLCBhbmQgd2UgZG8gbm90
IGdldCBhIHJlZmNvdW50Lg0KDQpUaGFua3MsIHdlIGhhZCBiZXR0ZXIgYWRkIHJlY2hlY2tpbmcg
YXMgd2UgZG8gaW4gZGlzc29sdmVfZnJlZV9odWdlX3BhZ2UoKS4NCg0KPiBTbywgSSBndWVzcyBt
eSBxdWVzdGlvbiBpczogU2hvdWxkIHdlIHJlLWNoZWNrIHVuZGVyIHRoZSBsb2NrLCBhbmQgaWYg
aXQNCj4gaXMgbm90LCBkbyBhICJnb3RvIHRyeV90b19nZXRfcmVmIiB0aGF0IHN0YXJ0cyByaWdo
dCBhdCB0aGUgYmVnaW5uaW5nLA0KPiBvciBnb2VzIGRpcmVjdGx5IHRvIHRoZSBnZXRfcGFnZV91
bmxlc3NfemVybyBhdCB0aGUgZW5kICh0aGUgZm9ybWVyDQo+IHByb2JhYmx5IGJldHRlcik/DQoN
ClllcywgcmV0cnkgY291bGQgd29yayBpbiB0aGlzIGNhc2UuICBMb29raW5nIGF0IGV4aXN0aW5n
IGNvZGUsDQpnZXRfYW55X3BhZ2UoKSBwcm92aWRlcyAicmV0cnkiIGxheWVyLCBidXQgaXQncyBu
b3QgY2FsbGVkIG5vdyBieQ0KZ2V0X2h3cG9pc29uX3BhZ2UoKSB3aGVuIGNhbGxlZCBmcm9tIG1l
bW9yeV9mYWlsdXJlKCkuICBTbyBJIHRoaW5rIG9mIHRyeWluZw0KdG8gYWRqdXN0IGNvZGUgYW5k
IG1ha2UgZ2V0X2h3cG9pc29uX3BhZ2UgY2FsbCBnZXRfYW55X3BhZ2UoKSBpbnN0ZWFkIG9mDQpj
YWxsaW5nIF9fZ2V0X2h3cG9pc29uX3BhZ2UoKCkgZGlyZWN0bHkuDQoNClRoYW5rcywNCk5hb3lh
IEhvcmlndWNoaQ==
