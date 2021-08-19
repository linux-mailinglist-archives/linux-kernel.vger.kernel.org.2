Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB43F12CE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhHSFfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:35:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51090 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229782AbhHSFf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:35:29 -0400
X-UUID: 84bc1639523c4645bacce2ecfc530a5f-20210819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=m9bp4O6+k9Tk1a0NJEL/0pD/rptC2O9OYRXyH59LgPw=;
        b=Y8Vwpj/ggPH5K38W7cSFBsiBxj8STgB98XJxMPadVUR7KXlM+sGQ0Ot3RlVbHxyEjOV4qOG4TVWwEuwKBRAnCde6r+LNQSO004Q8Q8olpyKSHXC57KGXemny0ONNO7n9L6LRmaoZrKdVquqA5RMFzyXWbI4kr0lEkOkHKzq9Xd4=;
X-UUID: 84bc1639523c4645bacce2ecfc530a5f-20210819
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2073319112; Thu, 19 Aug 2021 13:34:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Aug 2021 13:34:48 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 19 Aug 2021 13:34:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qx7FsEpcJz6HtX4B+l2V8QSiaAk6rIT2snVz0pueT4WlXI/lcDjtCWvUNyjg52GBj5/UEmFiVU5cvz9D91NOU+afccomWGbxZGjFl+I0Up4IsXPtgUNzEzptZnkJd+si/ll2hkdWq1JtxYCSUiXeLtMijYqKUg52Mf1nw8OJWlRbxIT4IXsPInzsLy/fYb0sW2MZsy5HpMrOlyigBHqYAQBWyQYteBJqWnM/iUEl1AKT+8F7uqkYeEY2mWBcNlLa8bU2WGVv4cP0PcjH2gESMnzdSuKCyygJWAcsScShck6MDIXbqr0MTNV9vANu7JuEQVRrFhwWNJ0D/Dk0CozEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9bp4O6+k9Tk1a0NJEL/0pD/rptC2O9OYRXyH59LgPw=;
 b=B9u7Iq0LwhVkZmtKDMXeNoZPaBg+S425LhqE4RxYk3S+iw8XGa7pzDS8p4NAV6ksb9crj7KInT4woVBZf1FJifDL4xAVwVgE2yW8SyQIJhwPlLzNQ4do5bOlHltAKHYccXqoGiUFsyhegHFj8AN2u9z+WKMG6+dBaiYSC0L9mERNBI+zxzgzaA0y3jC6fPn468XM5T1+smgBtgROS5F9/ZudajH2v8uU+TpWGv09s899oLBV/5HgJs6Ku+Ln/Owa+vG2aHdRI/KnJ/iNYpk90q3oGik5Vs7GNlNgELd55wcDEuxLaKroaLWcCJKsJ8SQJPZbA57KUUYdf2TNhbngEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9bp4O6+k9Tk1a0NJEL/0pD/rptC2O9OYRXyH59LgPw=;
 b=TAI8Z448en9IoXU6Vpj1OQviLVDa6+M2jxQ6eOw/hUdjCa6TKm6zmBywxukq2W5vNIZ88Z8k4lvNwM1fG01QQJNPSvhAqHtpcBuu9f5puAiCTNjshkdAwjG9HxDNC+MTxWCXFRsHbjbIigBuaxBm1bB/EOvx7pEwmG5s1cTw34s=
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com (2603:1096:203:4b::11)
 by HK2PR0302MB2499.apcprd03.prod.outlook.com (2603:1096:202:3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.15; Thu, 19 Aug
 2021 05:34:34 +0000
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::9108:efd1:31ac:c6b0]) by HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::9108:efd1:31ac:c6b0%7]) with mapi id 15.20.4436.018; Thu, 19 Aug 2021
 05:34:34 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        =?utf-8?B?WWkgS3VvICjpg63mh78p?= <Yi.Kuo@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        =?utf-8?B?QW50aG9ueSBIdWFuZyAo6buD5bu65ZiJKQ==?= 
        <Anthony.Huang@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "ikjn@chromium.org" <ikjn@chromium.org>,
        =?utf-8?B?TWluZy1GYW4gQ2hlbiAo6Zmz5piO5rGOKQ==?= 
        <Ming-Fan.Chen@mediatek.com>, "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v3 00/13] MT8195 SMI support
