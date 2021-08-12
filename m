Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4D3E9C96
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 04:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhHLC3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 22:29:46 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34338 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229729AbhHLC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 22:29:45 -0400
X-UUID: ec126597bb5943e18977b483439d13de-20210812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cjwrNSNKk7kpxT00KjQ+zePQDBzk9yx7w+v8Ix7SWLY=;
        b=OpCOzUOFtKNhJxl1bySj6GA37xBFMlUnmVstCpjdPuOCTPCBjf6mUbBRLkaqShYeznjzEmG61Dti1SRF5wsiyktEbRLlo7dWR+XEPdqubmn8CDf711dVRFvYuXm8UXmvZXChBxaMrrX4sTr9sAheT0pGj1IiuxCXa+0ma3BDcsg=;
X-UUID: ec126597bb5943e18977b483439d13de-20210812
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1254420789; Thu, 12 Aug 2021 10:29:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 10:29:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 12 Aug 2021 10:29:15 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 12 Aug 2021 10:29:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZtGU+6jwisMduqWTSf4PX07Laz0tP3GA+4jnBNdczWm0KQLVWjSO+rsitsI8LkCX8y7z1+XpnogHWjZVgQUC3Q8gY/FAdyqnLYk5kox0wFA3gHNhLlOiM9FlqPYdgCo/LnDUEzuUT/1W0BUWMdRNSw3t3j9M7AYcdBV/yXE471JeBs+nCF/l1Ce6Bjj4fIFWKTDdOj62lyw+C8saTlPk9cv513uA9bx3ljaM0dx9qT57D2lShg+cRDTod0RLIMCPBGgHIku3algFa11XBmNw98OKPfuanCuDgtVwbZ926aOFJxcLfwkKkiKspxz/pCd//GPElIp6r1mnLCdBPiYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjwrNSNKk7kpxT00KjQ+zePQDBzk9yx7w+v8Ix7SWLY=;
 b=DzwfLZ+L/cbyVFRutGcNQdwF1DVrpCopiSVvN8CiRGLJlTjpVZh0q4HSoMy8ZTVap+LHj4Y1QBO4G/+dcp5JCcwpzZEFsdZ90XiWMRAc1x/NN0QMpBKBvlg3kDATTtXCR115LF14ZCN6ewqGgqCdTRtSUUgFobGS0ytryObe80MO3rGVYCsk3LIyYvnVsyGdoq37a5ygVhTBy8OLO89mQiYBQ21IYRQq5dt8rXzBEsP4kNXoGO3Q/In5cmyolH1xF6PdCqjuMqUcs6DnIx1C5azMyLXtOf6+whYpEYJk+Rofg4ejRU22U+b6FOPZdEKqRyU/FxjvdNB6nNs6+xtVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjwrNSNKk7kpxT00KjQ+zePQDBzk9yx7w+v8Ix7SWLY=;
 b=GWRhamfnsA4rUSgwPNE1njzTYc1WRpiqR4goZF3yMnMW1zXKaxj2PHDS0hgsbh5mG3Fa1ifnl9+G8jSS4JQ2Evg/uWSp5w8OGaOEpmRxqZ/ossmL33f/IPzcCUXv52t5BWdoJWQ16PKYapHR00myyM/M5Kzvyq9Kp97/gKENAt4=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KU1PR03MB2854.apcprd03.prod.outlook.com (2603:1096:802:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.7; Thu, 12 Aug
 2021 02:28:55 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 02:28:55 +0000
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
Thread-Index: AQHXhR/4fMl3EMN3dEGb/VVeJQbwbqtm+4mAgAcF14A=
Date:   Thu, 12 Aug 2021 02:28:55 +0000
Message-ID: <0ad1ff768954580b3b4a6a344eacde7a35a8ad2c.camel@mediatek.com>
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
x-ms-office365-filtering-correlation-id: c055cead-470f-4271-cb77-08d95d38eee2
x-ms-traffictypediagnostic: KU1PR03MB2854:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1PR03MB285410AE2B91A6AF54FA6DC0FDF99@KU1PR03MB2854.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UiEI8+jkKfpCkVmGF/ngzLICQGvle50fa5zyPL23ik9ZirqwHVUgnpxVlg4gd+0kXSLdlMwypaCchZquYFKAQZFe3IyNthDPyfrInRN6lkI4Nv9DOQ6KkasJsxUh/D2k5P4sVlHY9Nb8cGnw4Zx3SNveuNflwY+4+f/eSlLJH1wfcQTDxGLIQDRLMDFgJNN76RYpR1yFtOfPxVtEy9UZMqAsWT0Wpuo6p36t0Ne22d/BensRFQVaGum3+e+fnFM3njLPQMPPO23VPgpkmMx1Oe9Kd7Xz9umCCT5QJa0ETNHolEvWLh8jCUeSuU+yFmerxPHTdVmoPdqzStAEASRjSomW8wFbsLDqLKJHv3IpesGCmnsULhZXwxSqNZhIWiRHu001iR7/psvGgCkN5RR8Lm2wMXkTDZi+S6USImTCscn3sF9CYAKpy5jp4YrrNJupAj4eIQybAXci89/KGgQuuKNIURi97VwOjVOmdKcGy9olc1QmC29HZ1Nda1FtqEFQQI3BCV2mUheKfgsj9VsnQ9OEav6j1zUa19JdzQtPbiQJcx7K8JgswkEp7cx8jZm5PcqRoQzcxPVrlqWy3vdXhCK0z0gjl5gq+hO7lO/wUVLiNkiKDDb4dsC99nVSD4gnlNRqaHivk2yN0gbMrummB6z9NS/3njlHhDtzWdxVgLipJN8M4zd06T+eWyXEru1aBBpVLrR9/TbE8vpeYCSl4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(5660300002)(2616005)(83380400001)(54906003)(122000001)(4326008)(498600001)(38100700002)(66556008)(85182001)(66476007)(6512007)(26005)(36756003)(186003)(6916009)(38070700005)(86362001)(91956017)(6486002)(2906002)(71200400001)(64756008)(8936002)(66946007)(8676002)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejhBaG4yeXM5Q1dCUUdSSjNpUUU3WWF1MVhNTjZSczM5ZWxSQklHSUhPcFRa?=
 =?utf-8?B?SWZiQ1VsNFZ3ZFNCRFB6WFJPT2pGNkpOeVVyRHdmRWdmOFE1WTZLbzBiQ0do?=
 =?utf-8?B?OGNIVWdvcUFLVXJtcmhFRTQrNkdDQ2xYY2JiQlhwRURMU1dSUnNteEQ4SEp5?=
 =?utf-8?B?L0JENHdWdDFwelJZZ2pwZmhaMXFqc1Z1ck9DSXFHK2lXOEpSTXhYVW1YVU9x?=
 =?utf-8?B?TUhtOS9jdHJYVC93Z2poZDN6a21ZdGFaaFpWRitkUXdoVTV3SThSUTFBUllY?=
 =?utf-8?B?aVhiNWJYbENwVmZPdThuNkFYWVFrUzVGU0FjeDJSNHBydnE0STAxMU9TaDMy?=
 =?utf-8?B?MWpubm9POHBRRzA0bmlYN2VkRTNrQk5Lb1RnNDZORStxSG0rSW5LcUFyd0NP?=
 =?utf-8?B?cFV2YWVYbklXR0ZDa09HMGhXd08zclJqQzNsTGhBTC9IUEdMZHgzZTJ4YnFu?=
 =?utf-8?B?V05CUUY4alQwaUF6V1FYTERRdHJ6dmNKUTFFRFg5Z1JpZy91L2MxSDRyR0ZS?=
 =?utf-8?B?YUZlZHc4SFgzNG82TXJaR2h0eEptazQyd2d4eUZHbDdYRG82aHhrSyt5Uzcy?=
 =?utf-8?B?Y1dnb21DSVlXbnRwZ3ExcDBJVHRTRTZ2TnhlNUdjajZpdHpmbk1CTmZxWnkv?=
 =?utf-8?B?TlBiM2NrR3d0d0o5S2c3ZHc5aDdkOHdxZGJaYmpDN24wZ1EvYjNoWU1sT2dk?=
 =?utf-8?B?U2xROEZabk94RUw1VnhJajBUT1JxeE1GbWdHWmtqQllWaHpVbW5KSTNQTitL?=
 =?utf-8?B?R2d5VUkvT3MyRlRMTGdHckZzOUdCVDJFbkJzRjhMTUpUT3ExMWsrK0RQWGlL?=
 =?utf-8?B?aFNmVGNCb2NiN3ByUWU5OHdVenU2eHlzbmdTNFNFT0tuLzdWY1lCOE81R3Nx?=
 =?utf-8?B?bitpdmFxN1AxKzczOThWVWtNclp4VzJTV2FoUlB0VzNKOEFlbGRMODd5UklP?=
 =?utf-8?B?KzRoYWNQWFdFU1U1R05yZEZWSFdPTUtJL2dJdXJmbm9MQ1UvOGxMMmFHRlBs?=
 =?utf-8?B?TkptYnBlZG5Fc1pPZXRpZG9GNFI2WHdQcVRuN3psaUJ1RTVVUjZKQ25ZY3Zp?=
 =?utf-8?B?VnhOUTl4clNqSWpSWDNCMkt5Z2FhMEh2MzVFb1paS3VSV1lpZit4KzRac3ZX?=
 =?utf-8?B?UUpYaWNkR0tVZ0hWdkVDdUc3amlsK3hnRGFXdGI4dTRpeXozbWZMTTQ0ZXc4?=
 =?utf-8?B?ekM5VGZHdFIwcmtYaDVjYUFjOHVtR0p3YVFSVDYvQWZLRXdHQ2Y1dmpSRHM0?=
 =?utf-8?B?Q3hZaFQwNGhWSTVHYm9vMEEybXo2Wjd6MHFDeCsvdmsxcVJQOUlBVjJHcXRv?=
 =?utf-8?B?Q3Z1MHVTeHQvdzd2RWlOOUZBcEp0VUdyR3lPVGNLM1dLV2YxdTZ5d0JxWjdL?=
 =?utf-8?B?YVhteWtkYjhXS05aakI1Q2Nsc2swQzBLU2VnM1d0RTJYT0dIdUtPQUNKODNi?=
 =?utf-8?B?clcrM2k4MVVIY3RuV3J3aHBhRjFWVm9RN1RJb2RrSVVxOWdVUW5EYldnUGVk?=
 =?utf-8?B?QzU2a3ZiVDE2OE05emNiMDFESGNpdjQ4VENFaTNJdjJ5OXByZFNRZytWVkJD?=
 =?utf-8?B?d29YSGx1endraVBMaVNDYXlDeWQ2NmFzaWFHWVkwYUxuVUtGdWowSVpjNFR3?=
 =?utf-8?B?SGJVOEVVVTBuK3U1WGJEVWFtNVkzQ09wRTJtcjdIcldYa2J5Sm9McmMyMDUx?=
 =?utf-8?B?aGFNVllpMlNTaUw0emtCVm9laE40aFdtUUZ0RXpjOC9YcUVYeXlBdDRyM2xZ?=
 =?utf-8?Q?xyntpw4QTUN9mKCmyoQoCliec2ScGfR7zLYqna2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C545294F303C6540B4C05AC5A87DF357@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c055cead-470f-4271-cb77-08d95d38eee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 02:28:55.5698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHXGmfzuI4iWa03qOq+05/hrr5UjuGt7g3CutQXtZh3hDZ5EZn0MpyyRn4nJgT+8bNaFAkpefHPtPvV2hWMaImbS28W+Ud54ouLRqSGEjWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1PR03MB2854
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTA2IGF0IDE0OjM3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCBKdWwgMzAsIDIwMjEgYXQgMDQ6NDk6NTJQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IEFkZCBwcm9wZXJ0eSAndHBsLXN1cHBvcnQnIHRvIHN1cHBvcnQgdGFyZ2V0ZWQg
cGVyaXBoZXJhbCBsaXN0DQo+ID4gZm9yIFVTQi1JRiBFbWJlZGRlZCBIb3N0IENvbXBsaWFuY2Ug
VGVzdA0KPiANCj4gR2l2ZW4geW91IGhhdmUgdG8gY29uZmlndXJlIHRoZSBUUEwgc29tZWhvdywg
aG93IGlzIHRoaXMgdXNlZnVsIHRvIGJlDQo+IGluIA0KPiBEVD8gQW5kIG5vLCB0aGF0J3Mgbm90
IGEgc3VnZ2VzdGlvbiB0byBwdXQgYWxsIHRoZSBUUEwgY29uZmlnIGludG8NCj4gRFQuDQpJdCdz
IGluZGVlZCBub3QgZmxleGlibGUgaGVyZSwgYWJhbmRvbiB0aGlzIHBhdGNoLg0KDQpUaGFua3MN
Cg0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1
bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCB8IDINCj4gPiArKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiA+IHhoY2ku
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRr
LQ0KPiA+IHhoY2kueWFtbA0KPiA+IGluZGV4IDI0MDg4MmIxMjU2NS4uNDk3MjlhYWI2ZDFhIDEw
MDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVk
aWF0ZWssbXRrLXhoY2kueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KPiA+IEBAIC0xMTUsNiArMTE1LDgg
QEAgcHJvcGVydGllczoNCj4gPiAgDQo+ID4gICAgdXNiMi1scG0tZGlzYWJsZTogdHJ1ZQ0KPiA+
ICANCj4gPiArICB0cGwtc3VwcG9ydDogdHJ1ZQ0KPiA+ICsNCj4gPiAgICBpbW9kLWludGVydmFs
LW5zOg0KPiA+ICAgICAgZGVzY3JpcHRpb246DQo+ID4gICAgICAgIEludGVycnVwdCBtb2RlcmF0
aW9uIGludGVydmFsIHZhbHVlLCBpdCBpcyA4IHRpbWVzIGFzIG11Y2gNCj4gPiBhcyB0aGF0DQo+
ID4gLS0gDQo+ID4gMi4xOC4wDQo+ID4gDQo+ID4gDQo=
