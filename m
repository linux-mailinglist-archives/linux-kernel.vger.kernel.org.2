Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA1458E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 13:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbhKVMri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 07:47:38 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:10085
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233483AbhKVMrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 07:47:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml+7ykrxBOOSE2arnd0g2wvKWAgw0+y2mDHmECTKA82KbMwN0n1J27uHyC71/KBUOn83euQf+zhbB8P2q/wtq3STCDlfLcDm8GoAmQlmaOcZuEVtIFyyTRqnZGTbe0smDxtD5hMJzA8/sccU90wMpgoSTURZZBWKuOE5K7mBPXNZK71KxhJlox8YJtyyiG/jmLcVFQsScGxadDLJ9Y7Qhgewro9CXOGqscbRZfAmp97Rhf+TIU/Id+dnAAe6An0f8MqKhccskk0bnSK0hXI9RnjMNDXfwCI7e0bbdDISu2TVQ9rxnJY/7epjUDlhkc103j5HlcqpuE3oIy7AF7AmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfPbyLRSCyC8bcHdAuZBTubeKb6HcGnuVYS78qO2qD4=;
 b=n+K8EZ6U6bMeMVq/edQMRInSxroeJxkf/Xb8W03J+ITWvaHuOOdeTgOoB79rJA8gG6ayPr7wlf5oJH6jDuPKIeJxhGY22TrXpWV3gvaTdrTzK8mEtRIxM1ekElsJkyXxDx5LyNwWAqUWa3+oeQDFkx2BiR8LofcZciTtZg1niuyiMw7O/2eGyOg9R0CuBZShieLVn/k2uBN4aQO4gccD8H1zWQsuJ8af3Q2nA3w+5v1D9i6brL8pQuTDLN2Dkx2hhi6mk7fvjUof8lXY+SFeaNp0NFtv9TJQCKf31ukKQffNtP1CjPwumu26gRqyXVOnaeUCas3Xv2bWShl4IhdEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfPbyLRSCyC8bcHdAuZBTubeKb6HcGnuVYS78qO2qD4=;
 b=LOWrIbu6RZHaXIot2aUvHSYbKhmlyfCzHZ/QvxcsdaX/9I5WVOxBPZEyayutjbNCYzIGVw0GLXvGP8et98Y5NgRltXfnivG/GDud1dkyiWgzhRat8AYa/5knZxNWTJOTi2jnpk8XGnoeCHqgF9WP+ux1GuczaXELCbn3eevdu/g=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2586.eurprd03.prod.outlook.com (2603:10a6:3:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Mon, 22 Nov 2021 12:44:25 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::544e:754:6241:aa7f%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 12:44:25 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] regulators: irq_helper: Provide helper for trivial
 IRQ notifications
Thread-Topic: [PATCH 3/4] regulators: irq_helper: Provide helper for trivial
 IRQ notifications
Thread-Index: AQHX35C1xKJZ2J95XUWBjS7fJK/346wPbrKAgAAPiIA=
Date:   Mon, 22 Nov 2021 12:44:25 +0000
Message-ID: <3239d539-a2da-b913-b644-83766c6cabfd@fi.rohmeurope.com>
References: <cover.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <fc622a2135be79f718d32efac156558470568340.1637330431.git.matti.vaittinen@fi.rohmeurope.com>
 <YZuDoSvGj8/SpqjU@smile.fi.intel.com>
