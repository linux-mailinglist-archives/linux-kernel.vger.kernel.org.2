Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB04377E41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhEJIdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:33:08 -0400
Received: from mail-eopbgr1410075.outbound.protection.outlook.com ([40.107.141.75]:2702
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230240AbhEJIdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:33:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4uoozBbKyqOIqZyzK8yuCZZ+7w7D/Lc96o+9N75VMSaBsiNxkaMORkJZYTsoTRScW9HIFJh7VVM1yK6qxS/dkXPD2oQP4TkNSlm5FChg7TkiHLwsw7im29fc/SaafH4ZjS/w1A/zwpfBRU9iVbpCVBF3MeJPLKJVtZO5S2g0a/RnRf1B/SvQh3x1EBk6z8usba3BX8QJEN8KiqmDS2MJIef4J7ZXPxGmUOTLMDMSylouX+kEgGJt8vPC0i1m7klypPGrNwIDoETe7GQlx9i1iTC1BP24X1fpVZcn9nk7T9i59mmbrFcIzlzV6ceTR2GTxQsHusIkgNEMyQf2dLNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/JdPmXbe8rSnOPobDCuTtjF+jWB+EXOeMoLKCn6D8g=;
 b=oNFIWGdrHEQO0UyEXoV8qhezH+OibWjjVicOB0iwoeXBgr+yLx3MPoPR8p34NMWBe7aaJxX/6X4jKChPnbuSO8LijiuLqEGTTRmMjcOxgIihMG3Rzrcc4MU5bOFqX31DGbzlZyGyPHZ9pWxBwDKM6zhQOhad7bxRkswe3aOpsu3lQWl90j7HoWbX2HvSJYCiD+8VffEoSOgXlW2LeO8ca2OJb2iy/9lKyZmi/DNdpN9MviDJuXkDy2zm4MgrUgr6mZ1InZN7IIU4VulmoB76snd0nT6cG0McgmaJSbLyaPmcQ4FXQmEM+Am0UTIS3+VfCJqo8jom9UrSt4xi4wv8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/JdPmXbe8rSnOPobDCuTtjF+jWB+EXOeMoLKCn6D8g=;
 b=b8eidVmW9+9nGUOqvLqy1qwyD4HD96FHOlGnWNN60giX4jALqc3bzLWhjEn0OcGjvvXS7F/5cjrlbc8n2KUKQytXIHBQMdC8U8/aiXAVFPPMOiGK95H1tV7nWVEbkg//SlSCGxwE259gTfgE4oobN/DPcMzj5Y09b/aigJYp28o=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5952.jpnprd01.prod.outlook.com (2603:1096:400:47::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 08:31:58 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 08:31:58 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaoaili126@gmail.com" <yaoaili126@gmail.com>
Subject: Re: [PATCH v4 2/2] mm,hwpoison: send SIGBUS when the page has already
 been poisoned
Thread-Topic: [PATCH v4 2/2] mm,hwpoison: send SIGBUS when the page has
 already been poisoned
Thread-Index: AQHXOy7IzwXBqmKu6kCc/e42oULGaarX0zYAgASQmwCAAArdgIAACNKA
Date:   Mon, 10 May 2021 08:31:57 +0000
Message-ID: <20210510083155.GB3504859@hori.linux.bs1.fc.nec.co.jp>
References: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
 <20210427062953.2080293-3-nao.horiguchi@gmail.com>
 <20210507173852.0adc5cc4@alex-virtual-machine>
 <20210510072128.GA3504859@hori.linux.bs1.fc.nec.co.jp>
 <20210510160021.648b41db@alex-virtual-machine>
In-Reply-To: <20210510160021.648b41db@alex-virtual-machine>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kingsoft.com; dkim=none (message not signed)
 header.d=none;kingsoft.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4487f17-c204-48e1-0c28-08d9138e13cb
x-ms-traffictypediagnostic: TYCPR01MB5952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB5952F5D41C8AA448470A8B14E7549@TYCPR01MB5952.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u8+z00pzVD/Mp6PFSl7AlnF0An6SJXXejknecYQK8euUEf0LIH2Ki0fs9Ry4DMsZQ6G7J00XTBmOfRXV6Mnb5uXbQktfRgLpo3lgqoLrKBzUFCp3rT6LLXW4DduqXvFDnZ4oY5SUBhfWIUIcvKxLEO+PY0yf3YgkmB8Db1z6uEAQiMs3iL5DOUZCYwelrllq3nqPxsDWw5rGxsB1btQzOrLKP0Z8Q9+lYRdvO9eQX4emGrJNDHoYxOPNWvCzL9P7UoP/+r8eEPKycAKhJS8lLWdHgfMeJkg6iLbLDTvvnEEdofglVZzHva+a4VUD/zf4heGbTlU0/X6pMj8GIhgWDHRf6t1MpVqdrefEYct3vpu5vTBV2/qQsefuOY+AzemMPkVnyllVs+t60fXfLryBr/ieuywmPyImDwMirDXFWrfiOzokqGbmsu6JP7hZ8F/t2/QMnfMFryQIMN0GKtn8q2tZNkqPOcPbXC1kpTzKe2w/2QiDJJHA6f0x9R1leuixnbqzL0pg5NwIDg4aN4mWGf7BzCFtSB6oykblQUwr73gTFKZDlIFyLC03lLpA31ZLGzY2xklHU5Qk04EeecOuT0ajLu27yZR19PmDvoskz6yGggdPCkZmYLhA3XF4GbjkyCWpwYhXyqlUkH9TMPa5pY0UeywW/OooLRal4Sn7tHNUW1MiZIWVP8eo/nGfKOgQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(6512007)(26005)(186003)(54906003)(71200400001)(86362001)(6916009)(33656002)(6486002)(8936002)(38100700002)(55236004)(2906002)(966005)(316002)(9686003)(66446008)(66476007)(5660300002)(8676002)(66556008)(66946007)(1076003)(7416002)(76116006)(64756008)(6506007)(4326008)(508600001)(85182001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NDl3dnNlVXBtME1CaHI3NWd3MHV3Tml5QkFpZXBoT0FuN1ZvZ3E1cTNUamgz?=
 =?utf-8?B?cUJwN2prdGNpSXVDVTF1Y0cva05BaW9hMFRHbGJGemJLdUxpV0hnV3hlQkhW?=
 =?utf-8?B?RHY5SjNFREZlTXRWbnc0VFNNaGNTdUFkeUxJNDlsOVJRU29oRnUzWUxvRDVM?=
 =?utf-8?B?d0RnN2p3d1grK2V4NHZyTmQzRTBvNFlGRXFYeFY0Y1JMZCt4YVhTaG9rV2sx?=
 =?utf-8?B?YWtZeW00ekQxOTdvSzZSRGZoRktIQXFrS25Xc05GWWFUMlU1YVYzUWM1VXRH?=
 =?utf-8?B?M0hzM3pBSGdTTmo4TWpkUEViYnZCM2hwWGVka2FyZDd6aWFmNU40VTRLaTFT?=
 =?utf-8?B?d2RTZ2wwemUyK0RzbkZESVY1RTRGa2Juc0FJOGhTWmlqNVoxblU2Rjc4ZWZK?=
 =?utf-8?B?ZGI1dkFDVWMrMVRUTXZMZlFIM1FvdVFvWDB1ZG44T3lTQytKQitYaU9mdE4y?=
 =?utf-8?B?LzVDc1dBbFNZZkZVM0g5c0FMdjFNSjA4d3FGNHBPYmt0dHNZMzJVenNsVlF4?=
 =?utf-8?B?U0kvcmlvZTRUbExMUTE5WDVKVDVxMmpFL1R0b1k5aUt4b2lmY21YL25BcUxS?=
 =?utf-8?B?cm9VeUNFVVhJTWEwcXUvL2s1eHpmbi9JWUpiQnQ1Yzl3c0lRZ1d0ZjlqOVVH?=
 =?utf-8?B?ZjNQdUJFTWc5SlpJYnZNMVVaMkIwcXVUcTJHemZxa3ZmeUhUR1RXdUgwYTJ1?=
 =?utf-8?B?UUhuZ1k5YUtIaWp4OGRhaXZqeEJMYmpzRExhTjBRY0IvZlJ1MVlHK1RycWgy?=
 =?utf-8?B?c001LzZMSzZQTllrODlKOFY2SDlaM1luVWhvcTFvdHVzdDdJV2FyRGNyT2FR?=
 =?utf-8?B?TENidFB2UEs5K1k2MGg3eDZ5YXJua0hoYkl4Mm5OSU5sa3c1eGpEdHE1LzIz?=
 =?utf-8?B?YmF4N25uRTEyaGJIZnh4VFlVNGI4cVZ3OEJ4VXdoTkxCWHRWb0dnY2JyQkJN?=
 =?utf-8?B?c0xIakRSeG15YmRlem9YbWRwMWJCVmlKT1MzUjBjaSs0aXltaG5MTzNWbkQ1?=
 =?utf-8?B?SDVPVjRMRkNJM3JHN1dqQVZHelpYUDEvTGk4eWxoOXNXNUhGQWJKNkQ2U0xE?=
 =?utf-8?B?MHhGZmVDMjZINE1TTWFTM0FRK1Q2LytoTDJ6Rm9jVkxicnA1OE1ucmhiZnE3?=
 =?utf-8?B?VHBuL3BOQWJvNExKVzRlV0poY2xpV21YZHlRNlRFSGhocVBJU1Y1RE5hVjU2?=
 =?utf-8?B?VncvRjZWY2M1blRPSTR5elNhRm42ODV0d2dhUkR3Y0NDQkFWejJ6eENtUk1m?=
 =?utf-8?B?MW5hRThLS1BWbVNLcnptelFDMTYxTXkvN09OOEcvNHhoZXFDaG5EMG80TjIx?=
 =?utf-8?B?c1lHSzloY2VheWFRNlhvU0dNWEVjVjloc1dzaFczRFVPSnc2bnFtY004Uity?=
 =?utf-8?B?Z2t0S2I1RGdsTXNTM0VkdlZ6a0NDejFlYTQySnFFZXFURGptWnNtL0R1RjVu?=
 =?utf-8?B?SnN6UkU4SDhNS0NNOE1uRmZMeFhNYkpvcng4V3FRa1k1ekhkRnVncWtzWGR1?=
 =?utf-8?B?MnJ6UFljdnFhRFV0NWh5WmdoNW02VDdzQnY3aHFycTltRW1sZnZFN1hHRi9F?=
 =?utf-8?B?Y2M5Z3kzaWY3My81Wnp6R1pMRlRKWTF5Nm80UzRlaGljMHFoRWdhaGJKNUtl?=
 =?utf-8?B?eXR1ZHRsOG5FTGJoTVR5b3p3SWlWaWhodnc1MFU0eVY4Y0dKWm9UZDBIMVRU?=
 =?utf-8?B?Mm4wR0ZBT2YrTzRaOHBUS3hhRk1vdlZlNTFHTVAwL2JoTitYaDIrYk43TG9Y?=
 =?utf-8?B?SU16WlQ5ZEhJVGZwMWtnS21UeVY4eWJQaUUxRnNtOFl2aXkrL09xZWU0ZCsy?=
 =?utf-8?B?a2N5MXZVMlZEVkllOHV3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0947E64F990AFA499E641D4E2C32B8D2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4487f17-c204-48e1-0c28-08d9138e13cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 08:31:58.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofublvV8oBooBGmbf8MoeYVHypCVzSOR0Dca4HcekiYQ6lIhNf4CXjFgSzzQQTXp1aAK359pgTMAIM0/sire8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5952
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXkgMTAsIDIwMjEgYXQgMDQ6MDA6MjFQTSArMDgwMCwgQWlsaSBZYW8gd3JvdGU6
DQo+IE9uIE1vbiwgMTAgTWF5IDIwMjEgMDc6MjE6MjggKzAwMDANCj4gSE9SSUdVQ0hJIE5BT1lB
KOWggOWPo+OAgOebtOS5nykgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPiB3cm90ZToNCj4gDQo+
ID4gT24gRnJpLCBNYXkgMDcsIDIwMjEgYXQgMDU6Mzg6NTJQTSArMDgwMCwgQWlsaSBZYW8gd3Jv
dGU6DQo+ID4gPiBPbiBUdWUsIDI3IEFwciAyMDIxIDE1OjI5OjUzICswOTAwDQouLi4NCj4gPiA+
IEFuZCBJIHRoaW5rIHRoZSB2aXJ0dWFsIGFkZHJlc3MgYWxvbmcgU0lHQlVTIGlzIG5vdCBtZWFu
IHRvIGJhY2t0cmFjZSB0aGUgY29kZSwgaXQganVzdCB3YW50IHRvIHRlbGwgd2hlcmUgdGhlIGVy
cm9yIG1lbW9yeSBpcywgZm9yIG11bHRpIHB0ZQ0KPiA+ID4gZW50cnksIG9uZSB2aXJ0dWFsIGFk
ZHJlc3MgZm9yIHRoZSBzYW1lIHBoeXNpY2FsIHBhZ2UgaXMgbm90IGVub3VnaD8NCj4gPiA+IA0K
PiA+ID4gQ29tcGFyZSB0aGlzIHBhdGNoIHdpdGggbXkgUkZDIHBhdGNoLCBkaWZmZXJlbmNlOg0K
PiA+ID4gMS5UaGlzIHBhdGNoIHdpbGwganVzdCBmaXggdGhlIHJhY2UgaXNzdWUncyBpbnZhbGlk
IHZpcnR1YWwgYWRkcmVzcy4gd2hpbGUgbXkgUkZDIHBhdGNoIHdpbGwgY292ZXIgYWxsIHRoZSBl
cnJvciBjYXNlIGZvciByZWNvdmVyeTsNCj4gPiA+IDIuRm9yIG11bHRpIGVudHJ5LCB0aGlzIHBh
dGNoIHdpbGwgZG8gb25lIGZvcmNlX3NpZyB3aXRoIG5vIG90aGVyIGluZm9tYXRpb24sIEJ1dCB0
aGUgUkZDIHBhdGNoIHdpbGwgdGFrZSBvbmUgcG9zc2libGUgcmlnaHQgYWRkcmVzcywgSSBkb24n
dCBrbm93IHdoaWNoIG9uZSBpcyBiZXR0ZXIuDQo+ID4gPiANCj4gPiA+IEFuZCBpZiB0aGlzIG11
bHRpIHB0ZSBlbnRyeSBpcyBvbmUgcmVhbCBpc3N1ZSwgaXQgc2VlbXMgdGhlIG5vcm1hbCByZWNv
dmV5IHdvcmsgd2lsbCBhc2xvIHRyaWdnZXIgdGhpcywgd291bGQgaXQgYmUgYmV0dGVyIHRvIGZp
eCB0aGF0IGZpcnN0PyAgDQo+ID4gDQo+ID4gQXNzdW1pbmcgdGhhdCB5b3VyIFJGQyBpcyBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjEwMzE3MTYyMzA0LjU4ZmYxODhjQGFsZXgtdmly
dHVhbC1tYWNoaW5lLywNCj4gPiBpdCBzaW1wbHkgdXNlcyB0aGUgZmlyc3QtZm91bmQgdmlydHVh
bCBhZGRyZXNzLiAgSSBzdGFydCB0aGlua2luZyB0aGF0IHRoaXMNCj4gPiBhcHByb2FjaCBjb3Vs
ZCBiZSBmaW5lLiAgQW5kIGl0J3MgZWFzeSB0byBjaGFuZ2UgdGhlIHBhdGNoIHdpdGggdGhpcyBh
cHByb2FjaC4NCj4gPiBJIGhhdmUgbm8gcHJlZmVyZW5jZSwgc28gaWYgeW91IGxpa2UsIEkgc3dp
dGNoIHRvIHRoZSAiZmlyc3QtZm91bmQiIGFwcHJvYWNoLg0KPiANCj4gSGkgTmFveWE6DQo+ICAg
VGhhbmtzIGZvciB5b3VyIHJlcGx5IQ0KPiAgIFllcywgeW91IGNhbiBjaGFuZ2UgdG8gdGhhdCBS
RkMgYXBwcm9hY2gsIGJ1dCB0aGVyZSBtYXkgYmUgc29tZSB1bi1pbmRlbnRpZmllZCBpc3N1ZWVz
LCBhbmQgbmVlZCBtb3JlIGNvbnNpZGVyYXRpb25zIHRob3VnaC4NCj4gICBBbmQgdGhlcmUgbWF5
IGJlIG90aGVyIG1ldGhvZCB0byBhZGRyZXNzIHRoaXMsIHlvdSBjYW4gYWxzbyBkaWcgaW50byB0
aGF0LCBnZXQgaXQgcmVhbGl6ZWQgYW5kIHBvc3RlZC4NCj4gICBJIGFtIE9LIHdpdGggYW55IG9w
dGlvbi4NCj4gICBCdXQgZm9yIGhlcmUsIEZyb20gdGhlIGJlZ2lubmluZywgSSB0aGlua3MgdGhl
IGludmFsaWQgYWRkcmVzcyBpc3N1ZSBhbmQgcmFjZSBpc3N1ZSBhcmUgdHdvIGRpZmZlcmVudCBp
c3N1ZXMsIG1heSBoYXZlIHNvbWUNCj4gcmVsYXRpb25zaGlwIGJ1dCBzdGlsbCB0d28gaXNzdWVz
IGluIG15IG1pbmQuDQo+ICAgd2hvdWxkIHlvdSBwbGVhc2Ugc2VwZXJhdGUgdGhpcyBzZXJpZXMg
cGF0Y2hlcyBpbnRvIHRocmVlIGFnYWluPw0KDQpPSywgSSdsbCBkbyBpdC4NCk1heWJlIHRoYXQn
cyBoZWxwZnVsIGlmIHdlIGNvbnNpZGVyIHRvIHNlbmQgc29tZSBwYXJ0IG9mIHRoZSBzZXJpZXMg
dG8gc3RhYmxlLg0KDQotIE5hb3lh
