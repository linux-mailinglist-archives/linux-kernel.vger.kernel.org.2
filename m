Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C94F3B108E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFVX10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 19:27:26 -0400
Received: from mail-co1nam11on2099.outbound.protection.outlook.com ([40.107.220.99]:37355
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229501AbhFVX1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 19:27:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezba/Wgkw9SZzkweHT1zc9+oE26EvEeXWbtDWVHdT4PR2ZedtSptPS0ZD8NlgLpllKHw99VPl437p9auoIrCl2GPVa6Cs7i3GLHx6v6nQOgvqgLrIdiSnPERYvdJsINKX2hP+KLHpZ1KbEu80hfwS01C+spixpr66PgmEytfvJLlGaLeAPHVawB5Kr5Evt3i/aEgddLm1AB7+uo9rH2cSvinFoP2vpL04WH4VqAODCFQ014Lr/h8BlFd3a6vqQF2Oh+JvcGDQlXXA1+CGeH18H9YDXRLVxkKhF8qmIN84vkQrStnQQf1L6WSqcVDuth69jA/0UboYpQXGJN2gUWRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMGa/K6HqkZnul1ZyNg8taMGtyTbfavWFpkapV2eIY0=;
 b=Gu9Qd4cudueSzB8s42igWwNsGX85Fw++9jk5fyyM6f03S/hu221icOF8VzRUgNrLkAQoZNK5wU0sJHmiED+pv5f2KUFDWn/OafdvYQgfZon71Ragnn1vPNJiVHMQtG2yf+ErrIMGzOXzUR91RRiT0KwMZ0xRxfFfWVj3/e4V0pNbB0JgAF81THQkcqXvxmuRw16tw64oH8QRID0G6gg+EDPoc+aWokanH2+blx7EZqH8IAEUHcotVsof+jtmeeJEXdppAnCHVodi1kb7YpJLYukYMenDcvOS6TZMXRR00o/nIuWnOPOHuQX7WZE7JGkPGtyy8GEVjwQ6NGZ2DJsN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMGa/K6HqkZnul1ZyNg8taMGtyTbfavWFpkapV2eIY0=;
 b=Q2+gqJDmx2b1gJ53I9nO+sJAHmXT0cg7ZO2VjvXv70uWKovn1I9sXLqv4yzQ7uKQ/CszEfV1rdC17a+Sg+HMpWyqltXDW3tZ2FHpE7NDiHINPOEZRAOUKpGubhcdJRdpQgUewY0K1s8Hg1jElYU4GgTCOF2bpuyNuZvGh/JymaQ=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1874.namprd21.prod.outlook.com (2603:10b6:303:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.6; Tue, 22 Jun
 2021 23:25:06 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b838:6cc7:4c40:fe99]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b838:6cc7:4c40:fe99%7]) with mapi id 15.20.4287.005; Tue, 22 Jun 2021
 23:25:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Gavin Shan <gshan@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "shan.gavin@gmail.com" <shan.gavin@gmail.com>
Subject: RE: [PATCH 0/3] mm/page_reporting: Make page reporting work on arm64
 with 64KB page size
Thread-Topic: [PATCH 0/3] mm/page_reporting: Make page reporting work on arm64
 with 64KB page size
