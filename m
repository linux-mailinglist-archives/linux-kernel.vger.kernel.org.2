Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD69436F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhJVCAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:00:00 -0400
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:42725
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230190AbhJVB75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:59:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKfvu9g97RlJya47Ff0lNiHEwZ9CxWJDMaKu7YNXo3ko/xryyCyFZm3QxPLU3eEoKx+JT34pE9X2xH2sdChTvBcWHAjFIlTtlKsyS4JbXC2l68hFeaS2pLMCaTDn63lfhd8zvIoyDicC2hAEsF7RYFZTlHY1u3qrd/nUjeJ8yTwlBCy6fRGQ8+8McRx3a3B01mdvVBcOq8eliAv7T/6uz9HUliXW0ya23cpAP5xsRVdEEaUYeNjAwUFIRMIW5r+BqwdlIUWh2QrQX5S60JrHnzAhz+GKz+KNh+EQHQcDyNbCHK2wKj3dR6Z0cCRbyDDNyNMU7nEEHdmV7AGIq7VjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=albpRxz3zmUGWloRDjO0LJQuLzGIWP2LoYB7+rRb3SU=;
 b=gTe7A85p1Rxgk1Psl97BlwXF5jQiJuYvybslLq3FwImSvIKp4vbCAgRVNmPgxcKqCpml3CoXmHB/BXe/CuXHulZz9ZrcXXZ5lo+wsbXDodd2LjdQhamQ3UhM4q7iDvKPRFqcLgqHZaUgDce8YsSAcFbIHyDluGRDxmsJs5JzFBlHz/4HGZDgnBojmpzpZHYoSfaehwBskcofY+HeDpt+3a831NjLBo3RhbgnICdUuTarvfZHgiybl9NemFxv3mkZsbvhTIrTyq/CuZYxf/36q/XjuM0IsgxNoFy8S7oPDYOLGqcNp+KtlWJtYnbkbVcorl8EvBBnKkm9K8dn/hIotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=albpRxz3zmUGWloRDjO0LJQuLzGIWP2LoYB7+rRb3SU=;
 b=CVqqiMD8D1ldB7W8m6YY5aZ5E/gwRg5BFHSp+bb9zKXtnB5bqikm2z1tGCyjkZGNUjwDKWNhw5wePL80EU+LRyd/PjqWcikKJdr4nXZHLt0iK3As05QMYwFoivsm1VZjeMMTdMbLFkwxd3w8wsbrzIqkMYu2l65juSwRcYJJAL8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 01:57:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 01:57:38 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 3/9] arm64: dts: imx8mm: add the pcie phy support
Thread-Topic: [PATCH v3 3/9] arm64: dts: imx8mm: add the pcie phy support
Thread-Index: AQHXv0hmtOht47yCTEie2PLD2LHQ3avUZuMAgAnqzNA=
Date:   Fri, 22 Oct 2021 01:57:38 +0000
Message-ID: <AS8PR04MB867664014F9C0972C1B6B8F18C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
         <1634028078-2387-4-git-send-email-hongxing.zhu@nxp.com>
 <81462d405b92472c699f47c0d49e980cda857426.camel@pengutronix.de>
