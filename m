Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38D33C816
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 22:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhCOVAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 17:00:17 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:59494 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbhCOVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:00:05 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 12FKxHia023041; Tue, 16 Mar 2021 05:59:17 +0900
X-Iguazu-Qid: 2wHHiY2QgChMRL7HfM
X-Iguazu-QSIG: v=2; s=0; t=1615841957; q=2wHHiY2QgChMRL7HfM; m=ZJjqvTXot3TPXpFIfGTyE+48HF6aYviO/T37tBsXdQI=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1111) id 12FKxECh029422
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Mar 2021 05:59:14 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 495521000BD;
        Tue, 16 Mar 2021 05:59:14 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 12FKxDX8023702;
        Tue, 16 Mar 2021 05:59:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCGt0Ud0EHPMCu4n1NYH/cJDkByDssiGoutK4GECLT0tFktEaDbObpTXc3PRAelUkZ4ltvX8652UtNvRteSL5sNGBRkDiABDt77kNE/AFqkBD1IPfbKV1yNjrsz1jNTt6qFMRx+szbYUxtkXCAfW7Ase7wsHHxNCfuO8tMlb33kNjYM+zPUlFIP5Ym0GyHP3yznhd0r1f6vwrdR65xJU31TZNZNkIXoHN/nPQ64eGpYtV7lKbfYHPt34kLqTksCIpXTT0MSjlXng2JqAqquM3okn1TRNBVWACNCVGCX9r5mtm4HMnBm1/+WoRV3DJe4WBuh2BBLTtK0i80sA2NibWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUwfLPNLGdppnK+LgI4ngUvKQEhAM1TFeKJvkfU4YnQ=;
 b=ZU8ip8jif1H7DdOSfFzEdjZESxoSB5Cf4yV4qqUkNPnlTqluMyRBzjca8sbVW9y2VshNJayx6RefQ0XGmasF1tO0K84i6LeMPBKjecRmzttJ7855LnL3vKYEvefam6Mk7LHpXcAzfmWStWUnSuv5xbXuInO5z+jsXwd3X1j88K7p6jGVetTqjFCLX0l+pJV0QmYHzBKfQhZRS7fqxqmZMnQI7pch6C9TT/nGFmgLI+N7QF5z6a6hnDPDFDcwJLuOvrgnKwRKuyXo+g0bMA7hejPHVhjjx1/8hHcfTxf2cz+6VQ7LJ8oXZ/b4HscXSS+avBuo1Hl+g8qBSNTE3796VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <lukas.bulwahn@gmail.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <chenyu56@huawei.com>, <anitha.chrisanthus@intel.com>,
        <Jonathan.Cameron@huawei.com>, <joe@perches.com>,
        <ralf.ramsauer@oth-regensburg.de>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI
 ARCHITECTURE
Thread-Topic: [PATCH 2/5] MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI
 ARCHITECTURE
Thread-Index: AQHXGbUCeM82hwVXTkyp2kzcZ2/0oKqFh8eg
Date:   Mon, 15 Mar 2021 20:59:11 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298322B4D87B2BA2F24515AD926C9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20210315160451.7469-1-lukas.bulwahn@gmail.com>
 <20210315160451.7469-3-lukas.bulwahn@gmail.com>
