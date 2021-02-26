Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E86326776
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhBZTdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:33:40 -0500
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:50208
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229545AbhBZTdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:33:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU2ROT9Aso8+lHchjvd4j8+cwj51O9I1SclKMwcUl1NEAktmP9nBDs14fWlc3NoOHvlnmR0ow9RTFuHBPYEskqWxuWdOP9wPHwY2V7pAeP7hBi3j6oE555z3SPa/4pU+PXjVB5HePlwze825ceOzHNM1m7seqIcQkOkBJLJ7ZMhr3tqKqproy7HSxD4hJYRLqdKKkJz+Dw04g7KXEE2VOe5aLVPGt+MFzgZwM0hLc4+xVCgrlv+fah+be5L50BdHP7V29A9daZ7V9PfzLXmFT92clZLXMHqUuAQxXyg+K0AU55vRGIqzTaEVc+OKLN4j5lB+Ijo8gqNhyEAYBphmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLTRQFueVRhAB0K40qdJE/0p9R/1Wtk230ZcsqWFPQk=;
 b=gmUzY5g5OcgnE/v3c8ChInnAjVZKLkrcaGUD9EoK3uFOpJrhiOoqK2TRQh/xWfsH7LZiBulptbaJ/ovKeTPVPcEw57/SrFHMEnk62YMiNoy2O1HeuDZpENQbLrteib+K+qxgemi71CbwpVfVSgrMTHlKuRDgiqt5gSqubKsavBOohM8GuMZ8f9ftaxlE5Q/P74D4RZ8aGsGqfGhP5MDhqFn4/dsDvfCEn7ER91TZbBoeAr5EhCddNHcTVnBVgQWnVgFLt/KUP5m80IdqjF4gdFInqfk/Mj/1IF65viRfG1RKetZMh8BCfd7aG38LFP8zc96xVJRjpdbM6uMtm4N5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=visionengravers.com; dmarc=pass action=none
 header.from=visionengravers.com; dkim=pass header.d=visionengravers.com;
 arc=none
Received: from BYAPR01MB5621.prod.exchangelabs.com (2603:10b6:a03:118::32) by
 BY5PR01MB5779.prod.exchangelabs.com (2603:10b6:a03:1ce::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 19:32:42 +0000
Received: from BYAPR01MB5621.prod.exchangelabs.com
 ([fe80::c4cc:6fb9:44da:e2dc]) by BYAPR01MB5621.prod.exchangelabs.com
 ([fe80::c4cc:6fb9:44da:e2dc%6]) with mapi id 15.20.3846.041; Fri, 26 Feb 2021
 19:32:42 +0000
From:   Hartley Sweeten <HartleyS@visionengravers.com>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     "soc@kernel.org" <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] ARM: ep93xx: don't use clang IAS for crunch
Thread-Topic: [PATCH] ARM: ep93xx: don't use clang IAS for crunch
Thread-Index: AQHXDF6daAHoIbKUtEazeMb2p7+FnKpq0PYAgAABKaA=
Date:   Fri, 26 Feb 2021 19:32:42 +0000
Message-ID: <BYAPR01MB5621DC2003DA49EA64AD46A0D09D9@BYAPR01MB5621.prod.exchangelabs.com>
References: <20210226164345.3889993-1-arnd@kernel.org>
 <141f3098744ea8d1cc39abcdce89c0e513bfbc70.camel@gmail.com>
