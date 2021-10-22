Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D79436FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhJVCJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:09:48 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:53729
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231958AbhJVCJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:09:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiNOld+GKphB0OGm4UJyr/HbksLdQiJDM5FVmRkIsSjpyJDRzTxYntXhUcdatwpuwLfASP9FNuFTR+SiKm1z+vVVpvxeqHs9BZFpww/+6mk2E86PE+pKYogEpk0Nym0rrgAs30padlLtBrTzKX3FT6cSSnyZOFgltQIjl+huMom+swVkagsOBMObKHGzev63a781fpdq6mc907FxEC9euXB6lxuJN+6LxqxVeGC5yh2tNvU7/so+wLEuldfGEpqBRzEXC7ztrbSNhpuSTUwmmyBOaXpCZAI3yN+IThuOduELVUj8Hm34T/D+MtuQyzpszp1PzywSJteaC3pNYSI8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92ITrQaM159ffdOnWT3ANa4VU8ia1pLQeO6pggibcAs=;
 b=PXQgI2ZNte/Jl/Bg1OFbY+YRcw57FYY8lmcUc01wqE4oP7fDqR6kQsdxS7rt4gcRAUqkesaFW3KBnpsPcVM4guXcy/jpAm2ph82oaMyHipXXjDPonBUlh5Un1+e5uYfEwCmUCAe6vMoG47BZX8cS4Lbf/YrupH3T1m5MllDWneB6DU4d145C65EOKLko1L6JXpqdhsmWmcmDQyvQ7waoxOy+rM5xUs4P/RFZpu6scEXU+Z/mqYzfljFmVAxomGHycK8iN0WS8myz76TQgOpZ8F7DV0E0SUGz7rbFostJk8WMc6pdo2nf/kUI7v5d1U0Yjo/+6uWQd9KQ3eYjdTZJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92ITrQaM159ffdOnWT3ANa4VU8ia1pLQeO6pggibcAs=;
 b=ZKIqm/sZmdfRhV2AUaByBwcXLxjBJD9JLtn8du1KfgkRCYXB3wG0BfjkzfsPdItLJcFAsd0OzHCo/3c4XQHPx17BzIbF7+rwLOUYZhhF/yR7izQC9ZjWjAtSK37lkvR7iqCevcz1WRlqAJRPCwY76ftXcD2bjMVEzd4xPYUH9eI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 22 Oct
 2021 02:07:26 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 02:07:26 +0000
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
Subject: RE: [PATCH v3 8/9] arm64: dts: imx8mm-evk: add the pcie support on
 imx8mm evk board
Thread-Topic: [PATCH v3 8/9] arm64: dts: imx8mm-evk: add the pcie support on
 imx8mm evk board
Thread-Index: AQHXv0hsbacPRtv/ckW1/tKlzw2/zavUcDuAgAnj/rA=
Date:   Fri, 22 Oct 2021 02:07:26 +0000
Message-ID: <AS8PR04MB86766965F158A4B3A6AF1FDC8C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
         <1634028078-2387-9-git-send-email-hongxing.zhu@nxp.com>
 <e761c991636d4a9ea7a7362dcba8983ee47e997a.camel@pengutronix.de>
