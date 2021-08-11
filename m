Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513BD3E8E54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhHKKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:16:33 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:42884
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236785AbhHKKQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:16:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU/WctefnlIToUM+cb5C2iKwgI8oFqzD8pG75nJElUZEll46Pu6qM3ARz4/vb/stcQgReSPWzc8WEUgIrXg+KCTo07j9IwQLuqAPWwi0mBIj8df/lwYPzGiDK9roxYPcgTjg/oy9RtPbZjzKnWavCJxsYHTFM8u0kqqw32TJi4LK7iKAf9Cjsk0TRZfPwkBbMz8f9nfZpWb1ob6+c2VDKBoETbCl/P5hmSoeHGzIKQAYFbtPAPG51qF04SHBX4zPRfXBFr0Ih/9pU6OroWZ5tdiOqxy/IiQ/3ae5JYUHdUb12EkBpNt5oaR0+tLFaxxsNEWUkYo/GxaFFJDRCI1QoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syjt8LAJOuQHQ5nx6Ab6nGWg5IoTmZw0cdHBm2JGJYE=;
 b=HbBJHtyusjf68w2if4zzlleIneZGuRD/94eH8crfYFUyTd0iLSjDTTYg/4vdiNx0QL+i6hd6utVDInoEnZu7EfoMJFmKbRBrTiRdKWn83aEE94KrK6JGRUAke2vQf/EL+n94Vxam4egFEZzLL+0fQs93VoA3ceNh1fEWQj9jSVB8H1IBkd3oQJwPlGO4WcGC115CBKwJQ8J/ILKIvz3n3EcudApv9D7a5Ez7/qPk4CxzX5RCG8m9P5SOY52D6bHuuLGwvsIjZwwOnNZ0ZxQ2B1W+10f6QJOsthIgW+WM4/JTm7zbaAq+nrdiuTvVe2PbW3dE92ANx4WNodmYvzs8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syjt8LAJOuQHQ5nx6Ab6nGWg5IoTmZw0cdHBm2JGJYE=;
 b=kHBvEo6qQj2jYnE5VPunrgdQPCkH6BCLbm187a0Oh2Xs3aqvZcjMTva8TktPHZA2Ph6vt/h9vQETRHCAiR9n8HiSt3A5cc4/mWr0/jeaolWcHxYoWh/r5cOqlffxWJueyHGqFcXnlut/7z4YuyEQ+IPUbqUzR8t8qFaqMTbXJWw=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB7018.eurprd04.prod.outlook.com (2603:10a6:10:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 10:16:06 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::6969:eadc:6001:c0d%6]) with mapi id 15.20.4394.025; Wed, 11 Aug 2021
 10:16:06 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1 2/4] nvmem: core: introduce "reverse-data" property to
 reverse buffer
Thread-Topic: [PATCH V1 2/4] nvmem: core: introduce "reverse-data" property to
 reverse buffer
Thread-Index: AQHXjbpJi0D4d8PZZEmHsekciQjhp6tuEa8AgAABNjA=
Date:   Wed, 11 Aug 2021 10:16:05 +0000
Message-ID: <DB8PR04MB6795553231EB1AD65501549DE6F89@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210810073510.18218-1-qiangqing.zhang@nxp.com>
 <20210810073510.18218-3-qiangqing.zhang@nxp.com>
 <2a69b82c-0ecb-51cf-ea60-1827c60bfe85@linaro.org>
