Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9563E50B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbhHJBpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:45:55 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38240 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232781AbhHJBpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:45:54 -0400
X-UUID: 74a53627804248ed8d0774207229dd8f-20210810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nds5HKnrFon2Eb8PE4QjW+EmntRxSjvivLwn3tmv/kI=;
        b=r6d1Qaaa89lS6LwKyW2KBzm0RkxMa2OPoE6XHyM9Al1CkkKO6N1IQ/u1hNF6mIuiZ8TulS8J+1SMKXdDCyht7VAezVQFEkzp+Nxn/ESnWP8u4U/aNuPbEu9H4gHCx5x3s2Wiu2Z10Go9lSuflT0jLCUt4dc+SRQPnReCzgDK2HE=;
X-UUID: 74a53627804248ed8d0774207229dd8f-20210810
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2102577345; Tue, 10 Aug 2021 09:45:29 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Aug 2021 09:45:27 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 10 Aug 2021 09:45:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpiCkgiGWf1wfCflarMZTt8d03wY2fQO8lj5mN9cv96DiXCND1Rex8bcG6SfVUrLcTvyLyXBg5ry0LYcQWFhvnV5m6VHyggJmIBT9Yl+EmvTfyNFWEKDFgGuaugflloAyV20LZL7emRPejgGaXEY7oZQj6cpEGCmJJ9c3BAJyjy8Unh8jSEt8UVhCUPiV5tjtc7ks8A2DCipcVnk5FE4trEmi9ENewIz8FRzU1HDDgJ/+8KiBQku0+NL01kdMkZJg06wAM+aDg0tWsYQo2fSMPwOb4pur6PR+3aeX0rxSmWqVAztDDjwUN76t50GjDDV3hpUiQosZSqTwUkc9ICz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nds5HKnrFon2Eb8PE4QjW+EmntRxSjvivLwn3tmv/kI=;
 b=PtS+MlK+taD8zAYfILM3qudEfJmhgXmsj4if1wr6klrxID6LrF480iPmpNrKnj7u3lHzWsdel/ZEpn/0dBaVMrBdPf0RG3iQpqOG3qwfO7q24aizXcKzr60ky58Ey+m77+NVTGy5cvNsm5lzI2PbMLZYTaK8glb/xITycwc4prWBGigfUq6jU31svbHnQtm4NF/FPvMavIObkbz9SW45xKyld1vWjsfP6I3g34u/8kNyFLqw9+snH/73mWuxRQQSX/QTXb86f9ADlD9ZWFUDkcWczbnT11B0J8iskSdvUfY1vcfv23gmIc5LfZBSeBfeepgsz8RHitDyadWcIDbzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nds5HKnrFon2Eb8PE4QjW+EmntRxSjvivLwn3tmv/kI=;
 b=mQpMRj81U5RpKvk2RQGfSHlaSKOak0imYjNkXGxIm2F1UmnNOLKVtvcML3nqBeH912eEZcrCmPXVVtn/OfTaTAWbAUPaNbtL1ZS1feyDnlyDX55cCdYGy6qOPfKIgdz2RQUfpKza9+qvJIXAon4V1FxOsi/A1fZq0tWXZCpjuSQ=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR0302MB2630.apcprd03.prod.outlook.com (2603:1096:802:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.9; Tue, 10 Aug
 2021 01:45:16 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4415.013; Tue, 10 Aug 2021
 01:45:16 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 08/11] usb: xhci-mtk: update fs bus bandwidth by
 bw_budget_table
Thread-Topic: [PATCH 08/11] usb: xhci-mtk: update fs bus bandwidth by
 bw_budget_table
