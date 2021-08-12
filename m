Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0FE3EA404
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbhHLLuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:50:25 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:57748 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235158AbhHLLuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:50:23 -0400
X-UUID: 85947105067745e6ab66afbaa4ad5a7b-20210812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ADihbeCGeoQXY+9ooNXg1ZjGgsap75vw0THfuq9UeTM=;
        b=caBZ3ns77T92L5ERFurzGdj+dXhqsliPeNbaZqnNuGyUKJ1YB6n8LLhYU+hYSTyK/jKX71gVbvjwEVAeqJ2wZethqQf/ZZtI1tMHQo3kIc4Yx8C/7rhS/HnNmn1RQvaRd6ScZ2S0KYYCoo2n0yte31DySNB35NfSixsDPMCo5uQ=;
X-UUID: 85947105067745e6ab66afbaa4ad5a7b-20210812
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1737639442; Thu, 12 Aug 2021 19:49:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 19:49:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkcas07.mediatek.inc (172.21.101.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 19:49:52 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 12 Aug 2021 19:49:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIS9sGfoi2SmKNb3/xhuRwB810l/j0vVbs/BrsE3xbHp0YrR+87Mv8LfItl6nxlioB57w6xdl/A+sTiv+8UWd01xr4YSXyLLjB9FkADHBMtOjpgtxRz4Ft8iYnW3lcoCGX8oB25O8dOZrxxEUdksdwzOwt00GoECTK0BM4KDQ8jCJELKtSAdKzlHh2XhFbZkGQWNwIyRe/5PM5tOw4FV7nu3Pd6W7WCuTQgf0/KgPBWSWCdyPVEUNdSmyZhT0MfvAIQUee0okz/OaZeXC+jjddyWg45QemlGMiCkwatyssZATKHQsEixAEmKtv/ukl1bc1dapT7PZOzpFLlBcONwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADihbeCGeoQXY+9ooNXg1ZjGgsap75vw0THfuq9UeTM=;
 b=cpWCK/ZKpYp+zov1ajQyEQTNRr/M2KvG56edGno9I6Q1tSVRhgXes4v5MTwEf6bqUtKLwwZhgMc89Yx1WNit1uSloq22OZ3rBEGWXzpSVNFEjFphmzmmm8K5nrsJLrUwFEBKmC1fLzJGE1obFQyMREEfh5LyASL5JfNcyQb/XU4uK1PDSHav1nxyDzTrgb/HIgfyZTgp3X83F3pNkpXXvUCRBuYLj8XCedyi9vxOG0B3TcA0L3VJi9ZeQVbvcQHTQWbPZJ+KwFGCRDbhYZcwHnGMH1kRWY/1SXUub97MyNRqoLJw1BFOB1q9EG7xoySwcYPD0RWhe/a1k4HBLSvXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADihbeCGeoQXY+9ooNXg1ZjGgsap75vw0THfuq9UeTM=;
 b=NaUDTsNVlu/LmEHvNmezE5rdA9mtgZ5DVTcU1WNoDqSXWE50UiB1VbECZdgWJx/VjUkevBp0Ruy/U9NlHQB3uSmXLvqrERNan4ZDLvkSm1MR2zP1H9OjXqH+AopELtZINFZFCp/RnpYJZveXluACyESfa7W1oUBxdsZGXzNnC9k=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KU1PR03MB2902.apcprd03.prod.outlook.com (2603:1096:802:25::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.7; Thu, 12 Aug
 2021 11:49:39 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 11:49:39 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: xhci-mtk: handle bandwidth table rollover
Thread-Topic: [RFC PATCH] usb: xhci-mtk: handle bandwidth table rollover
Thread-Index: AQHXjPzqwpeGZOWapUiNHdL7bl5Aqatq4ykAgAAIfYCAAxloAIABmrOAgAAmhgA=
Date:   Thu, 12 Aug 2021 11:49:38 +0000
Message-ID: <efcd999aaf83cf73ed2f4f4b9efa1bb93efd2523.camel@mediatek.com>
References: <20210809165904.RFC.1.I5165a4a8da5cac23c9928b1ec3c3a1a7383b7c23@changeid>
         <YRDxTodNNqtnpPpn@kroah.com>
         <CAATdQgDSCzZtiDSQk94CYHfSb9Mq28OH7-RdaTZNv3oPrW3nkQ@mail.gmail.com>
         <7b48f4c132a8b4b3819282e961fbe8b3ed753069.camel@mediatek.com>
         <CAATdQgD1paUUmWhiLVq-+zq0V6=RTJw89ggk=R6cBUZO+5dB-Q@mail.gmail.com>
In-Reply-To: <CAATdQgD1paUUmWhiLVq-+zq0V6=RTJw89ggk=R6cBUZO+5dB-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5df701e0-f9fd-41de-a65d-08d95d874407
x-ms-traffictypediagnostic: KU1PR03MB2902:
x-microsoft-antispam-prvs: <KU1PR03MB29024E7ED0467EB9DDCA600EFDF99@KU1PR03MB2902.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +w8VL2D026Uooxe5Wd8fvyfMCbmnY4b59wg0fG81E3oadbKrLl/lOQ4Xm8J1tcXgLzQsfCbM54ttEG1IuwCP1YXH7vryPQAjWr2kEwxRj5YQ0i1vkYy3sbpX6L9Thbe1NqWdMD4KOJEhldpbYn9h7FkBkoAxRVfrFXTuRtycPDsLHJlXeNEddQnMyaBAnMEQODOFKrX4r9es+PX0yQHxaWd215v9hBzzQZISzK+MeCVER5D2P/7iuIoKY+tcHQAYo45UZx4C79hwGBqEaRTpcU2VbLsJfbtNVvQu7Rs34vOCqAjA7tUcSg6M1jAsz2jxJdFcbKdm/QaQz3V6VSyag0z+1p0KfejG/vxIMInLva0bCThNoKYzj8jgelqFuj0wkfegpF7dC1Njt/iv7MkS48TmRHdE7IxJ0WhIau6cZ0KkzrwfkQc9QUbOMAKnH3+L2KoVUHfXy0fb5ODdjFbFc6VFJASp6mIsLc+rlYur+m6HPHwEvIbbwAUKDBp5ETwZ/Xh0PVXZfA8Y07/PTAgsIa/iOAluWHPZaakTYC3Vzr+9O4VIKUHJcLr9a0UmvMtbteHI445wQ8FWQD5JL/T3mfOVXDm8BVDCTLTx04iauxfRpaTNC+wH/rEJS8oXzpz2qA0vuWLAVrrrgUw8wfuGN+LIwM3FyiZ3ORp7qmpndS5Bo1YOX5GMQaxPxV78HRHYrLoeKda26uqZ7XEB5cCVVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(2616005)(6506007)(186003)(316002)(66556008)(6512007)(8936002)(76116006)(85182001)(66946007)(54906003)(6916009)(66476007)(4326008)(26005)(53546011)(8676002)(91956017)(71200400001)(508600001)(6486002)(38070700005)(122000001)(5660300002)(36756003)(2906002)(38100700002)(66446008)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWtqaEYxTXN3cVNtd0Fzd0VORTdNREdRazhLaTFINFVMSWYxbjZhQXRkVmU4?=
 =?utf-8?B?bElESGZ4WGd4TjZocmFLL1pXeEl2eHJxYU1VRzdpOEU2S1ZsMi83b2Q4Rk9j?=
 =?utf-8?B?NWNMLzMrMFBQUUpvRFNSbWk1NjRiTlpxNnBib0FEQVRqYTVMNDFuemJCbnBG?=
 =?utf-8?B?dkEvV1NVeGNKaVpRT3NmRThPQjFPQSt2RGhmWWVja1Z4WjZidEZNK2FVU1hq?=
 =?utf-8?B?cEpVQnVGV2JhajNwY0dtYlpZMkViYlRSOEY0aTF5YTBVZXBsdHZ3dVY4d2dn?=
 =?utf-8?B?S2hrbXdFUVVXcnJIOVY2a3AvQlFjdEJsK293WUpEMDNTTWJ5OUxXR2FrVUg0?=
 =?utf-8?B?NWVMR0JxcjZnME4weG1PMlRRL29Wemh3MVkzcUZLeWhNNVNwNUZLdU5Dd0N1?=
 =?utf-8?B?d3BVMWROdjhoMEQ5amhLRGdDM1lOdVlBOG13SEdOZmRBQmhwVVoyaWJNeHBP?=
 =?utf-8?B?Y3JVcXZDOUl1SmlhZ3ZSZnhEeXJMSnUrTThwZUl2Q2VLdVFEaVY3VWtyanNG?=
 =?utf-8?B?OUlMVHd0WDhtZGYxWjdBbTNJOWR6UXlLZEZWckhxYXRVVEllNDJTUVBmc1R2?=
 =?utf-8?B?cnVudjlWRHRDRi94ZWxtMEt5elMxTkp4UHNjSWFmd25QR3o4MVl0WGZmWngz?=
 =?utf-8?B?TVVPVlBqYUx5cHB1RTFCb1p2cTlicnNBQ1hFZDAvdjludUpMNTJONkMwcHdi?=
 =?utf-8?B?alh6VUZYK01MWmhnL3RHOTN1WTBtdzBBQnhBTG1BMElaSkxpSGNsQkZRR0pj?=
 =?utf-8?B?RkpBamZ4UnlVRHo4cDdVeVBoTnJlalBLcUxxUUpuZFlxL1lWUUNDUEhxTGps?=
 =?utf-8?B?Z21ZS2NldU9nNVRRcVJTR01wNW1mb0dLaVVqeEx6SlZmR2tXL25TRjdYMGhl?=
 =?utf-8?B?a1pGOVdUeXJMQzhQQkthclZ0eVNOZ2dRUDFUVkFCVkVRejR2VHZobCtNK3Bl?=
 =?utf-8?B?SGtveUNMbCtOWHlISUFURWgrMk5tdnZtT2VtbC9qZnVOUGluSU5Zc3ZxT1dW?=
 =?utf-8?B?bXFyRnZpVy9qN1N1YlREQzJScGFNYVU3T1ZWSDYvMTI1T25sRWw1eVJWN3Qw?=
 =?utf-8?B?N0g3eXpkQ2ZaOW00cXNuRHJsUVZNSnduaGY1TCs2aGNkQzg4QVBraittella?=
 =?utf-8?B?Mkg3VlNUT0FNMWNYd0hLa25yTlErRzJURC9kaXNGMGZicVlHYVNHREQyRGFo?=
 =?utf-8?B?TUErQS84NnRhMnZxd0o0L1BRQnoveFQxdVhDNytVZlVYcGpRR3dzYnJzUCtq?=
 =?utf-8?B?WXpqYkJxMUtKQmFGcDgyZW9NSDk0QWtpSXZRTnNucG5ZeWxRUXZyK2lnS29y?=
 =?utf-8?B?VHM3OG5UU1lRVHI0S3JVMXUzaFM5eWlMdElZWEJFSnhmSDV1ZHpuQUZxcFFM?=
 =?utf-8?B?c0k4enQwVmZOdDRBZ01zRWk0YTQ4NTgyYVFaV3IwVDFkeFV6eWJuRE5hSThy?=
 =?utf-8?B?cFNETWtnd3hDck1mNVdpQXpJaWliQmh6cmNOU2szb2VkblBFRDhjREhWajVB?=
 =?utf-8?B?ZWVPZWd1ZUQyYjMvbWRnRSttRVhZUmJyRFhQcnBHWGlja1lMOUJNNldtQUZh?=
 =?utf-8?B?MStWZE1YbjRrTTl4cGxhaG9IRWRQZUdXNzlhT3AwNjQrblNDNC9SNXo3TGZX?=
 =?utf-8?B?MStDcHVKMEQweFZjMTg5VkhmNXczSXFoUEtPa0xXQlFjbjFIMUZQWXl3Mk1I?=
 =?utf-8?B?cGVIcUdxbzlrVVczUzB1bllRVitYK1BUUFdueU9FcmxZSnV5VTZMUHNyVUVI?=
 =?utf-8?Q?s6cCHAsN0+ymmAALGXIDpzX3fIRkZpaj+2H96Fv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F55E41A1AF68644AA67AC29CD9EF2D63@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df701e0-f9fd-41de-a65d-08d95d874407
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 11:49:39.0487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McE3ogi5MhKSFllEuc5aBZ4XrjDaTcHdT4gKfZ/yezHOn9AQXjeyJgWH9QC2eynP/5c89MZ6x0WAadQ5y+pYdWF89upGDh4Oxa78YaAdWMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1PR03MB2902
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA4LTEyIGF0IDE3OjMxICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
SEksDQo+IA0KPiBPbiBXZWQsIEF1ZyAxMSwgMjAyMSBhdCA1OjAyIFBNIENodW5mZW5nIFl1biAo
5LqR5pil5bOwKQ0KPiA8Q2h1bmZlbmcuWXVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+
ID4gT24gTW9uLCAyMDIxLTA4LTA5IGF0IDE3OjQyICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToN
Cj4gPiA+IE9uIE1vbiwgQXVnIDksIDIwMjEgYXQgNToxMSBQTSBHcmVnIEtyb2FoLUhhcnRtYW4N
Cj4gPiA+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+
ID4gPiBPbiBNb24sIEF1ZyAwOSwgMjAyMSBhdCAwNDo1OToyOVBNICswODAwLCBJa2pvb24gSmFu
ZyB3cm90ZToNCj4gPiA+ID4gPiB4aGNpLW10ayBoYXMgNjQgc2xvdHMgZm9yIHBlcmlvZGljIGJh
bmR3aWR0aCBjYWxjdWxhdGlvbnMgYW5kDQo+ID4gPiA+ID4gZWFjaA0KPiA+ID4gPiA+IHNsb3Qg
cmVwcmVzZW50cyBieXRlIGJ1ZGdldHMgb24gYSBtaWNyb2ZyYW1lLiBXaGVuIGFuDQo+ID4gPiA+
ID4gZW5kcG9pbnQncw0KPiA+ID4gPiA+IGFsbG9jYXRpb24gc2l0cyBvbiB0aGUgYm91bmRhcnkg
b2YgdGhlIHRhYmxlLCBieXRlIGJ1ZGdldHMnDQo+ID4gPiA+ID4gc2xvdA0KPiA+ID4gPiA+IHNo
b3VsZCBiZSByb2xsZWQgb3ZlciBidXQgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gZG9lc24n
dC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGlzIHBhdGNoIGFwcGxpZXMgYSA2IGJpdHMgbWFz
ayB0byB0aGUgbWljcm9mcmFtZSBpbmRleCB0bw0KPiA+ID4gPiA+IGhhbmRsZQ0KPiA+ID4gPiA+
IGl0cyByb2xsb3ZlciA2NCBzbG90cyBhbmQgcHJldmVudCBvdXQtb2YtYm91bmRzIGFycmF5IGFj
Y2Vzcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBJa2pvb24gSmFuZyA8
aWtqbkBjaHJvbWl1bS5vcmc+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
IGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMgfCA3OSArKysrKysrKystLS0tLS0tLS0t
LS0NCj4gPiA+ID4gPiAtLS0tDQo+ID4gPiA+ID4gLS0tLS0tLS0NCj4gPiA+ID4gPiAgZHJpdmVy
cy91c2IvaG9zdC94aGNpLW10ay5oICAgICB8ICAxICsNCj4gPiA+ID4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCAyMyBpbnNlcnRpb25zKCspLCA1NyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+
IFdoeSBpcyB0aGlzICJSRkMiPyAgV2hhdCBuZWVkcyB0byBiZSBhZGRyZXNzZWQgaW4gdGhpcyBj
aGFuZ2UNCj4gPiA+ID4gYmVmb3JlIGl0DQo+ID4gPiA+IGNhbiBiZSBhY2NlcHRlZD8NCj4gPiA+
IA0KPiA+ID4gc29ycnksIEkgaGFkIHRvIG1lbnRpb24gd2h5IHRoaXMgaXMgUkZDOg0KPiA+ID4g
DQo+ID4gPiBJIHNpbXBseSBkb24ndCBrbm93IGFib3V0IHRoZSBkZXRhaWxzIG9mIHRoZSB4aGNp
LW10ayBpbnRlcm5hbHMuDQo+ID4gPiBJdCB3YXMgb2theSBmcm9tIG15IHRlc3RzIHdpdGggbXQ4
MTczIGFuZCBJIHRoaW5rIHRoaXMgd2lsbCBiZQ0KPiA+ID4gaGFybWxlc3MNCj4gPiA+IGFzIHRo
aXMgaXMgImJldHRlciB0aGFuIGJlZm9yZSIuDQo+ID4gPiANCj4gPiA+IEJ1dCB3aGVuIEkgcmVt
b3ZlZCBnZXRfZXNpdF9ib3VuZGFyeSgpLCBJIHJlYWxseSBoYXZlIG5vIGlkZWEgd2h5DQo+ID4g
PiBpdCB3YXMgdGhlcmUuIEknbSB3b25kZXJpbmcgaWYgdGhlcmUgd2FzIGFub3RoZXIgcmVhc29u
IG9mIHRoYXQNCj4gPiA+IGZ1bmN0aW9uDQo+ID4gPiBvdGhlciB0aGFuIGp1c3QgcHJldmVudGlu
ZyBvdXQtb2YtYm91bmRzLiBNYXliZSBjaHVuZmVuZyBjYW4NCj4gPiA+IGFuc3dlcg0KPiA+ID4g
dGhpcz8NCj4gPiANCj4gPiBXZSB1c2UgQGVzaXQgdG8gcHJldmVudCBvdXQtb2YtYm91bmRzIGFy
cmF5IGFjY2Vzcy4gaXQncyBub3QgYQ0KPiA+IHJpbmcsDQo+ID4gY2FuJ3QgaW5zZXJ0IG91dC1v
Zi1ib3VuZHMgdmFsdWUgaW50byBoZWFkIHNsb3QuDQo+IA0KPiBUaGFua3MsIHNvIHRoYXQgZnVu
Y3Rpb24gd2FzIG9ubHkgZm9yIG91dC1vZi1ib3VuZHMgYXJyYXkgYWNjZXNzLg0KPiB0aGVuIEkg
dGhpbmsgd2UganVzdCBjYW4gcmVtb3ZlIHRoYXQgZnVuY3Rpb24gYW5kIHVzZSBpdCBhcyBhIHJp
bmcuDQo+IENhbiB5b3UgdGVsbCBtZSBfd2h5XyBpdCBjYW4ndCBiZSB1c2VkIGFzIGEgcmluZz8N
ClRyZWF0IGl0IGFzIGEgcGVyaW9kLCByb2xsIG92ZXIgc2xvdCBlcXVhbHMgdG8gcHV0IGl0IGlu
dG8gdGhlIG5leHQNCnBlcmlvZC4NCg0KPiANCj4gSSB0aGluayBhIHRyYW5zYWN0aW9uIChlLmcu
IGVzaXRfYm91bmRhcnkgPSA3KSBjYW4gc3RhcnQgaXRzIGZpcnN0DQo+IFNTUExJVA0KPiBmcm9t
IFlfNyAob2Zmc2V0ID0gNykuIEJ1dCB3aWxsIHRoYXQgYWxsb2NhdGlvbiBiZSBtYXRjaGVkIHdp
dGggdGhpcz8NCj4gDQo+IC0gICAgICAgICAgICAgICBpZiAoKG9mZnNldCArIHNjaF9lcC0+bnVt
X2J1ZGdldF9taWNyb2ZyYW1lcykgPg0KPiBlc2l0X2JvdW5kYXJ5KQ0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCj4gDQo+IEkgbWVhbiBJJ20gbm90IHN1cmUgd2h5IHRoaXMgaXMg
bmVlZGVkLg0KUHJldmVudCBvdXQtb2YtYm91bmRzLg0KDQo+IA0KPiBVbnRpbCBub3csIEkgY291
bGRuJ3QgZmluZCBhIHdheSB0byBhY2NlcHQgdGhlIFVTQiBhdWRpbyBoZWFkc2V0DQo+IHdpdGgg
YSBjb25maWd1cmF0aW9uIG9mIHsgSU5ULUlOIDY0ICsgSVNPQy1PVVQgMzg0ICsgSVNPQy1JTiAx
OTIgfQ0KPiB3aXRob3V0IHRoaXMgcGF0Y2guDQp3aGF0IGlzIHRoZSBpbnRlcnZhbCB2YWx1ZSBv
ZiBlYWNoIGVuZHBvaW50Pw0KDQo+IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGFua3MhDQo+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+IHRoYW5rcywNCj4gPiA+ID4gDQo+ID4gPiA+IGdyZWcgay1o
DQo=
