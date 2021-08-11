Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6733E8B42
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhHKHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:55:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41994 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233850AbhHKHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:55:03 -0400
X-UUID: 9efe5504eb6b425ab02a4f0e818f6d99-20210811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Qa1mZmyveRrQar9gJBvhkndGuAICeJ8a1JAoOHitSTU=;
        b=rJj4XIQHteexggCGYbrWQXoQgxzKh5Sv0ZuMdYmnO88yQt0UEoKMTifb7nX7YZOtEhCZD931YKrSHpogPeSWTdlke45BEYR3wrteFu/iP8jktlzU/+sWH/qXWA2B+Y+bZDVatcewt1+XVJzi769d4UVQWon/ePjDTNSP+K2rOks=;
X-UUID: 9efe5504eb6b425ab02a4f0e818f6d99-20210811
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 824003787; Wed, 11 Aug 2021 15:54:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 15:54:34 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Aug 2021 15:54:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKp3gnuD/3QOrJXtdMrn1THI7898OKyeCWaxc571fPpK2OvlxCr9vHYocA7aVGB27aGtdZ8CQdHtwL3vNsG27McFGColtOEzKloI1adk/9wTjTaMZ1CW6TZCI5ZZjRaofBzAHJNeQokSmPjA0qj2oX3NzTs6SCp7GL9/5JKvKX6vZkro1DBCNB32/wapK3eROp85nkJ8ageNV+KoftnAs9cGUDWq9EBkq4Gm+Y4XpXONRfn++kQoQD4rFEEIog9NR8e6ODsG7sKV0x7zynlb5JvO+cY3ARGNpb+OAitG+Ww6wRYb7abCei1mkD/UlCKSgU25lGbDJwqXT2N6A1vwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa1mZmyveRrQar9gJBvhkndGuAICeJ8a1JAoOHitSTU=;
 b=b1+BdfGd0QejKo5EnS770gYUMgGGCwLf7GVZh09W09AqZGfvNXZ/rb2sa+Tuy9ZkdGApSt46E6uyMzQtxg2DgJaRgsVFNjR4xXE9pxnIN72WfQLYNiUl7ljr4t12ssi8cjUA9YbUssRF4iHJa+issuP2hGGECfL1fhtvLLdtMoxVNUzW10DvSD5WLaVbHJeFMwSaUBaQ5YQezZmuWAQJDAj/hGX9W5voOenWolTrz/K/+8LU2b1CJJogbcvb4/0UTa5xC0fmcx/ckgmfzkyMtze8zhwA24ihCXtn0U8tTEfxcD5oLFSkTjsTjxf0gXJaVQO1y8atG9s7r3rZ+sCXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qa1mZmyveRrQar9gJBvhkndGuAICeJ8a1JAoOHitSTU=;
 b=O0lFvf44yMbs5FOfadmkYbIO5jpxuTGtsuuW4Lcue2afrS4PfwLXchTjoiIt0hbddJELHIcH95/WK8onyOcM2YF2bEX4Bm+1YLnDynqifIECBY2XLvcS8UeTO8Q1WNULNC5qZQ/J5K/YrPBHYjKjL0SoI1Z2qm989ikeNzb/GGM=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KU1PR03MB2711.apcprd03.prod.outlook.com (2603:1096:802:29::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.6; Wed, 11 Aug
 2021 07:54:20 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 07:54:20 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: usb: mtk-xhci: add support property
 'tpl-support'
Thread-Topic: [PATCH 01/11] dt-bindings: usb: mtk-xhci: add support property
 'tpl-support'
Thread-Index: AQHXhR/4fMl3EMN3dEGb/VVeJQbwbqtm+4mAgAcGZQA=
Date:   Wed, 11 Aug 2021 07:54:20 +0000
Message-ID: <35e5467d8784d32ad765a6d3b3a07c3d183dc77d.camel@mediatek.com>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
         <YQ2dkcKiXxIHLCOT@robh.at.kernel.org>
In-Reply-To: <YQ2dkcKiXxIHLCOT@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 879a009f-e109-4728-6829-08d95c9d3a4d
x-ms-traffictypediagnostic: KU1PR03MB2711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1PR03MB271127BC10F9DE05240BD26AFDF89@KU1PR03MB2711.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxwNEhv6OKJF9/RxpsPhSQKySX3qU5sxK1OARVfPTiGv5R1z4mK9cSwu5h7KhTE8wRTekjhsgDCJlY7U+I9Ug3jXWp6vrN4nowIbrs6/P7XjASgZsglPDGgKEWW6oOSRWoqjJIMlVplGVbMqR62WB8RJQasbu2ycxbMLvIaj0e9qwkiGIb+pUf1zM3iS8B6VBjq40tww0eUy38OhnRiAp7X4e4diMaHgWkohqNl84qMAg2wrI2lZe4+NPF8YZcnrIti11FSqt2t90kjfXzLLN6R6rmQLHMPwlzsa+Mx+5KaGoUy8frKTGDAagso8Gc79Fo19PWYf+t9yhzq+/cW6v0etcGTSNU+DViu/VCDLLEtZmSzREgjGYWmgMZLfYR4K46/YTv2O2il+nsVhP2mEgvE6beyxYQhMqGRxZrzoYhw49kKet2TTw9lcY4+kIHZ10QLf8sHJ+fXIDtIblvwpvGUwmydUWFAwwHT8WE3IUFy4avyRIafTpuiw7YHHs7SvjWDPRN/BmyTMmuYmmVmgC+wT3tn5NLa/Pw86NHo+p/h7GdGQXbR6KsgKWdjxTI5dRaa+I2HoR2Do5pfse0Z97hxXudkgZrE+LW5XVSOnGLofQGgDAaykYenemIlEQ1Y04W2QV676SsFwTr1+lVzfitb21JrAcZcjA1cw1RCFRSzZqD8JUCCmqDDZgNldzFcgOyWOvLAlC+whuR0kLdGR1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(6916009)(54906003)(498600001)(2906002)(122000001)(38070700005)(4326008)(83380400001)(2616005)(85182001)(8936002)(6486002)(71200400001)(66946007)(36756003)(186003)(38100700002)(91956017)(76116006)(6512007)(26005)(66556008)(64756008)(66446008)(66476007)(5660300002)(8676002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW1ZL1BKeWZFMUxKU282MjM1Q2FsMyt5U3o1NzM2cnNDTWY2UDlvUk9QdU1G?=
 =?utf-8?B?M2lqUVAzYnZ4RVBSeDBMOWtrMDROTm15S20wVTRlZXNGWnE4T05aa2ZKQlU2?=
 =?utf-8?B?aENSRFFsenJnSEErSTlOTGd5ZDRFdlhLSTBEOU5HSldPeEhWZDNoNW5id0lu?=
 =?utf-8?B?QzhKaDc1b0NUamdsaUtiUkVHc3dLZEZicCtDZnJ1RmZBckY3V3hXbzBFa3Rw?=
 =?utf-8?B?dEJDbGNiMXNyenp0YzNwZGNBN0xTRU5Gb2hDVjNrVjBwQUo1dlFOTjA3VEJh?=
 =?utf-8?B?KzhiMVlCaC9rSS95TnEvNW9XTFJ6aDZZMjNDZlNQRmI0RTFpVlBYMWwvVk5W?=
 =?utf-8?B?Unp5NEFMMk5sSDhGbnhBWEkwVnM4aU9IVjJUSUF3Q3Z0WHp3S0lrbGMvT05T?=
 =?utf-8?B?bVowaHpyRHRSQzlRSWlRbUVURlIrblFEbmNSWG12N0pwbnlWZ0J0bHBSTVJB?=
 =?utf-8?B?OVdmRWtsMEMwNFB1SXBWU1BQR1BYTTM0c1JKVEM4TEkvTHFhL3RGak5wTWFs?=
 =?utf-8?B?akh2UW9HeXk5QkgwNENVYUM2dWV3REJXVFpsdW9iekNoZUl4aHBJNnRoYkx6?=
 =?utf-8?B?elNObkQ0ZTBubm10U0lwcVdBVHpUb3dlaHRzQzcwaWdpelRkdXRTbG9ZZEsv?=
 =?utf-8?B?TTBRamJCb3NzYnhucWtKSUFINFNmYTdnbzlDU2l6eGRjanZ0dEs1V1czNW5t?=
 =?utf-8?B?UUhxZXVpTjRrd0hvdXBMbzVVTUE2NWlYdzlyM0lob3hLb2pPUCtDdjNrb01S?=
 =?utf-8?B?MHpNejBrblZTR2ZINmNsTHRQT0dHWmVEcTIrN3V5TmEzcXQrbVpCZWVOWXhu?=
 =?utf-8?B?Rk1LRmJIQ292V29URlFZU042bGFEWTZkNlFTNlVKa0dPM0RuUGFiZ3pzbHor?=
 =?utf-8?B?Zk9YaWw1cXRQWDJ4UjZGSkxocUxpdEZDTG5HMWU2cjh4MkgrR0N5V3RkNUJD?=
 =?utf-8?B?aDg5RlJZVVZDOGhFWGhUUkp0TVQvYnU5SDVwL3VrOG9MYW5PUFE3RkwweDBC?=
 =?utf-8?B?NDlXRndJVDgvNWM1NmNPeFBsT3lBY2Jhb1JrTURhKzVWTGlGY2pieHA5RVVI?=
 =?utf-8?B?ZzI5N1c1WjFMV21vck9VbE81MFpiSW1iMDFjQnRIeENtaWRhRjV4Y3I4VkdU?=
 =?utf-8?B?eFB5azVCUEJuaFV4RGhIeWdKWDI3WnErQWU4REUwLzdybGxlU2NEWnE3Rzgy?=
 =?utf-8?B?WE5rZGRuajltczNUSGg5SEtseHJnNWFCS2EwdnU1b0pIeFBKREhZTjJjUGZx?=
 =?utf-8?B?di9UUXJhSnBtL1VYMk0xaFVUV0lJUzlSaE9TOGpldmZtUUppSkswVkU5MGNO?=
 =?utf-8?B?Mkk1TjVqLzVaR1NXYmR4MWVDbmNOeVd2MWZkS3JEWVRacUxyWUZpSjNSSnBa?=
 =?utf-8?B?bGFwLzJIOHlweElCZ1hKV24yOUZuWG1kT3ZscEM1b1RHaHJhVzE5VW1zMlhq?=
 =?utf-8?B?R2pGUUh2VEVWdmlOUkwvbUhMNTFqVXRFdXV3Y0FhRGFlUUpJaWxhVUpuTHRE?=
 =?utf-8?B?b0pkV2hmbUlJM1JTOE5sbGVNZGRvcHhqQlVRNzQ5Zkk1bVdLYzlFczRLNmdH?=
 =?utf-8?B?QUFyWnlSTmQreHNxMDJGcmV4RFRqV0s4NTE4Q1pCTm80SElLR241QmhnelZZ?=
 =?utf-8?B?d0tGaVArTGVnTjZqbW16NzFsSWpnLzNsMUhNbE40WVR4cW9WbTkzWi85WmU5?=
 =?utf-8?B?S01hbEM1ZG1qbmVNaXYzZFlvWm9QdmRrYkNSeFVJRm92MTdlcWQ2Q1l6L2ww?=
 =?utf-8?Q?P89GnfYNDjXov9bZD/iT1BRvEPsEugueUuKKu1m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC2A28965A02B143B6C67761B16E160D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879a009f-e109-4728-6829-08d95c9d3a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 07:54:20.6138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nA2xKF10v4L59lNQAp/GVlTy4yc2NxFyS9HvATVyXuOFCBTEn3d86WxBhjQGl8OHZyyzwAT3UQP36wqANQaERqsUP/c/qvq+VXtFJRvEvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1PR03MB2711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTA2IGF0IDE0OjM3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCBKdWwgMzAsIDIwMjEgYXQgMDQ6NDk6NTJQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IEFkZCBwcm9wZXJ0eSAndHBsLXN1cHBvcnQnIHRvIHN1cHBvcnQgdGFyZ2V0ZWQg
cGVyaXBoZXJhbCBsaXN0DQo+ID4gZm9yIFVTQi1JRiBFbWJlZGRlZCBIb3N0IENvbXBsaWFuY2Ug
VGVzdA0KPiANCj4gR2l2ZW4geW91IGhhdmUgdG8gY29uZmlndXJlIHRoZSBUUEwgc29tZWhvdywg
aG93IGlzIHRoaXMgdXNlZnVsIHRvIGJlDQo+IGluIA0KPiBEVD8gQW5kIG5vLCB0aGF0J3Mgbm90
IGEgc3VnZ2VzdGlvbiB0byBwdXQgYWxsIHRoZSBUUEwgY29uZmlnIGludG8NCj4gRFQuDQpPaywg
d2lsbCBhYmFuZG9uIHRoaXMgcGF0Y2gNCg0KVGhhbmtzDQoNCj4gDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10
ay14aGNpLnlhbWwgfCAyDQo+ID4gKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdXNiL21lZGlhdGVrLG10ay0NCj4gPiB4aGNpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay0NCj4gPiB4aGNpLnlhbWwNCj4gPiBp
bmRleCAyNDA4ODJiMTI1NjUuLjQ5NzI5YWFiNmQxYSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwNCj4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10
ay14aGNpLnlhbWwNCj4gPiBAQCAtMTE1LDYgKzExNSw4IEBAIHByb3BlcnRpZXM6DQo+ID4gIA0K
PiA+ICAgIHVzYjItbHBtLWRpc2FibGU6IHRydWUNCj4gPiAgDQo+ID4gKyAgdHBsLXN1cHBvcnQ6
IHRydWUNCj4gPiArDQo+ID4gICAgaW1vZC1pbnRlcnZhbC1uczoNCj4gPiAgICAgIGRlc2NyaXB0
aW9uOg0KPiA+ICAgICAgICBJbnRlcnJ1cHQgbW9kZXJhdGlvbiBpbnRlcnZhbCB2YWx1ZSwgaXQg
aXMgOCB0aW1lcyBhcyBtdWNoDQo+ID4gYXMgdGhhdA0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+
IA0KPiA+IA0K
