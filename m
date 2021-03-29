Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01B934D045
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhC2Mm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:42:27 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:64720 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhC2Ml7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1617021716; x=1619613716;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XHa/uvdSReX/Iz6rxPW8tM4ztE/6qivKRg5PaEzjBh0=;
        b=bDgO7WSQEoKRBKRxd2LC/3F2N1hoU6KhcLvX47C1riRUHHGhtdJvEWRWJn/AaUxT
        9FIJ2fEhrTgBU03nTp1D4acLoBVIIG7g3U7uixQrb1Ucx6s6Hzfxuf2aUrXeJ7jG
        XP4Xdfkm8jZWheIwegdGYGkOlbl8WNVTtiB+zlE7B0Q=;
X-AuditID: c39127d2-868b870000001c91-fe-6061cb14dc80
Received: from florix.phytec.de (florix.phytec.de [172.16.0.118])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7D.1B.07313.41BC1606; Mon, 29 Mar 2021 14:41:56 +0200 (CEST)
Received: from Berlix.phytec.de (172.16.0.117) by Florix.phytec.de
 (172.16.0.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 29 Mar
 2021 14:41:56 +0200
Received: from Berlix.phytec.de ([fe80::f594:d241:d581:a5be]) by
 berlix.phytec.de ([fe80::f594:d241:d581:a5be%3]) with mapi id 15.01.2176.009;
 Mon, 29 Mar 2021 14:41:56 +0200
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
Subject: Re: [PATCH 3/3] ARM: dts: imx6: pbab01: Set vmmc supply for both SD
 interfaces
Thread-Topic: [PATCH 3/3] ARM: dts: imx6: pbab01: Set vmmc supply for both SD
 interfaces
Thread-Index: AQHXJI6oDU6feJ4y+02SO/HWBz4AL6qatFcAgAAS0YA=
Date:   Mon, 29 Mar 2021 12:41:56 +0000
Message-ID: <64f317c57ef0493e221482d68bc0a06c83cb15d9.camel@phytec.de>
References: <20210329112819.64043-1-s.riedmueller@phytec.de>
         <20210329112819.64043-3-s.riedmueller@phytec.de>
         <CAOMZO5DMnqZTedg_bb=NCZ4_cfP1sDam=N0-FrDRYTeKi+4n-g@mail.gmail.com>
In-Reply-To: <CAOMZO5DMnqZTedg_bb=NCZ4_cfP1sDam=N0-FrDRYTeKi+4n-g@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.116]
Content-Type: text/plain; charset="utf-8"
Content-ID: <94DBDCB091F67341831183E311EF8641@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWyRoChTFfkdGKCwf11Ohbzj5xjtXh41d9i
        1dSdLBabHl9jtej6tZLZ4vKuOWwWrXuPsFv83b6JxeLFFnEHTo+ds+6ye2xa1cnmsXlJvcfG
        dzuYPPr/Gnh83iQXwBbFZZOSmpNZllqkb5fAlbGr+xhrwQr2iuvb77A1ME5g72Lk4JAQMJH4
        sVOhi5GLQ0hgOZPEnb4rrBDOQ0aJDbOuMkI4mxgltj68xtLFyMnBJuAi8bntGxuILSKgK7Hi
        RBdYEbPAHmaJE63/2EESwgKREg8n9jNCFEVJNNzpg2qwkpi8agkTyGoWAVWJk4ejQcK8Am4S
        i44uZIZYtoNRYnb/elaQBKdAoMTHdQ1gMxkFZCU6G94xgdjMAuISm559B6uREBCQWLLnPDOE
        LSrx8vE/qLiCRFtPJ9guZgFNifW79CFaLSRubHsLNUZRYkr3Q3aIGwQlTs58wjKBUXwWkg2z
        ELpnIemehaR7FpLuBYysqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzECo/nwRPVLOxj75ngcYmTi
        YDzEKMHBrCTCK3wgMUGINyWxsiq1KD++qDQntfgQozQHi5I47wbekjAhgfTEktTs1NSC1CKY
        LBMHp1QDoyFn/dvmCQFLZjX5fMg9y97xZteB1A3SZQYKC669Pjmt/+yP6LwNbuxS8x9aPfA5
        vTLobPLui69+HYnQe3dB2ujdT4OX5abS59gOrbdkTFoYu6Z+s7/92TQ3L6Vn3/Z8++XeNans
        uuhpm0L/hla7Hf/3b096xRyYlHj+Vq6sTPV8lbx/zzO5spRYijMSDbWYi4oTATuxG9nUAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCk9uIE1vbiwgMjAyMS0wMy0yOSBhdCAwODozNCAtMDMwMCwgRmFiaW8gRXN0
ZXZhbSB3cm90ZToNCj4gT24gTW9uLCBNYXIgMjksIDIwMjEgYXQgODoyOCBBTSBTdGVmYW4gUmll
ZG11ZWxsZXINCj4gPHMucmllZG11ZWxsZXJAcGh5dGVjLmRlPiB3cm90ZToNCj4gPiBTZXR0aW5n
IHRoZSB2bW1jIHN1cHBsaWVzIGlzIGNydWNpYWwgc2luY2Ugb3RoZXJ3aXNlIHRoZSBzdXBwbHlp
bmcNCj4gPiByZWd1bGF0b3JzIGdldCBkaXNhYmxlZCBhbmQgdGhlIFNEIGludGVyZmFjZXMgYXJl
IG5vIGxvbmdlciBwb3dlcmVkDQo+ID4gd2hpY2ggbGVhZHMgdG8gc3lzdGVtIGZhaWx1cmVzIGlm
IHRoZSBzeXN0ZW0gaXMgYm9vdGVkIGZyb20gdGhhdCBTRA0KPiA+IGludGVyZmFjZS4NCj4gDQo+
IEl0IHNlZW1zIHRoYXQgdGhpcyBkZXNlcnZlcyBhIEZpeGVzIHRhZy4NCg0KSSB0aGluayB0aGlz
IG11c3QgYmUgYnJva2VuIGZvciBzb21lIHRpbWUgbm93LiBNeSBndWVzcyBpcyB0aGF0IGl0IGJy
b2tlIHdoZW4NCnRoZSBQTUlDIHN1cHBvcnQgZm9yIHRoZSBTT00gd2FzIGFkZGVkLiBTbyBJIGNh
biBhZGQgYSBmaXhlcyB0YWcgZm9yIHRoYXQNCmNvbW1pdC4NCg0KVGhhbmtzLA0KU3RlZmFuDQoN
Cj4gDQo+IFJldmlld2VkLWJ5OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo=
