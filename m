Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970B842A230
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhJLKfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:35:03 -0400
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:45791
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236013AbhJLKfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:35:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKo6pidOwtszfnzKQ0NqQ+YD8ceCXWOAt8C0pOxfw51bAx4BEq2ujNN95ttuUmdriJ6Ljfv96OD1rncKC/eFAXK8dZcR6pNKr4PctQAihe4vYjijJ5trXSZyYYLzgi9z3VQ7Y1bycQDA4M31B+/HHFkHDRA1cB3mJfxmGzdXaoRDN/1DCnl7kyJ7fgSNG7YtJyFp0T+KYM+G+ZnfPHUnrCXGZLJyyOM4FaMurAW9s6mMfPrtf7RcirhptETpdqiO2fEEwPFoJXyRSQmIjyZjMt7P8tVxSiVQPcPDDJMueGUEePlj0Syte58Byem1wlJS3elTEJGNYHY7XR9rNuWznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFwJ+sL4uEqo0wiyM9wW9xekOHGisycBC10Izb5UlAs=;
 b=KdhubP5cVQzQzB6pxnXnbjOuxr2XDO9Q/MbbNTpOiOAfBtauEJX3grkbLUEsMxiyBN4YreEZ8E1u4q7N3Al8vT/Cif12ewBk6ovtlyhu8hgKkuqL7jHv8eNP7wjIfEFQM5QX1GRyA3wOs/pZGd4i7j2l/kUC3hKlxiBLN7J5wsmLiYkcUpsANnjUkLQVLnYLmhPzMSEKNJrsPBGnNRnFHx7FRIXgT3fDXEzFWpvb/B/dl9FbfDSn7hh6TkbjMHnfz0SKOicnZhQcHtFjWTa6FbLNK6JKc97pCntWlmPKwBSWrDqdSPVXfAh3SyQAE8o1QbxuZSEVR+k1+c6wNDijkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFwJ+sL4uEqo0wiyM9wW9xekOHGisycBC10Izb5UlAs=;
 b=ZjIS5cN6KfMzrfUi73kzIrnDSESwFqeLLJmW6k3vZpdoAPNHX3PAmNMoxfjLTQRjCvn34SWchX7LQFhRoWMe1R8YYkJVPR8lPbaLPRU9tite6RQzn+O2CH/P2falz5HAB3QEJxD9JmXkID/8NdFcf8nZJVkE9kmOmswNcKTO9qY=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR1001MB1046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:5f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Tue, 12 Oct
 2021 10:32:53 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 10:32:53 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
Thread-Topic: [PATCH] drivers: mfd: da9063: Add restart notifier
 implementation
Thread-Index: AQHXrqpI0LoFC+MHc0+B+6k9QHIUIauzTVswgAAUm4CAB616wIABMx0AgAArEQCABmU8AIAAMeyAgAF704CAAUpnYIAAJDmAgAMFyyCABlaakA==
Date:   Tue, 12 Oct 2021 10:32:53 +0000
Message-ID: <DB9PR10MB46525FC6EAF1610178A20B7580B69@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
 <CA+zEjCtQN6c8bikg620PQwoPzJ6T4wGLvzQ413iPs1tCeHif0Q@mail.gmail.com>
 <CA+zEjCtVxDkg8K0iK32j4KO+Wgt+hTjXD15HdRhNeCV2Sjpckw@mail.gmail.com>
 <DB9PR10MB4652294AB444536BF57E320A80AE9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCsf6m8cctHNPBxJczg-J9XC-piAcdtNDO71qmtCtDj9gw@mail.gmail.com>
 <DB9PR10MB465270EA5D6F25C44E68D1E580B09@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvFO6Tz+D42wgnstx_TLNEt=HM0eeT5g0-zwaEscGj2vQ@mail.gmail.com>
 <DB9PR10MB46521072770D6A1C75DEE08380B29@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB46521072770D6A1C75DEE08380B29@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: diasemi.com; dkim=none (message not signed)
 header.d=none;diasemi.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff39e06d-23f8-4d58-7b84-08d98d6ba5ed