Thread-Topic: [PATCH v3 00/13] MT8195 SMI support
Thread-Index: AQHXjb8Hll+XizX+WEmkps1CcJVtHKt5x2YAgACU4IA=
Date:   Thu, 19 Aug 2021 05:34:34 +0000
Message-ID: <5f4c25b27f347a1ae0e2941ab3e3584730a9970a.camel@mediatek.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
         <1a160afd-ceeb-04a3-8213-fe781ec18e30@canonical.com>
In-Reply-To: <1a160afd-ceeb-04a3-8213-fe781ec18e30@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbc40bb0-fe2f-4c25-b69c-08d962d3071d
x-ms-traffictypediagnostic: HK2PR0302MB2499:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0302MB24991E45028B5617BF5557D598C09@HK2PR0302MB2499.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sydXY7e5t8B/F7mHOhSUynyn5v+h+XGNj4xvaLmwjtGNUI6TDfyGGZxhue+iaBjP7XhAIQZtXQrPcP4BT+EWmaWpLCgEls+thwuVGRXjTNSNbKLAHl5V2wcK0Tr2N7naRkeiK1bK9Z1VdOMwrKosh8Fdjfiy+3/RqXLH8mtXNbd2ujw3I40OVECqzKYBKPlVHn9Wj+/WpLbRorOjgq4RXNl1t8K2G0j8bY5Vp37un3zBtRabkar8/Y+ENirGCSZUZ3jRU+KaPZ0E1/gq1C6gSRiJ8KGykfJZzUYigLos7xWbSddq3jlndfVO9mnY8pv+dzLuqZ5fVrVU7wlOrhsDsPVm1vy6sMbswaDCVBRWdk8UhhevpLexjhX7tghMvF14ZEiulBw27dLjWXYV0wVMoaW+c5B6dG6c9kJpHezeD2DmHGdQDQ4rhbCUhv9tM0bYom2tOwqsakjqzF4i1baO4A5LQM5+k2FwcH+vgol495+pnlaMietj48V9dskB++AKXHoHhvCKYRNow1dGwEQCkYaGS3LkNFXja+byGufibxNARinWo3xt6DT9k0Na+xj5ycQ3HMrPe/5tUet9xwKYz1a7VK1Xi5c034SvTRZXr30/PDqQx2QuQtOdXcJrKzFlUBJONa1BrZOwO7uP2M3P2bxyJcbJhtAavKmgSPnr3aacYXwcuZHXiIy8qCH4tB+2iv62DsxHpyV8Tzcn3sVLjDtP5OcopubOjFlE9RGOJ38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3139.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(6506007)(8936002)(4326008)(36756003)(5660300002)(7416002)(64756008)(26005)(8676002)(110136005)(316002)(2906002)(186003)(38100700002)(6512007)(76116006)(53546011)(2616005)(85182001)(6486002)(71200400001)(54906003)(122000001)(508600001)(83380400001)(38070700005)(66556008)(66476007)(66446008)(66946007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE1KSW00dzAweG4rOFArTkxtYklEUVdrM3hJTmFZOGljQWxjdHJPcVhOU0hL?=
 =?utf-8?B?dHlxZnU5TnpCVm5RNStBYkJKWk9CUzl6VGRrRVFKUVdvcC9yYXNFam1SNkxH?=
 =?utf-8?B?VWJ5MzNnanlmZ2wya1ZkMzdDZFA2NzlybUFWSGt6eHJhcW5sQjYwdzQ1Tk9K?=
 =?utf-8?B?QWJraTNrVGxuUjJtRUQ4amNTNWIzWkNRSklGemRpdWtsVUlOM090b0lJZ2lJ?=
 =?utf-8?B?N1F4bWZCMEhIdWlFaHRtWEJRbFhpVkJpaWhhNUY0eUhnVXhtYnZBK1g5a3V0?=
 =?utf-8?B?SU1yamY0N3Z5UXVqU3JmdXFSSHFkbnlwQmxyZWZKTkhVYnhtamR4a2hmMG1J?=
 =?utf-8?B?bVltUUZHemNtMkVxMHhNVzdpWGRCaHc1R2dSYlIrZENPZk9ZczMzUVlGcDM2?=
 =?utf-8?B?V0tGYmpyb1NCaStvNGRFUGpTelJKWUtVR2N3emJqTXBoRTBKbm9XRFJYRDRz?=
 =?utf-8?B?RmNMWHVXcHRkT1I1d2o1Q2RQUDYrMEpqWXNmOERHTHlJT3kwN1pwbkxHaW83?=
 =?utf-8?B?V3lGZXJmMU1YYUdwa21KZ3hRUEx5T1AvdEkxS2J1dkJxSFY3dE5zTmZGbEZC?=
 =?utf-8?B?TG1NQW1tS2VTODdSZGs4aVpDd1VCcDVSd1BYNC9GMFczYUR3N3ozSUgrNUlJ?=
 =?utf-8?B?d28yMnBQb1pxQXBqcTIxeDlDK2JTcUxLcjlPWjU4bXVuZER3YmRVMnRpSVpK?=
 =?utf-8?B?V2RqU29MQmk3WWptaXJSV3gzdUZRejh2SGw5ZUNNNHVGL3B2SnI4dExZeGFj?=
 =?utf-8?B?azhhWGVsVW5LdEFOVHBISVY5WG1qYlYxWHhNVlRrUDZ0UG1IWkxDMnVGeldB?=
 =?utf-8?B?VGYxZ2VzQ3F5SXVDVVN0TGk5QmF3T2pwSjE4c3ZabjJqTEc4Zi9MUFhPeGF4?=
 =?utf-8?B?N1pITUZ3amJKQUp5RVJmWStlZktVcEJqdjdveXVMR2pQRnkwYmsvOUpTMkdk?=
 =?utf-8?B?TnB2OVNJUkJWbUg1ZHBmMjRhUTBtQVMrTnpWRCtrZGtIVVdLaGh0UGwxN1Ra?=
 =?utf-8?B?V0NScDFKZGdaTnNpNmJoUnUwWnZYWCtoZU5SQVk0SHBGeXdMV1Ftd0NTKytC?=
 =?utf-8?B?djNoVDIwRnNrbFVLaVlnck96UWxIc1krZjNmVSt6TjNFUVhadnlsVHRxY2w2?=
 =?utf-8?B?WitpMmE4azlyZmpUR1hEaWdYQUNJbE9TWGQvL1RNUi85djdJcGwrU05raUdF?=
 =?utf-8?B?ZnM2RHJ0YWE2WmszYkhJMDhIcnlWK0MxQndJWnNIZjd2UUFxVUdtTXcxYXN1?=
 =?utf-8?B?WG5XVnFoaG5qYWVJMFhZMXc1KzFuTG5aRkRCL2lTMHVkUURKNzdCYWJTVXE4?=
 =?utf-8?B?UnFQUkU5QnhwbUREMTMrMVhFQmZrQUwzZUJKakZVY0g3WDRjL1FrdStsMUM1?=
 =?utf-8?B?L0pxWG5IblN0dkdoRjVhRjVTK0R0d1NvZFRLa05VUUN0eUljVG84YUVDMGZx?=
 =?utf-8?B?R2dyLzZ0S3AxS0JIVys5aVVieUt1WFlxdE8vdno2cEFxOTRUUTNnWGU1MzU3?=
 =?utf-8?B?TUR6Q1BoTXNiTVZaWjNVN0RxYTU2Yll0WnV2VWI0QW5MQkc1M01XZEVnNCth?=
 =?utf-8?B?QWJtbUhidWpYTHg1aWdaY3JJam9HRjdpaktTdG9DVmUwVGh2Y3BUaW5rVHBo?=
 =?utf-8?B?UUZjeG85dWcvMENGeFd6VDMvSEpLbTJBYVNhOEljRE1uUDBsSWNDRnZHL0kr?=
 =?utf-8?B?Uzk0a1l0Y0lQY0NiY2gwQmlWZ1pQQlE4eks0R0o4UEFYRnphSEd0bVUxVGF5?=
 =?utf-8?Q?qIFxWq2sCrJRtvvC+ZxUKKfFriLP1dZCQ7Ke/gX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F805D9607951246BE421B3EF4D3E1A1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3139.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc40bb0-fe2f-4c25-b69c-08d962d3071d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 05:34:34.5915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxegxedq2MzOIRd7FYu7LDx5ENlqBQ7ybOrRNzFswpOLBj1Ce6XqadWt6FLbgxzPOLjDKhN2I+iT9gOvFNyUaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0302MB2499
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTE4IGF0IDIyOjQxICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxMC8wOC8yMDIxIDEwOjA4LCBZb25nIFd1IHdyb3RlOg0KPiA+IFRoaXMgcGF0
Y2hzZXQgbWFpbmx5IGFkZHMgU01JIHN1cHBvcnQgZm9yIG10ODE5NS4NCj4gPiANCj4gPiBDb21w
YXJpbmcgd2l0aCB0aGUgcHJldmlvdXMgdmVyc2lvbiwgYWRkIHR3byBuZXcgZnVuY3Rpb25zOg0K
PiA+IGEpIGFkZCBzbWkgc3ViIGNvbW1vbg0KPiA+IGIpIGFkZCBpbml0aWFsIHNldHRpbmcgZm9y
IHNtaS1jb21tb24gYW5kIHNtaS1sYXJiLg0KPiA+IA0KPiA+IENoYW5nZSBub3RlOg0KPiA+IHYz
OjEpIEluIHRoZSBkdC1iaW5kaW5nOg0KPiA+ICAgICAgICBhLiBDaGFuZ2UgbWVkaWF0ZWssc21p
IHR5cGUgZnJvbSBwaGFuZGxlLWFycmF5IHRvIHBoYW5kbGUNCj4gPiBmcm9tIFJvYi4NCj4gPiAg
ICAgICAgYi4gQWRkIGEgbmV3IGJvb2wgcHJvcGVydHkgKG1lZGlhdGVrLHNtaV9zdWJfY29tbW9u
KQ0KPiA+ICAgICAgICAgICB0byBpbmRpY2F0ZSBpZiB0aGlzIGlzIHNtaS1zdWItY29tbW9uLg0K
PiA+ICAgIDIpIENoYW5nZSB0aGUgY2xvY2sgdXNpbmcgYnVsayBwYXJ0aW5nLg0KPiA+ICAgICAg
IGtlZXAgdGhlIHNtaS1jb21tb24ncyBoYXNfZ2FscyBmbGFnLiBtb3JlIHN0cmljdC4NCj4gPiAg
ICAzKSBNb3JlIGNvbW1lbnQgYWJvdXQgbGFyYiBpbml0aWFsIHNldHRpbmcuDQo+ID4gICAgNCkg
QWRkIGEgbWFpbnRhaW4gcGF0Y2gNCj4gDQo+IFRoZSBwYXRjaHNldCBsb29rcyBnb29kIHRvIG1l
IGJ1dCBJIHNhdyBub3cgY29tbWVudHMgZnJvbSBSb2IsIHNvIEkNCj4gZXhwZWN0IGEgcmVzZW5k
LiBUaGVyZWZvcmUgdGhlcmUgaXMgYWxzbyB0aW1lIGZvciBhZGRpdGlvbmFsIHJldmlldyAtDQo+
IG1heWJlIGNvbnRpbnVlZCBieSBJa2pvb24gSmFuZz8NCj4gDQo+IElmIHlvdSBzZW50IGEgdjQg
d2l0aCBmaXhlcyByYXRoZXIgc29vbiBhbmQgZ2V0IGFjayBmcm9tIFJvYiwgSSBjb3VsZA0KPiBz
dGlsbCB0cnkgdG8gZ2V0IGl0IGludG8gbmV4dCBtZXJnZSB3aW5kb3cuIEFmdGVyIHRoaXMgd2Vl
a2VuZCBJDQo+IHdvbid0DQo+IGJlIHRha2luZyBwYXRjaGVzIGZvciB0aGlzIGN5Y2xlIGFuZCBp
dCB3aWxsIHdhaXQgZm9yIHRoZSBtZXJnZQ0KPiB3aW5kb3cNCj4gdG8gZmluaXNoLg0KDQpIaSBL
cnp5c3p0b2YsDQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIgaW5mb3JtYXRpb24uDQoNCkl0
IGxvb2tzIHRoZSB0aW1lIGlzIHRvbyBzaG9ydCB0byBnZXQgUm9iJ3MgYWNrIGluIHRoaXMgd2Vl
a2VuZC4gSSB3aWxsDQp3YWl0IGZvciBvbmUgb3IgdHdvIHdlZWtzIHRvIHNlZSBpZiB0aGVyZSBp
cyBvdGhlciBjb21tZW50cywgdGhlbg0KcmVzZW5kLg0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCg==