In-Reply-To: <20210315160451.7469-3-lukas.bulwahn@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=toshiba.co.jp;
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e21e842-cf67-4e4d-df5e-08d8e7f52efd
x-ms-traffictypediagnostic: OS0PR01MB5906:
x-microsoft-antispam-prvs: <OS0PR01MB5906A16A93FB7FFEC5470EB4926C9@OS0PR01MB5906.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z0hCp4kOup9j2f9aGK/Ydz5eqNjYa57njqyyirCqhKAmh2hjbdg8Ico/uyxC8X/1ahSgejQqcjf8x5ZcgXt/Wk9Pwoo8GuUVR6gmMWem/JBJJqeWO5QRIbPML/nS/otSgT5XgSQ6xUcdQM7XRVjypsQ+pOLZZLQD+LZqe1OfRY00vOSBx6bGJQbgbKiR+W1CGYP+Ze1s62NbhTsm+JRvFqEJ1IQQEMToDRRY6wz0r5BpFblv4sLEDHqZjx1KyLc+j9r2i1ihP37a92rqV4Co6Zq19MIMqB2AEYdQvacxI78j+oAjYVib4Pixko2yGquKTHO2Jj4ll8pMJ54vNAlBR/BBx8N1BRbprpokHV97x4/XZZUdXxU/ZTfuXk9UYac50XFds+MYgjj+76Kr7z2UeA9BUukOof9IpvBvQWQK/yLjTKpyZCcQtG4mg7yKhRnxPmiSxpxtm+IX07hef9IkMQkiFijD/AHOvYAKdyhFC8wGVuYT4t7/3cjhQK/XGt2CxgqfRG+t8fP4yIDZcyliOwzcTup4AEic2lSzb5ES88230su9nBTobqoqT4KrqwW8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2983.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(136003)(366004)(396003)(7416002)(52536014)(186003)(110136005)(26005)(316002)(5660300002)(54906003)(2906002)(478600001)(86362001)(66476007)(4326008)(53546011)(64756008)(6506007)(71200400001)(8676002)(7696005)(8936002)(76116006)(83380400001)(9686003)(55016002)(66946007)(66556008)(33656002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UUdiMjZkU2ZxV3pZMUxLcjZ3Wjg3bGxxUHhTcURXK2xCVFBUL3ozOEsrUEJ3?=
 =?utf-8?B?T0VWcGJpd01icUtoK2JUMXc3TURwUnhxcFF1bnZ1V1N5Y0lGWEZkQ01OZXFK?=
 =?utf-8?B?ZSt3RWIxcEhFK2M5YUM4TjluV2ZMVTVPZkpuSVpWK0QzV2RyVDgzcUNmMVlq?=
 =?utf-8?B?U3JtNDZLdHBlM2J3U1lkWW1sWXRWVGZlUm5wVTF3R3VQN2EyR2hhSm1VVXFM?=
 =?utf-8?B?SUdPd3A0OVliSytDREw2YXZ2dTF3UmtWcy9SUlJUUi9Ub25UU2E2Tjk5RENI?=
 =?utf-8?B?MmY3UDdUc21JWkFQUnAvV29neUtUcUVTOWxNSEhZMndHV0ZRS2dETWJyMVNJ?=
 =?utf-8?B?Y0pvaWpDZWxOWXU0cFErWE9YNUJFaVViUDAwV09iUVp3L2xsVGptQ3ZkS1h3?=
 =?utf-8?B?VlJaSW83cW9vL2ZzSHEzR3RMMzE4TnBFNk9RUDFSc21tY1BxaEJBK0hWbURW?=
 =?utf-8?B?Y3kzL2lFb2EvZUkxSmxlOTQ1SnZ0OUNSc3Q0enBaaGcvUTFVUDVDeXhXbll4?=
 =?utf-8?B?aGpsMEVhaHpKWG5vUTNLSjVPWG91VDRmc3VxMTdGeEJkN0FubHNkN0N5dWRt?=
 =?utf-8?B?cmRnaWNnbFNwelRKRFpIQjJCdnJLOS9lOHZKZ1FZVUl4c014aWswNlBldkl1?=
 =?utf-8?B?SnpkejJxSUprcWdLWTJkNk9mRzZCQVQ5ODZuWUhQSlRiNExieWVzcnNibXFT?=
 =?utf-8?B?THd5cFJNMnhia3J1cTNVSWo2emtUK0JSYmh0ZXVYV3V3VkpKNDR3UmVhenlE?=
 =?utf-8?B?anNsVjlFL2ViOU1ONmJUVDZTTlZDZElCVTRvcG03WWRxaFgzZ05ETzBVUlpw?=
 =?utf-8?B?cG05UjB6MkdHSFF5ZEhsWnZIbDFrOCtMQy80VW1kSWpjVkNjdVVRMEEvNjZv?=
 =?utf-8?B?N1ZqeW9ESnNQVnNjUldCUllMOVFzYU9vSGx3RDhtMXUrc1poN0liWU9OUzZB?=
 =?utf-8?B?dXlIZEJUaExPUkNPSGVwQ2tRNzlWU25Xa3Bxa2ZpdmpTRDF0cGxYblFkUENl?=
 =?utf-8?B?cTVlQnZCOXR5RVhWWEtXVHVYYVg4RjBqOVhxWTdzaUdNZjNpdzROVUVVWEhF?=
 =?utf-8?B?dFpENHpEa3JqclFibW44QnJsaVRCaGdINUFEY1I2SHcwUnFaTWFkaXY0MGtM?=
 =?utf-8?B?bmZiMytvajhtR0l5azRFUnRSOEF6Z1ZEenh0bEVocEFEVHlRZzR2TE5ocGhZ?=
 =?utf-8?B?aHZsQXBMeTcwRVdJOUd1V2NmM0FEUlZnZ0RFSmJNcjFtcUVWWUU5MmFqQk1E?=
 =?utf-8?B?eFZpeVlXMWlKUFNqeWpnd3VmTGtEM2Z4em9tTUFFc213TGZKYmMvcGV2ZHY2?=
 =?utf-8?B?TTNPRDVvbXNiVkEyUWEvMnp6QkhUOFYxT1YzYnJwZm9kSGRsZk5sZU85WHVH?=
 =?utf-8?B?NmpaSmJ0Z1lGNS9MREpSaXRjSm8ySnNsR3h1bHZEeFdWdDFmdkdnZEY3cTBp?=
 =?utf-8?B?V3dzZ2xDNk02azVEejg5dEVTR1FUS3dMZkpBN3J4WG84VXpXbW1EYUcyUHI1?=
 =?utf-8?B?ZVZ6MWtOeUxqK3hpY1NFcTU0ZlA5QUV2S3d2RGhnOEFFQUJyWkI1SUlqZjVm?=
 =?utf-8?B?K2MrZjU0cE9hNW13ZitnNEh3RGRzMDNYb1g0a1IvSnd3TzJRL2tWdXIzTzBF?=
 =?utf-8?B?Rm5EVmFXa25mSGJEdkNacVdrUy9sdjJ4NmVBMCtaM3Ivd2JxdGVpMjJOZ3RT?=
 =?utf-8?B?a1hmNHNnRml0ZGlGdWtycEJteFcvSm9IU2M3ZWt3V24xdlovY1F1TVEyYlF4?=
 =?utf-8?Q?VlTcAYyjF4KFQAA6T5PL5puRxSbWFSuQVdhopCr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e21e842-cf67-4e4d-df5e-08d8e7f52efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 20:59:11.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPZFN8mxBf7Dcmul9rSiGUONUgX+80/xYiALcspVj1foNTJOdOXIgnh9rH6L9dUoUVWFOMieNxTA+UKdg+QHTiT3v9LJVk5+FJch7RrkOgRk/DECT+gd6qv8x0iACNW8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5906
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVrYXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVrYXMg
QnVsd2FobiBbbWFpbHRvOmx1a2FzLmJ1bHdhaG5AZ21haWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5
LCBNYXJjaCAxNiwgMjAyMSAxOjA1IEFNDQo+IFRvOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJu
ZWwub3JnPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGl3YW1hdHN1IG5vYnVo
aXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KSA8bm9idWhpcm8xLml3
YW1hdHN1QHRvc2hpYmEuY28uanA+OyBZdSBDaGVuIDxjaGVueXU1NkBodWF3ZWkuY29tPjsNCj4g
QW5pdGhhIENocmlzYW50aHVzIDxhbml0aGEuY2hyaXNhbnRodXNAaW50ZWwuY29tPjsgSm9uYXRo
YW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPjsgSm9lIFBlcmNoZXMNCj4g
PGpvZUBwZXJjaGVzLmNvbT47IFJhbGYgUmFtc2F1ZXIgPHJhbGYucmFtc2F1ZXJAb3RoLXJlZ2Vu
c2J1cmcuZGU+OyBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBMdWthcyBCdWx3YWhuIDxsdWthcy5idWx3YWhuQGdtYWlsLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIIDIvNV0gTUFJTlRBSU5FUlM6IHJlY3RpZnkgZW50cnkgZm9y
IEFSTS9UT1NISUJBIFZJU0NPTlRJIEFSQ0hJVEVDVFVSRQ0KPiANCj4gQ29tbWl0IDgzNjg2M2Ew
OGM5OSAoIk1BSU5UQUlORVJTOiBBZGQgaW5mb3JtYXRpb24gZm9yIFRvc2hpYmEgVmlzY29udGkg
QVJNDQo+IFNvQ3MiKSByZWZlcnMgdG8gdGhlIG5vbi1leGlzdGluZyBmaWxlIHRvc2hpYmEsdG1w
djc3MDAtcGluY3RybC55YW1sIGluDQo+IC4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BpbmN0cmwvLiBDb21taXQgMTgyNWMxZmUwMDU3DQo+ICgicGluY3RybDogQWRkIERUIGJp
bmRpbmdzIGZvciBUb3NoaWJhIFZpc2NvbnRpIFRNUFY3NzAwIFNvQyIpIG9yaWdpbmF0aW5nDQo+
IGZyb20gdGhlIHNhbWUgcGF0Y2ggc2VyaWVzIGhvd2V2ZXIgYWRkcyB0aGUgZmlsZQ0KPiB0b3No
aWJhLHZpc2NvbnRpLXBpbmN0cmwueWFtbCBpbiB0aGF0IGRpcmVjdG9yeSBpbnN0ZWFkLg0KPiAN
Cj4gU28sIHJlZmVyIHRvIHRvc2hpYmEsdmlzY29udGktcGluY3RybC55YW1sIGluIHRoZSBBUk0v
VE9TSElCQSBWSVNDT05USQ0KPiBBUkNISVRFQ1RVUkUgc2VjdGlvbiBpbnN0ZWFkLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTHVrYXMgQnVsd2FobiA8bHVrYXMuYnVsd2FobkBnbWFpbC5jb20+DQoN
ClRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCkFja2VkLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9i
dWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+DQoNCj4gLS0tDQo+ICBNQUlOVEFJTkVSUyB8
IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggMjUx
ZTIwNWI1NDQ0Li44OTQwNGNhNzYwYjkgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsr
KyBiL01BSU5UQUlORVJTDQo+IEBAIC0yNjIxLDcgKzI2MjEsNyBAQCBUOglnaXQgZ2l0Oi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2l3YW1hdHN1L2xpbnV4LXZpc2Nv
bnRpLmdpdA0KPiAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS90b3No
aWJhLnlhbWwNCj4gIEY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvdG9z
aGliYSx2aXNjb250aS1kd21hYy55YW1sDQo+ICBGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZ3Bpby90b3NoaWJhLGdwaW8tdmlzY29udGkueWFtbA0KPiAtRjoJRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvdG9zaGliYSx0bXB2NzcwMC1waW5jdHJs
LnlhbWwNCj4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL3Rv
c2hpYmEsdmlzY29udGktcGluY3RybC55YW1sDQo+ICBGOglEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvd2F0Y2hkb2cvdG9zaGliYSx2aXNjb250aS13ZHQueWFtbA0KPiAgRjoJYXJj
aC9hcm02NC9ib290L2R0cy90b3NoaWJhLw0KPiAgRjoJZHJpdmVycy9uZXQvZXRoZXJuZXQvc3Rt
aWNyby9zdG1tYWMvZHdtYWMtdmlzY29udGkuYw0KPiAtLQ0KPiAyLjE3LjENCg0KQmVzdCByZWdh
cmRzLA0KICBOb2J1aGlybw0K
