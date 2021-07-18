Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DA53CC860
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 11:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhGRJ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 05:58:26 -0400
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:44678
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229578AbhGRJ6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 05:58:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSK5RIwBw1a850KADFVtxu9VxrIyRDhpr+7AyBcotTnzJhc2jwsK+DYb+zqk3z79nY0n4rOiKQ1v0iKutghMOEXST9chiZSUUwZc32DhSHh6kwrQKqhErIf7nYdGPjlAdXWuczqbo4pLrCQ2xiceS40hT/XBp45uzB/GtfCPUftZMPMAPJWLTzfAEDBJMS6785xvskLC17pnMP8u+HH41RchT88TjewWO5Ccq0W+VIoefgckmpwYcSZAeEEvWIwLVI5u7PXB/EHrAGnEFJj3hUg38JyiWKOIu6MfnfAUyO24GijLnLgZq+LSX/T9ubROKasZrwnLDToEzDQsmZ6YnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBZwHa7zaQrSbJQgrW2UtJzlg0kybjQwjZ+/7khIf8s=;
 b=isqNZww+B0fEXbpiaJOAERQUtGvCMbRSG/6AwcEOhQpFYQ8mliSZGDqqLLuXYF53OKquX9MDH8MaR/Zr/B4q+simOzlrmoH4mwjE0az5heXbKOBcRDkDrQo2CLMyHdvIgPs2jfPJGbISQycZx9fIOrOsYHPaQb+bqw8/u2SD7QTAxHNHsshCsEbY2NE0JNMi243PikjHO92oIxOazmX2SX+62POf0fRgluBs+1z9ZL3FtQjLPw0Lczq1OmIwQ4NXN6DTg83wxJoC0elpwABg5ExRX9x4ECjaKXDaJ5O5avIzl83jXgo/CWh3rwsVQ7vNV03phRzK1A0ZvZ+eM+vZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBZwHa7zaQrSbJQgrW2UtJzlg0kybjQwjZ+/7khIf8s=;
 b=nPsM8DJZF2faI+1bc0WcfFPBoYQsFRfamJCvqQaUN0oWSYGeI4lX2HeJauaw9Au2cOwZ+HbhyAvIyMPEhJuFqkGxXcqOJotI4tA68h91ol9vuO4b3a6SvJA2uT+SDUWdy2MnDEdlbKNt2suQXe3+u8vn9EqTEdd9SflGCBOL8YI=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2313.eurprd03.prod.outlook.com (2603:10a6:3:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Sun, 18 Jul 2021 09:55:22 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::40f1:967f:ee9f:ea90]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::40f1:967f:ee9f:ea90%7]) with mapi id 15.20.4331.031; Sun, 18 Jul 2021
 09:55:22 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "gene.chen.richtek@gmail.com" <gene.chen.richtek@gmail.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "inux-pm@vger.kernel.org" <inux-pm@vger.kernel.org>,
        "benjamin.chao@mediatek.com" <benjamin.chao@mediatek.com>,
        "cy_huang@richtek.com" <cy_huang@richtek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gene_chen@richtek.com" <gene_chen@richtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wilma.Wu@mediatek.com" <Wilma.Wu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v6 1/3] lib: add linear range get selector within
Thread-Topic: [PATCH v6 1/3] lib: add linear range get selector within
Thread-Index: AQHXeicgfZyLQURgy02fHGmRYUcoRatIgcGA
Date:   Sun, 18 Jul 2021 09:55:22 +0000
Message-ID: <a6af3a44529141fb931bef33e96b4c66b93d920a.camel@fi.rohmeurope.com>
References: <20210716094353.140536-1-gene.chen.richtek@gmail.com>
         <20210716094353.140536-2-gene.chen.richtek@gmail.com>
