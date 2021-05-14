Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17A380C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhENO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:58:40 -0400
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:7652
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230484AbhENO6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:58:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3OvmEJyj8h7jUCgnrq51Fc4mSiNIlS77zHH5nfU+08a1Jmlh/F3y8Zw3wbkKlXFsUN/+JjX2kUzWyHIp3rXIHb800k/gYh8JW92iRnomPVLa+BVvcovJc6XLIBq78kv0j9ISlzNKBwMkEpOUL2ki0iqQF3K8WDf44eqpDN7fy2v9/WQe8RK4XWQU000jFHWVgCYMMM1ub/WUTJWDmX+ftD5QSdk362EoKNE9H6TNnCNH/F9gWLG1Wu1vqKFhcUh0n0Z7+XHQhexTj6aLxT7LPdIm0sIqL2oZgMXrS/KreE2geuXYaifvH0ZvoO0ktBXtDPc4H2l7UBfHV3fW6mCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85EbY+MRf/ys2Z1Vh3n5q3mh8vhCVgf6459Zo1NbUjU=;
 b=I5d9TZkLaQDnE6gPjtay+ZqxBoEOzhfXox1ZPj2WQq1k1cQHmC9neLNbTU5akn11bfKFeFuhQ4VTJP0UDYS1PTQg5N/7p8Tfqo6b+d+aEBtXC7bpOfLiRxV9erjqE/HXzn1xcJYWBpF2DNt2azOFWilneVrTv7ABGbluQZClDWkT4bEcVPhwohwrQHuhhigUzirv1OYE+Wvwzj4cqo8tlqjpSR/1PwxbFrOciQit8EvTBujm2To5YnvsY/XEvkFe0+2/pRR9ZXH8d5Xlwl1v/A4UCTD3jEri9LKABZOdoUwDRzLZRz+hW4hHLY0Z8KxchqDeKEC2GKnl6ol1O4p0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85EbY+MRf/ys2Z1Vh3n5q3mh8vhCVgf6459Zo1NbUjU=;
 b=h9xlymgr4W5X8dHCD7pPBBiynx4/Ka91iUak2Dq7HDzieCvYgi5iU5+x02AmyvMaIvoxUi7+vDyRZPL9LmmkWPm4EpVIx9MOqmNE6G9/XtmOjP3lnkwQRko230TdzIW0+UjMi3IkBacUwlrYre6PF1AJqDuSwedqRwyBhBDvKnc=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 14:57:24 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::bcfe:215c:1b66:6011]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::bcfe:215c:1b66:6011%4]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 14:57:24 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Adam Ford <aford173@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
Thread-Index: AQHXKoTrm+1dEO4gCEi87d5cyZOFDqrdyocAgACF5YCAABIPoIAAMe4AgASmRGA=
Date:   Fri, 14 May 2021 14:57:24 +0000
Message-ID: <VE1PR04MB668860A19062925162C40F3C89509@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <20210406013344.124255-1-aford173@gmail.com>
 <20210511024604.GE3425@dragon>
 <CAHCN7xLFpL=9BF9M5gUA6sMhc2ZZMNz+GP0OLmLfpJAWdD7W-w@mail.gmail.com>
 <VE1PR04MB6688CD4AA4826EEEBBA2651689539@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <CAHCN7xJ5Hq6bRpEgE8Pi9VbQ_Kejy-sgKQsJ93pQEG3U_Wsu=Q@mail.gmail.com>