Thread-Index: AddnvXc07gDLs0G2QNGWdZISeL5Y8Q==
Date:   Tue, 22 Jun 2021 23:25:06 +0000
Message-ID: <MWHPR21MB1593D17E79F4FFBB4A36F32BD7099@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=263f170b-d619-4f87-9c60-7fddda354bb6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-22T23:22:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3833deb5-78f0-4112-4f81-08d935d4f85b
x-ms-traffictypediagnostic: MW4PR21MB1874:
x-microsoft-antispam-prvs: <MW4PR21MB187490ECB0E7B83DB1FE9B56D7099@MW4PR21MB1874.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PFvCY0BHr5U+WXvnRcPKRKMCnRwawAX7Nyqf8LHOAAvfo19cj80+gDws2uGTzQoCW/M4sSbU0n5VFoFZ+0lEN4B7L4tM2xBK5ybiVuuYNM8VjFAl7A9jUR96ux4vwq7M6Y9sVnUWjLquKMGb7q+8FVoi5yDjRzld3Bw7oZ22fYxofLjTEwu6BCJD5pwzlCQ2faLaw0P09inVSkmesZVxkukOGBpCxmL04eS0ZMlpqWKc+CJyzGjW1uunQI0poupPDsezsVOEQW3iW12Zui+oVLDW8G36aYxYWAXeacmaesOzBMwpkMXNONLLjfkq0x4ncQ12K5MY9/Elyo+N1NBl0MMJehyxV/YMC7QHU3aSX8YXghD0bPVcpTuOKxGCCzOAb/Sw7pkF4FM0GMdo0PUdcIydQ2fpJLZgC11GUv5cdmvAw4VY0jGaue7/iHv9P4TOSOgKXMccztOHDngBpRAFjf+SB3UOZ6JwhtIY6ce/xogWZD74Xr0qYvCYrl7WoYt2la+xvMq9iQZ2DT9VOQu3NrDbnvjoXC8IkH7PYRBvy0UIiEyZ+gKezqY2gM/mW3noG64el1+f4X89bQiI8rX3L58UOyAWZNV1GPI/3chCigjalm7V+ifApKQ9Mh6elpyrqDHpi/NhyV9oZUPv2g+XgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(110136005)(7416002)(4326008)(8936002)(6506007)(122000001)(2906002)(54906003)(82960400001)(82950400001)(38100700002)(53546011)(33656002)(66476007)(8990500004)(86362001)(66946007)(5660300002)(316002)(76116006)(52536014)(7696005)(55016002)(66446008)(9686003)(478600001)(71200400001)(26005)(64756008)(83380400001)(186003)(10290500003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVQxblpJZFp5bURkNEQwMG02a0VsYnJXRngydVBucVZzVkZGZWd0NThFUnVW?=
 =?utf-8?B?dHFvekF5eXlsWjdrUUcrb0FtRjRXRXhZMXNkQlFBVlM2ZUJwdDhhbEpPVEdr?=
 =?utf-8?B?VVBUcjJyM0xLTmF0Z1VVbkM5L0t5K0E5NVBrQjZEZVlzNUVuWEhxbUhlb2NK?=
 =?utf-8?B?aGE4U3ZUNko4L25iWmNvY2FlcGNxNzAzUVJnNit4cmIrNGNCT0YrQVdjNVRt?=
 =?utf-8?B?S0llZVNsZDRXbHZqTzFXR2REbzBhWFJPNDRzVkRJZTZpUktVVnl1Z24vU1BO?=
 =?utf-8?B?Nk13cnFOc2ppeTY2a1k1bmF6c3hHQXMwdExtSURYeFJiVFRTYUZ6anZnR2lP?=
 =?utf-8?B?UWRRdUF1eGthTXV6UHhXNkp2SUFFVURIeitOaWRReFp0akVGcWhBTytXRW9r?=
 =?utf-8?B?dWdmWUVHOWxKYUhpS3oyTmUrM0JUaW8zZjFmUmFkWFVuSUJac09tcnZjd3Zv?=
 =?utf-8?B?MVJVNFFPS3B3MUdhSVF6SStJQmJNbGFPTUZCREhYdTJlZnBGWGdkKzdPTStv?=
 =?utf-8?B?QkF3TWI3dGx6TFlxYngvaFpLNU5CNTdvL01ZcUFZYmxzOWt5UkxEWVBpWXBI?=
 =?utf-8?B?N0xDbTMrN2JWVWFPaEd1NmJ1VjJjQmMxVmc5ZmVpOU55d01RbEoydFRacnN4?=
 =?utf-8?B?dnZWWFYwZEozTk85ckIyNGJ2TDJRa2EwSkpwTWlzMXg3WXJkU29lb1FsZCsv?=
 =?utf-8?B?VGpYWGdYcC8xdHZ3SFlDZCt3S3lXa0RaQ3h4SnB4R1Y3WHdNUlk2Q0h2WUkw?=
 =?utf-8?B?eXVBV0NiSWxzUUgyVm4wNEErRkd2L0xkeGlaeHIwcGxPbTBNbHpjcUVaa0NB?=
 =?utf-8?B?MHRsRkRjN0g2aWU3M0M3WTJkaVplTXFMSldnYUljN3Y5K0wwYkJ6WTRJRXVk?=
 =?utf-8?B?dmFIb3dVTXR4SlJZUlk5cTBmekFWY0RkWmlpcU9PaWhIakVVKzdHQ3c2VmZu?=
 =?utf-8?B?QVhOQkVzWDBEUm1COTZxNFZ2YnFGbG9UQ3lCbms4NXpNRkJQY2RQYXdscEpF?=
 =?utf-8?B?bjloOVEyc2NjWUVZUVdIMGVaYUhRTndTb0E5UytCRDdJdnBmNjVrZ3NUZDVT?=
 =?utf-8?B?QWtoTnI2ckhvcTRZSmVVcGN0ektoTnE0dDNuM05GZ1RHVG1JWU4zSFdsV3hj?=
 =?utf-8?B?NXMvaXVFWXZlODgrUDFtUXQwRmNMbGRBUDBMUlJDcXRaYXhXckh0L1djNDlj?=
 =?utf-8?B?ZHhLbktsQWMwSGprMUZIeDl6Ny9peC9Hb3ZxcVZIZDUyMXNpLzl2ZWlNRm05?=
 =?utf-8?B?ektwZEZaazkyYnU2TXJTbFFqR0VpME0vUTAyOFlhdCtLVTBXd04yaVFJaitq?=
 =?utf-8?B?N3NYSjNpK0RqQjRpSndzMmRycXdpZWlZVGZZcjg2cGtxWmNIak5UZnkvWDFl?=
 =?utf-8?B?OXlmeVMvZUdjeENyOERoOG9EV3NqMjlUMHVsc01FejJzQnVNK1BvSFl5Qk9n?=
 =?utf-8?B?TWhPTzFBbHhOZ09TS0dVZ0FhbzM2VHlUOE00QlpUZHo5MTJaeGVQd3hVQ1JY?=
 =?utf-8?B?VlBzaUdTL3NzV1pFSUVSaEt1U3ovKzBrblM4RFpqUjB5VTJRemdrRVZSSko1?=
 =?utf-8?B?dk5nQkFLVW52STRsVnNHMkMwOGozUVc0NHlMaWpLTS9ub3hYMCtWMWtiMVpl?=
 =?utf-8?B?SGIyTEFOYUw4VUNZb3R6RFZVMzg5WFFJOEs3ZE0rUnFLRFV6dVlTUVI3MWRi?=
 =?utf-8?B?YjJZUk81dVpCeTNMc05FSU8zRVJoNFhQWXpqNFpXOEZ3QnJNdS9DSjZZTU4v?=
 =?utf-8?Q?A5BxRKahQBUiArb0grdDrjgtED+8hYFQfO+60Rl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3833deb5-78f0-4112-4f81-08d935d4f85b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 23:25:06.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Quqbo7jXiTvTWM8/J7ecDVLoBiBBnSmCaRRm7v9xqFoLNBGRquJ+l2zICd0Av2FJWP085ZKMvsSjv0UrMf1AK1VmK7Q1FC9iRqjTf9BRw0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1874
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4gU2VudDogTW9uZGF5LCBKdW5lIDIx
LCAyMDIxIDc6MDUgUE0NCj4gDQo+IE9uIDYvMjIvMjEgMjowNiBBTSwgTWljaGFlbCBLZWxsZXkg
d3JvdGU6DQo+ID4gRnJvbTogQWxleGFuZGVyIER1eWNrIDxhbGV4YW5kZXIuZHV5Y2tAZ21haWwu
Y29tPiBTZW50OiBNb25kYXksIEp1bmUgMjEsIDIwMjEgNzowMg0KPiBBTQ0KPiA+PiBUbzogR2F2
aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT4NCj4gPj4gQ2M6IGxpbnV4LW1tIDxsaW51eC1tbUBr
dmFjay5vcmc+OyBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQW5kcmV3DQo+
ID4+IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPjsNCj4gPj4gQW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1bWFuLmto
YW5kdWFsQGFybS5jb20+OyBDYXRhbGluIE1hcmluYXMNCj4gPj4gPGNhdGFsaW4ubWFyaW5hc0Bh
cm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IHNoYW4uZ2F2aW5AZ21haWwu
Y29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8zXSBtbS9wYWdlX3JlcG9ydGluZzogTWFr
ZSBwYWdlIHJlcG9ydGluZyB3b3JrIG9uIGFybTY0IHdpdGgNCj4gPj4gNjRLQiBwYWdlIHNpemUN
Cj4gPj4NCj4gPj4gU28gdGhlIHF1ZXN0aW9uIEkgd291bGQgaGF2ZSBpcyB3aGF0IGlzIHRoZSB1
c2UgY2FzZSBmb3IgdGhpcz8gSXQNCj4gPj4gc2VlbXMgbGlrZSB5b3UgZG9uJ3QgaGF2ZSB0byBk
ZWFsIHdpdGggdGhlIGd1ZXN0IG5hdGl2ZSBwYWdlIHNpemUNCj4gPj4gaXNzdWVzIHNpbmNlIHlv
dSBhcmUgd2lsbGluZyB0byBicmVhayB1cCB3aGF0IHdvdWxkIG90aGVyd2lzZSBiZSBUSFANCj4g
Pj4gcGFnZXMgb24gdGhlIGd1ZXN0LCBhbmQgdGhlIGZhY3QgdGhhdCB5b3UgYXJlIHdpbGxpbmcg
dG8gZ28gZG93biB0bw0KPiA+PiAyTUIgcGFnZXMgd2hpY2ggaGFwcGVucyB0byBhbGlnbiB3aXRo
IHRoZSBob3N0IFRIUCBwYWdlIHNpemUgZm9yIHg4Ng0KPiA+PiBtYWtlcyBtZSB3b25kZXIgaWYg
dGhhdCBpcyBhY3R1YWxseSB0aGUgZW52aXJvbm1lbnQgeW91IGFyZSBydW5uaW5nDQo+ID4+IGlu
Lg0KPiA+Pg0KPiA+PiBSYXRoZXIgdGhhbiBoYXZpbmcgdGhlIGd1ZXN0IGNvbnRyb2wgdGhpcyBp
dCBtaWdodCBtYWtlIHNlbnNlIHRvIGxvb2sNCj4gPj4gYXQgYWRkaW5nIGFuIGludGVyZmFjZSBz
byB0aGF0IHRoZSBwYWdlX3JlcG9ydGluZ19yZWdpc3RlciBmdW5jdGlvbg0KPiA+PiBhbmQgdGhl
IHBhZ2VfcmVwb3J0aW5nX2Rldl9pbmZvIHN0cnVjdCBjb3VsZCBiZSB1c2VkIHRvIHJlcG9ydCBh
bmQNCj4gPj4gY29uZmlndXJlIHRoZSBtaW5pbXVtIHBhZ2Ugc2l6ZSB0aGF0IHRoZSBob3N0IGNh
biBzdXBwb3J0IGZvciB0aGUgcGFnZQ0KPiA+PiByZXBvcnRpbmcuIFdpdGggdGhhdCB0aGUgaG9z
dCBjb3VsZCB0aGVuIGd1YXJhbnRlZSB0aGF0IGl0IGlzbid0IGdvaW5nDQo+ID4+IHRvIGh1cnQg
cGVyZm9ybWFuY2UgYnkgc3BsaXR0aW5nIHBhZ2VzIG9uIHRoZSBob3N0IGFuZCByaXNrIGh1cnRp
bmcNCj4gPj4gdGhlIHZpcnR1YWxpemF0aW9uIHBlcmZvcm1hbmNlLg0KPiA+Pg0KPiA+PiBBbHNv
IHlvdSB3b3VsZCBiZW5lZml0IGJ5IGxvb2tpbmcgaW50byB0aGUgY2FsbGVycyBvZg0KPiA+PiBw
YWdlX3JlcG9ydGluZ19yZWdpc3RlciBhcyB0aGVyZSBhcmUgbW9yZSB0aGFuIGp1c3QgdGhlIHZp
cnRpbyBiYWxsb29uDQo+ID4+IHRoYXQgYXJlIGNvbnN1bWluZyBpdC4gT2RkcyBhcmUgSHlwZXJW
IHdvbid0IGNhcmUgYWJvdXQgYW4gQVJNNjQNCj4gPj4gYXJjaGl0ZWN0dXJlLA0KPiA+DQo+ID4g
RldJVywgSHlwZXItViAqZG9lcyogY2FyZSBhYm91dCBBUk02NC4gIEl0J3MgYWxyZWFkeSBpbiB1
c2UgYnkNCj4gPiB0aGUgV2luZG93cyBTdWJzeXN0ZW0gZm9yIExpbnV4IFZNIHRoYXQncyBwYXJ0
IG9mIFdpbmRvd3MgMTANCj4gPiBvbiBBUk02NCBoYXJkd2FyZS4gIFdlJ3JlIHdvcmtpbmcgdG8g
Z2V0IHRoZSBjb2RlIGFjY2VwdGVkDQo+ID4gdXBzdHJlYW0uDQo+ID4NCj4gDQo+IE1pY2hhZWws
IHRoYW5rcyBmb3IgeW91ciBjb25maXJtYXRpb24uIEFzIHRoZSBpc3N1ZSBmb3VuZCBvbiA2NEtC
IGd1ZXN0DQo+IHdoZW4gbWVtb3J5IGJhbGxvb24gaXMgdXNlZCwgbGV0cyByZXNvbHZlIHRoZSBj
YXNlIGZpcnN0LiBJIHdpbGwgbG9vaw0KPiBpbnRvIEh5cGVyLVYgY2FzZSBsYXRlciBpZiB5b3Ug
YWdyZWUuIEl0IHdvbid0IGJlIGRpZmZpY3VsdCB0byBmaXggdGhlDQo+IHNhbWUgaXNzdWUgZm9y
IEh5cGVyLVYgYWZ0ZXIgdGhlIHNvbHV0aW9uIGlzIGZpZ3VyZWQgb3V0IGZvciBtZW1vcnkNCj4g
YmFsbG9vbi4NCj4gDQo+IFRoYW5rcywNCj4gR2F2aW4NCg0KVGhpcyBzaG91bGQgYmUgZmluZS4g
IEZvciByZWZlcmVuY2UsIHRoZSBIeXBlci1WIEFSTTY0IGhvc3QgYWx3YXlzDQpydW5zIHdpdGgg
YSBiYXNlIHBhZ2Ugc2l6ZSBvZiA0Sy4gIExpbnV4IGd1ZXN0cyBvbiBIeXBlci1WIG1heSBoYXZl
IGJhc2UNCnBhZ2Ugc2l6ZSBvZiA0SywgMTZLLCBvciA2NEsuDQoNCk1pY2hhZWwNCg0KPiANCj4g
Pg0KPiA+PiBidXQgeW91ciBjaGFuZ2Ugd291bGQgZXNzZW50aWFsbHkgZGlzYWJsZSBpdCBvdXRy
aWdodA0KPiA+PiB3aGljaCBpcyB3aHkgSSB0aGluayB0aGlzIG1pZ2h0IGJlIGJldHRlciB0byBh
ZGRyZXNzIHZpYSB0aGUgY29uc3VtZXJzDQo+ID4+IG9mIHBhZ2UgcmVwb3J0aW5nIHJhdGhlciB0
aGFuIHRyeWluZyB0byBhZGRyZXNzIGl0IGluIHBhZ2UgcmVwb3J0aW5nDQo+ID4+IGl0c2VsZi4N
Cj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+Pg0KPiA+PiAtIEFsZXgNCj4gPj4NCj4gPj4gT24gU3Vu
LCBKdW4gMjAsIDIwMjEgYXQgODoxMSBQTSBHYXZpbiBTaGFuIDxnc2hhbkByZWRoYXQuY29tPiB3
cm90ZToNCj4gPj4+DQo+ID4+PiBUaGUgcGFnZSByZXBvcnRpbmcgdGhyZXNob2xkIGlzIGN1cnJl
bnRseSBlcXVhbCB0byBAcGFnZWJsb2NrX29yZGVyLCB3aGljaA0KPiA+Pj4gaXMgMTMgYW5kIDUx
Mk1CIG9uIGFybTY0IHdpdGggNjRLQiBiYXNlIHBhZ2Ugc2l6ZSBzZWxlY3RlZC4gVGhlIHBhZ2UN
Cj4gPj4+IHJlcG9ydGluZyB3b24ndCBiZSB0cmlnZ2VyZWQgaWYgdGhlIGZyZWVpbmcgcGFnZSBj
YW4ndCBjb21lIHVwIHdpdGggYSBmcmVlDQo+ID4+PiBhcmVhIGxpa2UgdGhhdCBodWdlLiBUaGUg
Y29uZGl0aW9uIGlzIGhhcmQgdG8gYmUgbWV0LCBlc3BlY2lhbGx5IHdoZW4gdGhlDQo+ID4+PiBz
eXN0ZW0gbWVtb3J5IGJlY29tZXMgZnJhZ21lbnRlZC4NCj4gPj4+DQo+ID4+PiBUaGlzIHNlcmll
cyBpbnRlbmRzIHRvIHNvbHZlIHRoZSBpc3N1ZSBieSBoYXZpbmcgcGFnZSByZXBvcnRpbmcgdGhy
ZXNob2xkDQo+ID4+PiBhcyA1ICgyTUIpIG9uIGFybTY0IHdpdGggNjRLQiBiYXNlIHBhZ2Ugc2l6
ZS4gVGhlIHBhdGNoZXMgYXJlIG9yZ2FuaXplZCBhczoNCj4gPj4+DQo+ID4+PiAgICAgUEFUQ0hb
MS8zXSBpbnRyb2R1Y2VzIHZhcmlhYmxlIChAcGFnZV9yZXBvcnRpbmdfb3JkZXIpIHRvIHJlcGxh
Y2Ugb3JpZ2luYWwNCj4gPj4+ICAgICAgICAgICAgICAgIG1hY3JvIChQQUdFX1JFUE9SVElOR19N
SU5fT1JERVIpLiBJdCdzIGFsc28gZXhwb3J0ZWQgc28gdGhhdCBpdA0KPiA+Pj4gICAgICAgICAg
ICAgICAgY2FuIGJlIGFkanVzdGVkIGF0IHJ1bnRpbWUuDQo+ID4+PiAgICAgUEFUQ0hbMi8zXSBy
ZW5hbWVzIFBBR0VfUkVQT1JUSU5HX01JTl9PUkRFUiB3aXRoDQo+IFBBR0VfUkVQT1JUSU5HX09S
REVSDQo+ID4+IGFuZA0KPiA+Pj4gICAgICAgICAgICAgICAgYWxsb3dzIGFyY2hpdGVjdHVyZSB0
byBzcGVjaWZ5IGl0cyBvd24gdmVyc2lvbi4NCj4gPj4+ICAgICBQQVRDSFszLzNdIGRlZmluZXMg
UEFHRV9SRVBPUlRJTkdfT1JERVIgdG8gNSwgY29ycmVzcG9uZGluZyB0byAyTUIgaW4gc2l6ZSwN
Cj4gPj4+ICAgICAgICAgICAgICAgIG9uIGFybTY0IHdoZW4gNjRLQiBiYXNlIHBhZ2Ugc2l6ZSBp
cyBzZWxlY3RlZC4gSXQncyBzdGlsbCBzYW1lDQo+ID4+PiAgICAgICAgICAgICAgICBhcyB0byBA
cGFnZWJsb2NrX29yZGVyIGZvciBvdGhlciBhcmNoaXRlY3R1cmVzIGFuZCBjYXNlcy4NCj4gPj4+
DQo+ID4+PiBHYXZpbiBTaGFuICgzKToNCj4gPj4+ICAgIG1tL3BhZ2VfcmVwb3J0aW5nOiBBbGxv
dyB0byBzZXQgcmVwb3J0aW5nIG9yZGVyDQo+ID4+PiAgICBtbS9wYWdlX3JlcG9ydGluZzogQWxs
b3cgYXJjaGl0ZWN0dXJlIHRvIHNlbGVjdCByZXBvcnRpbmcgb3JkZXINCj4gPj4+ICAgIGFybTY0
OiBtbTogU3BlY2lmeSBzbWFsbGVyIHBhZ2UgcmVwb3J0aW5nIG9yZGVyDQo+ID4+Pg0KPiA+Pj4g
ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCB8ICA2ICsr
KysrKw0KPiA+Pj4gICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3BhZ2UuaCAgICAgICAgICAgICAg
ICAgICB8IDEzICsrKysrKysrKysrKysNCj4gPj4+ICAgbW0vcGFnZV9yZXBvcnRpbmcuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgOCArKysrKystLQ0KPiA+Pj4gICBtbS9wYWdlX3Jl
cG9ydGluZy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEwICsrKysrKystLS0NCj4g
Pj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0K
PiA+Pj4NCj4gPj4+IC0tDQo+ID4+PiAyLjIzLjANCj4gPj4+DQoNCg==
