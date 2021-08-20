Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E42B3F2567
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 05:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhHTDiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 23:38:54 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51118 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234832AbhHTDir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 23:38:47 -0400
X-UUID: 6cd92cac53f949f5822bcf6e96125999-20210820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tcOiEStKRrox9Amq2VzhgvY9ppzOabv0hG2Da01URtA=;
        b=fkMwHovSJFcwNvh0bokr89f6l5fYGcaSeHspkvZShNHwWsTNgMtgZ44GtEtJlfBkGHeXQ85DQ+kcB3Bqp0Yj+VsAuqqmz6qeZi/Cbi6ZF74WVYHaUQ4WyrHJgZz8nHgMIMorxkwVC3uCuxFuFp4DsTCH0U1kE6gubglmousFq1Q=;
X-UUID: 6cd92cac53f949f5822bcf6e96125999-20210820
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1688833049; Fri, 20 Aug 2021 11:38:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 Aug 2021 11:38:06 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 20 Aug 2021 11:38:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO8ooZpKoD3ArmWG3SGBSyW2IDdbt3NLKt+qBOo3v0OCeF5XYLA7oFyxMXo5PlewqlBT7gg1PT8DK6116mXDbbNDXLDZXAf9A5rEzSqh+YNprkUTU7NrMV3DxSKLBdOYCc3ZCyn4G7k1e3/SIojFww1gVByLFxWTOt6/e4GOTKxECU8Ol5Q+Rk768xA8hdo0rQF1722B1AKV1cZkE/+LZXQ97TQO1vIRxbCEUElI0xkO4upnlSRQQX6HSVvS3PSjHVZUh8OowF1aJOL1w5zqsGYfT6bhBvXyJPoFy1c6G1np7Lt9ecYZh+/EWRD0byZBA4h83qHewx5/PMzt41mB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcOiEStKRrox9Amq2VzhgvY9ppzOabv0hG2Da01URtA=;
 b=GVE3pSY1N0maGozRmJJF56zZ4t+TdpfWTrjKNgxs6LhJpHKkoXeoUHGjPj3W60ytrqa+NZFXpkGBkGZEySo49IcmS5L6/0BMN5InSI+ZHmngulscpENTDVrg4pjPP5HVOpWeHbddRNwSlvT4r5UTxV15qRuIc356pkpQFlSqAs5ZS3Wg7JdQbc2DYAp9H/1UfDxPsDEUefsYa2u5ohzLzvSj3yRl8xwrpGVzk/e8fmWf9ryRoGZBptHNKhCfhXwksjT6K5p1HPTHclfP7lG4raeY/J8zpz6d+jEwxD188LuLOIz8EDACApgFv3BUgEL3wZsJBDOyOrP3xFDYM7DRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcOiEStKRrox9Amq2VzhgvY9ppzOabv0hG2Da01URtA=;
 b=I0+vN9phh0h2/pDn0EmSiu3sCFlS1HvPEjpCYiNHlikIG03yaUSmY4aBYwEoMh4qXjpu1WzyANCG2QgJpEee2sHbolsgPjpIdZ3+imJJPjlX5Y0iC9p/ZorIhShO2ePPeUAuN/a60qZOKJO8IhvSGEffKJoYuv/G9MZ4XLtvOwA=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR0302MB2551.apcprd03.prod.outlook.com (2603:1096:802:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.16; Fri, 20 Aug
 2021 03:37:55 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4436.018; Fri, 20 Aug 2021
 03:37:54 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: xhci-mtk: handle bandwidth table rollover
Thread-Topic: [RFC PATCH] usb: xhci-mtk: handle bandwidth table rollover
Thread-Index: AQHXjPzqwpeGZOWapUiNHdL7bl5Aqatq4ykAgAAIfYCAAxloAIABmrOAgAAmhgCACNVhgIADM+IA
Date:   Fri, 20 Aug 2021 03:37:54 +0000
Message-ID: <71ae637d3b44938d6591bd9072a58299d3c17e57.camel@mediatek.com>
References: <20210809165904.RFC.1.I5165a4a8da5cac23c9928b1ec3c3a1a7383b7c23@changeid>
         <YRDxTodNNqtnpPpn@kroah.com>
         <CAATdQgDSCzZtiDSQk94CYHfSb9Mq28OH7-RdaTZNv3oPrW3nkQ@mail.gmail.com>
         <7b48f4c132a8b4b3819282e961fbe8b3ed753069.camel@mediatek.com>
         <CAATdQgD1paUUmWhiLVq-+zq0V6=RTJw89ggk=R6cBUZO+5dB-Q@mail.gmail.com>
         <efcd999aaf83cf73ed2f4f4b9efa1bb93efd2523.camel@mediatek.com>
         <CAATdQgC_aukAA3-=cuiOAQGzu_Ztvo4BsMbRv2hCGZpUeOAJVg@mail.gmail.com>
In-Reply-To: <CAATdQgC_aukAA3-=cuiOAQGzu_Ztvo4BsMbRv2hCGZpUeOAJVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 377a6a7f-8810-4a2c-12d6-08d9638be559
x-ms-traffictypediagnostic: KL1PR0302MB2551:
x-microsoft-antispam-prvs: <KL1PR0302MB2551D240A5B681A15251AC89FDC19@KL1PR0302MB2551.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBWUTe7QGTIcJbQWDxFRT17JJcRK+zUVGBQ09GOr+iqtVnrjskxrc/YnWbULUuCQ1AIJsuXPjLP7+zGe+H+KesJYBVK3NazLDRwiKTv/wVMilQuBiwjuUsRHwfzCofzpIVB4dvVMjLCp80R4+BIlRfPYadt23sbtQemmNdltDwfOGLbTvFxKki5qjDyiUtViLDBizSmjBO7aHgDLV7Bg9+7/tvWBSu1XEtyp9oDlMmq3dlFoI/wyaJhPEpZFyC+0RXJthBOT0I/GiBgPY2wsxSmtWMD57v7UwqzQQ3R3bpEIL34FXMX1sN0bkqhUf8v1oEtsOtQV8eq6dqPZjmVOFJJZC5EZSyWHSuk2KXSUrm4xOmJJSqO3/Q+s1FMlP4SCXIrZy1vrniJd21pKjFbgAXgmnP5QIse8Mvn8Ym1DGXvkHqwqsN5J28fsqDPznS+93i7FUh14JPY9Ydb9HkZ6tq4WfZKa1rJv23n2pCkhPR5FTLh5ud08BFOyvp7MSoi/o9ktTB7wl0W75I5+03tMFOhxYM+AgoVJP3HwvR4F7+XHXuGNqmAJv0/55VTZphIouW0bBo+/dJ6x/x2Uih2yDi3jUkwN3s1czVhvfnPP+5ViV4MeAnf9IxpDds/G1xmoax+KgIBIkzFLeys14XPAIHdIRtU04GHoKyohDt1gCS5BkEU8TdKkyDRgLdQbFYCKq/OBsY8IK4Q/73+z0qC+UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(6916009)(53546011)(26005)(66476007)(2906002)(186003)(8936002)(83380400001)(316002)(6506007)(86362001)(6512007)(85182001)(71200400001)(478600001)(6486002)(38100700002)(8676002)(38070700005)(5660300002)(66446008)(4326008)(76116006)(36756003)(122000001)(2616005)(66946007)(66556008)(64756008)(91956017)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aC9KQUMwb2FOeiszcERWUnhSRFI2Ymx1c0ptNnowTU8vSCtLcmdkY2hJOFVh?=
 =?utf-8?B?ZmEzME1FNk05RURySTZpUUJZUFNGL2hmUFZjZjViQ1Zvb3F0MXd3M0VtbGZY?=
 =?utf-8?B?Unp5QlQzcjh3bnAvOEFsTXVjUUtRcFowY0swbzNuRGQxT00wRGFFTG9TTVB2?=
 =?utf-8?B?b2k2TVAvTGY3dU5Tb3U0WElhRnBuZUpMQ1JpTk5Zd0hkMjg5QTVGVklFaTBL?=
 =?utf-8?B?Yk1yeXVxWTh6RG40cXhjNEVSdld5eHlhWFBNTTZuVEFRcElMcXFXNENKMUUz?=
 =?utf-8?B?SXFPM2JPTE5ReDkyMVorQUdXU05rQTQxUDFvTFdja1RHMjBDUGZJWEJyOURD?=
 =?utf-8?B?SVVQdzJnaC9MaWFMREpQZzVuYmlWdFo1WWlXT1huK1dxSnVmeThvQXYvRVJS?=
 =?utf-8?B?RThMT1ZwV2RRL3dpV2J1Q01wV1JrbVk0VEx1UHc1V1A2VDZnZHpScmFINGlG?=
 =?utf-8?B?WFNnV2hCN2oxYk9Lc1FqaFJJcnhLcldDVzJ2QjZXWkhKRHFpSU9heFRXc29R?=
 =?utf-8?B?NTNXbk1tTzZTWkVzZFNnNVJIRnQxa1JJUnNRTTFhLzV0ZTdYSmlQb3lXRVp0?=
 =?utf-8?B?VUM2cW5TK1NaNzdsRTI5T3BLcllWeDZiMStmSnNsNnFweHNNU2cxZmpJazhT?=
 =?utf-8?B?RnYvUUpObkttSThDZzlSNTVMa2RVR3h0YUhBVUhaclp1RG91RWdsNWlWRTdY?=
 =?utf-8?B?bjB3WjVvTWRjT3hVdDE5TGJ2aVdnRjlHZVYyWGYvczFYeHNCalFLbmZSMFhu?=
 =?utf-8?B?QzRYNzRXK04vcUxGb0t2SnNla3dQYjFRM3o0R0V4MWVnWFZGQkQ3RC85Wmxh?=
 =?utf-8?B?eURHeVpRM3EyN3lRazgvaExzZStsVzdQY1VsT0graXVpWlFxQThQTklQZ3B6?=
 =?utf-8?B?VjVZUE5IL2FPRzA4cU5XRGxPcStJcFphbGk2Uml5Ti9nbnRTdWJPYzRDY2ph?=
 =?utf-8?B?OE9SVVExcHF2djI2MjlDTnJiNDB5QkNScTdiWlZDNXZBeG5aL0tiSFlHRkhO?=
 =?utf-8?B?SlFoTlltWUdIdEVXVTJobDJlUHZLUEY0bDdZWnkwTGZscFZySUtTMlFtb0NQ?=
 =?utf-8?B?cXhPdjFIbmRHU2h1SmtlNmhZdUxuRDdNOHZWdnloaTVTZzVSa2ZyMFBaRmky?=
 =?utf-8?B?VFhac3hQS0ZXa2VBNXJYYUlsVFJjVG9ybGMycEdVaktEdUxDeVRhcHlzOS9J?=
 =?utf-8?B?ek9tRGNIQVNHZUFibXFadnIzZlltS3oyeHhudzd6V3FQcUhQUnk2S2FnQmlF?=
 =?utf-8?B?eXZRcWw4K0NBMVZ1MkZLT3lwRTdmbk5rMUEwalJKMDVDTHcyWDFqc2VoTWVn?=
 =?utf-8?B?QVVJeXZKcVBUZktEZXIxdTY0OVZqUkxSOVl5TXRvMUZQa01Zd0NkazcxVm93?=
 =?utf-8?B?WkhvU2ZaSXM4N1hROFhKMWJaM2RMQVQ0cFVKNk5vajQ4WkE0SU9VckgvclFr?=
 =?utf-8?B?MmhBcVpqMHNSTXJSbC8rbnRZUnQyQzZ1Z1R2MkNlRGhRZGlzNlZFMEFuclk5?=
 =?utf-8?B?RkNGb1kzeHJYTUhwV0xJcGEvSVpQRGpIemswTjZVUlhZUjEwUnlISVNSYUJL?=
 =?utf-8?B?czA3QkhPTkRXTmY4cGZURW1CZzRRVXY5dkMxV0ZJbVBWWkVpZC9aYU8xTGFE?=
 =?utf-8?B?TlBhQkJmclVGZS9idVdQSjhsbkxTSjhQcnlGZUp3bEVHM3hVb0M4L3RBQ01v?=
 =?utf-8?B?TVdXamYvMUNzbWU5NFlsd3ZraWxGeUVnN000OEZITzM2MkRJVVd5Y1ZvYjh2?=
 =?utf-8?Q?Syo3FFyp25z8uFnt+uSO5vKpmxhvf4lq8pLGqPg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA0586A285CDC445BBDB4A11234D8B42@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377a6a7f-8810-4a2c-12d6-08d9638be559
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 03:37:54.7090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3GksH32teJPCQSrgephbdJ2EyvFt+ovETeYWrpqosRso8FEu+YjNxxu8CysKD1YpMvnCsdLDU2uHODbCAk7w4dpzgDbPDRFTueXQ5JdOxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB2551
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTE4IGF0IDEwOjQzICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
SGkgQ2h1bmZlbmcsDQo+IA0KPiBPbiBUaHUsIEF1ZyAxMiwgMjAyMSBhdCA3OjQ5IFBNIENodW5m
ZW5nIFl1biAo5LqR5pil5bOwKQ0KPiA8Q2h1bmZlbmcuWXVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6
DQo+ID4gDQo+ID4gT24gVGh1LCAyMDIxLTA4LTEyIGF0IDE3OjMxICswODAwLCBJa2pvb24gSmFu
ZyB3cm90ZToNCj4gPiA+IEhJLA0KPiA+ID4gDQo+ID4gPiBPbiBXZWQsIEF1ZyAxMSwgMjAyMSBh
dCA1OjAyIFBNIENodW5mZW5nIFl1biAo5LqR5pil5bOwKQ0KPiA+ID4gPENodW5mZW5nLll1bkBt
ZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24gTW9uLCAyMDIxLTA4LTA5
IGF0IDE3OjQyICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4gPiA+ID4gPiBPbiBNb24sIEF1
ZyA5LCAyMDIxIGF0IDU6MTEgUE0gR3JlZyBLcm9haC1IYXJ0bWFuDQo+ID4gPiA+ID4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
T24gTW9uLCBBdWcgMDksIDIwMjEgYXQgMDQ6NTk6MjlQTSArMDgwMCwgSWtqb29uIEphbmcNCj4g
PiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiB4aGNpLW10ayBoYXMgNjQgc2xvdHMgZm9y
IHBlcmlvZGljIGJhbmR3aWR0aCBjYWxjdWxhdGlvbnMNCj4gPiA+ID4gPiA+ID4gYW5kDQo+ID4g
PiA+ID4gPiA+IGVhY2gNCj4gPiA+ID4gPiA+ID4gc2xvdCByZXByZXNlbnRzIGJ5dGUgYnVkZ2V0
cyBvbiBhIG1pY3JvZnJhbWUuIFdoZW4gYW4NCj4gPiA+ID4gPiA+ID4gZW5kcG9pbnQncw0KPiA+
ID4gPiA+ID4gPiBhbGxvY2F0aW9uIHNpdHMgb24gdGhlIGJvdW5kYXJ5IG9mIHRoZSB0YWJsZSwg
Ynl0ZQ0KPiA+ID4gPiA+ID4gPiBidWRnZXRzJw0KPiA+ID4gPiA+ID4gPiBzbG90DQo+ID4gPiA+
ID4gPiA+IHNob3VsZCBiZSByb2xsZWQgb3ZlciBidXQgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRp
b24NCj4gPiA+ID4gPiA+ID4gZG9lc24ndC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
IFRoaXMgcGF0Y2ggYXBwbGllcyBhIDYgYml0cyBtYXNrIHRvIHRoZSBtaWNyb2ZyYW1lIGluZGV4
DQo+ID4gPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiA+IGhhbmRsZQ0KPiA+ID4gPiA+ID4gPiBp
dHMgcm9sbG92ZXIgNjQgc2xvdHMgYW5kIHByZXZlbnQgb3V0LW9mLWJvdW5kcyBhcnJheQ0KPiA+
ID4gPiA+ID4gPiBhY2Nlc3MuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBJa2pvb24gSmFuZyA8aWtqbkBjaHJvbWl1bS5vcmc+DQo+ID4gPiA+ID4gPiA+IC0t
LQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1t
dGstc2NoLmMgfCA3OSArKysrKysrKystLS0tLS0tLQ0KPiA+ID4gPiA+ID4gPiAtLS0tDQo+ID4g
PiA+ID4gPiA+IC0tLS0NCj4gPiA+ID4gPiA+ID4gLS0tLS0tLS0NCj4gPiA+ID4gPiA+ID4gIGRy
aXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuaCAgICAgfCAgMSArDQo+ID4gPiA+ID4gPiA+ICAyIGZp
bGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDU3IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiBXaHkgaXMgdGhpcyAiUkZDIj8gIFdoYXQgbmVlZHMgdG8gYmUgYWRk
cmVzc2VkIGluIHRoaXMNCj4gPiA+ID4gPiA+IGNoYW5nZQ0KPiA+ID4gPiA+ID4gYmVmb3JlIGl0
DQo+ID4gPiA+ID4gPiBjYW4gYmUgYWNjZXB0ZWQ/DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gc29y
cnksIEkgaGFkIHRvIG1lbnRpb24gd2h5IHRoaXMgaXMgUkZDOg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IEkgc2ltcGx5IGRvbid0IGtub3cgYWJvdXQgdGhlIGRldGFpbHMgb2YgdGhlIHhoY2ktbXRr
DQo+ID4gPiA+ID4gaW50ZXJuYWxzLg0KPiA+ID4gPiA+IEl0IHdhcyBva2F5IGZyb20gbXkgdGVz
dHMgd2l0aCBtdDgxNzMgYW5kIEkgdGhpbmsgdGhpcyB3aWxsDQo+ID4gPiA+ID4gYmUNCj4gPiA+
ID4gPiBoYXJtbGVzcw0KPiA+ID4gPiA+IGFzIHRoaXMgaXMgImJldHRlciB0aGFuIGJlZm9yZSIu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQnV0IHdoZW4gSSByZW1vdmVkIGdldF9lc2l0X2JvdW5k
YXJ5KCksIEkgcmVhbGx5IGhhdmUgbm8gaWRlYQ0KPiA+ID4gPiA+IHdoeQ0KPiA+ID4gPiA+IGl0
IHdhcyB0aGVyZS4gSSdtIHdvbmRlcmluZyBpZiB0aGVyZSB3YXMgYW5vdGhlciByZWFzb24gb2YN
Cj4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gZnVuY3Rpb24NCj4gPiA+ID4gPiBvdGhlciB0aGFu
IGp1c3QgcHJldmVudGluZyBvdXQtb2YtYm91bmRzLiBNYXliZSBjaHVuZmVuZyBjYW4NCj4gPiA+
ID4gPiBhbnN3ZXINCj4gPiA+ID4gPiB0aGlzPw0KPiA+ID4gPiANCj4gPiA+ID4gV2UgdXNlIEBl
c2l0IHRvIHByZXZlbnQgb3V0LW9mLWJvdW5kcyBhcnJheSBhY2Nlc3MuIGl0J3Mgbm90IGENCj4g
PiA+ID4gcmluZywNCj4gPiA+ID4gY2FuJ3QgaW5zZXJ0IG91dC1vZi1ib3VuZHMgdmFsdWUgaW50
byBoZWFkIHNsb3QuDQo+ID4gPiANCj4gPiA+IFRoYW5rcywgc28gdGhhdCBmdW5jdGlvbiB3YXMg
b25seSBmb3Igb3V0LW9mLWJvdW5kcyBhcnJheSBhY2Nlc3MuDQo+ID4gPiB0aGVuIEkgdGhpbmsg
d2UganVzdCBjYW4gcmVtb3ZlIHRoYXQgZnVuY3Rpb24gYW5kIHVzZSBpdCBhcyBhDQo+ID4gPiBy
aW5nLg0KPiA+ID4gQ2FuIHlvdSB0ZWxsIG1lIF93aHlfIGl0IGNhbid0IGJlIHVzZWQgYXMgYSBy
aW5nPw0KPiA+IA0KPiA+IFRyZWF0IGl0IGFzIGEgcGVyaW9kLCByb2xsIG92ZXIgc2xvdCBlcXVh
bHMgdG8gcHV0IGl0IGludG8gdGhlIG5leHQNCj4gPiBwZXJpb2QuDQo+ID4gDQo+ID4gPiANCj4g
PiA+IEkgdGhpbmsgYSB0cmFuc2FjdGlvbiAoZS5nLiBlc2l0X2JvdW5kYXJ5ID0gNykgY2FuIHN0
YXJ0IGl0cw0KPiA+ID4gZmlyc3QNCj4gPiA+IFNTUExJVA0KPiA+ID4gZnJvbSBZXzcgKG9mZnNl
dCA9IDcpLiBCdXQgd2lsbCB0aGF0IGFsbG9jYXRpb24gYmUgbWF0Y2hlZCB3aXRoDQo+ID4gPiB0
aGlzPw0KPiA+ID4gDQo+ID4gPiAtICAgICAgICAgICAgICAgaWYgKChvZmZzZXQgKyBzY2hfZXAt
Pm51bV9idWRnZXRfbWljcm9mcmFtZXMpID4NCj4gPiA+IGVzaXRfYm91bmRhcnkpDQo+ID4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+IA0KPiA+ID4gSSBtZWFuIEknbSBu
b3Qgc3VyZSB3aHkgdGhpcyBpcyBuZWVkZWQuDQo+ID4gDQo+ID4gUHJldmVudCBvdXQtb2YtYm91
bmRzLg0KPiANCj4gSWYgaXQgd2FzIGZvciBwcmV2ZW50aW5nIGRyaXZlcnMgZnJvbSBvdXQtb2Yt
Ym91bmQgYXJyYXkgYWNjZXNzLA0KPiBJIGNvdWxkbid0IGZpbmQgYW55IHJlYXNvbnMgd2h5IHdl
IGNhbm5vdCByZW1vdmUgdGhlIGFib3ZlIGxpbmVzLg0KPiBTbyBjYW4gSSBrbm93IGlmIGl0IHdh
cyBqdXN0IGZvciBwcmV2ZW50aW5nIHhoY2ktbXRrIGRyaXZlcnMgZnJvbQ0KPiBvdXQtb2YtYm91
bmRzIGFycmF5IGFjY2Vzcz8NCkR1ZSB0byBpdCB1c2UgYW4gYXJyYXkgdG8gY2FsY3VsYXRlIGJh
bmR3aWR0aCwgaWYgdXNlIHJpbmcsIGNhbiByZW1vdmUNCml0Lg0KDQo+IA0KPiBJZiB4aGNpLW10
ayBIQyBpdHNlbGYgY2FuIGNvbnRpbnVlIHRoZSB0cmFuc2FjdGlvbiBmcm9tIFlfNyB0bw0KPiAo
WSsxKV9uOw0KPiBpbmNsdWRpbmcgdGhlIGNhc2Ugb2YgWT09NjMsIEkgdGhpbmsgaXQncyBqdXN0
IG9rYXkgdG8gcm9sbG92ZXIgdG8NCj4gKFkrMSkuDQo+IA0KPiBJZiBpdCdzIHByb2hpYml0ZWQg
YnkgeGhjaS1tdGsgaHcsIG9yIGlmIHlvdSB0aGluayB0aGlzIHBhdGNoIGlzIG5vdA0KPiBhbGxv
d2VkIGJ5IGFueSBvdGhlciByZWFzb25zLCBjYW4geW91IHBsZWFzZSAgdGVsbCBtZSB3aGF0DQo+
IGtpbmRzIG9mIHByb2JsZW1zIGNhbiBoYXBwZW4gd2l0aCB0aGlzIHBhdGNoPw0KU2VlbXMgc3cg
bGltaXRhdGlvbiwgb3IgYXZvaWQgcmVwZWF0ZWQgY2FsY3VsYXRpb247DQpJJ2xsIGNoYW5nZSBp
dCBhcyBhIHJpbmcsIGFuZCBkbyBzb21lIHRlc3RzLg0KPiANCj4gT3RoZXJ3aXNlLCBwbGVhc2Ug
Y29uc2lkZXIgbWluaW1pemluZyB0aGUgYncgY29uc3RyYWludHMgZnJvbQ0KPiB4aGNpLW10ay1z
Y2ggb24geW91ciBzaWRlLiBOb3RlIHRoYXQgd2UncmUgc3RpbGwgaGF2aW5nIG90aGVyIHVzYg0K
PiBhdWRpbyBoZWFkc2V0cyB3aGljaCBjYW5ub3QgYmUgY29uZmlndXJlZCB3aXRoIHhoY2ktbXRr
DQo+IGV2ZW4gd2l0aCB0aGlzIHBhdGNoLg0KT2ssIHRyeSBteSBiZXN0IHRvIGRvIGl0LCB0aGFu
a3MgYSBsb3QNCg0KPiANCj4gVGhhbmtzLg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gVW50aWwg
bm93LCBJIGNvdWxkbid0IGZpbmQgYSB3YXkgdG8gYWNjZXB0IHRoZSBVU0IgYXVkaW8gaGVhZHNl
dA0KPiA+ID4gd2l0aCBhIGNvbmZpZ3VyYXRpb24gb2YgeyBJTlQtSU4gNjQgKyBJU09DLU9VVCAz
ODQgKyBJU09DLUlOIDE5Mg0KPiA+ID4gfQ0KPiA+ID4gd2l0aG91dCB0aGlzIHBhdGNoLg0KPiA+
IA0KPiA+IHdoYXQgaXMgdGhlIGludGVydmFsIHZhbHVlIG9mIGVhY2ggZW5kcG9pbnQ/DQo+ID4g
DQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhhbmtzIQ0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiB0aGFua3MsDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IGdyZWcgay1oDQo=
