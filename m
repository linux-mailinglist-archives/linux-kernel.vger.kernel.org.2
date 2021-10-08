Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC26E42671B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 11:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbhJHJsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 05:48:10 -0400
Received: from mail-vi1eur05on2063.outbound.protection.outlook.com ([40.107.21.63]:38464
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239083AbhJHJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 05:48:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFbAcdcF+Z8faCT+pI6Ved43TpqRh43C4Ii6fHVTMC5GeH9ijKMunBKjmbsWF6IgQCLHKGrxyYPFvVvB05ZnBphkPkMAHVfcl2leqSf9Qv4BxtjWdFjQiTaRU5bj1AEfGWhxQ7cZWHt3TqwxjRW4evpa1duIe5tXltgnOKf+eZwXIhkl6MgIekKh4CwdR5IiwzhgLR9yFCPAtce88INZqlfFFYt4UiaEpkteh+PuqzQZsjHRwxCH0cN0Ttnu6uLd4c5YFQ0GHIbjGIp833Safy1FAFMlcwt4ChF3jfaFQ3swSmeqq8E2eAi1/f7l8PDxw+dFno8nmqV7UEeQTlJJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCJMPTX+YiYy0F8+BR8NJS8hh6K0Um9HndCeyWkwl+M=;
 b=JOpYJH6m+vttY1zR13ORszBGh5pHWeK2rH7yUHL8yKQH4VtXScxYDTxxEEOXgeSt/XbouABJSf+zPinKVTQBQGqADfOMCkE+a/cQLGsWMiVO8RhCZPcUmsGA22pOYvr9qxZ9mDzHsTks3ZD0vcxdd9E3tna++717gtXezgebMSSJacBHjP+owd+bBNk3TW04pEnsgOUZHD5fuMWXI/tEmScKMKysGEU8WHI8SKd61qaePQLLClCXqeIex7Z2mnFnm5OYi1xLRa0CGKuhTtlWqa06oo2GxjpGPykom2wpo8gXZkggHUfR4r5Wv5n6hzYZ80utpAejzIePLAnTbIEC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCJMPTX+YiYy0F8+BR8NJS8hh6K0Um9HndCeyWkwl+M=;
 b=y/v44NtjAJLsSp88Go7X6pL2k2EhxGDhYbkk2X6fdNWWS8txphv+eb/Y10dc2h6gbi9ybHPSr8bfyh/FMB2ZJQdzMGD5mYKO/3UqxNzT2yT0BASsnVbdVW3zcb5ReFzYezAofCzNsp+/rC0GKhQbOfumm2r906STnn1peNLcclk=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB3531.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21; Fri, 8 Oct
 2021 09:46:05 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%6]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 09:46:04 +0000
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
Thread-Index: AQHXrqpI0LoFC+MHc0+B+6k9QHIUIauzTVswgAAUm4CAB616wIABMx0AgAArEQCABmU8AIAAMeyAgAF704CAAUpnYIAAJDmAgAMFyyA=
Date:   Fri, 8 Oct 2021 09:46:04 +0000
Message-ID: <DB9PR10MB46521072770D6A1C75DEE08380B29@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
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
In-Reply-To: <CA+zEjCvFO6Tz+D42wgnstx_TLNEt=HM0eeT5g0-zwaEscGj2vQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05925235-1f6a-4ee5-6f87-08d98a407240
x-ms-traffictypediagnostic: DB8PR10MB3531:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB3531F6EE3F0398FBE924A551A7B29@DB8PR10MB3531.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2fNqtc3BGCV8tGYn2kqo9EneUGWh3Pd4XFtUxBtt5QfDz5eqO3aE4A8GLYRxZhwu0w+qQoxjAKaPb7C7RtbrqggML5iq8r/DTo2B1MVrYbVlA921EFtp/TPCXuSCz45prjUm42Bc1jvhtZoWjBokSDH+oRpOjUEChkE4EnRnr6I8sEj90mfRoRkSDDh2D+yCws5hH5vdlfDUNtehc+LafLp7DwhcRP4g9dIXhPwslm2JtYnHyQcU+/2c7mHzoNSu/290y1NCh/c4ZlHnfWpUc6fgtlGsgcqdHrQrkFinz+/Xi+BZmBLDF9O3um9y8tLWmJBtNKOa0YjhCXNGfFy4EYkDcoz0LmrK9RT6HYMZVq2DrS3QlgItedhzmyXMrbsdqz+ySz66wAEg9hg14UCq9HGB7tng245YIkIOCTPH0O0+PfmvImYnOrH0C2GGEkcn15jYSfVSOYMaAfCj/RIhMh5Tpw4+7bLQqqF3FxcdhFp3zA20zUA8tTvkI7zQDUsXnIeE2Qr5B5yBYeekzRtco7vuQHbb0zNzl5yDeqRCc+khuh+oegMU0TKkLplM6K/TFqp0L9aXdKFKIJiVebejBylerVDTKrYOaky7bCWo5FOiRx/ZNyvmU2eVoZYjz8611j8wOMsk0iaPLUg/6rmkoy88z6Yi9c4YMYOYAVPm7MXUlLQoFHrPZUzT7fj77irz+UVqhJkLDPlsLwCv36IuBaRCj8G9IKBjxf8bI/ErBxZcIXTEfrNPDYZaS4HffuflY6qbeUkIhjo9jcJ5w/zztihbrv9uf8dTpdyl+8c0T7s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(52536014)(66446008)(55016002)(4326008)(186003)(38070700005)(54906003)(66946007)(66476007)(64756008)(66556008)(76116006)(2906002)(9686003)(38100700002)(8936002)(8676002)(122000001)(83380400001)(110136005)(33656002)(26005)(508600001)(71200400001)(316002)(966005)(7696005)(5660300002)(53546011)(6506007)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUVJU0FPdHdJSXB2MEpTZWYrbnI1YXZKSkd3RDhmTFhUcHBrU0hmb1Q4RFVt?=
 =?utf-8?B?RkhkV1JuTVFCUFh3OTh6Q01YOEtqcWVKdkJKSG5PVUI1dVk5NGxrcDUxd3pT?=
 =?utf-8?B?dnVTY2dxNVBPOU1HSEtsRWcvNHBTUVY4ZGxrWERpRkZTWGdHV281dWo2dko5?=
 =?utf-8?B?cWVjUlc3cXZDN3lJS3hqbm9kVVdNcGZHNEYxT01mNGhwVUl6ejlnMm1oQWZJ?=
 =?utf-8?B?TWdsQXNZc3U1RGJpVnhPbU9rVnhYRVhhTTYwYnAxd1hSc2FaNTJuOHZEdklw?=
 =?utf-8?B?OE1vVGxCZEw5SHFDa3FGRGJ2Zms2eTJ3Q0lvVUFhRm1Wdmw5QW5RaUJBUnRr?=
 =?utf-8?B?RGVSc0M4cnExeStYd092TTNRYi92THRNYWxQQXp1Rm1QS0V6WjFnOGNEZ2xI?=
 =?utf-8?B?YWV1aWdRY2Z2UDNVTmpnVlkydWNzSzlsY2dGR3FSVEIrc0QybGRLUlNjQmxa?=
 =?utf-8?B?TWRyVmZwdTMxTGZxR01ZSDIyV0NwNGRsT2s5MUg2M0lRV1pRUm11bUQzSXlE?=
 =?utf-8?B?OVl3RE9xUWx4dlRTb0dKNDduMlY5Ni9ic3o2NmtlaEhiYjRvTGpnSEdmZ3FR?=
 =?utf-8?B?RkhLOHRjMTI3N2tBb2tVelVJSVVJRllINHZCUm5oa2NwYWdpcTNFSk9jeXdR?=
 =?utf-8?B?TU1rY0JrMDZzaWZUd1k5Szh6dDVqNmc2WG5uVnZBc2pRZzlrYUxmK3lXL2FF?=
 =?utf-8?B?b1JoMTMvd0lLcGFYeWFTazl5ckt1VTFwNEZONW1xdTRUNjRZU29RZ3hmUXh1?=
 =?utf-8?B?dzFEUHUxSFk5WStweWwzejZHYlRDN2NsTjVuc1REam1rYkczMXRicCs3bGdi?=
 =?utf-8?B?SjZjT1FCSlQvNUFHSjlDUGVtYnZTU0crK3p6azRZNUNuR3JJVVFkNFROTWhT?=
 =?utf-8?B?RHNoOEtuRXRRbDVGWXRrQlgvYTB5ek4zYnNBSDg2b3p3V1JvNTc3b05TZXZm?=
 =?utf-8?B?dEtPcVZnRnJlclhLWXpGczZjWXZHeGlnOC9MTFh1SWhweXkyWkt3WnV5WnNZ?=
 =?utf-8?B?ZWp6OWV1NUVzRitqb3EramdSemFOTlZIb3VhTkZWZkJHcUJwN0R2alZ5Zk43?=
 =?utf-8?B?NGliNWVERmZGRU5RYUFiUEhhNlN1TUJsOHBLMy9DemdlU1lJb3V4RXBnVS9Z?=
 =?utf-8?B?YlFNUHB2V1FKaU5ncU5Nd1R6WnovMjE1Rkg4a1JpUmxXZUgzZHNYRUJWRllS?=
 =?utf-8?B?amJGTE5Cai9XbUIxeFZ3SWsxY0tna2NZcDlha2VNUHVkQ0VIdXg2aWg0QnBi?=
 =?utf-8?B?UDlJM0Ywa2xhelVpdTBpV2t3RGRyVlgyenNpTXUwL3d4VURWKyt3empXTUd5?=
 =?utf-8?B?VTRCZTV2OHJLa1pNNC9kdUxlN09lbyswMHN4ZGh6M0hSY2x0bnFRbHZmR1hR?=
 =?utf-8?B?TTYxS0hQa0hKcUVCRVl2T0REN3J3UWJQSE9QMHB2UkV2bGV5dHdaV3N0WXBV?=
 =?utf-8?B?Yk1rQWJ4Q2lBczFSb250NmhCVTFaZG16VjZObjFNbVMwMFA4TzZvOXA1Rm4y?=
 =?utf-8?B?MFFqVEhPR1h3OHhHUDNhWUhLM2VKTGR4Vi9icVU0Y0RoalZ5WlAybnJtbEM5?=
 =?utf-8?B?c2xFYkovcUF0RnduUVFCZFRpK2x4aERyN3ozZ2M1SWZzdnNLOFl0NTBqQlUv?=
 =?utf-8?B?OHNOd2ZhQVl5NnNtUG5zeUNudS8wUmtLTjErRkhwSnlpRnV4eHF1YS9wK1VC?=
 =?utf-8?B?d0t3RkVoSlVOcFNYeUFhSXNPREFpaEJrSjVtRVhNeVl0NXdNclZvSjU1bEsy?=
 =?utf-8?Q?ONVTWtwD52NT/omel6SffCr8Qt25wSbfvlMdP2F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 05925235-1f6a-4ee5-6f87-08d98a407240
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 09:46:04.7876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V3/JalEAp5qlnP7cAdQP4Xo6jVXe90yPRebG6o9B5QZNHQ+OwZpXs6Z25LMYC8nZGK+pHFBSJdWtFi6b34M4dZK4HcnOSElCWfbhMZt4qwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3531
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYgT2N0b2JlciAyMDIxIDEyOjM2LCBBbGV4YW5kcmUgR2hpdGkgd3JvdGU6DQoNCj4gPiBU
aGFua3MgZm9yIHRoZSBpbmZvLiBTbyB3ZSBiZWxpZXZlLCBiYXNlZCBvbiB0aGUgZXZlbnQgcmVn
aXN0ZXJzIHZhbHVlcw0KPiA+IHByb3ZpZGVkLCBpdCBpcyB0aGUgUlRDIGV2ZW50IGFzIHRoYXQn
cyBub3QgY2xlYXJlZCBieSBhIHBvd2VyLWN5Y2xlIChpdCdzIGluDQo+ID4gdGhlIGFsd2F5cy1v
biBkb21haW4pLiBUaGUgb3RoZXIgdGVzdCB3b3VsZCBiZSB0byBtYXNrIHRoaXMgZXZlbnQNCj4g
aW1tZWRpYXRlbHkNCj4gPiBhZnRlciBhbiBSVEMgYmFzZWQgcmVib290IGFuZCBzZWUgaWYgdGhl
IGxvbmcga2V5LXByZXNzIHRoZW4gc2h1dHMgZG93biB0aGUNCj4gPiBkZXZpY2UuIEkgc3VzcGVj
dCBpdCB3b3VsZCBpbiB0aGF0IGNhc2UsIGFzIHBlciB5b3UgY2xlYXJpbmcgdGhlIGV2ZW50Lg0K
PiANCj4gSW5kZWVkIGlmIEkgbWFzayB0aGUgUlRDIGFsYXJtIGluIElSUV9NQVNLX0EsIHRoZSBp
bnRlbXBlc3RpdmUgcmVib290DQo+IGRpc2FwcGVhcnMuIEJ1dCB0aGF0J3Mgbm90IHNvbWV0aGlu
ZyB3ZSBjYW4gZG86IHRoZSByZXNldCBkcml2ZXIgd2lsbA0KPiBhY3R1YWxseSBiZSBpbXBsZW1l
bnRlZCBpbiBvcGVuU0JJIGF0IHNvbWUgcG9pbnQgd2hlcmUgdGhlIGRldmljZXMgYXJlDQo+IHBy
b2JlZCBvbi1kZW1hbmQgKHRoZSBzYW1lIGFwcGxpZXMgdG8gdS1ib290IEkgdGhpbmspLCBzbyB3
ZSBjYW5ub3QNCj4gY2xlYXIgb3IgbWFzayBhbnl0aGluZyBhdCBib290Lg0KPiANCj4gPg0KPiA+
IEknbSBzdGlsbCBjdXJpb3VzIGFzIHRvIHRoZSAxNiBzZWNvbmRzIHRob3VnaC4gV291bGQgdGhh
dCBiZSB3aGVuIHRoZSBrZXJuZWwNCj4gPiBmaW5hbGx5IHN0YXJ0cyBhbmQgbWFza3MvY2xlYXJz
IGV2ZW50cyAoc2VlbXMgcXVpdGUgYSBsb25nIHRpbWUpPw0KPiANCj4gTm8sIHRoZSBrZXJuZWwg
aXMgbm90IHVwIHlldC4gTWF5YmUgMTZzZWMgaXMgbm90IHRoZSByaWdodCB2YWx1ZSwgSQ0KPiBt
YXkgaGF2ZSBiZWVuIGluZmx1ZW5jZWQgYnkgdGhlIGRpc2N1c3Npb24gaGVyZQ0KPiBodHRwczov
L3d3dy5kaWFsb2ctc2VtaWNvbmR1Y3Rvci5jb20vcHJvZHVjdHMvcG1pY3M/cG9zdF9pZD0xMDA1
MiN0YWItDQo+IHN1cHBvcnRfdGFiX2NvbnRlbnQuDQo+IA0KPiBJdCBzZWVtcyB0aGVyZSBpcyBz
b21lIGNvbnNlbnN1cyBhYm91dCBoYXZpbmcgdGhpcyByZXNldCBkcml2ZXIgYmUgYQ0KPiBTaUZp
dmUgVW5tYXRjaGVkIGJvYXJkIHNwZWNpZmljIHRoaW5nOiBxdWlkIG9mIHRoZSBzZXF1ZW5jZSBJ
IHByb3Bvc2UNCj4gaW4gdGhpcyBwYXRjaCB0aGVuPyBJdCBkb2VzIG5vdCBtZXNzIHdpdGggdGhl
IFJUQyByZWdpc3RlcnMsIGl0DQo+IHJlYm9vdHMgcmVsaWFibHkgYW5kIHRoZXJlJ3Mgbm8gaW50
ZW1wZXN0aXZlIHJlYm9vdDogaXMgaXQgZGFuZ2Vyb3VzDQo+IHRvIHVzZT8gT3IgZG8geW91IGhh
dmUgYW5vdGhlciBhbHRlcm5hdGl2ZT8NCg0KWWVzLCBhIGJvYXJkIHNwZWNpZmljIGltcGxlbWVu
dGF0aW9uIHdvdWxkIGJlIHRoZSB3YXkgdG8gZ28uIFdlJ3JlIGp1c3QgY2hlY2tpbmcNCnRocm91
Z2ggdGhlIHNlcXVlbmNlIGFnYWluIHRvIGJlIGFic29sdXRlbHkgc3VyZSBvZiBhbnkgcGl0ZmFs
bHMgdGhhdCBtYXkgDQpwcmVzZW50IHRoZW1zZWx2ZXMsIGFuZCB3aWxsIGdldCBiYWNrIHRvIHlv
dSB3aGVuIHdlIGhhdmUgc29tZXRoaW5nIG1vcmUuDQo=
