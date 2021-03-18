Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F92340425
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCRLER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:04:17 -0400
Received: from mail-db8eur05on2087.outbound.protection.outlook.com ([40.107.20.87]:5025
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230423AbhCRLEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:04:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8BU2NZJWLnZGeip5TLpoj8kgu1Uk5Iy15SJVXcJ1CtpA/NaKhZl5TBbPkdUou7yj0k7ZIOCvCEI1L6HqYX1S2sUWWiyg2ZxdwJKGiB4xZgZRHm7qyMdOZviPTnkLd89HzDZpH7cQE9roQol9CQZJmCSuswZ7a5oZK00HJ7yonQv5bYfUJ8m3sIfO2GLhYwNIojHY/ihVSQg0nXJnYtBaqFPoTA1wT+agCd3tWn2KECnbPOpEpHBHgW2+DdPjiktzYsbV5FWcqOcMdWyhXsXsrRSfSVgt7j0Z4WSDZSRYWwh7DGg619/B75vCaEdZCep28OB6/xKEm07UUV3V/KSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMJ5qDdBKsJ6wHT/6zwmn15xdXs6tDdEKu8bS3UoMhI=;
 b=IY27BO1GaEdtzaIjfbjV93biXVakDIet+t5H7BSGDrX4XHN3XDpKqtkHYINPcFXb1vZ1XghGmjyImAt8EGGKhECpPWzKLD6lSBDhYbVvqtGPV7WXc6KVx49XIINf3rmeOpAJs5giJiTq+G6I2/ZVuDYPainV6MzDdnNhh0hxAEKtYSYCV+8wzuphAbi2gJd5OAdT0TJ1FPkS4ET6Tx1LYHUP6GeApkdCZh2gbA6ZFUqi4H30h0RqFrPgs6FHZVeQqIgbN6kXUFv7hQPgfE5g6O8/qNt7NB9Yk/8w8nJMqMgjMjYC6xf73xMPink4zaw5V9Aog6Fo4FED+v5/Fs89Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMJ5qDdBKsJ6wHT/6zwmn15xdXs6tDdEKu8bS3UoMhI=;
 b=EXQiABVnPBqYqc1yA1XweBiMYDZf+ALAQ9wPwYtWZFK7xj8E8G7PN8eDDZuY3dp6N5+eVN+u0B1cBDzyJBGak/cy89zPJdIj0E2IhARzImHJSuNB4rCQ3+ykvXO7xInpwQF8gnpEtEcYQo+XibiNe2GKUSF+UPDLQR0T2A2UVtM=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB7PR04MB4778.eurprd04.prod.outlook.com (2603:10a6:10:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 11:03:59 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9598:ace0:4417:d1d5]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9598:ace0:4417:d1d5%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 11:03:59 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1] arm64: dts: imx8mp: fix FEC can't work when attached
 to generic phy driver
Thread-Topic: [PATCH V1] arm64: dts: imx8mp: fix FEC can't work when attached
 to generic phy driver
Thread-Index: AQHXEOsfGZoksDr6hU+Kq56FPsGR4KqJpo4AgAADGyA=
Date:   Thu, 18 Mar 2021 11:03:59 +0000
Message-ID: <DB8PR04MB6795178A70C52D067DC1AEE1E6699@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20210304114013.18494-1-qiangqing.zhang@nxp.com>
 <20210318104813.GB22955@dragon>
