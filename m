Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23A235427B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhDENu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 09:50:27 -0400
Received: from mail-eopbgr1410042.outbound.protection.outlook.com ([40.107.141.42]:45408
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233806AbhDENu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 09:50:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9Ov9vEu9zDfbjNcW/lTrbdMIBCUum5YKOqUlqETic82CtaIRePTO0TOmNPwTTp15FXiL63P199SwWTapBZSR1OGH8LStznPMtDu9VYp77UmZk3D+c7pWTnebwzsa93fEcRBPLT8v2ZF9WSSBnETmFEHzZEGmdUTfAYjiIQk3opOFeRiKdqIeHyAYxfAxbAkzHQJubFfXInNOp29giPPIvJljwbI2dD4QzmEaAYUpYwxaeLXXdVIpeXrKHDXiBRk7vY0JGFg34AJ31uf/iSbIue5jLQIve/zp52vG+XDdxBrHVg6PJocOp7up3IduMW/bKqgPbUrQZMYwrJpLxvK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlKe2wTzpnM+NS8o7XuoQteF1ui2DgQSCI+mFzgCLlw=;
 b=Cj8I6KpSTFkdJ9WFjY1qcPZgDUB+w3iR5ddLFzfect0dVcXoAjd5Vbe4vuvUVuB+F11e+C0oqZJkUEadqbMw9oAu+6mNDSnPZqvTdAdyybpyJXCIFZctb2bs3kCyLco50Yu7VVVF0oZh6qFuzm3RV4NyRInnXOGo5TG/0oSf09O8vu/l60yqwABbPrH7HewhTZOW/+vrwkB3dltbpTbX20YHrLBzDUReieDAZsS4fmgPijy1XSIJwQHsY3lZ73kns/OSDIb/0AH8p5LDzuMQDtiC6UMRXOIG61Efdem6kYEg/dBczi4HCLkeZ9x5OBzGmDsfLJr7X9N/E96Nlk8PbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlKe2wTzpnM+NS8o7XuoQteF1ui2DgQSCI+mFzgCLlw=;
 b=XZt2fzuY8Mh6ya0gEF6EiChwx51LntJo+NMbqj2HO+sEIwZk57I3tfghVoy46e4T2+XEG6cdiKwsZrTaIXEZE1cOqPoGki+rDbRo90VtBUr+GzGxu38ZD/U8gmKl3KuonxV7vPwjFVqb39ZUjofMJsDaVocKLHZBIAaF7Guorlc=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB6445.jpnprd01.prod.outlook.com (2603:1096:400:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 13:50:18 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 13:50:18 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Aili Yao <yaoaili@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>
Subject: Re: [PATCH v3] mm,hwpoison: return -EHWPOISON when page already
 poisoned
Thread-Topic: [PATCH v3] mm,hwpoison: return -EHWPOISON when page already
 poisoned
Thread-Index: AQHXJiCdggusTB+xD0Gxw5Y8NXSvk6qfzG4AgACjcwCAAOi9AIAEoFmA
Date:   Mon, 5 Apr 2021 13:50:18 +0000
Message-ID: <20210405135017.GA6504@hori.linux.bs1.fc.nec.co.jp>
References: <3690ece2101d428fb9067fcd2a423ff8@intel.com>
 <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
 <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
 <20210309100421.3d09b6b1@alex-virtual-machine>
 <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
 <20210309143534.6c1a8ec5@alex-virtual-machine>
 <20210331192540.2141052f@alex-virtual-machine>
 <20210401153320.GA426964@agluck-desk2.amr.corp.intel.com>
 <20210402091820.04d7c3e0@alex-virtual-machine>
 <a10c7838216e4a10b4fd5ebb0f1108a1@intel.com>
In-Reply-To: <a10c7838216e4a10b4fd5ebb0f1108a1@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88e70bc0-dd87-4cf1-664b-08d8f839bf92
x-ms-traffictypediagnostic: TYCPR01MB6445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB64451DEF20F93B84BDAB5E83E7779@TYCPR01MB6445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3qqBJQiGKVyn4iKAnWWv9lEWAdZt2gG7XL+6xe5LUf4hHCHA4BaIAIe9qsryOXa/Yjp6Ze4+WYs3ADBxQqs9/jpAvYwrpXHvwgR7niu3TrFdUY1xVH0ogg5UBKcHnj9zWDU+e0JVR6JS72EP0bzMKGOR5TtuOG4fPxcW8rlHWoJpLVWFn27rBLw0DbXIJoulIWNrPUlwTxgJEnQJvpmb9JN9Gb6RIj2fa4bZVpNa5cUHQxAcy/4XJVWVq37GY+f3u8JsbjCxfuBvGq6IApDqmLZi8t80qCPzp/3ousdZoD1grbVu+E3r3+9ADOBMzvcmqgvqo2i4lJWnXbYs5sO9w0PuEzQtAgp4P+C9Ivmt/x6m+akz7o0LsuiqC971PtjtCwOjYPLzDX4AmDRuCPLHJ62gaZO8/KAkvs/kijb9TLnhKVUs02x5QfZT7ZwX4P3hun1B6ysNi0am5pl2JgEmpC1FSgVKfVaZtPPcSuydsXbY6/udRNQYYt1q0boeFuRriOejhPTkA8uKnzLaKHZnvOTcAVAk1wNZAW50sGGNQEWzm6qx95c3nzxqVLLLVSNf7sgr1L8svwVWpIqZu0Z8LRJVCh7FhDuo2ReFu36AQtfFBvwWtVlzZ0KgkDWi3ceQCS3acouEQsIV83K8kakNAJiX9PyBY2zVLKbb6t5GACI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39850400004)(346002)(136003)(86362001)(71200400001)(83380400001)(1076003)(9686003)(6512007)(54906003)(6916009)(66446008)(5660300002)(8936002)(6486002)(76116006)(316002)(55236004)(6506007)(66476007)(186003)(64756008)(66556008)(8676002)(478600001)(2906002)(66946007)(33656002)(85182001)(4326008)(26005)(38100700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?U3F0SHE4ZS8rNncyNkVGalQ3ckN3Sk53ZVAwb0JWMk9iMElvVDF2N3pNWENr?=
 =?utf-8?B?UGdCbXFZQks5bTEzWGJZcEgwbFdRbTZNaVNXZWJ5NFl4Q202OEw3eUhNdnBI?=
 =?utf-8?B?SU9lZGFndFV0RFkvRkw2SGlpRHRPZ2tNNkc3VnUvZHc0WDNFQXBrTGRici9B?=
 =?utf-8?B?SnZKWXlzb0pWdXhlQmF5eGsrRktlZkkwbWtOdlhGTDV6M2tqL1FyRk01eGpZ?=
 =?utf-8?B?S0c3NjBkT20zTVkxZkpEYnFTa0Zqa2ZpTDRwQzQvSEZVSnZsMitPUEl0ZGsz?=
 =?utf-8?B?Rm1ySEFDcS9VbUpxeEllV1V5b2VTSFQyays0VjZwZmVBWXZCelJtTGxCYTdI?=
 =?utf-8?B?M1cwZ3BGMDRxWjBhY1MxeUZhN0xwU0NoRStsZVhyK3g1dUxWclZSdDVKV3JL?=
 =?utf-8?B?MzhxT3FVUG9tNFBDdXQxQ0ptK3R5UVZtV1FGTGR5c3gybTIvbGtWWkJaSEo3?=
 =?utf-8?B?enVqLzkzdHM1TVBPaVNNUVhnYUhBSVZ4OVUzNXFKbzZ3RjRxdGlCdnZCT1Fq?=
 =?utf-8?B?a0xpaGdMU3ZjSjEycUZHNElnRFZudzdZUnYwSDFsNHhMd05VRHpZQTAvdGNn?=
 =?utf-8?B?dUpBeUx2UHFLTlZrZmNpSzlSWS9LR255MHZROG0zcHNVaWdXenVQZjBUWXc0?=
 =?utf-8?B?RkwzYXduMVh2ejVpdFJDeVJtMTJJbCtRQXZaUmVoSzFNUlNsaWQ3dmpVTlll?=
 =?utf-8?B?NWJPMEc1dXNhNUk0QWFiRGhaZ21jeWp0Z0tPbDZBc291cHBSQm1OblVBUkt4?=
 =?utf-8?B?RldsbStjZjdHWXpVQUt5R2l2ZEJ1UHhGYjEzUFoyVk5Gb0tOMS8zVXFKL1Rn?=
 =?utf-8?B?c0E4bERpblppQ1daUmdreU94elFTMVE2N3hMSzYzK3pTSVNzNFBRenFPRzVk?=
 =?utf-8?B?Zm5JbVhvbHVYbFowMDJzQ2FEb2RoOG1JdmdhK2ZLc3lKVER5RW1CMXpYR3JQ?=
 =?utf-8?B?SDNnRVpUdXVzN0pJWUF3QUhIenpUd3lXejFLdHBONFRsRGZuNlgyTmdISkZi?=
 =?utf-8?B?MWczVUxGbmdiMjZRNEFBM1RSUUlVRXVrWEVRZklPbVV1NE05TjEwcSsxWG5w?=
 =?utf-8?B?Qk95Y1QxbnhkVnU3RDB2eVlGMmV3bmdjbGRDWFJVei9qWjl1WGZwa3ZHelZP?=
 =?utf-8?B?T2s5MnZvblZvOWdNVkdYM1JHKzVTbGRZNkw0TFF4b1F2U3dUN3BQNGMxbjJL?=
 =?utf-8?B?SE1nNmI1UTVFYXJnWGt0TEVOdGtMaDl1UHljdVpZMDdLTjk5TTUxUXpBUTF6?=
 =?utf-8?B?eE5Zcm5YdXBZd2VlbmJyVGVJU3k2QkszdGxkVmZtVGlBV3VBM2pRenVnZkt4?=
 =?utf-8?B?MjNGTVYrRG1CVGJTcnU5NzhPMXNhQ2s1TmtDZFpvVVNCd05FZ0o3Skdqak5l?=
 =?utf-8?B?akNDNllFakczU1hWM0FxamQ3OWl2MzRPMGJKTzh4cmxITWVKUll6OTVJZXUr?=
 =?utf-8?B?dTdxQ2loL2ZlOXdhaXhIeDFNTXcrYlFBeHRJbGVnMGlvSHRoL3ZhOFFZNWRR?=
 =?utf-8?B?bVI2QkRHbkI2NXB3Zk5IVmZEVHRxcktZNzZjMzBLMHdDNDFldWtjNHEwanNs?=
 =?utf-8?B?OUJHUTVLbStIK0l2WXJoTDJiY1Y3UjVEYlNwVVlyZERQRlJ3bTF0dVFlOUZi?=
 =?utf-8?B?aWlWVVRzb2VvRWdSdW55ejFRblZSMkNTZkZ6bGFoNHNxWGRjaWpkUURrU05U?=
 =?utf-8?B?aE83aC96eW5lYnNaaVdEOTFPaFlYZW9ITkJJYlJFU0g2R3JSWHZwWjBrRDJp?=
 =?utf-8?B?UjZJNm14Q0hGUE1HN05YRlBqbUFCZEdUVjZQdktsMmc1MS8wdjBaQ1I3cWlU?=
 =?utf-8?B?cVI5aFRkK2JZdzRhTnBPQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBC5D431E9E93F45BBF9C07017CA6FC3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e70bc0-dd87-4cf1-664b-08d8f839bf92
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 13:50:18.2522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84hwZzpwUKAwl31UVyqGS4L6SeLqPE1JZmkNoWxOvhmNBTLokx+UtSTdE/HSGvKo1/bb+PD2hYMX7WccAcOSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6445
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBcHIgMDIsIDIwMjEgYXQgMDM6MTE6MjBQTSArMDAwMCwgTHVjaywgVG9ueSB3cm90
ZToNCj4gPj4gQ29tYmluZWQgd2l0aCBteSAibXV0ZXgiIHBhdGNoICh0byBnZXQgcmlkIG9mIHJh
Y2VzIHdoZXJlIDJuZCBwcm9jZXNzIHJldHVybnMNCj4gPj4gZWFybHksIGJ1dCBmaXJzdCBwcm9j
ZXNzIGlzIHN0aWxsIGxvb2tpbmcgZm9yIG1hcHBpbmdzIHRvIHVubWFwIGFuZCB0YXNrcw0KPiA+
PiB0byBzaWduYWwpIHRoaXMgcGF0Y2ggbW92ZXMgZm9yd2FyZCBhIGJpdC4gQnV0IEkgdGhpbmsg
aXQgbmVlZHMgYW4NCj4gPj4gYWRkaXRpb25hbCBjaGFuZ2UgaGVyZSBpbiBraWxsX21lX21heWJl
KCkgdG8ganVzdCAicmV0dXJuIiBpZiB0aGVyZSBpcyBhDQo+ID4+IEVIV1BPSVNPTiByZXR1cm4g
ZnJvbSBtZW1vcnlfZmFpbHVyZSgpDQo+ID4+IA0KPiA+IEdvdCB0aGlzLCBUaGFua3MgZm9yIHlv
dXIgcmVwbHkhDQo+ID4gSSB3aWxsIGRpZyBpbnRvIHRoaXMhDQo+IA0KPiBPbmUgcHJvYmxlbSB3
aXRoIHRoaXMgYXBwcm9hY2ggaXMgd2hlbiB0aGUgZmlyc3QgdGFzayB0byBmaW5kIHBvaXNvbg0K
PiBmYWlscyB0byBjb21wbGV0ZSBhY3Rpb25zLiBUaGVuIHRoZSBwb2lzb24gcGFnZXMgYXJlIG5v
dCB1bm1hcHBlZCwNCj4gYW5kIGp1c3QgcmV0dXJuaW5nIGZyb20ga2lsbF9tZV9tYXliZSgpIGdl
dHMgaW50byBhIGxvb3AgOi0oDQoNClllcywgdGhhdCdzIHRoZSBwYWluIHBvaW50LiAgV2UgbmVl
ZCBzZW5kIFNJR0JVUyB0byB0aGUgY3VycmVudCBwcm9jZXNzIGluDQoiYWxyZWFkeSBoYXJlZHdh
cmUgcG9pc29uZWQiIGNhc2Ugb2YgbWVtb3J5X2ZhaWx1cmUoKS4gIFNJR0JVUyBzaG91bGQNCmNv
bnRhaW4gdGhlIGVycm9yIHZpcnR1YWwgYWRkcmVzcywgYnV0IHVuZm9ydHVuYXRlbHkgd2Fsa2lu
ZyB0aGUgcGFnZSB0YWJsZQ0Kb3IgdXNpbmcgcC0+bWNlX3ZhZGRyIGlzIG5vdCBhbHdheXMgcmVs
aWFibGUgbm93Lg0KDQpTbyBhcyBhIHNlY29uZC1iZXN0IGFwcHJvYWNoLCB3ZSBjYW4gZXh0ZW5k
IHRoZSAid2Fsa2luZyBwYWdlIHRhYmxlIg0KYXBwcm9hY2ggc3VjaCB0aGF0IHdlIHdhbGsgb3Zl
ciB0aGUgd2hvbGUgdmlydHVhbCBhZGRyZXNzIHNwYWNlIHRvIG1ha2Ugc3VyZQ0KdGhhdCB0aGUg
bnVtYmVyIG9mIGVudHJpZXMgcG9pbnRpbmcgdG8gdGhlIGVycm9yIHBhZ2UgaXMgZXhhY3RseSAx
Lg0KSWYgdGhhdCdzIHRoZSBjYXNlLCB0aGVuIHdlIGNhbiBjb25maWRlbnRseSBzZW5kIFNJR0JV
UyB3aXRoIGl0LiAgSWYgd2UgZmluZA0KbXVsdGlwbGUgZW50cmllcyBwb2ludGluZyB0byB0aGUg
ZXJyb3IgcGFnZSwgdGhlbiB3ZSBnaXZlIHVwIGd1ZXNzaW5nLCB0aGVuDQpzZW5kIGEgbm9tcmFs
IFNJR0JVUyB0byB0aGUgY3VycmVudCBwcm9jZXNzLiAgVGhhdCdzIG5vdCB3b3JzZSB0aGFuIG5v
dywNCmFuZCBJIHRoaW5rIHdlIG5lZWQgd2FpdCBpbiB0aGUgaG9wZSB0aGF0IHRoZSB2aXJ0dWFs
IGFkZHJlc3Mgd2lsbCBiZQ0KYXZhaWxhYmxlIGluIE1DRSBoYW5kbGVyLg0KDQpBbnl3YXkgSSds
bCB0cnkgdG8gd3JpdGUgYSBwYXRjaCBmb3IgdGhpcy4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1
Y2hp
