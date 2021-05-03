Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403673720D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhECTup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:50:45 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:60848 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhECTuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:50:44 -0400
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 143Jhw3Q013048;
        Mon, 3 May 2021 19:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=eXe39SaZYF1ygtFqd0TZViMUP58IJJfD23jobjv15Tk=;
 b=IgzZpT1M28D8rFEXMUGaS678K01FWiWlYYbf/IuHphj27SAGOcCdzcYB4JNcF7luzT8h
 RwtL0ghER3hPbAC1UAIYYIRvlw30lNdpSYDIvEaJ4xGzHlTOEpmDV2rNAXCGlyBxpq28
 X17n72K/yVVyiFqq8+o8OYXVm7TylMQalSt30NozXGwvRRUpSI344X21PRbm7wWRM/Vf
 cxGTSxpCPx5tBmrKswmJhc30qjYLsrdUL3eN1z85wge6cmmMo2LYPPnUQ/kzv0Y8zRwo
 jH+cczWYiQpdLYLJV4GK6t7d+7I+U/djFFg8DAiZhvpvNJ+nqHlaJ12+TfNVXk11lt4F OA== 
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
        by mx08-001d1705.pphosted.com with ESMTP id 388w6mh6ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 19:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kra8nFhzpeHNQ0qrOKQgaUbWqqu1jetO3a6u2UdqKp2vgvkGjc5w0/qx53L1udalDhbEdDDA58bQlJKEfTUF5NbcQsJGZXn5sZHG6i9J3+R9B8AUOAg0BADEbPxvurHWWW422voLGM+/ugIT7/Y40KgjcZs7qO5UCEPH3pTMsjGKSUsSStrFjqfdal1heoEQgegQpCcNV+BjgnIs20lbCfxVTg5mWyKgQRtNhMJJoDE7FpXBR/h1sRxtGCH3r09DduW/PVeA/05PdA9KfS6KwDN21IgCgBcoTKNrUu2DzlmJ4cDT/fA2GA8Y2Yd6tt9JnvtMqy/SaQOpN9SjXlINtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXe39SaZYF1ygtFqd0TZViMUP58IJJfD23jobjv15Tk=;
 b=XcLLD7WEDKc89ch7e0EB9b54kS34tdrXKJGxdNRhMfTQ24dTL/WErlWQFoRlNhR7eX9evzUwfOKPZhiGhaGpSWVLKZRWsTD6LcTz7jPyW+fqLELtIskxsEGgAlroFzgWUah35lN2y2ElV0kQJcrZiY5l2AuyxCS0UjHl7p5QNG0x3X/Efznh/3XR+z+0ilQbdSwE5sq8aCnsLgJauBsha34bovBQyA7XFTGqJZhy0OKV2DwOMuK6kv7x8xG87brNCl8mLIfHj/9f9JfRvGMcYR87Mpj8RkOUpJERsxwnZwE5Cq5C6L4sG5ijYtJvhJupulZPj7yR2qGwa78dEcSTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:306::20)
 by AM9P193MB1523.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:308::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 19:43:52 +0000
