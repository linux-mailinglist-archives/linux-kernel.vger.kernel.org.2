Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4709C3309C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhCHIwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:52:21 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:42138 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhCHIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1615193529; x=1617785529;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QC5HtvTGllslExCWxbDmPu4ND79ar+Dh51Uqy90ZDoI=;
        b=M/MQvqIYmy1/Iy29OpIj9SiiiN1S4ERWZyfYQnMx4OUzUG6E2k96R/Kdak1P6K6p
        IuTxMAyWOAihFZCpFl5cGEZsrXL/VIx+lD2D/Bmvfkxbng3Ik0nbOs6GLXo6K1m5
        MHskKnrzDe8MszC4iNS5g0i+UEaCofqVSXOW1WEHz/k=;
X-AuditID: c39127d2-0c7b670000001c86-33-6045e5b92119
Received: from Florix.phytec.de (florix.phytec.de [172.16.0.118])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F3.E1.07302.9B5E5406; Mon,  8 Mar 2021 09:52:09 +0100 (CET)
Received: from Florix.phytec.de (172.16.0.118) by Florix.phytec.de
 (172.16.0.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 8 Mar 2021
 09:52:09 +0100
Received: from Florix.phytec.de ([fe80::b416:3f1c:18a3:d40f]) by
 Florix.phytec.de ([fe80::b416:3f1c:18a3:d40f%10]) with mapi id
 15.01.2176.009; Mon, 8 Mar 2021 09:52:09 +0100
From:   Teresa Remmet <T.Remmet@phytec.de>
To:     "hs@denx.de" <hs@denx.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
CC:     "krzk@kernel.org" <krzk@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] arm64: imx8mp: imx8mp-phycore-som enable spi nor
Thread-Topic: [PATCH 2/2] arm64: imx8mp: imx8mp-phycore-som enable spi nor
Thread-Index: AQHXE+Ysra23/WzIi0mypBQWD91O56p5tOiAgAADLAA=
Date:   Mon, 8 Mar 2021 08:52:09 +0000
Message-ID: <196131b90400b434931992ba5a9078828d1eaf2a.camel@phytec.de>
References: <20210308064046.1576267-1-hs@denx.de>
         <20210308064046.1576267-3-hs@denx.de>
         <20210308084047.numy4o2jvsiz5d3v@pengutronix.de>
In-Reply-To: <20210308084047.numy4o2jvsiz5d3v@pengutronix.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <05A165B04570234689855C7B946C83F4@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWyRoChTHfnU9cEg6vXtS3mHznHavHwqr/F
        jjv3mS1WTd3JYnH+/AZ2i02Pr7FadP1ayWxxedccNosPu64yW7TuPcJu8Xf7JhaLF1vEHXg8
        5s06weKxc9Zddo9NqzrZPDYvqffY+G4Hk0f/XwOPz5vkAtijuGxSUnMyy1KL9O0SuDLebrrC
        XvBIomLZugaWBsYJEl2MHBwSAiYSbw9GdzFycQgJLGOSeL3mBBuE84BR4sK81ewQziZGiYf7
        PjN3MXJysAloSLw80c0EYosIhEhcmTUJrIhZYAKLxPF771hBEsICnhJLXs+CKvKSWLz6BZRt
        JfF09RoWEJtFQEXi1r7rbCA2r4CbxNu3H5ggtvUxSrx+/gBsG6eArUTj3gZGEJtRQFZiw4bz
        YHFmAXGJTc++gy2TEBCQWLIHIi4hICrx8vE/qLiCRFtPJxPIn8wCmhLrd+lDtFpIHJxzlx3C
        VpSY0v2QHeIGQYmTM5+wTGAUn4VkwyyE7llIumch6Z6FpHsBI+sqRqHczOTs1KLMbL2CjMqS
        1GS9lNRNjMC4PzxR/dIOxr45HocYmTgYDzFKcDArifD29jgnCPGmJFZWpRblxxeV5qQWH2KU
        5mBREufdwFsSJiSQnliSmp2aWpBaBJNl4uCUamDcOLNy6cVgHq8Zbqd+Ltq+6EpKl0B2wZO4
        rcyqf2vv2Va/jLrbXXYk66hgRcHXuL1CJtsvLGGqzd9T2rRh47ymdW4XTnvWLd54qrt+uZuA
        hsHUjKk+n0W+SejOL9yyIaq3RWlpbYcLV4ijx+u7oq3y+/ff3Kwh1sxZbb3g0OQfH946+a/e
        +iNKiaU4I9FQi7moOBEAYk8o2+kCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWFyY28sDQoNCkFtIE1vbnRhZywgZGVuIDA4LjAzLjIwMjEsIDA5OjQwICswMTAwIHNj
