Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6479D3A2599
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFJHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:40:34 -0400
Received: from mail-eopbgr1400080.outbound.protection.outlook.com ([40.107.140.80]:56240
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229634AbhFJHkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:40:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4ziWg5vh2QH4jvfwYWP6/fDnBYnOfNiHPUG/FwxKhqTGCzYTf9UgjHQq9Y8XfUixr02k5DfpQ+IDq21dWgt0I73PdfceGVdHybxNhS0UFoJlbqbzFSuNdB6m6KZ9UvUaKMrqLu6VqvLL2bIOz+E6ThgR2WDhfa2LkzpSDUqpt9ExnDkjB4kWya5Zj5kfXUZ8afUHBvGUrWEmybBR1B1h9Y0iK/cSgCZfmWIcY/zTFr2LF8ucaQ4fHZOSrxWyb+l+LXVBZZxmXFuzwNlyk+/IP127+qopMJWSOFIwk3X2B3TbtdJALXOaj1CB6te4LlBXn1ycOhKqKmjLaEMIXSlfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT2y4SiWAk8uxo90siRWlqwvIKjgO2g2Zx4p0elQIH8=;
 b=Nh62DOcpCzV3UC0dH9iAjmzNcQp1ZuHs2biGrsK4a3g8XbeNB7Td9tpKg6SCs8kVz8X+WbGRDwobiwuCzJmZShk7NAYJ58q7h5hcP+CmejbKTs2uCbuu/PYAdlty6DAXxoIusQpw/rEBsCmw1iTFe0AcpeJBruHdP43yiNDSVWnWCq8l6GIUtPcn95+JM1Ncr5RLfhi45NyZcF4+M1t5VZ/TWC6S2IhYQDV6tiSuhXhDcOfdJ4zaGNZos4wMeRUsVxyhYLL+sQgMKqY+cLhtzxrRzVxPZASTfneZOx5VkaKAfRs2qCU9Hvjtuieg9ZWXol++iSNl/fy30VHwJ01/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT2y4SiWAk8uxo90siRWlqwvIKjgO2g2Zx4p0elQIH8=;
 b=VDg8t5KyT1iGTLW4D8hIy9JTC4atg98VRLuDXZ+Pn8V7oQ+NAPFIClZQORdocvOS+f1NrflsneYjWP28VB/18bZvD/zfOOtdXBQoKgJXCFa5HoXlQ9Rjjz6iZTDw0aa0IBFWmvpH/D22aUWGhsNmqvMGMn+3OEVNr3TOG8pZwbI=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB5833.jpnprd01.prod.outlook.com (2603:1096:404:8055::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 07:38:35 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 07:38:35 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] mm: hwpoison_user_mappings() try_to_unmap() with
 TTU_SYNC
Thread-Topic: [PATCH v2 10/10] mm: hwpoison_user_mappings() try_to_unmap()
 with TTU_SYNC
Thread-Index: AQHXXOghAtEOjJw/6EyU2qDH2Ijr4qsM3WqA
Date:   Thu, 10 Jun 2021 07:38:35 +0000
Message-ID: <20210610073833.GA1196948@hori.linux.bs1.fc.nec.co.jp>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
 <329c28ed-95df-9a2c-8893-b444d8a6d340@google.com>
In-Reply-To: <329c28ed-95df-9a2c-8893-b444d8a6d340@google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 220ed4ee-04a2-40ce-5dd5-08d92be2c173
x-ms-traffictypediagnostic: TYAPR01MB5833:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB58337DFC5CB826078DE20C0FE7359@TYAPR01MB5833.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: koIZLFiXoKF6l6ZVkrfciiwyrDU3DMZkYbXW2YISLSCnHPiwUY3hXj1+YYqcbCSnkVmau8jth8gdRm1DcEnKBlIpceCFQGDcSfz06BWS12T2lqWp775+O0ojRyetFAxWkGuu7PpE/P9WcDBCqRpcI2dRVMo2Er5o6rNr2Xjx9lf1uZQTXYmr2Z/3Rr3Z+tDVEh3InBpU3nWgp/VGTVCeQGd0pQtEEu/N1U7TPWnljMMVfd55AkK5AxFE5ZHnUqWLEzZKG02lCNzwZdKw/U7OJYyltuUibU+pUok58brBePtZHSeoniRyM/g7Wdc24PrLLEmxuxFtfWNvrjwSpjhdrfCP5qvMSDSqWLs6rmhEnBHzq6npN7bDYuS/RCszycqw4xG3U2yy221MyGAaRoY4Cgrj8dqeObohaOGQRg3eCN1scxf1vuxOhl1G0QGFqQ3FPNXR7OjNDFUl11TMngk2SU1nLUXaBRl2w8okS2OjYobb/ilPcK3+icXRtFuhh2yeYJAwCX+qhJhEvfu1KUgGDNm9CWFotpj8v4o/1Scr2y/gpuzGsCNx2iGEuo7KrIfUFQq5IT5ZVhniCfMkQofGmOp9WAJyapFh4qVNLmPADBI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66446008)(6486002)(85182001)(316002)(38100700002)(33656002)(26005)(4326008)(186003)(478600001)(1076003)(66556008)(64756008)(66946007)(76116006)(66476007)(54906003)(5660300002)(6512007)(6916009)(55236004)(83380400001)(86362001)(8936002)(7416002)(4744005)(71200400001)(122000001)(8676002)(9686003)(2906002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MmF0OUZSVE5yQ1dub1NCZ0V1UGd0SnYyVVhxSVJUNDNERHJKcGtZckt6WXFr?=
 =?utf-8?B?YnA3WWFuanRwTWczd0Q4b3k2dnZadmt6QjA3RFFtTkU1anVudVdGT0VWcTRr?=
 =?utf-8?B?ektDdkk3emZ3RGlya2lUMXFzc3BUZGluSjRORmd3UFN2NGdVbTJUM3BwL2Rm?=
 =?utf-8?B?bkJiZHg3WUdnS1FRL2ZiYjJNQmh0NE41M21IKzFhbGNDYWxKd21UNHNVN252?=
 =?utf-8?B?emtBNnprWGVTaStSZVpOM0RvUEo1RllqNm03WFJzTngwRndmRWttT1BwQkoy?=
 =?utf-8?B?SDdRaHVHb3lOZkJIVXorMldxUVJIc0YzUjhpRXIzR1I2VldHaWJRaVZ2NWEv?=
 =?utf-8?B?ekpLNzlrYXpiTXV5SUZEeFNVbERGSHVxSWJVbU5qd3dXV1ovVVdEbzZIbXJo?=
 =?utf-8?B?ZXFuT3VEUmNnOUYrYW1PNTYvRFZXK0xlQ3NrU3NWK0QzZ0JWNHNzM0NKaitV?=
 =?utf-8?B?UWxacjdvMzNUZDRLQ0RJRVFGWEhNRnRTNVgwUmtRMzc1dTNwb1ROTDJaLzFX?=
 =?utf-8?B?YlgzUE5MWnFuYnBaR2paSXJNZFZYZlF5VFdFenlBN01uRGV5am9RTjg4K25u?=
 =?utf-8?B?ODF2UFAzR0JxUzJuWGJnc0NaM2lkVVlrdVNQRHl2b1oxQ3JiTzZ0eUQyM3No?=
 =?utf-8?B?K0VMWGJ1K2NPVHFMdjVSdW5jZUlLR3NJcDJ2TmxaNGdNZFlkU0o5UFdkOC94?=
 =?utf-8?B?djZWaGtSY2czYUxUTDdyZHdXSkJDaHJOVFRkeHN2a08ySWptbVBLVUNIYWZW?=
 =?utf-8?B?OVZFMjN6aTI1dGxWRzVyUXhRL1lMN0pybDhMbGRIa2ZTT1VIcGQyUDQ2eEs0?=
 =?utf-8?B?K09uNlp5QVhhL0R5N1NZeXdrS2V0ZEl1RnVDUlRialBWYkhHV2R5WHRsaHZK?=
 =?utf-8?B?THNyWitlQ2NKcmZ6eWM4UjZPYjhQSmJ1RHoyYjhxZTRQb0RIVHRYeEdpMXJi?=
 =?utf-8?B?aTREdXU4SS96ZmFCT2VpSTBJRWg3NHVlalJ3eVVCbnNzaE1DM2ZWcHJUZ3Er?=
 =?utf-8?B?a1VIbTFKN1dEU01FR2h2OG0wR2FBS0l5VTJuRXk1amc3RDNBdi9kS2xTTko4?=
 =?utf-8?B?cklnb0hGcmFoK0R4aEpVRUE0S2FHOGtEeWtZYkxtMFdOcmFTc0t5Snh0YlBP?=
 =?utf-8?B?UDNYYnJvdGZlRmIwdmZhY0ZpaThlN1RGR3VmQ1hVNGJDeUgvWWFhQlNBSGZn?=
 =?utf-8?B?NEhNYTcvSVRaSFBmVTRETmx1a2I4QWZNalIwSDZLbG9qQUJjajRWR09OdGds?=
 =?utf-8?B?KzFia0VScWhmMHU5ZElheVA1a25qa1ZpaE5tcW90OEFGcHVuSFVuTTRid2dC?=
 =?utf-8?B?U2VHejJPN3dscVppNElzUWY2emJOUjdJRGJZVnhlVHFNSzVtSkZsZ1ZOSjNs?=
 =?utf-8?B?RUJtMGtseHpwd1BVaEJxQzEwZ2pnMTJsWGlyNW1iV2dVS2orVnRkNTdnNlZV?=
 =?utf-8?B?SnVsWG5UclhucG90WXEzUHU4eTZ3NWw1Si9JenBTQ21aaU1qRkR3VVpPMVpI?=
 =?utf-8?B?Qis2T05ROEtjYm5nQUFmQTNYekRhMWRiYVJQaUlkUGI2d0E5MWMwelY2NjA0?=
 =?utf-8?B?UGVrWjRyM2hCOEtFUWV0WnVqN0RVS0lXRWlVSWlmYTF6SVkza2REdnNaWGwv?=
 =?utf-8?B?MnJteU9YM1EyT0RtSlQ5K1NBaVZRK0hmUXJud1VTZ0hYL1FLSVplam4xbFBZ?=
 =?utf-8?B?dDljRVNuUWxGTWlScHZObFpXSXdid0s0dzZncFhXKzBLR0Y3NEFCcjdYcXpn?=
 =?utf-8?Q?X/hT2mU4GnlH3xooyWulYpffW1ki0vf00w2TbJ8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <693B9219D514B04F824EE2FB09AB2E7A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220ed4ee-04a2-40ce-5dd5-08d92be2c173
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 07:38:35.6425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+vl7p3y3MEwxOeE+zrtFZiyZJcUc7Jv/EzHigJsVrURBjwy1vlD3pi/hR8KG8e2w1ffF6v6fsIcxfJvCerJDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5833
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMDgsIDIwMjEgYXQgMDk6MzA6MDBQTSAtMDcwMCwgSHVnaCBEaWNraW5zIHdy
b3RlOg0KPiBUVFVfU1lOQyBwcmV2ZW50cyBhbiB1bmxpa2VseSByYWNlLCB3aGVuIHRyeV90b191
bm1hcCgpIHJldHVybnMgc2hvcnRseQ0KPiBiZWZvcmUgdGhlIHBhZ2UgaXMgYWNjb3VudGVkIGFz
IHVubWFwcGVkLiAgSXQgaXMgdW5saWtlbHkgdG8gY29pbmNpZGUNCj4gd2l0aCBod3BvaXNvbmlu
ZywgYnV0IG5vdyB0aGF0IHdlIGhhdmUgdGhlIGZsYWcsIGh3cG9pc29uX3VzZXJfbWFwcGluZ3Mo
KQ0KPiB3b3VsZCBkbyB3ZWxsIHRvIHVzZSBpdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSHVnaCBE
aWNraW5zIDxodWdoZEBnb29nbGUuY29tPg0KPiAtLS0NCj4gUGF0Y2ggYWRkZWQgc2luY2UgdGhl
IHYxIHNlcmllcyB3YXMgcG9zdGVkLg0KPg0KPiAgbW0vbWVtb3J5LWZhaWx1cmUuYyB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4g
aW5kZXggYjY4MDZlNDQ2NTY3Li5lMTZlZGVmY2E1MjMgMTAwNjQ0DQo+IC0tLSBhL21tL21lbW9y
eS1mYWlsdXJlLmMNCj4gKysrIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBAQCAtMTA2MCw3ICsx
MDYwLDcgQEAgc3RhdGljIGludCBnZXRfaHdwb2lzb25fcGFnZShzdHJ1Y3QgcGFnZSAqcCwgdW5z
aWduZWQgbG9uZyBmbGFncywNCj4gIHN0YXRpYyBib29sIGh3cG9pc29uX3VzZXJfbWFwcGluZ3Mo
c3RydWN0IHBhZ2UgKnAsIHVuc2lnbmVkIGxvbmcgcGZuLA0KPiAgCQkJCSAgaW50IGZsYWdzLCBz
dHJ1Y3QgcGFnZSAqKmhwYWdlcCkNCj4gIHsNCj4gLQllbnVtIHR0dV9mbGFncyB0dHUgPSBUVFVf
SUdOT1JFX01MT0NLOw0KPiArCWVudW0gdHR1X2ZsYWdzIHR0dSA9IFRUVV9JR05PUkVfTUxPQ0sg
fCBUVFVfU1lOQzsNCg0KVGhhbmtzIGZvciBpbXByb3ZpbmcgdGhwIGNvZGUuDQoNCkFja2VkLWJ5
OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg==