Received: from AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::311d:abde:1437:dde1]) by AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
 ([fe80::311d:abde:1437:dde1%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 19:43:52 +0000
From:   <Peter.Enderborg@sony.com>
To:     <ebiederm@xmission.com>
CC:     <mathieu.desnoyers@efficios.com>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <akpm@linux-foundation.org>, <peterz@infradead.org>,
        <ast@kernel.org>, <christian.brauner@ubuntu.com>,
        <dave@stgolabs.net>, <walken@google.com>, <jannh@google.com>,
        <christophe.leroy@c-s.fr>, <minchan@kernel.org>
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
Thread-Topic: [PATCH 1/2] tracing: Add a trace for task_exit
Thread-Index: wQHXPcxKtEu4vBDankanfcyX4+Z7rarR2y0AgAAcuruAABoKgIAAEFzHgAALY4A=
Date:   Mon, 3 May 2021 19:43:52 +0000
Message-ID: <d60a456e-a08c-1eff-245b-64bec065317c@sony.com>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
 <20210430142223.25500-2-peter.enderborg@sony.com>
 <m14kfnzmsp.fsf@fess.ebiederm.org>
 <4bb24db4-f720-f5e7-9054-36bdeaee1d79@sony.com>
 <20210501091104.418765bd@oasis.local.home>
 <1214833117.22933.1620049830326.JavaMail.zimbra@efficios.com>
 <769a00d2-a76d-62d2-aa56-5a107dfdc53d@sony.com>
 <m1sg33lqyo.fsf@fess.ebiederm.org>
 <663fc7fa-e7fc-7d63-9de8-91b5f6fe4f06@sony.com>
 <m1a6pbk5d3.fsf@fess.ebiederm.org>
In-Reply-To: <m1a6pbk5d3.fsf@fess.ebiederm.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec87dfcb-3a6f-49ad-94fe-08d90e6bc7c4
x-ms-traffictypediagnostic: AM9P193MB1523:
x-microsoft-antispam-prvs: <AM9P193MB1523714D9D6B186C2894794F865B9@AM9P193MB1523.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yw2K1A+NHeb5e6T0jnr2WgLcfLOOz9qEmxLQ1223SGLyB+60qvKY2a854EMfU+wDm41TWkwVHX+AL7sGitLQdfgO7IX1sy+gg5mrg7X9wNAz+kMBEWPk55xszWPKsMYtVGL3wZwbRyCs8adb37KoBUL4fyi9KukW4GpE5obezEG08UtOMxoBuqrmADCxjahzHCYrjAd2aP9epSNh2sGXHi/m5tzruMmHlAuC6+n2S0KiQkxXLFGgd7gK/Vkx9a4bIQ0/s46S+eDooOtiBS9/7uQPtMI7b+KGvnX9oAjTa1t6VIQH4p4ecJB80IUjoelvrHosOtmS+EnL+zHV8dvReZGhxcxMwAlas+tyk6UfqtWxUp9odtnuqbYsQ4Ab/mPopR//n1znLY/PDbwPh2KaVau0TCmbhpLgUN214wsXW77JXga7SAZXDk3j3tdsroWZTr9FIu7pMToiXbmUl7Hs2JcopqNMekDY9d761cZ/qkq5tCOWSpxAjnXxtC82lYtG5qZZeQT0wMgb6CiqGAA8O2XTy13WE014AYxMIBbBz6lWXRPCP/3r6MZBzzr4VaNCumo+lHFchKvgaQakmoHz48K2F04TZucoSlA9vkfJwLe+8Gla+TQlh9nRrfcbxy3hMLGMzFFbmboFX3aCCVAUGlS3YA2eftEV5HeQXlRTMrVYYAc1sAccpKT0ALuvQ8KA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1491.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(396003)(136003)(366004)(66946007)(66556008)(64756008)(66476007)(8936002)(186003)(8676002)(2616005)(6916009)(76116006)(54906003)(66446008)(6486002)(91956017)(26005)(36756003)(53546011)(6506007)(31696002)(7416002)(5660300002)(86362001)(316002)(38100700002)(83380400001)(71200400001)(6512007)(31686004)(122000001)(2906002)(4326008)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WG1ib0ExSC8yQ044cmEzVGxJTmFRQ1dyNnUrUWpaK2I5Z1lNZGR0dXdrOFFJ?=
 =?utf-8?B?VmVmbjIyenV0c1NWRHVaNFVCWUdVeUlFaXdpb3hxNldoZU12aWRjeG85V0th?=
 =?utf-8?B?QmpVV3BJOXV2RnBQVWxoeEkwN0U1ZVZSbk5icmJwdGtxTGpvS2UyTmprTzJC?=
 =?utf-8?B?KzUvd291aXc0a3NBMTVJSE8rNlFRcC9hTWhqNVVFVEpwc0VFQjJHU1RJNDBU?=
 =?utf-8?B?SEh4dDZEUDJyS0o4YS9zN2xJREgxVFdvWVhZSzBlVEJ6dVRscnBnY2s2Y2th?=
 =?utf-8?B?QURiNWRMNFFQQk9EazNxZHkxa2FNVUFVRkxiMnFRWXd5cHVZWmptUW42MVdN?=
 =?utf-8?B?cXE5c21qYlhvYmg0ZEpINm4zMFdwN3krYU91Q0hDWkVVVmRCOGVIamZ2WEhx?=
 =?utf-8?B?NXgvclcxc0ZMZHMxcEs2RzNJSE9qNHBPSE84L3NJSTd1QzArU0NDcVgvMTZm?=
 =?utf-8?B?TDBBUWxMY2FQSnRuNks0S2JGWkpXbG1aTVBaVFNxOHN6cERXZFFlWENqQVRq?=
 =?utf-8?B?NzkyWXV5TU9iaWxPNHFJZTgxdUl3eFVvS252YWI3UzZOVWRlbDk5Wmo1WStE?=
 =?utf-8?B?bVZ3YzBUdGY1WVVZZVNWakpTUzJ5YlVvU29kanFvS2V4T0Rjd0N4TS82R2RN?=
 =?utf-8?B?b1RTNktTalM4ODRad3ZReHdsQzFtTnVTQkNyS0hZSVJXREFZVmwzSVRqWjVM?=
 =?utf-8?B?WW1JaUgwUnNpYWJDWnFKUU1MdWthbk5SUnU5SUViU3MrSDAxaUF3M1hYdG5M?=
 =?utf-8?B?SjhCY1NEbm1kVmtjV3J5L0JCeG5qVHQ5SDFPU0plclVyYlF2ejBwOStrNnVn?=
 =?utf-8?B?OVpGclA4MUwvMExqL1BnbTI0R2NEalVGRXhWc3BuR3dDUFZ0ZXBQMzFNUWxO?=
 =?utf-8?B?V2gyeHFMSXZEODIxK1BGOXM0Z2ZOOGFSaUVVVFJYV1kwakl0ejIzaVh2UzhT?=
 =?utf-8?B?d0c0L1dwditMcFBSZXphUHo5ZkgrWWxySUN6Nml5cWRqb1ZlWnc0d0NTSHAw?=
 =?utf-8?B?OWtqcTVidXloaGRhSTBSZUxyNlVpeEVCRlVVanhwNlVjWklJZmx3OVhPdUxG?=
 =?utf-8?B?OGFHNURMekNGYmY5aGMwMjNjenEwb05HeDRlRGd0UVJEeVNFZmpJRUZSbkdV?=
 =?utf-8?B?VlV6N1k2ekZ5dHZGdTRNSFU0ZlRVejRDckFSL09yanZPazVKWVNlVzhMT214?=
 =?utf-8?B?U3R4R0w3ZTRMTlVSZDkzZnZ2U1dMbllqSVRPeldPa1V3OGdia2NBd3lrOEMx?=
 =?utf-8?B?K0lhcXhzaDdpRHNCUElHck5sWC9UR3ZIU3FYUWIyazdxNDBHM0p1dWZ0MSth?=
 =?utf-8?B?b2hoM1JoWWxKQ2g2aXlyYWZYQ21zZW81ZFNGVWdDeVA2U0Q2VFdMdkNqbTNo?=
 =?utf-8?B?ZDdxenpwU3I5OHEyU2gzbXh5TWN0ZXVNbWkyVkhuOUE0bmZ3SXpwVXoxUGpa?=
 =?utf-8?B?ZmhGSFZGVnhYeWJ5RjNpbk5aK2hKbG1xUXJrOXRXR1M3MGlnU2ovaDRsbXZR?=
 =?utf-8?B?T1hJTE1mTERGZTZGTnFyeUZKbW1mMExEZzFXUUFMekMzRGdPeitOOTI0Vm1R?=
 =?utf-8?B?Y0hxWVp1c0dVS0tVd3VNNW1EcUZ1ZTZZc0hFb2lpaytuWFRXYzd0b2VoOEY5?=
 =?utf-8?B?b0RvS1U3ZnVxUDN2V2lpdGJJdmVRTS9lNk1YMDlWRVZPU2s5UDBHeEdSTE9r?=
 =?utf-8?B?czdPZkNvbHp2RzZIVmVEb2hoZmw3WElTdnBIM3ZxblZVVml1ZHRhUXN3cUlH?=
 =?utf-8?B?Sk1hSjBocGhheWRtZEtCK2V4MTlNSmZickhSTUxyZE81RkFYZEdqU2FUUEFo?=
 =?utf-8?B?cGdYaTgxTXRpMEtJQjZ4UT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1FE38A26274E14A80BBF3EE3B05FDE7@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1491.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ec87dfcb-3a6f-49ad-94fe-08d90e6bc7c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 19:43:52.3951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKGGmTWw2VzB9bWpPUhcrCJxUAjP8YrC0cPzDjOJg4XveSvYondVvbU03Vk7r5+XpetiPWDYy7VOFs5li18xPBq1M6rXhAc5Ye8g2ZCm644=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1523
X-Proofpoint-GUID: xTge1IdsB7OcCuVo3Z5wIvjfnTrNJ4_B
X-Proofpoint-ORIG-GUID: xTge1IdsB7OcCuVo3Z5wIvjfnTrNJ4_B
X-Sony-Outbound-GUID: xTge1IdsB7OcCuVo3Z5wIvjfnTrNJ4_B
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-03_16:2021-05-03,2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105030133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIxIDk6MDIgUE0sIEVyaWMgVy4gQmllZGVybWFuIHdyb3RlOg0KPiA8UGV0ZXIuRW5k
ZXJib3JnQHNvbnkuY29tPiB3cml0ZXM6DQo+DQo+PiBPbiA1LzMvMjEgNjozMCBQTSwgRXJpYyBX
LiBCaWVkZXJtYW4gd3JvdGU6DQo+Pj4gPFBldGVyLkVuZGVyYm9yZ0Bzb255LmNvbT4gd3JpdGVz
Og0KPj4+DQo+Pj4+IE9uIDUvMy8yMSAzOjUwIFBNLCBNYXRoaWV1IERlc25veWVycyB3cm90ZToN
Cj4+Pj4+IC0tLS0tIE9uIE1heSAxLCAyMDIxLCBhdCA5OjExIEFNLCByb3N0ZWR0IHJvc3RlZHRA
Z29vZG1pcy5vcmcgd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4+IE9uIFNhdCwgMSBNYXkgMjAyMSAwOToy
OTo0MSArMDAwMA0KPj4+Pj4+IDxQZXRlci5FbmRlcmJvcmdAc29ueS5jb20+IHdyb3RlOg0KPj4+
Pj4+DQo+Pj4+Pj4+IE9uIDQvMzAvMjEgNzo0OCBQTSwgRXJpYyBXLiBCaWVkZXJtYW4gd3JvdGU6
DQo+Pj4+Pj4+PiBQZXRlciBFbmRlcmJvcmcgPHBldGVyLmVuZGVyYm9yZ0Bzb255LmNvbT4gd3Jp
dGVzOg0KPj4+Pj4+Pj4gIA0KPj4+Pj4+Pj4+IFRoaXMgaXMgdGhlIHBlZXIgZnVuY3Rpb25zIHRv
IHRhc2tfcmVuYW1lIGFuZCB0YXNrX25ld3Rhc2suDQo+Pj4+Pj4+Pj4gV2l0aCB0aGlzIHdlIGdl
dCBob2xlICJsaWZlLWN5Y2xlIiBvZiB0YXNrIGFuZCBjYW4gZWFzaWx5DQo+Pj4+Pj4+Pj4gc2Vl
IHNob3J0IGxpdmllZCB0YXNrIGFuZCB0aGVpciBleGl0IHN0YXR1cy4NCj4+Pj4+Pj4+IFRoaXMg
cGF0Y2ggaXMgaW5jb3JyZWN0LiAgVGhlIGxvY2F0aW9uIHlvdSBhcmUgZGVhbGluZyB3aXRoIGlz
IG5vdCBwYXJ0DQo+Pj4+Pj4+PiBvZiB0YXNrIGV4aXQuICBUaGUgbG9jYXRpb24geW91IGhhdmUg
aW5zdHJ1bWVudGVkIGlzIHBhcnQgb2YgcmVhcGluZyBhDQo+Pj4+Pj4+PiB0YXNrIHdoaWNoIGNh
biBjb21lIGFyYml0cmFyaWx5IGxvbmcgYWZ0ZXIgdGhlIHRhc2sgZXhpdHMuDQo+Pj4+Pj4+IFRo
YXQgaXMgd2hhdCBpdCBhaW1pbmcuIFdoZW4gdXNpbmcgdGhpcyBhcyB0b29sIGZvciB1c2Vyc3Bh
Y2UgeW91DQo+Pj4+Pj4+IHdvdWxkIGxpa2UgdG8ga25vdyB3aGVuIHRoZSB0YXNrIGlzIGRvbmUu
IFdoZW4gaXQgbm8gbG9uZ2VyDQo+Pj4+Pj4+IGhvbGRzIGFueSB0aGluZyB0aGF0IG1pZ2h0IGhh
dmUgYW55IGltcGFjdC4gSWYgeW91IHRoaW5rIHRoZQ0KPj4+Pj4+PiBleGl0IGltcGx5IHNvbWV0
aGluZyBtb3JlIHNwZWNpZmljIEkgY2FuIGNoYW5nZSB0aGUgbmFtZS4NCj4+Pj4+Pj4NCj4+Pj4+
Pj4gSSB0aG91Z2h0IGV4aXQgd2FzIGEgZ29vZCBuYW1lLCBpdCBpcyBpbiBpbiBleGl0LmMuDQo+
Pj4+Pj4+DQo+Pj4+Pj4+IFdpbGwgdGhlIG5hbWUgdGFza19kb25lLCB0YXNrX2ZpbmlzaGVkIG9y
IHRhc2tfcmVhcGVkIHdvcmsgZm9yIHlvdT8NCj4+Pj4+PiBJIHRoaW5rICJ0YXNrX3JlYXBlZCIg
aXMgcHJvYmFibHkgdGhlIGJlc3QgbmFtZSwgYW5kIHRoZSBtb3N0DQo+Pj4+Pj4gZGVzY3JpcHRp
dmUgb2Ygd2hhdCBoYXBwZW5lZC4NCj4+Pj4+IFdoYXQgd291bGQgaXQgcHJvdmlkZSB0aGF0IGlz
IG5vdCBhbHJlYWR5IGF2YWlsYWJsZSB0aHJvdWdoIHRoZSAic2NoZWRfcHJvY2Vzc19mcmVlIg0K
Pj4+Pj4gdHJhY2Vwb2ludCBpbiBkZWxheWVkX3B1dF90YXNrX3N0cnVjdCA/DQo+Pj4+IEZvciB0
YXNrX2V4aXQgKG9yIHRhc2tfcmVhcGVkKQ0KPj4+Pg0KPj4+PiDCoMKgwqDCoMKgwqDCoCBmaWVs
ZDpwaWRfdCBwaWQ7wqDCoMKgwqDCoMKgwqAgb2Zmc2V0Ojg7wqDCoMKgwqDCoMKgIHNpemU6NDsg
c2lnbmVkOjE7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgIGZpZWxkOnNob3J0IG9vbV9zY29yZV9hZGo7
wqDCoMKgwqDCoCBvZmZzZXQ6MTI7wqDCoMKgwqDCoCBzaXplOjI7IHNpZ25lZDoxOw0KPj4+PiDC
oMKgwqDCoMKgwqDCoCBmaWVsZDppbnQgZXhpdF9zaWduYWw7wqAgb2Zmc2V0OjE2O8KgwqDCoMKg
wqAgc2l6ZTo0OyBzaWduZWQ6MTsNCj4+Pj4gwqDCoMKgwqDCoMKgwqAgZmllbGQ6aW50IGV4aXRf
Y29kZTvCoMKgwqAgb2Zmc2V0OjIwO8KgwqDCoMKgwqAgc2l6ZTo0OyBzaWduZWQ6MTsNCj4+Pj4g
wqDCoMKgwqDCoMKgwqAgZmllbGQ6aW50IGV4aXRfc3RhdGU7wqDCoCBvZmZzZXQ6MjQ7wqDCoMKg
wqDCoCBzaXplOjQ7IHNpZ25lZDoxOw0KPj4+PiDCoMKgwqDCoMKgwqDCoCBmaWVsZDpfX2RhdGFf
bG9jIGNoYXJbXSBjb21tO8KgwqAgb2Zmc2V0OjI4O8KgwqDCoMKgwqAgc2l6ZTo0OyBzaWduZWQ6
MTsNCj4+Pj4NCj4+Pj4gc2NoZWRfcHJvY2Vzc19mcmVlDQo+Pj4+IMKgwqDCoMKgwqDCoMKgIGZp
ZWxkOmNoYXIgY29tbVsxNl07wqDCoMKgIG9mZnNldDo4O8KgwqDCoMKgwqDCoCBzaXplOjE2O8Kg
wqDCoMKgwqDCoMKgIHNpZ25lZDoxOw0KPj4+PiDCoMKgwqDCoMKgwqDCoCBmaWVsZDpwaWRfdCBw
aWQ7wqDCoMKgwqDCoMKgwqAgb2Zmc2V0OjI0O8KgwqDCoMKgwqAgc2l6ZTo0OyBzaWduZWQ6MTsN
Cj4+Pj4gwqDCoMKgwqDCoMKgwqAgZmllbGQ6aW50IHByaW87IG9mZnNldDoyODvCoMKgwqDCoMKg
IHNpemU6NDsgc2lnbmVkOjE7DQo+Pj4+DQo+Pj4+IFNvIGluZm9ybWF0aW9uIGFib3V0IG9vbV9z
Y29yZV9hZGosIGFuZCBpdCdzIGV4aXQgcGFyYW1ldGVycy4NCj4+PiBGb3IgdGhlIHJlY29yZCBy
ZXR1cm5pbmcgb29tX3Njb3JlX2FkaiB0aGF0IGxhdGUgaXMgbm90IGFwcHJvcHJpYXRlIGZvcg0K
Pj4+IGFueSBrZXJuZWwvdXNlciBBUEkuICBJdCBpcyBwZXJmZWN0bHkgdmFsaWQgZm9yIHRoZSBr
ZXJuZWwgdG8gb3B0aW1pemUNCj4+PiBvdXQgYW55dGhpbmcgdGhhdCB3YWl0KDIpIGRvZXMgbm90
IHJldHVybi4NCj4+Pg0KPj4+IElmIHlvdSB3YW50IG9vbV9zY29yZV9hZGogeW91IHByb2JhYmx5
IG5lZWQgdG8gc2FtcGxlIGl0IGluDQo+Pj4gc2NoZWRfcHJvY2Vzc19leGl0Lg0KPj4gVGhhdCBJ
IGRvbid0IHVuZGVyc3RhbmQgd2h5P8KgIG9vbV9zY29yZV9hZGogaXMgcGFydCBvZiB0aGUgc2ln
bmFsLA0KPj4gd2h5IGlzIHRoYXQgbm90IGludGFjdCB3aGVuIHdlIHJ1biBfX2V4aXRfc2lnbmFs
ID8NCj4gWWVzIG9vbV9zY29yZV9hZGogbGl2ZXMgaW4gc3RydWN0IHNpZ25hbC4gIFRoZSBuYW1p
bmcgb2YgX19leGl0X3NpZ25hbA0KPiBpcyBzaW1wbHkgaGlzdG9yaWNhbCBhdCB0aGlzIHBvaW50
LCBub3QgZGVzY3JpcHRpdmUuDQo+DQo+IFRoZSBmdW5jdGlvbiBvZiBvb21fc2NvcmVfYWRqIGlz
IHRvIHRlbGwgdGhlIG9vbSBraWxsIGhvdyBhZ2dyZXNzaXZlIHRvDQo+IGJlIHdoZW4gb29tX2tp
bGxpbmcgZnVuY3Rpb25zLiAgVGhhdCBzdG9wcyBiZWluZyByZWxldmFudCBhcyBzb29uIGFzDQo+
IFBGX0VYSVRJTkcgZ2V0cyBzZXQuDQoNClN0aWxsIGl0IHJlbGV2YW50IGZvciB0aGUgY2FzZSBp
dCB3YXMgb29tIHRoYXQga2lsbGVkIGEgdGFzayBvciBub3QuIEFzIEkgc2VlIGl0DQppdCBtdXN0
IGJlIHZhbGlkIHVudGlsIHRoZSBwaWQgaXMgcmVtb3ZlZCBpbiBwcm9jX2ZsdXNoX3BpZC4NCg0K
SWYgaXQgd2FzIHBhcnQgb2YgYSBvb20gb3Igbm90IGlzIGRpZmZlcmVudCBtYXR0ZXIuwqAgSSBo
YXZlIGEgb29tIHRyYWNlDQp0b28sIGJ1dCBJIGhhdmUgbm90IHNlbnQgdGhhdCB5ZXQuDQoNCj4g
QW4gb3B0aW1pemF0aW9uIEkgaGF2ZSB0b3llZCB3aXRoIHRoYXQgd291bGQgYmUgY29tcGxldGVs
eSByZWxldmFudA0KPiBpcyB0byBoYXZlIGEgdmVyeSBtaW5pbWFsIHN0cnVjdCB6b21iaWUgdGhh
dCB3b3VsZCBjb250YWluIGp1c3QgdGhlDQo+IGluZm9ybWF0aW9uIHRoYXQgd2FpdCgyKSBuZWVk
cy4gIEV2ZXJ5dGhpbmcgZWxzZSBhYm91dCB0aGUgcHJvY2Vzcw0KPiBjYW4gYmUgZnJlZWQgd2hl
biB0aGUgcHJvY2VzcyBhY3R1YWxseSBzdG9wcyBydW5uaW5nLg0KPg0KPiBJdCB3b3VsZCBtYWtl
IG5vIHNlbnNlIHRvIGluY2x1ZGUgb29tX3Njb3JlX2FkaiBpbiBzdWNoIGEgc3RydWN0IHpvbWJp
ZS4NCg0KQnV0IHN0aWxsIHlvdSBjYW4gZG8gYSBjYWxsIHRvIHRoZSB0YXNrX3JlYXBlZCBpbiB0
aGUgZmFzdCBwYXRoIHRvbz8NCg0KDQo+IEFzIHN1Y2ggaXQgbWFrZXMgaXQgdmVyeSBiYWQgY2hv
aWNlIHRvIHBsYWNlIG9vbV9zY29yZV9hZGogdXNlcnNwYWNlIEFQSQ0KPiB0aGF0IHRyaWdnZXJz
IHdoZW4gYSB0YXNrIGlzIHJlYXBlZC4NCg0KaWYgaXQgaXMgcmVsZXZhbnQgZm9yIGl0J3MgY3Jl
YXRpb24gYW5kIHJlbmFtaW5nIHN1cmVseSBpdCBtdXN0IGJlDQptb3JlIHJlbGV2YW50IGZvciBp
dCdzIGtpbGxpbmcgc2luY2UgaXQgaXMgcGFydCBvZiBpdCdzIG9vbT8gSG93ZXZlcg0KdGhpcyBw
YXRjaCBpcyBub3QgYWJvdXQgb29tLCB0aGUgb29tX3Njb3JlX2FkaiBhcmUgdXNlZA0KYXMgYSBw
cmlvcml0aXphdGlvbiBpbiBhbmRyb2lkIHdoZW4gdGFzayBhcmUgcmVjeWNsZWQuIEhhdmluZyBh
dCBhcyB0cmFjZQ0KcGFyYW1ldGVyIG1ha2UgaXQgZWFzeSB0byBtb25pdG9yIHRoZSBhY3Rpdml0
eSBhbW9uZyBzZXJ2aWNlcy4NCg0KSnVzdCBzZWxlY3QgdGFzayAwLTI1MCBhbmQgeW91IGdldCB0
aGUgYXBwbGljYXRpb25zIGFuZCBzZXJ2aWNlcw0KdGhhdCBpcyBjdXJyZW50bHkgdXNlZC4NCg0K
DQo+DQo+Pj4gSSBwZXJpb2RpY2FsbHkgbW92ZSB0aGluZ3MgZnJvbSB0aGUgcG9pbnQgYSBwcm9j
ZXNzIGlzIHJlYXBlZCB0byB0aGUNCj4+PiBwb2ludCB3aGVyZSBhIHRhc2sgc3RvcHMgcnVubmlu
ZywgZm9yIGJvdGggY29ycmVjdG5lc3MgYW5kIGZvciBzaW1wbGVyDQo+Pj4gbWFpbnRlbmFuY2Uu
ICBXaGVuIHRocmVhZHMgd2VyZSBhZGRlZCBhIGJ1bmNoIG9mIGNsZWFudXAgd2FzIGFkZGVkDQo+
Pj4gdG8gdGhlIHdyb25nIHBsYWNlLiAgSSBjZXJ0YWlubHkgd291bGQgbm90IGhlc2l0YXRlIHRv
IG1lc3Mgd2l0aA0KPj4+IG9vbV9zY29yZV9hZGogaWYgY2hhbmdpbmcgc29tZXRoaW5nIHdvdWxk
IG1ha2UgdGhlIGNvZGUgc2ltcGxlci4NCj4+Pg0KPj4+IFdpdGggYm90aCBzY2hlZF9wcm9jZXNz
X2ZyZWUgYW5kIHNjaGVkX3Byb2Nlc3NfZXhpdCBpdCBsb29rcyBsaWtlIHdlDQo+Pj4gYWxyZWFk
eSBoYXZlIHRyYWNlcG9pbnRzIGV2ZXJ5d2hlcmUgdGhleSBjb3VsZCBiZSBuZWVkZWQuDQo+Pj4g
dGFzayBleGl0Lg0KPj4gSXQgbWlnaHQgYmUgd2hlcmUgd2UgaXQgaXMgbmVlZGVkLCBidXQgaXQg
ZG9lcyBub3QgY29udGFpbiBpbmZvcm1hdGlvbiB0aGF0DQo+PiBhcmUgbmVlZGVkIGZvciB1c2Vy
c3BhY2UuIEkgZG9uJ3Qgc2VlIHRoaXMgYXMgdG9vbCBmb3Igc2NoZWQgaXNzdWVzLA0KPj4gYnV0
IGFkaW5nIGluZm9ybWF0aW9uIHRvIGV4aXN0aW5nIG9uZXMgaXMgb2YgY291cnNlIGEgb3B0aW9u
Lg0KPj4NCj4+IEhvd2V2ZXIgY3VycmVudCB0cmFjZXMgaXMgdGVtcGxhdGUgYmFzZWQsIGFuZCBJ
IGFzc3VtZSBpdCB3b250IGJlDQo+PiBwb3B1bGFyIHRvIGFkZCBuZXcgZmllbGRzIHRvIHRoZSB0
ZW1wbGF0ZSwgYW5kIGV4aXQgcmVhc29ucyBpcyBub3QNCj4+IHJpZ2h0IGZvciB0aGUgb3RoZXIg
dGVtcGxhdGUgdXNlIGNhc2VzLg0KPj4NCj4+IEkgc3RpbGwgc2VlIGEgIm5ldyIgdGFzayBtb3Zp
bmcgaXQgdG8gZG9fZXhpdCBtYWtlIHRyYWNlIG5hbWUgbW9yZQ0KPj4gY29ycmVjdD/CoCBPciBp
cyB0cmFjZV90YXNrX2RvX2V4aXQgYmV0dGVyPw0KPiBJIHJlYWxseSBjYW4ndCBzYXksIGFzIEkg
ZG9uJ3Qga25vdyBtdWNoIG9mIGFueXRoaW5nIGFib3V0IHRoZSB0cmFjaW5nDQo+IGluZnJhc3Ry
dWN0dXJlLiAgSSB3b3VsZCBhc3N1bWUgaW4gbW9zdCBjYXNlcyB3aXRoIGEgdHJhY2Vwb2ludCBp
biBwbGFjZQ0KPiBvdGhlciBraW5kcyBvZiB0cmFjaW5nIChsaWtlIGJwZiBwcm9ncmFtcykgY291
bGQgY29tZSBpbnRvIHBsYXkgYW5kIHJlYWQNCj4gb3V0IHBpZWNlcyBvZiBpbmZvcm1hdGlvbiB0
aGF0IGFyZSBub3QgY29tbW9ubHkgd2FudGVkLg0KPg0KPiBBbGwgSSByZWFsbHkga25vdyBzb21l
dGhpbmcgYWJvdXQgaXMgdGhlIGV4aXQgY29kZSBwYXRoLCBhcyBJIGtlZXANCj4gc2xvd2x5IHRy
eWluZyB0byBjbGVhbiBpdCB1cC4gIEkgcGxhbiBvbiBpZ25vcmluZyBhbnkgdHJhY2Vwb2ludCB0
aGF0DQo+IG1ha2VzIHRoYXQgZ2V0cyBpbiB0aGUgd2F5Lg0KPg0KPiBFcmljDQoNCg==
