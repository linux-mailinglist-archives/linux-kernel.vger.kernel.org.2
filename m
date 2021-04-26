Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A2036AFAF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhDZIYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:24:12 -0400
Received: from mail-eopbgr1400071.outbound.protection.outlook.com ([40.107.140.71]:55104
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232647AbhDZIYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeupBRj02K5MoKnrxrYF+HkDLkLsqMtvYU3xObSm8zMpAqfk2KTeWF80oR4oZ0+n2Db+RifPtQbrKMmG3dv7wpzkUqIZmJVuAD6x55XkUU0LFEZeXuKleKkkgLecaKmjmdTxOiUlkrAtebSBpw2sTSzvjfclJlqGQoDqhvpbomr2l4yvNyajcnYUUAcC3UgX4l+u6nP7ju+PdDm9ZTJv0TkIn5gwiUMoCFZSsxyrx+xz9VKkQfOKO4tA++sD5urssrXWvJayLCKvQ4VrdKS5ihvw/zf9aA+fYAmXFhIcfXOSH3Bbi+M5lcWnTtG5Npsv06QVAVnVvliuL4RxTFnNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1ztfWRekJ69ISSSX22G93wqayXNDm9sHcF64u5f+W0=;
 b=BRryhbT8ldiD8sV4e2y77ztIk4zOBRXETuLJAH1GCIycdCXtAe+5Y4dBfo9BU2cXN9oXb+2mSkDqXPoSuMGdWnqUO1IRJb9GxLqtaCYxmeT/Yw1b9ISlEYjuT52AlV4mg9TJnrWZOp+QlHyRFZDUSGhYABQ5PorT+CMOBd84njoy3NleXXSuYQkz7KA+RXodgCjofwfziJtNwnu8zcZzQvCiGjQZbkXv8xym9QYLAydNek+HeSOhfQ3w8xq19H2Qwercyn6PhXxhd1H7w+LU3SxB7rHwbttRc1TQ7rTMxJInZIRg0CTQsxb5ASoTD8RMzSSMnsuZPv2FXOg3ZADFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1ztfWRekJ69ISSSX22G93wqayXNDm9sHcF64u5f+W0=;
 b=TcvRQpge2qBMkP7fpI0Nfs/4pMxPOvsyDU4Edh99t6ewcuR58aGOjfuW1SfUkleq39NDEwAVhbZ1vXvAW1MArekEbfKc81jhi+PniJa24v8Ly1RvmQdqwGnTmFqM30MP0LTuuO3jJinY52R6pzd0KTl3wH9fJJXdwSw9CDsOr6w=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYBPR01MB5421.jpnprd01.prod.outlook.com (2603:1096:404:802e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 08:23:17 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4065.025; Mon, 26 Apr 2021
 08:23:17 +0000
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
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Thread-Topic: [PATCH v3 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Thread-Index: AQHXNklgr5oQqPpfCk+wWIRkBSmi9arAxeiAgACbcICAAKG7gIAEeyoA
Date:   Mon, 26 Apr 2021 08:23:17 +0000
Message-ID: <20210426082316.GA181354@hori.linux.bs1.fc.nec.co.jp>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
 <20210421005728.1994268-4-nao.horiguchi@gmail.com>
 <20210422170213.GE7021@zn.tnic>
 <20210423021833.GB68967@hori.linux.bs1.fc.nec.co.jp>
 <20210423115725.GB18085@zn.tnic>
In-Reply-To: <20210423115725.GB18085@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e5ea4e3-f97f-4af8-57e6-08d9088c8b60
x-ms-traffictypediagnostic: TYBPR01MB5421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB5421BE9C2E5B078C9A9CD786E7429@TYBPR01MB5421.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0fHINfmtWB9GTl01Rwn8uKEYHdkwIjNKA9nDm5n0gf8G1jPdu9PV4VxXR8iV9dr7e5TG+nDE+vUX1Ks11yG8AgH5E2K5Y7WnGOdRy8QQTC8XwBYdQ1mUG8hpPgmThGmvgGb3VI4M2Gkr+Swtz8ulC8JR+np2KKtYM+Xpqpa5uE1X3ECyv3jHn7KNwpRElADJaiUb+C6htT+mTaFfiWaZj6QTYHIICwu1eM+m1Rws6iz0iO7MSrGnhNtvutijyOWZw4Fe0dy698MbG2PMIqh5u8p/Vbbv2JHoxWV/eEl4+Cuke/29QfM4VRw4qQtGcHKcrJkDIzv041u5ROAHDbCaufejk820GQkRk6Vzw7HGYzRISQLRURfu5K81ouftmZBAtW5VS0HLJNtaLlqz6oXKWQxRzb0oqItjsbbQAkkSl4GJBeXES5qJMZDN2rOd2SRRHisZlVixwqnGCd48bF2vwETnskq9DFiv0+8BnAW3V0J8FHmuxt8S1AG+WXYfWH0x5egGy+gSdl5CCs5cJrAShLc7GsvalPh6czi0QY0zP2gPfj60BAp7ogMSC5qLhQe4mZsyjPMBtZ8y7CR6PCTC/iGPHb+vzu69PhI29auCi19cgXkynH4IWWjoqd9joC9QAU9UaDSTbuGcvn5To7AYVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(66946007)(33656002)(76116006)(64756008)(186003)(71200400001)(478600001)(8936002)(122000001)(66446008)(6506007)(66476007)(4326008)(66556008)(316002)(54906003)(26005)(85182001)(7416002)(83380400001)(6916009)(1076003)(86362001)(8676002)(2906002)(5660300002)(38100700002)(6486002)(9686003)(6512007)(55236004)(37363001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VTk2Ynhxc3hCbXVLaUhwVElmZk9NRGZEaTFibUFhYlNNY0RuVmhTVGxGVG9F?=
 =?utf-8?B?UnhrbHordjJLbnhOYnA0Um5QMGpKY1JtRmlqZ0ZJWitvSENBMEpFamExbVM0?=
 =?utf-8?B?dnF2RXZkK3A3S1Ztc3FQdTF0TlAzZnd3OWZUV005T1UzNnQxWHhpV1F2TGE0?=
 =?utf-8?B?cFZ4UUVHN1BlWVc2SUhMMUdXRWo4d1p0TEduRFI4Q0FMRWR2eDJQNURrUHp2?=
 =?utf-8?B?WlZFOURPTFBJVHdDTkRFcytWcS9zWTJibHZ3ZHY1dlJrT3V4Qnh2eW4wWjNI?=
 =?utf-8?B?QnVtajFuUEdEcmRBTUJrQ2ZtUmoxc2dnbFNoREd2ajB2RWdhaXhxVzdiOFA4?=
 =?utf-8?B?YmlpMU0vUlFaVmdpUi9rb0YvYzVudE8xa045MllYVTlDVU5oSUpYUkIrYXlD?=
 =?utf-8?B?WXJyUjZYMmJHVEdQdzg2a2Zxb3NrZkl4NWN1Nk5wOUNoaW9uNE11YjRaSVky?=
 =?utf-8?B?N0c2OStST09zZDBOMk1NNUY4Qjk5Qng2bGZEUy93S0RzL0J1cnhxdlZXU3JN?=
 =?utf-8?B?Q1FVQnQ3aUhFczBWVUtuYks0WGJwODR2TzY2ZmhCS3VEZzlzMEtLMG5iZ2xy?=
 =?utf-8?B?T3EwNm9OL1RFYUROTFh4ZkFlNHB4K0R2a1RlaEZsRW5PZlNxR3I4MkVOUXBP?=
 =?utf-8?B?NFNnSmszdXFPS3MzeU5LRE5RRGUzakRHMUFVYnREc05raCs5ZU83SzVzMFRB?=
 =?utf-8?B?RHF2YWlGZVVuZ3RLU29JOCtTWmkra0lkYURsNGhOTCs3T0pOeFNjT3lNMEFD?=
 =?utf-8?B?VzR4USttcitnKy9KaFplSnVGckVGTGx3d3dxVnZjb2FGNlpDaXhES29JK1kx?=
 =?utf-8?B?UGdKaTlkdHg2S0dOemtpVU81cEpFUm0wcHN5eEhwYXJ0UUV3VXRCSE55Yit2?=
 =?utf-8?B?YURlUHRVUHBpTjFWRGhraHZ5dVV1U2J0R09kVS8yZnJyZDBQd0MyQXJsYkZn?=
 =?utf-8?B?SS9DQlp6MEZ6WnFjSHZTMVJKRHI4a3dxRmhLYm10RS81ZnpoeGVYUFFhbG5T?=
 =?utf-8?B?VFdxQ0VYVmViaVZqQjVWWTA1N252OEVSLzFoWUxKOENuWHpOY2d1SWRnNjNB?=
 =?utf-8?B?WWVxWWdvSXo5VndRMDRBWktzZ3RYbjIrTDZyNHJxZXAwZGl6OVlMT0tQenp3?=
 =?utf-8?B?VCtvUTcyNmpLT054R1pkemZBMEMyQnZmN3lNSUg0citwb3hXVWl3ZWZRdGNk?=
 =?utf-8?B?QmozVHhQSWpFbldMMldWRHBHOXovMURBdm55QTBKYlh2VnIzZG43b21hNm15?=
 =?utf-8?B?TUwrWWYyU3F3d3I0MUExTzZPUmZmN25DR3UxRi9NL1VZM1JaUFo4aHdONXNj?=
 =?utf-8?B?YXA1bzRFeTF5STBSNmI4N1Ftd2cyMkxkYzhkSEVvblBrc3Vwc1p5K1dUMTBI?=
 =?utf-8?B?ajh5eTJheHFBcGw0UC9vZDNUZEMyMDZ6dU5jcER3Q2swdkJKaTlzNGk0d0pa?=
 =?utf-8?B?M0Vodm9hb2FWZnJvTDVaNXFRdFJ5VTJheGNzYkFtaFFZSHlQN0trcFRuUlI2?=
 =?utf-8?B?T0R6RHhYa0svd2IwMWxGZEVQRHBFVlE5WFMyMW1RQUYrbHY2a2JuVWNzN3VO?=
 =?utf-8?B?M1VHdCt1YVA2Q3R3Z3RSektidEFlRjBjRXdBZEk1cjVZTFJ6dlVwL0MxN0ZT?=
 =?utf-8?B?bFRVSjF3eGlUbFhyK0NjcGp4MVVYYm9mNHpMWGx5OEFVTUZSTU9PNXNrNTZ6?=
 =?utf-8?B?SVo4RDBsSmVacTJOcy9nSmo0cUtTWHp6b29udUVlMDI0Qk1GcCtHVHlLdUFt?=
 =?utf-8?Q?q95VW0jVwP6EPRDFc9diYSZo7kwYNBfFFK0qaDD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB04AE4EB0553A47B31803D3BE936124@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5ea4e3-f97f-4af8-57e6-08d9088c8b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 08:23:17.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /9Hj7VkAj6huAMlGtBiY5Zz199XK5S7WM4Yt9mBdIM1yPXhwraR614VXCi2kAD0JwNXhwz+P7HsmFO327vWJ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5421
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBcHIgMjMsIDIwMjEgYXQgMDE6NTc6MjVQTSArMDIwMCwgQm9yaXNsYXYgUGV0a292
IHdyb3RlOg0KPiBPbiBGcmksIEFwciAyMywgMjAyMSBhdCAwMjoxODozNEFNICswMDAwLCBIT1JJ
R1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykgd3JvdGU6DQo+ID4gSSBkb24ndCBrbm93IGV4YWN0
bHkuICBNQ0Ugc3Vic3lzdGVtIHNlZW1zIHRvIGhhdmUgY29kZSBleHRyYWN0aW5nIGxpbmVhcg0K
PiA+IGFkZHJlc3MsIHNvIEkgd29uZGVyIHRoYXQgdGhhdCBjb3VsZCBiZSB1c2VkIGFzIGEgaGlu
dCB0byBtZW1vcnlfZmFpbHVyZSgpDQo+ID4gdG8gZmluZCB0aGUgcHJvcGVyIHZpcnR1YWwgYWRk
cmVzcy4NCj4gDQo+IFNlZSAiVGFibGUgMTUtMy4gQWRkcmVzcyBNb2RlIGluIElBMzJfTUNpX01J
U0NbODo2XSIgaW4gdGhlIFNETSAtDQo+IGFwcGFyZW50bHkgaXQgY2FuIHJlcG9ydCBhbGwga2lu
ZHMgb2YgYWRkcmVzcyB0eXBlcywgZGVwZW5kaW5nIG9uIHRoZSBodw0KPiBpbmNhcm5hdGlvbiBv
ciBNQ0EgYmFuayB0eXBlIG9yIHdoYXRub3QuIFRvbnkga25vd3MgOikNCg0KIjE1LjkuMy4yIEFy
Y2hpdGVjdHVyYWxseSBEZWZpbmVkIFNSQVIgRXJyb3JzIiBzYXlzIHRoYXQgdGhlIHJlZ2lzdGVy
DQppcyBzdXBwb3NlZCB0byBoYXZlIHBoeXNpY2FsIGFkZHJlc3MuDQoNCiAgICBGb3IgYm90aCB0
aGUgZGF0YSBsb2FkIGFuZCBpbnN0cnVjdGlvbiBmZXRjaCBlcnJvcnMsIHRoZSBBRERSViBhbmQg
TUlTQ1YNCiAgICBmbGFncyBpbiB0aGUgSUEzMl9NQ2lfU1RBVFVTIHJlZ2lzdGVyIGFyZSBzZXQg
dG8gaW5kaWNhdGUgdGhhdCB0aGUgb2ZmZW5kaW5nDQogICAgcGh5c2ljYWwgYWRkcmVzcyBpbmZv
cm1hdGlvbiBpcyBhdmFpbGFibGUgZnJvbSB0aGUgSUEzMl9NQ2lfTUlTQyBhbmQgdGhlDQogICAg
SUEzMl9NQ2lfQUREUiByZWdpc3RlcnMuDQoNCj4gPiBUaGUgc2l0dWF0aW9uIGluIHF1ZXN0aW9u
IGlzIGNhdXNlZCBieSBhY3Rpb24gcmVxdWlyZWQgTUNFLCBzbw0KPiA+IHdlIGtub3cgd2hpY2gg
cHJvY2VzcyB3ZSBzaG91bGQgc2VuZCBTSUdCVVMgdG8uIFNvIGlmIHdlIGNob29zZQ0KPiA+IHRv
IHNlbmQgU0lHQlVTIHRvIGFsbCwgbm8gaW5ub2NlbnQgYnlzdGFuZGVycyB3b3VsZCBiZSBhZmZl
Y3RlZC4NCj4gPiBCdXQgd2hlbiB0aGUgcHJvY2VzcyBoYXZlIG11bHRpcGxlIHZpcnR1YWwgYWRk
cmVzc2VzIGFzc29jaWF0ZWQNCj4gPiB3aXRoIHRoZSBlcnJvciBwaHlzaWNhbCBhZGRyZXNzLCB0
aGUgcHJvY2VzcyByZWNlaXZlcyBtdWx0aXBsZQ0KPiA+IFNJR0JVU3MgYW5kIGFsbCBidXQgb25l
IGhhdmUgd3JvbmcgdmFsdWUgaW4gc2lfYWRkciBpbiBzaWdpbmZvX3QsDQo+ID4gc28gdGhhdCdz
IGNvbmZ1c2luZy4NCj4gDQo+IElzIHRoYXQgc2NlbmFyaW8gcmVhbCBvciBoeXBvdGhldGljYWw/
DQo+IA0KPiBCZWNhdXNlIEknZCBleHBlY3QgdGhhdCBpZiB3ZSBzZW5kIGl0IGEgU0lHQlVTIGFu
ZCB3ZSBwb2lzb24gdGhhdCBwYWdlLA0KPiB0aGVuIGFsbCB0aGUgVkFzIG1hcHBpbmcgaXQgd2ls
bCBoYXZlIHRvIGhhbmRsZSB0aGUgc2l0dWF0aW9uIHRoYXQgdGhhdA0KPiBwYWdlIGhhcyBiZWVu
IHBvaXNvbmVkIGFuZCBwdWxsZWQgZnJvbSB1bmRlciB0aGVtLg0KDQpJSVVDLCB0aGUgYWJvdmUg
c2hvdWxkIGJlIGRvbmUgYnkgdGhlIGZpcnN0IE1DRSBoYW5kbGluZy4gSW4gImFscmVhZHkNCmh3
cG9pc29uZWQiIGNhc2UsIHRoZSBwYWdlIGhhcyBhbHJlYWR5IGJlZW4gcG9pc29uZWQgYW5kIGFs
bCBtYXBwaW5nIGZvciBpdA0Kc2hvdWxkIGJlIGFscmVhZHkgdW5tYXBwZWQsIHRoZW4gd2hhdCB3
ZSBuZWVkIGFkZGl0aW9uYWxseSBpcyB0byBzZW5kIFNJR0JVUw0KdG8gcmVwb3J0IHRvIHRoZSBh
cHBsaWNhdGlvbiB0aGF0IGl0IHNob3VsZCB0YWtlIHNvbWUgYWN0aW9uIG9yIGFib3J0DQppbW1l
ZGlhdGVseS4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
