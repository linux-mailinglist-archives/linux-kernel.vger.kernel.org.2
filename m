Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF133091D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhCHIBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:01:32 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:64122 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhCHIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:01:17 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Mar 2021 03:01:17 EST
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1615189574; x=1617781574;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QFR/PhxWNLZvU5C5KEfyMkMySt0HlamU0dCTqIXe2ds=;
        b=EhsXjkRVhuarHMmRwe8O7cPd4yT5LPizEgpSL2YSA9sdJjTzLOhlZPd/Cyfa+I4k
        nWWws1giEJT+kYcJdBYnHy0haTAFfR8H3ro68G8b6n0yxCFfYozeYIjZ2zN7i/d4
        D7uZ3R6te/BBJg6EoaEapUlrd9acc+t37wNBUrDwhbc=;
X-AuditID: c39127d2-0d3b770000001c86-0c-6045d64606bf
Received: from Berlix.phytec.de (Berlix.phytec.de [172.16.0.117])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EC.41.07302.646D5406; Mon,  8 Mar 2021 08:46:14 +0100 (CET)
Received: from Berlix.phytec.de (172.16.0.117) by Berlix.phytec.de
 (172.16.0.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 8 Mar 2021
 08:46:14 +0100
Received: from Berlix.phytec.de ([fe80::6dc0:81aa:52a5:106a]) by
 Berlix.phytec.de ([fe80::6dc0:81aa:52a5:106a%6]) with mapi id 15.01.1779.004;
 Mon, 8 Mar 2021 08:46:14 +0100
From:   Teresa Remmet <T.Remmet@phytec.de>
To:     "hs@denx.de" <hs@denx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "krzk@kernel.org" <krzk@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] arm64: imx8mp: imx8mp-phycore-som enable spi nor
Thread-Topic: [PATCH 2/2] arm64: imx8mp: imx8mp-phycore-som enable spi nor
Thread-Index: AQHXE+Ysra23/WzIi0mypBQWD91O56p5pamA
Date:   Mon, 8 Mar 2021 07:46:14 +0000
Message-ID: <9f77093260dbf37ffff3e1dd167162a8a2b75c73.camel@phytec.de>
References: <20210308064046.1576267-1-hs@denx.de>
         <20210308064046.1576267-3-hs@denx.de>
In-Reply-To: <20210308064046.1576267-3-hs@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E8292FAE57E534DB7C3917D1C8256E6@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWyRoChVNftmmuCQetpA4v5R86xWjy86m+x
        4859ZotVU3eyWJw/v4HdYtPja6wWXb9WMltc3jWHzaJ17xF2i7/bN7FYvNgi7sDtMW/WCRaP
        nbPusntsWtXJ5rF5Sb3Hxnc7mDz6/xp4fN4kF8AexWWTkpqTWZZapG+XwJXx6+gr1oI20Yrb
        e9cxNjAeEOli5OSQEDCR2HJ5N3sXIxeHkMAyJonDV58xQzgPGCX6Zt9ggnA2Mkp0Tf3CBNLC
        JqAh8fJEN5gtIpAn8XD5IkaQImaBvcwSp//sZwZJCAt4Six5PQuqyEti8eoXULaRxKRtW1lB
        bBYBFYkFa+aC1fMKuEl0LW9lA7GFBKIk+l8sAavnBKpf8v0EI4jNKCArsWHDebB6ZgFxiU3P
        vrNC/CAgsWQPRFxCQFTi5eN/UHEFibaeTqA5HED1mhLrd+lDtFpIPGo+AjVGUWJK90N2iBME
        JU7OfMIygVF8FpINsxC6ZyHpnoWkexaS7gWMrKsYhXIzk7NTizKz9QoyKktSk/VSUjcxAqP9
        8ET1SzsY++Z4HGJk4mA8xCjBwawkwtvb45wgxJuSWFmVWpQfX1Sak1p8iFGag0VJnHcDb0mY
        kEB6YklqdmpqQWoRTJaJg1OqgVF+xu45K6L/HxRYeb7tYXhU00T9LuX64rB7U0OmfI2eJqCe
        dyG1vHWuypegoG9JG0yXH1kjmaF+5oNhYuyUfzrmpk/fnOh6vvKwWlnTA8eF6mU/lTadVZZj
        Ofe7xDSMze8/k6aDAFdTZde9LmU2Pp4Nrpu13aX2zAsp6Psp+XpyhdVp3/x2KSWW4oxEQy3m
        ouJEAGhmACHkAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSGVpa28sDQoNCmZpcnN0IHRoYW5rcyBmb3IgdGhlIHBhdGNoIDopLg0KDQpBbSBNb250