In-Reply-To: <CAHCN7xJ5Hq6bRpEgE8Pi9VbQ_Kejy-sgKQsJ93pQEG3U_Wsu=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.233.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61e158f9-06da-4464-c65c-08d916e8956b
x-ms-traffictypediagnostic: VI1PR04MB7022:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB7022FF5C35B6EA294A8BB44589509@VI1PR04MB7022.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SQ0bgI0P4+GMbj30d2LYoWLZO6oWuDETAblQtGts1YufZNarQNAucrkKP2SOPd94i/aRW30K+/Ci5Fqvk1YtcxoOxvhbeVe30P+SVxpgmtisLkILOptptRx86GxINqb53SKWy/59/HMA/UDy38bYaIb9+KO/sA2Y2w6SE0qIvyEddTUqRA7l3Ge2wY4XJjMV6JHqIliFNm9S2aTm+T4wCUqFftU+0vEmeS7/BmoefbegFMhzScGHNPqKVa08jZoBXj3boWlxv2s29/u/t2MNr3Aqy8x+3MkDj0ghULRSv6wUhYPdNAoEbhe+RbPqU96BrYhopLEj0UqDkSxe4KZegD1XOjF5ayJnoTfw6xUBqSIDv50zq9Opc9IQ9M0umZRq2yusJ+4dBOWqVxO8ZTDp0fDdWEPEHzoTNSD96cFgSsrFjEzcOEgK+3ERvA03L3OSP6yFM7nocx4wJNc7vN8Jiy/JZDSXgva0fEU+kXWUvjAdB9o8r8aJFGk+uU39qXW75D5BQOfFRWkk0YTfVeU531cAiXPd8LBBVt09xvb3ofmo2MxfAs9KDuxorDpQG8/R37ANhpkGlR/WH7OseV3ENBzouBeZoF41XffMecRALXP5BFtVXsDnrfwK0ptlui/T4pyAqNr++qnQPFWPJxPe9DNd2vCXojFZeYgaJHRqvgOtSxMY0AXctgphwJFt+hqKNJo9JQRQTg5QWIOoNqXC9Y1hCkJijdHH3I2Pp/kcFyQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39850400004)(396003)(55016002)(54906003)(76116006)(4326008)(5660300002)(9686003)(71200400001)(316002)(6916009)(83380400001)(52536014)(8936002)(66446008)(64756008)(38100700002)(6506007)(53546011)(122000001)(8676002)(966005)(2906002)(478600001)(66556008)(66476007)(186003)(26005)(86362001)(66946007)(33656002)(7696005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SnhyRWQ5TCsxZS9MNHl4OGpnQmMxUmE0STFXNlBsTzNoT1Y1UXFxNFFERzhq?=
 =?utf-8?B?QVkzR2dNMnZ1LzhPL1BCNmlNc3l2M01MclQyenFSN1IwWEs2NzB2bFpSUjNW?=
 =?utf-8?B?VWQzRVkwSGxzMGxIV29IRUMvTmZmM2JlRFV4WFFQOTI1M1hRWTNVb3c1SUo1?=
 =?utf-8?B?SUdweW5sSVROTkd2aUtvVU04ME9kQTVHVzJhanBtWmRYSWFHS0VkRXVlbFZa?=
 =?utf-8?B?OTQvVlZMTFU1eUZQRE1Qc1hBemFuODlKQU9aakI3SEJpVUJPekNSSUZGWFJx?=
 =?utf-8?B?SlAyVFFDUCtRQU9wV24rMSszL3JEUzVmRHJrTDhWajVhaFRUcjZUSGUyZ3hj?=
 =?utf-8?B?Vy9qWjNvQjJud3RzdUNwSmJ3T2Nvdm5WTXlNS1JxQkIxWC9RdVR1Tm1iVnpn?=
 =?utf-8?B?eTFCUmdic1czejlJWHJmbzBoVTZoODVVTGVwRlNMSXd4d0o5TGVUYTJwZDlt?=
 =?utf-8?B?TUI5UllFVDFneENPaDUzT21BY0haQ2pGQy9LN3NoaFA3MUkyZWRJMEJWeWV2?=
 =?utf-8?B?UllGbHRmZGloZU00TmdzN2VWd21MSTZUVnZNSTNoYzJlOHdxV296K0ZsMDFh?=
 =?utf-8?B?dWt0VVY1UWNFSjA3U2V6UmFya0lNUXB6ZGxiUGtmVmlRUXVKQWJ2LytaVTZq?=
 =?utf-8?B?b0psakdvaFdueVNTTkcycTBIN0FNZUNlL2FUTDZJOGxHNFNwMUdjYVkvS1RP?=
 =?utf-8?B?S05SUms1dzBVTDQrcERYbHBMd1RvTFBWdWZTVUYvTXh1aXR1RDI1bVcxeWty?=
 =?utf-8?B?Y0pzVlJBSlNScFhVYmpic2hzWFk2eXB0U2dVM085U0RhQ3Z1N2p0OFFDeUNt?=
 =?utf-8?B?ZU1sRWRpU2h3WnBMaUplaGd3b0xYR0FwZFo2ZllqTlhycHJ5NFdIMWo3Vm05?=
 =?utf-8?B?dWNjZllsdjlNRjlTTUt1U21JSkFsYXJhbnJ2b1gzdnZSelIza1lZSU1tVEtj?=
 =?utf-8?B?d3ZhUHdwbFVpN2xxZndNZzdmYnB4OTZBWFFyeGFva2duU0VUVEpMcDVJQlJv?=
 =?utf-8?B?cFBtbHo4SDRXNS9iTHZqTEdhNkVtK0ttMTdnMVhLU3BEQ1JCektZdGErOHJD?=
 =?utf-8?B?V0JjZzQ0eVBZV0d1a3lOTUViSWYvU3VObmFMY0hySU5HNk5SSUp3cVVrNHBr?=
 =?utf-8?B?REtoOExTdkNFUEsyOE4vb1VXdHZhcXNCZi9CR3ZFV0pCYks0WHdWV285TG9J?=
 =?utf-8?B?RURJdW1CYTB2djc0MklUcGRWT3NNTlVvRHlXRnRxTm5hcytHU2Y5NGt4aXVC?=
 =?utf-8?B?NWo1cnJvMU1YLzl1VDdvbDdEQXZRNEtrZnFHUEM2N2dJMnVHWmhmeWJBbjJ0?=
 =?utf-8?B?Zk95TGtJcEFBS2Z4N3JWS3hZbHI4cU83SVd5UFRZbzNqU3RUb3FsV1dxei9j?=
 =?utf-8?B?eXVhZHRacjdVNXpDZU9KcHE1eEpvcXY1Ykl1ZjRUa0JISTZ1UzJtVm9nd043?=
 =?utf-8?B?ZTZKV0h6Y0d0NDhxYnRyZ3N2V01FM3YxbEVZU2ZBcDlST3VsNkZFRmFLNXRr?=
 =?utf-8?B?b1FPTHF4bFkwNTFNR0VyVTRDVGpXUDZYV0hicTJVeWlBaVdBM2k5WUZQM3NQ?=
 =?utf-8?B?b2NKWmE5cVZBMWMxZkZTTXlBVVFVcTZzN1lZczBYdXBnenhQWVUzbXZXTGtR?=
 =?utf-8?B?USt3UHhxUVprVGxZK1VMVU5GcDdrM3BhU2Z2ajRWZWQwWlFUdjEvSXpxR3I4?=
 =?utf-8?B?U3JiQ09VYklHVHBKd0RRR1NnQi9wOFZVYTJleHZiM3pjdjdRbG1WODJxM3ZV?=
 =?utf-8?Q?YayhSxxttU+3BCJql3Q/Hbn3poZDFOujeZ7jzmc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e158f9-06da-4464-c65c-08d916e8956b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 14:57:24.3408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRLC73OIzyMiHxvfS0wbDsip9GEdsOLrcoJ6PwrOTi2IYcKPShf56tNnbco9NqEz5gQa66k4Rahr+1oXx2rvOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xMS8yMSAyMjo0OSBBZGFtIEZvcmQgPGFmb3JkMTczQGdtYWlsLmNvbT4gd3JvdGU6DQoN
Cj4gPiBDb21wYXJlIFBJTyB3aXRoIERNQSBvbiBVQVJULCBidXQgbm90IHcvbyB0aGlzICAnc3Bi
YSBidXMgbm9kZSAnIHBhdGNoPw0KPiA+DQo+ID4gPiBJbiBmYWN0LCBpZiB0aGUgRE1BIGZpcm13
YXJlIGlzbid0IGxvYWRlZCwgSSBvZnRlbiBnZXQgdHJhbnNmZXIgZXJyb3JzLg0KPiA+IFVBUlQg
dXNlIFNETUEgUk9NIGZpcm13YXJlIGluc3RlYWQgb2YgUkFNIGZpcm13YXJlLCBzbyBpdCBzaG91
bGQgd29yaw0KPiA+IGV2ZW4gd2l0aG91dCBzZG1hIFJBTSBmaXJtd2FyZSBsb2FkZWQuICBTdGls
bCBjdXJpb3VzIHdoYXQgcmVhbGx5DQo+ID4gaGFwcGVuIGluIHlvdXIgYm9hcmQgd2l0aG91dCB0
aGlzIHBhdGNoLg0KPiANCj4gV2hhdCBJIGFtIHNlZWluZyBpcyB0aGF0IGF0IHRpbWVzLCB0aGUg
SENJIFVBUlQgbG9hZGluZyBiZWZvcmUgdGhlIERNQQ0KPiBmaXJtd2FyZSBpcyBsb2FkZWQuDQo+
IA0KPiBbICAgMTAuNTgyMDM3XSBCbHVldG9vdGg6IEhDSSBVQVJUIGRyaXZlciB2ZXIgMi4zDQo+
IFsgICAxMC41ODY4NjddIEJsdWV0b290aDogSENJIFVBUlQgcHJvdG9jb2wgSDQgcmVnaXN0ZXJl
ZA0KPiBbICAgMTAuNTkzNTY2XSBpbXgtc2RtYSAzMGJkMDAwMC5kbWEtY29udHJvbGxlcjogc2Rt
YSBmaXJtd2FyZSBub3QNCj4gcmVhZHkhDQpTZWVtcyB5b3UgYXBwbHkgbXkgcGF0Y2ggc2V0ICcg
YWRkIGVjc3BpIEVSUjAwOTE2NSBmb3IgaS5teDYvNyBzb2MgZmFtaWx5Jw0KaHR0cHM6Ly93d3cu
c3Bpbmljcy5uZXQvbGlzdHMvbGludXgtc3BpL21zZzI2NzI4Lmh0bWwgDQp3aGVyZSAnc2RtYSBm
aXJtd2FyZSBub3QgcmVhZHknIGFkZGVkPw0KDQo+IFsgICAxMC41OTQ1NDhdIEJsdWV0b290aDog
SENJIFVBUlQgcHJvdG9jb2wgQnJvYWRjb20gcmVnaXN0ZXJlZA0KPiBbICAgMTAuNjAwMTA4XSBp
bXgtdWFydCAzMDg2MDAwMC5zZXJpYWw6IFdlIGNhbm5vdCBwcmVwYXJlIGZvciB0aGUgUlggc2xh
dmUNCj4gZG1hIQ0KV2h5IG5vdCB1c2UgUk9NIHNjcmlwdCBmb3IgVUFSVCBhcyBtYWlsaW5lIGxp
bnV4LW5leHQgZGlkIChldmVuIHRoZSBhYm92ZSBwYXRjaCBzZXQpPw0KSWYgc28sIEkgZG9uJ3Qg
dGhpbmsgeW91IGNvdWxkIHN1Y2ggaXNzdWUgb24geW91ciBib2FyZC4gV2hhdCBzY3JpcHQocGVy
aXBoZXJhbCB0eXBlcykgeW91DQpzZXQgaW4gdWFydCBkdHMgc3VjaCBhcyBiZWxvdyBpcyA0LS0g
TUNVIGRvbWFpbiBVQVJULT4gSU1YX0RNQVRZUEVfVUFSVC0+YXBwXzJfbWN1Og0KIA0KZG1hcyA9
IDwmc2RtYTEgMjIgNCAwPiwgPCZzZG1hMSAyMyA0IDA+Ow0KDQo+IA0KPiBXaGVuIEkgZ2V0IHRo
ZSBhYm92ZSBtZXNzYWdlLCB0aGUgYmx1ZXRvb3RoIGNoaXAgSSBoYXZlIHRocm93cyB0aW1lb3V0
cyBhbmQNCj4gZG9lcyBub3QgZnVuY3Rpb24uDQo+IA0KPiBbICAgMTAuNjE1MDkwXSBpbXgtc2Rt
YSAzMDJjMDAwMC5kbWEtY29udHJvbGxlcjogbG9hZGVkIGZpcm13YXJlIDQuNQ0KPiANCj4gT25j
ZSB0aGUgZmlybXdhcmUgaXMgbG9hZGVkLCBJIGNhbiB1bmxvYWQgdGhlIEhDSSBVYXJ0IGRyaXZl
ciBhbmQgcmUtbG9hZA0KPiBCbHVldG9vdGggd29ya3MgYWdhaW4uDQo+IA0KPiBCYXNlZCBvbiB0
aGF0LCBJJ3ZlIGJlZW4gaGF2aW5nIG15IHN5c3RlbSBkZWxheSB0aGUgbG9hZGluZyBvZiB0aGUg
Qmx1ZXRvb3RoDQo+IG1vZHVsZXMgdW50aWwgYWZ0ZXIgdGhlIGZpcm13YXJlIGlzIGxvYWRlZCwg
YnV0IHRoaXMgdGVsbHMgbWUgdGhlcmUgaXMgYQ0KPiByZWxhdGlvbnNoaXAgYmV0d2VlbiB0aGUg
RE1BIGFuZCBVQVJULiANCklmIHlvdSB1c2UgcmFtIHNjcmlwdCwgb2YgY291cnNlIHlvdSBzaG91
bGQgdXNlIGl0IGFmdGVyIGZpcm13YXJlIGxvYWRlZC4gQWN0dWFsbHkgDQpTcGJhIGJ1cyBpbiBk
dHMgaXMgb25seSB1c2VkIGZvciBwZXJfMl9wZXIgc2NyaXB0IGp1ZGdpbmcgaWYgdGhlIHBlcmlw
aGVyYWwgYWRkcmVzcw0KY291bGQgYmUgYWNjZXNzZWQgZGlyZWN0bHkgYnkgU0RNQSBvdmVyIFNQ
QkEsIGlmIHllcywgc2V0IFNETUFfV0FURVJNQVJLX0xFVkVMX1NQDQp0byBsZXQgcGVyXzJfcGVy
IHNjcmlwdCBhY2Nlc3MgcGVyaXBoZXJhbCBvdmVyIFNQQkEsIG90aGVyd2lzZSwgYWNjZXNzIHBl
cmlwaGVyYWwgYnkNCkFJUFMgaW5zdGVhZCBsaWtlIEFSTSBzaWRlIGRpZC4gUGxlYXNlIGNoZWNr
IHdpdGggYmVsb3cgY29tbWl0IGZvciBtb3JlLg0KQmVzaWRlcywgcGVyXzJfcGVyIHNjcmlwdCBp
cyB1c2VkIGZvciBhdWRpbyBkYXRhIHNhbXBsZSByYXRlIGNvbnZlcnQgYmV0d2VlbiBBU1JDIGFu
ZA0KdmFyaW91cyBhdWRpbyBpbnB1dC4gU28gYXVkaW8gcGVyaXBoZXJhbHMgaW5jbHVkZSBBU1JD
IHNob3VsZCBiZSBpbiByZWdpc3RlciBzY29wZSBvZiANCidzcGJhLWJ1cycgLiBCdXQgd2l0aCB5
b3VyIHBhdGNoLCB0aGVyZSBhcmUgdHdvICdzcGJhLWJ1cycgZGV2aWNlIG5vZGUgaW4gZHRzLCBz
byB0aGUgZmlyc3QNClNwYmEtYnVzIHNob3VsZCBjb250YWluIGF1ZGlvIHBlcmlwaGVyYWwsIG90
aGVyd2lzZSwgJ29mX2ZpbmRfY29tcGF0aWJsZV9ub2RlDQooTlVMTCwgTlVMTCwgImZzbCxzcGJh
LWJ1cyIpJyBtYXkgZmluZCB0aGUgd3Jvbmcgb25lIHNvIHRoYXQgU0RNQV9XQVRFUk1BUktfTEVW
RUxfU1ANCk5ldmVyIGJlIHNldC4NCg0KQlRXLCBkbyB5b3UgbWVhbiB0aGUgYWJvdmUgZmlybXdh
cmUgbG9hZCBpc3N1ZSB5b3UgbWV0IGlzIGdvbmUgaWYgdGhpcyBwYXRjaCBhcHBsaWVkPw0KSWYg
eWVzLCB0aGF0IHJlYWxseSBzdXJwcmlzZWQgbWUuLi4NCg0KY29tbWl0IDgzOTFlY2Y0NjVlYzVj
OGNjZWY1NDcyNjdkZjZkNDBiZWI4OTk5YTQNCkF1dGhvcjogU2hlbmdqaXUgV2FuZyA8c2hlbmdq
aXUud2FuZ0BmcmVlc2NhbGUuY29tPg0KRGF0ZTogICBGcmkgSnVsIDEwIDE3OjA4OjE2IDIwMTUg
KzA4MDANCg0KICAgIGRtYWVuZ2luZTogaW14LXNkbWE6IEFkZCBkZXZpY2UgdG8gZGV2aWNlIHN1
cHBvcnQNCg0KDQoNCg0KDQo=
