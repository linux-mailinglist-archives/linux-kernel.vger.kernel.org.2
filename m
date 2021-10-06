Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23703423A8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhJFJcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:32:17 -0400
Received: from mail-eopbgr20079.outbound.protection.outlook.com ([40.107.2.79]:38343
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229824AbhJFJcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:32:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us5UnvnWro+zEmsVVBD4ejc8IOdTJ7KVqkFSIyzav3fDix6ygEUayzf+siJA2FzVIdUjozuqW0lXuEaofRQjjWKIEIjxqLCsUehHeLNcp1gAoeRsa5lV0SAw5A62Ly4nOzAIRKNslyOxAtOYwhpbUAZZwr8mj5oHO3H92ZOY2U+hE/83XtOxkpGvLE4b5qnRosswqkk8T31zKP0xxwn65/OiIjhi1Ub7OFl4kyk7h8QR/YXlp9dziQRFzmKfRhmeWyJPOLXU120gLl6IJDAkgfcRDBzHaH3CoZb89YHjHWJgl9yFefwGM1+LE9LBsJ3meVGb0e1HtOBJgLtZGGtgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y0Z0FIvUXkB0fBNjt3ScjAkR+6+ytEGCI3ZY7ZIkik=;
 b=idbv8bJNfc32kxPxATkbY3K1EeiCtFOPZOxVlDSV8tTdbtLTq+U/uSd1j63LpKVNJbgGdDfreTzhaW/YxtFWmfCyVwX9/o4ucL1vJbYWJq9eQxMbcH/tITv/yzC70u32qjkiR/uBUIRs2vSQ26JFduYVTpELvyXl5Fn/HE81rWkh4k9oMjlrSXT60D9ynnk12tijDuEWiDpdAS4nX9uOUZXi0oLzSx7coXEnCPHMXvXpSye6hh+YXugLctQOCyW3XXF/j1R3M9Eq48zO6JVl63IKSdjcJvoaVJh5Omdv85qwdF5Ua01s4TbiX6pX1nGta37Y/xh0b505Pc3kSld2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y0Z0FIvUXkB0fBNjt3ScjAkR+6+ytEGCI3ZY7ZIkik=;
 b=wOJ1g4WTKjjLCsUicRdGTquYm/FgBb/MEsNj7j2Xg7wJkKa07S2n85EUL3NcNfbZwROmhjIqD9xNwz6rLPF4Pgvkmhha55yGbmDPIfkcQOYK9BNmqmVHBSy0oycb8+X4OVxuAwFVXNgZJKwuGlkQSfomx9x2WTnfkZRc34nVMWQ=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB7PR10MB2171.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 09:30:15 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 09:30:15 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
Thread-Topic: [PATCH] drivers: mfd: da9063: Add restart notifier
 implementation
Thread-Index: AQHXrqpI0LoFC+MHc0+B+6k9QHIUIauzTVswgAAUm4CAB616wIABMx0AgAArEQCABmU8AIAAMeyAgAF704CAAUpnYA==
Date:   Wed, 6 Oct 2021 09:30:14 +0000
Message-ID: <DB9PR10MB465270EA5D6F25C44E68D1E580B09@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
 <CA+zEjCtQN6c8bikg620PQwoPzJ6T4wGLvzQ413iPs1tCeHif0Q@mail.gmail.com>
 <CA+zEjCtVxDkg8K0iK32j4KO+Wgt+hTjXD15HdRhNeCV2Sjpckw@mail.gmail.com>
 <DB9PR10MB4652294AB444536BF57E320A80AE9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCsf6m8cctHNPBxJczg-J9XC-piAcdtNDO71qmtCtDj9gw@mail.gmail.com>
In-Reply-To: <CA+zEjCsf6m8cctHNPBxJczg-J9XC-piAcdtNDO71qmtCtDj9gw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1a20de5-8dfb-48e2-1700-08d988abe751
x-ms-traffictypediagnostic: DB7PR10MB2171:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR10MB2171411C0B9F88EE0E19BB69A7B09@DB7PR10MB2171.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ae9Jh928JGWhrv1PzX2E/2GmPK3bgKWD32pqJ3l+tX2bdUfy0PJhzlMa0Li5hpsTM0zeLUVPled/Vw62A5jBgfo1cPyDBCHOULHmOiOVANV+Vhr/3eWsv3VS3cy3ZqoQl5oOEX+rrKH8e+xrmOSpvk680/DHeumCSRPNVd/CmsF7xqI1mJtoejkQIEOsi4fDQkw7as4Ncqm8O8a51PkiCsk37Z4Qwm+SQpyvP2cHAD7C3ubX9s4dzLbyTZZ6enSf27qqoZrywpbnxqKIWcY77i2Jf+7/6KHMKBIs/7Sm0HNqsRg2FzdA+mysxuIbjeq6Rgedx5gNdH4vF7Ns2iqEUp8633IEHv1NnUobRvXjYWg9xN6g9mjrwQCS5/bA/OAmP4uXu7FVDSvJ9BbbPooTC0tgj0IE+yFF7R28Z4YK3bLwTrW6nQb+q/pE28bpSz/7XDcN8m2jWJj/ydr9hwutc6+bhUxWmbWGfTzOWH5L1fk3xVEssVa8pG4wYBxhYmHFLsPWdikjs6MO7gTldt/a6lD73OUoPfhARsrckaNxGy9rd0jEBxsntJFCsjXuOAHsznj4qfyuwSXM7LCaaP4XyO5iEb6beTf2QK41muV4rAS8C2fRQ0tDCXXDVQEShQVOKUYq7orjEEB4a9u0oumY4qP1kR0Mwq+cxN6UoRVTcxkY8xIfjz9EEk4BSKMNCID7vBFGxMYvJXlaTev5sMhZgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(2906002)(71200400001)(52536014)(55016002)(86362001)(508600001)(316002)(38070700005)(122000001)(38100700002)(6506007)(33656002)(26005)(186003)(110136005)(83380400001)(54906003)(53546011)(9686003)(8936002)(66556008)(7696005)(4326008)(66946007)(64756008)(66446008)(66476007)(76116006)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk43cXh2aDZIT005eG02TmxvRklUQzRZNGFNd1hLWmtkZEYxRWQ3NUdrQVJj?=
 =?utf-8?B?bWc0czlKbitlSWZaV3A4aC9IbXNXSmVwS0NjcUM0NHlCR092Y0JWd3hhV2VU?=
 =?utf-8?B?N2lDMGxVTkN3aHdTU3ZXbVI0cnh0T1dkaTVuaUd6QlUyVGZCVWVTSk9qU2pm?=
 =?utf-8?B?Q29kT0IwdXRYRzYwRHNOUXBaM1VGTW80ck95NUgrNmh4YWxRQnpqbVRwN3VR?=
 =?utf-8?B?RHJhN2FKZHBUOVJYTEhFUXhlWm10enp0MCtnQTRBajQ4cmlBKzAvQjJ3b2sw?=
 =?utf-8?B?aXRUUTVIU3V5QjB5UkE3elJXWG9Gd0haaERxanhDSzFXenlhMmJiY200ZVVD?=
 =?utf-8?B?djRRT2J6TVVYS0hQVUR1R0hGY01sZmNiNm9FWmE5UTNDVFRZWFAzZGpqNUt5?=
 =?utf-8?B?cS8xamtvWDROcUk4bTFwL2xPNG8vRTRDTlE5YittRmVkMkZhYXlIRXJEU21G?=
 =?utf-8?B?ZERFQUR0RDJaTkc5bmZsOWJQN0FuTnRPbmN1RjNOZURYWEFlQWY0SWNrajRr?=
 =?utf-8?B?QWR5TmRFR0pPQ2VNU3FnSVFjZElkZGlXVUE4OTZBL1hzT2ZyUTRzeStQcEs4?=
 =?utf-8?B?a1c1bkhEZzhER2tLVFFoSFJUUC9VZnJlZjBHVzhRN1p3T2gvYmRJbXh3N2Z2?=
 =?utf-8?B?cHdKUHo1RWxaTGNPMFpRMENYVXFUT0NTZWZWSTdkTTJmbWVueVFHbEpmMzBN?=
 =?utf-8?B?SVoreE5BcFdKMVduNWdXaTBGeTNxK29sazJITm5CUUR1NmxtY1lSRTVkRGor?=
 =?utf-8?B?ZEpTYS9RNGYxSEZER3NaRE1rV1VUR284dHZTWnZhbE9DLzc1V1BsdE0zTUlH?=
 =?utf-8?B?dGUrMGlJQTEyQzRIUXNpYnRYcXpqQVBuTjEzbFhXTEVUSXZ3L3Bna1MzSWVa?=
 =?utf-8?B?MFd2RWRJa0tzOC9acS8wUDYzL2JEbmxMRm5Lc2lvMHkyZWZXdG81dDdpY1FD?=
 =?utf-8?B?MFA4djRKTjB5N1ExeXpsY3lOLytxcFZvdUhxY3FpTkljL0NVY0RNTS9QSmo0?=
 =?utf-8?B?R0Q0Ni9ja3RHalp6MnRPWGtJNkZGSUFYbGpZbDdkbUd0cG0xVEpvdVNuc0pW?=
 =?utf-8?B?NS8wa2dTUStrUUdiYi9Sd1habVdFbWlvOXNyR1dRd2FvNUlKU2xwU1RqL1VT?=
 =?utf-8?B?T0VmQ0VkR25ockpQLzBHUmlyc1ZFRXc1K0tYby9Qd3JCY25QTTBvRE9YdSsr?=
 =?utf-8?B?bURXdjluYXpaMlRjbzZtK1pXN04vbFFWN2tWdURkMGorUWwrTFY5WHNvVUwv?=
 =?utf-8?B?M042L29RMjhaVnZKb1puUlpwcVZlUUMvNTJaZklTN28rTE1ZTVpxOUgwZnRT?=
 =?utf-8?B?OUExNm5uWUZFK3h0N0prNnRDVmJQdDNrdTZDWmg4cndpdkYrSDJUeWZMaVpB?=
 =?utf-8?B?Z0w4Nkx1Y3QvZTJ6eDZXUUhXekpKVlYzTGJiTEJsekZ1WHNDUUc2Ukx4TXAz?=
 =?utf-8?B?WXFlblBPRGRUMnhLenFVTVpmNjhjUHNlVWUwQmRlVk9nVkp1MkVkRncybkpm?=
 =?utf-8?B?VVRiQXZnbTVFT2tyMmdEaTF0dUNkM3NNUjFwWjJaMWZiSVhFbkMvRy8xaE9L?=
 =?utf-8?B?QmVWcFhGTGlPdzlES1FlREtBRUNmRjVYb2FxUTByV1VvYkM3TzZDbTZQNGZi?=
 =?utf-8?B?aGplRlFVSXlnRXNvU2hvVks3d241cHU1VWhnd29HMEJQRy9tVGhhZTVqTm9i?=
 =?utf-8?B?YzFuaHc1TDhXVzhRSHhMcDlxTW13SXZpUG5RU2FyZlg4SXVZOVZyME5BYkdz?=
 =?utf-8?Q?2e+4Xl7wr8wmx8ooP3TPLgiOyhZM7FQ0VqbFFwc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a20de5-8dfb-48e2-1700-08d988abe751
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 09:30:15.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMB8rgGBn0pQESZMFFTCaqKbPI3+M3sB8xQ0gedwjNdoo5kJJ04NFZ/kGFFT3+yzHtf+bkexuR9LlZepXFPGAmqMOCVkgarfzpSUGCQx8sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2171
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUgT2N0b2JlciAyMDIxIDE0OjQzLCBBbGV4YW5kcmUgR2hpdGkgd3JvdGU6DQoNCj4gPiA+
ID4gVGhhbmtzIGZvciB0aGUgcG9pbnRlciEgSSBoYXZlIGp1c3QgdGVzdGVkIHRoaXMgc2VxdWVu
Y2UgZnJvbSB0aGUNCj4gPiA+ID4gdS1ib290IHNoZWxsLCBpdCByZXNldHMgdGhlIGJvYXJkIGNv
cnJlY3RseS4gQnV0IHRoZW4gaWYgd2UgdHJ5IHRvDQo+ID4gPiA+IHBvd2VyIGRvd24gdGhlIGJv
YXJkIGJ5IGEgbG9uZyBwcmVzcyB0byB0aGUgY29ycmVzcG9uZGluZyBidXR0b24gb24NCj4gPiA+
ID4gdGhlIGJvYXJkIHdpdGhpbiAxNiBzZWNvbmRzLCBpdCByZXNldHMgdGhlIGJvYXJkOiBzbyB3
ZSBjYW5ub3QNCj4gPiA+ID4gc2h1dGRvd24gdGhlIGJvYXJkIGluIHRoZSBuZXh0IDE2IHNlY29u
ZHMgdGhhdCBmb2xsb3cgdGhpcyBzZXF1ZW5jZS4NCj4gPiA+ID4NCj4gPiA+ID4gTWF5YmUgdGhh
dCBjYW4gYmUgcmVzb2x2ZWQgYnkgdXNpbmcgdGhlIG9uZS1zaG90IGFsYXJtIGFzIGRlc2NyaWJl
ZCBieQ0KPiA+ID4gPiBBZGFtLCBJJ2xsIHRyeSB0byBmaW5kIHRoYXQgaW4gdGhlIGRhdGFzaGVl
dC4NCj4gPiA+DQo+ID4gPiBBZnRlciBjb25maWd1cmluZyB0aGUgb25lLXNob3QgYWxhcm0sIEkg
c3RpbGwgaGF2ZSB0aG9zZSBpbnRlbXBlc3RpdmUNCj4gPiA+IHJlYm9vdHMgaWYgSSB0cnkgdG8g
cG93ZXIgZG93biB0aGUgYm9hcmQgYnkgYSBsb25nIHByZXNzIHdpdGhpbiAxNg0KPiA+ID4gc2Vj
b25kcy4gVGhlIG9ubHkgdGhpbmcgSSBmb3VuZCBpbiB0aGUgZGF0YXNoZWV0IHJlZ2FyZGluZyB0
aGlzIHRpbWluZw0KPiA+ID4gaXMgaW4gY2FzZSBvZiBwb3dlciB1bmRlcnZvbHRhZ2UsIG5vdCBz
dXJlIGhvdyB0aGlzIGlzIGxpbmtlZCB0byB3aGF0DQo+ID4gPiBJIHNlZS4NCj4gPiA+DQo+ID4g
PiBAQWRhbSBUaG9tc29uIEFueSBpZGVhcz8NCj4gPg0KPiA+IE5vdGhpbmcgaW1tZWRpYXRlbHkg
c3ByaW5ncyB0byBtaW5kLiBDYW4geW91IGNvbmZpcm0gdGhpcyBpcyB0aGUgbk9OS0VZIGxvbmcN
Cj4gPiBwcmVzcyB0aGF0IHlvdSdyZSBhdHRlbXB0aW5nIGhlcmUsIHdoaWNoIGlzIHJlc2V0dGlu
ZyB0aGUgYm9hcmQgcmF0aGVyIHRoYW4NCj4gPiBzaHV0dGluZyBkb3duPw0KPg0KPiBZZXMsIHRo
aXMgaXMgdGhlIG5PTktFWSBsb25nIHByZXNzIHRoYXQsIGlmIGRvbmUgd2l0aGluIH4xNnNlYyBh
ZnRlcg0KPiB0aGUgYm9hcmQgaXMgcmVzZXQgdXNpbmcgdGhlIGFsYXJtLCByZXNldHMgdGhlIGJv
YXJkIGluc3RlYWQgb2YNCj4gc2h1dHRpbmcgaXQgZG93bi4NCj4NCj4gPg0KPiA+IEFsc28sIHdv
dWxkIHlvdSBhYmxlIHRvIGFnYWluIHByb3ZpZGUgZXZlbnRzIGFuZCBmYXVsdCBsb2cgd2hlbiB0
aGlzIHVud2FudGVkDQo+ID4gcmVzZXQgb2NjdXJzLCBqdXN0IGluIGNhc2UgdGhlcmUncyBhbnl0
aGluZyB0aGVyZSB0byBnaXZlIGEgY2x1ZS4gQ2FuIHRoZW4NCj4gPiBkaXNjdXNzIGludGVybmFs
bHkgdG8gc2VlIGlmIHdlIGNhbiBhc2NlcnRhaW4gd2hhdCBtaWdodCBiZSBoYXBwZW5pbmcgaGVy
ZS4NCj4NCj4gRkFVTFRfTE9HID0gMHg2MA0KPiBFVkVOVF9BID0gMHgxMg0KPiBFVkVOVF9CIHRv
IEVWRU5UX0QgPSAwDQo+DQo+IEJ1dCBJJ20gdW5zdXJlIG9mIHRob3NlIHZhbHVlcyBzaW5jZSB0
aGV5IGFyZSB0aGUgc2FtZSBhZnRlciB0aGUgcmVzZXQNCj4gdHJpZ2dlcmVkIGJ5IHRoZSBvbmUt
c2hvdCBhbGFybSAqYW5kKiBpZiBJIGNsZWFyIEVWRU5UX0EsIHRoZQ0KPiBpbnRlbXBlc3RpdmUg
cmVib290IGRvZXMgbm90IGFwcGVhciENCg0KVGhhbmtzIGZvciB0aGUgaW5mby4gU28gd2UgYmVs
aWV2ZSwgYmFzZWQgb24gdGhlIGV2ZW50IHJlZ2lzdGVycyB2YWx1ZXMNCnByb3ZpZGVkLCBpdCBp
cyB0aGUgUlRDIGV2ZW50IGFzIHRoYXQncyBub3QgY2xlYXJlZCBieSBhIHBvd2VyLWN5Y2xlIChp
dCdzIGluDQp0aGUgYWx3YXlzLW9uIGRvbWFpbikuIFRoZSBvdGhlciB0ZXN0IHdvdWxkIGJlIHRv
IG1hc2sgdGhpcyBldmVudCBpbW1lZGlhdGVseQ0KYWZ0ZXIgYW4gUlRDIGJhc2VkIHJlYm9vdCBh
bmQgc2VlIGlmIHRoZSBsb25nIGtleS1wcmVzcyB0aGVuIHNodXRzIGRvd24gdGhlDQpkZXZpY2Uu
IEkgc3VzcGVjdCBpdCB3b3VsZCBpbiB0aGF0IGNhc2UsIGFzIHBlciB5b3UgY2xlYXJpbmcgdGhl
IGV2ZW50Lg0KDQpJJ20gc3RpbGwgY3VyaW91cyBhcyB0byB0aGUgMTYgc2Vjb25kcyB0aG91Z2gu
IFdvdWxkIHRoYXQgYmUgd2hlbiB0aGUga2VybmVsDQpmaW5hbGx5IHN0YXJ0cyBhbmQgbWFza3Mv
Y2xlYXJzIGV2ZW50cyAoc2VlbXMgcXVpdGUgYSBsb25nIHRpbWUpPw0K
