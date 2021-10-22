Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049A0436FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhJVCBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:01:15 -0400
Received: from mail-db8eur05on2064.outbound.protection.outlook.com ([40.107.20.64]:5184
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230190AbhJVCBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:01:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mICYSQ05gAF/l1pmXng2AbX9f5UbaLy2CMD5ASzPheS1d7FJWfXSaNKNUu58S7xJSUCZcp7AA/NYR5J/qeK/64pkPby/eVkgk1csSb1Q2nDoTRSUOHRUlmQTzlCNBxJD1C6dEIYISwzu0iu6Oh74QVgytiCWdLd3jQ0b9/7kSxrZWj5eKsSk4m+f31LG9YOsMyaByEPTreMsL8hka5vuG/3Ofh11BNmakPxOl3hiNCWD2AlZI+kOMuQbUcTXTIQee7rjq6v8YAfOAL4qNcHfPIq9HN3Scld5416yjHO6+unRHhABu4RjqH8K2TN60LsjExYJ4xzwaHPbBbYBH/WjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH7QLg+ZVpj8phawNIzQCr6HGHhMDpZEwtSblVckCqg=;
 b=IPw6rHGeOb6o1HbAGL3euE5vKCMlRsFsaWrfTrS1JJbJXF3ADhUDKkIVlPBHXNgGvlpqpZ1V30kaYUB3zLJwjNnhQDBjvvVSHwPR6OnQ65x853bolvVLHjR4PSM2yDvehkoC1ScCQ2i8K9OvmGXV3l3cslKGtXLLMIm8iGlp7tZve+KeonX2hmTRu3cdMbT1bSrAFe8FwexK8s0NuFrmtx+zx3lG8+ZHnhCdBzRJ1QkfulLmMAkOecp54k914McQ4LnSuMyPa+7wd0apoI7RIIVwxUvOVQIO7mQXWUTlc3KRknuqH2pR03k3WFlNei9puKelTD1DV1Fxu7llqopelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH7QLg+ZVpj8phawNIzQCr6HGHhMDpZEwtSblVckCqg=;
 b=YMSAw/EyK84ejDDHjxLYnFv2+LWwAkRKFgH8tcEDXV/tHX/LSoOf31xDOAi13QhnQ04MCA8WDlXCzGqPGNz1Q23T5b/VMa06Od7y5/qiOvM6NhfkWsk8dyCNxgI5QKugNkpYIhq332MBFzNMqrrYE/hTBPic7RwCzxSIuqoPG1g=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 01:58:53 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 01:58:53 +0000
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
Subject: RE: [PATCH v3 4/9] arm64: dts: imx8mm-evk: add the pcie phy support
Thread-Topic: [PATCH v3 4/9] arm64: dts: imx8mm-evk: add the pcie phy support
Thread-Index: AQHXv0hn2z8u2DOLk0err/FG2U4BpKvUZ3qAgAnqYDA=
Date:   Fri, 22 Oct 2021 01:58:53 +0000
Message-ID: <AS8PR04MB8676484A6968CDDCF3422C6A8C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
         <1634028078-2387-5-git-send-email-hongxing.zhu@nxp.com>
 <ca1e71abe4c87ae2be6e3a3fa92ac79a6da4b6c4.camel@pengutronix.de>
In-Reply-To: <ca1e71abe4c87ae2be6e3a3fa92ac79a6da4b6c4.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44de1bdb-94fb-42c8-bfa7-08d994ff801b
x-ms-traffictypediagnostic: AS8PR04MB8820:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB88202A94B0879A12827C32488C809@AS8PR04MB8820.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fw3UFshJzot9x/9KrTzKHTIgDNaKADm8lXaF0aywMqZ2McMAHzs5rOBUugbrlrryqnMHRJLrrH/MEOkhFWuGixPtWNSrxLfvqAMllNT934svqYA06S3dvO3kcG6Efcd4/9KDRUSr4WawZqAg6XRZIvJ9GhGcOCRTSNFI57Hz8etgrBDlSOA4gQ/urDIdkIVgmyDopF2IZT4dkKMYGbk/S4AqbpZ9D2D8p8cdviJs37OxoN87FbA7Wdv2fGfB7CTDfHQ0h+ZuTSL+gDsQpH2r+Cl6IdRUKCQkbEjFAMBM/NMs7d4c5yjLvdqCLusMNtNk0PfLyNOWEVrW8wL9LwMcw91kWC3emjR3/kIzrH7M8uHcTymabcwhDuqq/LgpJcd6bREksTBQsne+HfebYBLOxBj9q+aXJ1oXLy8l7yffjVvfLg4KKW+yYPGxKmvkSKbfpSbvPklIK/DKxnMuWKrCbZx/ZL2Uit+hyZW0tL0iTxb7WF9FLdAzPppViT6vucuQhifRfON9NrmMj9bqZnLjY3rHcw9yRFh9VCXl+GzAAnIAigdnn5VZrq2OZJHD6wBnQaaqvDY0KBAJi8Izl6H2hHOUVvCYHxbUOl6ALg1RYhXXYKhcfbQTdYsEyG/GA4sw0N7zQilwowZMqt2GYbcuFkNCr20AUxPafkwIR9kE0aS4hdW6E8Q8NbeFTip6+/jVqUs5aSz8FaDhMtNzDoHdc81tvJBd/SB4WpWonLle8eo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(8936002)(38070700005)(76116006)(71200400001)(54906003)(66476007)(8676002)(508600001)(66946007)(316002)(110136005)(52536014)(38100700002)(64756008)(83380400001)(7416002)(122000001)(26005)(4326008)(2906002)(66556008)(6506007)(66446008)(9686003)(33656002)(5660300002)(55016002)(186003)(53546011)(86362001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cS9SUHEyczJ3UHNoeWZTbWV1Y25TVnlRSTJzS3FTZFBydGQwckx1Wkk1QlRq?=
 =?utf-8?B?WU9jbDlpYnNtTllUWFFPMERFdlczS3lYKzdBNkZCeVViQzRmNTBSeXVyTFd6?=
 =?utf-8?B?enFXRm5ydUw3bnZ3NFFhS29MdndFNitoN3FmK0pWV01tSDZzRXlFVmk3VkZM?=
 =?utf-8?B?TDMwQlNuczlkdFRQNzcwd1JLakYyL0czZGNaQjBLdGhCTVREV2lqMXl2bXZ2?=
 =?utf-8?B?RkFodmJpUG1NbWgyNUhwS09EQVc4bmFBbG4rSE5LUFgxMndld280azNpNW1l?=
 =?utf-8?B?bE5sK3M3SFZ2RHNDTStmS2plYlVFRVBkTG1jRTA4dlN3Tm9XdkZtbHpOQnZm?=
 =?utf-8?B?WnlER0ZaSkRCcHAxcXB5MEsrRkttQzhMWGJHMEZNb2gwMnJQL1FUS1djNDky?=
 =?utf-8?B?YkhoUDdqKzJTbWVjSE9YWlp2ZXR6czdpbURsR1RVblNCWmFxMnhBMWp6QkJZ?=
 =?utf-8?B?cEVtT2l6bTRuRnYwM0pxTXFIY01sa08xRXVKWWUyMmp0dGtjb09Ya2EveUN2?=
 =?utf-8?B?NzRRcU5kWHp6YmJuUUFKeisvQ0l4dXBwWURRVjFBQ05BV0x6dFpvVXdwWXVm?=
 =?utf-8?B?QUl0RndxWjJPWW9rT0greGVid0VqYWp2dkZFbFJDalZDa2JDVUhINmxsL2x3?=
 =?utf-8?B?M2wvUlpEbldOdUx3VjlOOEQyemNCZmNJYzRkS1kvcGkzOWlORXYwMllsVFRD?=
 =?utf-8?B?R1NNc3lvMHFIYkFlcitqWHZqNVRRd0liRDZDTDNmTUpzM05lUkYwaXRNdlVo?=
 =?utf-8?B?a0k0NENLaEM1Z1cxUXZ1WWIreWM2Q0NtdzM2MkViUFhuWDVpNjBUNXB3RGJl?=
 =?utf-8?B?VFdnMGRqNERLbEVHeisvOUVLakdlUllhNlNIUTBPZCthVkxIai8yUU9QbjRv?=
 =?utf-8?B?OFVOY1hIRGR6YW1KMzA3MFBZQUZLYnNESkNXSWVMbTdPMmdKRlRWcDhEUEdP?=
 =?utf-8?B?aTh4K1hSNFVNZzRtdmlnQUR6QnNJYzU2aThOUjYvdFpWenFDR3VnYk9May9X?=
 =?utf-8?B?OEdiaDFYTEI3WlR3Nmp2M2hGUEVPUENZOGJBUmNmYTlENHR3Rzc5T3FsTExG?=
 =?utf-8?B?NTUxelIrc1hxREQyRzhzSGZOaGYxVVpTc01vYVB0TTVlUlBTOWhWa2s5cW1V?=
 =?utf-8?B?SXpQcjdmNWxKSGNJMEtKVndrblNSdlFuazl3S0NnbEJoWWw2WmkxVjlrTzFO?=
 =?utf-8?B?REdYODNmMWxKSXM0QWZnQTlORE93THRicVNvU1BSdWZPMVVxTWljNTU0N3lw?=
 =?utf-8?B?eklTQVZzK3JZQ1laN0tsNWlhUWVvQ1JSbFlNY2dmblE3UDhjVnN4WmhCV2kv?=
 =?utf-8?B?Y1J4SzliSjhXbVJieUQ1eGdTdXIyTjFwYTQ0WnVJbTlWVlZTS1lLQlhoamRY?=
 =?utf-8?B?YU5FdFRXdktkb3N3RUZERHdvcHhTRnlzV3BhckNRZDJmSlQ1M0sxbjdOakxK?=
 =?utf-8?B?bjByOGFDUUdvNWNRV0tHcUNwUWpNZkcwQXRsTFZYVFl3SVVnQ3d3aDZxVmJu?=
 =?utf-8?B?VXpHMjB4SWhNWkV5MDU2YWJuR0pyL082R0l5dU0rdS9VeGpUVTFkOXRKQ3pt?=
 =?utf-8?B?K2xjVlJ5RjBYam1EOWxNRHBzVk02SFc1SHNqNmorNHNWWE82a3RPZ3FXTlNG?=
 =?utf-8?B?QXB5cHNicW0zbkFBdWdEVCtwU2hTaG9NMXNuUG5mdjN6b2Q4Q091SXN3ZXF5?=
 =?utf-8?B?M05OY0NZcitVVEFSMzlFWk01U0RPTHQzQjVpdW41ZjVTajlaTnF6dk9vdUNW?=
 =?utf-8?B?VzRNcUY3Y284Wk1rZUgyT0lUNHhvN0MvdmllM0QrQUdVc3dlY3ZjUTlhSjZN?=
 =?utf-8?B?Ym44K3NIUTljUm1CeUtmTG1kcmMzQ29mbVpnUTJjZTdXTE5Yd3c4R1RldDJT?=
 =?utf-8?B?Z3NQN1Y4NmMwZE1FdUJBNnlaWC9mM295Zmx6Mjd1SG9SMUMwc3kwME9jMlB5?=
 =?utf-8?Q?oVlkNi8ZflI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44de1bdb-94fb-42c8-bfa7-08d994ff801b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 01:58:53.4996
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
MyBBTQ0KPiBUbzogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgdGhhcnZleUBn
YXRld29ya3MuY29tOw0KPiBraXNob25AdGkuY29tOyB2a291bEBrZXJuZWwub3JnOyByb2JoQGtl
cm5lbC5vcmc7DQo+IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IHNoYXduZ3VvQGtlcm5lbC5v
cmcNCj4gQ2M6IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNC85
XSBhcm02NDogZHRzOiBpbXg4bW0tZXZrOiBhZGQgdGhlIHBjaWUgcGh5DQo+IHN1cHBvcnQNCj4g
DQo+IEFtIERpZW5zdGFnLCBkZW0gMTIuMTAuMjAyMSB1bSAxNjo0MSArMDgwMCBzY2hyaWViIFJp
Y2hhcmQgWmh1Og0KPiA+IEFkZCB0aGUgUENJZSBQSFkgc3VwcG9ydCBvbiBpTVg4TU0gRVZLIGJv
YXJkcy4NCj4gPiBBbmQgc2V0IHRoZSBkZWZhdWx0IHJlZmVyZW5jZSBjbG9jayBtb2RlLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0
c2kgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1l
dmsuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5k
dHNpDQo+ID4gaW5kZXggZTAzM2QwMjU3YjVhLi4yZDA2ODRhYzgyZjYgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpDQo+ID4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpDQo+ID4gQEAg
LTUsNiArNSw3IEBADQo+ID4NCj4gPiAgL2R0cy12MS87DQo+ID4NCj4gPiArI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL3BoeS9waHktaW14OC1wY2llLmg+DQo+ID4gICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy91c2IvcGQuaD4NCj4gPiAgI2luY2x1ZGUgImlteDhtbS5kdHNpIg0KPiA+DQo+ID4gQEAgLTI4
OSw2ICsyOTAsMTIgQEAgcGNhNjQxNjogZ3Bpb0AyMCB7DQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+
DQo+ID4gKyZwY2llX3BoeSB7DQo+ID4gKwlmc2wscmVmY2xrLXBhZC1tb2RlID0gPElNWDhfUENJ
RV9SRUZDTEtfUEFEX0lOUFVUPjsNCj4gPiArCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfRFVN
TVk+Ow0KPiANCj4gUGxlYXNlIGFkZCBhIGZpeGVkIGNsb2NrIERUIG5vZGUgZm9yIHRoZSBleHRl
cm5hbCBjbG9jayBnZW5lcmF0b3IgYW5kIHVzZSB0aGlzDQo+IG9uZSBpbnN0ZWFkIG9mIHRoZSBk
dW1teSBjbG9jayBoZXJlLg0KW1JpY2hhcmQgWmh1XSBXb3VsZCBiZSBjaGFuZ2VkLCBhbmQgc3F1
YXNoZWQgdG8gOCMgcGF0Y2ggb2YgdGhpcyBzZXJpZXMuIFRoYW5rcy4NCg0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkIFpodQ0KDQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiArCXN0YXR1
cyA9ICJva2F5IjsNCj4gPiArfTsNCj4gPiArDQo+ID4gICZzYWkzIHsNCj4gPiAgCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gIAlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfc2FpMz47DQo+
IA0KDQo=
