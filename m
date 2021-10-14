Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4B42CFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhJNBWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:22:49 -0400
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:42208
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229736AbhJNBWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:22:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFQTM3oHn7CUjADH6m4GNJqA9pA3yNOMuUDTV/d/sdDmoTVQScOYm8iFOeOr1mkYtxLVBPczrsi2VDuajxfYMjVpkDaguvibcUJlYUwCSVHr1K9zlbU4WA27PuCow/LsT+ZGi/mbFmH7T/sVzPDRlWaZqykOuO7MOO9tz2kbNTA3cfrYRmdvrfwZDm2pV2aLSYTPfhjKrnU1hgN+HL80H463f/LdEHcIuK9aIQmUqr1LVcjCHXgCO/mPUDjWV3xMZEfeCIKTBt0YS/dKHj3kvDHrkxgL4X+5/znqzosWH8GfqNaIBTVM1IdwwBFxBVcsvkLsWiIqH/t7vo+OmiIVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IyEmfBIDgKlHJksyoDgZU5FF/dvmuU60xaSdw+6JWQ=;
 b=NQbtUKGG47S51es94z4jS4yIviW60wpHHwN2LYL4bfPyQnpMMLe30kSDZ3at12HjzLZQWAmUUuxrqDO5MyPxVfSXmZ7UiLcGTr7y440cus5xVWDRlg4IcssvxXKpcXfH19EvqleJlZ6G8KGqQFBJEhAqX667MABGw5QCkCguQUHkqVFdTrwnRr8zwvmpyoczk7oE5iz/eEWle9m26tsmKOoLg8eXXx52sGcfEF3197R1Rq2O1cG3k6+z/gXvePaFJPxYR928EkEMd+AUkADWQGu89VEsBx5kG7fk9+zGIG+8dezOCO4c/ND3oIlIcAtDU1VwbdvJ+/SoeATKZwn8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IyEmfBIDgKlHJksyoDgZU5FF/dvmuU60xaSdw+6JWQ=;
 b=YTlnqnJV7PqyIU38ggOjL63bpBHDwDYbw3Xj/sKd7dtU91PYMttgOwKUs0A9wdkpCcqpHJDr2sqeSqJ7YjgGTpALeKpfbU+RKhkXM1JOl1H7Ta2ZRYYPa1Acc7E7ecMwmeRcgdy8pT20GqJ+cQtCbEBHVqDb3D4DrW+bJKBFINc=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Thu, 14 Oct
 2021 01:20:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::551d:cc86:4d67:587]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::551d:cc86:4d67:587%3]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 01:20:41 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [PATCH v3 9/9] PCI: imx: add the imx8mm pcie support
Thread-Topic: [PATCH v3 9/9] PCI: imx: add the imx8mm pcie support
Thread-Index: AQHXv0hvnaQTVIrSFUO/5iyHoeCmE6vQ4e8AgADSmbA=
Date:   Thu, 14 Oct 2021 01:20:41 +0000
Message-ID: <AS8PR04MB8676F18EF63A0C014047FC4F8CB89@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
         <1634028078-2387-10-git-send-email-hongxing.zhu@nxp.com>
 <00afb7b8bc6f7ad41cd6770532294992a667f1af.camel@ew.tq-group.com>
In-Reply-To: <00afb7b8bc6f7ad41cd6770532294992a667f1af.camel@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ew.tq-group.com; dkim=none (message not signed)
 header.d=none;ew.tq-group.com; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38f20ad4-4459-4cf5-739c-08d98eb0d6cc
