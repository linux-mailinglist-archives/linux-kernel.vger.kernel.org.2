Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2D3E8ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhHKHKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:10:37 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41674 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235119AbhHKHKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:10:35 -0400
X-UUID: 2b2ca38242474a009c7dfbb3ddee3f6c-20210811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PkvKZFibJYOq63p31tEfFVHxGuXlHkUq4H3AlBPzjsY=;
        b=jaIlLXZEAjc5VrHw+Q/T5EabjWcPJpRNcJS5nvW73GGGPPOQQaUNreNv6hMXU28iKbN//jSDwq9iq0GPytVg/F8klJ7fdWkOXYQM4UXq8Qgd1gXP5im5/uqqxrU7HhM8YhcRuM+NTOoxMhcV85wR1v9NZ6yaf0mSjdQUJ/v5CRs=;
X-UUID: 2b2ca38242474a009c7dfbb3ddee3f6c-20210811
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1538001369; Wed, 11 Aug 2021 15:10:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 15:10:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkcas07.mediatek.inc (172.21.101.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 15:09:59 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 11 Aug 2021 15:09:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Opz4RAcUDieahXyosFlLst1Y85tJTO11J9UBA7N7sNQI2VVdYPE1XnerLbLfVF/KC5gq+9cb8KukIek6Fqpznxtjpx45N8s/cnzHJ/pZe6lhI3Nj+EE0CVjOkfg1aQlQfQ1Zv7b+4ZOXLbekNLnUz9eY7iAQ6N9E23EK95xDJH1qNtk+Z/jsUwnTMBPb1cD/I0NtsQ0g4qnCAxrhBLAsej8T9L4Bwaky4Cd2g8OZR5o8jvTPXmoN8wBXeltMD1tl6/2Dx79NXclj0kK0hWM6jEezLIjI5v5hksKT3g7ktWh4iagPVMwUV8a8qLXwa1ZV9ywN8r2ZU7LPI4uO+UkgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkvKZFibJYOq63p31tEfFVHxGuXlHkUq4H3AlBPzjsY=;
 b=a5V0ISL2q9Sty3a/3BBD1O+ArXMH9LESme4xrnuqhYTYA2Y52c7SYYxn6vpoUnNjZjXUldnxAOvBbwXd0y9V00lkbg44CZNab6UARW2BMqb4zHakg7mgXw0OmA5zUrKm0qF3sSYa5/k9yv2FLXLfwHNQX4qE0ct6WfJMzFm/VJzpsIOSWTMjsorlPaGWb15fuyss7wTRiX1UGNjgfx4lW4JL7kejS2CjV21oScqlXElpsRDOf4oBoH5jOjxVjuLKIK2uTMwtrQ/u1qofl7GPPVy/gMvILIuwmrF6Ar0EfAZLXcKuYw/H4BcruxHASLlTWbeZVyyuJsPMFT5eG2/NXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkvKZFibJYOq63p31tEfFVHxGuXlHkUq4H3AlBPzjsY=;
 b=qKpHVlRTfad7XIkEgiL4xm6CWfbg2A5a+hGgpyALsMJMrJOtI+ceg4C39/IKGI/uLKZ1ck8+Sol5t1ujUG129ss9vxJpSYeInDs6O32EgL6J9zHhF/egCEUL/jpnYRVntwL33T4lCGn/i64O6bFR7nn8IMW1iKs9igTT3fNBplM=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB5569.apcprd03.prod.outlook.com (2603:1096:820:5e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.9; Wed, 11 Aug
 2021 07:09:48 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 07:09:48 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: xhci-mtk: relax TT periodic bandwidth allocation
Thread-Topic: [PATCH] usb: xhci-mtk: relax TT periodic bandwidth allocation
Thread-Index: AQHXibx4IFarZRbj3ECFB3Gy0get7Ktt7EQA
Date:   Wed, 11 Aug 2021 07:09:48 +0000
Message-ID: <269c9a997cb4d3362fc111ed1efe0bd7eb6ac817.camel@mediatek.com>
References: <20210805133937.1.Ia8174b875bc926c12ce427a5a1415dea31cc35ae@changeid>
In-Reply-To: <20210805133937.1.Ia8174b875bc926c12ce427a5a1415dea31cc35ae@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8af93386-672e-426f-85cd-08d95c9701a5
x-ms-traffictypediagnostic: KL1PR03MB5569:
x-microsoft-antispam-prvs: <KL1PR03MB55690B173F2DBDE322099F64FDF89@KL1PR03MB5569.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Zt05mdPc3rxS/F/bK9OiFiHl+G7EJN6HAyXP4K0ZAYttQmH6qnOOSDZToNUThhfXv0FPG8cmAevwtUV4I596Ng+q9/+F6ugNwJIAsN3X34GSQNkPRtm9fQYjCvM/IYQ+obZbQ7KPt8hITJoQ/JyHV6mdiSJfPlrNCrxWjgL9EnWH1RXxrgAWouFgiw46s7Nhsh4n0nSZaktX+nvOiSSl0/FZ8bdIMfbI14z9wGOKrN2WdNhsj2lbrmmsVuvXTr1CnQR6Pt55gvL3JyKsy0+1QuykDc6SypWD6qmrq6PgzOoyI5qz/jZeZKkBCGvPADl135Nwrq82ccWCE2Yi1fLkwA6ldEzfV8lthxNzOpqHjqs90TNxrwY79H1vX6TOt0TR6c0E8RmrFTivGoOA92/Ht1bCZ0LGOraVkrcD4gYHAkV/S3vjPwLY5iquvQgif8Vczbo8Z6EZQQBOi+WAm6EhqZKoItNx4cztXdNIe4bnVfUi7PadDbxqFP+zyxwVW5hOQ64GFdkNVkoNLHAX/GZ+1HAy1lY3Xr+cb9f0h9SPgG61DCo7Euh6Ty/Ue24WgmpOMY9G0rgSHO+acJvpp9FXWkcB6Vao9E+W6R3/YXQEazbaAuTuVBO4snPGeFQ3wtFWFBO8+ScXkUL8ERIYRZ19iDx1j0gq5TmjoBhzK0tSqCcul8HiPQPsPI0nXD43y1cW85cV25GAQ+Rtxh6V76K9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(85182001)(91956017)(498600001)(8936002)(38100700002)(8676002)(76116006)(66476007)(38070700005)(122000001)(66946007)(2616005)(83380400001)(66446008)(2906002)(36756003)(186003)(64756008)(66556008)(26005)(6506007)(86362001)(6512007)(71200400001)(4326008)(6486002)(5660300002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVhNbWJFYXU5cE9FRXo5ejY2RGpYZnNWb3lQK2RKa2dZRmlpdWtFZ3RoMGhO?=
 =?utf-8?B?VmhFYTlTT0NiQi9JTFdJa1p5MVNDT3I2REJtUytqQk4zK3AwVEcxQjkzT2M4?=
 =?utf-8?B?Z2w3ZitzQUVWdmhESkYwazJ5SVVsVjM0RU8yTVdyOGJvVUNGWEZ2Zk1nY3Fa?=
 =?utf-8?B?SXQ3Yll2cWxaaW5vd0hmMm5lTXJrYmRZd3hUcFNFNUw3TEFlbFh3Mkx1Wmk0?=
 =?utf-8?B?R2RsRWljWTFwMWo3YkQ5d0IrQVFWK05aWmp3MCtGb2QrSXkyL3hIM201RDVm?=
 =?utf-8?B?V2cxK2dOa2t5TCtvVTRIdmNyd1QzQWVQWUJ2ZzJMaFRUTmlPUHc4WVloV0N1?=
 =?utf-8?B?Q2Q1bUJQMUVnMDcvNGgzem8xT1hUSnVxUmFrZDJnOEFrMmxQdUZ6ZlV2a0ZE?=
 =?utf-8?B?RllPcnJEejhEbjB5YVQwRElmUXhEQWxhWkdBc3IyWW9zdWs2RzZLblNQMDZq?=
 =?utf-8?B?aG4zZTNhN1ZlYlJVZFBJcFVjQThXb1ZpMFgyZitOU2RpenNHK0VHckx1RWQv?=
 =?utf-8?B?UldBbEVXUTFUL3dWZ2lVcURBSkhOR0NWeE13dkNJZ2IxclR6RWNJMC9RbnV2?=
 =?utf-8?B?WUpYYnRQUkJENG1aS0tuSlh4cEE0Z054WVZodDB4TGxxc0dhNnBhYkp2Z1NY?=
 =?utf-8?B?eFlTWjVOZU9LL01jTUVYSDVKV3hiKzQvenAxekpUTzZvQVVndzRqWk5QMnhD?=
 =?utf-8?B?WngyV2g3RE1WdEVpTmorWlhWeEF4T3ZvWi9XM2VCem5QUWlpWStoL3MrcnEv?=
 =?utf-8?B?VllCRDV4WGNPN0Rqc1hXWVh6Z1lpL1lnOFFDYkhON0tMT01xUTZESTFvbk1K?=
 =?utf-8?B?dGVRVWZMZnovYmFQZ0Z6aXFldkdiY2IzS29VTmhDNUxnK2hPMUxyaHVrSDRE?=
 =?utf-8?B?VEd6VlZlZ0xJUnQ2RGlEK2tJeGNpVmtVeHVxUlgzeDdhaHE4UEllVVFOMGdG?=
 =?utf-8?B?UWRlbkJ0SHZaNlkvUVdydHg2T1BhTFJ2OEV3MjFaSVUrbzdtY3pHdXYwVzJm?=
 =?utf-8?B?eTdYZTB4QWpaZlBaeDkxMk9MRERHNmdVc3dpTzZHU0hOdm96MFNoUWZHMWd1?=
 =?utf-8?B?SFo1eEpKMkNGMHM0TXBVaVZHaEJIREZoOWh6NGdaQTBIWTY5M0RmVXBGaWhR?=
 =?utf-8?B?bVNQVkVLU0JWdjFrTEtiWU5uYjhjbnF0TTR5Ykg4eDJiWDhHb2NLMHNSMys0?=
 =?utf-8?B?anNyTUNqZU1WTXIybHlrWVpCZlVWVWVRRlArTmc1bFQvTTZRUU9GMVNJSEU1?=
 =?utf-8?B?SFdWOWZqNEhBQkZ6eWVGd29YUUVnYVowRVNRbHJoNEJFek1aQUJQMkFWaDhw?=
 =?utf-8?B?T3FoWlJtNkR6MW1GQ003cDQ1SXJ6TC9xa1NTSVJpbEdxbnZRUGN2QjVGZGxv?=
 =?utf-8?B?UVU1VjNpN3FESFBtNHY0YjRMUUo2UjBtNzI2SlkwV3BSUVNYazh1cDhoa3RK?=
 =?utf-8?B?ajJyWTFFVU90UXIyV0ppS2RyWGM1TkIwK1NNTUY0T3ZFSVhyKzlDL2RGY2NE?=
 =?utf-8?B?MEpDNWF2cnJoblFoeWE0UTdGUGUxRzMrdWwxa3Z3R3c1TU9nZWsrR0xpZTlQ?=
 =?utf-8?B?Y091T3dwdVlxcGhSNjNsUW5HN1NlU0RyYlpjd0Z0NEJPT2hMZUp2YWR2Nno5?=
 =?utf-8?B?cG1JRGN2bmlHOTNrZUlrK3RFb2p2OGJrNlVEb1l3T2U1WjRhdGhHYTczTWpq?=
 =?utf-8?B?dUQ1dklIRVdkak9FVzZCbXlRcEFXUmE0cm1USVVsT2xoN2xHZ0VCYnhralZE?=
 =?utf-8?Q?pSj6yhGC69bWY5H1UjEmhlC4j9VG5Oa9kSJvP/V?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <10F78B1FD0F99848B469FD28B18FBFA7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af93386-672e-426f-85cd-08d95c9701a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 07:09:48.5248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44Hgs5nuJlHjnpH75FzYWKxeW6BjhUjQODtV14XCZlhhpah/m6FDYGYGmBa6EGK16PaJO5xq155/bI3EVqr/CjoK+FWNAIpVw2VbRjng2do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5569
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA4LTA1IGF0IDEzOjM5ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
Q3VycmVudGx5IHhoY2ktbXRrIG5lZWRzIHNvZnR3YXJlLW1hbmFnZWQgYmFuZHdpZHRoIGFsbG9j
YXRpb24gZm9yDQo+IHBlcmlvZGljIGVuZHBvaW50cywgaXQgYWxsb2NhdGVzIHRoZSBtaWNyb2Zy
YW1lIGluZGV4IGZvciB0aGUgZmlyc3QNCj4gc3RhcnQtc3BsaXQgcGFja2V0IGZvciBlYWNoIGVu
ZHBvaW50LiBBcyB0aGlzIGluZGV4IGFsbG9jYXRpb24gbG9naWMNCj4gc2hvdWxkIGF2b2lkIHRo
ZSBjb25mbGljdHMgd2l0aCBvdGhlciBmdWxsL2xvdy1zcGVlZCBwZXJpb2RpYw0KPiBlbmRwb2lu
dHMsDQo+IGl0IHVzZXMgdGhlIHdvcnN0IGNhc2UgYnl0ZSBidWRnZXRzIG9uIGhpZ2gtc3BlZWQg
YnVzIGJhbmR3aWR0aA0KPiBGb3IgZXhhbXBsZSwgZm9yIGFuIGlzb2Nocm9ub3MgSU4gZW5kcG9p
bnQgd2l0aCAxOTIgYnl0ZXMgYnVkZ2V0LA0KPiBpdCB3aWxsIGNvbnN1bWUgdGhlIHdob2xlIDQg
dS1mcmFtZXMoMTg4ICogNCkgd2hpbGUgdGhlIGFjdHVhbA0KPiBmdWxsLXNwZWVkIGJ1cyBidWRn
ZXQgc2hvdWxkIGJlIGp1c3QgMTkyYnl0ZXMuDQo+IA0KPiBUaGlzIHBhdGNoIGNoYW5nZXMgdGhl
IGxvdy9mdWxsLXNwZWVkIGJhbmR3aWR0aCBhbGxvY2F0aW9uIGxvZ2ljDQo+IHRvIHVzZSAiYXBw
cm94aW1hdGUiIGJlc3QgY2FzZSBidWRnZXQgZm9yIGxvd2VyIHNwZWVkIGJhbmR3aWR0aA0KPiBt
YW5hZ2VtZW50LiBGb3IgdGhlIHNhbWUgZW5kcG9pbnQgZnJvbSB0aGUgYWJvdmUgZXhhbXBsZSwg
dGhlDQo+IGFwcHJveGltYXRlIGJlc3QgY2FzZSBidWRnZXQgaXMgbm93IHJlZHVjZWQgdG8gKDE4
OCAqIDIpIGJ5dGVzLg0KPiANCj4gV2l0aG91dCB0aGlzIHBhdGNoLCBtYW55IHVzYiBhdWRpbyBo
ZWFkc2V0cyB3aXRoIDMgaW50ZXJmYWNlcw0KPiAoYXVkaW8gaW5wdXQsIGF1ZGlvIG91dHB1dCwg
YW5kIEhJRCkgY2Fubm90IGJlIGNvbmZpZ3VyZWQNCj4gb24geGhjaS1tdGsuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBJa2pvb24gSmFuZyA8aWtqbkBjaHJvbWl1bS5vcmc+DQo+IC0tLQ0KPiANCj4g
IGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMgfCAyMCArKysrKysrKysrKysrLS0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYyBiL2RyaXZl
cnMvdXNiL2hvc3QveGhjaS0NCj4gbXRrLXNjaC5jDQo+IGluZGV4IGY5YjRkMjdjZTQ0OS4uNDZj
YmY1ZDU0ZjRmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5j
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMNCj4gQEAgLTQ1OSwxNiAr
NDU5LDE3IEBAIHN0YXRpYyBpbnQgY2hlY2tfZnNfYnVzX2J3KHN0cnVjdA0KPiBtdTNoX3NjaF9l
cF9pbmZvICpzY2hfZXAsIGludCBvZmZzZXQpDQo+ICAJdTMyIG51bV9lc2l0LCB0bXA7DQo+ICAJ
aW50IGJhc2U7DQo+ICAJaW50IGksIGo7DQo+ICsJdTggdWZyYW1lcyA9IERJVl9ST1VORF9VUChz
Y2hfZXAtPm1heHBrdCwgRlNfUEFZTE9BRF9NQVgpOw0KPiAgDQo+ICAJbnVtX2VzaXQgPSBYSENJ
X01US19NQVhfRVNJVCAvIHNjaF9lcC0+ZXNpdDsNCj4gKw0KPiArCWlmIChzY2hfZXAtPmVwX3R5
cGUgPT0gSU5UX0lOX0VQIHx8IHNjaF9lcC0+ZXBfdHlwZSA9PQ0KPiBJU09DX0lOX0VQKQ0KPiAr
CQlvZmZzZXQrKzsNCj4gKw0KPiAgCWZvciAoaSA9IDA7IGkgPCBudW1fZXNpdDsgaSsrKSB7DQo+
ICAJCWJhc2UgPSBvZmZzZXQgKyBpICogc2NoX2VwLT5lc2l0Ow0KPiAgDQo+IC0JCS8qDQo+IC0J
CSAqIENvbXBhcmVkIHdpdGggaHMgYnVzLCBubyBtYXR0ZXIgd2hhdCBlcCB0eXBlLA0KPiAtCQkg
KiB0aGUgaHViIHdpbGwgYWx3YXlzIGRlbGF5IG9uZSB1ZnJhbWUgdG8gc2VuZCBkYXRhDQo+IC0J
CSAqLw0KPiAtCQlmb3IgKGogPSAwOyBqIDwgc2NoX2VwLT5jc19jb3VudDsgaisrKSB7DQo+ICsJ
CWZvciAoaiA9IDA7IGogPCB1ZnJhbWVzOyBqKyspIHsNClBsZWFzZSBkb24ndCBjYWxjdWxhdGUg
bmV3IHZhbHVlLCBzaG91bGQgdXNlIHRoZSB2YWx1ZSBjYWxjdWxhdGVkIGJ5DQpjaGVja19zY2hf
dHQoKS4NClNlZSB1c2IyLjAgc3BlYyBGaWd1cmUgMTEtNjQsIHNvbWV0aW1lIHdpbGwgdXNlIDIg
ZXh0cmEgQ1MuDQoNCj4gIAkJCXRtcCA9IHR0LT5mc19idXNfYndbYmFzZSArIGpdICsgc2NoX2Vw
LQ0KPiA+YndfY29zdF9wZXJfbWljcm9mcmFtZTsNCj4gIAkJCWlmICh0bXAgPiBGU19QQVlMT0FE
X01BWCkNCj4gIAkJCQlyZXR1cm4gLUVTQ0hfQldfT1ZFUkZMT1c7DQo+IEBAIC01NDYsNiArNTQ3
LDggQEAgc3RhdGljIHZvaWQgdXBkYXRlX3NjaF90dChzdHJ1Y3QgbXUzaF9zY2hfZXBfaW5mbw0K
PiAqc2NoX2VwLCBib29sIHVzZWQpDQo+ICAJdTMyIGJhc2UsIG51bV9lc2l0Ow0KPiAgCWludCBi
d191cGRhdGVkOw0KPiAgCWludCBpLCBqOw0KPiArCWludCBvZmZzZXQgPSBzY2hfZXAtPm9mZnNl
dDsNCj4gKwl1OCB1ZnJhbWVzID0gRElWX1JPVU5EX1VQKHNjaF9lcC0+bWF4cGt0LCBGU19QQVlM
T0FEX01BWCk7DQo+ICANCj4gIAludW1fZXNpdCA9IFhIQ0lfTVRLX01BWF9FU0lUIC8gc2NoX2Vw
LT5lc2l0Ow0KPiAgDQo+IEBAIC01NTQsMTAgKzU1NywxMyBAQCBzdGF0aWMgdm9pZCB1cGRhdGVf
c2NoX3R0KHN0cnVjdA0KPiBtdTNoX3NjaF9lcF9pbmZvICpzY2hfZXAsIGJvb2wgdXNlZCkNCj4g
IAllbHNlDQo+ICAJCWJ3X3VwZGF0ZWQgPSAtc2NoX2VwLT5id19jb3N0X3Blcl9taWNyb2ZyYW1l
Ow0KPiAgDQo+ICsJaWYgKHNjaF9lcC0+ZXBfdHlwZSA9PSBJTlRfSU5fRVAgfHwgc2NoX2VwLT5l
cF90eXBlID09DQo+IElTT0NfSU5fRVApDQo+ICsJCW9mZnNldCsrOw0KPiArDQo+ICAJZm9yIChp
ID0gMDsgaSA8IG51bV9lc2l0OyBpKyspIHsNCj4gLQkJYmFzZSA9IHNjaF9lcC0+b2Zmc2V0ICsg
aSAqIHNjaF9lcC0+ZXNpdDsNCj4gKwkJYmFzZSA9IG9mZnNldCArIGkgKiBzY2hfZXAtPmVzaXQ7
DQo+ICANCj4gLQkJZm9yIChqID0gMDsgaiA8IHNjaF9lcC0+Y3NfY291bnQ7IGorKykNCj4gKwkJ
Zm9yIChqID0gMDsgaiA8IHVmcmFtZXM7IGorKykNCj4gIAkJCXR0LT5mc19idXNfYndbYmFzZSAr
IGpdICs9IGJ3X3VwZGF0ZWQ7DQo+ICAJfQ0KPiAgDQo=
