Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3436F3F4492
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 07:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhHWFGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 01:06:11 -0400
Received: from mail-eopbgr1400047.outbound.protection.outlook.com ([40.107.140.47]:42708
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229462AbhHWFGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 01:06:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeAupA1GVOH4QAsDxivPcj9o01TYbax9o+lz+wOwVN7BfoeLfYTiyUX28TDBxCjBsrxfMIULiLwmR1LV9uZ766H6gHRx7PMrW6m4Xpv2pmDg7Z0tVXrB+A4B7dwm4AcXTarRoBNwJ+8qAR1JUwT8J8yNGLcixVRvbKBKEavHlePm4CQopWpbfu5hNViiyeE8749ArnxzESftKwJ1XY//rWgEFwjPsVWA8jUvlf8YtG6P2Dk/8oROexYX+/+qUfqIMhRneBQAY+uA04gPAKm1nImKt8TTPQJObKxpyl74uLer3+8L5rmUpBPDNQdvg4IWGYQzgRvAj5OealM+Sog4mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ+p2vFIwc/KPEcSI9wTLTJ2QFLdX1VNwUxw5KgwqvY=;
 b=BtUNrxz3zZ1iy50bfFG3X8CnnN8bTaM30BVdhcjt61MFbVxZ4Pd4+n+rydeRNc/whLkyj3uz054WOk0iPMBNSl+PxkvzNjwS7NND/t28Pug3ha075WGJ+gUGFuayjIk8qRbcEeAnKJdU2x8sEelyS3VQhDnuzpD8n7Gj8eqVL9PHOb6SW//rza8h4sMODa+EA9Gm9FYadShwUQ5iYYP9msywadcb/ijMdD3UTQ3B1ejbCHxl6E0MHJRH/YBUM7iMAtR4yjnIkTkLRDbkEYD4CPCzJBdXIXy7Nnvcn0x/MfBSV6e+5/rs7NYVZQJBkKNEB1pr6e2ouZmqUx4Jr2VS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ+p2vFIwc/KPEcSI9wTLTJ2QFLdX1VNwUxw5KgwqvY=;
 b=ETCchRSx1viHbOeGZ6KJmYAYBJ3dXmxoJpgOTtP9yKLdxJKM52YyuXaElXvDKbqov5MYeJzSchUQfzXmiFaK/9budEOJDIGf2qWV+o4R0/l/gZKwL9a+HiOyLvHo+akFuvaeylJdtpZKWf3R8R1IwrgK8YufEDhVJlu/VV8WtuY=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 05:05:26 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 05:05:26 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "osalvador@suse.de" <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        "david@redhat.com" <david@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Thread-Topic: [v2 PATCH 3/3] mm: hwpoison: dump page for unhandlable page
Thread-Index: AQHXlLzdYeiiCRicSE2McTnzojcv9qt79U4AgADG5ACAA9NMAA==
Date:   Mon, 23 Aug 2021 05:05:26 +0000
Message-ID: <20210823050526.GA1452382@hori.linux.bs1.fc.nec.co.jp>
References: <20210819054116.266126-1-shy828301@gmail.com>
 <20210819054116.266126-3-shy828301@gmail.com>
 <20210820064832.GA63355@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkqnBbqz7rHTQWsBKdq5uSdKDJX=iDz+HDyF2Jo6CX3H1g@mail.gmail.com>
In-Reply-To: <CAHbLzkqnBbqz7rHTQWsBKdq5uSdKDJX=iDz+HDyF2Jo6CX3H1g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6106108-e66b-4469-00ae-08d965f39ef1
x-ms-traffictypediagnostic: TYCPR01MB5936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB593628F59026ABEA8E364B5AE7C49@TYCPR01MB5936.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RHWsdt1hnVJ8EWlv7p71UXHA5uKtL8VWNm9zWt3Tdy5gI+lkXOMAQmHSHXMPDvPOlkc6JrCQS7ifRBBSl45f7RPrAINJLAuK0lgAbMsN6O/NCO5PTwI+n0mitAuXQYnXbpZt77M62gV+bMc7pIqzbnM67/ljVf2wcfO7xflUT8jFcXVBqVBBvdVto8hh5DzHHyLxIIS8PIIOFbQHI0/ERI1u5qrejr3dNsC/uSJF4iWMFn8xhfT6ML3s0SZwYREKEYZ2joxRemc6WtLnAqUr5XFit+n7Q/5LgYMXEq6ThxXnkFdxRqld+rHCA2SranLIG5GqWPwTPV7dqOZD7XPJ/7GTNzKY67dsiG4APQRRz2+ZItbVQpMPaoJN5NN4a4ag+tTnUOV/qEik9MPN3YmMtkB+jZ8aeMeaL12PgK1kM6BF8X74FfjDES8mFFZQuu9PIy7wuQTlPX+Hxy7bN2PZCdoXMI8vsW88lyFbQaVCEIhcJ96m1lsvnBbxXJiCYQBiwergUvVbvcIcWXhPdyU2kclM9QZzDmbr4nX38ckOEh1LZFYF3AYCqMdsjMGI4IISAEeDzqGQMBS0UfDYv8Km7ci+4CQHvcy804GpXncW9FzQBqxfC4Tiw753c1DC7qh57AufeJsyQwW9QFUWteaiGcVi4hBMIZKawhGS6nofMliiLftH7p1cetCzKbsqE/gh08cOqMNix0hRlRboX52UBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(26005)(38070700005)(8936002)(86362001)(76116006)(8676002)(55236004)(9686003)(6512007)(122000001)(5660300002)(6506007)(83380400001)(71200400001)(66446008)(186003)(6486002)(64756008)(66476007)(66556008)(66946007)(2906002)(54906003)(53546011)(316002)(38100700002)(4326008)(33656002)(478600001)(85182001)(1076003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUc3b2tSNkc2QjFCTms0KzlXTGhNeTBnRjNoYVpGekpwMkk3SGl2U3d3aFN4?=
 =?utf-8?B?bmtSUDVqdWwyak5Eb3Y2RldONjZEUG44YTBKNjFnS1FUb3EzMHMybVVPaTZ0?=
 =?utf-8?B?aXVDWW14UUdIV01mcENBTTB4a0tZUy94R1Q2UTlobWttdTB4T1BiMURVR0o4?=
 =?utf-8?B?RVJSZXMwRDBlUHFvYlZWVWhudFJQdk03ZFdWek5vbUo2U1hoWndIWWd6Tkgx?=
 =?utf-8?B?YUt1NE9kQ1hVVVdtUjVIc0Fqc0pmUWRRT0p0MWhOWEoySkw5VHRKVGZRNC9m?=
 =?utf-8?B?eDE0dndON2Q3SHNmbEhPcHI4S1A0bUxHTnU1dEg3K1h4cnpMYmZsRlBBU0d6?=
 =?utf-8?B?RmN2WEpVdzdvVloyd24rR2U3TXVmYUNaS3VqWEFuR2JLYkN2b08vTFg2RkNu?=
 =?utf-8?B?aDYrTFFrL2x6djJ0Y1dQK0Nud1JOMmlaSWJnQ1VYQnp6cXhEamhVdlNYNEVV?=
 =?utf-8?B?a2kzZG5rNHhqWFNDTEExNzlWYkovT1RqanZJMVNFOHNtQXBjWFV5dTREVnpx?=
 =?utf-8?B?YVpONGxEVkFLM0xXMVN2QjJpVmdsRHVzS0VBV21aNkxUUHVEd0t0Zk1wWUtI?=
 =?utf-8?B?cUNaU0VEUTBSZlZkbTFIT2pIdXRuekZTcDVMMlhZdlJpYWxDVDIrWitwdWs2?=
 =?utf-8?B?VkFPSHRxdnU0WGpQUkZ3azRvVWIrOHBjaHR5ZlhaM2dYNlJad0NWcDJKU2tw?=
 =?utf-8?B?YXBIZHVNTVZHNDdLZXlDaWF0Y2Q2eSszVHRqSzJyeGpIL2lwbnA0VmxCYWhy?=
 =?utf-8?B?R2FReW1xdlVoQzZkaTVUM0VaSXZiWlVtSmFXSDd4UTR4TkJkVW4rSy9RTWJl?=
 =?utf-8?B?blBNdUlaazYxY1lZbk9UeXBFcVYybzdJMnR0VWFkU29WOUVybjlFSzlCOHQ4?=
 =?utf-8?B?QlFIbURGYU0xTTAyV2h5SVdTNjV3S0RpV01DcHQvcTJOdEhISk5HRWVTN0Yv?=
 =?utf-8?B?SGhzMTFFZ2ltb0YxL1JCeWcxWThVVFJ0bEgvOTNyWjVydUpvLzVTMFN2RU9y?=
 =?utf-8?B?OTdqdjhXM2kvRnE0aEpMalV0ZU1YOGNPSlJJUHJkUmY0cHZkeFlNN1A5NVdx?=
 =?utf-8?B?SE5jejBoaTQ1eldTYjdiaW8wOTZDOXd0d2FrMDc5OGR0aml4V3Q0bjE2amY5?=
 =?utf-8?B?WG55d0lVdzdjZWFCaUNvZnRaaHlZdU9EMlpsbnFleG51TUN2S0ZadFBqZ0pB?=
 =?utf-8?B?OGcwVEl0MUg4T29jSERFaW1qL1JKN3NIbFM1R1FuVW84U3ZHdHp1cGdaekha?=
 =?utf-8?B?QVA4THVLNU5sUi9Ea1ozYW02WUxwKy9HMWpyL1ZmSUNRR0lLQlVVQjFjanlV?=
 =?utf-8?B?SWtVMk5hQUZKR1A4dmJ4dkFrNjF0NWFuNG5Udjl5UGtGQlJnZ21peUk4RENJ?=
 =?utf-8?B?N3Zta25INVhnS1hRTTJ5WXNRb3FBSCs1WVEyUkZGdGVYblU1bk1wLzg4ZWFz?=
 =?utf-8?B?MWgxYS83bUhia2hUL3UwYXZVckVhQnlQeHZLRm1XZVF4ZC96VTZsUHY3OWFz?=
 =?utf-8?B?V1NWRktaOXJXdTQzendEM0FDMHpSRldyNkpvZHFZdmwxVE05anp0V0p1THRH?=
 =?utf-8?B?ek5ybDFHK3dVMW9QSWoxWmo4MExiUjBWOHpCVlorUGUzMm82MzFtQW9tTEZw?=
 =?utf-8?B?L1BSOUlNcTFhTGpsQlIrRnNiLzU3MnZFR0I3SkdpYXE5M0hSV251TG9sdVYx?=
 =?utf-8?B?Rk9oVjJQMnVEQkE4OGkvalN1U2d3ajdNWWN4WGlHYllpZ09IT0xvbWl3S1d4?=
 =?utf-8?B?d050bmVBQUcyOFRhQlpsRU12aks4VnA0eEc1ejhsTVlldStPa1pyOUNBZE5o?=
 =?utf-8?B?UitYdmVEWDJjRW96MWc1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4DD7675F6A9AA469A316FFD721AB8AE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6106108-e66b-4469-00ae-08d965f39ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2021 05:05:26.7148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ojbC4ROHOI4drEK0LV0fwv4imXAzBtb7ulIhpPshOAhIazPhuPUG0l4yPjI8lBN6jSMtNnL3Z6gTPp3SpqNhEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBdWcgMjAsIDIwMjEgYXQgMTE6NDA6MjRBTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IE9uIFRodSwgQXVnIDE5LCAyMDIxIGF0IDExOjQ4IFBNIEhPUklHVUNISSBOQU9ZQSjloIDl
j6PjgIDnm7TkuZ8pDQo+IDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBPbiBXZWQsIEF1ZyAxOCwgMjAyMSBhdCAxMDo0MToxNlBNIC0wNzAwLCBZYW5nIFNoaSB3cm90
ZToNCj4gPiA+IEN1cnJlbnRseSBqdXN0IHZlcnkgc2ltcGxlIG1lc3NhZ2UgaXMgc2hvd24gZm9y
IHVuaGFuZGxhYmxlIHBhZ2UsIGUuZy4NCj4gPiA+IG5vbi1MUlUgcGFnZSwgbGlrZToNCj4gPiA+
IHNvZnRfb2ZmbGluZTogMHgxNDY5ZjI6IHVua25vd24gbm9uIExSVSBwYWdlIHR5cGUgNWZmZmYw
MDAwMDAwMDAwICgpDQo+ID4gPg0KPiA+ID4gSXQgaXMgbm90IHZlcnkgaGVscGZ1bCBmb3IgZnVy
dGhlciBkZWJ1ZywgY2FsbGluZyBkdW1wX3BhZ2UoKSBjb3VsZCBzaG93DQo+ID4gPiBtb3JlIHVz
ZWZ1bCBpbmZvcm1hdGlvbi4NCj4gPiA+DQo+ID4gPiBDYWxsaW5nIGR1bXBfcGFnZSgpIGluIGdl
dF9hbnlfcGFnZSgpIGluIG9yZGVyIHRvIG5vdCBkdXBsaWNhdGUgdGhlIGNhbGwNCj4gPiA+IGlu
IGEgY291cGxlIG9mIGRpZmZlcmVudCBwbGFjZXMuICBJdCBtYXkgYmUgY2FsbGVkIHdpdGggcGNw
IGRpc2FibGVkIGFuZA0KPiA+ID4gaG9sZGluZyBtZW1vcnkgaG90cGx1ZyBsb2NrLCBpdCBzaG91
bGQgYmUgbm90IGEgYmlnIGRlYWwgc2luY2UgaHdwb2lzb24NCj4gPiA+IGhhbmRsZXIgaXMgbm90
IGNhbGxlZCB2ZXJ5IG9mdGVuLg0KPiA+ID4NCj4gPiA+IFN1Z2dlc3RlZC1ieTogTWF0dGhldyBX
aWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+DQo+ID4gPiBDYzogTmFveWEgSG9yaWd1Y2hpIDxu
YW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiA+IENjOiBPc2NhciBTYWx2YWRvciA8b3NhbHZh
ZG9yQHN1c2UuZGU+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFNoaSA8c2h5ODI4MzAxQGdt
YWlsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCAzICsrKw0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZm
IC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gPiA+
IGluZGV4IDdjZmExMzRiMTM3MC4uNjBkZjhmY2QwNDQ0IDEwMDY0NA0KPiA+ID4gLS0tIGEvbW0v
bWVtb3J5LWZhaWx1cmUuYw0KPiA+ID4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ID4g
QEAgLTEyMjgsNiArMTIyOCw5IEBAIHN0YXRpYyBpbnQgZ2V0X2FueV9wYWdlKHN0cnVjdCBwYWdl
ICpwLCB1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPiA+ID4gICAgICAgICAgICAgICByZXQgPSAtRUlP
Ow0KPiA+ID4gICAgICAgfQ0KPiA+ID4gIG91dDoNCj4gPiA+ICsgICAgIGlmIChyZXQgPT0gLUVJ
TykNCj4gPiA+ICsgICAgICAgICAgICAgZHVtcF9wYWdlKHAsICJod3BvaXNvbjogdW5oYW5kbGFi
bGUgcGFnZSIpOw0KPiA+ID4gKw0KPiA+DQo+ID4gSSBmZWVsIHRoYXQgNCBjYWxsZXJzIG9mIGdl
dF9od3BvaXNvbl9wYWdlKCkgYXJlIGluIHRoZSBkaWZmZXJlbnQgY29udGV4dCwNCj4gPiBzbyBp
dCBtaWdodCBiZSBiZXR0ZXIgdG8gY29uc2lkZXIgdGhlbSBzZXBhcmF0ZWx5IHRvIGFkZCBkdW1w
X3BhZ2UoKSBvciBub3QuDQo+ID4gc29mdF9vZmZsaW5lX3BhZ2UoKSBzdGlsbCBwcmludHMgb3V0
ICIlczogJSNseDogdW5rbm93biBwYWdlIHR5cGU6ICVseCAoJXBHcCkiDQo+IA0KPiBObyBzdHJv
bmcgb3BpbmlvbiB0byBrZWVwIG9yIHJlbW92ZSBpdC4NCg0KUmVhZGluZyB0aGUgZXhwbGFuYXRp
b24gYmVsb3csIEkgdGhpbmsgdGhhdCBjYWxsaW5nIGR1bXBfcGFnZSgpIGluIHRoZQ0Kb3JpZ2lu
YWwgcGxhY2UgaXMgZmluZS4gIFNvIGxldCdzIHJlbW92ZSAiZWxzZSBpZiAocmV0ID09IDApIiBi
bG9jayBpbg0Kc29mdF9vZmZsaW5lX3BhZ2UoKS4NCg0KPiANCj4gPiBtZXNzYWdlLCB3aGljaCBt
aWdodCBiZSBkdXBsaWNhdGUgc28gdGhpcyBwcmludGsoKSBtYXkgYmUgZHJvcHBlZC4NCj4gPiBJ
biBtZW1vcnlfZmFpbHVyZV9odWdldGxiKCkgYW5kIG1lbW9yeV9mYWlsdXJlKCksIHdlIGNhbiBj
YWxsIGR1bXBfcGFnZSgpIGFmdGVyDQo+ID4gYWN0aW9uX3Jlc3VsdCgpLiAgdW5wb2lzb25fbWVt
b3J5KCkgZG9lc24ndCBuZWVkIGR1bXBfcGFnZSgpIGF0IGFsbCBiZWNhdXNlDQo+ID4gaXQncyBy
ZWxhdGVkIHRvIGFscmVhZHkgaHdwb2lzb25lZCBwYWdlLg0KPiANCj4gSSBkb24ndCBoYXZlIGEg
c3Ryb25nIG9waW5pb24gZWl0aGVyIHRvIGhhdmUgdGhlIGR1bXBfcGFnZSgpIGNhbGxlZA0KPiBl
aXRoZXIgYmVmb3JlIGFjdGlvbiBvciBhZnRlciBhY3Rpb24sIGl0IGp1c3QgbW92ZXMgYXJvdW5k
IHRoZSBkdW1wZWQNCj4gcGFnZSBpbmZvcm1hdGlvbiBhcm91bmQgdGhhdCBwcmludGsuDQo+IA0K
PiBGb3IgdW5wb2lzb25fbWVtb3J5KCksIEkgdGhpbmsgaXQgaXMgaGFybWxlc3MgdG8gaGF2ZSBk
dW1wX3BhZ2UoKQ0KPiBjYWxsZWQsIHJpZ2h0PyBJZiBnZXRfaHdwb2lzb25fcGFnZSgpIGNhbid0
IHJldHVybiAtRUlPLCB0aGVuIHRoZQ0KPiBkdW1wX3BhZ2UoKSB3b24ndCBiZSBjYWxsZWQgYXQg
YWxsLCBpZiBpdCBpcyBwb3NzaWJsZSB0aGVuIHRoaXMgaXMNCj4gZXhhY3RseSB3aHkgd2UgY2Fs
bCBkdW1wX3BhZ2UoKSB0byBoZWxwIGRlYnVnLg0KPiANCj4gU28gSU1ITyBjYWxsaW5nIGR1bXBf
cGFnZSgpIGluIGdldF9hbnlfcGFnZSB3aGVuIC1FSU8gaXMgcmV0dXJuZWQNCj4gY291bGQgd29y
ayBmb3IgYWxsIHRoZSBjYXNlcyB3ZWxsIGFuZCBhdm9pZCBkdXBsaWNhdGluZyB0aGUgY2FsbC4N
Cg0KRmFpciBlbm91Z2guIFNvIGNvdWxkIHlvdSByZXBvc3QgMy8zIHdpdGggdGhlIGFib3ZlIGNo
YW5nZSBpbiBzb2Z0X29mZmxpbmVfcGFnZSgpPw0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
