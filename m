Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9953FC2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhHaG2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:28:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60210 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233032AbhHaG2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:28:36 -0400
X-UUID: 14131145302c4f76a6fc90ee9df8ea6b-20210831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pW+/s0ECqJ+Ztd6yxtNaPW15O2Z32AI8iM7/Y6NLiqk=;
        b=psObLO3j+ndUFaipdN4fRH1Ja6KT0EUJzo7jf609tY9A5q8n5FaXrd61BFZxDTNiCYaqnxLPVk6EhfNpupk6dt0lsf6vlGbuCMvJTn2wemsnVITKl4WU4VcJm5d8hB5rNcyuSd6PPUTV0Fj8CYCBW6h2ANrWvD6Zb8f2UIP7DWc=;
X-UUID: 14131145302c4f76a6fc90ee9df8ea6b-20210831
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1672085433; Tue, 31 Aug 2021 14:27:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Aug 2021 14:27:36 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Aug 2021 14:27:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGFcYkf9d8S3SqzsKB2VtoIfRo1JzS8VX2YBO6bFnMsZkI6f02Xu1ZSg+d4rJYISiqphmtD7+rJJUfwzlmSGvf4q6qM7oi7eIo5udPGgxqW2M4kfi511642fmmPgii17EHR7HmjrJiJL8WV2z21WUrtONLFTAsIVsI5ELRxdB51/ep6MyTIHGtDzrH4pbnvHf1Uw2BuNYixf0rFg+Bnt508chkw9/x14060QrWiMa6deIHc3YJo7H5GQJ0x1+j4CxtMFz0bHUranGXGgDGAhuEg2HSgS4/NxqzSfGxlClH9rRKvCYpelrJy9f8efHM6NtXaDJeBO66ymWU7fJGbINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pW+/s0ECqJ+Ztd6yxtNaPW15O2Z32AI8iM7/Y6NLiqk=;
 b=cqGYG5GJh7rZyVsyml8LUoCsm1Xnkf4dJ5s5OgAstgWDIiar8oCXPY/Y7IcCU0iF/EL6S1EDBLc6HTbY+IrdZsCk8JEz2C8bDmyumyplFLfKFpHSzznH80zpgXvaW0lqrw20bfxH8emEl9yAVbx9i7q18S8oJC2iJkBSwdcys/E9DYqnc+7CZ3hCjyJtf+bS6hwayzXVBAcAstgX7BxaZL7yXnclFJyIZo5TEP9aYyCxeF+cJiMLnzzuUOnu/OTLFv0BkGtIG2mLm6aGGtY0D/aBqk1faF6R2oX7im4kS9K1rOkOGRBU9E4wF6f8bQo5HuoW8Jh8fKHzNCL2wF8LmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW+/s0ECqJ+Ztd6yxtNaPW15O2Z32AI8iM7/Y6NLiqk=;
 b=dK+RKffivrgMaD/dyz4Lw7HwH5j/mrvs4YJbkofIGE78qYbTGNThNXtaOlvPCXMzrlopMlU9NaC1NbFqIczZchy6xfLMX5zsnDF/unB0AGlpy147LJ47g2YAxHHQgCOkM7mRmIRY1tnJYI9BWBlKxSvfBNrAw0iDX51/Tp1LmhA=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB5636.apcprd03.prod.outlook.com (2603:1096:820:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.14; Tue, 31 Aug
 2021 06:27:18 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c%7]) with mapi id 15.20.4457.017; Tue, 31 Aug 2021
 06:27:18 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mans0n@gorani.run" <mans0n@gorani.run>
CC:     "b-liu@ti.com" <b-liu@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/2] arm: dts: mt7623: add musb device nodes
Thread-Topic: [PATCH v4 1/2] arm: dts: mt7623: add musb device nodes
Thread-Index: AQHXnbiA/Q+TZIhyUk2qQADVVY0HNauNJwSA
Date:   Tue, 31 Aug 2021 06:27:18 +0000
Message-ID: <16f980b95e1f32bb8eb32448f1615bafdc51b792.camel@mediatek.com>
References: <20210822041333.5264-1-mans0n@gorani.run>
         <20210830155903.13907-1-mans0n@gorani.run>
         <20210830155903.13907-2-mans0n@gorani.run>
