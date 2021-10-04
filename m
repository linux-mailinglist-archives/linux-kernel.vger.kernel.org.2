Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4341D4212AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhJDPbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:31:12 -0400
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:21563
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235189AbhJDPbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:31:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC5bcpUO/PqApLu9Tdy8HlS1F/acpuIir+OnjCM5FHdDTR+G2iQspRCihg05mre+l0nbKxh2eioBulmuo8XHyhQQ4F+2vjC3oeMBSocHiGhc6p4BegxwbKXwLL+h3gMfIPh2Kt8PkrGH5fQt6QxA5gVtcK05uixzSCanMliTIOykG+a1o0UMsTc7lMRuYXV/DJQFDPgnUf3jXW9ZUMJ8GvJV5IuX3/vU0ZrGjviJ2M4trP2CiYXmrRauIxozB2jQT29855meMqSvwmTxKMtgDDWhnbGPbqNCClLO2LldpQmkpUOJa0X4eJgFiJxmd97a6UroWzoPBPG3kAAHIBblhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pG339ZjapXWB19Z+ZaVAI4nBIvw+o2sArSvFX7pqjI=;
 b=ff8pOixpaOmr29i4hof9FN9eJ2PGL0nadwtrbdJka3RMPVhVYb6MiUYE10XmJIUX33ziZzHs03pMd8iYR+6dAB/740AcVnWFlUh7m6out4OiJ4QP2A0b0cxekoWhn4DXCQdg/7kAtYFYbjLbPa0S47/j5SRfwArzksy9pepbk72LIwP8TRnuu/emk0hY/MhVPI/mNB6ttdXfAbjwbhNoda1DDryus9VlfYJowDPjw7czjb1iCHP9K4E7iasaJbCMeXff0Z1HiG3a53WTkkyE5wCoZKqITYqWK381Sj1oTcwj6B24NvoxoZWNo17abb2gXnbhCvjKnnOrG3sicUN/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pG339ZjapXWB19Z+ZaVAI4nBIvw+o2sArSvFX7pqjI=;
 b=IHIptgiguO4usE1U7wYQZLYdPWdvnNPQq0FruhtHSVNgf5rv6h3No4UfZRuIvBGDKxrUPtcYfL2F2Ps4AKhFaujddzNj18OpO4S3SeA5NDHRDBwz2ut5HI8ZpMXPaCLf3LI8hqPXorsQ42sViJUgyOoC/XQh9qxzdPLf3qnX/Pc=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB3593.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:140::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Mon, 4 Oct
 2021 15:29:16 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 15:29:16 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
Thread-Topic: [PATCH] drivers: mfd: da9063: Add restart notifier
 implementation