In-Reply-To: <2a69b82c-0ecb-51cf-ea60-1827c60bfe85@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8328322e-572a-42f1-881f-08d95cb107dd
x-ms-traffictypediagnostic: DB8PR04MB7018:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB70180F8406C9B1A5542B060EE6F89@DB8PR04MB7018.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FxsSUchPamd5mTjdX2U6pNfvgr7L1S8gAE8EVCem+w8MRQHYD+3YEcC/MC1Qz1Iw2eRwedU1m3MryHLbWwkV5rwYFo4o8lIw9i/zfVxmqZ7qxgkg1nKXeRqWnBsN83KmDTHCajuuM/1p2YYUMw7HyevTaJF7jVSwbeLkJ02pj0A0wfxD1Z2Pfez4P7+sm7kzdmICjSHYAQUq6NP7tRpRvuKQGkH/buAGjiByvfqsPj8dcDJA3e9mxnP9ei6IyWpf8gpReNDqbLbXt//eNyA+YV+4PzMtHCeZmrgkgjhZWIw4SiT663DurVwfeuFX91Cd5+3nrT2QWvVEX+XPYl3VvyDb5W6nlzmPQfY9MpKwzO+q4jOqLQNngY81ygKvtpx5UGO/MH10VySCtOX8OQytMccbBicxPxf5Pi8+VuZ9zmH2LBXybjCCsWCTg+Dd4k2GBb5pL4jR4VGJEIDvPf0aXrH3iDExXLxRNVel/jwHdN+N4fyXOV958FvJ0DIamosC5fRtpCxes903ubgjhItu0Km1rZ5tL+RhvSbVsAgRLxi6d8sCnApAH2gEVo1yMlXWgj7iEWnlB3jxAg1Cen9vydp9Pb/vHpOAlYPgFpflu3A8UqDRyUoOjRQdL/s36Wkyp+vGw/p94K+UTy806bRFXBfgPlUcbnRVFbvvBmsmmdOfoVdcJBoUNlwNFk59MaziC9x4mUvjwPHACgElHQ8zpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(316002)(33656002)(71200400001)(83380400001)(7696005)(55016002)(9686003)(186003)(26005)(86362001)(66476007)(66556008)(64756008)(66446008)(66946007)(508600001)(5660300002)(76116006)(53546011)(6506007)(8676002)(110136005)(52536014)(4326008)(54906003)(2906002)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3VHamxGSDh1MGpEVTlKUnpQL1pVdGtOQWVPbUU2WXZmWGp3N1MyOHlGeUlQ?=
 =?utf-8?B?WXN3UHpCcGhFUHRub0lMSWVLTEpXb0xFNDhocEMwKzdpN2JuamhUVU00Mits?=
 =?utf-8?B?NzFBZ1FCT2FaTnFvaDVVU2FrTnVNYWFuZEpidnJRN3VEcUhMRFA0cXZuOVhI?=
 =?utf-8?B?TVhMclVLbWdjc3d0V2ptRnNPZjZIelkwelFycHlDL05sQ20yNGE3empNNlRh?=
 =?utf-8?B?MUV1WktHMm9CSjFpeVZRN1daeU5wSC90VFg0dDZ1Vzg4RXN4V1VlejVBT3NF?=
 =?utf-8?B?ZC9CdlUzNGlpOHFuSVkrRm1BOHU0ZFZFajRHRGhHcmwvcFFjeE9yeS9aZWhK?=
 =?utf-8?B?OVdobjUzVUVwZzBDNUVRTlFNUG5CK1FFelZCM3ZiNFBpamJMQ2htNUNUQ0lx?=
 =?utf-8?B?VTJhN1M1NERiVGVTU2p6QUtYQzhXK0pTSkR1WVpzRjJTemIwK1BRK3hBb1VY?=
 =?utf-8?B?ZU1sTGFVazdHWnorWTlVVXIzT3Z0eDZhYkFCWEwrYlNnbnV2cUlnM05TazQy?=
 =?utf-8?B?bzJYSFZrSExxMWt6UWRic0N3eFg2bFNPYjRna3J6YzJxMlM2ak5tTlNoRXE0?=
 =?utf-8?B?ZTJ1OUdSVUVseTcyeXppQ0s2MHp0UFB1ak1FaWNDWldEQVI0RVZtdWtyQ1BF?=
 =?utf-8?B?ODk2NU1SZ0F3cDZ2NGlZWFJ1SUZKNExicFlLMVFsS05nQTNGVm9sbEd3TWNq?=
 =?utf-8?B?QXdJWTZHek9BeC9lUFVJZVI0YjNLUFhMS0ZKbDRsbGZqWkFxcjRJNHhpVGVa?=
 =?utf-8?B?bmJYWG9WWSszdXVYbThtYzJCOVdFN0orTlZvT2ZoZUtyaGZzZnI1NTV4b0I5?=
 =?utf-8?B?eGhQeEVVMWliZytkOXBXM2NOVlltUjNCMi9OTGJuanlOR1p2aGRkaFRiZTl5?=
 =?utf-8?B?M210bnRvZXJPOWpwS3ZGQW1IU2YvUHBBZVBjd1ZxMURET3hjT2FIUkxiSW5h?=
 =?utf-8?B?cjNZZWpJblQxNTdFVi9BUC9ZY21TQlorUFRrS2NFbU8wRVE1WDJKc1d5Z2ow?=
 =?utf-8?B?Qk1DV1dwVE1BbUhoNG5oWVZYbFdkNlJ3cVo0VTcvWlZpWFZvMUV3WDVnWEpt?=
 =?utf-8?B?L2MrNVBVb1VhVTBtRERGb2lDbng0NDZZVytMeXdyTXdNUFQ1UHpGWExyNWY1?=
 =?utf-8?B?clhtaldLcHdPTFIwSGhObVpwMFd5U2xkTTVnNktIYmdHY2o3aEg3ak0yKzFw?=
 =?utf-8?B?NVE0Zlc5U0t5KzI3OU5GdW5qSmx3TFdGeEdRL0FJNVdVK2NhaTdQQjErMDFL?=
 =?utf-8?B?KzcyeHFkWTRhdlJoV1BhNzNEaFdQVUNveVVEMFBZbDd1K1NpaVFjMzFZM1hG?=
 =?utf-8?B?UThjNGdxY1hVcmlZd2s0VUx4Y1ArN05ObnpSV3VYUnlNbC9nc3R0NDB3TlNh?=
 =?utf-8?B?U1pSVXljcmsxaE90aDNoVitQdXJZVTAwVUtBRCswWmx2UEZZMzVuWkpEZ1hW?=
 =?utf-8?B?Nm9vSDhkQjJub0JVWjZTWGdNWElGRmtpV01ZVDI4MHJMOGtnUjUwVWxDOG85?=
 =?utf-8?B?ZDYwYWRxSXlxWVpZSXdUNEcrQmJ3RjBlaFpVUHhEVlRJS0tnTjk5WFZtc053?=
 =?utf-8?B?V0NGKzBxM0FUVTZrZHNLaGlwUEhTTGZWZGd2VDFWV05qVWxqczJTelMrb0Zk?=
 =?utf-8?B?NSt2MDBCdksvaHlxTis4SnlNUWQyK0R0SktTcXU3THgrYVY4RCtSM3VXaDFn?=
 =?utf-8?B?RUFkYXVKUFg3UTlwT2JhcXZRc2tHWjdXRnRlWWFLRmY5ZEJUK1BjMjVCR00w?=
 =?utf-8?Q?RmMDj4rThrV4UZnDuAS1hoGS9TB+OEwnPTOAZFs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8328322e-572a-42f1-881f-08d95cb107dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 10:16:05.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQ3dWDYVhVnXp3D2ceJN6jX/K2lckis8puts6HE4mEOOGWQtmH+ci74daQg+MMdUPlcJWD4rIICmOYZB4UCsuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNyaW5pdmFzIEthbmRhZ2F0
