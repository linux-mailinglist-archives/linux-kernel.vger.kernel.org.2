Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8ECF377D07
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhEJHWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:22:51 -0400
Received: from mail-eopbgr1410073.outbound.protection.outlook.com ([40.107.141.73]:53520
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230059AbhEJHWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:22:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa06JbeyPVe2+zQzlD6Ej0d8UhYio26t9cIJXcAzkh02JpvewSq9HZpepAkN8yLtNLxkZOupH6AJWYtez1TI8cVRbMGWQhVJekyZSpDW8YDvHxeFkcPngsZmW3M9qGfnh9P8B7TAzhBv/ES2IxKljsr6mO2mZ7u2RFrEdZRDHUns7rAXx0ZnOBA8PyYYk/YYq/Ok97HdUOKeDmItfGDm1UmmGc4OvQP27rZrm/JTSOq4FridI2SN1iWbXmDy7ronUkQI5XkCYcc7XDQdthrVLyefGNZ5IfQEs218IBtMwJcU5cswreZV/LNyTEhiOtSuBF3zZY95kV7Gqwovvn2FbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALRvG+IcArnksUNIsNnTlVNSLIaCtKFk+RQS3n6Q5CM=;
 b=QbdtEo1m46d38+4HQlUfJ4Rt10f3yu9EwaYh50B5ABxkJUzK4GPfEIkdILbbgrZaSrFo07Iw2l6KqdgDBY7XBmCu8RGKCEXJakPedWHvqzRIhFZl8nwcrvkuP0cSZVRPoL0ZeoZ9ya6OKgI9bDlWw1Lpbi2JecTZkVFnUAh7goHSRI/h1Z/lbpSTgdZmZxRsDvgzOE9s8jkeHIIO7UcEV9+CnRuMr/KlLZJLxcrqu9hfGwjCjwnW3GPCj8P8cleLk8+8dF45kVzvXzaPOaYjqiLWMRTGLG2uhh8w5DIK8KS0mymhA1cfPnmTYEdL5Xt2iZu/jdyQXaj2sRP/XsbhGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALRvG+IcArnksUNIsNnTlVNSLIaCtKFk+RQS3n6Q5CM=;
 b=X6Q+5DcOQztI/BilC130azPv/ksOJNVdHcawkoWGDfVwFLyh5IreTZD8DNOXyK1PVpkW+9JPgp5OUQRHeOO5d30Vbh4NejlU7UXxEaShrEWzjqw70BK2lrU0L2eeQuU5HZbMPk02BIa+7J/bGvwjEKK2WBfc5+K7qiRW/44iqEI=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB6299.jpnprd01.prod.outlook.com (2603:1096:400:86::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 07:21:28 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 07:21:28 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Aili Yao <yaoaili@kingsoft.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaoaili126@gmail.com" <yaoaili126@gmail.com>
Subject: Re: [PATCH v4 2/2] mm,hwpoison: send SIGBUS when the page has already
 been poisoned
Thread-Topic: [PATCH v4 2/2] mm,hwpoison: send SIGBUS when the page has
 already been poisoned
Thread-Index: AQHXOy7IzwXBqmKu6kCc/e42oULGaarX0zYAgASQmwA=
Date:   Mon, 10 May 2021 07:21:28 +0000
Message-ID: <20210510072128.GA3504859@hori.linux.bs1.fc.nec.co.jp>
References: <20210427062953.2080293-1-nao.horiguchi@gmail.com>
 <20210427062953.2080293-3-nao.horiguchi@gmail.com>
 <20210507173852.0adc5cc4@alex-virtual-machine>
In-Reply-To: <20210507173852.0adc5cc4@alex-virtual-machine>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kingsoft.com; dkim=none (message not signed)
 header.d=none;kingsoft.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bf5a197-e7a4-4ad9-c5ca-08d913843a80
x-ms-traffictypediagnostic: TYAPR01MB6299:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB629969BEDE26D78A12A49269E7549@TYAPR01MB6299.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfX7znffs1hnAR3dLLRvUW4AI2PGNU7t8C08p/ranvKGt/b6IqqNZMO0AmFUO3a+rFYn+kpa4IbzQQHbKN9TodeMSD7WGemWGnkqaFJy373oe/QXQ0N0/fkwoOUhmE4DHxE16H3XJaaoko1ChtLu3gGsbsCegSHia6w4A5G2xkXPRYOkas2zNS6ZAW1Tsc4w8BGckZrywtPUXD9JBKY+q1qKgjZRTMnxkGyN5OJXfZPA3IQEaZaidylwRxydIuMCKj4UfNEuBsCC2Azyn2r5BQahi+Ey8/VpPnXgx9n8Vg2HEasZn01FpyYc6vnZW5Nba3cR3qYaYl1doMNYnU68t/bA+9XfoR3+VBXD9tP/7pMSxPl/MR5c5JHSSavGh63IjDxOMBT87Ic2pE/Jn5yFXpcS+gwWXEN+bE1F2zNz+PSwZbIUM4UKSUqZqomhlF+gUxeQIysOSvXJjSD7o2k6R9z7cMkuKrBYEtJCftUiIMq+nwo66e+JGL1PUJ8wzJKMvbeA9Yg1MJjJwz2Pw6HFOm/NuQME3E+mGl27vcVvZwvGIzyzXt+PzUiJ2QSoWCSDUKIu9cjV3O/cxpiyG941fWWyvvmGp8qiIMDMF69Ky5RbG2RNfYbaJmzLrXNwzWV3euppcQDm+6FMz/31/psOSUscgXxqylDeKelSdn/WRcWttM9qsYvp+pfuGJxnH5o7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(26005)(186003)(6916009)(83380400001)(1076003)(85182001)(86362001)(8936002)(122000001)(508600001)(38100700002)(33656002)(8676002)(6506007)(55236004)(71200400001)(9686003)(6512007)(5660300002)(316002)(54906003)(966005)(64756008)(76116006)(66446008)(66946007)(66476007)(4326008)(66556008)(2906002)(6486002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V1hpMmllMnB1UXlpSWxsbWw3aG1qMnBwdGp2aVVscUhiam5ZYmUreXV1WFcy?=
 =?utf-8?B?NjZsUHJGQ2dvemVibkR6VUxXOGFUMU9jNVd1eXZUU3dGeGU0L2J5V3VLM29w?=
 =?utf-8?B?dWQzTC9tWHd3b2dxM0pWUitGMXlya1hTMXhBbGhjQUl5M1RMVFJ0UGdhZm4w?=
 =?utf-8?B?SWhob3l6NEtZY2hnYktEMlRlT2ZPSXlCZWNMK3BiNmFEMndjY1lOUGIrMEdN?=
 =?utf-8?B?WVU0RlRSRTYzL1RpVjVqR2d0MXNkaVJUTDR6UnpyRzJRTnpHTmx1MjFVcGcr?=
 =?utf-8?B?TVJFdlJyckhsZzlNVC9JYkRhWjI4dVRvOXBmanRvWnNzRjlQN05KQzJ1dURl?=
 =?utf-8?B?ZThvNklyeFR0RU9sSGRLbThCZkFjSEh2VVZNemVDQjVPQUhRVWVFMzJtdW5J?=
 =?utf-8?B?Mk5xM2RMNTBJMUxsRHhENVN1QW5iVVhXcFh4R1M0bXhidFlKTU1EWUtoekRW?=
 =?utf-8?B?Z3RNUGVQRGR2RFdYSTNtQVQyK1gzM2VXam80Y1JHR1J2ODZGRkJTZUFjZXdh?=
 =?utf-8?B?eWQ5VHBmMTJvbDdzSFU2UXZURC84VzhSV2p1RlNvZVh0WUlLcFdkRndJQm05?=
 =?utf-8?B?cjFkbTJSdDYzSnRUWG5LaWduY3NpSmhHNE1xZDVKTGlhMFY5akhFbmRkcW42?=
 =?utf-8?B?OWtyekM2dklMVWg5b2xyRGZxb3hhNVFacVV1MmNoNDVPTzV1VHZFK2l5MTh2?=
 =?utf-8?B?N2c3N3VPMFRWOE5ZUVIzdlJxakxmNWlhQ3ozN0NURmZTaGlPbm9rSlkxSGMx?=
 =?utf-8?B?eVRzeEVmVndEbGduUllEc2U1TlRxMGhvUFZpaTFDSVB5Z2czRzA2MGJaNWwy?=
 =?utf-8?B?bXY0VTVKSFlRMUxKVEJnL0t6RkJIVVRIYnFhNnFPU0VKMDAvc2hqY3pPQnVH?=
 =?utf-8?B?bmlJaktReTV1RjlnR3lHdXVBcDZRY2UzNmlQc2EzUllLMlNibVBqT3pvUkl2?=
 =?utf-8?B?RGlOMEw2VG5sa1hvdHNseVpMa1VFMlNldjRpZU5LTUsyTDBicDNmSFRJdXAz?=
 =?utf-8?B?OTgvSkpsdU91YXVRZzNyd0RpcWJIMWFWdFRqWmJqMnZCR2hUV2tPMnFOMTJZ?=
 =?utf-8?B?bTBWUjhuc01MR2NRWUprYUVLbzh2L2M2dFR4YytRcktHd1hnTHlQSmFsUm0x?=
 =?utf-8?B?RlhFV1RhVnp5aFR5UTYvclZ5MmZ5U2gya0RRTWNpb2RxdTBLY29wWk51WVhU?=
 =?utf-8?B?cFdzSGsrTlpYRzdTQitCQUF4L0pVQjAyb1BMRUh4WFNlODYxWmJPaWxPNzJE?=
 =?utf-8?B?cm96NjhkZWRjTmhUSFprTmRNTkRZUkpqMmhYN2c3eUtqaXZuRC83SXlLUzlZ?=
 =?utf-8?B?Y0ROTHlzRmhudmwxS2tQSlM0RGMxRU5HTmFXaktQbG1XVkdqN2s2Z0NLUXo5?=
 =?utf-8?B?UHBKSFkxd3QyNTY3RjkrR1FUd0FhZ3lJLzlSOUZOWWppTHAySDVzUHQ3ekc2?=
 =?utf-8?B?K25nbnQwRnR5emRqaXNtQy9oYlpLWG1QdU9nVDBkYUxIOUFSV3ZBY3FuS2tB?=
 =?utf-8?B?ZGhDNlNsamhmODRZODdDT3FTZDBlQ3JWSjJTSGVwMThhRnFSMnpERG1Nd1pF?=
 =?utf-8?B?QVVhQ0hYRFhjVXJ1d2FxRU5XVHBoaTF1RTFaSFIwblYzaEgyd1RIdUdMSkR4?=
 =?utf-8?B?RjYxQzdNQTI2aEZYendXdktvek5zVCtZOElqZ2ZKUUx2bmptMWpWb3d1dlh6?=
 =?utf-8?B?NTlDSDZtQU1BNi9KMUY0bm44RHRSbHlodGNtV2NCbkdnZE5LT29zV2tyWm1W?=
 =?utf-8?B?MWpBS2ZMMWp2VnllRDFPUVVid0ZOQ3ExR2JURUxLTlRDZ1RPQzgxYitVd2dV?=
 =?utf-8?B?Uk51Mkd3ZlN2YWEvUVZLUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <322620C030E26547BB8368D042A5B5F7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf5a197-e7a4-4ad9-c5ca-08d913843a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 07:21:28.5895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z504zlgTZfWPgq/z9qGvAkPA8JdjDtTW4TVrZMCROvhwXWJ9fvsSAiy946WgjNxV4viJO8T3WgXab3jWqa9+dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6299
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXkgMDcsIDIwMjEgYXQgMDU6Mzg6NTJQTSArMDgwMCwgQWlsaSBZYW8gd3JvdGU6
DQo+IE9uIFR1ZSwgMjcgQXByIDIwMjEgMTU6Mjk6NTMgKzA5MDANCj4gTmFveWEgSG9yaWd1Y2hp
IDxuYW8uaG9yaWd1Y2hpQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEZyb206IE5hb3lhIEhv
cmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4gDQo+ID4gV2hlbiBtZW1vcnlf
ZmFpbHVyZSgpIGlzIGNhbGxlZCB3aXRoIE1GX0FDVElPTl9SRVFVSVJFRCBvbiB0aGUNCj4gPiBw
YWdlIHRoYXQgaGFzIGFscmVhZHkgYmVlbiBod3BvaXNvbmVkLCBtZW1vcnlfZmFpbHVyZSgpIGNv
dWxkIGZhaWwNCj4gPiB0byBzZW5kIFNJR0JVUyB0byB0aGUgYWZmZWN0ZWQgcHJvY2Vzcywgd2hp
Y2ggcmVzdWx0cyBpbiBpbmZpbml0ZQ0KPiA+IGxvb3Agb2YgTUNFcy4NCj4gPiANCj4gPiBDdXJy
ZW50bHkgbWVtb3J5X2ZhaWx1cmUoKSByZXR1cm5zIDAgaWYgaXQncyBjYWxsZWQgZm9yIGFscmVh
ZHkNCj4gPiBod3BvaXNvbmVkIHBhZ2UsIHRoZW4gdGhlIGNhbGxlciwga2lsbF9tZV9tYXliZSgp
LCBjb3VsZCByZXR1cm4NCj4gPiB3aXRob3V0IHNlbmRpbmcgU0lHQlVTIHRvIGN1cnJlbnQgcHJv
Y2Vzcy4gIEFuIGFjdGlvbiByZXF1aXJlZCBNQ0UNCj4gPiBpcyByYWlzZWQgd2hlbiB0aGUgY3Vy
cmVudCBwcm9jZXNzIGFjY2Vzc2VzIHRvIHRoZSBicm9rZW4gbWVtb3J5LA0KPiA+IHNvIG5vIFNJ
R0JVUyBtZWFucyB0aGF0IHRoZSBjdXJyZW50IHByb2Nlc3MgY29udGludWVzIHRvIHJ1biBhbmQN
Cj4gPiBhY2Nlc3MgdG8gdGhlIGVycm9yIHBhZ2UgYWdhaW4gc29vbiwgc28gcnVubmluZyBpbnRv
IE1DRSBsb29wLg0KPiA+IA0KPiA+IFRoaXMgaXNzdWUgY2FuIGFyaXNlIGZvciBleGFtcGxlIGlu
IHRoZSBmb2xsb3dpbmcgc2NlbmFyaW9zOg0KPiA+IA0KPiA+ICAgLSBUd28gb3IgbW9yZSB0aHJl
YWRzIGFjY2VzcyB0byB0aGUgcG9pc29uZWQgcGFnZSBjb25jdXJyZW50bHkuDQo+ID4gICAgIElm
IGxvY2FsIE1DRSBpcyBlbmFibGVkLCBNQ0UgaGFuZGxlciBpbmRlcGVuZGVudGx5IGhhbmRsZXMg
dGhlDQo+ID4gICAgIE1DRSBldmVudHMuICBTbyB0aGVyZSdzIGEgcmFjZSBhbW9uZyBNQ0UgZXZl
bnRzLCBhbmQgdGhlDQo+ID4gICAgIHNlY29uZCBvciBsYXR0ZXIgdGhyZWFkcyBmYWxsIGludG8g
dGhlIHNpdHVhdGlvbiBpbiBxdWVzdGlvbi4NCj4gPiANCj4gPiAgIC0gSWYgdGhlcmUgd2FzIGEg
cHJlY2VkZW50IG1lbW9yeSBlcnJvciBldmVudCBhbmQgbWVtb3J5X2ZhaWx1cmUoKQ0KPiA+ICAg
ICBmb3IgdGhlIGV2ZW50IGZhaWxlZCB0byB1bm1hcCB0aGUgZXJyb3IgcGFnZSBmb3Igc29tZSBy
ZWFzb24sDQo+ID4gICAgIHRoZSBzdWJzZXF1ZW50IG1lbW9yeSBhY2Nlc3MgdG8gdGhlIGVycm9y
IHBhZ2UgdHJpZ2dlcnMgdGhlDQo+ID4gICAgIE1DRSBsb29wIHNpdHVhdGlvbi4NCj4gPiANCj4g
PiBUbyBmaXggdGhlIGlzc3VlLCBtYWtlIG1lbW9yeV9mYWlsdXJlKCkgcmV0dXJuIHNvbWUgZXJy
b3IgY29kZSB3aGVuIHRoZQ0KPiA+IGVycm9yIHBhZ2UgaGFzIGFscmVhZHkgYmVlbiBod3BvaXNv
bmVkLiAgVGhpcyBhbGxvd3MgbWVtb3J5IGVycm9yDQo+ID4gaGFuZGxlciB0byBjb250cm9sIGhv
dyBpdCBzZW5kcyBzaWduYWxzIHRvIHVzZXJzcGFjZS4gIEFuZCBtYWtlIHN1cmUNCj4gPiB0aGF0
IGFueSBwcm9jZXNzIHRvdWNoaW5nIGEgaHdwb2lzb25lZCBwYWdlIHNob3VsZCBnZXQgYSBTSUdC
VVMgKGlmDQo+ID4gcG9zc2libGUpIHdpdGggdGhlIGVycm9yIHZpcnR1YWwgYWRkcmVzcywgZXZl
biBpbiAiYWxyZWFkeSBod3BvaXNvbmVkIg0KPiA+IHBhdGggb2YgbWVtb3J5X2ZhaWx1cmUoKSBh
cyBpcyBkb25lIGluIHBhZ2UgZmF1bHQgcGF0aC4NCj4gPiANCj4gPiBraWxsX2FjY2Vzc2luZ19w
cm9jZXNzKCkgZG9lcyBwYWdldGFibGUgd2FsayB0byBmaW5kIHRoZSBlcnJvciB2aXJ0dWFsDQo+
ID4gYWRkcmVzcy4gIElmIG11bHRpcGxlIHZpcnR1YWwgYWRkcmVzc2VzIGFyZSBmb3VuZCBpbiB0
aGUgcGFnZXRhYmxlIHdhbGssDQo+ID4gbm8gb25lIGtub3dzIHdoaWNoIGFkZHJlc3MgaXMgdGhl
IGNvcnJlY3Qgb25lLCBzbyB3ZSBmYWxsIGJhY2sgdG8gc2VuZGluZw0KPiA+IFNJR0JVUyBpbiBr
aWxsX21lX21heWJlKCkgd2l0aG91dCBlcnJvciBhZGRyZXNzIGluZm8gYXMgd2UgZG8gbm93Lg0K
PiA+IFRoaXMgY29ybmVyIGNhc2UgaXMgbGVmdCB0byBiZSBzb2x2ZWQgaW4gdGhlIGZ1dHVyZS4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNo
aUBuZWMuY29tPg0KPiANCj4gU29ycnkgZm9yIG15IGxhdGUgcmVzcG9uc2UsIEkganVzdCBnZXQg
dGltZSB0byByZXRoaW5rIHRoZSBwYWdld2FsayBwYXRjaC4gUGxlYXNlIGxldCBtZSBzaGFyZSBt
eSB0aG91Z2h0cywgDQo+IElmIGFueXRoaW5nIHdyb25nLCBqdXN0IHBvaW50IG91dCwgdGhhbmtz
IQ0KDQpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiANCj4gVGhpcyB3aG9sZSBwYWdl
d2FsayBwYXRjaCBpcyBtZWFudCB0byBmaXggaW52YWxpZCB2aXJ0dWFsIGFkZHJlc3MgYWxvbmcg
U0lHQlVTLCBGb3IgdGhpcyBpbnZhbGlkIHZpcnR1YWwgYWRkcmVzcyBpc3N1ZSwNCj4gSXQgc2Vl
bXMgdGhpcyBpcyBvbmUgZXhpc3RpbmcgaXNzdWUgYmVmb3JlIHRoaXMgcmFjZSBpc3N1ZSBpcyBw
b3N0ZWQuIHdoaWxlIHRoZSBpc3N1ZSBpcyBub3QgZml4ZWQgZm9yIGEgbG9uZyB0aW1lLg0KPiAN
Cj4gVGhlbiBJIHRoaW5rIHdoeSB0aGlzIGlzc3VlIGlzIG5vdCBmaXhlZCwgbWF5YmUganVzdCBu
byBwcm9jZXNzIHdpbGwgY2FyZSB0aGlzIHZpcnR1YWwgYWRkcmVzcyBhcyBpdCB3aWxsIGJlIGtp
bGxlZC4NCj4gTWF5YmUgdmlydHVhbCBndWVzdCB3aWxsIG5lZWQgdGhpcyBhZGRyZXNzIHRvIGZv
cndhcmQgaXQgdG8gdkNQVSwgYnV0IHVudGlsbCBub3cgdGhlIG1lbW9yeSByZWNvdmVyeSBmdW5j
dGlvbiBpbiB0aGUgVk0gZG9lc24ndA0KPiB3b3JrIGF0IGFsbCwgYW5kIHdpdGhvdXQgdGhpcyBh
ZGRyZXNzLCBJdCBzZWVtcyBub3QgYSBiaWcgaW1wYWN0IHRob3VnaC4NCj4gDQo+IE1heWJlIHRo
ZXJlIGFyZSBzb21lIG90aGVyIGNhc2VzIHdpbGwgY2FyZSB0aGUgdmlydHVhbCBhZGRyZXNzLCBp
ZiBhbnlvbmUga25vd3MsIGp1c3QgcG9pbnQgb3V0Lg0KPiANCj4gQnV0IGludmFsaWQgdmlydHVh
bCBhZGRyZXNzIGlzIHN0aWxsIG5vIGdvb2QuDQo+IA0KPiBCZWZvcmUgdGhpcywgSSBwb3N0IG9u
ZSBSRkMgcGF0Y2ggdHJ5IHRvIGZpeCB0aGlzIGlzc3VlIHdpdGggb25lIGtub3dpbmcgaXNzdWU6
aXQgZmFpbGVkIGZvciBtdXRpcGxlIHB0ZSBlbnRyeTsNCj4gVGhlbiB0aGlzIHBhdGNoIGlzIHBv
c3RlZCB0cnlpbmcgdG8gYWRkcmVzcyB0aGlzLg0KPiANCj4gRmlyc3QgSSByZWFkIHRoaXMgcGF0
Y2gsIEkgdGhpbmsgdGhpcyBtZXRob2QgaXMgZ29vZCBhbmQgcmlnaHQgYW5kIGkgdGVzdCBpdC4g
QnV0IG5vdyBJIHRoaW5rIGl0IGFnYWluLCBJIGFtIHdvbmRlcmluZyBldmVuIHRoZSBwcm9jZXNz
DQo+IGhhdmUgbXVsdGkgcHRlIGVudHJ5IGFuZCB3cm9uZyB2aXJ0dWFsbCBhZGRyZXNzLCBidXQg
aXQgc3RpbGwgcG9pbnRpbmcgdG8gdGhlIHNhbWUgcGFnZSwgcmlnaHQ/DQoNClllcywgaXQgaXMu
DQoNCj4gSWYgdGhlIHByb2Nlc3Mgd29uJ3QgZXhpdCBhbmQgZ2V0IHRoZSB3cm9uZyB2aXJ0dWFs
IGFkZHJlc3MsIHdoYXQgd3JvbmcgYWN0aW9uIHdpbGwgaXQgZG8/DQoNCkkgaGF2ZSBubyBjbGVh
ciBpZGVhLiAgVHlwaWNhbCBhY3Rpb24gZm9yIHRoZSBTSUdCVVMgaXMgdG8ga2lsbCB0aGUgcHJv
Y2VzcyB3aXRoDQpzb21lIGxvZ2dpbmcsIHNvIHRoZSBvYnZpb3VzbHkgd3JvbmcgYWN0aW9uIGxp
a2Uga2lsbGluZyB3cm9uZyBwcm9jZXNzIG5ldmVyIGhhcHBlbnMuDQpBIHBvc3NpYmxlIHdyb25n
IHJlc3VsdCBpcyBpbnZhbGlkIGFkZHJlc3MgaW4gbG9nLCB3aGljaCBtaWdodCBub3QgYmUgY3Jp
dGljYWwuDQoNCj4gd2hpbGUgSSBjYW4ganVzdCB0aGluayB0aGUgdmlydHVhbCBtYWNoaW5lIGV4
YW1wbGUsIGJ1dCB0aGUgcWVtdSB3aWxsIHRyYW5zbGF0ZSB0aGUgd3JvbmcgdmlydHVhbCBhZGRy
ZXNzIHRvIHJpZ2h0IGd1ZXN0IHBoeXNpY2FsIGFkZHJlc3M/IA0KPiBJIGFtIG5vdCBzdXJlIFZN
IHdpbGwgaGF2ZSBtdWx0aSBwdGUgZW50cnk/DQoNCkFzIGxvbmcgYXMgSSBrbm93LCBxZW11IG1h
aW50YWlucyBvbmUtdG8tb25lIG1hcHBpbmcgYmV0d2VlbiBob3N0IHZpcnR1YWwgYWRkcmVzcw0K
YW5kIGd1ZXN0IHBoeXNpY2FsIGFkZHJlc3MsIHNvIG5vIG11bHRpIGVudHJ5IGlzc3VlIHNob3Vs
ZCBoYXBwZW4gYXJvdW5kIHFlbXUuDQoNCj4gDQo+IEFuZCBJIHRoaW5rIHRoZSB2aXJ0dWFsIGFk
ZHJlc3MgYWxvbmcgU0lHQlVTIGlzIG5vdCBtZWFuIHRvIGJhY2t0cmFjZSB0aGUgY29kZSwgaXQg
anVzdCB3YW50IHRvIHRlbGwgd2hlcmUgdGhlIGVycm9yIG1lbW9yeSBpcywgZm9yIG11bHRpIHB0
ZQ0KPiBlbnRyeSwgb25lIHZpcnR1YWwgYWRkcmVzcyBmb3IgdGhlIHNhbWUgcGh5c2ljYWwgcGFn
ZSBpcyBub3QgZW5vdWdoPw0KPiANCj4gQ29tcGFyZSB0aGlzIHBhdGNoIHdpdGggbXkgUkZDIHBh
dGNoLCBkaWZmZXJlbmNlOg0KPiAxLlRoaXMgcGF0Y2ggd2lsbCBqdXN0IGZpeCB0aGUgcmFjZSBp
c3N1ZSdzIGludmFsaWQgdmlydHVhbCBhZGRyZXNzLiB3aGlsZSBteSBSRkMgcGF0Y2ggd2lsbCBj
b3ZlciBhbGwgdGhlIGVycm9yIGNhc2UgZm9yIHJlY292ZXJ5Ow0KPiAyLkZvciBtdWx0aSBlbnRy
eSwgdGhpcyBwYXRjaCB3aWxsIGRvIG9uZSBmb3JjZV9zaWcgd2l0aCBubyBvdGhlciBpbmZvbWF0
aW9uLCBCdXQgdGhlIFJGQyBwYXRjaCB3aWxsIHRha2Ugb25lIHBvc3NpYmxlIHJpZ2h0IGFkZHJl
c3MsIEkgZG9uJ3Qga25vdyB3aGljaCBvbmUgaXMgYmV0dGVyLg0KPiANCj4gQW5kIGlmIHRoaXMg
bXVsdGkgcHRlIGVudHJ5IGlzIG9uZSByZWFsIGlzc3VlLCBpdCBzZWVtcyB0aGUgbm9ybWFsIHJl
Y292ZXkgd29yayB3aWxsIGFzbG8gdHJpZ2dlciB0aGlzLCB3b3VsZCBpdCBiZSBiZXR0ZXIgdG8g
Zml4IHRoYXQgZmlyc3Q/DQoNCkFzc3VtaW5nIHRoYXQgeW91ciBSRkMgaXMgaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDIxMDMxNzE2MjMwNC41OGZmMTg4Y0BhbGV4LXZpcnR1YWwtbWFj
aGluZS8sDQppdCBzaW1wbHkgdXNlcyB0aGUgZmlyc3QtZm91bmQgdmlydHVhbCBhZGRyZXNzLiAg
SSBzdGFydCB0aGlua2luZyB0aGF0IHRoaXMNCmFwcHJvYWNoIGNvdWxkIGJlIGZpbmUuICBBbmQg
aXQncyBlYXN5IHRvIGNoYW5nZSB0aGUgcGF0Y2ggd2l0aCB0aGlzIGFwcHJvYWNoLg0KSSBoYXZl
IG5vIHByZWZlcmVuY2UsIHNvIGlmIHlvdSBsaWtlLCBJIHN3aXRjaCB0byB0aGUgImZpcnN0LWZv
dW5kIiBhcHByb2FjaC4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