Thread-Index: AQHXrqpI0LoFC+MHc0+B+6k9QHIUIauzTVswgAAUm4CAB616wIABVcUAgAahx9A=
Date:   Mon, 4 Oct 2021 15:29:16 +0000
Message-ID: <DB9PR10MB46520380861FA72192C0740080AE9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCv8tExoZx309qRMe6KCZ=-AC+nCOV7qivJWE5gCqrd2MA@mail.gmail.com>
In-Reply-To: <CA+zEjCv8tExoZx309qRMe6KCZ=-AC+nCOV7qivJWE5gCqrd2MA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee42a420-e37d-4cd5-aab0-08d9874bb9fe
x-ms-traffictypediagnostic: DB8PR10MB3593:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB359398B59E453959FBFBE13CA7AE9@DB8PR10MB3593.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVEPKYExSc1mQVPX8g5VpzEBrLo0iWfj2blPC4Mxg20Af0Vp0IOxvZNrts3qh/vagUXO6kwScZO3vz/K/y76NrJEVE+a7Vb+i5PzXPFsWDsk5AW2CORc8HOfU0/E/1m816NxyeLMqxNUfQKH0/z7B64zjsnGQaX6gPWvJ3ekZYRmlNBsWTALq6phq6WANItD0PybArjAWXPMUAAWp5DANJy/j3q0JlnwixJRynMh/TRYVOztN9HPzXhlhIbxccJMSUNlK2mFLzY6K7JWfsum8EtmeN6QShZRa//PtHFJbzaqBI3rhAkaYAEETPEUYiLWkw7x0tseMALxO06FtS0zcisiuBKAZ5SOTGMNLOw9/qtgvaPsPwt4bMxaNtX6fYLrbon7VjTfoZOSsMfctjQzvVluie4T+BY96kgRMYhoSKL4gT7KQeeLnHF8w9+pyJ7JTlO2Xo8ArEmHAqAopx9+zxGz7cYckv47fjP5ZD3iUJuzd4p+eJI1p/OGLkFmLy14Ds+4+4jFsuKj7BdW5Aq10/5BXGU8LAZ8FnFGMLgAmdincPIXod3SIc8FOfEI8WDr+8pssjtb0BOtureH3u6ISJnzjTLmdwnczBUiNA6d0u4opkAjf0wJDrzWElOxG0QWL+uPRy/r9MLlLRENWkIHnon2KlNqQpk4huaYmLJtrV1Y/S8xKE3MfHpjb5uqpGwn+3P/nkeZdXr0MsmWLbtp9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(86362001)(54906003)(110136005)(52536014)(71200400001)(508600001)(5660300002)(66946007)(55236004)(7696005)(66476007)(8936002)(26005)(66556008)(64756008)(66446008)(53546011)(6506007)(76116006)(9686003)(33656002)(186003)(38100700002)(55016002)(2906002)(8676002)(122000001)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVJFd3ZnT2p4cExndC9HNjlBMlZvZ1lWd3FiZ0hiSFM3b1o5dWg0VWVZMXlM?=
 =?utf-8?B?eTdjMVRxRUVhSzN5SFJLV3NzYms4SUs1MUtHT2ZKeHo2WWFsa1Rrci9EMWN6?=
 =?utf-8?B?THN2UmdpdnVhUHNGdjZVRUFybHE1enI0TEJSZlM2QVhqTDg3dkZreGxMNnlk?=
 =?utf-8?B?ckRBcVcrdkw5L2pDWUFRNUxob0dhRkJ0TGgwaXd4WkhwVUVMTzJUQm9mbUxm?=
 =?utf-8?B?RUsrV3Y2ZW1OWEl1V29yRVJmem1UcDBvYXU2a2o3VWZOSytxODZlQjdYa05q?=
 =?utf-8?B?dm5VRkJDT05hV0NMTWcvdUpid0hKR0pjbHZocVp4NVNqOWpKa2liQlVJbjlS?=
 =?utf-8?B?NWdhNU5HbWhTMXROaThocE1qMFV5UXBYZWQ4aUk4S1hUTENDWFpIZlZucU1I?=
 =?utf-8?B?a1lYNFA0eG13ZWozU2xLcVVvMCtKL1JkeUloSnFXWldFVWs3NXAzd0JGc25H?=
 =?utf-8?B?My9zOS9IVHVWbjFjUGh4S3JBdnVvSFJCQ1dtK2R2dHlCVWVxeE8vdThDdEdo?=
 =?utf-8?B?akZpOXRXTWR6M0dZcjg4Wmc4YzRLMXdCckU1d1BJL01yT25aTFNNZEVlZTda?=
 =?utf-8?B?NkxFeGdpU1J6UWNaL3dCTXUzR1duenlhb1pvcjFYbVNqaXdvS1JCNzk1Mktt?=
 =?utf-8?B?YmFsbkpZNk9xVnkxWFR6a2hSVGVVV1BGTmwyb1oxTGVaMDlpTmQ5SEtJRGp2?=
 =?utf-8?B?T2s2YlZXVXJsdjlhWUphcGJDMHEwLzkwSDJtTGNKNGVsV3BFTFAxaTRUdEtR?=
 =?utf-8?B?UEQzV1hnL3lzUTBlNGs1Zzd0TGI2QXQ4TDlGSEVueXRHVnBHb3d0TGJ4UDN5?=
 =?utf-8?B?WDF4S3ZCcnJaQ1JUUHl6YTY3MC9OYzZjUGhCWnV4R1RDYng1ajZ2NVRIeE9u?=
 =?utf-8?B?YlpwNGs5eFA1VG9wY081QlFFU1owcXk4aFZ4Y0V5ZmtmTjQ0ZXc0NVh2TzZv?=
 =?utf-8?B?MVZsRE9xVlFTUk96elVnWXQ1eXlMY0RHZFFNNDA4am5TTkdaSWRJSXlVK21r?=
 =?utf-8?B?Y3R3RE1NbHlwdWkzM0NQL0ZCVGp2aE9rR3Y4VktUTmhoKzhSTUttT0FqcDVw?=
 =?utf-8?B?WkNvRk9zcDFSZTBoU0ZTaDcwUDk2bTZEV25QZDNoN3lkR3hKRlhta0tKS2Zj?=
 =?utf-8?B?akNqdTU1WWNKWDdERDEveFplVHJmMm9oZHpCZ3gvR2xVdllJS0FiYTRFUUtJ?=
 =?utf-8?B?VjJPN0VWS0FmVlp1Mk15cEg1VzBzblBpK2ltM3l4RlcxeFQyL2dRVmUxS0xu?=
 =?utf-8?B?MkwvMFo2WklLR0t1L2xsNEx3K0lkc29IcE1jb2pDY2V3N0hIQ2VrYnpIdTFv?=
 =?utf-8?B?L3gzZDA3VG9ud04vZTZsY2xJcE8yZTZVNTlIZ2FwNnNlckJrV0NVMk45RUhy?=
 =?utf-8?B?VUcydk5hZEJnd3hEOWsyckZDMklydWQvUDRtb3g4QThpSk15SHFtdVNrSUp2?=
 =?utf-8?B?M3VpUTNoV0xIMGxkWWtXV3d4OWxBbzlIcXVIM2IvV1RzR3JTY2xUV1NLbU0y?=
 =?utf-8?B?TE0zS2ZRYkZtRm00cEpkcTBzZTNtTkorbWlmWkpIQVIyZk9nMTJ3aXZmS0kz?=
 =?utf-8?B?N2VZbnBkbGNVUWtkWTE5bksrK3ByamFsb3UrSUduUFVVSjV2THM1NThQZUJn?=
 =?utf-8?B?MUovTG00MkZxcWx4NVpKcTVYcEJNTnJGdzNVRWROdllOcUtVbW40bUNOWWRQ?=
 =?utf-8?B?dERheFVuQS9VUXkxUFJ1S2JDcEhIN1VhcXdaWjk4UHE1bUV1RHFWWC9kdG5K?=
 =?utf-8?Q?FT7rjHsW/zk9W31JGjTi8xiJyk0NkZDYz9PcFjf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ee42a420-e37d-4cd5-aab0-08d9874bb9fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 15:29:16.1511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4avOgBv6ZERNQb1sxPMiSSjUSV2Nj38Mt3RrfwEOKULzUtTKfx1ExnnV5AjqoGz+xXnnIMXOETMmHt09S0yPIdH4GlQmH59Ww/F70nYKDm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3593
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAgU2VwdGVtYmVyIDIwMjEgMTA6NTUsIEFsZXhhbmRyZSBHaGl0aSB3cm90ZToNCg0KPiA+
IFNvIEkndmUgZGlzY3Vzc2VkIHRoaXMgaW50ZXJuYWxseSBhbmQgc28gZmFyIGl0J3Mgbm90IGNv
bXBsZXRlbHkgY2xlYXIgaG93IHRoZQ0KPiA+IHNlcXVlbmNlIHlvdSBwcm92aWRlZCBhY3R1YWxs
eSBwZXJmb3JtcyB0aGUgcmVzZXQgYXMgeW91IHN1Z2dlc3QuIEl0IGNlcnRhaW5seQ0KPiA+IGRv
ZXNuJ3QgbG9vayBsaWtlIGl0IHNob3VsZCwgc28gbWF5YmUgdGhpcyByZWxhdGVzIHRvIGFuIGV4
dGVybmFsIHBpbiBzb21laG93DQo+ID4gdHJpZ2dlcmluZyB0aGUgcmVzdGFydCBpbiB0aGlzIHBh
cnRpY3VsYXIgc2NlbmFyaW8/IEknZCBiZSBpbnRlcmVzdGVkIHRvDQo+ID4gdW5kZXJzdGFuZCB3
aGljaCBldmVudCBiaXRzIGFyZSBzZXQgd2hlbiB0aGUgYm9hcmQgZG9lcyByZXN0YXJ0IHRvDQo+
IHVuZGVyc3RhbmQNCj4gPiB3aGF0IGRpZCBhY3R1YWxseSB0cmlnZ2VyIHRoZSBib290LXVwLg0K
Pg0KPiBBZnRlciBjbGVhcmluZyBhbGwgdGhvc2UgcmVnaXN0ZXJzIGFuZCBhIHJlc2V0IGFzIGRv
bmUgaW4gdGhpcyBwYXRjaCwNCj4gSSBnZXQgdGhlIGZvbGxvd2luZyB2YWx1ZXM6DQo+DQo+IEZB
VUxUX0xPRzogMHgwMA0KPiBFVkVOVF9BOiAweDEwID0+IEFzIHBlciB0aGUgZGF0YXNoZWV0LCAi
U2VxdWVuY2VyIHJlYWNoZWQgZmluYWwNCj4gcG9zaXRpb24gY2F1c2VkIGV2ZW50IiA/DQo+IEVW
RU5UX0I6IDB4MDANCj4gRVZFTlRfQzogMHgwMA0KPiBFVkVOVF9EOiAweDAwDQo+DQo+IERvIHlv
dSBuZWVkIGFueSBvdGhlciBpbmZvPw0KDQpTYWRseSB0aGF0IGRpZG4ndCBzaG93IGFueXRoaW5n
IHVzZWZ1bC4gVGhlICdTZXF1ZW5jZXInIGV2ZW50IHdpbGwgaGFwcGVuIG9uDQp2YXJpb3VzIHBv
d2VyIHRyYW5zaXRpb25zIHNvIGRvZXNuJ3QgZ2l2ZSB1cyBhbnkgY2x1ZSBhcyB0byB0aGUgdHJp
Z2dlciBoZXJlLg0KVGhpbmsgdGhlIG5leHQgc3RlcCB3b3VsZCBiZSB0byBwcm9iZSB0aGUgdmFy
aW91cyB3YWtlIHJlbGF0ZWQgcGlucyBvZiBEQTkwNjMNCnRvIHNlZSB0aGVpciBzdGF0ZXMgZHVy
aW5nIHRoaXMgcHJvY2VzcyBqdXN0IGluIGNhc2UgdGhlcmUncyBhbnl0aGluZyB1c2VmdWwNCnRo
ZXJlLCBhbHRob3VnaCBJJ2QgZXhwZWN0IHRoZSBldmVudCBiaXRzIHRvIG1pcnJvciB3aGF0IHdh
cyBoYXBwZW5pbmcuDQo=