In-Reply-To: <YZuDoSvGj8/SpqjU@smile.fi.intel.com>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51f770fd-01ad-4d10-6fb8-08d9adb5d11b
x-ms-traffictypediagnostic: HE1PR0302MB2586:
x-microsoft-antispam-prvs: <HE1PR0302MB258675431B1849C18180E895AD9F9@HE1PR0302MB2586.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZEvyvNeE0YLPu9mZRliOvJxsLRWZW0ZLzoIVjxH8xjkAkPP8h4JjRguXipASEJRA29VcP0J8jb51JF698Bd/9j+1oT4JIwLW9JR1M7YtyXGPI+5js/5JSF529JTbmJTt6lx5mj9dL4Ktmg/8R0Cng44dtIehLtMs/glQqTOcde+2FSlVTS2wuTzhmGYsnfrspowQn0mWCtfSxhNHc6DuoWIk9PWSjInqjddNxwmN8c+Hbjz1NVbPTbLCocC9EhDYkSqc34F0a8LtbYRSPK3QIfVx3k/QcmO35kkbVkIoy60lMCPBa6aBs4lNVIM+jl8uIaj1CWvsWFho2q+nvbOcCktktL78ETndfrVmbgm+QBPTgNy1vTrv2Vsg9PXNSu+v0ZI4s88V8p5rcWVELzGPJu7c0xrOsL7Vi+SR+yWER+ALV8CPqXVsbE8u56V+PR3eOmOPxbrPQufUTtlGIBq+0AaSYjoL8JJu+kyiGy7rjNwJ0+CaXkE4VeZPYfdjYAJ5xkdKL+d2yQV4261Rdw4Yuhaf1dOINC0Jd5oSJvsaYPnFQFfnkCRjUuY9nak68zs1CxPcOkH4WuvPnGq6PPkSp5N6lUO18gQP4rR7ZKg9C04FZeJvuZmYaWka/i9kS1AaXsyPmHRKQ9oLi7Kft89OBwZNJZ/hkcmMjXMey8o9kPwH+AnRwalMd+XpSHN9b2G28Gw6auPx0FMSr5K54pYcL7dycYn3fes84Cy/h3OnBKNiFK9eVApQek6Ixe6JbrYB3t/qnDi4MlGmJVlpHICs8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(15650500001)(66446008)(6512007)(4744005)(64756008)(316002)(26005)(31686004)(122000001)(8936002)(83380400001)(4326008)(186003)(38100700002)(2906002)(76116006)(38070700005)(31696002)(66556008)(2616005)(6486002)(508600001)(66476007)(5660300002)(71200400001)(8676002)(86362001)(66946007)(54906003)(6506007)(6916009)(53546011)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2l4dkpiRmpoNmg2SmJsZnpubTMwNytBY2VlV3VuZXdZeFU5bTJzUjlYVXZV?=
 =?utf-8?B?T3hDZFRLTVFrbGxGNldIRWNXYXVSREdVNzBzcUN1akYxcFgvTnVDR3VYMm91?=
 =?utf-8?B?U3JWcVphYmZ2dTAxcnMwcFc4K1NXVVFlTm0vdUhMQk5HM2VWbUJndG9OazMz?=
 =?utf-8?B?V0FGSnNwazBpMzl0bGczLy9nN2ZLclFPdW5rSk1WbDhFeHY4UWJ3RFR0Z09T?=
 =?utf-8?B?RGVOS1UyNWZtQkd5aUlWcmxzT2E1N3ZUcW9IOForN0lPYW1GME1RYlFZbW9V?=
 =?utf-8?B?RFRRVU9sTkszVkZwZEw5c1c1dHk3OEQxVHZJeGlzazhuLzg5UURXWDROd1FX?=
 =?utf-8?B?RUJtVVZSQ2RLS2srZTNKclVlMnJkOGRlMW9wZmVnc1pXdjFsa3JjSWNNMHZl?=
 =?utf-8?B?TWZaRmhVcjUraEF4RlhST1F0MVdJakFtTFp2WjJUWFNyY1lST0x1NlRjUWEy?=
 =?utf-8?B?bjY2SGI2dG5GbWNTWk1zNmhFNnBtQkJaY0l0YnBxTEZ1dkhQN3Y5SjJSYzFD?=
 =?utf-8?B?MHd3OEJ4aTg0UzIwbFNSNjBHVWhVeDVya3l6TzZpVm9UUHlocDg3Z0xtM1BV?=
 =?utf-8?B?SlovZWQ4RUd6OGg3dFkxQ1JQbU16UWpZaGVrZ2lpZDQ3S1B0Q25UN2pLeGV3?=
 =?utf-8?B?QTk0QklBTlNvMHAwT0NtZ0UxSFFLQ0Y2UXA0WFg1YnVkc2NYZ3FYUzFDd3ZS?=
 =?utf-8?B?OFRvKzAvVE5Ud0F3ZWNDZWJTTW11cUxpQytsQTBnK2Y1d1piZFg4ZmRmR1dD?=
 =?utf-8?B?YitOdG92SE1VcngxK2V4aGJYa0F6Z0RLRlR3Q003Vzg4VlNrZEtYdEwydzdP?=
 =?utf-8?B?RjVxK3lnaWhUMDVWM1RBRzlwRm9FdXhtUERVdVBpa0dveTZJaFlLMnZnL3JL?=
 =?utf-8?B?Ly91VE5FYUtHMjJuWEF6VWRodTR3NEluM1RPdFhQR3pBNkIyR04rM01NcFVu?=
 =?utf-8?B?OFpPQXJ4a3NCendqeGZzN3pEMFFhL29QUWVZNFFuQ2dvR0k2UGRaWmwzRlcz?=
 =?utf-8?B?ZWRFcXh3ZUZDWVdWczZCbVArZnNFb3ZpMFl6REhhZitsNUJ0SDMyMURCWjFM?=
 =?utf-8?B?UlZjbGMyZ2toMk1yUFVCd0NlbTlmWTFxRGlGODE5ZGlQNVE4YjZqdUxwcXhP?=
 =?utf-8?B?YWx2SE1DMERsQlorcmREWHpOWUlJMDI5OVJlUFcwVExOMCsreU4vQWxZTTlU?=
 =?utf-8?B?RWIzcys5dER1M0VCbkVzc2lMY1pKN2NPWkxwYWVpSnMwK3hqYkxtM3pCdGhD?=
 =?utf-8?B?SXp4VDllT0FWNSthQ254UTBKZi9FZEptdW1URzVrYytDSHJ6YWY2ZzVLT1hQ?=
 =?utf-8?B?U0tQOVc5dDlOSDVaQVdGZEtYTnZHTUN2RkVqckdONzJuNGNRMVozQ25PbnE4?=
 =?utf-8?B?RWhFNGFNRU9LYTF1cUxOS05FSEtUcVhYa1krWEorcnF1eDlGbm9iK1hqbUMw?=
 =?utf-8?B?T1dKcXYvcjYwb2d6bCtJVkRUTVdNWklaT09qbnN1NHdQNFltMGRSNG1JdU8x?=
 =?utf-8?B?SXYwenhsSElGN0d3WjFuNmV1enpTUlh6a3FmV1g4ckRNSlBnYjJWejZFQnhz?=
 =?utf-8?B?dDcyNkswa0czYzgrNE5pRVVOS1R6OFJ5SDF0RVRnYVRNWndwdWptTVF0RHIv?=
 =?utf-8?B?TUt5VmN0TkF1MmRFUnBxZGFOZFVUMGQrektWRW5rK1pTMFk4ZGdhU1g2Zm1G?=
 =?utf-8?B?eGl4cjNVU0dtQXd4WGNaNU9OMVVRRjQ0YVRtaHRHVTcxMFZCUk5TRVRva2t6?=
 =?utf-8?B?M0MxM2VCbnBPOUxHNXQ2OHlLOU1SbG1kZFdQK3dYNnIrREduNEF1OGlUSUxa?=
 =?utf-8?B?Y0tXRktZUnlyYnJNZTkydVFTRnFwQ3U1d1BQc2UvY200Q3N6aTk1NkZRbm55?=
 =?utf-8?B?Qk1Rd2l3c0hMOTRvSHpyS0p0dXZXeUhTMnFhY2lpUWFIRlMvbFRGYWJuelEx?=
 =?utf-8?B?UWFYNzdFaDBuYXNUaVJkSlRGQjAzU1g2dzYyQ3dDMHFzVHRTZXpoRnB5TmZX?=
 =?utf-8?B?bDlsdEFOSTVWN0RGL0ZVdVlvSnFZNXVVSDlITERwOHZOV1NhK2tQMmluNEta?=
 =?utf-8?B?RVlNZzJQUjlSSUVXU0F4WDVBbmtUR1lKNEhjZjZPbmxpRjV4R3BCNEViSDkr?=
 =?utf-8?B?aWs2bjM5azBMQ2NHc0RkWlIvWEpRd3VoYUZNaDZjTGw0cW1GS2laVXNLZzA0?=
 =?utf-8?B?ajVmMTEvbXI4NDdHSlBNalZJTytBVXpyZGh5ZWRRZ3VLTnZlVEh1Uk8rblU1?=
 =?utf-8?B?UWZuQm1LQVdnRFVIMXNpeXp1MjlkSVFVZ1dvS2lsRHVwZXJ5bFA1TGVwb1Vl?=
 =?utf-8?Q?hnYxbVWXIZ359aS+29?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC484DAE5FB76347910CFDAE80BB54F5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f770fd-01ad-4d10-6fb8-08d9adb5d11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 12:44:25.7198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CKH9S4P2897IhX3ddJ3pUzZ7mB/f8n7tDURhfvwfdrv7YQo1vlmzt4FiCjOaLPGuDtDnDgf0vGOm50aWGrwpHnOczbfoEjX6a+1+gBbEHS1GjMKcvMgFTT1mcucRbqW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2586
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjIvMjEgMTM6NDgsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gT24gTW9uLCBOb3Yg
MjIsIDIwMjEgYXQgMDE6MDQ6MTJQTSArMDIwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4g
UHJvdmlkZSBhIGdlbmVyaWMgbWFwX2V2ZW50IGhlbHBlciBmb3IgcmVndWxhdG9ycyB3aGljaCBo
YXZlIGEgbm90aWZpY2F0aW9uDQo+PiBJUlEgd2l0aCBzaW5nbGUsIHdlbGwgZGVmaW5lZCBwdXJw
b3NlLiBFZywgSVJRIGFsd2F5cyBpbmRpY2F0ZXMgZXhhY3RseSBvbmUNCj4+IGV2ZW50IGZvciBl
eGFjdGx5IG9uZSByZWd1bGF0b3IgZGV2aWNlLiBGb3Igc3VjaCBJUlFzIHRoZSBtYXBwaW5nIGlz
DQo+PiB0cml2aWFsLg0KPiANCj4gLi4uDQo+IA0KPj4gKwlpbnQgZXJyID0gcmlkLT5zdGF0ZXNb
MF0ucG9zc2libGVfZXJyczsNCj4gDQo+IEkgd291bGQgcmF0aGVyIG1ha2UgaXQgdW5zaWduZWQs
IGJ1dCBhbnl3YXkuLi4NCj4gDQo+PiArCSAgICAhc2luZ2xlX2JpdF9zZXQoZXJyLCBzaXplb2Yo
ZXJyKSAqIDgpKSkNCj4gDQo+IGh3ZWlnaHQzMigpIHNlZW1zIHN1aXRhYmxlIGhlcmUuDQoNClRo
YW5rcyBBbmR5LA0KDQpJXGxsIHNlZSBob3cgaXQgd29ya3Mgb3V0IGFuZCByZXNwaW4uIEkgYWdy
ZWUgdGhpcyB1c2UvY2FzZSBwcm9iYWJseSANCmRvZXMgbm90IHdhcnJhbnQgYWRkaW5nIHRoZSBz
aW5nbGVfYml0X3NldCgpLg0KDQpCZXN0IFJlZ2FyZHMNCgktLSBNYXR0aSBWYWl0dGluZW4NCg0K
DQotLSANClRoZSBMaW51eCBLZXJuZWwgZ3V5IGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCg0KTWF0
dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVycw0KUk9ITSBTZW1pY29uZHVjdG9ycywg
RmlubGFuZCBTV0RDDQpLaXZpaGFyanVubGVua2tpIDFFDQo5MDIyMCBPVUxVDQpGSU5MQU5EDQoN
Cn5+IHRoaXMgeWVhciBpcyB0aGUgeWVhciBvZiBhIHNpZ25hdHVyZSB3cml0ZXJzIGJsb2NrIH5+
DQo=
