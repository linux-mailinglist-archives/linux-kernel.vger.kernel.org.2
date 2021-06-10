Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D393A25F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFJH70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:59:26 -0400
Received: from mail-eopbgr1300053.outbound.protection.outlook.com ([40.107.130.53]:60800
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229770AbhFJH7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGRW1TKV+rJ5Sof0kTbTX08z//FsNXG9ApQ+JknzxfEpEIz5pJczzdZhJRCs3hstYCWTrMOvIUkJd8zQ7ES32M2y88+kmF6gwBwQIIyS4C/JRmA8T/2DSV9pSU8PbCtsME9e05vBdfM6BxMRGfT3CniveENoGY/6IE7BKiXUXNkkt+lhQvzSJ5HekLSOf6iFHpZrrcG0FjKBhQb0lYxgFR3RY8U0nPB7y1EMs3kgpNSDF5m+Qy5O5WNhEO1UvxYBtBfweQkIpi6C4fjWJ59j/cI66vcYDZsLpLWpFMSAWQKd2jv/e9hRu2OFzwOGX0ij7366/PNPEpicQQA7SXmadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OcXm7R18OzOVbCAjQxcteASyK6ESG5DDFhcZNpBxFs=;
 b=LyilYGGloCM6Jn3dOEX5qaqe78Z4NQM/Kh/fi967NkhJGhfe0+bvLa5wnBdkFj6pmRXU1lgVhBKft1YHqOrYmLKuPDfxy9J35htSXqgICkjddUMYEznnYh1ybVImLMYuJCBu+niQtR66+dsEKG+fNoHzH4NN3dKx9WtIuxE9LvZHoNd+mVeFPfhVUhYKsUMTOl99q/sL52tsF3jxqUwyz73pSLYp+9YIDiCZ2cQ0VGi70lDcGpzMRM5MWuJqyxu+K8kV41CVwHSEVGvpa+YDcthKmczVajc569laBvMGaCyVyTJffHygHThdS9QxJz/qpW6hLSMxmHtbLtgWcdTmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OcXm7R18OzOVbCAjQxcteASyK6ESG5DDFhcZNpBxFs=;
 b=KyMqxTX8ikWtc0R9uTDNe0uTAcTO7sVZwrdV72DQgGSB/vs1cyyusTCQxkZ4sNmqhsxEmcY2DLikK5zQaAt96SPWolAaxZAoz7jgntZKZ4HkFGkVHeCrI/5930CZaNH/nVTDlvfvoZTs3H4kZbuj17HPnWWWWWrvRSFAuYz/v50=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB2090.jpnprd01.prod.outlook.com (2603:1096:404:e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 07:57:26 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 07:57:26 +0000
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
Subject: Re: [PATCH v2 08/10] mm: rmap: make try_to_unmap() void function
Thread-Topic: [PATCH v2 08/10] mm: rmap: make try_to_unmap() void function
Thread-Index: AQHXXOd8oKmZHuRickmk71vY+VtY9asM4rGA
Date:   Thu, 10 Jun 2021 07:57:25 +0000
Message-ID: <20210610075725.GB1196948@hori.linux.bs1.fc.nec.co.jp>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
 <bb27e3fe-6036-b637-5086-272befbfe3da@google.com>
In-Reply-To: <bb27e3fe-6036-b637-5086-272befbfe3da@google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee3052ab-ddac-4575-b9fa-08d92be56326
x-ms-traffictypediagnostic: TY2PR01MB2090:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB20903A16C24CFEB8B397899AE7359@TY2PR01MB2090.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKh+72gt4Sy3w05Yu+Cw1/31Ly3o2kwNSsUck3fc7Ux+adzOXVCEiTkThEujALc5iRBlYIuT6A7hLq2ddz0UNIByjVPRzzLdzkfsSm4rWQUs8O9PJIDoTaQLdv9epQHu1uUJcwycr1SXekv4cVpfXZ3Koz9FLN3UCppg+DTL3toiFF+YTvNr2lzkglAYeidZQOjYYOYpNI+jxWo3AFmBo4L6PoUgE8zISIS7hDJdrUTYA0Be4MZH5LfJOTDYYzFv4znUM90eSv7xlr1EXICeelidDPBSifBOLrY+Egi1OeE9ouy/+FVSx96GNAbuqGf2ePCqjruYRBgrCpRjCwcATaeC+s6YM1uJZoHrTU6XAQM2JIy/WHAUQtoVRc8zfFxeg9yCBSUeIesQwza+j3sVpfRFTh492iKfkAtA+2Oh+zMg4N9lj74uBCB+CLUPdDQOUsRcIjWW42wW5cY7oJUW87Ng8pt21I9WKa1RMb9UkjWdmMGg8u/vUkhp3XysPq23YSfKQxRYub/y+afckwjzD3JqD4RK25F2eSEMTzGgoQJ2Pwp5isxw2PdgyJAGb8RCLvTailMoXh5J0bxY+tlkTeCzbE62VxK6mmIwGeLRI/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(6916009)(478600001)(38100700002)(54906003)(71200400001)(5660300002)(33656002)(122000001)(64756008)(6506007)(85182001)(186003)(55236004)(8936002)(66946007)(66556008)(76116006)(6486002)(7416002)(66476007)(86362001)(66446008)(316002)(4744005)(8676002)(2906002)(1076003)(4326008)(6512007)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cEZ6RmoybUtJQ1lQbGZDN0ovYVJwbTc2cEUwdkJHbWI4cU96Mk01NFBtYnpa?=
 =?utf-8?B?bE5KZTc4SVRybjdSKzI0a3ZZOXZrWk93WGMyNHk0RGRvVmN3clJIVm90UTho?=
 =?utf-8?B?OGN6VUJkUnBxT0tqV0tnck9tZ2pVZGoxOWhaZWp4a21FV1VraklpeUZKbSta?=
 =?utf-8?B?Sis5bGNIdnpJTXB6Y1Q0OWI2SWpTT3FKem5aMjhWQ1g4ejgyTVlnUitKM3FS?=
 =?utf-8?B?RHZ3TW9SbFg1Y1dEdGdocHdSTDZ0ak5vcitlMU41b2VLYTZzMTJBODM5Rkw1?=
 =?utf-8?B?d0pUNVZhVjFVTHh2emV1bUJTL1VrRXlRVGc2dzFmMDhjK3FKMDJBK0dRVWo5?=
 =?utf-8?B?WVh6QlBUWjVxM3JnR3NBZ0NjRG1HdThoWWkvRGExWElUeTFYa09kN2VsQjhX?=
 =?utf-8?B?T25XbmFwYTdaSGl5OXlIcWdRNzAxUGdMck95N3pjaGc0Nkx6U1dvOVhGNldC?=
 =?utf-8?B?U3QxeHJ3UjBPVllwVUIxQjZQWWJja3kxMGNDOHpTNnI1SW5sSm5xRElXK3dl?=
 =?utf-8?B?V3QyZTM2ZUsyV3NUL0pqc2ZIY2UzNG9GbUtvTXJJTmc1S054a201WEkwaFQ4?=
 =?utf-8?B?SmdPM0RFU0s4QjBRak5RV0F6aWZFNnFFbjZvSG5UQlkzY2g4QmR4a0ZmdjZ1?=
 =?utf-8?B?bk44V2J2NGJFTU56b09HZzMrVlJ2RS9YNGcyOE02Tzd6eUMvRXJHR0Nkb1U0?=
 =?utf-8?B?VG15K2FocWxuSEtycnFTVHJZOXlwOFJxOHB1dE9OTG8ySnp1WXZkaTBGU3lG?=
 =?utf-8?B?cE5NZmZ6a1ZQQlZyNkx1aXB2NGxFMDNaNlFtOTBZc0xnd28rcXlVVTVlSnp5?=
 =?utf-8?B?dXdnNkRwb2w0bFRIc2EreXBycUlvN1lkTmM2TVVSNVZsbzBRVytlWGRzcStl?=
 =?utf-8?B?VDJqUFVlVDR2TUZuRW53Y04vUVREZW9xV0ZNM1BZNTJQRVlVdStzV0VUMG9u?=
 =?utf-8?B?VXM2Q1JPbHlsRzViTVMrdHVLbDFJMTBEKzl6L1V0c0lrdW9UYVdma0paSTR3?=
 =?utf-8?B?Q1N2bWxkMC9nZW10em51L3A4OGhYR0pNUXkyU0Q1REtLYnpIZjYrdllKa2Mz?=
 =?utf-8?B?T1Nkd3VLa25xY2ZDUG90ZXN5NGhWT3NZaTA2VU5LTmp5MkdNM3F6ZWlHQnZ4?=
 =?utf-8?B?ODVBYlFTbVV3S3VkQ1RGUW1xY1lUNUF2dWVPZjJReU1iNGxYMWZEbzFpa24v?=
 =?utf-8?B?eWdSV2V1UmlTSWhTaGlQRzJ3MTBnN2tEaXhmdVBvTmNQSzd4TE9pdnp3RExi?=
 =?utf-8?B?Z0JxNU5vOFFzdVM4ZmlrYnFpVWwvRkt3UEpUWk5UOWJ4WUtLTGJEbGVPck5G?=
 =?utf-8?B?S2NNeDV1OUhrRTkvdDVIeW9TMklheWFPYmtJcFdmL2Rrd2kzeUVxWk1JeGVW?=
 =?utf-8?B?VG5xaXBnOWJjRGdoak5FYXZpb3NuSHorM3MxL3VKUm1GejkwNVVSb2JIbHpP?=
 =?utf-8?B?N1dReVlKVmU0a3YxOVNWYlBkNnFRMUlNTEMrWkRJVCt4SUhmcjFaLy9DczhY?=
 =?utf-8?B?a2xvYmk2ZzlhZnZkTWlIcEk0bGJibEQ1TTR1T1RhS3Z3dEVVNGxYeXJlL3JM?=
 =?utf-8?B?Wi84S0xQaklsUXFxYkd3SUZacmszam9yYjQ4cFNvcWZ4aXYzcWNodG5jYjdI?=
 =?utf-8?B?cmlSbTY5S2l2aXBwOU8xK1U5UGR6MjYvb1dMMVNQMmxhaXk0cTE4dlgxazdt?=
 =?utf-8?B?ZFZwQUtMQ3pyL1FCUDd3eWFVM1BVL1NPaUdSYTF5RVNySjdNY29qaFNCTWRU?=
 =?utf-8?Q?e7ylYIsjbVitEKvLHJIp9vU02UWao/cHXtoCHhV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDA90027A1E1C5499877BE49B418273C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3052ab-ddac-4575-b9fa-08d92be56326
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 07:57:25.9809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZp+Tmi3FJAAvMdRhrLpY6DBKQvWoSL1NRLtZmmVjt6AF5c+aMSxIPtLiX2nfkfln9+SEARn0JttgSVxhq59GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKdW4gMDgsIDIwMjEgYXQgMDk6MjU6MjJQTSAtMDcwMCwgSHVnaCBEaWNraW5zIHdy
b3RlOg0KPiBGcm9tOiBZYW5nIFNoaSA8c2h5ODI4MzAxQGdtYWlsLmNvbT4NCj4gDQo+IEN1cnJl
bnRseSB0cnlfdG9fdW5tYXAoKSByZXR1cm4gYm9vbCB2YWx1ZSBieSBjaGVja2luZyBwYWdlX21h
cGNvdW50KCksDQo+IGhvd2V2ZXIgdGhpcyBtYXkgcmV0dXJuIGZhbHNlIHBvc2l0aXZlIHNpbmNl
IHBhZ2VfbWFwY291bnQoKSBkb2Vzbid0DQo+IGNoZWNrIGFsbCBzdWJwYWdlcyBvZiBjb21wb3Vu
ZCBwYWdlLiAgVGhlIHRvdGFsX21hcGNvdW50KCkgY291bGQgYmUgdXNlZA0KPiBpbnN0ZWFkLCBi
dXQgaXRzIGNvc3QgaXMgaGlnaGVyIHNpbmNlIGl0IHRyYXZlcnNlcyBhbGwgc3VicGFnZXMuDQo+
IA0KPiBBY3R1YWxseSB0aGUgbW9zdCBjYWxsZXJzIG9mIHRyeV90b191bm1hcCgpIGRvbid0IGNh
cmUgYWJvdXQgdGhlDQo+IHJldHVybiB2YWx1ZSBhdCBhbGwuICBTbyBqdXN0IG5lZWQgY2hlY2sg
aWYgcGFnZSBpcyBzdGlsbCBtYXBwZWQgYnkNCj4gcGFnZV9tYXBwZWQoKSB3aGVuIG5lY2Vzc2Fy
eS4gIEFuZCBwYWdlX21hcHBlZCgpIGRvZXMgYmFpbCBvdXQgZWFybHkNCj4gd2hlbiBpdCBmaW5k
cyBtYXBwZWQgc3VicGFnZS4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogSHVnaCBEaWNraW5zIDxodWdo
ZEBnb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFNoaSA8c2h5ODI4MzAxQGdtYWls
LmNvbT4NCj4gQWNrZWQtYnk6IE1pbmNoYW4gS2ltIDxtaW5jaGFuQGtlcm5lbC5vcmc+DQo+IFJl
dmlld2VkLWJ5OiBTaGFrZWVsIEJ1dHQgPHNoYWtlZWxiQGdvb2dsZS5jb20+DQo+IEFja2VkLWJ5
OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IEh1Z2ggRGlja2lucyA8aHVnaGRAZ29vZ2xlLmNvbT4NCg0KTG9va3Mg
Z29vZCB0byBtZSwgdGhhbmsgeW91Lg0KDQpBY2tlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95
YS5ob3JpZ3VjaGlAbmVjLmNvbT4=
