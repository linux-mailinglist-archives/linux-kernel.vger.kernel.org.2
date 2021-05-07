Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4010375FAE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 07:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhEGFZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 01:25:24 -0400
Received: from mail-eopbgr1400078.outbound.protection.outlook.com ([40.107.140.78]:41376
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229666AbhEGFZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 01:25:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlpl2l2xHWHKJWQnKX2ImgMMELnKkqrqnQJidyFcP2TDAb9UyMK0DN6lcHP+QA35jJIYBzPVvMQDtTxOqZfCYoVWQTnQt3qOPJL43gcVkdv+dfctclGBx/N6aZPq9LsckAR8X0F8u6b6Wd4asUDlNN2OE7geiKw2xd2HNJRI18aBjYhMVUL5TpjsEW7NLEQEgRgSOebxC9JiEjT5wD3rvE1HQcTHzoaq3yc/ugk3+21ga3xMnmQj0yTgv9NFoPO+IIuzVlcoGAobo1QVoscy0axBJOnKiS71Nwg6+eiotN7Dmk3rLXuQH9ISzJk0SNhnLpTcVb4iEf9kKjc81JMECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/jgmgzjsS3owDxUKV8+kbM8NTT26FeJA09q0I41Nbo=;
 b=h3AW3jQX5OYhE5kC9vpZx/zLohtbutqoMp70jHxuIqGofLA+GzEFX+N2dE9zHjx5sqjZC7+SXumSAiw5JEESXa6Kj1s/X18I9VKisEnNIVo3g+8QE95brOsIwzA9uHma39Xs/wR79uD00bZW4MQ6KFplcrsrJvbgJOhKHk2jHcGstwJKQ2a9QKWgW0c90nHRuIsLJA9QC2damhaupf7GLaduFua8gvzZ3DikBU3YCQLnVKZrZm1qxhv+F0B7rcvzKMrU1uqt9Mr+ODIefcWjml39TEK0H8L/Ei7DteoKzpFdlE3mT115UBYQ8Wl0ygyP9nQmuyTYiq1GzNNZYSvfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/jgmgzjsS3owDxUKV8+kbM8NTT26FeJA09q0I41Nbo=;
 b=UffiR1I1zFT9l+7JzTOa3m1fu7HCyHxCTWuSgQoMLmoOlPFxCRPE0KfMynoQAAbyFTspxBZHTrTcQy/2kfkK2XaspwkL2Kp3z7fwEJId6FHroOgQh4RGstomzgbbh5Tw5A6/44W6CFLT44ouwoXG1fFapWgJ0g0kPRiOBHoY6Uc=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB5482.jpnprd01.prod.outlook.com (2603:1096:404:8034::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 05:24:22 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4065.039; Fri, 7 May 2021
 05:24:22 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Topic: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Index: AQHXQuY21tdoe528FUCsWFgD12p5WqrXXrWAgAAd9wA=
Date:   Fri, 7 May 2021 05:24:22 +0000
Message-ID: <20210507052422.GB2158342@hori.linux.bs1.fc.nec.co.jp>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
 <d09f178272df4c82b8c090ba79d222b5@intel.com>
 <87ba79daaba1416589b203118be096cb@intel.com>
In-Reply-To: <87ba79daaba1416589b203118be096cb@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7b63d6e-bf35-4b4b-5fb1-08d911185f80
x-ms-traffictypediagnostic: TYAPR01MB5482:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB54820E8F11E3EE4CD23CDC34E7579@TYAPR01MB5482.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:475;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0LukdB48M3szYIAKJoJs3AT5/0AWo/uD9uag6Z8vEJkBmX4BtAP+MJPUH9Y+XpkS2vd4+2yFoQ+dV1KYmlxYfbdWG6x7qi07sIr2frJS9c8Uv3oT2q6GVRbt16ON2APGaKLealoW4X3XmGl/rCppHIuHq20JOevAdAPsk4RaUw1qjWL9DrDjlFXzUBofEtBY+g0XJ6qFcAsdaYpZOk3FOHL0ImV89s5e7UkauFj1I5/Q32ADtesYqUP/Ysh6T5mZqVagzruD2XSsbuquD38+nEZH9zexPms3ysZaXC6sSDnnET3T+Yk6sZkDeNzFHAdgLBsWOPELrTbSdW0ybK6qzRPD+C6mjc6PP4q5qY/qT9CGDlck5ck0wD+ucGnnn7afPbw0LFENYOCmA9QNU0lJkbTzvJsqtAep7N2qgK9w2MqSmAbmxSRRPhhgvI0ap9tJFhxwrP3HAUDL/6hlY7zbECE8NtuLD0rlPwC7TlMClKZemTMC1b77WQepoiBqmiPAx2I/cui2a05j4s++h1EFGaTv4o37yWbLuTyg65lIhUel1O3+DLdBRQiH6k/+RrevWgsR2poi13I+hqRBN/6dHsM3jjthaUu3S59JknQpmVk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(2906002)(7416002)(186003)(26005)(55236004)(71200400001)(83380400001)(478600001)(66556008)(66476007)(6486002)(6916009)(8936002)(1076003)(66446008)(8676002)(316002)(64756008)(66946007)(54906003)(33656002)(76116006)(6512007)(122000001)(6506007)(9686003)(4326008)(38100700002)(86362001)(5660300002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?azlDQ2lFWDlhMHEzb0Y4YVU5Ty9mOTlhTlVlQjg1OVBMS1pYUE84cmF0N0cz?=
 =?utf-8?B?d3VkaUN6bkVVM1FwKzF0NHFEU01Camg4NDRrV1B4djBZSi9UWUJuOUFIYmZk?=
 =?utf-8?B?ZXBlVHVqbEJHWDBOSEMybVU5QXUzSGgrUXVoUExQOTU5WG9BUDNoUHJtckd5?=
 =?utf-8?B?TUNxRDducitjSk02SVhqTFk0cVhMSHdrMVdpMGpWeGpIN3FxTk54d1E2R05D?=
 =?utf-8?B?QVhTVk9NU1FLODN4MVUwcnVvVUhPaTI5V0tPemhOZEwxZ1JrQTVlOWphUnd5?=
 =?utf-8?B?OFdpb3JDNEZxUUZWN0JYZSswdm5kN3AxT0N1MTYrZXorSHhJVXhzcllKK3lW?=
 =?utf-8?B?dDlXWjhLR3lSS3JWbG51dWEzNENaTjUzYkNLMDRtck1IQVAxWXZSZ3c1UFg2?=
 =?utf-8?B?eFpoNyt6WkdJcjF4ZXowT1d3K2dtbFhMbGFrdWFRMlJjeVBMNks0NlZIb2JT?=
 =?utf-8?B?a1lxTVV0aWJBbnlqN09PZkY5ZFh2WWo2d3A5NnkyU28weFpEbGFveVBua0Qy?=
 =?utf-8?B?RTRNSDlqM0s0MWk3WHRkTG1LQWM2Rk0wSDRCRk5xWTdwa1U2SWpYdEhrUVdT?=
 =?utf-8?B?TUxoSTJlNmpXblFhRXAydU5sN1AzTjdGbXhZanhjSGpCNXNFOW1wNGllMUor?=
 =?utf-8?B?Nm9wbmZjNWFYREt3SDltV2JlZC8zOWdtTWVEMlhISnNiVTZKTmU1MTlEbEZ5?=
 =?utf-8?B?QTloalZVd1dZUjBJOHBBeGN3NE9LNFdKQVNTdDNhRjV5Y0lZMTU1K3NBSTFF?=
 =?utf-8?B?YUtNS0V1Z1h5MHRQcDNXaFVucC9XT29MNnpBUVF1K2VhRlhjZ3VsZkh2RUFO?=
 =?utf-8?B?NXdSVHJJdnlVSjVoVHQyMlFySit6OTNJb3UxWXV5d3hZZTZmT1h3QVJjTmNE?=
 =?utf-8?B?R3E2MjJKUHFOcnhnay80N2dOWnNQZ2MvdXZQeHFQUjdqSTJWRGI2dkxKYWkv?=
 =?utf-8?B?azNGVURQYlBPN0xyUUlqT0NIaXYweW5yZE9IMXB6SWljc2w4aTNqMHhWbndh?=
 =?utf-8?B?STROb2t6ME83aThqNjh2RnNOdWNvZkZBVWR1cHdOT3ZiSzAwUEVXVWFkNDR3?=
 =?utf-8?B?NjBQanR3UEJoZ3FjNTBIcnJpQ0ticFB2a3FMb3BINXFoTlpVSDBjZ0RoZm1R?=
 =?utf-8?B?Mjd4U09OTS9JQ2RLOE00MzVCdE56N09lNDdSSlBQczVqT0lqUWlYMXcyL2xQ?=
 =?utf-8?B?bVFyZ2pnejIxVkNVUVdiUzViV0Zpc2pGU3dnT0x1TzkxSVhYTWk3MDh2bkE0?=
 =?utf-8?B?bkpyeUt0Mko3TWZaLzZuNTN2TThpQm5SOGR5S0JpQmI5TGpoeGQ5bGVjSGhz?=
 =?utf-8?B?a2dORE1PTkloT3pSR1lReWZMNjI5UFVXczRvT3hSRjNJUUxPSS9YYTlDSTM5?=
 =?utf-8?B?cFQ5cnJDa1VvWXE0YjlGc05VVmc5YlJkRXdueG1sN2JtdmdUTllaNlpzSk5S?=
 =?utf-8?B?bjU3MGRwa1RSbDArWkY1cmQ2L0Z2Y0dEOUFsRFB0b2wwSnVubHJIYTIrVnVR?=
 =?utf-8?B?ZXZiWVp5SjJzamNpQkhGd012Ti81K1NHejRvTm1XQ2lVNU5tNHZiNXVYUHh4?=
 =?utf-8?B?RzV6QkVvcWJOakFhVkdLeUJ6b3hvTmgzZlY0WDRqRzRtaFFCU3VoQ29MdUow?=
 =?utf-8?B?VnNhaUxNK1JLZzhFc2tCMW1JMmJReTZCQWlJdUNsR3lKYmxJaEswbnRBUXNZ?=
 =?utf-8?B?bDRhWjNhQ0hRUC9KMnViUFBjdjV6QjZKZE1BMzdPcnBDY2VBWlVGN0FKZXpw?=
 =?utf-8?Q?bhREnYehiobtlnvWIT51IOOTGc0IuZZ0IoR9vee?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6512465AF567F64990D7244173D141F6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b63d6e-bf35-4b4b-5fb1-08d911185f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 05:24:22.7802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krxJwZxlGVNBmYGuKZ/PfvG8H8kcLN9OnRmibk1fQyu6myR/yK0o0kEuDW4Nvu0g0Jia36B9V0zwH68YwnI+NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5482
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXkgMDcsIDIwMjEgYXQgMDM6Mzc6MDdBTSArMDAwMCwgTHVjaywgVG9ueSB3cm90
ZToNCj4gPj4gSSB1cGRhdGVkIHRoZSBzZXJpZXMgYmFzZWQgb24gcHJldmlvdXMgZmVlZGJhY2tz
L2Rpc2N1c3Npb25zLg0KPiA+DQo+ID4gVGVzdGVkLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0Bp
bnRlbC5jb20+DQo+IA0KPiBNYXliZSB0aGlzIHNlcmllcyBzaG91bGQgZ2V0IGEgIkNjOiBzdGFi
bGUiIHRhZyB0b28/DQoNClRoZSBzZWNvbmQgcGF0Y2ggKEkgc3F1YXNoZWQgMi8zIGFuZCAzLzMg
aW50byBvbmUgaW4gdjQpIGlzIGEgbGl0dGxlDQp0b28gbGFyZ2UgKG1vcmUgdGhhbiAxMDAgbGlu
ZXMgb2YgY2hhbmdlKSwgd2hpY2ggZG9lc24ndCBtZWV0IHN0YWJsZSBydWxlLg0KQnV0IHRoZSBm
aXJzdCBwYXRjaCBsb29rcyBzdWl0YWJsZSB0byBtZSBmb3Igc3RhYmxlLg0KDQo+IA0KPiBJIGRv
bid0IGhhdmUgYSBzcGVjaWZpYyBjb21taXQgdG8gcHJvdmlkZSBmb3IgRml4ZXM6LCBidXQgaXQg
ZGVhbHMNCj4gd2l0aCBhbiBpc3N1ZSB3aGVyZSBzb21ldGltZXMgcHJvY2Vzc2VzIHJldHVybiBm
cm9tIHRoZSBtYWNoaW5lDQo+IGNoZWNrIGhhbmRsZXIgYW5kIGhpdCB0aGUgc2FtZSBtYWNoaW5l
IGNoZWNrIGFnYWluLg0KDQpJZiB3ZSBjb25zaWRlciB0aGF0IHRoaXMgaXNzdWUgaXMgdmlzaWJs
ZSBhZnRlciBMTUNFIGlzIHN1cHBvcnRlZCwNCnRoZSBmb2xsb3dpbmcgY29tbWl0IGNvdWxkIGJl
IHRoZSB0YXJnZXQgb2YgRml4ZXMgdGFnLg0KDQogICAgY29tbWl0IDI0M2Q2NTdlYWY1NDBkYjg4
MmY3MzQ5NzA2MGRhNWE0ZjdkODZhOTANCiAgICBBdXRob3I6IEFzaG9rIFJhaiA8YXNob2sucmFq
QGludGVsLmNvbT4NCiAgICBEYXRlOiAgIFRodSBKdW4gNCAxODo1NToyNCAyMDE1ICswMjAwDQoN
CiAgICAgICAgeDg2L21jZTogSGFuZGxlIExvY2FsIE1DRSBldmVudHMNCg0KYnV0IGFjY29yZGlu
ZyB0byB5b3VyIHRlc3QgcmVzdWx0LCBhbnkgb3RoZXIgZmFjdG9yIG1pZ2h0IGFmZmVjdCB3aGVu
DQp0aGUgaXNzdWUgYWN0dWFsbHkgZ290IHJlcHJvZHVjaWJsZS4NCg0KPiANCj4gSXQncyBoYXJk
WzFdIHRvIGhpdCBpbiB2NS44LCBidXQgc29tZWhvdyBnZXRzIHByb2dyZXNzaXZlbHkgZWFzaWVy
IGluDQo+IG5ld2VyIHZlcnNpb25zLg0KPiANCj4gLVRvbnkNCj4gDQo+IFsxXSBJbml0aWFsbHkg
SSB0aG91Z2h0IGl0IGRpZG4ndCBoYXBwZW4gYXQgYWxsIGluIHY1LjguIFRoZW4gd2FzdGVkIGEg
YnVuY2gNCj4gb2YgdGltZSB0cnlpbmcgdG8gYmlzZWN0LiBCdXQgbXkgImdpdCBiaXNlY3QgZ29v
ZCIgcmVzcG9uc2VzIHR1cm5lZCBvdXQgdG8NCj4gYmUgcmFuZG9tbHkgYXNzaWduZWQgd2hlbiBJ
IGp1c3QgaGFkbid0IHRyaWVkIGVub3VnaCB0aW1lcyB0byBtYWtlIHRoZQ0KPiBwcm9ibGVtIHNo
b3cgdXAuDQoNClRoYW5rcyBmb3IgdGltZSBhbmQgZWZmb3J0IGZvciB0ZXN0aW5nLg0KDQotIE5h
b3lh