In-Reply-To: <20210318104813.GB22955@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d56e79e-efb5-4e8c-d3bf-08d8e9fd8832
x-ms-traffictypediagnostic: DB7PR04MB4778:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4778FC1A0B539C1A8AFC8BF5E6699@DB7PR04MB4778.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JDCr7bjl1FCTvLY8+hzl8ZQjT+7jlL9iHeeGGYWRpHEuFeo9DAmaOKWUxK2W4xJpi55vWlHug4MBotCwhD8e6NylXIFZZ2z6inNzRLKXQmzi5phyIHxElERDlkVGRvWsD6O89Afdb3sWfweWJYo1M5k4ojKImjyS/GVNsUyiHczyZm3VLbZyya676moZNpvwrpXRLs17FRCOpL3bHD95e5NiaJy7HbPrS2DhGEqDYrmWBrgD1p6L934PFj2QsCTUnDbtRcOA3qXbAwDZfF1tTrg4puwTtLfv1y7Z7uxWweCYXrtELX7oDpzVNKxKH/ro/Lsy+tf3koP5CghBPMqCugOWBjfDmKUW/0UAAYf+t+ZTosO89Y9YYm8P21t/UiNLJU/uDVwIe2Ga0nQktUtd/nRwSfwquoL9+e9g/1WmjH7WGTKeYkONvGCOM3nOXP+sku9rDhfjXzgwI/Y1rqhljLVpGuCN034Q0G6pHrZyf+f0YJ4Z8JbxanewYXvVVYsRZGnC+rF0lzbie1ZJLPcgqqrfdFb5FMJyPqvNFxnf7D0TjSqssOVgIEpZKgiFJwxsPZuQX7bv6KFQInBUra7Rf6t3xAzn80OkkDNzD3MYtavt0uan8HVnJ/TO5c83Sn6z3wsWUrDdLZW7hSaM/CGtGKAuOrV+WhtQCgtysfY4Ja0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(186003)(66946007)(64756008)(66446008)(66476007)(76116006)(9686003)(33656002)(66556008)(8936002)(4326008)(53546011)(54906003)(316002)(7696005)(38100700001)(2906002)(5660300002)(6506007)(86362001)(6916009)(8676002)(52536014)(71200400001)(83380400001)(26005)(478600001)(55016002)(41533002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?Q0tscm1wTjZIK1JzeXk2cWZsdFM2dW9xUk9DU2VLWllXNVhnY1YwS2FQU0Qx?=
 =?gb2312?B?Q2JlaEFsOXNGWFBGR0Y3NjJzL1ZMU0EyZzkvZWxQclBRYUhzZytlSWdSSENO?=
 =?gb2312?B?aE1JVGlwNSt2cDcwdkRMVTFmS0FlbGZ3MjZveDVTMzVvK2VMbkVOamtNaXM1?=
 =?gb2312?B?NkZ2b3IxZGlFcmo1aytoUGlaeVNsVnpwUlhNdEhEVk5DOC85MVgrTm5vOUI3?=
 =?gb2312?B?ek9La20zRTlTR2NaOVNqNnFZUFFYYzhSVm9yOXVlQjQ1RGcxZlBGK21CODlI?=
 =?gb2312?B?bWJyaWlEcmc2MVVkai9YWUpxdS9odkhFYUJrcHlSb2p6NHIreTBzcGlXZ2JS?=
 =?gb2312?B?Qm1zZXpGSDFuM214LzRTTWNhNDJmaEora2NWbkNZYlZVZHpxc0JoVU5nQkEw?=
 =?gb2312?B?bllqMHNwYVlCNnZCQjE1bkQwN2d6ekorSUYxVDY5S1FaNDAxZlBQaGRYd1Zn?=
 =?gb2312?B?Q0laRXE3UWJsemNuMWU5Nm9lOFBxWHNjK0RwbHUrNjYrQmxuMlh0azJvUEp6?=
 =?gb2312?B?aHluczB5d2c1dnVONDRYaSsxRENYWEx3MkpQb0xDSzhWWkUyQ0pXT0o4MEgv?=
 =?gb2312?B?amlENmVvMDk2azZKK0EyZm9QOXhjNnpqUDBBOGhFKzdBM0pvQ05HVEN2aUd4?=
 =?gb2312?B?NEZWS0R1c3FmZUhwUnFNeEpUZnpLLzUwTzFNT0FmVlU5dVFBb3BwTWU4M2Uv?=
 =?gb2312?B?TzRFUUtoQWdmQXAxYW9jNmVYTFJpMHRIQi9CajBkeENkYzFmYVJRWXN2SjJ5?=
 =?gb2312?B?SHF1ZFpUS3I4VzBZeklldXZGWVN1TjU3bmhxejQxck44OVVXc2pLM21pK09M?=
 =?gb2312?B?L2lxUWxrQmRwMWUwQWU0bVdRNWY2WTFiRWQ3RGJWNzROVUpTWWROTXBrbERq?=
 =?gb2312?B?MU5WOEFVZVo4cFZTejhreXRNVys1UjN6MnlvNGhZczFCQmc3UXluazJncGJF?=
 =?gb2312?B?Z2tQeGxWQXJEUDEyQ1hhMGdjV2JhU0dsblg5YjJJT0djZElkaTlBejh4OSt3?=
 =?gb2312?B?TmZTWEMzY2gyaEh1UHhiK3c5dU9ndEVxeGUzMVZBYzlUSjVUR2Q3NTRIT3BH?=
 =?gb2312?B?anY2dUFxY3ZoeHFid0phTDhZQ1lpNGtjNWFIZTBMdjRxVHpKS0N3aEgxYzIz?=
 =?gb2312?B?bmVjRWZkN01hWlhsckJCVkVOT09ma29TSndxWFJXOXNTOXNmVVk0UkY3aDV3?=
 =?gb2312?B?ZFgzeXlsWk5lUnR1TmpqU3lDU3dPektMWXFlUWNZL1hQNXZhdEZmR01rY2NZ?=
 =?gb2312?B?aStOZnpoK041SUpYaVlmbFd1QmNFVk5zQTEwdWxXR3dlRDhENEVjSnJIRE1N?=
 =?gb2312?B?U0FGZXR1T01pbG1uei8vVTFiYS93aktqeWlYL1poaDBjYWw1NjdzRTh4aUhH?=
 =?gb2312?B?d2VoUkMydjNOVkhEVjJXS3hpMFIxWm5hZGptOXk3b1YrRFNZaGEybk1rUkt5?=
 =?gb2312?B?TTdVdXhaS1Y2TWd4MzJuTVpTdEVwUjFDS0FmUGpvWjdnMjM4elJoR0dpZWNR?=
 =?gb2312?B?bzhpQXJzNWQ3b1JZMmsxcEFqWWtxRVVHTVU1T1FaRStPQjh4N3E2dXUxT3Rl?=
 =?gb2312?B?SDRkUEoxZkp4dmlxRHMzZjJWUmd2T2Jib0VrZ0FSUlNFRjlSZEx1RHpkeStU?=
 =?gb2312?B?SERtd3h2ZVZSZHgvZThDUW9rSE02TkRCTjV2MnNUTnRNRUc3NEt3aFRMUFZ0?=
 =?gb2312?B?L0Z6SHBNdE85cUdESEpWU1lwRnErdjhWeE5lTVhrSUpBVVM2LzRUb3hnbXU1?=
 =?gb2312?Q?YA4wZ5GcyyZNq01BiJZhSCiDyPBQzaAsrP5NyIw?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d56e79e-efb5-4e8c-d3bf-08d8e9fd8832
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 11:03:59.2581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKR6hA2EcWyfaGclVdpzFzlJv2LEwRmHIcJIfdwqFCY/GF+OtSrlOby1yazrwBoCc2l9HBBmumtry5yQ8ejZCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4778
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz4NCj4gU2VudDogMjAyMcTqM9TCMTjI1SAxODo0OA0KPiBUbzogSm9ha2lt
IFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9y
Zzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjFdIGFybTY0OiBkdHM6IGlteDhtcDogZml4IEZFQyBjYW4ndCB3b3JrIHdoZW4gYXR0YWNo
ZWQNCj4gdG8gZ2VuZXJpYyBwaHkgZHJpdmVyDQo+IA0KPiBPbiBUaHUsIE1hciAwNCwgMjAyMSBh
dCAwNzo0MDoxM1BNICswODAwLCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4gU29tZSB1c2VycyBy
ZXBvcnQgdGhhdCBGRUMgY2FuJ3Qgd29yayBvbiBpLk1YOE1QIEVWSyBib2FyZCwgaXQgYnJpbmdz
DQo+ID4gaW5jb252ZW5pZW5jZS4gVGhlIHJvb3QgY2F1c2Ugc2hvdWxkIGJlIEZFQyBjb250cm9s
bGVyIGF0dGFjaGVkIHRvDQo+ID4gZ2VuZXJpYyBwaHkgZHJpdmVyLCBhcyBSZWFsdGVrIHBoeSBk
cml2ZXIgaXMgYnVpbHQgYXMgbW9kdWxlIGluIHRoZQ0KPiA+IGRlZmNvbmZpZyBmaWxlIChDT05G
SUdfUkVBTFRFS19QSFk9bSksIHNvIGl0IGlzIHVuYXZhaWxhYmxlLiBJZg0KPiA+IHByb3ZpZGUg
InJlc2V0LWdwaW9zIiBwcm9wZXJ0eSwgaXQgd2lsbCByZXNldCBwaHkgd2hlbiBwcm9iZWQsIGFu
ZCBubw0KPiA+IHdheSB0byByZS1jb25maWcgcGh5IHNpbmNlIHdlIHVzZSB0aGUgZ2VuZXJpYyBw
aHkgZGlydmVyLCB3aGljaCBsZWFkcw0KPiA+IEZFQyBjYW4ndCB3b3JrLg0KPiA+DQo+ID4gVGhl
cmUgYXJlIHR3byB3YXlzIHRvIGxldCBGRUMgd29yazoNCj4gPg0KPiA+IDEuIElmIHlvdSB3YW50
IHRvIHVzZSBnZW5lcmljIHBoeSBkaXJ2ZXIsIHBsZWFzZSBkZWxldGUgInJlc2V0LWdwaW9zIg0K
PiA+IHByb3BlcnR5LCBrZWVwIHBvd2VyLW9uIHN0cmFwcGluZyBwaW5zIGNvbmZpZ3VyYXRpb25z
Lg0KPiA+DQo+ID4gMi4gSWYgeW91IHdhbnQgdG8gdXNlIFJlYWx0ZWsgcGh5IGRyaXZlciwgcGxl
YXNlIGJ1aWxkaW4gZHJpdmVyDQo+ID4gKENPTkZJR19SRUFMVEVLX1BIWT15KSwgYW5kIGhhZCBi
ZXR0ZXIgYWRkIGFub3RoZXIgdHdvIHJlc2V0DQo+ID4gcHJvcGVydGllczoNCj4gPiAJcmVzZXQt
YXNzZXJ0LXVzID0gPDIwMDAwPjsNCj4gPiAJcmVzZXQtZGVhc3NlcnQtdXMgPSA8MTUwMDAwPjsN
Cj4gPiBBY2NvcmRpbmcgdG8gIFJUTDgyMTEgc2VyaWFscyBQSFkgZGF0YXNoZWV0LCBmb3IgYSBj
b21wbGV0ZSBQSFkgcmVzZXQsDQo+ID4gcmVzZXQgcGluIG11c3QgYmUgYXNzZXJ0ZWQgbG93IGZv
ciBhdCBsZWFzdCAxMG1zIGZvciBpbnRlcm5hbCByZWd1bGF0b3IuDQo+ID4gV2FpdCBmb3IgYXQg
bGVhc3QgNzJtcyAoZm9yIGludGVybmFsIGNpcmN1aXRzIHNldHRsaW5nIHRpbWUpIGJlZm9yZQ0K
PiA+IGFjY2Vzc2luZyB0aGUgUEhZIHJlZ2lzdGVyLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZWxl
Y3RzIG1ldGhvZCAxLCBzaW5jZSB1c2VycyBtYXkgd2FzdGUgdGltZSB0byBmaW5kIG91dA0KPiA+
IEZFQyBmYWlsdXJlLCBpbiBtb3N0IGNhc2VzLCB0aGV5IGp1c3Qgd2FudCB0byB1c2UgbmV0d29y
a2luZyB0byBkZWJ1Zw0KPiA+IG90aGVyIG1vZHVsZXMuDQo+ID4NCj4gPiBGaXhzOiBjb21taXQg
OWU4NDc2OTNjNmYzNCAoImFybTY0OiBkdHM6IGZyZWVzY2FsZTogQWRkIGkuTVg4TVAgRVZLDQo+
ID4gYm9hcmQgc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9ha2ltIFpoYW5nIDxxaWFu
Z3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1wLWV2ay5kdHMgfCAxIC0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXAtZXZrLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1wLWV2ay5kdHMNCj4gPiBpbmRleCA3ZGI0MjczY2M4OGIuLjRmNWMyZmIzM2VkYSAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0
cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmsuZHRz
DQo+ID4gQEAgLTk3LDcgKzk3LDYgQEANCj4gPiAgCQkJY29tcGF0aWJsZSA9ICJldGhlcm5ldC1w
aHktaWVlZTgwMi4zLWMyMiI7DQo+ID4gIAkJCXJlZyA9IDwxPjsNCj4gPiAgCQkJZWVlLWJyb2tl
bi0xMDAwdDsNCj4gPiAtCQkJcmVzZXQtZ3Bpb3MgPSA8JmdwaW80IDIgR1BJT19BQ1RJVkVfTE9X
PjsNCj4gDQo+IEhtbSwgRFQgaXMgZGVzY3JpYmluZyBoYXJkd2FyZS4gIElmIGJvYXJkIHNjaGVt
YXRpYyBzYXlzIHRoZXJlIGlzIGEgcmVzZXQNCj4gR1BJTywgd2Ugc2hvdWxkIGhhdmUgaXQuDQoN
CkhpIFNoYXduLA0KDQpTZWVtcyB5b3UgcHJlZmVyIHRvIDIsIGlzIGl0IHBvc3NpYmxlIHRvIGJ1
aWxkaW4gUmVhbHRlayBQSFkoQ09ORklHX1JFQUxURUtfUEhZPXkpPyBJZiBub3QsIGl0IGlzIGdv
aW5nIHRvIGJlIHRyaWNreS4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+IFNoYXdu
DQo+IA0KPiA+ICAJCX07DQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+
ID4NCg==