Thread-Index: AQHXhSAdeZo+STGT8U6qm0O73EoaWqthUNEAgAGFmQCAAJMjgIAInu2A
Date:   Tue, 10 Aug 2021 01:45:16 +0000
Message-ID: <daf21b34135d3463aeff7e0a6e416e91c577fabb.camel@mediatek.com>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
         <1627635002-24521-8-git-send-email-chunfeng.yun@mediatek.com>
         <CAATdQgDWkohpzgr=z+uzro4m9Bd=v88DNnJ-M88-5-0annhH_w@mail.gmail.com>
         <1628054384.14982.12.camel@mhfsdcap03>
         <CAATdQgA9WeKr2UkrcAKY1rP22GtT0bMezdWkb-wyF9Yjx2p_9w@mail.gmail.com>
In-Reply-To: <CAATdQgA9WeKr2UkrcAKY1rP22GtT0bMezdWkb-wyF9Yjx2p_9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 860969e0-48de-4a74-959f-08d95ba080eb
x-ms-traffictypediagnostic: KL1PR0302MB2630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1PR0302MB263044CB535500A2F4D76199FDF79@KL1PR0302MB2630.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LOSeFvAwaAeqbZApNVqUu2cnfbrodORdVuOuhR0jQa/1uijUkbQyzVz4lUmEZGSPXpoA2gjE8+GCeyjTHmoUguw/zltPRNoD8f7aGaH30Ff1vXkxppvG7CENQVaMhGTdLBDfT4IMX4Ts23A6UBfFWC3ybyf2UGgAvbqEhC2Rj6J60k2EfH+iK1q/XHOZa5CLndx+19HCK83asD6J0QdG8KrkBvKbctG7EIONDOEyRaIHM1Kw/2V7te+R60ptyln+pPV0UidwHXzZocHKNxCwdl5mSCPqyjTV7xTcltM9VD1QDLSCSVLgZeJvxFsuv7BYBJbEzue0fwREfxfZ5OE6Xf0mMfai54p34kL3nuA6e8XaszFH1ZUEPqqMXLJCFer/wpIWqtFCEYxp1e6Jokgb6zRWtJfIbqKutS5hU1IGCzkKNbAW3FMimosaBSFQp9HtVHMZ7lGI4/3j8V+0jvttgv7S0wwT7lhNw6zGNFDndhbCcrCh90sND6y98IDe6iu0ymJ22TkiO0DIzDb//LyK5H88wRhJWn/Zjje1HAXw+8UkgPl2a2wbidVpbftuYNw4aG+cYyOO6vB/jaKNb5RKf60comdahEVQv9TftQZe+q4++cL1GeDXvwGHkOOe6V1S9+rycuRpqw5U5iJBNXIZz9wrItR2uy7j9LEeo05rUoVFyGafPxFXTQb9TtatvevltV5AkfG/zFGJ5GnicI4TgTLaljhHkQO4FwdRzq992rE2Fao8RT8p8h+b7xHQ/uOk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(71200400001)(53546011)(6506007)(6512007)(6916009)(26005)(86362001)(15650500001)(6486002)(4326008)(54906003)(5660300002)(36756003)(91956017)(508600001)(7416002)(85182001)(83380400001)(38100700002)(8936002)(186003)(122000001)(2616005)(66446008)(2906002)(38070700005)(8676002)(76116006)(66476007)(66946007)(66556008)(64756008)(473944003)(414714003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3hSL2UrYkRrRWQrZk5ySE5HeEc2UCs4WDI3L2E0ck1Yc0hLMFpzRVFRb2Ju?=
 =?utf-8?B?bWpjQnptK2pBK0puRmdqcS9YV2xkSkZ5ejBYV3hnOUJIUXNGM0xVZGZLRGRW?=
 =?utf-8?B?S1BYY0lWQUJqVmNiN05jWlBIWFk3MW5PNXh6K2Z5ZUh2NGdCL3FacWg2WXh2?=
 =?utf-8?B?R1lPZEVyZTEySnVZY2FjWDNzZ0diZHpGVlRJTngybE5kSmJEK0FpcFFHN1Ay?=
 =?utf-8?B?RlpTcnVGWTd0RXppSTI5RzlhcWhFNkxDemViTWR6VGJ0N29vZDFtTXVSWEor?=
 =?utf-8?B?Y1dFSTFKZEEvaVVNSllIbmhSVmdQczcwbzBZMVZJNGVWSHRGamVQWUZ3WnRp?=
 =?utf-8?B?ZURyS05FTW1pRWhpSVdZR1d0c2Jvemkrb3hXcE1yZzdjTGJEd2g3cUx3RnQ2?=
 =?utf-8?B?RVB5RmNyZzZDYWFZSkxndWJrbHBZYVF4dnRtN2pEZGVXeHJQOUZqazgrVFo2?=
 =?utf-8?B?NTVaa0J6UENORHhJSEhqSmp3cVQybUMwTTU0a01tZTA4VmhhTlI4cUg4Q1dH?=
 =?utf-8?B?S2hyNGtpWmZNdVg2Vk5HNStkYkJMMVBBUjNkVWdZcTFFVG0zU2JkTWxHdnVx?=
 =?utf-8?B?SmlpanlvZURLRlp4VHJ3aGJQajRMMHRadExseGFZa2VadGdaQkRzZlpWSFg5?=
 =?utf-8?B?OC9QcG9kL1VUMFpYZS9TaTVGTlRMdmxsTklzK2t2YTVXUi8wTk5kdEdhdTdn?=
 =?utf-8?B?UngzY2J5V2VqVWRsNXdFZWJFd0JyYmY1THRSNFdPV1RUMEZXeUZaOUI0ZmRC?=
 =?utf-8?B?OWlpZWJyeHpyRmJnS2dhZ3JtWFdDZ0RZTkQvMmYrQklJN3JRV0V6M1NVaURK?=
 =?utf-8?B?QjZib3haWmQ5VXhWalBla0xHdWFmZUZiNUVhMmJYR2pRZWozRUovM2pQVndi?=
 =?utf-8?B?Nnp6c1NoMTBiQWUwTWUycTQ4S3M2em9uSnk1cHN5Y0RXWnNYMWVUYm5zM0F1?=
 =?utf-8?B?YkxsNm5JWFpZRWZzYzhTOC8wQWszREtNcHFEZGlCNmkxOG8rUFpEbldXaUtB?=
 =?utf-8?B?SzJiSk1GWmNva1VPMnhoQjFsWnpFemlLeVVGR0RLQ0lBcHllQUp2NjkxR1Ri?=
 =?utf-8?B?MTc1UWN2YTRsZzFZdFZWY05CMlVNT2tIcHZtRTBPK3h6WE51eWcvWkVLZGZP?=
 =?utf-8?B?SVh4MVE0bDUyK3E1TURFbks4bkQ4SVU2ekZ4Nm8rdENhZzN4dDl5VmNGUEw0?=
 =?utf-8?B?eGpwM1NJQlRGb01GOHVHK2dLTy9qRnAvay96b2lXUXB2UzJjd0Z5R0twSUw4?=
 =?utf-8?B?WEE1RUhlN1U1OE4wQ0ZSWGhpLzFUQ1hHaDVZWXBJaEdNKzJUNmt3V2ZGNlgy?=
 =?utf-8?B?SWNkL2FIdndlWHg2WDRwQnJ1bWZrcFJ2b0NZRlNwVFMya0dlS0MwcUhGZWdv?=
 =?utf-8?B?UW5Oa3JlOWJaeUZFOWZFR3dGQlpRNldNSlpKM3FXUkU4Zm1IYVEyelM5VmtM?=
 =?utf-8?B?UFdUUzFsZW4xancwaHlKcTNONWF1bFVHaUcxN3FaUWR0K1BVbUlWUEhiUW9h?=
 =?utf-8?B?UCs2ZCtpc1EyblJLM1F3NlZhdzB2QUNvZUpIVVljVEJuWnc3eW5IL25nejdW?=
 =?utf-8?B?RkRST2JNZW1QaERicVUzSUJKQjRsUWE4NVZwejI4TVd0YlRVZlIwNGpzcHpY?=
 =?utf-8?B?WWlyTUJpdGp2bm9semZBVmpFbWQra1hwODNaakQ0SzBNeEthOS92UGJTR0I0?=
 =?utf-8?B?eEdRRDdjSllWdkpHSHJZRVMvZ3RQNmh3QXlaYWpQVTZJMFlCbTVQR1FMbmlR?=
 =?utf-8?Q?ohrvXq4wPDBcAVfeD+8bN1wOMiAMX5+fc+wvadR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CCB3645C502B74B8D16A2EBDFBBBC06@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860969e0-48de-4a74-959f-08d95ba080eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 01:45:16.3025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JzvR077AiCr75K2npqpgUkAZn8gv0SlRgFuoh5bgDIggf8BhhUn4kb8meBhuMBz8KtrCye79p7kQFpO3B10Eef3QadDi9gk7O5CypKFupM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB2630
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA4LTA0IGF0IDIyOjA2ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
SGksDQo+IA0KPiBPbiBXZWQsIEF1ZyA0LCAyMDIxIGF0IDE6MTkgUE0gQ2h1bmZlbmcgWXVuIDwN
Cj4gY2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAy
MDIxLTA4LTAzIGF0IDE0OjA1ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4gPiA+IEhpIENo
dW5mZW5nLA0KPiA+ID4gDQo+ID4gPiBPbiBGcmksIEp1bCAzMCwgMjAyMSBhdCA0OjUxIFBNIENo
dW5mZW5nIFl1biA8DQo+ID4gPiBjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4g
PiA+ID4gDQo+ID4gPiA+IFVzZSBAYndfYnVkZ2V0X3RhYmxlW10gdG8gdXBkYXRlIGZzIGJ1cyBi
YW5kd2lkdGggZHVlIHRvDQo+ID4gPiA+IG5vdCBhbGwgbWljcm9mcmFtZXMgY29uc3VtZSBAYndf
Y29zdF9wZXJfbWljcm9mcmFtZSwgc2VlDQo+ID4gPiA+IHNldHVwX3NjaF9pbmZvKCkuDQo+ID4g
PiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBt
ZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay1zY2guYyB8IDE3ICsrKysrKystLS0tLS0tLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5jDQo+ID4gPiA+IGIvZHJp
dmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYw0KPiA+ID4gPiBpbmRleCAwYmIxYTYyOTVkNjQu
LjEwYzBmMGY2NDYxZiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay1zY2guYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5j
DQo+ID4gPiA+IEBAIC00NTgsOCArNDU4LDggQEAgc3RhdGljIGludCBjaGVja19mc19idXNfYnco
c3RydWN0DQo+ID4gPiA+IG11M2hfc2NoX2VwX2luZm8gKnNjaF9lcCwgaW50IG9mZnNldCkNCj4g
PiA+ID4gICAgICAgICAgICAgICAgICAqIENvbXBhcmVkIHdpdGggaHMgYnVzLCBubyBtYXR0ZXIg
d2hhdCBlcA0KPiA+ID4gPiB0eXBlLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICogdGhlIGh1
YiB3aWxsIGFsd2F5cyBkZWxheSBvbmUgdWZyYW1lIHRvIHNlbmQNCj4gPiA+ID4gZGF0YQ0KPiA+
ID4gPiAgICAgICAgICAgICAgICAgICovDQo+ID4gPiA+IC0gICAgICAgICAgICAgICBmb3IgKGog
PSAwOyBqIDwgc2NoX2VwLT5jc19jb3VudDsgaisrKSB7DQo+ID4gPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgIHRtcCA9IHR0LT5mc19idXNfYndbYmFzZSArIGpdICsgc2NoX2VwLQ0KPiA+ID4g
PiA+YndfY29zdF9wZXJfbWljcm9mcmFtZTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGZvciAo
aiA9IDA7IGogPCBzY2hfZXAtPm51bV9idWRnZXRfbWljcm9mcmFtZXM7IA0KPiA+ID4gPiBqKysp
IHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdG1wID0gdHQtPmZzX2J1c19id1ti
YXNlICsgal0gKyBzY2hfZXAtDQo+ID4gPiA+ID5id19idWRnZXRfdGFibGVbal07DQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0bXAgPiBGU19QQVlMT0FEX01BWCkNCj4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVTQ0hfQldfT1ZFUkZM
T1c7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gPiA+IEBAIC01MzQsMjEgKzUzNCwx
OCBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfc2NoX3R0KHN0cnVjdA0KPiA+ID4gPiBtdTNoX3NjaF9l
cF9pbmZvICpzY2hfZXAsIGJvb2wgdXNlZCkNCj4gPiA+ID4gIHsNCj4gPiA+ID4gICAgICAgICBz
dHJ1Y3QgbXUzaF9zY2hfdHQgKnR0ID0gc2NoX2VwLT5zY2hfdHQ7DQo+ID4gPiA+ICAgICAgICAg
dTMyIGJhc2UsIG51bV9lc2l0Ow0KPiA+ID4gPiAtICAgICAgIGludCBid191cGRhdGVkOw0KPiA+
ID4gPiAgICAgICAgIGludCBpLCBqOw0KPiA+ID4gPiANCj4gPiA+ID4gICAgICAgICBudW1fZXNp
dCA9IFhIQ0lfTVRLX01BWF9FU0lUIC8gc2NoX2VwLT5lc2l0Ow0KPiA+ID4gPiANCj4gPiA+ID4g
LSAgICAgICBpZiAodXNlZCkNCj4gPiA+ID4gLSAgICAgICAgICAgICAgIGJ3X3VwZGF0ZWQgPSBz
Y2hfZXAtPmJ3X2Nvc3RfcGVyX21pY3JvZnJhbWU7DQo+ID4gPiA+IC0gICAgICAgZWxzZQ0KPiA+
ID4gPiAtICAgICAgICAgICAgICAgYndfdXBkYXRlZCA9IC1zY2hfZXAtPmJ3X2Nvc3RfcGVyX21p
Y3JvZnJhbWU7DQo+ID4gPiA+IC0NCj4gPiA+ID4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnVt
X2VzaXQ7IGkrKykgew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgYmFzZSA9IHNjaF9lcC0+b2Zm
c2V0ICsgaSAqIHNjaF9lcC0+ZXNpdDsNCj4gPiA+ID4gDQo+ID4gPiA+IC0gICAgICAgICAgICAg
ICBmb3IgKGogPSAwOyBqIDwgc2NoX2VwLT5jc19jb3VudDsgaisrKQ0KPiA+ID4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICB0dC0+ZnNfYnVzX2J3W2Jhc2UgKyBqXSArPSBid191cGRhdGVkOw0K
PiA+ID4gPiArICAgICAgICAgICAgICAgZm9yIChqID0gMDsgaiA8IHNjaF9lcC0+bnVtX2J1ZGdl
dF9taWNyb2ZyYW1lczsgDQo+ID4gPiA+IGorKykNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKHVzZWQpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dHQtPmZzX2J1c19id1tiYXNlICsgal0gKz0NCj4gPiA+ID4gc2NoX2VwLT5id19idWRnZXRfdGFi
bGVbal07DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0dC0+ZnNfYnVzX2J3W2Jhc2UgKyBqXSAtPQ0K
PiA+ID4gPiBzY2hfZXAtPmJ3X2J1ZGdldF90YWJsZVtqXTsNCj4gPiA+IA0KPiA+ID4gSSBhZ3Jl
ZSB0aGF0IHhoY2ktbXRrLXNjaCBzdGlsbCBoYXMgbW9yZSByb29tcyBmb3IgdHQgcGVyaW9kaWMN
Cj4gPiA+IGJhbmR3aWR0aA0KPiA+ID4gYnV0IEkgdGhpbmsgdGhpcyBhcHByb2FjaCBjb3VsZCB0
cmlnZ2VyIGEgcHJvYmxlbS4NCj4gPiANCj4gPiBTZWUgdXBkYXRfYnVzX2J3KCksIHdoZW4gYWRk
IGZzIGVwJ3MgYmFuZHdpZHRoLCBpdCB1c2VzDQo+ID4gYndfYnVkZ2V0X3RhYmxlW10sIHNvIHBy
ZWZlciB0byB1c2UgdGhlIHNhbWUgd2F5DQo+ID4gDQo+ID4gPiANCj4gPiA+IGZvciBleGFtcGxl
LCBpZiB0aGVyZSBhcmUgdHdvIGVuZHBvaW50cyBzY2hlZHVsZWQgaW4gdGhlIHNhbWUgdS0NCj4g
PiA+IGZyYW1lIGluZGV4LA0KPiA+ID4gKiBlcDFvdXQgID0gaXNvIDE5MmJ5dGVzIGJ3X2J1ZGdl
dF90YWJsZVtdID0geyAxODgsIDE4OCwgMCwgLi4ufQ0KPiA+ID4gLS0+IHkwDQo+ID4gPiAqIGVw
MmluID0gaW50IDY0Ynl0ZXMsIGJ3X2J1ZGdldF90YWJsZVtdID0geyAwLCAwLCA2NCwgLi4uIH0g
IC0tPg0KPiA+ID4geTANCj4gPiA+IA0KPiA+ID4gKElmIHRoaXMgaXMgcG9zc2libGUgYWxsb2Nh
dGlvbiBmcm9tIHRoaXMgcGF0Y2gpLA0KPiA+ID4gSSBndWVzcyB4aGNpLW10ayBjb3VsZCBoYXZl
IHNvbWUgcHJvYmxlbXMgb24gaW50ZXJuYWwgc2NoZWR1bGluZz8NCj4gPiANCj4gPiBUZXN0IGl0
IG9uIGR2dCBlbnYuIGRvbid0IGVuY291bnRlciBpc3N1ZXM7DQo+ID4gDQo+IA0KPiBBcyB5b3Ug
Y2FuIHNlZSBJbiB0aGUgYWJvdmUgZXhhbXBsZSwgdGhpcyBwYXRjaCBzdGFydHMgdG8gYWxsb3cg
dGhhdA0KPiBhbGxvY2F0aW9uLg0KPiBEbyB5b3UgbWVhbiB0aGF0IHdlIGRvbid0IGhhdmUgdG8g
d29ycnkgYWJvdXQgc3VjaCBhIGNhc2UgKG9uIGFsbCBNVEsNCj4gcGxhdGZvcm1zKT8NCk5vLCB0
aGF0IGlzIGFub3RoZXIgcXVlc3Rpb24sIHdoZW4gdXBkYXRlIGJ1c19id1tdIGFuZCBmc19idXNf
YndbXSBmb3INCkZTIHdpdGggVFQgc2hvdWxkIHVzZSB0aGUgc2FtZSBid19idWRnZXRfdGFibGVb
XSB3aGljaCBpcyBmaWxsZWQgaW4NCnNldHVwX3NjaF9pbmZvKCkuIElmIHRoZSBid19idWRnZXRf
dGFibGVbXSBpcyBzb21ldGhpbmcgd3JvbmcsIHdlIGNhbg0KcHJlcGFyZSBuZXcgcGF0Y2ggdG8g
Zml4IGl0Lg0KDQo+IA0KPiB0aGFua3MNCj4gDQo+ID4gVGhhbmtzDQo+ID4gDQo+ID4gPiANCj4g
PiA+ID4gICAgICAgICB9DQo+ID4gPiA+IA0KPiA+ID4gPiAgICAgICAgIGlmICh1c2VkKQ0KPiA+
ID4gPiAtLQ0KPiA+ID4gPiAyLjE4LjANCj4gPiA+ID4gDQo=