In-Reply-To: <20210830155903.13907-2-mans0n@gorani.run>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd25db86-4065-4358-5a7d-08d96c48620b
x-ms-traffictypediagnostic: KL1PR03MB5636:
x-microsoft-antispam-prvs: <KL1PR03MB56368C8C2166209F4EE63B6AFDCC9@KL1PR03MB5636.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wBWrBiC9Z71TBbOMz4WOZcr9JGsreeZfq4oWx0oRDqDrlxUpP41sNiRKfEGvE/JMeyICFJU1734n6HA043EPH86FtpTDXdA69lXVA/dPjNCA1xbygfSRdVhT6CYLIixb8sc1yunA2j8MBDuCwF4q/laapeONrre+EFgA1c2BA40Kkrc1Kt7jNgpr5a3rQqoJ/kQrs3gvo/xbsrD73j0a/XptJAoQZ97TSVxCCyRIWmrrKqz7L1XYu05qVdWnb1laRymDaIDWkwVp6XOXwMPO6J8d/3rvN9jiW2jRrmcdMZpXRQffrQSSbUp/kb065FqdaxyyXO6fW2qW2wsXCI3iIUYKaDA5waX73iAkEPiGLXQaOu4EErOQw4p/nmeIAghCBpR+wLTxHL+2NWYbiGoUUia2AM9DJC1f+h5Xt7Wk7w/I5gQMoPqdh03vjpebLuu7WeY92Zn4HHWyoI9lgyn/mHrpXKZ1Au36xdYsKhhEaOqEcyZ8iDY8bkPC7I2j8wXWkl4jG7FI/B2CNpK2QFD8pRPlKnx8tl7E6UJLR4RXW9Cd42PIU82TP59xSzn9is3NDzQfbt8HALyNajpfClrcLWj7ddGuCxAzUY6Z1cPEIIEKIEtJG8Nvi+f1UgXgDpRbp0qt6LpxQkf6GfHKdXn+wN7eV7xM9kJNpGrlAgSs/lU6s4Zun8BNwBTO9Pfkv0anj2kx/pVQ8XdIo7VoZVLTxck0gWSi1vTWvFaopNlY37s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(2906002)(6512007)(5660300002)(66946007)(91956017)(8676002)(316002)(4326008)(7416002)(2616005)(186003)(76116006)(83380400001)(85182001)(6486002)(38100700002)(122000001)(86362001)(8936002)(38070700005)(508600001)(66556008)(66446008)(66476007)(64756008)(6506007)(54906003)(26005)(36756003)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjVwakpWRGZOYTB3Qlh4bXRkTnRvU2UxWGtEMGNuVU9vRURlNkI0dVh6TkRO?=
 =?utf-8?B?UlVEVG1NdjNEZTlCaEQxYkNrc2M1c3BOYXZqK2VXUjVNUURNVUJvbysvdGdH?=
 =?utf-8?B?TTNjZ3NHM25JK2IwVysraFlKQXIvMEhuV0U0eEJPSjd5UHkyaFNqZlZrc1Bj?=
 =?utf-8?B?aVN4OGpORzYrUXJQeXVZSTl2bTBad1hPVnFLTWRPMml3N1liTmhndXZ2Q0Nq?=
 =?utf-8?B?a3krSlNaRmVsSUhQTCtzVVltcTdoTEFsUUF3N1FJbWRPVnJWQXNyVXd0Rmw4?=
 =?utf-8?B?ekt0cE9LN1grZGxBSzA2MmlFSVBsSjVCdHV2WFhUbTBiT3FwTVdVRU5FWUU2?=
 =?utf-8?B?OGVEQTFnY0tjd25tTVNlVmlmRU9Cb3ZmK2J6OEpqaFg5M0dYeHBJSzhuaUJ2?=
 =?utf-8?B?TXVaRVJTM0FaZTdkUy9rMnhJVlpFVVZiQTNzR0hPRnI0cExsNXc4WEtCaGpl?=
 =?utf-8?B?cmRqL1FsNlZXaHBiMmdKQ2V0VFh3ejNGRU1ONllUb1NuYlYrRGljck5ycGFM?=
 =?utf-8?B?Mmx4Qlh4RGdPZDN0WGlZclY3eG5RU1hrUEphUUlHZS9mREpuRWFTY1BSanQ4?=
 =?utf-8?B?Q3lWeVdZaTdxQjV5S1N1ak9na0QrOVRhNmN6NmlFK1h3b2lsN3JZZW8rVHoy?=
 =?utf-8?B?ZkZGK1IwQ1FJZ21YQWRRT2NFbUdPYkZxTDhIY2tzamphWmEwV1o1QlhpbDdQ?=
 =?utf-8?B?eXMzZWRPVzZmYlQwcE50NEd3ZStDVlg2dGdDUElreEkzZTJHNzNCMHRoenA4?=
 =?utf-8?B?MWtteEszRTFkc3pxdGJtbTB5V0dZSjNxT3A3UU82c2JPR1JxZkpYWGhYN0k5?=
 =?utf-8?B?aEFFeGpTYVNlaVZrTTJ2T2p3V0hNb1h2STJybWcvVkVrMFZ3Z0hyOVRQV2sr?=
 =?utf-8?B?SSt2NmVmWlNKODg3K05NZU1WcWo2YXNjc2NyRFRDUnNxL01QMS84UCtCQkpM?=
 =?utf-8?B?a0ZuZnVUQ0hPanZaeWtkdCtTUStSQ3k3a0lYS04yZUcyaE9mbjJvNE15R0hM?=
 =?utf-8?B?YVJSUDg5TzEwR1I0cmI3QTU3ZVRmNHdPazF2K21PNDE5T3FCVitnZmpHc3Ji?=
 =?utf-8?B?ZUtvMzFjN1YzZ2dVSmJBTmRINGJlc2RHZHNjdW1DdXVIcklkVkNtNDIvbyti?=
 =?utf-8?B?bDBXK2REQ1VlU0dHSDBVSWwzVUdFMXRRb3UvYmlQUkpIV1dZbjgyMnF0c2Z1?=
 =?utf-8?B?UHJEZS9DMHN0Y1ROL0ZWY2t0cEZYdTFHdDJ2RXFhdzZHa1hSbWVmZHIyVU56?=
 =?utf-8?B?TGlxU1Q1YkdvVDJJdWZUU2NGbWxNQjVaZ0xYck9qamdlVFNiM2VLbWNCeWtj?=
 =?utf-8?B?WWhLYjR4NjBqRUxTNndqYkNwN1BOL0RDcC96bDByWkYzRjFTL2NFeEQ4a0lD?=
 =?utf-8?B?bE01S0crRzVoZmZiblRvcTVhZC9OS0FzbHJGT3ZQeTVqYWI5SzMweFlVUU9a?=
 =?utf-8?B?VThYZEpoU0pILzB5Q1E5TEhmSDl4ZWxXeCsyU1lrUWk5WVJISnhHVFZkVHhy?=
 =?utf-8?B?Y25vNGNJdXV3S09Ua3l2M2U2Mkd0anZnVndIbERWb21DUW44SzFoaGRSWXBH?=
 =?utf-8?B?UVlwSE95YzBhaTlTMGRENlZhNTMxTlJTdHUvVGR2L3l2T08vT2ZsTHg5TVNF?=
 =?utf-8?B?U2doSlZZNkVsUlN0TS9Xd2xSczVKM0F4b0hzZFF2bUJKWUh5cHU4a2N4VVhG?=
 =?utf-8?B?UE1aUm9tMlZJKzdKVThJekcwdTRlemhsNXNSUlZxNnF5ZlV2OGU4V1JpS2Fo?=
 =?utf-8?Q?/rWjJs/KSFFH8KDTAY75VtoGqTzInWFlIhk5Z/g?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D9C9303D8EC5C48A06E52151417ECE9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd25db86-4065-4358-5a7d-08d96c48620b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 06:27:18.7192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFzsRkW2E05FaG4jN/HpHT945XAuvYgHV7wYMNOxyFhEkjD430GOgZpxEWEewD8iTFoBH91XluLdvAWVzNDN4uYPmioolX1JiqMYPdKHhTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5636
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDAwOjU5ICswOTAwLCBTdW5nYm8gRW8gd3JvdGU6DQo+IE1U
NzYyMyBoYXMgYW4gbXVzYiBjb250cm9sbGVyIHRoYXQgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSBv
bmUgZnJvbQ0KPiBNVDI3MDEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdW5nYm8gRW8gPG1hbnMw
bkBnb3JhbmkucnVuPg0KPiBUZXN0ZWQtYnk6IEZyYW5rIFd1bmRlcmxpY2ggPGZyYW5rLXdAcHVi
bGljLWZpbGVzLmRlPg0KPiAtLS0NCj4gdjQ6DQo+ICogYWRkIHRlc3RlZCBieSBGcmFuaw0KPiAN
Cj4gdjM6DQo+ICogcmVtb3ZlIHVubmVjZXNzYXJ5IHN0YXR1cz1va2F5IGZyb20gdTJwb3J0Mg0K
PiANCj4gdjI6DQo+ICogcmVuYW1lIHVzYjMgbGFiZWwgdG8gdXNiMA0KPiAqIG1vdmUgdXNiMCAm
IHUycGh5MSBub2RlcyB0byB0aGUgcmlnaHQgc29ydGVkIHBsYWNlDQo+ICogZGlzYWJsZSB1MnBo
eTEgYnkgZGVmYXVsdA0KPiAqIGNvcnJlY3QgdTJwb3J0MiBub2RlIG5hbWUgdG8gbWF0Y2ggaXRz
IHJlZyBhZGRyZXNzDQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzLmR0c2kgIHwg
MzMNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBhcmNoL2FybS9ib290
L2R0cy9tdDc2MjNhLmR0c2kgfCAgNCArKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM3IGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9tdDc2MjMuZHRz
aQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyMy5kdHNpDQo+IGluZGV4IDNjMTFmN2NmY2M0
MC4uMjFjOGEyOTFiNzRlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9tdDc2MjMu
ZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9tdDc2MjMuZHRzaQ0KPiBAQCAtNTg1LDYg
KzU4NSwzOSBAQCBzcGkyOiBzcGlAMTEwMTcwMDAgew0KPiAgCQlzdGF0dXMgPSAiZGlzYWJsZWQi
Ow0KPiAgCX07DQo+ICANCj4gKwl1c2IwOiB1c2JAMTEyMDAwMDAgew0KPiArCQljb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10NzYyMy1tdXNiIiwNCj4gKwkJCSAgICAgIm1lZGlhdGVrLG10ay1tdXNi
IjsNCj4gKwkJcmVnID0gPDAgMHgxMTIwMDAwMCAwIDB4MTAwMD47DQo+ICsJCWludGVycnVwdHMg
PSA8R0lDX1NQSSAzMiBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiArCQlpbnRlcnJ1cHQtbmFtZXMg
PSAibWMiOw0KPiArCQlwaHlzID0gPCZ1MnBvcnQyIFBIWV9UWVBFX1VTQjI+Ow0KPiArCQlkcl9t
b2RlID0gIm90ZyI7DQo+ICsJCWNsb2NrcyA9IDwmcGVyaWNmZyBDTEtfUEVSSV9VU0IwPiwNCj4g
KwkJCSA8JnBlcmljZmcgQ0xLX1BFUklfVVNCMF9NQ1U+LA0KPiArCQkJIDwmcGVyaWNmZyBDTEtf
UEVSSV9VU0JfU0xWPjsNCj4gKwkJY2xvY2stbmFtZXMgPSAibWFpbiIsIm1jdSIsInVuaXZwbGwi
Ow0KPiArCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQyNzAxX1BPV0VSX0RPTUFJTl9JRlJf
TVNDPjsNCj4gKwkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwl9Ow0KPiArDQo+ICsJdTJwaHkx
OiB0LXBoeUAxMTIxMDAwMCB7DQo+ICsJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIzLXRw
aHkiLA0KPiArCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCj4gKwkJcmVnID0g
PDAgMHgxMTIxMDAwMCAwIDB4MDgwMD47DQo+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiAr
CQkjc2l6ZS1jZWxscyA9IDwyPjsNCj4gKwkJcmFuZ2VzOw0KPiArCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPiArDQo+ICsJCXUycG9ydDI6IHVzYi1waHlAMTEyMTA4MDAgew0KPiArCQkJcmVnID0g
PDAgMHgxMTIxMDgwMCAwIDB4MDEwMD47DQo+ICsJCQljbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19U
T1BfVVNCX1BIWTQ4TT47DQo+ICsJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KPiArCQkJI3BoeS1j
ZWxscyA9IDwxPjsNCj4gKwkJfTsNCj4gKwl9Ow0KPiArDQo+ICAJYXVkc3lzOiBjbG9jay1jb250
cm9sbGVyQDExMjIwMDAwIHsNCj4gIAkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc2MjMtYXVk
c3lzIiwNCj4gIAkJCSAgICAgIm1lZGlhdGVrLG10MjcwMS1hdWRzeXMiLA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjIzYS5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMv
bXQ3NjIzYS5kdHNpDQo+IGluZGV4IDA3MzVhMWZiOGFkOS4uZDMwNGI2MmQyNGI1IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9tdDc2MjNhLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvbXQ3NjIzYS5kdHNpDQo+IEBAIC0zNSw2ICszNSwxMCBAQCAmc2Nwc3lzIHsNCj4g
IAljbG9jay1uYW1lcyA9ICJldGhpZiI7DQo+ICB9Ow0KPiAgDQo+ICsmdXNiMCB7DQo+ICsJcG93
ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UNzYyM0FfUE9XRVJfRE9NQUlOX0lGUl9NU0M+Ow0KPiAr
fTsNCj4gKw0KPiAgJnVzYjEgew0KPiAgCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDc2MjNB
X1BPV0VSX0RPTUFJTl9ISUY+Ow0KPiAgfTsNCg0KSXMgdGhlIGR0LWJpbmRpbmcgcGF0Y2ggYXBw
bGllZD8gDQpJdCdzIGJldHRlciB0byBwdXQgaXQgaW50byB0aGlzIHNlcmllcyBkdWUgdG8gdGhl
IG5ldw0KY29tcGF0aWJsZSAibWVkaWF0ZWssbXQ3NjIzLW11c2IiIGlzIHVzZWQgZm9yIHRoZSBm
aXJzdCB0aW1lLg0KDQpSZXZpZXdlZC1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVk
aWF0ZWsuY29tPg0KDQpUaGFua3MgYSBsb3QNCg0KDQoNCg0K