In-Reply-To: <e761c991636d4a9ea7a7362dcba8983ee47e997a.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 108ffa24-7343-48a2-fc92-08d99500b1a2
x-ms-traffictypediagnostic: AS8PR04MB8851:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8851FADA14E5A059F5AF521B8C809@AS8PR04MB8851.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o41iuticXZ+NmObgOMDHbXv4AlsN2+K0XfVOhD2QWFhSTtc66j4I6kWfgUWvJd6gngdGDEbGPqchR2TEL51vUT3Tiyi13kGHqWgro2yZrzuRe3d8OKANZ1yYTYJMlj/Y6wFa21Z9o/xSfX/IRclFXtMzUq9jvhfKnq7jsG5Fmhx1/dfHiG1t5RHPOGfgOKZkDK3aBUPhTWyTDrk67Y1rkJ2URbvTkquzyYhc13n0wLMMmQE6Ml77JZ1Oso7LRIVoVGVgIB6IISJqCtxugOS81LMJkwVAIIuUH1YqWx3YjM6aEdDxd31WR7eG3qcl9Wfu1IDkAp+UCp6YZNqzL3h20bioigsmaCIMYvS31PJmyHan60RyYwVO2K7rqaejzkKWBkcZI358/hJFJ/trYQe7T9r8WOgQ4g0nxyNGP/L0KDn2ohneAojMiRV2p280X5uodMqsKCJsMa/PPoOX/hasvUT/k3r9qv/goEr4efwDJFULS/U8bzEaSITazDhGOGfVc4Koqm3x1lcUj77bpRH5Kac4vaxsE75mJh5IVrk5iyPh7/euqWrC+1BMSGROrWOzbAoGBVEQwLXluK8t5rNQUB8+7Xlqvf+qnwF4XZI9gkJYVhjkIONOTgdwOVkB5XzbymbhaRjslWJwXyQt45vP6BcdckO/DedRzOUzsV+U9AkLDlD6dA1VsZT3xDofniJGc0B14XnT/Q2fgOUVKisIF2tvg9KtQe+IyUDXdIql5LI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(76116006)(71200400001)(186003)(52536014)(64756008)(26005)(66476007)(66556008)(2906002)(8676002)(7696005)(38070700005)(8936002)(33656002)(55016002)(66446008)(4326008)(122000001)(38100700002)(6506007)(53546011)(9686003)(83380400001)(86362001)(7416002)(316002)(5660300002)(110136005)(66946007)(508600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0t5dFZ4bEJpakRwS2pucXF6clovQnZna092Z1lkb0liVU5PaXg5MytjSlZZ?=
 =?utf-8?B?L2N0UWRBQ3lHWkN0aTg4YWhiT2N5RGJHTkpaaVJIZC9EZ1V1SEEyUTM3c01H?=
 =?utf-8?B?WVFSRk53Sy9sQTZUcy81ZmpqaER2RjVNM3RHaC9wNy85NUMyTDdXaWxseUpY?=
 =?utf-8?B?ZGJ5bmhXanZyM2ZiTVFvcXlmd0JXaDhkU3k1NzJqZnNQTXJvcmw4UzQwTzlZ?=
 =?utf-8?B?bUw1UEI1V3pGZVlMcktQeXprUzNJWmc2eEIxUFd1YytTSGswa0VjSnNrZFlE?=
 =?utf-8?B?M2Mwc21OVG9rUkczbXQzRkpTQ2VPbmRvMHJBU3VGTDZFWG1xRG1jZW9Sd0cx?=
 =?utf-8?B?NFg1dW5kMkdYUWNtWVFjUDIwcmF4T3EyVVhmM3BzSTBFOGFXR2JiaHZLS0gw?=
 =?utf-8?B?OVc2UVg4WkhTQ1RNdE9GcFZRZzJEc044VWpESmw0ejJQbUNuVGl3Tk5aWDUy?=
 =?utf-8?B?cTgvU3RjSFNGeks1cnoxUjRmdEFIQy9GL0hPaWU5aEFtVE1lSmt4Rm9uNElK?=
 =?utf-8?B?a2xYaVVUV2Y3L1NxMlBOekNlNFRjb093TWFSdWt1OGdXKzFKNjcrSStRaGNO?=
 =?utf-8?B?VmMwK3dMZUtQNmhIQlNzcDlhbHR2bWhqelVlUXRPYjdHZ1dLNm1PYWcxY2h0?=
 =?utf-8?B?Q1V0T3p5UnJackVvbm5EcGJURzdVUDFHNkhOMCtoQjVVcnN1eWlERUh2V1VD?=
 =?utf-8?B?cVRneEhjSnhEbE5na0U3UzdJSnN5MjN5NjZYc2UxRWg5Q0tJaDZyaGhGR2Zz?=
 =?utf-8?B?OEdNanJzR1RYVnVrSjM3T3g0M1FxQVdwM1RHV093bFRWQXNJa1NlNDB3MWI3?=
 =?utf-8?B?ZDIvUzhjRkF1WXVhSzJtejZ3Wmc1UER6SzFnbnpIZTkxTEhFU24xYzNDSVVX?=
 =?utf-8?B?dFAxRWxOTVFNN3pUYng0dlVqQUo0dDZVdCtYcUFJQ3lFWUY3QTBocXVUYVV3?=
 =?utf-8?B?ZkJYOGlreUdrdHJ4TFhQZGE5Y2pnb0NXdlNBdVpyY0dleUNYTnNZTE9EN2x5?=
 =?utf-8?B?Q2NiWHpWMjYyN0FrY2xhNlQvb1YwaTlCcnNjbUF4S1EyUU9YUkRoaVJhYk44?=
 =?utf-8?B?OU1EeUJQblV6K2JGMHFoSitqQStRUkhmb2xXTmIrWmRKeDZRcGZGSXZxNzdn?=
 =?utf-8?B?SGVmdVdXblVuUnZNMnArY2RTa1hOMGdGajltZ3QrL2RoYjYxZExUcUZpYno0?=
 =?utf-8?B?VFhmUkkxRFBCMXJrOENQSHpGNlVPVDhlN0wyL2oySDJORG52RHZvYWZGTnFq?=
 =?utf-8?B?SjFlcnhSSC9BbW9uTjZ3aHVsOFNibUwrS2xYZkVRaWdwTjVVTDJrek1hNFlT?=
 =?utf-8?B?Rzl5M0ZuZ1BUd0RvNTdGVUN6Tmh1ZU8ybHlRYW1xM3ErRWIrdTBBVFhPMksw?=
 =?utf-8?B?Q3NzaXNoQ3RUR2c1dFVWa0oxK3JvV0M4V0VubUZpRkJyZUxaTjF4UytVbjJv?=
 =?utf-8?B?bXdNSVgyQXFuSnMwWmowbEJCNFBWbVRpRDhHWXBCbEJVWUo4L0tXOUlIam9j?=
 =?utf-8?B?QUpKZEZNRnE1VmdZTkxkQzBKQjRydVArOVZlWVZabmZ0Sy9wQUkwSEZYK09R?=
 =?utf-8?B?bnRMa1NGdUphZXpEQWUxdnQ1T1RkdDhwYkxGNnliYWZxUG50eE00RVZJb1ZH?=
 =?utf-8?B?T1VlTDA2R3JDS3U2SkpyVXhGT0RlaG5jdWFzSk5hM0NCVFZYUEk1eWwwRkRB?=
 =?utf-8?B?VVM1YWQ5L0RyUE9vemFFb3E2eTBRTzY0UGNlQ2kvdDhONGdmbVVyQzgvcTJs?=
 =?utf-8?Q?/PRizoNrWOiuLJUdnLid51mfetRdzJ4pDy4Xj9Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108ffa24-7343-48a2-fc92-08d99500b1a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 02:07:26.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hongxing.zhu@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTYsIDIwMjEgMzow
NCBBTQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgdGhhcnZleUBn
YXRld29ya3MuY29tOw0KPiBraXNob25AdGkuY29tOyB2a291bEBrZXJuZWwub3JnOyByb2JoQGtl
cm5lbC5vcmc7DQo+IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IHNoYXduZ3VvQGtlcm5lbC5v
cmcNCj4gQ2M6IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgOC85
XSBhcm02NDogZHRzOiBpbXg4bW0tZXZrOiBhZGQgdGhlIHBjaWUgc3VwcG9ydCBvbg0KPiBpbXg4
bW0gZXZrIGJvYXJkDQo+IA0KPiBBbSBEaWVuc3RhZywgZGVtIDEyLjEwLjIwMjEgdW0gMTY6NDEg
KzA4MDAgc2NocmllYiBSaWNoYXJkIFpodToNCj4gPiBBZGQgdGhlIFBDSWUgc3VwcG9ydCBvbiBp
Lk1YOE1NIEVWSyBib2FyZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxo
b25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpIHwgNDYNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpDQo+ID4gYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiBpbmRleCAy
ZDA2ODRhYzgyZjYuLjVjZTQzZGFhMGM4YiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiBAQCAtMzEsNiArMzEsMjMgQEAg
c3RhdHVzIHsNCj4gPiAgCQl9Ow0KPiA+ICAJfTsNCj4gPg0KPiA+ICsJcGNpZTBfcmVmY2xrOiBw
Y2llMC1yZWZjbGsgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPiA+ICsJ
CQkjY2xvY2stY2VsbHMgPSA8MD47DQo+ID4gKwkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwxMDAwMDAw
MDA+Ow0KPiA+ICsJfTsNCj4gDQo+IFRoaXMgaXMgYm90aCB0aGUgUEhZIHJlZmVyZW5jZSBhbmQg
YnVzIGNsb2NrLiBJIGd1ZXNzIHlvdSBjb3VsZCBqdXN0IHNxdWFzaA0KPiBQYXRjaCA0LzkgaW50
byB0aGlzIG9uZSwgYXMgdGhleSBhcmUgYm90aCByZXF1aXJlZCB0byBnZXQgUENJZSBvbiB0aGUg
RVZLDQo+IGJvYXJkLg0KPiANCltSaWNoYXJkIFpodV0gT2theSwgYWdyZWUgd2l0aCB0aGF0LiBX
b3VsZCBzcXVhc2ggIzQgd2l0aCAjOCB0b2dldGhlci4NClRoYW5rcy4NCg0KPiA+ICsNCj4gPiAr
CXJlZ19wY2llMF9ncGlvOiByZWd1bGF0b3ItcGNpZS1ncGlvIHsNCj4gDQo+IERyb3AgdGhlIGdw
aW8gc3VmZml4Lg0KW1JpY2hhcmQgWmh1XSBPa2F5LCB3b3VsZCBiZSBkcm9wcGVkLg0KDQo+IA0K
PiA+ICsJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiArCQlwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOw0KPiA+ICsJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llMF9yZWc+
Ow0KPiA+ICsJCXJlZ3VsYXRvci1uYW1lID0gIk1QQ0lFXzNWMyI7DQo+ID4gKwkJcmVndWxhdG9y
LW1pbi1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ID4gKwkJcmVndWxhdG9yLW1heC1taWNyb3Zv
bHQgPSA8MzMwMDAwMD47DQo+ID4gKwkJZ3BpbyA9IDwmZ3BpbzEgNSBHUElPX0FDVElWRV9ISUdI
PjsNCj4gPiArCQllbmFibGUtYWN0aXZlLWhpZ2g7DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiAgCXJl
Z191c2RoYzJfdm1tYzogcmVndWxhdG9yLXVzZGhjMiB7DQo+ID4gIAkJY29tcGF0aWJsZSA9ICJy
ZWd1bGF0b3ItZml4ZWQiOw0KPiA+ICAJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4g
QEAgLTI5Niw2ICszMTMsMjIgQEAgJnBjaWVfcGh5IHsNCj4gPiAgCXN0YXR1cyA9ICJva2F5IjsN
Cj4gPiAgfTsNCj4gPg0KPiA+ICsmcGNpZTAgew0KPiA+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IjsNCj4gPiArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llMD47DQo+ID4gKwlyZXNldC1n
cGlvID0gPCZncGlvNCAyMSBHUElPX0FDVElWRV9MT1c+Ow0KPiA+ICsJY2xvY2tzID0gPCZjbGsg
SU1YOE1NX0NMS19QQ0lFMV9ST09UPiwgPCZjbGsNCj4gSU1YOE1NX0NMS19QQ0lFMV9BVVg+LA0K
PiA+ICsJCSA8JmNsayBJTVg4TU1fQ0xLX0RVTU1ZPiwgPCZwY2llMF9yZWZjbGs+Ow0KPiANCj4g
VGhlIGkuTVg4TU0gUENJZSBkcml2ZXIgc2hvdWxkIG5vdCByZXF1ZXN0IHRoZSBwY2llX3BoeSBj
bG9jay4gUGxlYXNlIGFkZA0KPiBhIGNoYW5nZSBpbiB0aGUgZHJpdmVyLCBzbyB3ZSBkb24ndCBu
ZWVkIHRvIGhvb2sgdXAgYSB1c2VsZXNzIGR1bW15IGNsb2NrIHRvDQo+IHRoaXMgbm9kZS4NCltS
aWNoYXJkIFpodV0gT2theSwgdGhhbmtzLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiAN
Cj4gPiArCWNsb2NrLW5hbWVzID0gInBjaWUiLCAicGNpZV9hdXgiLCAicGNpZV9waHkiLCAicGNp
ZV9idXMiOw0KPiA+ICsJYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19QQ0lFMV9B
VVg+LA0KPiA+ICsJCQkgIDwmY2xrIElNWDhNTV9DTEtfUENJRTFfQ1RSTD47DQo+ID4gKwlhc3Np
Z25lZC1jbG9jay1yYXRlcyA9IDwxMDAwMDAwMD4sIDwyNTAwMDAwMDA+Ow0KPiA+ICsJYXNzaWdu
ZWQtY2xvY2stcGFyZW50cyA9IDwmY2xrIElNWDhNTV9TWVNfUExMMl81ME0+LA0KPiA+ICsJCQkJ
IDwmY2xrIElNWDhNTV9TWVNfUExMMl8yNTBNPjsNCj4gPiArCXZwY2llLXN1cHBseSA9IDwmcmVn
X3BjaWUwX2dwaW8+Ow0KPiA+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+ICsNCj4g
PiAgJnNhaTMgew0KPiA+ICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiAgCXBpbmN0
cmwtMCA9IDwmcGluY3RybF9zYWkzPjsNCj4gPiBAQCAtNDEzLDYgKzQ0NiwxOSBAQCBNWDhNTV9J
T01VWENfSTJDM19TREFfSTJDM19TREENCj4gCTB4NDAwMDAxYzMNCj4gPiAgCQk+Ow0KPiA+ICAJ
fTsNCj4gPg0KPiA+ICsJcGluY3RybF9wY2llMDogcGNpZTBncnAgew0KPiA+ICsJCWZzbCxwaW5z
ID0gPA0KPiA+ICsJCQlNWDhNTV9JT01VWENfSTJDNF9TQ0xfUENJRTFfQ0xLUkVRX0IgICAgMHg2
MQ0KPiA+ICsJCQlNWDhNTV9JT01VWENfU0FJMl9SWEZTX0dQSU80X0lPMjEgICAgICAgMHg0MQ0K
PiA+ICsJCT47DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiArCXBpbmN0cmxfcGNpZTBfcmVnOiBwY2ll
MHJlZ2dycCB7DQo+ID4gKwkJZnNsLHBpbnMgPSA8DQo+ID4gKwkJCU1YOE1NX0lPTVVYQ19HUElP
MV9JTzA1X0dQSU8xX0lPNSAgICAgICAweDQxDQo+ID4gKwkJPjsNCj4gPiArCX07DQo+ID4gKw0K
PiA+ICAJcGluY3RybF9wbWljOiBwbWljaXJxZ3JwIHsNCj4gPiAgCQlmc2wscGlucyA9IDwNCj4g
PiAgCQkJTVg4TU1fSU9NVVhDX0dQSU8xX0lPMDNfR1BJTzFfSU8zCQkweDE0MQ0KPiANCg0K
