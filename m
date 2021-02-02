Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B24F30B4E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBBBxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:53:54 -0500
Received: from mail-eopbgr1410097.outbound.protection.outlook.com ([40.107.141.97]:55936
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229530AbhBBBxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:53:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK3WVLan9bmeEY3jiSUaqeya7K7/tlKrh10K0+NK1I5vfVbohSHKqBi2v+AKqBbJytMv+Zb670JVa0QBx0ZrK1Wt0attDIp11q6p0eaQOSZH/Vr0kgZK27nRF6IJEJHAwmfiNF6qI9zIpKTHB0+D4SIEAijcnipS5X0LobrunmwBpFm34zEBEd0+38KRaS4XDZ/M4QnX3dhFt6TRetz6luOIXU6bf4SL1R83PuBEA1rwWxB7H+7PgRGiOahYBl3oY8D11nmMwRh8U7t5lBTfjFY9UQ4U0gg65wXGiaaYlCOM6yspIrCbWOQZ6hfGld1RCRQPrE2L/7NLDwEPoIGJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAvNcvgiFWWh1o2gA1cVNshCvtieKIO+TD+gJUfMlSI=;
 b=O7qDpXpj8coc47xkwzGcqKco98tTux+ik4HLC52S18zhGWqNes/V+hhnLMHRMOnnFT/klHdGA1Kq+5CjNowPnAGVNYe9/WHC2baBPUbp56ppAHxwBJu0329zYbPdI/RnkTLKkQVZ8gF/FvjHhWa/uTc1Z31s1uWD9qg4RYkXCBYO3/P23YLoCd9uV3vouWGc8x5XI/p4QnpXt9Zzrp6MYVW9iRVOxCRAoiggmXxh1AOc1rTUrAjgAkV38tx7rb9lSA3mCOyUFcf4TlDrKznvbQSOQKzHUxN8OVKRADpVCC+G0Xxt5RSXG5KDCFH1BFrUjVOGWJY91rQBXRpmz646hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAvNcvgiFWWh1o2gA1cVNshCvtieKIO+TD+gJUfMlSI=;
 b=Pd4k/qVAat/sATXBXo8KKlFVV+tvfIpaw3jYmaYHOkInGPdRtoLe6tkDrInJDxM52vDsQQAGz8bSasybk6IXbeFTkKqCCCUNrrM7Q768h4AT/VkASkDCSh5bO55LQtJvqTbedmahmGYJkrcwypfqbFdSpZgAThKM5Yti4b6lcKE=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYBPR01MB5391.jpnprd01.prod.outlook.com (2603:1096:404:8021::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 01:53:02 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f%4]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 01:53:02 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Peter Chen <peter.chen@nxp.com>
CC:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jun Li <jun.li@nxp.com>, Marek Behun <marek.behun@nic.cz>
Subject: RE: [PATCH v2] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Thread-Topic: [PATCH v2] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Thread-Index: AQHW+KwQWUDpv+TqrUKdpul0BfUiYapEGdlw
Date:   Tue, 2 Feb 2021 01:53:02 +0000
Message-ID: <TY2PR01MB3692F219ECD17213BEB8BFD4D8B59@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20201223162403.10897-1-pali@kernel.org>
 <20210201150803.7305-1-pali@kernel.org>
In-Reply-To: <20210201150803.7305-1-pali@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:b91a:f1ca:dcaa:6cff]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5230e5f7-eb27-464a-e1c0-08d8c71d469f
x-ms-traffictypediagnostic: TYBPR01MB5391:
x-microsoft-antispam-prvs: <TYBPR01MB5391FD6B66210BF548D4B775D8B59@TYBPR01MB5391.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPBAuPfPrPQbGcKcJnCOsv8/D770EL2J9+C0PftjquOOj0+6ZOaMrg/P2BxHbxe8lLPnsd+nBNAHaKw9wcfM/8LVnZ6kDJtkIQdIgFGNpedK0LanrBJxjtoTHuEyRKxbyAuwbIEcoM8rbysdC2n76hc1tHgdi5oNq+l1XQGemkf1ZfJMvEpPlhVn5mcslAAjjqph10rAgia0CFiZzckY/K2VT4LEgUSGEAiqu1/hhL/gmbyTFsW43G8ADLUIW9tqVVCYiNM/4u/5XiQ1JoQQSGecad32E7cHt8lDARFq06rYz1D0L9i61+1UoQ1qJWXn/4OYRNwk93lG2dl4/n2K98XPvpcYrv0USkxyfdxF0qKZwgfI/kAOYYnBrgagC14r/kZSrb1Utud6hfAIuPBQeJYBsh1fbNmWlkvtJr4W3krmvHWwR1x02kiD1h+TMUq9bFo52G+CBrWdgTFaCuoq9ydrIyefExu5Vf0MFSKMkdsELSsiuxHGUJMUxutkfkkvoJ4gaELz+F+0bdw8FTDSqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(76116006)(66946007)(86362001)(316002)(186003)(66476007)(66556008)(7696005)(83380400001)(71200400001)(64756008)(2906002)(4326008)(33656002)(478600001)(55016002)(66574015)(66446008)(8676002)(7416002)(9686003)(5660300002)(110136005)(8936002)(52536014)(54906003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cmQxdysrSk1QMi9YREd3VXRoQWdYN2x0cGh3ekxFRVVCekZ2T3k5STVIQjky?=
 =?utf-8?B?VXU5N0xBM2tGdTRHaXMyQnpLU0lqU2JYSldGVTJkcmRnaEZseFZqazJtcEFp?=
 =?utf-8?B?Wk9uWm9RUldOeWloeVNaQ1lXUFFkcXBCalgyOVNMTlNrY09BVkRZZTJWeXE4?=
 =?utf-8?B?TkVXeEtFL3A2QzJWaGNBNWFyaFZpYkt1YWNmckNhbUdqRGpLNTY0bThZQmc3?=
 =?utf-8?B?VjJmTm8rYUxNWm9Ed1BSa0doZGhvVG5GV2libTB3ZmRhbzBRVXRDRlVSdDUx?=
 =?utf-8?B?TmNycUdJMzVSaWtQM294cGQ5MmJDNkRhem1KalZ1Q08yb3RXMVVhN1pHRzE2?=
 =?utf-8?B?U1B0V3RLcG9yZVZ0SFgvTHFrQ3d6STNkc1BObkgwK2h2ZmtEbEFVYVltUkJm?=
 =?utf-8?B?NWtHMWhSbFFwMWQrbTJ6NkR2Unp5Q1VoMlVVcmxzR2dQRGJSVksrTC9yaWd3?=
 =?utf-8?B?WVdGRkE5VHRPU0NleUNXVUR6NUVQUE9kQ2pPeW51RUFmRUtkMFFWNnlDeE5m?=
 =?utf-8?B?T0JRMWljMVRyZFh1eTFVcGFZWW9RdzJMQWFHdUcwNEt4K243NisxNmJZcko0?=
 =?utf-8?B?NFRra2dkekFIR2xJa2tJcHk0UDN3QXlycGVkVGpZeDVvZytXdXRWQkhMRHND?=
 =?utf-8?B?WXJMVHg5alFXK0tyNGNkem94UjFqOVFOLzRUTDV2YzVXQXVYdEVNMkREeVVJ?=
 =?utf-8?B?M3pkZFNYejErUVlEUnZGR3QzcjZzWjBSRVc2OUFtVUo4MmVCUWllSDlqTDRr?=
 =?utf-8?B?UDJFUSsxV0hKWit5Ly8rcE9BdGloelNjdnNFWllEcnk1RTRGU21mOFNnNWR6?=
 =?utf-8?B?Q1lkdStleDYxRnlDNW01ZHM4akE0ZGg2NjFXOHNVU0c4enBpYy9WaVh1VEdz?=
 =?utf-8?B?Uk5SeGhhMzJYZVdHc0Y2citWbHRIOU9pazEyaEN5Q29SY2ZPeWV1czQvUGJz?=
 =?utf-8?B?N2dYd2s1MG8wUVM3UE8yS0lRRmZqMDQrQnV5bE1sSFM0VE4xaDJtZ2hGNmFj?=
 =?utf-8?B?QUd5eEk3ZjBQaVIzcHBFSXlKc01meEMxdU5ZT0FNYW9mUmFOV2t6c1hGbzNl?=
 =?utf-8?B?QmMrYVk0RVE4ckNRL1JTRkNGMkpEV2pvQVhESnNab2Z2RGV0bUxTR0JuNzBQ?=
 =?utf-8?B?NVFmSU9TdVFweVJSZU1EZVhPa3B4QlJ2M0hMU2xSOFMxczRPczdxWEFEdnV2?=
 =?utf-8?B?L0l4Nzh6bUlSSnVzV3phaEpOSkdBZmorTm9FSEhUbXg1WDI2TGdkemtFRnlT?=
 =?utf-8?B?TjZNVDJtT2FzZkxuTVlKb1d6M0Z6d1gxWHdoK0ovTXFSWmwyOWtCTXcyNjMr?=
 =?utf-8?B?VXJwY3lRQ1RSTnlxWWxMZjJWMmtSeUJQNkdDdTBEU1BnbDRvbW94VE1YV1hZ?=
 =?utf-8?B?M1J0Y0V3aWVtSmZWeVNlQWpxbCt2UWpIWkZoYUJmb3lTdzFTN0s4Yk80R1hn?=
 =?utf-8?B?Ni9iM0V0WVJITnB0U0hJUTJ2dTJiaFBhSktlaGp5NUtpZFFHcUNHTVFqaHFp?=
 =?utf-8?Q?F7WmVs=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5230e5f7-eb27-464a-e1c0-08d8c71d469f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 01:53:02.4318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+UhqOTKjinjBQZ3ox8Rj1HjV9OY8V3VJI5SgxuElPpu/GfhDPpMqJxDZeu/kfnQGcXrc61zzPA7c56Rzm7SxXftGhgYQWne8RxK0/ReBSQI2kyscv2zWKFVmXCL7Yxo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5391
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGFsaSwNCg0KPiBGcm9tOiBQYWxpIFJvaMOhciwgU2VudDogVHVlc2RheSwgRmVicnVhcnkg
MiwgMjAyMSAxMjowOCBBTQ0KPiANCj4gT2xkZXIgQVRGIGRvZXMgbm90IHByb3ZpZGUgU01DIGNh
bGwgZm9yIFVTQiAzLjAgcGh5IHBvd2VyIG9uIGZ1bmN0aW9uYWxpdHkNCj4gYW5kIHRoZXJlZm9y
ZSBpbml0aWFsaXphdGlvbiBvZiB4aGNpLWhjZCBpcyBmYWlsaW5nIHdoZW4gb2xkZXIgdmVyc2lv
biBvZg0KPiBBVEYgaXMgdXNlZC4gSW4gdGhpcyBjYXNlIHBoeV9wb3dlcl9vbigpIGZ1bmN0aW9u
IHJldHVybnMgLUVPUE5PVFNVUFAuDQo+IA0KPiBbICAgIDMuMTA4NDY3XSBtdmVidS1hMzcwMC1j
b21waHkgZDAwMTgzMDAucGh5OiB1bnN1cHBvcnRlZCBTTUMgY2FsbCwgdHJ5IHVwZGF0aW5nIHlv
dXIgZmlybXdhcmUNCj4gWyAgICAzLjExNzI1MF0gcGh5IHBoeS1kMDAxODMwMC5waHkuMDogcGh5
IHBvd2Vyb24gZmFpbGVkIC0tPiAtOTUNCj4gWyAgICAzLjEyMzQ2NV0geGhjaS1oY2Q6IHByb2Jl
IG9mIGQwMDU4MDAwLnVzYiBmYWlsZWQgd2l0aCBlcnJvciAtOTUNCj4gDQo+IFRoaXMgcGF0Y2gg
aW50cm9kdWNlcyBhIG5ldyBwbGF0X3NldHVwIGNhbGxiYWNrIGZvciB4aGNpIHBsYXRmb3JtIGRy
aXZlcnMNCj4gd2hpY2ggaXMgY2FsbGVkIHByaW9yIGNhbGxpbmcgdXNiX2FkZF9oY2QoKSBmdW5j
dGlvbi4gVGhpcyBmdW5jdGlvbiBhdCBpdHMNCj4gYmVnaW5uaW5nIHNraXBzIFBIWSBpbml0IGlm
IGhjZC0+c2tpcF9waHlfaW5pdGlhbGl6YXRpb24gaXMgc2V0Lg0KPiANCj4gQ3VycmVudCBpbml0
X3F1aXJrIGNhbGxiYWNrIGZvciB4aGNpIHBsYXRmb3JtIGRyaXZlcnMgaXMgY2FsbGVkIGZyb20N
Cj4geGhjaV9wbGF0X3NldHVwKCkgZnVuY3Rpb24gd2hpY2ggaXMgY2FsbGVkIGFmdGVyIGNoaXAg
cmVzZXQgY29tcGxldGVzLg0KPiBJdCBoYXBwZW5zIGluIHRoZSBtaWRkbGUgb2YgdGhlIHVzYl9h
ZGRfaGNkKCkgZnVuY3Rpb24gYW5kIHRoZXJlZm9yZSB0aGlzDQo+IGNhbGxiYWNrIGNhbm5vdCBi
ZSB1c2VkIGZvciBzZXR0aW5nIGlmIFBIWSBpbml0IHNob3VsZCBiZSBza2lwcGVkIG9yIG5vdC4N
Cj4gDQo+IEZvciBBcm1hZGEgMzcyMCB0aGlzIHBhdGNoIGludHJvZHVjZSBhIG5ldyB4aGNpX212
ZWJ1X2EzNzAwX3BsYXRfc2V0dXAoKQ0KPiBmdW5jdGlvbiBjb25maWd1cmVkIGFzIGEgeGhjaSBw
bGF0Zm9ybSBwbGF0X3NldHVwIGNhbGxiYWNrLiBUaGlzIG5ldw0KPiBmdW5jdGlvbiBjYWxscyBw
aHlfcG93ZXJfb24oKSBhbmQgaW4gY2FzZSBpdCByZXR1cm5zIC1FT1BOT1RTVVBQIHRoZW4NCj4g
WEhDSV9TS0lQX1BIWV9JTklUIHF1aXJrIGlzIHNldCB0byBpbnN0cnVjdCB4aGNpLXBsYXQgdG8g
c2tpcCBQSFkNCj4gaW5pdGlhbGl6YXRpb24uDQo+IA0KPiBUaGlzIHBhdGNoIGZpeGVzIGFib3Zl
IGZhaWx1cmUgYnkgaWdub3JpbmcgJ25vdCBzdXBwb3J0ZWQnIGVycm9yIGluDQo+IHhoY2ktaGNk
IGRyaXZlci4gSW4gdGhpcyBjYXNlIGl0IGlzIGV4cGVjdGVkIHRoYXQgcGh5IGlzIGFscmVhZHkg
cG93ZXIgb24uDQo+IA0KPiBJdCBmaXhlcyBpbml0aWFsaXphdGlvbiBvZiB4aGNpLWhjZCBvbiBF
c3ByZXNzb2JpbiBib2FyZHMgd2hlcmUgaXMgb2xkZXINCj4gTWFydmVsbCdzIEFybSBUcnVzdGVk
IEZpcm13YXJlIHdpdGhvdXQgU01DIGNhbGwgZm9yIFVTQiAzLjAgcGh5IHBvd2VyLg0KPiANCj4g
VGhpcyBpcyByZWdyZXNzaW9uIGludHJvZHVjZWQgaW4gY29tbWl0IGJkM2QyNWIwNzM0MiAoImFy
bTY0OiBkdHM6IG1hcnZlbGw6DQo+IGFybWFkYS0zN3h4OiBsaW5rIFVTQiBob3N0cyB3aXRoIHRo
ZWlyIFBIWXMiKSB3aGVyZSBVU0IgMy4wIHBoeSB3YXMgZGVmaW5lZA0KPiBhbmQgdGhlcmVmb3Jl
IHhoY2ktaGNkIG9uIEVzcHJlc3NvYmluIHdpdGggb2xkZXIgQVRGIHN0YXJ0ZWQgZmFpbGluZy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBhbGkgUm9ow6FyIDxwYWxpQGtlcm5lbC5vcmc+DQo+IFRl
c3RlZC1ieTogVG9tYXN6IE1hY2llaiBOb3dhayA8dG1uNTA1QGdtYWlsLmNvbT4NCj4gRml4ZXM6
IGJkM2QyNWIwNzM0MiAoImFybTY0OiBkdHM6IG1hcnZlbGw6IGFybWFkYS0zN3h4OiBsaW5rIFVT
QiBob3N0cyB3aXRoIHRoZWlyIFBIWXMiKQ0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+
ICMgNS4xKzogZWExN2EwZjE1M2FmOiBwaHk6IG1hcnZlbGw6IGNvbXBoeTogQ29udmVydCBpbnRl
cm5hbCBTTUNDIGZpcm13YXJlIHJldHVybiBjb2RlcyB0bw0KPiBlcnJubw0KPiBDYzogPHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNS4xKzogZjc2OGU3MTg5MTFlOiB1c2I6IGhvc3Q6IHhoY2kt
cGxhdDogYWRkIHByaXYgcXVpcmsgZm9yIHNraXAgUEhZIGluaXRpYWxpemF0aW9uDQoNClRoYW5r
IHlvdSBmb3IgdGhlIHBhdGNoIQ0KDQpSZXZpZXdlZC1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlv
c2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPiAjIHhoY2ktcGxhdA0KDQpBbHNvLCBJIHRl
c3RlZCBvbiBteSBlbnZpcm9ubWVudCBhbmQgZGlkbid0IGNhdXNlIGFueSByZWdyZXNzaW9uLg0K
U28sDQoNClRlc3RlZC1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVo
QHJlbmVzYXMuY29tPiAjIE9uIFItQ2FyDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGlt
b2RhDQoNCg==
