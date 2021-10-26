Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3B43B638
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbhJZP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:59:08 -0400
Received: from mail-eopbgr20094.outbound.protection.outlook.com ([40.107.2.94]:22503
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237139AbhJZP7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:59:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX8+3GKLxM0Ac2crBPuXxHJxFLIviq9eljmoYINtTtrI1jX7za9NLUq9nz5C0wsGBiyKKJVqiX67hGLTQMTdGIrJ8LnpR00FbBI8dNcCy2tdTN12AqvBa2VfrIJKwB3D9HhQCQe92y98LgAPCsS6ZLK54n1FjQGUD2+zWdk1PBq+wnGjagjztRugstvdgR5Z6XOdk4fb54Je12PasXc6tH6/KKNMRz1ruXiC2KLilRzsrNIs32A1I0raOPU6QJ2HaioYZTm1FCL7OizvXckLF8IIoQpPQdHNClwkxo5Y1pPoNuIbRDrfcq6VURrjNasmPESbeawTd5E5D+tAzfU+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDspBJDgsaKNdcgjaaXldaPVHhYMt2wwpUcCV6KklZw=;
 b=kBPVJTr/j+LYqznx9v4E4YemohJwucpVaokccMCaEBbRfso2NUnWUPJns32GQlADrvVApLcK9x1nqJa5xmer7WzvvlzZp46rAy7ea5lqdeYKxMh+IKtZT3hXiI9sIFYs7zYSXhdduhYdSu2wsdAIIW7hHO0j4Zf8PDKhmf2N02qFqY+9T0PjYMoma5lrBcBibWElAkwhLm190pjPiQYNIB8ZBZFpQY8654r4dvufRcr7MvOQ8wcT+es7NI1gnfJDF9OMTOixrLxpe/aRsM4Xsf7rj69EnpH4nQmLtFSrMXfx51ElF4NJg6kPxUeAawUGckAUVJHsTJyQ+RtYbFnBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDspBJDgsaKNdcgjaaXldaPVHhYMt2wwpUcCV6KklZw=;
 b=WfCIgpaDujZeoOs8bqG0wW7sogW4JbK4kQ50AuxKMdbcXl2hBGTHuU5w7EUgGRcRqYJURnIUEM1449BTKTaJqCA7TyPhf3JuRKzQzwDMB+VEhuzi8z8ma3+yT8+Kax47UbbcyJvXDsCSa40yl/OoPls9vLuz5k/4vskpO8pUvQk=
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com (2603:10a6:10:55::32)
 by DB9PR05MB8670.eurprd05.prod.outlook.com (2603:10a6:10:2c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 15:56:38 +0000
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::91e8:e960:243:da70]) by DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::91e8:e960:243:da70%5]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 15:56:38 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHXyoIPgtB4w+SEX02HbR8b+B5OSQ==
Date:   Tue, 26 Oct 2021 15:56:38 +0000
Message-ID: <6af982786f0136d5f984beaf544e2ba7b7b68d31.camel@toradex.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09b233a3-1c6b-4acd-5d32-08d9989931d5
x-ms-traffictypediagnostic: DB9PR05MB8670:
x-microsoft-antispam-prvs: <DB9PR05MB8670CAEE674E11176A19508EFB849@DB9PR05MB8670.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/VRAErXqdvFL4lYURCyQYNA/I9M6aPp2I0W+Hmot7bBpBlv41z1PD3Qe5QuD22hQ+lxCn/vu65ZXEuZrTcTLMuI8EP7k5LWkorL5Aq6MkwcnVdRK/ZHTowLZrYMIxG908ptCcfhwSexO+HURV6PZh6WZFOZiXpGmgtFkn/cJ3hE3XeOuriIkQVDf/qj9Pz+OrJbRErbzQVDPaZNe6fx+ZpOdgmjwKmdnKb6HzCKg+pLJAKSjHQtflpeN/Fay+I42dTsPm7K/f859Y0oCPKtPkbJ3B6SY7D/XZXnCCpzQETvJxl3+wMlwsO56FQAP/CK5mXhTAgF+jt51b/uWj35Z8goeIjOFinqBgZLUU1slX1hWyq+2ydM8PtKjlof+YUNH9djIZVyH6tUbJ4fUTbUl0b0Wxt7Ztl55kiJFUfVf8C9urhtBK38KP73U3baPJF+U2tIYjskPsnxLKAfzqsqVBAtXLxy3+yVA7VIHnZhB77yNo0uw6AEsEGidWwpiAuke7Dx/jL5Uz4Eq28zdqbVISn4eYXjbFFK/TZZw6a2cFe88xrzfvvTLV6LvWY/O6vHoLu7SV7ZjG3UA2wqIJ0bCEtEcFZTZ+IfeqtrYxXe0iupHBkyJDPbkgZ0YD5mqPXVB316DkR8E6of46G1YeFSAM5seK2juY6zYv3q30ao15X0i6YMNQDGADhA0AU7B9TqFsXRdtjGW0ZMgExzAv+k/RDNUEGUUbAZwpeYXnrTI7SipaMP7nqlJi9XX9miZYes6B4OIIU/zfTS6KIg0Zidqt03G0Iio4V0vWPE0t5Xh514VdxSoT5zz1no6/kAzE4N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB5431.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(508600001)(38070700005)(66446008)(66946007)(966005)(91956017)(54906003)(186003)(8676002)(4326008)(36756003)(26005)(64756008)(44832011)(76116006)(2616005)(66556008)(66476007)(5660300002)(110136005)(6486002)(122000001)(83380400001)(71200400001)(8936002)(6512007)(4001150100001)(6506007)(2906002)(86362001)(7416002)(38100700002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmQ0Y2lVb1ltQzFRZG9TRDMvalo4S3h3dTJwZ05uRjVnNHYxK1BCakZuRVk5?=
 =?utf-8?B?RDkyUCs5OUp6UjNUdHliUGxvSXlOVkF1ak40TDFjdVcxbTRsZnJjQlFFdHJs?=
 =?utf-8?B?OG5vNHhERVlPRGx2M2txR2piQTJ3RWUzTTBVYmEvV0lnQ2V4Zm54dFZEbmYv?=
 =?utf-8?B?aGRDaEVXTTZOMVJzNWcvVTVpMVIvK096VkN6WW5qRFZqU3NCdHFibTc4RFFX?=
 =?utf-8?B?VkpNVjJOaGhKNU1ieldpbjFvRGpzSTEyYXpVV1BXT2xmVkZaSmpnTG9tRUhX?=
 =?utf-8?B?MGFqT3FKVG9rVm9mTnVLb3lFYzNoTVp3R0pCQ2lMa1IvNUtYYVJZS2cvRUFY?=
 =?utf-8?B?RENuSXRaY1ZpL1QvZFJvQWRaem9YTkNsb1FrQlNZZnNaYkhnd29TY2pnOUM1?=
 =?utf-8?B?Y3M3UTNiQjQxRjhtRGQxcVhmSXIzWHEwbGdjZEdtRDNCL01wamFYbEZDSWgv?=
 =?utf-8?B?a1pqNWdPNkRsRTE4MXdhd2JsZHBvZ2VjZDM5aTFxWC85UjY2L3F3UU1FTFpB?=
 =?utf-8?B?Ui9oM0hNMnJ2cXhCM0w0NWM1eWVoOTJrbUdyOUFlci8vQnRSaFl4bnhIcXdo?=
 =?utf-8?B?WVBvbURreXd2MUlZWGhHcDlCU1QydmJUQVJ6aWdJbEw5amVGS29NZFZ1d3lv?=
 =?utf-8?B?SkNqMWVGZXFxTWFOMUpWdHdMcTdEMGowVDJNNHZmR2dkZjkvS0p2WHdkcGVz?=
 =?utf-8?B?cmJWOFdyVXlpWm1EeU1PdTVhL1BUOCt3TWt3UHVTQjgvOGlPWmRXTktDRFo4?=
 =?utf-8?B?R2VsVWk4VmtSOStVdkNacnF4Qkl3RXlabW1QTU1QVnJEWmJYOERPekg0NFcz?=
 =?utf-8?B?SEVaNVRYWUxPN29iOENDOVpabTZqMFhGTHhsVWV0ellRVXVlQ2dxWVU4QU5z?=
 =?utf-8?B?a0huRWV0Wlg3MTF0RDFGQW1OakQ4N0tneUM3M3lsWmNoRlNKOUlMNk1CQjhH?=
 =?utf-8?B?UmdPSUZXcEVWTmR3dWZ0VE1xZ1c3TFZEUFNQSU9jVi8zQmZQb0hiNFhPSUQx?=
 =?utf-8?B?TmFnc25LYjZrRFRnVUozbmZrcFUvUjRXTEdQZWo5MkZabHJ4WVFhMER0UlpL?=
 =?utf-8?B?em9sdnBzR1ZZclpVWE5NeFFVVlBQbGlZT2c4eUYzQmEvSFRSamdXTDYybzZr?=
 =?utf-8?B?Y2ZSdVVxdWR1UUkwU2FXTnpsc0Vpc0xrQjd4R0pidWtkKzVzZ3Z6VFZJbGhY?=
 =?utf-8?B?YnU3NjlnNHFOa1BCcW5qdVhtUDRTQmxicU9XNlhmUW5vQnlQNEFkeENHU0xW?=
 =?utf-8?B?dEQ3eFpQb2s3Ky9NZEVIUlhKSjFNcWp0TnkwQVRQQjBqTTc5aGttRDVNT3VE?=
 =?utf-8?B?M2p4eFhtME4rRGp6MEpXUTZ1dTdWR0xVSTBqTmx6R0wrUVF5MDVhWnNVRkFk?=
 =?utf-8?B?MGJFUHNBZm5MckI3MU9aT0oxNTVHVGd3aDBHWE1qb2loem55bFdJTWU3Uklu?=
 =?utf-8?B?eGp4OHRnbHREOHVwZWYzUG9mSDB1QTZyNUF5MWdFOXc5blNVcTRzRFR0WEhl?=
 =?utf-8?B?SnRtQ3V5bGttdWw4S2ZHSlJDZVR0ZkZpbXkzQ3JWY3Q4UTNVTk8rWlRWeHVS?=
 =?utf-8?B?YjhyQ1FTSktEaTJ0VGxPaXozZUFWWFQvc0xyZnJNcUtTQWw2NXdoS1FDSksz?=
 =?utf-8?B?SER0RCtUekFtTU1Xdlg5SzAvTjdPM2t3dzJpMHBjNmVwVEZhWFlzZ2E0Tldp?=
 =?utf-8?B?TGpZKzBUalBCdmFoWFVYUStlNHlFUnpJZFFuMlFRRzFNa3I1MjVoQk9ZMjBi?=
 =?utf-8?B?YS9IS2lmOGl6dVY3Z09GbmwxRDNFQzhrU1RCM214cUlOb0FVaGtKVzdIbFpR?=
 =?utf-8?B?TitGRWRTM25wWncxS3Q0ZzFzUGRJd0lMN2JhTGZJMnExSEhYRzRPRUxaU2dq?=
 =?utf-8?B?S05hdHByNUtMeHAwanNsSWFmZy9NcjBOTHh4WE94Y2VDNmp4dXVIc0o0RWZG?=
 =?utf-8?B?RUU4UkJoQ2M1Y0NQb1VlUnBEVXJXeGN5eUtXWW9kYURYU2owOFdsUnlWSk8z?=
 =?utf-8?B?RkFsaTVtKzZWRnI5R3VjZC9QZWs1elFROWlLOFcwL0RwYzZiK011ZVlLc2x6?=
 =?utf-8?B?Nmpldi9mNmZmWkExdlg4U29WM1BJUDIrV1dEN09IU0tmNVZJeTc0TURXbzBM?=
 =?utf-8?B?T1pYWVhSN3BHYWJTN0QxSXgrT0dIaklzS3NZWlBKWVpxUGE5NDBuRUZ2SHFs?=
 =?utf-8?B?bC9OVlFZRW4rWmNHOWVWTzc1ZUtsWVhmRXc4MkgzR0xLcGc4eDF3dGxkRnp3?=
 =?utf-8?Q?uvDhenylKD/hw8zS4jsXBgPbYYQrRJtTmlZV1edBHg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31411283E773B541990FF7FF9311D3D4@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR05MB5431.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b233a3-1c6b-4acd-5d32-08d9989931d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 15:56:38.1331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LqjEpgq7rU21b5tizBM8pfbhoC9CCQ+otGmJsdEY2D7yCIA/GuzicvcKkotrmzrBVgHQE0xWoQPd9DqV7ba3+4w1OlTlHlFEWVnqwtgRPkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8670
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTEwLTEyIGF0IDE2OjQxICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4g
cmVmZXIgdG8gdGhlIGRpc2N1c3Npb24gWzFdIHdoZW4gdHJ5IHRvIGVuYWJsZSBpLk1YOE1NIFBD
SWUgc3VwcG9ydCwNCj4gb25lIHN0YW5kYWxvbmUgUENJZSBQSFkgZHJpdmVyIHNob3VsZCBiZSBz
ZXBlcmF0ZWQgZnJvbSBpLk1YIFBDSWUNCj4gZHJpdmVyIHdoZW4gZW5hYmxlIGkuTVg4TU0gUENJ
ZSBzdXBwb3J0Lg0KPiANCj4gVGhpcyBwYXRjaC1zZXQgYWRkcyB0aGUgc3RhbmRhbG9uZSBQQ0ll
IFBIWSBkcml2ZXIgc3Vwb3J0WzEtNV0sIGFuZCBpLk1YOE1NDQo+IFBDSWUgc3VwcG9ydFs2LTld
IHRvIGhhdmUgd2hvbGUgdmlldyB0byByZXZpZXcgdGhpcyBwYXRjaC1zZXQuDQo+IA0KPiBUaGUg
UENJZSB3b3JrcyBvbiBpLk1YOE1NIEVWSyBib2FyZCBiYXNlZCB0aGUgdGhlIGJsa2N0cmwgcG93
ZXIgZHJpdmVyDQo+IFsyXSBhbmQgdGhpcyBQSFkgZHJpdmVyIHBhdGNoLXNldC4NCg0KV2hvbGUg
c2VyaWVzOg0KDQpUZXN0ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRv
cmFkZXguY29tPg0KDQpCVFc6IEkgdGVzdGVkIGl0IG9uIFZlcmRpbiBpTVg4TSBNaW5pIFYxLjFC
IHdpdGhvdXQgYW4gZXh0ZXJuYWwgUENJZSBvc2NpbGxhdG9yIGFrYSBzZXR0aW5nIGZzbCxyZWZj
bGstcGFkLW1vZGUNCnRvIElNWDhfUENJRV9SRUZDTEtfUEFEX09VVFBVVCB3aGljaCB3b3JrZWQg
bGlrZSBhIGNoYXJtLiBUaGFua3MhDQoNCj4gWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5v
cmcvcHJvamVjdC9saW51eC1wY2kvcGF0Y2gvMjAyMTA1MTAxNDE1MDkuOTI5MTIwLTMtbC5zdGFj
aEBwZW5ndXRyb25peC5kZS8NCj4gWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1hcm0ta2VybmVsL2NvdmVyLzIwMjEwOTEwMjAyNjQwLjk4MDM2Ni0xLWwuc3Rh
Y2hAcGVuZ3V0cm9uaXguZGUvDQo+IA0KPiBNYWluIGNoYW5nZXMgdjIgLS0+IHYzOg0KPiAtIFJl
Z2FyZGluZyBMdWNhcycgY29tbWVudHMuDQo+IMKgLSB0byBoYXZlIGEgd2hvbGUgdmlldyB0byBy
ZXZpZXcgdGhlIHBhdGNoZXMsIHNlbmQgb3V0IHRoZSBpLk1YOE1NIFBDSWUgc3VwcG9ydCB0b28u
DQo+IMKgLSBtb3ZlIHRoZSBQSFkgcmVsYXRlZCBiaXRzIG1hbmlwdWxhdGlvbnMgb2YgdGhlIEdQ
Ui9TUkMgdG8gc3RhbmRhbG9uZSBQSFkgZHJpdmVyLg0KPiDCoC0gc3BsaXQgdGhlIGR0cyBjaGFu
Z2VzIHRvIFNPQyBhbmQgYm9hcmQgRFQsIGFuZCB1c2UgdGhlIGVudW0gaW5zdGVhZCBvZiByYXcg
dmFsdWUuDQo+IMKgLSB1cGRhdGUgdGhlIGxpY2Vuc2Ugb2YgdGhlIGR0LWJpbmRpbmcgaGVhZGVy
IGZpbGUuDQo+IA0KPiBDaGFuZ2VzIHYxIC0tPiB2MjoNCj4gLSBVcGRhdGUgdGhlIGxpY2Vuc2Ug
b2YgdGhlIGR0LWJpbmRpbmcgaGVhZGVyIGZpbGUgdG8gbWFrZSB0aGUgbGljZW5zZQ0KPiDCoCBj
b21wYXRpYmxlIHdpdGggZHRzIGZpbGVzLg0KPiAtIEZpeCB0aGUgZHRfYmluZGluZ19jaGVjayBl
cnJvcnMuDQo+IA0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxp
bXg2cS1wY2llLnlhbWzCoMKgwqAgfMKgwqAgNiArKysNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BoeS9mc2wsaW14OC1wY2llLXBoeS55YW1sIHzCoCA3OSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW0tZXZrLmR0c2nCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUzICsrKysrKysr
KysrKysrKysrKysrDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS5kdHNp
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQ2ICsrKysrKysrKysr
KysrKystDQo+IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2MyArKysrKysrKysrKysr
KysrKysrKysrLQ0KPiBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvS2NvbmZpZ8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDkg
KysrKw0KPiBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+IGRy
aXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuY8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIxOA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiBp
bmNsdWRlL2R0LWJpbmRpbmdzL3BoeS9waHktaW14OC1wY2llLmjCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE0ICsrKysrKw0KPiA5IGZpbGVzIGNoYW5nZWQs
IDQ4NiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gW1BBVENIIHYzIDEvOV0g
ZHQtYmluZGluZ3M6IHBoeTogcGh5LWlteDgtcGNpZTogQWRkIGJpbmRpbmcgZm9yIHRoZQ0KPiBb
UEFUQ0ggdjMgMi85XSBkdC1iaW5kaW5nczogcGh5OiBhZGQgaW14OCBwY2llIHBoeSBkcml2ZXIg
c3VwcG9ydA0KPiBbUEFUQ0ggdjMgMy85XSBhcm02NDogZHRzOiBpbXg4bW06IGFkZCB0aGUgcGNp
ZSBwaHkgc3VwcG9ydA0KPiBbUEFUQ0ggdjMgNC85XSBhcm02NDogZHRzOiBpbXg4bW0tZXZrOiBh
ZGQgdGhlIHBjaWUgcGh5IHN1cHBvcnQNCj4gW1BBVENIIHYzIDUvOV0gcGh5OiBmcmVlc2NhbGU6
IHBjaWU6IGluaXRpYWxpemUgdGhlIGlteDggcGNpZQ0KPiBbUEFUQ0ggdjMgNi85XSBkdC1iaW5k
aW5nczogaW14NnEtcGNpZTogQWRkIFBIWSBwaGFuZGxlcyBhbmQgbmFtZQ0KPiBbUEFUQ0ggdjMg
Ny85XSBhcm02NDogZHRzOiBpbXg4bW06IGFkZCB0aGUgcGNpZSBzdXBwb3J0DQo+IFtQQVRDSCB2
MyA4LzldIGFybTY0OiBkdHM6IGlteDhtbS1ldms6IGFkZCB0aGUgcGNpZSBzdXBwb3J0IG9uIGlt
eDhtbQ0KPiBbUEFUQ0ggdjMgOS85XSBQQ0k6IGlteDogYWRkIHRoZSBpbXg4bW0gcGNpZSBzdXBw
b3J0DQo=