In-Reply-To: <81462d405b92472c699f47c0d49e980cda857426.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2bae851-88d8-4e5a-7638-08d994ff5366
x-ms-traffictypediagnostic: AS8PR04MB8820:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB882070B82417F45619638CA88C809@AS8PR04MB8820.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wipUvoVEP0R7mx6ldDS7I+O0xh4QzjLUNWJFG4YJY0EX8+pVjSI8fP3L9S/WlsFd5QH5AW/Nju6e48c3hTq2iejTDbFvho8pjlmK1g9RPOu/I3mVAVrd5ZWOMxjNBcWuwSqBkckTjTIuNoEUvs3IKR9ssd+nJtaQKQuzkD1l8XWr8At6/K14q31GRpLgc3OCBeAV+lRGNo8cCUfMs8x5L6/muE6DVayyeWgeDiRMB5r8tYKcqosGs+PbTm3Nd4h/ZE5J9CwUbLmJh/bgoiNxQkrGGSo2lz6fkniRKrtQUs84TSr8SPPRfOqHQqImdW2DHv6POz1gcV6qWDa0DjQLSfJl9U+V6OYNX4RXY5hdaFn4AxBgDQ9nPPdyF8yGY8ymIQSpQUfWJoVkVebD5IA0Nn6OCv+9lSqvkJhq6+SXavo/BNoDnTvTXbEnANpucvuzzHOnDp/z34C5HhrtkpMPfQhjbNsZu6J0oQXZ2pDcP0UNNbg/ngx8XUA2ssELUSGmxzvzppgyP70T0JwEMCMUHxcDbtqcfyeihm+W1i4bTb5Cg7Wo35YZPrvFi1AN/efA6977Y3uAwIXrvyiOlv8ig7qKpFKuTvL8wJMIFR7PjlJmo8UbYLaziSYgwRTw9jmDcO4IKUTNZLVUTex702HTe5TJqYsAjpKYnQs2ApFkyrJpZ5MQaIJ/qo2ybtvV/Eh93XlSX/hMfMR1j/TlZ293VT++qBEKH/mC8zvAR2TcJA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(8936002)(38070700005)(76116006)(71200400001)(54906003)(66476007)(8676002)(508600001)(66946007)(316002)(110136005)(52536014)(38100700002)(64756008)(83380400001)(7416002)(122000001)(26005)(4326008)(2906002)(66556008)(6506007)(66446008)(9686003)(33656002)(5660300002)(55016002)(186003)(53546011)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q055Y080UmJyTTQvTys2VDN5b0RUT1YzWlhnWnRaMlVVdkdmQzhZYXpSSWht?=
 =?utf-8?B?UDhLYWQwK1lzUzZTMTJMRTQwMnp3LzF0VHdTd2ZQQ0duNXNVQ1pEbEJudXl0?=
 =?utf-8?B?WEFpYjNqa1YrT2NYRVpKQkVjSGt2NFJGWStyWk5DbU9MNGg5YnVEbUcvZlc4?=
 =?utf-8?B?Q3h0aCtNQjhZUFJBVVYrcHN2d0F0aVRab3E4R2xUVEdaWTQ1VmcxcWlVTGta?=
 =?utf-8?B?Vkc4TE1kT2RzcEpxcktNa2tOS3FVYXBmUHYxR054OERXUDl0b0NxYitnZnZB?=
 =?utf-8?B?Z1FHdjh2MlBCWkpOVWFhRmtrc0g0ZUF3MlNVYkVabWpieFJ4N0p4a2wvTFo4?=
 =?utf-8?B?aWxvbUNpcHdDVnRQREM0UnZZRmtvcURqTHM5bHdpR0ExTjA5akhzQTNCeVZl?=
 =?utf-8?B?cHVsQnBEck02RWkzdmtSajZUYVQ5ZnJtcFZIYm8vdUlxTkM4TVlVMHpiMEF4?=
 =?utf-8?B?b1BwVjdkME01SStBdjRUM1VlNzJQOUxSWDJpWU0wbk9SNU02d2ZNL2Jhc3pT?=
 =?utf-8?B?cEYxY1ZhZmtQRWlsYzdvZVA5U2JlY2JCN1A1NG1OUUxVV1pOTndvV0JHcXJP?=
 =?utf-8?B?WHJrSVBCK2p6YWVldE9YWXdtWXhCSzZlOE0wd2ZkM2Zsd2MxWmZ2OEZmUEZY?=
 =?utf-8?B?V1hINnM5SzltNDJ2cWo4cmpJSld0TUNZOG9rdW9IWjdpdVNyRnpsSFJiNXRX?=
 =?utf-8?B?STFodzZSZm9Ea0FSMGR0NTJaL1FFNVVoa1VqMG4xWUQyWk9wT2FubWh1a21U?=
 =?utf-8?B?SjBjMENIbDNjd1JKOHM4K0lTc1VYSHBSY05lb0dndTdQdkt1ckdzZjZiWGEy?=
 =?utf-8?B?Mk5aZEV1bXlBbWpuaUcxT2dBZWtPeFVSZVU3cTlIQkVTT042bEZBVU5NQTZ3?=
 =?utf-8?B?SDFYSTJKdm5PWUxLaDJKWEg0TWNuOGVWNzhTa3dOcTh3SDJjZ2FISEJxWlhE?=
 =?utf-8?B?UUxFSmJlTHhPZlVhMkE1WFRHcDJNbzRtQTZwWEFUaTBDTmxZbUsyaWVicHdL?=
 =?utf-8?B?M1NUd0REODVVcUJkSk1tcUdXbCtJK3Z5SXRTamZKQU5VRnFlMWlZR3dUclhi?=
 =?utf-8?B?OUZQamNGV0Rpa2VFNjNjVllRVW0vbm81SlFVL09FZE5DVTNjQ3drTERUUGJN?=
 =?utf-8?B?ZWNIcnlGMkVESnFXVW01QWw0N3RiMndhM1VZcjJzc1U5Q3JNNlZTbW9mQTI4?=
 =?utf-8?B?RGRxTFBqNWwzUnE2TGpVeVlQRVNoOFpWR1JqK01kWmtDbTlQSU9SSWlOOWRG?=
 =?utf-8?B?eVpPT2ttNDJuZVBwaHRxajUvTEdNK0RsWmVJL1poODJ4NVpTdWREZVRuR0hH?=
 =?utf-8?B?ZUh6eGpHcGFzV2FQRDlHMjZnWWJldzVCUmxkU2dTQ215WWU0WkRuNXhpWXhk?=
 =?utf-8?B?MXlyWmI4cWorYzVhYUlIbUJQcFRVWGdQQzVyTUlLYU1zMXBIMnQ0amEzNFNP?=
 =?utf-8?B?M2NvcFF4YnF3MzIzby80QkZ5RlE2Q2J6a3JBNXQ2NHZJMWRLQUp2RmxyTjdC?=
 =?utf-8?B?eUpRQks3VXhKNnRHdnZtWFlZdFpnb3VzOUk2T1Nvbi9odWhsbFNYTzdkN09L?=
 =?utf-8?B?UmF4cFF5bzZVaTVRQ1o2enFzUzZPV0NlS3hUSDRXUDcxUXkzMFV6dUFCajNt?=
 =?utf-8?B?REdHVmN2bGlTMzVWT2JWdnpKdVM0Y3cxM28rcE14Ym11UVdSSjFESjFDbnJO?=
 =?utf-8?B?MmxrYUY3dVNaYUtoRWhwdDRVVUVXL09tZzM0d1M0MjdzWGo0NEN3Vm1IaTZQ?=
 =?utf-8?B?c3BLWnlPb0x6eTFCMmN3N01Ja2FlYmcvOEo1dCsvc08zZGpjd1Z6TGFEN29y?=
 =?utf-8?B?eVpqL3ZaLy82cnpzUnZDbXRLaTVjdVYySHVKdHVKN2Z3QWZBKzN6RlNpbWJp?=
 =?utf-8?B?SXVYVlBXaWdSemR5NmtnZWpZZXBTV2o0bFFIMnc4V2tQNVUxNkxoQnM1VVg4?=
 =?utf-8?Q?V2SxLqLV5Os=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bae851-88d8-4e5a-7638-08d994ff5366
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 01:57:38.5465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hongxing.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTYsIDIwMjEgMjoz
MCBBTQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgdGhhcnZleUBn
YXRld29ya3MuY29tOw0KPiBraXNob25AdGkuY29tOyB2a291bEBrZXJuZWwub3JnOyByb2JoQGtl
cm5lbC5vcmc7DQo+IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IHNoYXduZ3VvQGtlcm5lbC5v
cmcNCj4gQ2M6IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy85
XSBhcm02NDogZHRzOiBpbXg4bW06IGFkZCB0aGUgcGNpZSBwaHkgc3VwcG9ydA0KPiANCj4gQW0g
RGllbnN0YWcsIGRlbSAxMi4xMC4yMDIxIHVtIDE2OjQxICswODAwIHNjaHJpZWIgUmljaGFyZCBa
aHU6DQo+ID4gQWRkIHRoZSBQQ0llIFBIWSBzdXBwb3J0IG9uIGlNWDhNTSBwbGF0Zm9ybXMuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNp
IHwgMTMgKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtbS5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kN
Cj4gPiBpbmRleCBjMmYzZjExOGY4MmUuLmFjNWQxMTQ2NjYwOCAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiA+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNpDQo+ID4gQEAgLTExMzUsNiArMTEz
NSwxOSBAQCB1c2JtaXNjMjogdXNibWlzY0AzMmU1MDIwMCB7DQo+ID4gIAkJCQlyZWcgPSA8MHgz
MmU1MDIwMCAweDIwMD47DQo+ID4gIAkJCX07DQo+ID4NCj4gPiArCQkJcGNpZV9waHk6IHBjaWUt
cGh5QDMyZjAwMDAwIHsNCj4gPiArCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1wY2llLXBo
eSI7DQo+ID4gKwkJCQlyZWcgPSA8MHgzMmYwMDAwMCAweDEwMDAwPjsNCj4gPiArCQkJCWNsb2Nr
cyA9IDwmY2xrIElNWDhNTV9DTEtfUENJRTFfUEhZPjsNCj4gPiArCQkJCWNsb2NrLW5hbWVzID0g
InBoeSI7DQo+IA0KPiBDbG9jayBuYW1lIHNwZWNpZmllZCBpbiB0aGUgYmluZGluZyBpcyAicmVm
Ii4NCltSaWNoYXJkIFpodV0gV291bGQgY2hhbmdlZCBsYXRlciwgdGhhbmtzLg0KDQpCZXN0IFJl
Z2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+ID4gKwkJCQlhc3NpZ25lZC1jbG9ja3MgPSA8JmNs
ayBJTVg4TU1fQ0xLX1BDSUUxX1BIWT47DQo+ID4gKwkJCQlhc3NpZ25lZC1jbG9jay1yYXRlcyA9
IDwxMDAwMDAwMDA+Ow0KPiA+ICsJCQkJYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmY2xrDQo+
IElNWDhNTV9TWVNfUExMMl8xMDBNPjsNCj4gPiArCQkJCXJlc2V0cyA9IDwmc3JjIElNWDhNUV9S
RVNFVF9QQ0lFUEhZPjsNCj4gPiArCQkJCXJlc2V0LW5hbWVzID0gInBjaWVwaHkiOw0KPiA+ICsJ
CQkJI3BoeS1jZWxscyA9IDwwPjsNCj4gPiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4g
KwkJCX07DQo+ID4gIAkJfTsNCj4gPg0KPiA+ICAJCWRtYV9hcGJoOiBkbWEtY29udHJvbGxlckAz
MzAwMDAwMCB7DQo+IA0KDQo=
