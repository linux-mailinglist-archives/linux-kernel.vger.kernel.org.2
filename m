Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD6534D03F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhC2Mjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:39:51 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:64634 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhC2Mjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1617021577; x=1619613577;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VNM0UtqlM+r85P41I9g1vivhzSRSzLEHiMDkKSZJmjw=;
        b=AtSUzWfzV+ES+QBTFvDv2xc2Oj1sLH3QcB4tg6wpYQe5eDqWT5JOKxW09cWTTaWu
        59WdoBIyGvQ5vPT0kmCD0iRFWntMUfVCjjSR+WR20LKZ/JYCdqX3e56Fd9f7WK5v
        cwKmaOWaoAPkPgeF/Vn5h7Vj3/CZklaAiQX+eYh0K0Y=;
X-AuditID: c39127d2-85cb770000001c91-c9-6061ca89690c
Received: from florix.phytec.de (florix.phytec.de [172.16.0.118])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 29.1B.07313.98AC1606; Mon, 29 Mar 2021 14:39:37 +0200 (CEST)
Received: from Berlix.phytec.de (172.16.0.117) by Florix.phytec.de
 (172.16.0.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 29 Mar
 2021 14:39:37 +0200
Received: from Berlix.phytec.de ([fe80::f594:d241:d581:a5be]) by
 berlix.phytec.de ([fe80::f594:d241:d581:a5be%3]) with mapi id 15.01.2176.009;
 Mon, 29 Mar 2021 14:39:37 +0200
From:   =?utf-8?B?U3RlZmFuIFJpZWRtw7xsbGVy?= <S.Riedmueller@phytec.de>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] ARM: dts: imx6: pfla02: Fix USB vbus enable pinmuxing
Thread-Topic: [PATCH 1/3] ARM: dts: imx6: pfla02: Fix USB vbus enable
 pinmuxing
Thread-Index: AQHXJI6jENN0NZmfXkefOB2FaqSgpaqas7iAgAASy4A=
Date:   Mon, 29 Mar 2021 12:39:37 +0000
Message-ID: <b449e9c40d225b3dbec9c79435b856f89ccdde29.camel@phytec.de>
References: <20210329112819.64043-1-s.riedmueller@phytec.de>
         <CAOMZO5AxkToaa3wFbx2KP6AyAnWVYKVsKOs-mgNMZLOzo3miuA@mail.gmail.com>
In-Reply-To: <CAOMZO5AxkToaa3wFbx2KP6AyAnWVYKVsKOs-mgNMZLOzo3miuA@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <311B64546FB78F4CB90ABAE54782B748@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWyRoChTLfzVGKCQedaS4v5R86xWjy86m+x
        aupOFotNj6+xWnT9WslscXnXHDaL1r1H2C3+bt/EYvFii7gDp8fOWXfZPTat6mTz2Lyk3mPj
        ux1MHv1/DTw+b5ILYIvisklJzcksSy3St0vgyti3eAFjwTn2in8PV7I2MG5h72Lk5JAQMJHY
        cuk/axcjF4eQwHImiUn/7jBBOA8ZJa5P7WeBcDYxSjQuvsYM0sIm4CLxue0bG4gtIqArseJE
        FyNIEbPAHmaJE63/wOYKC/hJTD91ix2iKFDi6o4FLBC2lcTMNzvBbBYBVYnXe46DDeIVcJO4
        +moB1LYWRomOI3fAijiBmqe07wfbzCggK9HZ8I4JxGYWEJfY9Ow7K8QTAhJL9pxnhrBFJV4+
        /gcVV5Bo6+kEqucAqteUWL9LH6LVQuLczIlsELaixJTuh+wQNwhKnJz5hGUCo/gsJBtmIXTP
        QtI9C0n3LCTdCxhZVzEK5WYmZ6cWZWbrFWRUlqQm66WkbmIERvThieqXdjD2zfE4xMjEwXiI
        UYKDWUmEV/hAYoIQb0piZVVqUX58UWlOavEhRmkOFiVx3g28JWFCAumJJanZqakFqUUwWSYO
        TqkGRtOlJZcundxSdWVyc545S9CjH1urZNRkI1Z9OmC3cm+e1c0QQSchXt6FEcmhM1qMhUz8
        1oosDMmM5t0067nnHTGX5I2SYVKLcw9HWaxetONA9ikGqV72+WlR+9K2b3tueOcy2yvB9VfW
        8GbEK1Y5+rRqlK12/+pi9uC6Wv0s7qBpB51qlr9bqMRSnJFoqMVcVJwIAD3urmnWAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCk9uIE1vbiwgMjAyMS0wMy0yOSBhdCAwODozMiAtMDMwMCwgRmFiaW8gRXN0
ZXZhbSB3cm90ZToNCj4gSGkgU3RlZmFuLA0KPiANCj4gT24gTW9uLCBNYXIgMjksIDIwMjEgYXQg
ODoyOCBBTSBTdGVmYW4gUmllZG11ZWxsZXINCj4gPHMucmllZG11ZWxsZXJAcGh5dGVjLmRlPiB3
cm90ZToNCj4gDQo+ID4gLSAgICAgICAgICAgICAgIHBpbmN0cmxfdXNiaDE6IHVzYmgxZ3JwIHsN
Cj4gPiArICAgICAgICAgICAgICAgcGluY3RybF91c2JoMV92YnVzOiB1c2JoMXZidXNncnAgew0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGZzbCxwaW5zID0gPA0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgTVg2UURMX1BBRF9HUElPXzBfX1VTQl9IMV9QV1IgICAgICAg
ICAgIDB4DQo+ID4gODAwMDAwMDANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IE1YNlFETF9QQURfR1BJT18wX19HUElPMV9JTzAwICAgICAgICAgICAweA0KPiA+IDgwMDAwMDAw
DQo+IA0KPiBXaGlsZSB5b3UgYXJlIG9uIGl0LCBjb3VsZCB5b3UgcGxlYXNlIHVzZSBhdm9pZCB0
aGUgdXNhZ2Ugb2YNCj4gMHg4MDAwMDAwMCBhbmQgZXhwbGljaXRseSBwYXNzIHRoZSBkZWZhdWx0
IHZhbHVlIGluc3RlYWQ/DQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuIFN1cmUsIEknbGwgZml4
IHRoYXQgaW4gYSB2Mi4NCg0KU3RlZmFuDQo=