In-Reply-To: <141f3098744ea8d1cc39abcdce89c0e513bfbc70.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=visionengravers.com;
x-originating-ip: [63.230.248.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5adf1bbd-676a-416a-4dce-08d8da8d4915
x-ms-traffictypediagnostic: BY5PR01MB5779:
x-microsoft-antispam-prvs: <BY5PR01MB5779019AF9CF17B1E1AFECBED09D9@BY5PR01MB5779.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BTCSu9be5eLB8ZVIFygNk4Juzma/ElYzCmn2x0tpFg/g5QQjarX9Q1Jd1ShkZ0ghyf8F47SsQTYghTTwRWNQ2LsVZnKCRBbMYmJUg9/uhj7nYQ+IxjsS+Ka7c2WZOre5YXrOy+S8rgm2tB1ZBXx/OGKTAh6qZkZxjEMMWBU6VVQFEX6SsAydR7WWU6p7UBzuRF+arql4PCCunb7smm6c5k5T+dQUo5nFSzPUqD+RDHuAOFcA7IFjetrnLRz44QpkVlnBliDLw2/DWoLosA4Yyp+SaQByd0BNAlPboChe6nv+h6hvlQW0t5PBY/JSB8HmIraUBLiTyu2ezaUQ0KRkTQBGNepoJHqLheQz3QdwpiCnsa9sWJb8c67wzvg+8iTy/nZzwEh5NdGncFFlv9JMgp+3l/fTvE+mt1UVfjbwuCoiT01w2m3FhXinlulqcRh5rmWgtcVlqR14YZSk1zIDraocNXrn2mLrl+qoWPvn6YlBCSBH10I7NCSw9TgA0yIXsjHbdgKFBWeZWGtdiI8esQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5621.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(376002)(39840400004)(136003)(4326008)(110136005)(7696005)(7416002)(186003)(8676002)(66476007)(66946007)(5660300002)(8936002)(64756008)(33656002)(55016002)(76116006)(2906002)(54906003)(66556008)(66446008)(52536014)(316002)(478600001)(6506007)(53546011)(86362001)(71200400001)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eGVGZFF3TmZCR0NrdkJjU0tkOEU0dEdsbE1TcnRVdlliRVcrdzdEb2xrVVdB?=
 =?utf-8?B?UzVtN0JwbkZmdjFuWlVnTkMrYktpc2t3Y3Q3b1FPZ3kxRFlKYVluL2MzYloy?=
 =?utf-8?B?WVA4QlVWTDZNc3dLelQyYTY5K3hiWHFENk52Rk5GbGE5M2FWRXVDL09YbXFk?=
 =?utf-8?B?K0dqQVlIQitwUzh6akRTRGxzRVlndEZCU3J3eDE0YkxRdTJTTDlkb2ZOMXRs?=
 =?utf-8?B?bjdXQkJMV3l5ckFuR3JhdVh4YUxmcE9Ya21iWHhXTzdiRFZ2OFd4UEVyaUVn?=
 =?utf-8?B?UFZCZmVaQjJHKzUrbmdIZTArZzAxSCtrLyt1QUIwNUNVZkQwZTErMTUyMkl5?=
 =?utf-8?B?TmdzMTJkSTBNUDlFbCs4TWFsWHVmaWNpQnBaMjdiYm9hb1ZhSjZNem9NSHFQ?=
 =?utf-8?B?ME9DcksrZ2Z6RDNGSGgrMXlBSHpoOHVydHFXOGVhbGNOcC9zbWhMa2ZCRldj?=
 =?utf-8?B?ZHB6L0xOcHlHeGZUYUJ2UjYxaCtIYlp4eUQwWUt0dmZBT2drUjBtMnhjQ2V6?=
 =?utf-8?B?WWNYSmVJR2ZKQzh0dDdMdWkzQU5UdjN0S05haGM2MGFnbktQYllBOE5DRzRS?=
 =?utf-8?B?bnJmaXNRTTA5UVFJaW5oWExWVHY5T1ZWTjltKy9XcUNjNnNyTGlmc2hUMGVV?=
 =?utf-8?B?MU9YS1hCQm53bVJKK2UxdFJWTVE3RUhsNzJwQlJYTURGWXRBR0RiZzJoQVRu?=
 =?utf-8?B?Y0NXYzRjTTd5YXRwMDNnV2NpZ0xGRHZBa0hzYjJrdVBtSzJSd1YvbFduNmFN?=
 =?utf-8?B?SUlLTC9FSVMreVF0ekg3czZsMUlGeXRGQlFhakY3QytNSUcyeDlkN2lwV20w?=
 =?utf-8?B?YjNza3RpRWtuMXpSbVQ0N29TTjN4THBob291cFRpdHVwQUNNcG0yT0tBWFQw?=
 =?utf-8?B?NlNtcFkxdzZWeitvUkV0UEoyeitsUFBnTkdSK09aMDVpY29LajBUdUxkcXNY?=
 =?utf-8?B?RUZBSHppck51VnU4SWlIUkl5dW5LK3VsbnBnQ01pWU95SEZYOWJMWmhlYUE1?=
 =?utf-8?B?eldRR2xIcWJ2RlFQT0NIL3V5WnkyL2R6VXZHM1phTlNDUTlSQjdiTEJDUEw0?=
 =?utf-8?B?emlScVFIT0tEQnRqbVJwLzFiRm5yWTZLeC9PaGpzOU9DRjU0amJManZ3QjR0?=
 =?utf-8?B?SStVdjdXWmxmYjlNTWVzSitJTlZzTTA0Y3hCc3cxUnNOWDJOQWJQRmRPcjFm?=
 =?utf-8?B?b05EcFlQK2Z3SjZzQWxreUdOaXp6Y2xFMll5emk5M2lwa2pqWHBZL2xvTi9V?=
 =?utf-8?B?ZVdVdDB1UXU0cktkSFovUStBdlcyS0pwaFZUMHUrSVltbGlQYmNUSGFPNldY?=
 =?utf-8?B?L0dMcDdubStKUVdrTlVjU3p3ZnlqVTZsQUlINWd3MmZUQ283WGpiOEszWFhh?=
 =?utf-8?B?MG5NNmEvcklZanVNY0dEUTFmU1MrZkVCbUZOZ0diWnBScVRUcW85b1pLUEVq?=
 =?utf-8?B?YUtCLzNQWFlGbXRjbVU0eTM1d01oZTdXR1l2eUl6SmtMNmJsS0tPeTVPL1Fy?=
 =?utf-8?B?dkhQUzNIb2ptZytraFh3WjhZYUtzUU5mdmtRWlVQU2J6bUJZS25YaURFdk1P?=
 =?utf-8?B?bEdlM3g2ditpUU5WSVRZUDVJRENuMk5mN0hlZlMwR0s5RmdiMHBBYnlFaDZj?=
 =?utf-8?B?a1A4V1l5Q29mcEVFSFZyT2t5cXlrZkI0dHJYL2RPM1c0MUNOY2JHY2E4L08v?=
 =?utf-8?B?ZkRnRjlJMElKbThJb2dOelJKTmJvY3pKUXVIMHMyVmNiMFZRNllZK0M4c2Nu?=
 =?utf-8?Q?1x70yMGxha/HVbGKMt+b6OM8/88bYZq+cRrLoQk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: visionengravers.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5621.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adf1bbd-676a-416a-4dce-08d8da8d4915
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 19:32:42.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d698601f-af92-4269-8099-fd6f11636477
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wxbxpkg3ioBuT9PFI+BlR4MV3qWdJlLBDObtI2qVws4uE4WUew+kwpLeCmGydQ1gEuTO722H/2Ae3qlhbiDdKfbcSA3KEm/H84dJPvN5FDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5779
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpZGF5LCBGZWJydWFyeSAyNiwgMjAyMSAxMjoyMyBQTSwgQWxleGFuZGVyIFN2ZXJkbGlu
IHdyb3RlOg0KPiBPbiBGcmksIDIwMjEtMDItMjYgYXQgMTc6NDMgKzAxMDAsIEFybmQgQmVyZ21h
bm4gd3JvdGU6DQo+PiBSYW5kY29uZmlnIGJ1aWxkcyB3aXRoIGVwOTN4eCBmYWlsIHdpdGggdGhl
IGNsYW5nIGludGVncmF0ZWQgYXNzZW1ibGVyIA0KPj4gdGhhdCBkb2VzIG5vdCB1bmRlcnN0YW5k
IHRoZSBtYXZlcmljayBjcnVuY2ggZXh0ZW5zaW9uczoNCj4+IA0KPj4gYXJjaC9hcm0vbWFjaC1l
cDkzeHgvY3J1bmNoLWJpdHMuUzo5NDoyOiBlcnJvcjogaW52YWxpZCBpbnN0cnVjdGlvbg0KPj4g
wqBjZnN0cjY0IG12ZHgwLCBbcjEsICMwXSBAIHNhdmUgNjRiIHJlZ2lzdGVycw0KPj4gDQo+PiBJ
dCBpcyB1bmNsZWFyIGlmIGFueW9uZSBpcyBzdGlsbCB1c2luZyBzdXBwb3J0IGZvciBjcnVuY2g6
IGdjYy00LjggDQo+PiBkcm9wcGVkIGl0IGluIDIwMTIgd2hlbiBpdCB3YXMgYWxyZWFkeSB0b28g
YnJva2VuIHRvIGJlIHVzZWQgDQo+PiByZWxpYWJsZWQuIGdsaWJjIHN1cHBvcnQgZXhpc3RlZCBh
cyBhbiBleHRlcm5hbCBwYXRjaCBidXQgd2FzIG5ldmVyIG1lcmdlZCB1cHN0cmVhbS4NCj4+IFdl
IGNvdWxkIGNvbnNpZGVyIHJlbW92aW5nIHRoZSBsYXN0IGJpdHMgb2YgdGhlIGtlcm5lbCBzdXBw
b3J0IGFzIHdlbGwuDQo+DQo+IFRoaXMgd2FzIG15IGltcHJlc3Npb24gYWxyZWFkeSBpbiAyMDA2
LCB0aGF0IENpcnJ1cyBpcyBub3QgZ29pbmcgdG8gd29yayBvbiBDcnVuY2ggc3VwcG9ydC4gRnJv
bSBteSBQb1YgaXQncyBPSyB0byByZW1vdmUgdGhlIHN1cHBvcnQgaW4gdGhlIGtlcm5lbCBjb21w
bGV0ZWx5Lg0KDQpNYXJ0aW4gR3V5IGRpZCBhIGxvdCBvZiB3b3JrIHRyeWluZyB0byBnZXQgdGhl
IG1hdmVyaWNrIGNydW5jaCB3b3JraW5nIGJ1dCBJIHdhcyBuZXZlciBhYmxlIHRvIHN1Y2Nlc3Nm
dWxseSB1c2UgaXQgZm9yIGFueXRoaW5nLiBJdCAia2luZCIgb2Ygd29ya3MgYnV0IGRlcGVuZGlu
ZyBvbiB0aGUgRVA5M3h4IHNpbGljb24gcmV2aXNpb24gdGhlcmUgYXJlIHN0aWxsIGEgbnVtYmVy
IG9mIGhhcmR3YXJlIGJ1Z3MgdGhhdCBlaXRoZXIgZ2l2ZSBpbXByZWNpc2Ugb3IgZ2FyYmFnZSBy
ZXN1bHRzLg0KDQpJIGhhdmUgbm8gcHJvYmxlbSB3aXRoIHJlbW92aW5nIHRoZSBrZXJuZWwgc3Vw
cG9ydCBmb3IgdGhlIG1hdmVyaWNrIGNydW5jaC4NCg0KSGFydGxleQ0K
