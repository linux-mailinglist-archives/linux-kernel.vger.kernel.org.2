Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B5B3EE734
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhHQH3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:29:01 -0400
Received: from mail-eopbgr1410082.outbound.protection.outlook.com ([40.107.141.82]:25857
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234560AbhHQH3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:29:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVelBk1uybN48uFIKtT4L8inf8CUB4/WmHVI5fnn02gdmXybC+7ymULi/+fmJCBvpk7GXmL/pLdi+QLDq0hkNtaCeUKb5iX1dTHUA9K1GvIjScdnv0bfR1iHxAV2zphZjkfbz2cnRsVyMd+WloBMC5BKyvWa1B1fXX4cyIgw/z7RcmiMNAK+3VAO2auXVHrr/aN1Scid9Q3cBIsmcLjlwwW47n+4jukNXnVGHlY6MPzikdgJayxO+SRBg61/ULcPP0UVWUiKbXpC2HLTLeu9nZ67B4Z9ocBWYcKUhAB43F4smdwaJNJo/KBjQW7YBLDV9TRxZXs3EUpLZr3Gg5ve4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrpfZNz85mRnDySyR9UisNSzBI5zC+5dRCdZNEcFFe4=;
 b=BZ3Nel+kJXPNtym4VPABCidjTL4zWXHT6OMpA4qQjocbvNSHGU8TaLTdLdSTXnarS45vfCRS5rtmoXwbz3OktTYGOAxu2fFPjnlB+zGgg5EioyMCz31fZRhU+sGhJh8bTp5tNrw39Ys7Z87emY2gnZo8ay9wToH62zZx/Zi+slvy2Drj2THPgJF94iFPqj8Wi0EmnwuTDZKRXPa4f0ZgBl1I5QF5yIWAl6UFWjlhrUQtNO5rwRfE1RScaISeeR4DrlszS92J4ebA9PmN/SqmL84ZWjAegqyiluk5odQDNRvleVNpTPzF43Be/vaopwuKtjVKG5PFLbpwlf8s8wb6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrpfZNz85mRnDySyR9UisNSzBI5zC+5dRCdZNEcFFe4=;
 b=fg0vys2Y/ZhVmkxCNndrcSj4aPLb7Deg7UQn/cGZmnoWbnOjwZ0WTjqsltjL9thyER6CmySRlCwG3/KJKxA4exXSi8BV5UHpePMOXt/5NAD+zMX23trifUMbOgvK8EZFWyx8Gq1PeExAKCwf1atqzK4nL08OfYpSjFnYx0LxBDU=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB3965.jpnprd01.prod.outlook.com (2603:1096:404:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 07:28:26 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 07:28:26 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mm/hwpoison: remove unneeded variable unmap_success
Thread-Topic: [PATCH 1/4] mm/hwpoison: remove unneeded variable unmap_success
Thread-Index: AQHXkPpecRA/Sq/XtUSE1vc8TyIiUKt3UPmA
Date:   Tue, 17 Aug 2021 07:28:26 +0000
Message-ID: <20210817072825.GA452988@hori.linux.bs1.fc.nec.co.jp>
References: <20210814105131.48814-1-linmiaohe@huawei.com>
 <20210814105131.48814-2-linmiaohe@huawei.com>
In-Reply-To: <20210814105131.48814-2-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2faa0f92-9b74-4087-c2d6-08d961509a70
x-ms-traffictypediagnostic: TYAPR01MB3965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB3965B31B6484A3B292177892E7FE9@TYAPR01MB3965.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4M4QskNOrtIQXzTZKNHoB/OPy0Wy4rc6qWbPsJoPDmnLeqdk4up14j2C7QiBEpEcyQxFunv+lf9tEmdy3YxULrXtPXlLkepFfJZnAuMxJhAqX1QFT0vUAtdJx6yDl58gvKsxNxdZ68sG8nlXCEskjX1SDEP23yi0+gugnJuEdcqTw3mIdiBh/11AfKJKTbznGxDZPTmd/qt6D9V4wohGsjhRVhdlxev5ty/zZtxT3wwxr6yOaktFJBRVvuW0HBT1cKt9AW3XW6xS8lr62SinQ/FXyK3b5FYygWDi+i4W/vhOSFpiu0vusXz7LjXV5viuZYGXawDGItgPN9WFSqlycEXAjBn4aO8PoY8QjyJ5aJ85YDsOuWT21rISeTB8Na7hCuOIlw31I9MB9fr7sAofOuhQn00RQCS96ibR0CjKYzHQbDNUG4YMUa0Kcsl6BLrU5Vh+quHcyA1czZ5EisG4BsaMA4xfSP2KSeE7i7DUlYofC0X7rt1fC5QgYThWAK1VYeX9hrhJnZXbhhX9WVsp02DDs7BSYJEx70VZ3r7poYz/Jo8OKlm819D4vy8da7rC3DePXEiLHZIuI4wwjCxHYnGgUnzMDE78nxRCIXFSfPOWH2dfrCZbXwRrBMQw+DV6wET1+c/rK2CMVMcM8543htFrk3n06B2CoSYM5pRPc9Zb2NRlfcHSGL4puoNnf2Ns7ADxXRaksRRyYR/lr1/jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(8936002)(5660300002)(85182001)(1076003)(122000001)(38100700002)(478600001)(33656002)(4744005)(316002)(54906003)(6916009)(2906002)(66946007)(55236004)(86362001)(8676002)(66476007)(64756008)(26005)(66556008)(66446008)(6512007)(9686003)(6506007)(4326008)(186003)(76116006)(71200400001)(6486002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG9veGdJZmYxWlppYUtoVFpKVE9FQWNrRjZNWmQxdE9ZaERDREFGNjRTd1dD?=
 =?utf-8?B?dFl1RWUyU2FJV0QyWnc4bUJWTUVwODF2eks4THZDQlZtRW9EalBFSzVvUU03?=
 =?utf-8?B?OW9VemZQOG8vRWRTczk2TVlzNGJ6UWllRVp6WWp3NkZOV2FzNVhKdCtEcURh?=
 =?utf-8?B?Q1dKU1ZhcXI1ci84NzREb3phQmNYN3BqaFNVM1hzZHhyVkpPdUdhY0FBNWQv?=
 =?utf-8?B?eWEvVkFrR3FJcG9lN0JaVm5CRlRSczQwS3p0VEpNUVR2Lzk1QTc1ek54bDF5?=
 =?utf-8?B?OFVXK3NQVXdaK3MzTnlwWTNZWjNpT1VUZTBNR21GTUQyNmoxTUxHazJjcWdo?=
 =?utf-8?B?dFZYcTBOVkRQU2RxTGJwRW40d01pWG9vZ0UvZ3hxU3UvNnVlL29RdDE5VUp6?=
 =?utf-8?B?L3VPT0lBRlBNbFBQVXk3cy9uTFVuL1d5SzVCN3RPbWNEZTVGT2dGRVZCMDVo?=
 =?utf-8?B?N2dJVW1odkU5Q2ltVzVwajhKQXdOVjNjMVVHYlFmalZrVlZwbEt1bitJQjRX?=
 =?utf-8?B?anFPYTljTm1JTWwyN0l6Qm84aHVLMHJicEhEOEx1MjdaMjk1akVQUjBwMk1u?=
 =?utf-8?B?cGFsY3hVRHRBNWdUNzNtd3N6RzY0QzE0dWdpN2RDT0oxTUtMbmZBUlFyS2l4?=
 =?utf-8?B?QTJNend4Ym91czNhakxFdXpIOGRSbmZpTkIwTnpsY0tmWFRZV0pYWjVXOXds?=
 =?utf-8?B?dDY5eTY3YWxtMGtvYTlXN2UxSkdJT3JIaXd2TVk4MlVXaG5Dc051ekVqMVY4?=
 =?utf-8?B?ZDJpN0xub2crZkZ1WjhKSFlQcm83MkZiZXlreXN6NlhDc3VDR0w0Uk5NSjA4?=
 =?utf-8?B?eTlsSldGSFJBeDgxa3BFYWZIQW5MMVlsT3hOYStGbDVGeGpFZ3cxYzVQMEJj?=
 =?utf-8?B?ZlFRd2cvL29CQkVHdUltL0xyY3J3ZTNiWFRPTHJWRG5jQnBsNjJoNCt2aUw0?=
 =?utf-8?B?NmM1a2ZYQ21jOHNjTnpqTW5aZ21NdHEza3EwWGRtWmhyaThmNlRrQnNEV3gr?=
 =?utf-8?B?YVR6NjFGbUd1K1FBZTFNTk9rL0FLbjV4UWdBZG5iVnE2RUpYZk5GRFNLRDll?=
 =?utf-8?B?aDZpUGs1a2Ezam9UU3VIcFZibU1oZGhvbmNqbDNIRjY3cWNwTXdKTlQ5Yldq?=
 =?utf-8?B?SHNMaWw0dWN4aDU2Y3JyVmdwYU5aU3Y3N3U1MG1IaW9vUzJxWUxtT0RGNzF6?=
 =?utf-8?B?NE1OZnpFTG9oYUtGMysvTHppYUZlNHA5Y3Q1SHkwMmU2Wm50YklncUlVZ3lS?=
 =?utf-8?B?VS9ISDhNamJ5WXJ5M2dDZGNWaWk0T1ErL1RicDQ1L3FldFNYQzhCNnd1elFn?=
 =?utf-8?B?L0YwZTlWcWNmOEtjMzh0UkR2TGxrRExlQVNpbGpvd0VsTUVrQU1WUTd5ZllZ?=
 =?utf-8?B?VVFFRmhQNjlENEpKZCt0NGVOZ3d6RDllNVJVUFhxKzVCcDUzU0pYM0drUElh?=
 =?utf-8?B?cUpTOVQ4cWlMVHpVRk1DWjF0UlNpNzZtSlN1aHh0dk1YUTFZSjBDVlpnMTdS?=
 =?utf-8?B?a2c0UGlHRHF1WENGbmRHbkhlVTR2TVBlSmtsRWxZR2pzSmM0V2hPamkyQmtQ?=
 =?utf-8?B?WU5nWlZ4eTRFSko1RWpZVEVDZXdCM21CNjVqNG9ZdzdFZWJ0M3lwL1VlczVh?=
 =?utf-8?B?OFU5K1ZxM2RiYjVrTXIwbWFDd0tVUld0WVlLdHF0RUxqaVJuUHlYQTZmR0lC?=
 =?utf-8?B?K2k4TE5WWGlJVExsdmRGRXJEMk4vcTNPbTkreWhXUTJUYnpocSs3NjRKREJo?=
 =?utf-8?B?bVozOG1Tbm5QTE5PUy9mOE0yV1FYbGdya0luUEN5WWY2aHdOUGtjTWNqNHNS?=
 =?utf-8?B?b1ZNUmx2eTNnWjRMeEs1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <415870E64438944C9F3F390F281DD6C5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faa0f92-9b74-4087-c2d6-08d961509a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 07:28:26.5145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLqSrhEw6cNmjDAwhr7zwPhU1XzlCnXlRkJJqnF3pOgVpAfuXV0cT9d4oGzjx+gKJdEb6nVJS/kyPHe9c1tHfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBBdWcgMTQsIDIwMjEgYXQgMDY6NTE6MjhQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gdW5tYXBfc3VjY2VzcyBpcyB1c2VkIHRvIGluZGljYXRlIHdoZXRoZXIgcGFnZSBpcyBz
dWNjZXNzZnVsbHkgdW5tYXBwZWQNCj4gYnV0IGl0J3MgaXJyZWxhdGVkIHdpdGggWk9ORV9ERVZJ
Q0UgcGFnZSBhbmQgdW5tYXBfc3VjY2VzcyBpcyBhbHdheXMNCj4gdHJ1ZSBoZXJlLiBSZW1vdmUg
dGhpcyB1bm5lZWRlZCBvbmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5t
aWFvaGVAaHVhd2VpLmNvbT4NCg0KSGkgTWlhb2hlLA0KDQpUaGFuayB5b3UgZm9yIGZpbmRpbmcg
dGhlIGlzc3Vlcy4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hp
QG5lYy5jb20+