x-ms-traffictypediagnostic: DB6PR1001MB1046:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR1001MB104610E9B3746038B521E3A4A7B69@DB6PR1001MB1046.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qrc7NtQnfgxsYcqXFdtIhw6ohIbC1OGQN2fpJmvL1gvg1VukU5uBAjFkpmdE5+U8Y6yftif/kMMqANsC9itrAkDljOXWdMLlgNnFek+06PQjnlblZubKXPPfIMIonbFaz4BfKp3LEeZV2QjyZtsEIP/3fedIQRSXhGPwpwNq2DAGCN22nF2V0VNPOKG8QpQRCaxv6SfcU1ASZQ+qt8AwLUO6XbRa3Hm2NisvgQWqluZZp/c8XENrvDuzxmdaLqPN7KIOeTYcehlpGsXY3WR3lKUTBYhsZOQJMjgpV0uK15DuUCK2NSsJA2x/zZhidGKynSkyTFxFO14B9ESFS41N7rcMoY5G2ubmEkO30aMr3Po4rA0opgUP0gpFnVmuPyI1l0LisH5xP2mpkAsDhNpPTB6b3+giXxl42p1Q+rzmh+619SiLUa2Fi6Q3wx8zG/DrNSe1FysPI8itN7dWoWpl38h9mNItoan71mriVfRG9uE/ukO4u3/1jxx+YEXvxMiBtguGEJTrzkXsdDQicBKorrJUFuJz2HzTDcHa5kwzZYNP/btIR9qUfnZS5I61BObYnVHAnl4Lrc1ntrtci8s2EvWWMeI5ilAdkmnJRnQ7eU8rGcH4f80VN3xhlvU6/0viYoWtmG+ekvoQoXWyhYaroPxYrogz52U+xJwcnqQkm2DzPejMitpM4TAAPlxto7zJRK9kjqMOmMr+krkML7wvw+vyMfeoAKrcVa/BDQDryHUAQxW062pZNOTKFN0lVOhXiyO0/mZ7PyuxJIjAMknyKnSH+rBb15R62/TK1o4SfI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(122000001)(508600001)(7696005)(66446008)(66556008)(64756008)(53546011)(66946007)(66476007)(6506007)(4326008)(71200400001)(26005)(186003)(966005)(38100700002)(83380400001)(54906003)(316002)(9686003)(55016002)(76116006)(8936002)(33656002)(8676002)(110136005)(86362001)(2906002)(38070700005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTk1eHFPclhCSjhWZkRRcS9uZ2xoZXFhd3g0NXd1VTgwanpRaVhGZVUvUTh2?=
 =?utf-8?B?K1p5eWdxVDkxNk8ydnNWUGgzNkRvVVVlVlFMeGRlbitZZDZFc1EySUw4bzlN?=
 =?utf-8?B?WE5UUmpJUkhqdkRxMVdnYkhlM09GeGgzYnlNU0o4RmNNekYxMDdDM0J1S25V?=
 =?utf-8?B?WnVwUnRuTW1wK2w4eDdKdHhpY2t4bmE3clJqMTdOZWhqdFVGMUhhOWdXWVcz?=
 =?utf-8?B?ZUtxM2lFdzhWR0c3V3U1dFh3S2dZVWhiV2dsWUZsS2xmWXZUcXprWUVoZmRI?=
 =?utf-8?B?K2FBSE1MKzF2bmQ2WnVYVU9YODlYWWpTZ01uaUZkckFKS2cvK2oxZ0pLa1Vz?=
 =?utf-8?B?bUthOGFQTmc1N3B6R1hxY2d2MHg0KzVCelNRb0tuSkl3bmlCb1RodERhRW84?=
 =?utf-8?B?YVFaaS9YMU9LK1Y3S282YXRjVTNpNkFvait6blBIMEk2dlJkOFlTWGI3ck4y?=
 =?utf-8?B?dHg5UnMvbFRJdk4vWG93bVJQUm0xejROeEgyTWhhOWk1MEFYeldnemdYeDNV?=
 =?utf-8?B?UmlpNGR1SjNGUVNoKzV3Ukl6cnFqdGQ4Y1FDNGRHZ09CMUtnK0M4R0tJZ2FB?=
 =?utf-8?B?blV4VittaGFRZnlFOS9HZGp5R2p3bFJ1ZzhnMDBZYmlLSU10NnlPL3RjQnk2?=
 =?utf-8?B?UFVESXNkSDZQMURvZmxsZXJYZVBycnRVTURDQ293dTg3WWpjL2t4cFlFUnFn?=
 =?utf-8?B?N1dlbG1jeGtONFJ2ZUdUSjZUMHJaaUlKQVREdkNaTENSTlJWOW9XMlord0JC?=
 =?utf-8?B?VkVzWDFkdHo3c2t4Ylg2cGxKYVhyTjQ2OTh4U3JCdS9rcUtwa3lJcnVhT3NE?=
 =?utf-8?B?bldNSmxQTklYTTZabUJuTklqNk1jTXl4UXpWZDl5UDVvc1g5a1lUZ2c1RGZW?=
 =?utf-8?B?cFFPSUdzYXJxcHY3WjljVmpzUXlWc1ZFMXJqMVQzWGZyZzczUlNTNU1kZ0ts?=
 =?utf-8?B?RVZSVlJNbk9SNDNzc1Y4UU5lTmVYdlVpc3FJaDlNKytVbFIwc0JXNlVvc3gr?=
 =?utf-8?B?OGVFeTZ1b0szZjJ6OC9hWkhRNlNHemlYeXp4ZVNucFhjMHFDMWMyVlJqUElI?=
 =?utf-8?B?Y2cwOUoxbnVBeTJQQm01dE01TXlCYUpEMmNMNFIxUkJDU0pwZ2M1QzFVR0Ux?=
 =?utf-8?B?WWJ1aDJmUnl4ZzcwOTRjYjBabGNsaUFDS2Z3cWZFOEVOdzR5L0pJNEpVQ1lq?=
 =?utf-8?B?SUdrZEZYdWRMU0VsU1VlL2tQQkJDU1Q0MWRVclQ0cDFYT0d5SDQxam5qMmVn?=
 =?utf-8?B?LzBTYzQ0elJVZm9QQ1B1KzRaZ1I5ZGNZd0QybjZrcklUeG94MFFMYUxQZjF1?=
 =?utf-8?B?ekRLRkFYYUg4NEFBbDRKMGxwRHJUWlNxNytMZkQxVGpGT1hZQ1RsTGRCcEtX?=
 =?utf-8?B?OXZtL3VycVU2VHV4TW5Da3R2cGFVVWZ0M1V6VHpSN21KTVRlM2svMHE1S1hD?=
 =?utf-8?B?cGJWVEpjU25RY0RNZTVhd3RMMTNiV3pHMEdyeEllQmg1blZZOFdkcTZELzl3?=
 =?utf-8?B?d0hGcVY1TWtlT1VHL2Z2a2R0Q29sVTErWHdRREpMUERRMjF3RGtOQ1k1SnRi?=
 =?utf-8?B?dlp4OTM0ZUxRMkxzTlVadThQQ2piaTJ5c0NhUzJRQXlHRnA1MTdrQ2dqQzB1?=
 =?utf-8?B?QkcyWDNVUGd1eDZ2bE1Eckk2SklWczhUUzBiVzdzRFpnNUF4cXU4TGdPMHdZ?=
 =?utf-8?B?Q0hCaWhuRUZYNlpGNmpWTHZkcXdzQS93Rk5nMXorR0JiNFp2dVRTYkJNejFS?=
 =?utf-8?Q?09tpz+VeGRSo93XBn3FQIo5szi1RXwxzX7g/k5W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ff39e06d-23f8-4d58-7b84-08d98d6ba5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 10:32:53.3531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9SRCTiTmflXCAasS6E6jD96OKZdCd71v83UokSp0h5NbrbPxFecVoXeKNogh691EJWRdWLzPPT79jOFR7f+E2j0VvtRLgEk1JpXxGdhaTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDggT2N0b2JlciAyMDIxIDEwOjQ2LCBBZGFtIFRob21zb24gd3JvdGU6DQoNCj4gPiA+IFRo
YW5rcyBmb3IgdGhlIGluZm8uIFNvIHdlIGJlbGlldmUsIGJhc2VkIG9uIHRoZSBldmVudCByZWdp
c3RlcnMgdmFsdWVzDQo+ID4gPiBwcm92aWRlZCwgaXQgaXMgdGhlIFJUQyBldmVudCBhcyB0aGF0
J3Mgbm90IGNsZWFyZWQgYnkgYSBwb3dlci1jeWNsZSAoaXQncyBpbg0KPiA+ID4gdGhlIGFsd2F5
cy1vbiBkb21haW4pLiBUaGUgb3RoZXIgdGVzdCB3b3VsZCBiZSB0byBtYXNrIHRoaXMgZXZlbnQN
Cj4gPiBpbW1lZGlhdGVseQ0KPiA+ID4gYWZ0ZXIgYW4gUlRDIGJhc2VkIHJlYm9vdCBhbmQgc2Vl
IGlmIHRoZSBsb25nIGtleS1wcmVzcyB0aGVuIHNodXRzIGRvd24gdGhlDQo+ID4gPiBkZXZpY2Uu
IEkgc3VzcGVjdCBpdCB3b3VsZCBpbiB0aGF0IGNhc2UsIGFzIHBlciB5b3UgY2xlYXJpbmcgdGhl
IGV2ZW50Lg0KPiA+DQo+ID4gSW5kZWVkIGlmIEkgbWFzayB0aGUgUlRDIGFsYXJtIGluIElSUV9N
QVNLX0EsIHRoZSBpbnRlbXBlc3RpdmUgcmVib290DQo+ID4gZGlzYXBwZWFycy4gQnV0IHRoYXQn
cyBub3Qgc29tZXRoaW5nIHdlIGNhbiBkbzogdGhlIHJlc2V0IGRyaXZlciB3aWxsDQo+ID4gYWN0
dWFsbHkgYmUgaW1wbGVtZW50ZWQgaW4gb3BlblNCSSBhdCBzb21lIHBvaW50IHdoZXJlIHRoZSBk
ZXZpY2VzIGFyZQ0KPiA+IHByb2JlZCBvbi1kZW1hbmQgKHRoZSBzYW1lIGFwcGxpZXMgdG8gdS1i
b290IEkgdGhpbmspLCBzbyB3ZSBjYW5ub3QNCj4gPiBjbGVhciBvciBtYXNrIGFueXRoaW5nIGF0
IGJvb3QuDQo+ID4NCj4gPiA+DQo+ID4gPiBJJ20gc3RpbGwgY3VyaW91cyBhcyB0byB0aGUgMTYg
c2Vjb25kcyB0aG91Z2guIFdvdWxkIHRoYXQgYmUgd2hlbiB0aGUga2VybmVsDQo+ID4gPiBmaW5h
bGx5IHN0YXJ0cyBhbmQgbWFza3MvY2xlYXJzIGV2ZW50cyAoc2VlbXMgcXVpdGUgYSBsb25nIHRp
bWUpPw0KPiA+DQo+ID4gTm8sIHRoZSBrZXJuZWwgaXMgbm90IHVwIHlldC4gTWF5YmUgMTZzZWMg
aXMgbm90IHRoZSByaWdodCB2YWx1ZSwgSQ0KPiA+IG1heSBoYXZlIGJlZW4gaW5mbHVlbmNlZCBi
eSB0aGUgZGlzY3Vzc2lvbiBoZXJlDQo+ID4gaHR0cHM6Ly93d3cuZGlhbG9nLXNlbWljb25kdWN0
b3IuY29tL3Byb2R1Y3RzL3BtaWNzP3Bvc3RfaWQ9MTAwNTIjdGFiLQ0KPiA+IHN1cHBvcnRfdGFi
X2NvbnRlbnQuDQo+ID4NCj4gPiBJdCBzZWVtcyB0aGVyZSBpcyBzb21lIGNvbnNlbnN1cyBhYm91
dCBoYXZpbmcgdGhpcyByZXNldCBkcml2ZXIgYmUgYQ0KPiA+IFNpRml2ZSBVbm1hdGNoZWQgYm9h
cmQgc3BlY2lmaWMgdGhpbmc6IHF1aWQgb2YgdGhlIHNlcXVlbmNlIEkgcHJvcG9zZQ0KPiA+IGlu
IHRoaXMgcGF0Y2ggdGhlbj8gSXQgZG9lcyBub3QgbWVzcyB3aXRoIHRoZSBSVEMgcmVnaXN0ZXJz
LCBpdA0KPiA+IHJlYm9vdHMgcmVsaWFibHkgYW5kIHRoZXJlJ3Mgbm8gaW50ZW1wZXN0aXZlIHJl
Ym9vdDogaXMgaXQgZGFuZ2Vyb3VzDQo+ID4gdG8gdXNlPyBPciBkbyB5b3UgaGF2ZSBhbm90aGVy
IGFsdGVybmF0aXZlPw0KPg0KPiBZZXMsIGEgYm9hcmQgc3BlY2lmaWMgaW1wbGVtZW50YXRpb24g
d291bGQgYmUgdGhlIHdheSB0byBnby4gV2UncmUganVzdCBjaGVja2luZw0KPiB0aHJvdWdoIHRo
ZSBzZXF1ZW5jZSBhZ2FpbiB0byBiZSBhYnNvbHV0ZWx5IHN1cmUgb2YgYW55IHBpdGZhbGxzIHRo
YXQgbWF5DQo+IHByZXNlbnQgdGhlbXNlbHZlcywgYW5kIHdpbGwgZ2V0IGJhY2sgdG8geW91IHdo
ZW4gd2UgaGF2ZSBzb21ldGhpbmcgbW9yZS4NCg0KU28gaGF2aW5nIGV4YW1pbmVkIHlvdXIgc2Vx
dWVuY2UgYWdhaW4gaXQncyBub3cgY2xlYXJlciBhcyB0byB3aGF0IGlzIGhhcHBlbmluZy4NCldp
dGggdGhlIHNlcXVlbmNlIHlvdSBwcm92aWRlZCB0aGlzIGlzIG9ubHkgYSBwYXJ0aWFsIHJlc2V0
IHdoZXJlYnkgYWxsIG9mIHRoZQ0Kb3V0cHV0IHJhaWxzIGFyZSBzZXF1ZW5jZWQgZG93biB0aGVu
IHVwIGFnYWluIGFuZCByZXN0b3JlZCB0byBPVFAgdm9sdGFnZXMuDQpIb3dldmVyIHRoZSByZW1h
aW5kZXIgb2YgdGhlIGNoaXAgc2V0dGluZ3MgYXJlbid0IHJlc2V0IGFzIHRoaXMgaXNuJ3QgYSB0
cnVlDQpyZXNldCBvZiB0aGUgZGV2aWNlIGdvaW5nIHRocm91Z2ggZnVsbCByZWxvYWQgZnJvbSBP
VFAsIHNvIGZvciBleGFtcGxlIHNldHRpbmdzDQpvZiByZWd1bGF0b3IgbW9kZSBHUElPIHN0YXRl
cywgb3IgSVJRIG1hc2sgYml0cyB3b3VsZCBwZXJzaXN0IG9uIHRoZSByZXN0YXJ0LA0Kd2hpY2gg
Y291bGQgaGF2ZSBpbXBsaWNhdGlvbnMgb24gc3lzdGVtIG9wZXJhdGlvbi4NCg0KSW4gYWRkaXRp
b24gdGhlIG9ubHkgYml0cyBvZiBpbnRlcmVzdCBmb3IgeW91IHNob3VsZCBiZToNCg0KIC0gQ09O
VFJPTF9GICgweDEzKQ0KCVdBS0VfVVAgKEJJVCAyKSA9IDENCiAtIENPTlRST0xfQSAoMHgwRSkN
CglTWVNURU1fRU4gKEJJVCAwKSA9IDANCg0KU2V0dGluZyB0aG9zZSB0d28gYml0cyBzaG91bGQg
YmUgZW5vdWdoIHRvIHRyaWdnZXIgdGhlIHBhcnRpYWwgcmVzZXQgc2VxdWVuY2UuDQpUaGUgb3Ro
ZXIgYml0cyB5b3UgaGFkIGluIHlvdXIgc2VxdWVuY2UgZG9uJ3Qgc2VlbSB0byBiZSBuZWNlc3Nh
cnkgb3IgcmVsZXZhbnQuDQoNCk9uZSBmaW5hbCBjYXZlYXQgdG8gdGhpcyBhcHByb2FjaCBpcyB0
aGF0IHRoZXJlIGlzIGEgMTZzIGludGVybmFsIHRpbWVyIChhcyB5b3UNCm5vdGVkIGJlZm9yZSwg
VkREX1NUQVJUKSB3aGljaCBpcyBzdGFydGVkIHdoZW4gdGhlIGRldmljZSBtb3ZlcyB0byBBQ1RJ
VkUgbW9kZS4NCldoZW4gdGhhdCAxNnMgdGltZXIgZXhwaXJlcyB0aGUgZGV2aWNlIHdpbGwgY2xl
YXIgdGhlIFdBS0VfVVAgYml0IGF1dG9tYXRpY2FsbHkuDQpUaGlzIG1lYW5zIHRoZXJlJ3MgdGhl
IG91dHNpZGUgY2hhbmNlIHRoYXQgeW91IGNvdWxkIHRyeSB0aGUgcmVzZXQgY29tbWFuZA0Kc2Vx
dWVuY2UgYWJvdmUgYXJvdW5kIHRoZSBzYW1lIHRpbWUsIGFuZCB0aGF0IGNvdWxkIG1lYW4geW91
IHNldCB0aGUgV0FLRV9VUA0KYml0LCBidXQgaXQncyBpbW1lZGlhdGVseSBjbGVhcmVkIGFnYWlu
IGJ5IHRoaXMgdGltZXIgZXhwaXJ5IGJlZm9yZSB0aGUNClNZU1RFTV9FTiBiaXQgaXMgc2V0IGxv
dy4gSW4gdGhhdCBjYXNlIHRoZXJlIHdvdWxkIGJlIGEgbmVlZCBmb3IgYW4gZXh0ZXJuYWwNCmV2
ZW50IChlLmcuIE9OS0VZKSB0byBraWNrIHRoZSBzeXN0ZW0gdG8gc3RhcnQgYWdhaW4uDQo=
