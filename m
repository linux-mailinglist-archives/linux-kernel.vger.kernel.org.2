Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EE931D382
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 02:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBQBDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 20:03:39 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:6049
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229544AbhBQBDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 20:03:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7FVxlIs2t63XXMT7irtm+fW0HiDPs1G64Xh4V0vYd5tYRd26L8Plwabx1xk4/1CM3Td2EaKilAH/eU5jH1z50eH4FLutEAz1X0cZcui/TcA5s5PCl4DKsCSbpNS6YGjxeWz1oG12hROfUD5Nojion9VCozCShOLBkRfEWiF12TX4CJplfcv8QZf2KROCJl283u9HUn2F07eGEfM2MVn2euiLza3R+mb0gZ1wS+VM9GA+jS2Azo8BxLiWWvNY+ncdVvmFoAajVDZXQW4tt9ek/Eu8XL/0NfoMmP70KwrIFgwZZDxO/LeHudP6YffEsHcGjEJY/kzLzmzWJPFrjUdRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSGowJvmwhwG9k1rXgQ41kt4mZhD67Ds4Md/S8FQ1Wc=;
 b=Gb5v+EQlX9XyJtgJaTEZz6q9bMfE9xPchlKWsuaTYadxQomhEvqPHzWEcKluEt9hhr96qkRlBvSI5lwU8RR2fidojKMn1I7DAc7OI1PBiAyBntLDdfKnunylj1kGsvgVDEpl5AHgJuGP+stVeegtQuLdmGgrVt+2usX5cZlJkNJog9HgI6oRewbdHffEXSE6Y+5quvRv0wB/PXSzw6W1XFNFxdBhBY8duv2Vq1uOzgRYDfaooAA47sN9bSfQwcgnpK0TtOnKgXo2bFlbYUS0vTfwxqxK+D9pQJPZ0akeklC2r1LcurtgsxF91Lz/4l3ac0aBmikYshLqMvSyX30zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSGowJvmwhwG9k1rXgQ41kt4mZhD67Ds4Md/S8FQ1Wc=;
 b=qsLun0/+XbrFNn1kI+EIRJiGOKbjkrhsve4ANO23smlf5o+n9t7FlBO1VJSM9e84HLcswxKiVkd4Q3Wtp6om0/nicY0X7KFFkdTEhv+aUwZdckxzck22ANvuKdvtbNXaf6hp8IT7lfY8Wok1St5JMPXuuywWsTjskuL4GHQeVxM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4070.namprd05.prod.outlook.com (2603:10b6:a02:88::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.11; Wed, 17 Feb
 2021 01:02:41 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3846.039; Wed, 17 Feb 2021
 01:02:41 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Thread-Topic: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Thread-Index: AQHXBIFqKsC+lRA3wUC6VAD48B2JFqpbIOyAgAAB54CAAGVXAA==
Date:   Wed, 17 Feb 2021 01:02:41 +0000
Message-ID: <9093B9DA-D29D-422F-8315-750CFDBF2690@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
 <YCvztEk6sqiCxXZV@hirez.programming.kicks-ass.net>
 <457D8FBC-8F64-48E9-B9E2-1A316DB0C2B6@vmware.com>
 <YCwWLSRVB1RG/NHm@hirez.programming.kicks-ass.net>
In-Reply-To: <YCwWLSRVB1RG/NHm@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fe389a9-d872-4912-6e04-08d8d2dfb9f6
x-ms-traffictypediagnostic: BYAPR05MB4070:
x-microsoft-antispam-prvs: <BYAPR05MB4070EFA6E489AEA6CD9CEFCAD0869@BYAPR05MB4070.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9e+RxxBVowVsJ+UzvRHjgBuHQsu1W0M1ciJCjPYOKpYHJBGhvzZJm5/iMiaEB3N6CRhrM2G7NPvuDWrT99k0ZeNFPP5y/sBGPvvSZ4sqVBHvOGSdsxVPYzFW4HoIRg2HDmFDhd59i0bvsxbo5zr+QhTYvIqS6gFZSxHcbdJOrD+6S0xZL01LHoha2EwGRWlGaaZ5JBWpGrxVs/fg6MVz+n66Rw4m+pte/NxYHOT+Qbhfn4vDwzb7Aba07p12R28kS0nxZk7tGQFdPo+FhvIUTANVS7vF8jCNamMJ+pyscQDHdQefTbuizX9xhaF0i9vaghDv+iN0L/Pulok3O0r1j998VZLP0W69DS5+MYY8gdsQT8x9mrachBqJK8yISu0J/3Ys7i2Bh4qYEh0g0Z5Uw1TyFWKCTZKXW5qs+roi92CV3XsMPG/6GfchKFYGsB8wOVo59q6VkSzHZx9hsSbY04bER/aPy0KmwYQo09ild4JtMea2jCSAwMMluiaA7kET3Cnwynl/d1tRNzXeh+B5MphQxwdzYG2uvBanGE5opG98gGPNvA13YX1gJ8+gdJZs1X2VJ3YG2uZxKuF/2tYFYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(4326008)(5660300002)(8936002)(478600001)(64756008)(66476007)(6506007)(66946007)(2616005)(66556008)(6512007)(6916009)(54906003)(66446008)(4744005)(71200400001)(53546011)(186003)(86362001)(2906002)(6486002)(33656002)(83380400001)(36756003)(76116006)(26005)(316002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N2wwNXRtdGY2K21Bc25DemlhalRYWFBzcUtTZWpYZHRPdnM0WWJxc2dGQzhP?=
 =?utf-8?B?NHRVSEJxVDlGcmxBQ1U4OXBHM1BkemREaExKd1d5c2RqQmFBYmxQblVycVcy?=
 =?utf-8?B?SGlxblBZeFMrbXltYmxXdEx3VU9tZnhhRnVpcjUvZDhKZVN4Y1NrSnVFblRI?=
 =?utf-8?B?VUVnd3BMZWpKQzN4VzNHd2wwbGNzWm1teWo4L3Y3NVVyUXdBeVZPOUFxcGli?=
 =?utf-8?B?WHVFbGcwWjVkOVNWSkh1S2FOalQ4OFZrMjFnaU5DZXQrWlh6NDE2a1N2UDZh?=
 =?utf-8?B?LzFBL3VNSFlKWmtlekl1dis5djUvVUxEbU9ObkVmNzkrZWtpQm5CcmZqRjBC?=
 =?utf-8?B?NkZ5VnFHNmo2ejJUOVZsZ2Nib2ptUjhjY2dLWHJFOWJiTi9pODFGZlNRWndO?=
 =?utf-8?B?bzVlWjVHdlJ6VHhMZ1gyQUFDYVZFOHdncStWeW5DNEVsbGlDY2c0M2FCTlFa?=
 =?utf-8?B?RjdEYmxScnExUnB5NytIQTU2Mk5aV0FRdXBGWFBLQXVacm85UEQ1M2h0Z1FV?=
 =?utf-8?B?VlpTRFlUeUxxeHFzYzFudFVLQjhrcFV1S2dETDNUWXJsejJ1Z1R1bGdiT2gr?=
 =?utf-8?B?dklhbjF3eHpzSi9LbDhlWXIxek82d2dRaEk4QjRqUkp4akZ0aVFORkUvWWQv?=
 =?utf-8?B?dGV6bmpFdk9talEvNndvVjd4Tkh5TEdCU25zWFhndldzNEF4bzRwd0ZuV2hK?=
 =?utf-8?B?WGNaaEFHR3owdjhOSFlTK3NHWEtBelkyaTFuWkhRdG83dWY4WHBVa0JKaUlu?=
 =?utf-8?B?VGZGUlNyNVg0bjEvS2hzamlJY2pEdXV5M0ZXbGlJeCtydkpudjladU5DeDhQ?=
 =?utf-8?B?YlQ5UVNTZjdGbGp1SVZhN3dMWm90bWhrVUdmTWFlY0RPSHdLUDRZVC9waXNU?=
 =?utf-8?B?T25sbkJrTUpLbllNRmFPbTgzZ1YrRm1jUkUrdTdlNjVSbXhKeUV5czVrZWFz?=
 =?utf-8?B?NVBUbS9kTlVucHBxa1J6TkcyaUc1NngrNS9pZkY1TXg3bWF0QUNROGRKLzlT?=
 =?utf-8?B?T24wN0pUaU9tRGI4QUU2RXV1TDBubjFSV3BSOGYrRWkrd3BMTUh4R1BIMElN?=
 =?utf-8?B?Y1ROcUt0WjRMQXdwZ01pOXdvRkZ3bklBdmV4SDY3MkplOFZYU3lwQWNuak5Q?=
 =?utf-8?B?SlFVT3lRUkloMVhrWkRMd2NSZ0crNCtsdk9URXFmS29XQU1vMng3cDd3YUM1?=
 =?utf-8?B?bXRNWWRGckt6QVRKUlBrT2RkNUpkeDc3OTlyWno1VVB4NG9PQjc0K2JOcEx2?=
 =?utf-8?B?L0owdHZyQ296a3NycEU2dGVxelcxNEdKWFlxd1VWOTd5NW5Zc0c2Y3RWckls?=
 =?utf-8?B?L3VaaHZ6K0pnM3k3S25mZG0zV011b25NU3dBU2w0aGF6T1piRGtYUkQzcWZw?=
 =?utf-8?B?Z3hvdmw3eXdNazFnbk5qQnBZWDM5SEVFQVZnbTQ1ZnpOa3A4NEJIRnplUVRu?=
 =?utf-8?B?ZGEybGJwYmNha0M5WkxaR1RXZzBpUVVoclRmM25qYVluRlF5WndZN1lidnN0?=
 =?utf-8?B?WWJJam5oNGIxUzZQaUszbkFqUXU5cCtVTU4rQUxZbm5RQVh3RytLMWNIY1Vu?=
 =?utf-8?B?VmRBUFRVUGJIcXhnN3h5WWdxZGMxZ2JUZnNibUIvekRwdnpNMjZjMUtYa0Vo?=
 =?utf-8?B?cVBmeUhGVXlPTFlDVk9xMVZMWU9sYmhPM1lVMDFaNGgyR2NUOFFlRXltZGVh?=
 =?utf-8?B?d2t3amdHWUJuZ2tRZVA0bC9iUGlYYkMzc08wTWRadmVUNEhNQllpNm9KVEl1?=
 =?utf-8?Q?TxSK4KpBvRvRN48INWnFHxkkwAq1KjJ1Ono02K/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <583E7AE9BB2DA14681FC99860666F09A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe389a9-d872-4912-6e04-08d8d2dfb9f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 01:02:41.1242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hMOtNhITDgPrPnmjrBS5orHXDEO/+Iv0sjzYU++5DTvixXr0Ty+/zJTRx9w/MiExUVR/XFrg+l0RgIyFxqvgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMTYsIDIwMjEsIGF0IDEwOjU5IEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBGZWIgMTYsIDIwMjEgYXQgMDY6NTM6
MDlQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+PiBPbiBGZWIgMTYsIDIwMjEsIGF0IDg6
MzIgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0K
Pj4+IEknbSBub3Qgc3VyZSBJIGNhbiBleHBsYWluIGl0IHlldC4gSXQgZGlkIGdldCBtZSBsb29r
aW5nIGF0DQo+Pj4gb25fZWFjaF9jcHUoKSBhbmQgaXQgYXBwZWFycyB0aGF0IHdhbnRzIHRvIGJl
IGNvbnZlcnRlZCB0b28sIHNvbWV0aGluZw0KPj4+IGxpa2UgdGhlIGJlbG93IHBlcmhhcHMuDQo+
PiANCj4+IExvb2tzIGxpa2UgYSBnb29kIGNsZWFudXAsIGJ1dCBJIGNhbm5vdCBzYXkgSSB1bmRl
cnN0YW5kIHRoZSBwcm9ibGVtIGFuZCBob3cNCj4+IGl0IHdvdWxkIHNvbHZlIGl0LiBFcnIuLi4N
Cj4gDQo+IFllYWgsIG1lIG5laXRoZXIuIEJpdCBvZiBhIG15c3Rlcnkgc28gZmFyLg0KDQpUaGlz
IHN0YWxsIHNlZW1zIHRvIGJlIHJlYWwuIEludHVpdGl2ZWx5IEkgcHJlc3VtZWQgcHJlZW1wdGlv
biB3YXMNCm1pc3Rha2VubHkgZW5hYmxlZCwgYnV0IGl0IGRvZXMgbm90IHNlZW0gc28uDQoNCkFu
eSBjaGFuY2UgeW91IGNhbiBidWlsZCB0aGUga2VybmVsIHdpdGgg4oCcQ09ORklHX0NTRF9MT0NL
X1dBSVRfREVCVUc9WeKAnSBhbmQNCnJlcnVuIGl0PyBQZXJoYXBzIHRoYXQgb3V0cHV0IHdpbGwg
dGVsbCB1cyBtb3JlLg0KDQo=