bGEgPHNyaW5pdmFzLmthbmRhZ2F0bGFAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyMeW5tDjmnIgx
MeaXpSAxNzo1Mg0KPiBUbzogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT47
IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZw0KPiBDYzoga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCBWMSAyLzRdIG52bWVtOiBjb3JlOiBpbnRyb2R1Y2UgInJldmVy
c2UtZGF0YSIgcHJvcGVydHkNCj4gdG8gcmV2ZXJzZSBidWZmZXINCj4gDQo+IA0KPiANCj4gT24g
MTAvMDgvMjAyMSAwODozNSwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggaW50
ZW5kcyB0byBpbnRyb2R1Y2UgInJldmVyc2UtZGF0YSIgcHJvcGVydHkgYXQgbnZtZW0NCj4gPiBw
cm92aWRlciBzaWRlIHRvIHJldmVyc2UgYnVmZmVyLg0KPiA+DQo+ID4gRm9yIGEgY2FzZSB1c2Vk
IGZyb20gRXRoZXJuZXQgZHJpdmVyLCBvZl9nZXRfbWFjX2FkZHJlc3MoKSBtYXkgY2FsbA0KPiA+
IG9mX2dldF9tYWNfYWRkcl9udm1lbSgpIHRvIGdldCBNQUMgYWRkcmVzcyBmcm9tIG52bWVtIGRl
dmljZS4gTUFDDQo+ID4gYWRkcmVzcyBwcm9ncmFtZWQgaW4gaW14LW9jb3B0IGlzIE1TQiBmaXJz
dCBpbiBsb3dlc3QgYWRkcmVzcywgc28gbmVlZA0KPiA+IHJldmVyc2UNCj4gDQo+IElzIGFsbCB0
aGUgZGF0YSBzdG9yZWQgaW4gaW14LW9jb3B0IHJldmVyc2UgYnl0ZSBvcmRlcj8NCg0KTm8sIGl0
IGRlcGVuZHMgb24gaG93IHVzZXJzIHByb2dyYW0gdGhlc2UgZGF0YS4NCg0KPiBvciBzb21lb25l
IGRlY2lkZWQgdG8gY2hhbmdlIHRoZSBvcmRlciBmb3Igb25seSBtYWMtYWRkcmVzcz8NCg0KTm8s
IHdpbGwgbm90IGNoYW5nZSB0aGUgb3JkZXIgZm9yIG1hYy1hZGRyZXNzLCB3b3VsZCBiZSBjb25z
aXN0ZW50Lg0KDQo+IA0KPiA+IGRhdGEgdGhlbiBmZWVkYmFjayB0byBudm1lbSBjb25zdW1lci4g
RS5nLiBNQUMgYWRkcmVzcyByZWFkIGZyb20NCj4gPiBpbXgtb2NvcHQgaXMgOTg6ZTI6MDY6OWY6
MDQ6MDAsIGFmdGVyIHJldmVyc2VkIHRoZSBkYXRhIGlzDQo+ID4gMDA6MDQ6OWY6MDY6ZTI6OTgu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0Bu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9udm1lbS9jb3JlLmMgICAgICAgICAgIHwg
MzANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4
L252bWVtLXByb3ZpZGVyLmggfCAgMiArKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lbS9jb3JlLmMgYi9k
cml2ZXJzL252bWVtL2NvcmUuYyBpbmRleA0KPiA+IGIzYmMzMGEwNGVkNy4uY2NjMmM1ODAxYzhl
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbnZtZW0vY29yZS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9udm1lbS9jb3JlLmMNCj4gPiBAQCAtNTUsNiArNTUsNyBAQCBzdHJ1Y3QgbnZtZW1fY2VsbCB7
DQo+ID4gICAJc3RydWN0IGRldmljZV9ub2RlCSpucDsNCj4gPiAgIAlzdHJ1Y3QgbnZtZW1fZGV2
aWNlCSpudm1lbTsNCj4gPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkCW5vZGU7DQo+ID4gKwl1MzIJCQlm
bGFnczsNCj4gDQo+IFRoaXMgZmxhZyBhbHNvIG5lZWRzIHRvIGdvIGluIHN0cnVjdCBudm1lbV9j
ZWxsX2luZm8gdG9vLg0KDQpPSy4NCg0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3RhdGljIERFRklO
RV9NVVRFWChudm1lbV9tdXRleCk7DQo+ID4gQEAgLTkyLDYgKzkzLDI2IEBAIHN0YXRpYyBpbnQg
X19udm1lbV9yZWdfd3JpdGUoc3RydWN0IG52bWVtX2RldmljZQ0KPiAqbnZtZW0sIHVuc2lnbmVk
IGludCBvZmZzZXQsDQo+ID4gICAJcmV0dXJuIC1FSU5WQUw7DQo+ID4gICB9DQo+ID4NCj4gPiAr
c3RhdGljIGludCBudm1lbV9idWZmZXJfcmV2ZXJzZSh2b2lkICpidWZhZGRyLCBpbnQgbGVuKSB7
DQo+ID4gKwl1OCAqYnVmID0gKHU4ICopYnVmYWRkcjsNCj4gPiArCXU4ICp0ZW1wOw0KPiA+ICsJ
aW50IGk7DQo+ID4gKw0KPiA+ICsJdGVtcCA9IGt6YWxsb2MobGVuLCBHRlBfS0VSTkVMKTsNCj4g
PiArCWlmICghdGVtcCkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwltZW1j
cHkodGVtcCwgYnVmLCBsZW4pOw0KPiA+ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBsZW47IGkr
KykNCj4gPiArCQlidWZbaV0gPSB0ZW1wW2xlbiAtIGkgLSAxXTsNCj4gPiArDQo+IA0KPiBZb3Ug
Y291bGQgcG9zc2libHkgc2ltcGxpZnkgdGhpcy4NCj4gDQo+IHN0YXRpYyB2b2lkIG52bWVtX2J1
ZmZlcl9yZXZlcnNlKHU4ICpidWYsIGludCBsZW4pIHsNCj4gCWludCBpOw0KPiANCj4gCWZvciAo
aSA9IDA7IGkgPCBsZW4vMjsgaSsrKQ0KPiAJCXN3YXAoYnVmW2ldLCBidWZbbGVuIC0gaSAtIDFd
KTsNCj4gfQ0KDQpUaGFua3MuDQoNCj4gPiArCWtmcmVlKHRlbXApOw0KPiA+ICsNCj4gPiArCXJl
dHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIGludCBudm1lbV9hY2Nlc3Nfd2l0
aF9rZWVwb3V0cyhzdHJ1Y3QgbnZtZW1fZGV2aWNlICpudm1lbSwNCj4gPiAgIAkJCQkgICAgICB1
bnNpZ25lZCBpbnQgb2Zmc2V0LCB2b2lkICp2YWwsDQo+ID4gICAJCQkJICAgICAgc2l6ZV90IGJ5
dGVzLCBpbnQgd3JpdGUpDQo+ID4gQEAgLTcwNSw2ICs3MjYsOSBAQCBzdGF0aWMgaW50IG52bWVt
X2FkZF9jZWxsc19mcm9tX29mKHN0cnVjdA0KPiBudm1lbV9kZXZpY2UgKm52bWVtKQ0KPiA+ICAg
CQljZWxsLT5ieXRlcyA9IGJlMzJfdG9fY3B1cChhZGRyKTsNCj4gPiAgIAkJY2VsbC0+bmFtZSA9
IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiJXBPRm4iLCBjaGlsZCk7DQo+ID4NCj4gPiArCQlpZiAo
b2ZfcHJvcGVydHlfcmVhZF9ib29sKGNoaWxkLCAicmV2ZXJzZS1kYXRhIikpDQo+ID4gKwkJCWNl
bGwtPmZsYWdzIHw9IE5WTUVNX0ZMQUdTX1JFVkVSU0VfREFUQTsNCj4gPiArDQo+ID4gICAJCWFk
ZHIgPSBvZl9nZXRfcHJvcGVydHkoY2hpbGQsICJiaXRzIiwgJmxlbik7DQo+ID4gICAJCWlmIChh
ZGRyICYmIGxlbiA9PSAoMiAqIHNpemVvZih1MzIpKSkgew0KPiA+ICAgCQkJY2VsbC0+Yml0X29m
ZnNldCA9IGJlMzJfdG9fY3B1cChhZGRyKyspOyBAQCAtMTM5OCw2DQo+ICsxNDIyLDEyIEBADQo+
ID4gc3RhdGljIGludCBfX252bWVtX2NlbGxfcmVhZChzdHJ1Y3QgbnZtZW1fZGV2aWNlICpudm1l
bSwNCj4gPiAgIAlpZiAoY2VsbC0+Yml0X29mZnNldCB8fCBjZWxsLT5uYml0cykNCj4gPiAgIAkJ
bnZtZW1fc2hpZnRfcmVhZF9idWZmZXJfaW5fcGxhY2UoY2VsbCwgYnVmKTsNCj4gPg0KPiA+ICsJ
aWYgKGNlbGwtPmZsYWdzICYgTlZNRU1fRkxBR1NfUkVWRVJTRV9EQVRBKSB7DQo+ID4gKwkJcmMg
PSBudm1lbV9idWZmZXJfcmV2ZXJzZShidWYsIGNlbGwtPmJ5dGVzKTsNCj4gPiArCQlpZiAocmMg
PCAwKQ0KPiA+ICsJCQlyZXR1cm4gcmM7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAgCWlmIChsZW4p
DQo+ID4gICAJCSpsZW4gPSBjZWxsLT5ieXRlczsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L252bWVtLXByb3ZpZGVyLmgNCj4gPiBiL2luY2x1ZGUvbGludXgvbnZtZW0tcHJv
dmlkZXIuaCBpbmRleCAxMDQ1MDVlOTAyOGYuLjM2NGFjMmE2MWIxMQ0KPiA+IDEwMDY0NA0KPiA+
IC0tLSBhL2luY2x1ZGUvbGludXgvbnZtZW0tcHJvdmlkZXIuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
bGludXgvbnZtZW0tcHJvdmlkZXIuaA0KPiA+IEBAIC0zMSw2ICszMSw4IEBAIGVudW0gbnZtZW1f
dHlwZSB7DQo+ID4gICAjZGVmaW5lIE5WTUVNX0RFVklEX05PTkUJKC0xKQ0KPiA+ICAgI2RlZmlu
ZSBOVk1FTV9ERVZJRF9BVVRPCSgtMikNCj4gPg0KPiA+ICsjZGVmaW5lIE5WTUVNX0ZMQUdTX1JF
VkVSU0VfREFUQQlCSVQoMCkNCj4gDQo+IE1heWJlIE5WTUVNX0ZMQUdTX1JFVkVSU0VfQllURV9P
UkRFUiBhbmQgc29tZSBrZXJuZWxkb2Mgd291bGQNCj4gaGVscCBuZXcgdXNlcnMuDQoNClllcywg
d2lsbCByZW5hbWUgaXQsIGNvdWxkIHlvdSBwbGVhc2UgcG9pbnQgbWUgd2hlcmUgbnZtZW0ga2Vy
bmVsZG9jIHRoZXJlIHRvIGFkZCBuZXcgaW5mbz8NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpo
YW5nDQo+IC0tc3JpbmkNCj4gPiArDQo+ID4gICAvKioNCj4gPiAgICAqIHN0cnVjdCBudm1lbV9r
ZWVwb3V0IC0gTlZNRU0gcmVnaXN0ZXIga2VlcG91dCByYW5nZS4NCj4gPiAgICAqDQo+ID4NCg==