YWcsIGRlbiAwOC4wMy4yMDIxLCAwNzo0MCArMDEwMCBzY2hyaWViIEhlaWtvIFNjaG9jaGVyOg0K
PiBlbmFibGUgdGhlIG10MjVxdTI1NmFiYSBzcGkgbm9yIG9uIHRoZSBpbXg4bXAtcGh5Y29yZS1z
b20uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIZWlrbyBTY2hvY2hlciA8aHNAZGVueC5kZT4NCj4g
LS0tDQo+IA0KPiAgLi4uL2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWNvcmUtc29tLmR0c2kgICAg
IHwgMjcNCj4gKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bXAtcGh5Y29yZS1zb20uZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtcC1waHljb3JlLXNvbS5kdHNpDQo+IGluZGV4IDQ0YThjMjMzN2NlZTQuLjAyODRl
N2E1YzZiYmEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcC1waHljb3JlLXNvbS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtcC1waHljb3JlLXNvbS5kdHNpDQo+IEBAIC02NSw2ICs2NSwyMiBAQCBldGhwaHkx
OiBldGhlcm5ldC1waHlAMCB7DQo+ICAJfTsNCj4gIH07DQo+ICANCj4gKyZmbGV4c3BpIHsNCj4g
KwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9m
bGV4c3BpMD47DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArDQo+ICsJZmxhc2gwOiBtdDI1cXUy
NTZhYmFAMCB7DQoNCnlvdSBjYW4gcmVtb3ZlIHRoZSBsYWJlbC4gQXMgaXQgaXMgbm90IHVzZWQg
aGVyZSByaWdodCBub3cuDQpBbHNvIHJlbmFtZSB0aGUgbm9kZSBuYW1lIHRvIGRldmljZSB0eXBl
IGxpa2UgImZsYXNoIiBtYXliZS4NCg0KSSB3aWxsIHRyeSB0byB0ZXN0IHRoaXMgc29vbi4NCg0K
VGhhbmtzLA0KVGVyZXNhDQoNCg0KPiArCQlyZWcgPSA8MD47DQo+ICsJCSNhZGRyZXNzLWNlbGxz
ID0gPDE+Ow0KPiArCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gKwkJY29tcGF0aWJsZSA9ICJqZWRl
YyxzcGktbm9yIjsNCj4gKwkJc3BpLW1heC1mcmVxdWVuY3kgPSA8ODAwMDAwMDA+Ow0KPiArCQlz
cGktdHgtYnVzLXdpZHRoID0gPDQ+Ow0KPiArCQlzcGktcngtYnVzLXdpZHRoID0gPDQ+Ow0KPiAr
CX07DQo+ICt9Ow0KPiArDQo+ICAmaTJjMSB7DQo+ICAJY2xvY2stZnJlcXVlbmN5ID0gPDQwMDAw
MD47DQo+ICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gQEAgLTIxNyw2ICsyMzMsMTcg
QEAgTVg4TVBfSU9NVVhDX0dQSU8xX0lPMTVfX0dQSU8xX0lPMTUJCQ0KPiAweDExDQo+ICAJCT47
DQo+ICAJfTsNCj4gIA0KPiArCXBpbmN0cmxfZmxleHNwaTA6IGZsZXhzcGkwZ3JwIHsNCj4gKwkJ
ZnNsLHBpbnMgPSA8DQo+ICsJCQlNWDhNUF9JT01VWENfTkFORF9BTEVfX0ZMRVhTUElfQV9TQ0xL
CQkNCj4gMHgxYzINCj4gKwkJCU1YOE1QX0lPTVVYQ19OQU5EX0NFMF9CX19GTEVYU1BJX0FfU1Mw
X0IJMHg4Mg0KPiArCQkJTVg4TVBfSU9NVVhDX05BTkRfREFUQTAwX19GTEVYU1BJX0FfREFUQTAw
CQ0KPiAweDgyDQo+ICsJCQlNWDhNUF9JT01VWENfTkFORF9EQVRBMDFfX0ZMRVhTUElfQV9EQVRB
MDEJDQo+IDB4ODINCj4gKwkJCU1YOE1QX0lPTVVYQ19OQU5EX0RBVEEwMl9fRkxFWFNQSV9BX0RB
VEEwMgkNCj4gMHg4Mg0KPiArCQkJTVg4TVBfSU9NVVhDX05BTkRfREFUQTAzX19GTEVYU1BJX0Ff
REFUQTAzCQ0KPiAweDgyDQo+ICsJCT47DQo+ICsJfTsNCj4gKw0KPiAgCXBpbmN0cmxfaTJjMTog
aTJjMWdycCB7DQo+ICAJCWZzbCxwaW5zID0gPA0KPiAgCQkJTVg4TVBfSU9NVVhDX0kyQzFfU0NM
X19JMkMxX1NDTAkJMHg0MDANCj4gMDAxYzMNCg==
