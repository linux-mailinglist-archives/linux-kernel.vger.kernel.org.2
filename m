Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB23E8CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhHKJDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:03:07 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34088 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236312AbhHKJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:02:34 -0400
X-UUID: aab18896f8fa435e98e1bedf5844b4db-20210811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OHEqAlLhjd9S4MMKeqvo97ph7nZ+D+uFeMPd7fmAR0g=;
        b=QWoGnDFBmlGoBU2UM39nQpPj+4J1PzF1tRcfKSFwADghg7VMA+550Qvehm8mrZPTQ8rnrst44KkqOzYvG+HruG0gMfIYAGZdly6neKlUMH2ZOETyejk5qhQ2IuPmNkirgQBl/UTlII+C+Yu2Ge9P/OL6fSG+NbcllBbaq27ZniQ=;
X-UUID: aab18896f8fa435e98e1bedf5844b4db-20210811
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 974566448; Wed, 11 Aug 2021 17:02:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 17:02:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkcas07.mediatek.inc (172.21.101.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 17:02:04 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Aug 2021 17:02:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxLJi0lr7Mmt5Qs0xaxw5qdtWWbw8N3TQzbK719ytFWwFUJrUxMw2Us/tLL40kL0sYRBBAIGQ8jFMhnSUupjHOZLyP4DiEwuo5a9snZ0gLpqOjq29dLElp921zSJB+ombdlWtlMVzyfEXvPCTV5WLiicwn+DPaFomKFY7PiQcHldND8t1aVch1D3znmEYPaYcL0DarcMcKoBFIBXb4WvYsbnBX30mG1sxB0XtRUd+vhcW0XIZge4GHeHTogI17nhDfsuqd8tzWDjnAOEu7k9tQrHj1OZBD9eJQx4oot1Pjr4ShDVlP5m3Yux5gxv0ac9SMc2OKAwSak7yeSpEwEFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHEqAlLhjd9S4MMKeqvo97ph7nZ+D+uFeMPd7fmAR0g=;
 b=Ob2o82KrO0BYj8emGRLDFiWEcIGqmf9f058qGf67dwp3xaDv07s9hVwG6eGz0ILTT5rc28WjHhHYZheKQE1aje0Wv1LtEBGya+csMuU8sn3jAVSugbPzMtE6hm3RxQnEwN1bJGL7wrUYaYDGOucMX8qAcwRRKndM0sH7blFcxp8gaHHfNL9udvTkDLGKVEWn5NEwYX1Dv/nXnAqqUJ56iiZt9OndnXEe9e9P0IOWtWjktWMt6X8vxyMt1D20g8b9fBPrllV3DJFo+A38si7IVMYaifTE44nTxxOmT/LnZDn4I7U886DkcKtZ54AZvcngUq+X99Q9+q0WzR5PervtUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHEqAlLhjd9S4MMKeqvo97ph7nZ+D+uFeMPd7fmAR0g=;
 b=fqpu9/8e6r9/ju/o9L38r+vowOOg8KZrjgQ/fiegVjJDQR4TB6lbNODOgHTIfVfTbkjH6iCAeMlKdqJgF+cO1HC2f5a5oGFhTvIDtUXpI/Uu12fzSqoD+E33MzfnBxrl9K6KJxonaiHAUAAs27W2hsnWh4AQ6oHWNjU3hln0b/4=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB5634.apcprd03.prod.outlook.com (2603:1096:820:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5; Wed, 11 Aug
 2021 09:01:53 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 09:01:52 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ikjn@chromium.org" <ikjn@chromium.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
Subject: Re: [RFC PATCH] usb: xhci-mtk: handle bandwidth table rollover
Thread-Topic: [RFC PATCH] usb: xhci-mtk: handle bandwidth table rollover
Thread-Index: AQHXjPzqwpeGZOWapUiNHdL7bl5Aqatq4ykAgAAIfYCAAxloAA==
Date:   Wed, 11 Aug 2021 09:01:52 +0000
Message-ID: <7b48f4c132a8b4b3819282e961fbe8b3ed753069.camel@mediatek.com>
References: <20210809165904.RFC.1.I5165a4a8da5cac23c9928b1ec3c3a1a7383b7c23@changeid>
         <YRDxTodNNqtnpPpn@kroah.com>
         <CAATdQgDSCzZtiDSQk94CYHfSb9Mq28OH7-RdaTZNv3oPrW3nkQ@mail.gmail.com>
In-Reply-To: <CAATdQgDSCzZtiDSQk94CYHfSb9Mq28OH7-RdaTZNv3oPrW3nkQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 721dc5ca-0ae3-4d14-dc47-08d95ca6a99d
x-ms-traffictypediagnostic: KL1PR03MB5634:
x-microsoft-antispam-prvs: <KL1PR03MB56341845E69850F99CCDFD56FDF89@KL1PR03MB5634.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mzc6ZMqVPqa4nSgNPGfjLR9O+75kns/FV9m2ZLHW3w6ozwVzFzU9AS/OrUgA+QROAT4abZHWsI7Jd0y91Fjfqts7G8iJg/yGgLbWV5YVntfYxA4MkKJ60RjCSCXoSPDps3WopQjtbHtZGeOks7eYqJDqR9qaj5+J7RCrFvJ2LDwyfg8TdFCpjChQhFB2vJkAY3xaRxCRyJQRBcSgUBVtNZmEvOPWa+IbbIICJwbZUfOY/AO+H04ZdzGPB3GAc2Syt5Zfe+uYZEgvP401Jr6midK3igYvF/VNecgGKvF1Z/RVoI+Y4oXAlXU9x4QTud/W4TdSaHAAWIi+G8QATpNw4fynWZ1PWrPQbHzY6Lrc/ZrTawk/EEtVrFtIQSZMP9KzolkhPvzxsCwqT3Vk+2G4pn6+Tb6DU+rHbrWyinx7iQivZxix138RTNjwe/9sZGFTI3Sdly0X+FyPKO7maugzMD9mmZxfA8rni0+Jxv7sv4gdwuasYgbiGyHczj8CaxDQ9G/LUZDgpT/usCIDRK+/swwrkIgyTKNdQ0yvU3A8w4y/+N8NE0SaeE8k04CKgq/OMr3d0Ge5Gl+tKzDgWOYcJf5k0Nf6mH+8piZut+iENLpb++8oTiIYCGI3ZshrAqGD3lbQOyWEKv9dLvOUsIIR1rsPFDPRN83Vbk3t3dMXPhovQwxinYmo6s56pKFi1VKDRjsasPAaTtC63QWopAov0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(86362001)(66446008)(53546011)(2616005)(76116006)(5660300002)(6506007)(66556008)(186003)(91956017)(85182001)(83380400001)(66946007)(66476007)(110136005)(6512007)(26005)(8676002)(54906003)(2906002)(6486002)(64756008)(36756003)(38100700002)(316002)(4326008)(508600001)(8936002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnM4NzFYOXBubytMUnlzS0FaOFdtSzZsMytDTG9qaWhLOXV3eURDZStkR00r?=
 =?utf-8?B?WERKeHl6cDV3ZlVpaFdLT0pONWZSR21uNzR5WG9OTG43TElMSUlRcTVDenhn?=
 =?utf-8?B?cWhBTCtVRVFmYnhwTkxuOWRJOFo5dXZvZExjcEZmRlQ2dmdQdzFVVXJjR2ZQ?=
 =?utf-8?B?R295WjJiazFMblZGT3Z3Q05hZ1g4ZHZ0OEd4MCtLdU1WMVdXbU1ITkw0RVpi?=
 =?utf-8?B?cDc0YTNhYjJ6bEthbElrWWZIQ1Bkc0pwb0I0K3Z2TlFPbTNqYmFSMEt3RFVS?=
 =?utf-8?B?dk04YzIvTHI3RVAyV1dSRTByNFNwUnJsbEQ2cXBESUFHc3VxTDQ2a3RrSXJR?=
 =?utf-8?B?R2FJUWNjZDBiYmNOQ1FoZ2NKRlU1NWcyRjhWMzc0M1JtUTBiTHJnM1VZZ2pT?=
 =?utf-8?B?Rk1jQm1iVzhkeDUyWE8vTUhTaXk3U1JlblgwZ2tMTzlMYzg5Qk93bFkwRE0z?=
 =?utf-8?B?V0xXWnp4TUlTbVhOM0FOWlUxaGRUT1JvQ3BxcE9DNS9XbHhKWk4xalF5clJv?=
 =?utf-8?B?N3dDeitjRmY2S0lmbzRzYWo5K01pcCtzek81Y3kxSFFyZjJLZVR4TlhRVWFF?=
 =?utf-8?B?RXBMVE1HSU8xNCtJL2ttcG1GenFxM1htTTNwYTlKMDlPYTdGQm40ZUtOaWRL?=
 =?utf-8?B?cGYwdWR5NVFHRmJYaENablRqeEozZUVFeTlza1dnL2s0VE12K2pYdzZTVjBU?=
 =?utf-8?B?UVZtV0pqSzJZdjFCd1pKeEJzRXlFOVFCbVF4Mk5zeEo4RlVIRm5SNUJGNzVa?=
 =?utf-8?B?VjhWWkptS1pqOC8yZnl6VERqRzkvb01Sd29GKzhVOVRncVgyaEZUaFpsSGpp?=
 =?utf-8?B?MFJ2MTRFVXlQVVdWK2Q3UkhxTkdGdWpWak11T2JMT3RHRmdMUFJXTHZFa0Yw?=
 =?utf-8?B?djdhTFFycHlqQ0xnRGNIWjRBV0ZzUVNkWVRrVm5DVkdQQUFhaVlJcXZkTldi?=
 =?utf-8?B?ekVUQVlPN3V3WXhOZ3RFejMwVmlUYUxlNU1UWVdQWHplbTBGT284WXBxWm52?=
 =?utf-8?B?Ujc4Smo5eUttY1N5cHpOOVNxS0RYWXZUeml5L05CVnQxZjNFbks1N3I3d0Qx?=
 =?utf-8?B?aDR1NFZHMG5IQ2o1NnBLVU1od3VSb0FIdXpnZEh5ZW9qU01OTW1teWplYW4y?=
 =?utf-8?B?M09WZ0x1UW5xOUJBczhZZW1HSnduMEJ2cnhmOVRTVVdScUZlaGRyekRWZ3Zz?=
 =?utf-8?B?U0Q5cWZWWG1TdVJCc3NRTUZUR2VHanI2K3RacTREV2JOMXVZMUU3MDhOb1Bq?=
 =?utf-8?B?b3krRTZVV05yZkxSYWFXYnZZaG9BQjV4U0R2Tk5rM3FHekV3ZENkNmEzRWlB?=
 =?utf-8?B?ZUJtWFA3cTVEQitOQ0JSbVR1VSt5NUFDSy96Q09MTHgvKzJlS1NqUXVNbk1K?=
 =?utf-8?B?b2lnMXl1VTF4NnI1STNMc2NWcUVPOVUvS1EraGNtRXRzV2cwL21XVDJvQTdq?=
 =?utf-8?B?WXlkVllLQk54TEtGQkpoT1dCK2NaMFVTQ2xMRTBxZzRxTzd6b0tWRzFkazd4?=
 =?utf-8?B?ZEtCUE9nMXlJTmh5V1RtQ2tHRFFsdEIreS8rYzFMTkxneUJvVnZpTWN5R3Nm?=
 =?utf-8?B?Tzgvc2lWWEpmc1FLck5jcEpXeFVBNjFoZ3o5SUtnRmhyN1Z4RUtCRmJJc0ZT?=
 =?utf-8?B?UHRJVHpDYWZhcTVtVGJmbkc0SjllVC9rd0grOEhOWjRoM0dFTUdoaHVvMCtR?=
 =?utf-8?B?L0xrZ1cyQnN1U28zR0dUUUcxRVhTYzh0U2VpV3hUNEZMc1FMenI5b0xlZEtO?=
 =?utf-8?B?Vngzem5IWGxCaU1kcHFrZy9oZWFHOU9mdldJUHN2STN2Y3BkOWM4U05ic3Rn?=
 =?utf-8?B?bm9uK2M1T05NdkFra2diZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A3328DC5CCD63449FADF39844B4BA1E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721dc5ca-0ae3-4d14-dc47-08d95ca6a99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 09:01:52.7918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/IeAvuA3iKEHaFk6rIN3JPIh64aaFAlKB9BIsXMM4vRumfamvdj8HMY+w9zM+hxiNEbJAAxfnkyAwORb/UwyRxx0XX/MaawTbH0MBWCmcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5634
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTA5IGF0IDE3OjQyICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gTW9uLCBBdWcgOSwgMjAyMSBhdCA1OjExIFBNIEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgQXVnIDA5
LCAyMDIxIGF0IDA0OjU5OjI5UE0gKzA4MDAsIElram9vbiBKYW5nIHdyb3RlOg0KPiA+ID4geGhj
aS1tdGsgaGFzIDY0IHNsb3RzIGZvciBwZXJpb2RpYyBiYW5kd2lkdGggY2FsY3VsYXRpb25zIGFu
ZA0KPiA+ID4gZWFjaA0KPiA+ID4gc2xvdCByZXByZXNlbnRzIGJ5dGUgYnVkZ2V0cyBvbiBhIG1p
Y3JvZnJhbWUuIFdoZW4gYW4gZW5kcG9pbnQncw0KPiA+ID4gYWxsb2NhdGlvbiBzaXRzIG9uIHRo
ZSBib3VuZGFyeSBvZiB0aGUgdGFibGUsIGJ5dGUgYnVkZ2V0cycgc2xvdA0KPiA+ID4gc2hvdWxk
IGJlIHJvbGxlZCBvdmVyIGJ1dCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBkb2Vzbid0Lg0K
PiA+ID4gDQo+ID4gPiBUaGlzIHBhdGNoIGFwcGxpZXMgYSA2IGJpdHMgbWFzayB0byB0aGUgbWlj
cm9mcmFtZSBpbmRleCB0bw0KPiA+ID4gaGFuZGxlDQo+ID4gPiBpdHMgcm9sbG92ZXIgNjQgc2xv
dHMgYW5kIHByZXZlbnQgb3V0LW9mLWJvdW5kcyBhcnJheSBhY2Nlc3MuDQo+ID4gPiANCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IElram9vbiBKYW5nIDxpa2puQGNocm9taXVtLm9yZz4NCj4gPiA+IC0t
LQ0KPiA+ID4gDQo+ID4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYyB8IDc5ICsr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+IC0tLS0tLS0tDQo+ID4gPiAgZHJpdmVycy91
c2IvaG9zdC94aGNpLW10ay5oICAgICB8ICAxICsNCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIz
IGluc2VydGlvbnMoKyksIDU3IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IFdoeSBpcyB0aGlzICJS
RkMiPyAgV2hhdCBuZWVkcyB0byBiZSBhZGRyZXNzZWQgaW4gdGhpcyBjaGFuZ2UNCj4gPiBiZWZv
cmUgaXQNCj4gPiBjYW4gYmUgYWNjZXB0ZWQ/DQo+IA0KPiBzb3JyeSwgSSBoYWQgdG8gbWVudGlv
biB3aHkgdGhpcyBpcyBSRkM6DQo+IA0KPiBJIHNpbXBseSBkb24ndCBrbm93IGFib3V0IHRoZSBk
ZXRhaWxzIG9mIHRoZSB4aGNpLW10ayBpbnRlcm5hbHMuDQo+IEl0IHdhcyBva2F5IGZyb20gbXkg
dGVzdHMgd2l0aCBtdDgxNzMgYW5kIEkgdGhpbmsgdGhpcyB3aWxsIGJlDQo+IGhhcm1sZXNzDQo+
IGFzIHRoaXMgaXMgImJldHRlciB0aGFuIGJlZm9yZSIuDQo+IA0KPiBCdXQgd2hlbiBJIHJlbW92
ZWQgZ2V0X2VzaXRfYm91bmRhcnkoKSwgSSByZWFsbHkgaGF2ZSBubyBpZGVhIHdoeQ0KPiBpdCB3
YXMgdGhlcmUuIEknbSB3b25kZXJpbmcgaWYgdGhlcmUgd2FzIGFub3RoZXIgcmVhc29uIG9mIHRo
YXQNCj4gZnVuY3Rpb24NCj4gb3RoZXIgdGhhbiBqdXN0IHByZXZlbnRpbmcgb3V0LW9mLWJvdW5k
cy4gTWF5YmUgY2h1bmZlbmcgY2FuIGFuc3dlcg0KPiB0aGlzPw0KV2UgdXNlIEBlc2l0IHRvIHBy
ZXZlbnQgb3V0LW9mLWJvdW5kcyBhcnJheSBhY2Nlc3MuIGl0J3Mgbm90IGEgcmluZywNCmNhbid0
IGluc2VydCBvdXQtb2YtYm91bmRzIHZhbHVlIGludG8gaGVhZCBzbG90Lg0KDQo+IA0KPiBUaGFu
a3MhDQo+IA0KPiA+IA0KPiA+IHRoYW5rcywNCj4gPiANCj4gPiBncmVnIGstaA0K