x-ms-traffictypediagnostic: AS8PR04MB8916:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB8916BAE46B559AD44304B4768CB89@AS8PR04MB8916.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZV21tFxKhr5e5g/pXT+NcEITRLnA3ZyzJ1PTrfGga1j30CsWfC7UFkw+Qe6u0Jqor6quJIQVCQJC4ClRuLhihkhsPkHwcuwhalabkIfRnsVI97fZ/ndzn+4NGnXOEA/EPf81MnXiaCytPt14VUXBK2gxDBbrDbU3TGVvZ7OzTARrjjU/3gPCANRl87Rtz+jao00n1JGBSEVFljukQyViRVQLeamBNWPvS3dWHPwvbc4a2+6ZO8P+VX93VUm5WV0EdaP9Sl42jXXOArKz9Y+EzIrLk4L5Q7hY6dpALPJo9uLhbXesmvqmyANYa+azK5+2Ow+L/Aj2/I0bZ+4Tow8Z/gpgvW1kgsYcf/F0jDUZhn+egW3gadKoAEJMhtC7QU4CJApq1gjfiMekZWV4WurFp8ChSoCz2CgeqInR3Hdd0MWfEhL8CSEWxIU81l6/1F4KWeWPka/T64PmY1Pj0zVSs8r7rBd071N6SnM5Fz8LHmgHVpBBnt9j9qGt0T3L5yanbBP/WCDqrfUKcKzkna/VfyVy1QEIdKa+OIukhIvo+CJ2r5Ty9BWZGO3GSv+BRJ6uBl5zOc6TjuB21SGDCMhK1/y6LQ4EvaZKoYl0r7bNb2sqT9LWRXMAx4wvMgekg15T/wcA/kN1S+Bp7Q+dbDyDCVTudCb9vs6gwuT52OfrzmQ8IAsPC+9bxQdY2j8dA57EVnZXkQZQyQPbSOOkQp1nY6uqC7Hir2oMDZkyzEZA64=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(33656002)(38070700005)(66476007)(4001150100001)(5660300002)(66556008)(71200400001)(508600001)(122000001)(64756008)(54906003)(9686003)(38100700002)(316002)(186003)(7696005)(8676002)(76116006)(2906002)(4326008)(52536014)(6916009)(86362001)(55016002)(83380400001)(53546011)(6506007)(66946007)(66446008)(26005)(7416002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHNGREtTOFRYM1lsWU1BRmJxVVZJUVhiN0pWRHhFY01Td0pQVnp6TVBrNHZM?=
 =?utf-8?B?R041K0R5ZzZQUE8vSVFvYnJpQVA5bmo5ODc0b21LODl1YUczMUg1dVJpVE1R?=
 =?utf-8?B?Mk40OUZsTlZGc0JaMzRHRGxmZ0JRTGg3UkpKN3E4aGxSYjF2Zk5JTklQelgx?=
 =?utf-8?B?Sys2QTI3Vm9sTmVxbFg1dzRJeUxWR3hQSzlmRWVCeCtSYkVyeHhFZ0ZoVGJD?=
 =?utf-8?B?emE3ZXIyRmxjc2Q2UFQwdDVNWlZYOGVvakRTbEVZWU9jaG5jRERmNHpPbXBV?=
 =?utf-8?B?dHI0bkxwOHBBZC82cmowYm5ITjVQaFhhMzY3dFJYNmFaa3JSeU1HRGdGZ3Rm?=
 =?utf-8?B?cHFxdlArN0pmUmRCZEtudlF4U25CaTdIT3lzay9IakJlOCtGTE52MlVMYi9w?=
 =?utf-8?B?emQvWXdhWXN6Yjk3VGxIQzJpZ0VaR2hpV1JNK3RMakJWUXoxV01JeXFPQk1G?=
 =?utf-8?B?M2crZHdYa1RkTmEvVXNSaVZabDVFbEdDYU5WWnNZck9YbnlPdHJKeWJXNFli?=
 =?utf-8?B?SEd5MGs1UzlHV0ZPak9vb1JNK0NMRXpjRUk1S3NHZFFyRUJHdWhocmZKd0JM?=
 =?utf-8?B?QkVaMzBiaWk4amxwa0JlUm9GWDVGdTRZZXc4WHZVVjVRdUhYbDU0bWtOcWZH?=
 =?utf-8?B?ZHo3c2lBT3hlb2JrT3B4RytBNno3d2FZU0ZzNmZkNGNBMmpCSmQvUm9Lanpa?=
 =?utf-8?B?b0NXTlZqTXA5MHBQenJJbjZMeThCcXdnR3pXekZQYllJTHNmcVJZQXF0VENm?=
 =?utf-8?B?NVh0R1dHak5NSzdKKzVEOVM4MnZhNm1XUzYvY3lNNWJWeXZQbUlDQTlXa3Rr?=
 =?utf-8?B?KzhTWjZJRzVzS2RYNHREQmQ3WVhLMmVaNSt4TDBuckR1aTJVbEVUdEg4SEFZ?=
 =?utf-8?B?MmFucFcrU1JjaDN1R1hTdHVPTjFVRUFPT3JXVktkVnIyU3VqV1dYNU9uVUZE?=
 =?utf-8?B?RmZNRXZzTll5ZktoOXNFdXp2VldKVjRYOU8rWHQ5UEh5SDdFUXZ2YzljVkdI?=
 =?utf-8?B?bGlBZkxVUVdLbGtHbWZKeFNMWVBwVzRkTWtvU0JVMXRFL29zLzg2MTNiYzZC?=
 =?utf-8?B?T1VDb3BwR0NVamUrUVZKSWpybUh5VVZRZkVZSENxdEJqcElKWU9hV1FKZGho?=
 =?utf-8?B?N0xSd3lMNVNCVktkdng4VFAvU3UzMGdEV2M3RndaVG15U2RzbmZPZURMU0Nr?=
 =?utf-8?B?aFJXUWZBdk5LZ0N2dC9RYVVXZjlxSlVEYzlpcFhhcmE1NGR4R0VEY1VBZDlD?=
 =?utf-8?B?bTVTc1dzby9jdzdFeExzV2V3MVlRWURicTRGVWVIdTZ2dVdSNmYvbjJnMGx3?=
 =?utf-8?B?M21NdHpEL3FlNm42YWxubVNXeDhIMTR5M0ZtTHZ6VjhpYWpkeFlvUUFnT3ZQ?=
 =?utf-8?B?cGFlNmd5SlphZmx5cmdTSWFnRE4yYlRVTnlmL0U3UDliS1BYQWNVY2tUc3dz?=
 =?utf-8?B?UnZxVlpsb0kraHNJV0w4RGpqS0pVVC9nWUI4VnU0UUtMbGFFdUszUTgyME4w?=
 =?utf-8?B?MUZ6TC9uN2toZVErOHYweEhIMDBQdDBiRGdFYVlWL2VZc2ZUZDUwbjZQZW4v?=
 =?utf-8?B?UjVFNWVvZFRNY3N2dzlEQ0pQTnlEOXoyOUNaZElzZGZ2M2tJcFQzeXVJVTdV?=
 =?utf-8?B?dFNWNVdSeXpGaWxBOFhtYnZnVk5LUkVYYjZsS0hlNXYxejZUb3N0RHRLdHZ0?=
 =?utf-8?B?amFvVlpmdlpEaTFsWWovMEdWK01RcHd5NUxVcGdvUXFCczBrUzFzZldwNFpZ?=
 =?utf-8?Q?PzYs8lSOrtlPnWdRNOaq87QV1LY2NvQF0ZsM08O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f20ad4-4459-4cf5-739c-08d98eb0d6cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 01:20:41.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wdmthcj5t7ZN1m381TL2UF+1a57J+RA7KhWMMJt4XQIS0+63S186HUQTl+7Jjy/uDsClrnJtdbniws7I0F3naQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hdHRoaWFzIFNjaGlmZmVy
IDxtYXR0aGlhcy5zY2hpZmZlckBldy50cS1ncm91cC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
T2N0b2JlciAxMywgMjAyMSA4OjQ2IFBNDQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1
QG54cC5jb20+DQo+IENjOiBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRl
OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4gbC5zdGFjaEBwZW5ndXRyb25p
eC5kZTsgdGhhcnZleUBnYXRld29ya3MuY29tOyBraXNob25AdGkuY29tOw0KPiB2a291bEBrZXJu
ZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7DQo+IHNo
YXduZ3VvQGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA5LzldIFBDSTogaW14
OiBhZGQgdGhlIGlteDhtbSBwY2llIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgMjAyMS0xMC0xMiBh
dCAxNjo0MSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gaS5NWDhNTSBQQ0llIHdvcmtz
IG1vc3RseSBsaWtlIHRoZSBpLk1YOE1RIG9uZSwgYnV0IGhhcyBhIGRpZmZlcmVudA0KPiA+IFBI
WSBhbmQgYWxsb3dzIHRvIG91dHB1dCB0aGUgaW50ZXJuYWwgUEhZIHJlZmVyZW5jZSBjbG9jayB2
aWEgdGhlIHJlZmNsaw0KPiBwYWQuDQo+ID4gQWRkIHRoZSBpLk1YOE1NIFBDSWUgc3VwcG9ydCBi
YXNlZCBvbiB0aGUgc3RhbmRhbG9uZSBQSFkgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IFsuLi5d
DQo+ID4gQEAgLTExMzAsNiArMTE3NiwxNCBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShz
dHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCQkJICZpbXg2X3BjaWUtPnR4
X3N3aW5nX2xvdykpDQo+ID4gIAkJaW14Nl9wY2llLT50eF9zd2luZ19sb3cgPSAxMjc7DQo+ID4N
Cj4gPiArCS8qIGdldCBQSFkgcmVmY2xrIHBhZCBtb2RlIGlmIHRoZXJlIGlzIFBIWSBub2RlICov
DQo+ID4gKwlwaHlfbm9kZSA9IG9mX3BhcnNlX3BoYW5kbGUobm9kZSwgInBoeXMiLCAwKTsNCj4g
PiArCWlmIChwaHlfbm9kZSkgew0KPiA+ICsJCW9mX3Byb3BlcnR5X3JlYWRfdTMyKHBoeV9ub2Rl
LCAiZnNsLHJlZmNsay1wYWQtbW9kZSIsDQo+ID4gKwkJCQkgICAgICZpbXg2X3BjaWUtPnJlZmNs
a19wYWRfbW9kZSk7DQo+IA0KPiBJdCBzZWVtcyB0byBtZSB0aGF0IHRoZSByZWZjbGtfcGFkX21v
ZGUgaXMgbm90IGFjdHVhbGx5IHVzZWQgYnkgdGhpcyBkcml2ZXINCj4gYW55bW9yZSwgYmVjYXVz
ZSBpdCBpcyBoYW5kbGVkIGJ5IHRoZSBQSFkgZHJpdmVyIG5vdy4gSXMgdGhlcmUgYSByZWFzb24g
dG8NCj4gcmVhZCB0aGlzIHByb3BlcnR5IGhlcmUgYXQgYWxsPw0KPg0KW1JpY2hhcmQgWmh1XSBH
b29kIGNhdWdodC4gSSBmb3Jnb3QgdG8gY2xlYW4gdXAgdGhlIHJlZmNsa19wYWRfbW9kZSBpbiBj
b250cm9sbGVyIGRyaXZlci4NCldvdWxkIHJlbW92ZSB0aGVzZSBjb2RlcyBsYXRlci4gVGhhbmtz
IGEgbG90Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQogDQoNCg==