aHJpZWIgTWFyY28gRmVsc2NoOg0KPiBPbiAyMS0wMy0wOCAwNzo0MCwgSGVpa28gU2Nob2NoZXIg
d3JvdGU6DQo+ID4gZW5hYmxlIHRoZSBtdDI1cXUyNTZhYmEgc3BpIG5vciBvbiB0aGUgaW14OG1w
LXBoeWNvcmUtc29tLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEhlaWtvIFNjaG9jaGVyIDxo
c0BkZW54LmRlPg0KPiA+IC0tLQ0KPiA+IA0KPiA+ICAuLi4vZHRzL2ZyZWVzY2FsZS9pbXg4bXAt
cGh5Y29yZS1zb20uZHRzaSAgICAgfCAyNw0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWNvcmUtc29tLmR0c2kNCj4g
PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHljb3JlLXNvbS5kdHNp
DQo+ID4gaW5kZXggNDRhOGMyMzM3Y2VlNC4uMDI4NGU3YTVjNmJiYSAxMDA2NDQNCj4gPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Y29yZS1zb20uZHRzaQ0K
PiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHljb3JlLXNv
bS5kdHNpDQo+ID4gQEAgLTY1LDYgKzY1LDIyIEBAIGV0aHBoeTE6IGV0aGVybmV0LXBoeUAwIHsN
Cj4gPiAgCX07DQo+ID4gIH07DQo+ID4gIA0KPiA+ICsmZmxleHNwaSB7DQo+ID4gKwlwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZsZXhzcGkw
PjsNCj4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiArDQo+ID4gKwlmbGFzaDA6IG10MjVxdTI1
NmFiYUAwIHsNCj4gPiArCQlyZWcgPSA8MD47DQo+ID4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+ID4gKwkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJqZWRlYyxz
cGktbm9yIjsNCj4gDQo+IFBsZWFzZSBtYWtlIHRoZSBjb21wYXRpYmxlIHRoZSBmaXJzdCBwcm9w
ZXJ0eSBmb2xsb3dlZCBieSB0aGUgcmVnDQo+IHByb3BlcnR5LiBBbHNvIHlvdSBkb24ndCBuZWVk
IHRvIGFkZCB0aGUgI3NpemUtY2VsbHMgYW5kICNhZGRyZXNzLQ0KPiBjZWxscw0KPiBub3cgc2lu
Y2UgeW91IGRvbid0IGFkZCBhIGNoaWxkIG5vZGUuDQoNCmJ1dCBpcyB0aGlzIG5vdCBzaW1pbGFy
IHRvIHRoZSBsYWJlbCBoZXJlPyBJZiB5b3UgYWRkIHBhcnRpdGlvbnMgaW4gdGhlDQpib290bG9h
ZGVyIHlvdSBuZWVkIHRoZSBjZWxscyBwcm9wZXJ0aWVzPw0KDQpUZXJlc2ENCg0KPiANCj4gUmVn
YXJkcywNCj4gICBNYXJjbw0KPiANCj4gPiArCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDw4MDAwMDAw
MD47DQo+ID4gKwkJc3BpLXR4LWJ1cy13aWR0aCA9IDw0PjsNCj4gPiArCQlzcGktcngtYnVzLXdp
ZHRoID0gPDQ+Ow0KPiA+ICsJfTsNCj4gPiArfTsNCj4gPiArDQo+ID4gICZpMmMxIHsNCj4gPiAg
CWNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDA+Ow0KPiA+ICAJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IjsNCj4gPiBAQCAtMjE3LDYgKzIzMywxNyBAQCBNWDhNUF9JT01VWENfR1BJTzFfSU8xNV9f
R1BJTzFfSU8xNQkJDQo+ID4gMHgxMQ0KPiA+ICAJCT47DQo+ID4gIAl9Ow0KPiA+ICANCj4gPiAr
CXBpbmN0cmxfZmxleHNwaTA6IGZsZXhzcGkwZ3JwIHsNCj4gPiArCQlmc2wscGlucyA9IDwNCj4g
PiArCQkJTVg4TVBfSU9NVVhDX05BTkRfQUxFX19GTEVYU1BJX0FfU0NMSwkJDQo+ID4gMHgxYzIN
Cj4gPiArCQkJTVg4TVBfSU9NVVhDX05BTkRfQ0UwX0JfX0ZMRVhTUElfQV9TUzBfQgkweDgNCj4g
PiAyDQo+ID4gKwkJCU1YOE1QX0lPTVVYQ19OQU5EX0RBVEEwMF9fRkxFWFNQSV9BX0RBVEEwMAkw
eDgNCj4gPiAyDQo+ID4gKwkJCU1YOE1QX0lPTVVYQ19OQU5EX0RBVEEwMV9fRkxFWFNQSV9BX0RB
VEEwMQkweDgNCj4gPiAyDQo+ID4gKwkJCU1YOE1QX0lPTVVYQ19OQU5EX0RBVEEwMl9fRkxFWFNQ
SV9BX0RBVEEwMgkweDgNCj4gPiAyDQo+ID4gKwkJCU1YOE1QX0lPTVVYQ19OQU5EX0RBVEEwM19f
RkxFWFNQSV9BX0RBVEEwMwkweDgNCj4gPiAyDQo+ID4gKwkJPjsNCj4gPiArCX07DQo+ID4gKw0K
PiA+ICAJcGluY3RybF9pMmMxOiBpMmMxZ3JwIHsNCj4gPiAgCQlmc2wscGlucyA9IDwNCj4gPiAg
CQkJTVg4TVBfSU9NVVhDX0kyQzFfU0NMX19JMkMxX1NDTAkJMHg0DQo+ID4gMDAwMDFjMw0KPiA+
IC0tIA0KPiA+IDIuMjkuMg0KPiA+IA0KPiA+IA0KPiA+IA0K