In-Reply-To: <20210716094353.140536-2-gene.chen.richtek@gmail.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a1725c6-fb9f-4a6c-83de-08d949d228a9
x-ms-traffictypediagnostic: HE1PR0301MB2313:
x-microsoft-antispam-prvs: <HE1PR0301MB2313EF4C0B77F8F50BD0DF2DADE09@HE1PR0301MB2313.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3dLW9gTTZagpukpkYyj2DW/HsPCUNIndGCvRrhGtD4hp4HHPNR9pCPuyMnbtDE0cBga+YKImZbKbq2AshzMiv7EDewvbhd6pVc2T6rjjnziZ/ffa/1+9Goq1+10C9R8LC9T/e0EFsAMyR7GNn9vW3YoT8btIhT/gHA4+Rtt1KBFkC4D7+xW36SqCmm9MDPYBJIc/Oz5OJfOxsttGwGFERhY/QG+x5PCfqGEwFDSpbU34Ex/WGjk3FUHq8FIfHLsHaInNVoxHfhJ0BtviFVbflZC63Ez17pHpYanIzQT9VOCEz4Y8GWxdzDXur65cdku30+k2Ld6rVDQ1IqMhissPyrlHLJRfsgnu4XZD+cDBHCkXFcGZ1z+OkbwTfwyp4Wf5R5qx/64LCGckY8q6yT2Wt0h2+r/9X80JTIe+RSdw6C8VHDqhkbgaXBFmmdikwLdyRAfNY4aUlH5zGMGVVJ9UiRwx7/JxcjB3/I7DPpZ4/CrvLIyo9B8aesq8PAO02uinCaEnErVeJVBYPF2w1yBHQX53lXPTIwoEnwR0shH+7I38Z1luRAk6IYBRkN2RtoMDKqljT946gKmwCPWeg/tE84j4qB8micF8ytuvjfGj9xR9uSg8k2julaymWka89T3i4qB//nbiK2iXE3lm8ZRt2R6jYTxhRL3QhYNpTCnpSUdYMary2QqFPA7qN228zYAu7q4NMiH+vT1+8mO+pgm+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39830400003)(376002)(136003)(346002)(4744005)(86362001)(66946007)(66556008)(71200400001)(110136005)(38100700002)(6486002)(66476007)(8936002)(6506007)(64756008)(54906003)(8676002)(3450700001)(7416002)(316002)(66446008)(122000001)(76116006)(2906002)(2616005)(83380400001)(5660300002)(6512007)(186003)(478600001)(4326008)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZytadnFxUmhieTNtOXNtL1dkUUFyR3JmWHJuVjlpY3VVeU9zMTZYUHROcVB4?=
 =?utf-8?B?eW5McmRkN0RNc0oyTVoveFp6WXVjd3JBT0ZGaHRkaWpGSENOV1NIS1pTc0xm?=
 =?utf-8?B?VkJJTHFTOGttRHlodlNvUjdKN0luZGk2eitSTzR4d2lnaWNlMTVXTTkvNU5k?=
 =?utf-8?B?eXBsQkp6K3QyWUFrazVEMDNjTStLTFd1OWtrTVFuTEJYNWtpTUdMbDRQVlkv?=
 =?utf-8?B?a2o3WFN4VHhkTnBvdHFla1FZUVIvRFo1S0dZVEd6ZWZsQk13MVVQNlhtOUJU?=
 =?utf-8?B?Z3djaC8ySThpMXNYczY4VlV1dldOenR3M3dycnRnT2xHTTF5Zzk0Zlp3Skow?=
 =?utf-8?B?YXNNakN6Q1BvWStCeWdtT3VEM0g5Mm1QaWpkOG9GOHZzcHByMzMraUxoUEh1?=
 =?utf-8?B?UXdURTdRZkQ5QkxzREhnS2FLM1QyWHlyTTVTaG9rWFB0RDUvV2JLYXlsMjlJ?=
 =?utf-8?B?K2JBS1ZFZDhQVDRrdVlqek1NbHBaNkdiMFhFU1JtK0t3Tm1tQzRtMTdmS1FX?=
 =?utf-8?B?czhpM1ViV1BsS2xZN2ppRmR4RHo1b1UwU0JwK2tqMUxLRUNPMWZRNHkwOWhF?=
 =?utf-8?B?L25hbThub3VTbWlSbnJBcnZSNDl6Y3pveFBlanhHcmxKeXkxZHhnRFdxSEFX?=
 =?utf-8?B?bXE3b2Z0bCtkMmwyMHBHWDZYakhDdUtxczJXYS9PNUxkbjc3SjJqanNFWGVO?=
 =?utf-8?B?eFBLUWNjVGtOcVNWcEptNkM1WkpMNjhKU0VhYStXNTBCT1dlK3JZVEVNSGZM?=
 =?utf-8?B?bUswTXVqbWxUL0x5OUZKSUZOeTF4b2plNUswYzJsc1FrRmp3YkN6VnlnQkhv?=
 =?utf-8?B?M1oySkZ3cHdOR0EzMUx0c0dkbmNlcThEVTY4UC9TWWhwSUduUGRSS0FRUjli?=
 =?utf-8?B?RDY5ZWdkT0pQWTVZN3A3WHdTYTZ0RFVQNzVGMEhya3pRU2oyNTRsdDE1a0ZR?=
 =?utf-8?B?OGJId1RJRkpxVEFxU01lYi93WlpaVjdDd29PYTE1VEYxSzE5akk4MTNFYU1O?=
 =?utf-8?B?VlNGdE9yMlpuN2VJVDd1YWRucEhpTnR3dU83M2Z6RG1Xa29mSjUwT0V1K2pF?=
 =?utf-8?B?VVkzV2NwM25CYjh4YmU1TGZ5NUNuRCszM3hjNzAvRFVtc1oxWXpZdW9nSE1M?=
 =?utf-8?B?RlFmbXY5M1RCNlZzZXVjQS9tWUo4Z3JYZ04xQXJBdGlxbXA4ekdLYmwvOTZI?=
 =?utf-8?B?OXVINkxoT200QzFpbGV6OHlERHpId283SmZjRzg5M3F3T3BZd0syV3hmMzJY?=
 =?utf-8?B?LzFHMUl1RnhpNXhwQWZhU3lSUHIxd0pnUTg4enpmZk9SMS9EZVhlTTVEY0x2?=
 =?utf-8?B?OGlkSUgrRUtEZTQ2dS8xMXRicjM5TnJKQWpKVXdkcmQ2RGxVaGhLL0ZLb0t5?=
 =?utf-8?B?V3BrK1ZjWnlXL1VMMUN5ZndxUVRZemkrdjhhSkhRUmZvckFEZVRQc3ZQeUhq?=
 =?utf-8?B?ek83eVVEOE9YUmEweTkzUFZJOHNsQmw1RUpkM2dGTWY0RmsxV0ZFTHBUQi85?=
 =?utf-8?B?aUFWRUZCOExUMVFhVzhpM29FR1lhQVJCWEovLzNjTk5Rb0Q4VkNkUjBQZ2JN?=
 =?utf-8?B?RkJCVFJNcDN2bmtCQ2haeVJqNHMyVHZSQ0hDa2NHWXpmd2g2OGRPWi8wbEc4?=
 =?utf-8?B?RFlYYmVVTEJlaHRsQ2V0YVFiRW1zeFJoQitreVEweERKVk8xWjkyZitpMi9T?=
 =?utf-8?B?ZGh4ZE9xMEpDbXE5akVzemlmQ2xmR0QxUmpOYTd2SUhsMnY3VU4vM1RrbVdh?=
 =?utf-8?B?L1l0YnhXMlBWcC9zazVodnR1bGJZa0VsZ0VSak1HNG9wcFRjOFRqcVdmcTZn?=
 =?utf-8?B?V0RwTy81dHZrUFdNVzl2Zz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CB33D0871080D49AACC4F9AECBC9A4F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1725c6-fb9f-4a6c-83de-08d949d228a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2021 09:55:22.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/6QlfgyF8ZVr3WUMHCmA9HqLl0oLDoAQROcRSScTls0CSDhPKJ/wxnxdl5YPvlS1/V3dHIwY4z8P8MEb2OjWH+D/WGmHiTaG+4DNuELT+NWI8/aZYEj1H3TmUkesiLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2313
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMjEtMDctMTYgYXQgMTc6NDMgKzA4MDAsIEdlbmUgQ2hlbiB3cm90ZToNCj4g
RnJvbTogR2VuZSBDaGVuIDxnZW5lX2NoZW5AcmljaHRlay5jb20+DQo+IA0KPiBBZGQgbGluZWFy
IHJhbmdlIGdldCBzZWxlY3RvciB3aXRoaW4gZm9yIGNob29zZSBjbG9zZXN0IHNlbGVjdG9yDQo+
IGJldHdlZW4gbWluaW11bSBhbmQgbWF4aW11bSBzZWxlY3Rvci4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEdlbmUgQ2hlbiA8Z2VuZV9jaGVuQHJpY2h0ZWsuY29tPg0KDQpJIHRoaW5rIEkgaGFkIHRo
aXMgYWxyZWFkeSByZXZpZXdlZC4NCg0KUGxlYXNlIG1haW50YWluIHRoZSByZXZpZXdlZCBieSwg
YWNrZWQgYnkgZXRjLiB0YWdzIHdoZW4gc2VuZGluZyBuZXcNCnBhdGNoIHZlcnNpb25zLiAoYXNz
dW1pbmcgdGhlcmUgaXMgbm8gbWFqb3IgY2hhbmdlcykuIEVnLCBhZGQgYWxsDQpyZWxldmFudCB0
YWdzIGFmdGVyIHlvdXIgc2lnbmVkLW9mZi1ieSBsaW5lLiBUaGlzIGhlbHBzIHJldmlld2VycyB0
bw0Kc2VlIHdoaWNoIGNoYW5nZXMgYXJlIHN0aWxsIHBlbmRpbmcgZm9yIGEgcmV2aWV3L2Fjay4N
Cg0KQmVzdCBSZWdhcmRzDQoJTWF0dGkgVmFpdHRpbmVuDQo=
