Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5603C3EE735
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhHQH3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:29:08 -0400
Received: from mail-eopbgr1410059.outbound.protection.outlook.com ([40.107.141.59]:46176
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234669AbhHQH3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:29:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeoJ9XVp3ZSV+RBefN7rHXwUizjRrdC6DmhpR3LJYGvNMTo07HXN9UNxJre/sbqrGcfwu0FePbuQ+5OgnLx1JzWqooxYwXY2T36c/aaWiAIVx6IDqS9bARYcW+YK80zPwMKzTOk6jQrHg1B5CCVrCJSpgpmM/bLbyEkYOUjXFNdGYagfMimG4UOUZmKk3GdJsBZrORv81nmJanY3/zDdpI/T+PlV0cCDsru9pYbZ6tIT7+t7/zcot+SSdN8ECfHC+EM6uHX3KDstPN6UqGjDyl2JQxYbWu06DyNI3aabcrw2/tiGsgLPvuf0iBDCGhwmDUzQnyEYLURUXulqD+4DFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWkZVQoZQVZUdjYds6oN7XyqCT28xjD0sT2BiB4Rais=;
 b=ihDnt+gm0s3XtKx7UoiV8/8mAS5OY6kYNiMA4inV/MahrFfCIIQBxXIcoAMxBk9xyDbi13+dOmRTkMZegoVPTien8UhpIeJMbWOIigI6KmZO/FiJpRwTD95yjOyOUo+aCU7hBgj02EzZlabyRcGJq8v5yIX1JSHJ9yH3XWlfpt4nirzanydEq2BJLiMCu/8OZufppvXmx/w0WFGhD+gsc/IkXpc4t1HYomWVds+fJ1c2v7pRuz5nPmLIs+gfil6GwLhfN9/IsZFzd13HYe+sjIhOrIXDyCOoooluxxErZrNmboOV+F9G9DcpkM/w7/kZqQnTMH0eqUZihlyye3d8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWkZVQoZQVZUdjYds6oN7XyqCT28xjD0sT2BiB4Rais=;
 b=PAowiflUJBY7ZFlrgkVUAykVOB6gW4njJi7jBb/P+RHBnrmNhRfUgORqiKfNCHVWPGTN+XZsw71KihS/WNg5DP219GBykhep24fQWna+FjITmvXNVctAk4DcHgCZW/rE3Spec7P5lV3nTcb1vfbVOI/GZohZFoWtPKdU0x28AVY=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3965.jpnprd01.prod.outlook.com (2603:1096:404:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 07:28:32 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 07:28:32 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] mm/hwpoison: change argument struct page **hpagep to
 *hpage
Thread-Topic: [PATCH 3/4] mm/hwpoison: change argument struct page **hpagep to
 *hpage
Thread-Index: AQHXkPpfIUciA/RKSkiZYpkpKfjzHat3UQCA
Date:   Tue, 17 Aug 2021 07:28:32 +0000
Message-ID: <20210817072831.GB452988@hori.linux.bs1.fc.nec.co.jp>
References: <20210814105131.48814-1-linmiaohe@huawei.com>
 <20210814105131.48814-4-linmiaohe@huawei.com>
In-Reply-To: <20210814105131.48814-4-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 594ae1fe-35bb-478c-05c8-08d961509dc4
x-ms-traffictypediagnostic: TYAPR01MB3965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB39652A75D9CFA9B0CE011493E7FE9@TYAPR01MB3965.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJ84hUEZpKx/12oa1wocDOS3EQLQquMe7Kx5ZMs6hDiS5pyy69m0Y0eTFS/UJBl7jnaYR+ufNVRODquGMDnof+LwhMTvYYlpHZneRVkxHEkjOWIAkybuurWXtiPuQ9v37kNUVwWNsTu2q0yzDan4WjO0EGONh3pHjXiAknfS40iVA5sO5Xk7voYxUe5yGyerykNsCoDVQrBtTsv4+66MHO2MGgtYGmX7lZEHAw4tubZTB3gzHU/4FocycFjXuM10ES0Amot8ysHwilOM1kP7z8i3yLVVDzglDx50efgp+zOd2RDxh2GWpsrtW5optNkLfUrCqwTEFsicbxbuXp2cBJEhbdk+wKKjauUOU3SAoGRZWLy4IVzNvP94PZGeuc+DvFKDQ5SElwMH4hmYq8zZ22Ylrhg2HL4GImo/KVxLwL1MODMOwDEeuloa6J82XaJlhkFpoj1NgtHqdV1/CHItmdXxg97Tn8jzfy8yF4jZXkgVCaoBYI5rQ6jBMRSE0XnPSXCc1gFWGXg4bX4GFAJt0XqlIKp1wz2/gE4vL4bQ2nIc0o8EGUOe+mP0RMmI6UtyWO6XMSXbWalFwR20A2dXVMu4c1oj10RrRIdr8NclLMYOIg1o2l58ePE09y76PpU196jc5Mi8vuNYeni5HHK8QzKDGi2xD3WcRile8Aizu/F8hNwRlUO9XeeJvpkCaWp9Al8R/GzecDG+fTKkkhNxww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(8936002)(5660300002)(85182001)(1076003)(122000001)(38100700002)(558084003)(478600001)(33656002)(316002)(54906003)(6916009)(2906002)(66946007)(55236004)(86362001)(8676002)(66476007)(64756008)(26005)(66556008)(66446008)(6512007)(9686003)(6506007)(4326008)(186003)(76116006)(71200400001)(6486002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0FIUTNtWnFwUFdZaUx2STE0aHNnVlVVUWV4ZVkxKzZmRi9vang1ZzE1aTNN?=
 =?utf-8?B?MkxEVGdNbFJxeEpjV0xNcGhKNHpIQWpoWjZVNlZuN1RvSHZOKzNpWkpOVjM0?=
 =?utf-8?B?VlFLcDFLRjBMN041WkJta3N1WXFER3RwdVptWGwzZ0hJV3Z2czZmTVpLRUhq?=
 =?utf-8?B?UnczY2tRNFhLYmQ0RXl4eUh5bmpnbE9Ld3FsdXZJdXpFN1g1QVZvbURTbURW?=
 =?utf-8?B?YXZmRGJCL0VvaDdQck1MR0ova3NDNkhFSFJpUXZZZk4zQzNTNWZWZkJucFYy?=
 =?utf-8?B?eVJicFNBS2xPWWI0VTdmNEx1R0VHd3k1ZU40aWNtVW9RSWR2MU1LY1JlSWU0?=
 =?utf-8?B?MHJ6TXlqcW5Zb2I4VTB3TjBPclkwYzZ5VlNzcmZDc1h2cndLaUZGaDVWUFFE?=
 =?utf-8?B?a0VIbkN1NHMxSXZiOU1TVXBQSFVuQnQxTEYwVGZPbkZDc1NPVHd4c0lyTStv?=
 =?utf-8?B?U2FuUCtHL0dKUm0zN2MxR1FuMitQakt1ajJSYWZjU293RVdRYjhMNTdYN3FW?=
 =?utf-8?B?bVVlRmxsRStNR01jTjIyU3dzRzYxZWNLNlMvd2wzUlpnQWJFbThSRWZCdTV0?=
 =?utf-8?B?UlVDeFpyMmFzdlFvcHlhNE5qcXJueXFnTTRxbXhvV1Q2LzNnTzlFdWZ1dnlV?=
 =?utf-8?B?a05QWGFXT20wZXBLYWF1ajVoWVJ3VjBsbExNQ1hXcnRFUUxPaXU3b1lYMC9y?=
 =?utf-8?B?cWpOcjFPUEtRVVBqOE1yZVlGc056TXFLZC82VU45VUN4TGMydGhXVmNJc0s4?=
 =?utf-8?B?ZktOQWtVTWl2NWJDTzc1Z1lSVVA2MDdrczlGejhIMkV0d1hZSThrRXBWOXpx?=
 =?utf-8?B?enlDUVFZQUxtRUVWRnZTNzJlZmY5N1BMN082ZExLbm4vclZmelc2MmVyaDJi?=
 =?utf-8?B?TzkzdHBXaU56WDdhL0tDV3lETlBYbTU4V0lXdFBQM1VKSk8rZld2R2o5ZVZn?=
 =?utf-8?B?RXZuZXYvdkp3aUl5dC9yZHNXbGFJRXgyM2QzWXM0K2hIZnFQVXk3a3J1aGpL?=
 =?utf-8?B?UEpybDJ3N3NEMW5qMzA0WEVQTzlWRjNzbGtua3EwS0hJNGI5R1RCazFXcWFH?=
 =?utf-8?B?L2RqekZKbWFJNW9aNTF3cmcyYTBBSEVJZFJ6TXFqQy84QjNMdEtEZiszKys0?=
 =?utf-8?B?YmN5WkNvY1lNT3ZqcUd1Nmo3Qmp3NC9HUVVzR3BVVUlXUHZoRzJEMWdjZHFQ?=
 =?utf-8?B?OE8vMGtaSStLUENSTzNHME1VeG55Y0JldlRNa0NoUklPZCtNS1B0NGQ4T2Fn?=
 =?utf-8?B?djY0WVNHbnA0d1F1NmdDVFpGeXp0L1J5WVlONWFSeFNrWGQva3VOSlpIRWxN?=
 =?utf-8?B?UjlJZlpmd2xMMDBuRzhSZ1NPcFhpWGtvNE1mV3ZKQWwydzVtVzBCM0p2ajYy?=
 =?utf-8?B?R3F4ZzFsRFR3OG5SSlo3Q2NhSzdFUTNLYUVYUTJqZFRTa3BubjNxNFN2aFEv?=
 =?utf-8?B?SzBxbytzZzNoMy9qVHI2bkNvelhrQ0R0dGI0WnJISUxwYk1lakliRkx0dUNx?=
 =?utf-8?B?d0hOTG1jRUtaWmRnbDFKS2psQ0ZVdFNBQzlINUlGSCtsQjRtOUZ1MFo4d09D?=
 =?utf-8?B?cDdvZGNodDIvS20wSjc5SlQ3SEU2K1FLV1E4V3kyMkJtT0NTdnY2ei9hbVpM?=
 =?utf-8?B?bHoycSs3LzBNZE9iZFowcURRT2luZEFXZEthSWk0TnNXWHNteEtBR1d4Vmdo?=
 =?utf-8?B?QXFTUGtEYVM5eWJ2aEFsVHBneEJWMXJxMitHS055eEp2Q3UzeEs1L29qVEQ5?=
 =?utf-8?B?VlE3UUl6K05nbTVHdVRVZXM0UG45ZDRQcUUrSTV1YXA1MGZUY0NlUE1GY1Y3?=
 =?utf-8?B?MlFQdW5UekxHMWl3Y2J1dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9D11A6718724741A8F0BC980A1D59E8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594ae1fe-35bb-478c-05c8-08d961509dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 07:28:32.0733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqwb2FEgowci4KCDhgRY0NbnGRd4zswkP7UXxeFNxPyIG7UpDollrznsyKG9rPs1zYeDJlc8PpYjIeM+q9QibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBBdWcgMTQsIDIwMjEgYXQgMDY6NTE6MzBQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gSXQncyB1bm5lY2Vzc2FyeSB0byBwYXNzIGluIGEgc3RydWN0IHBhZ2UgKipocGFnZXAg
YmVjYXVzZSBpdCdzIG5ldmVyDQo+IG1vZGlmaWVkLiBDaGFuZ2luZyB0byB1c2UgKmhwYWdlIHRv
IHNpbXBsaWZ5IHRoZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWlhb2hlIExpbiA8bGlu
bWlhb2hlQGh1YXdlaS5jb20+DQoNCkFja2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhv
cmlndWNoaUBuZWMuY29tPg==
