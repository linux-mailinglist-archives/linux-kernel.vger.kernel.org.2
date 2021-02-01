Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7722B30B313
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBAXA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:00:59 -0500
Received: from mail-dm6nam08on2086.outbound.protection.outlook.com ([40.107.102.86]:36448
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230154AbhBAXAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:00:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxsIyHi33F6e5cuZ1f5obv+Z6lyE/oFlIivDWf9APlrCQrtLP/0JoWl90gRNAhF1rmmxY1yWp6N9FnxJROAWgkwZcQjdOatYaQxUHuZBRqt447c/TrG2jWdgv/pXcK4LvkNRIAeH7+yKs0LnSTYl3Ca3ump6vj+ksEJg0rvieZrHZ+Sd3Fh6/kDX1qQHXNgYyxxShM7bxEihQT00+hUMBVvij5qmfD9Q3yQLy+b+vBqlmCgTETOmKKnRcDlzK9EhXngkxsZO7HMNmniH7vIFWEYfym+15mES/2bMNymzJgVexBpNDUCUOavEQ1XtEKIdNVQae4q/v1/9CeENAMR64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JVynt9r6ZsEJ3fQ00sHfCdtcbp2RxfA0ow3pm5AP9E=;
 b=R/FVo1fvkQ1fShY8GDzn+E/HT05vkPCpUKbmxJmQxm/EcRJ8njys9mRvE1DHj6JILOfE3iFajKSCdUfJ3fFlfalIjmlklETqmG57xkRo4DYiuALq5ewZ2nQBP/DYoKiBohGDEi5bmkslRJ1uuIvaI6nU0vYRJzExcUs3u/YzODfyC9Rx9Daig7XRFLQFqPKPxBIfmZvwx7VxL01z+JfTf949C6lwcUKFy7SP1HGCxh72dSLdDOUDtLRyPIb+DSTbyw2FuCEysTbvccllHjvkbxodh3jXzFhTumQHsS6/lOTHqwMjBiwD5cU8hrmN+rJMAHl6LHn1di1vt0PiVbBSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JVynt9r6ZsEJ3fQ00sHfCdtcbp2RxfA0ow3pm5AP9E=;
 b=fSvol2SYwXWi61jJxB86M4z1NcJVS73y0OyDbEYZ8aLJOwU+ScIch19PGixR3YHEmzdbJHXPYyRRTUXB6/3989hkN2oGKF4+4Ykz3V3t0vn5EMRMbOyCZpVsH9DUcR6tn1yWqtD/pRR4u0S+xKd0R6OyZQXJWY7yuTVyAko9tBs=
Received: from (2603:10b6:a03:4a::18) by
 SJ0PR05MB7689.namprd05.prod.outlook.com (2603:10b6:a03:2e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.13; Mon, 1 Feb
 2021 23:00:00 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3825.013; Mon, 1 Feb 2021
 23:00:00 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 13/20] mm/tlb: introduce tlb_start_ptes() and tlb_end_ptes()
Thread-Topic: [RFC 13/20] mm/tlb: introduce tlb_start_ptes() and
 tlb_end_ptes()
Thread-Index: AQHW+JzmH746u98gEUKBXN+2lRCvWqpD6rSA
Date:   Mon, 1 Feb 2021 23:00:00 +0000
Message-ID: <9D234926-25BF-4456-8EC5-1A578232EF07@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-14-namit@vmware.com>
 <YBf/1H/zZ2LNDf3U@hirez.programming.kicks-ass.net>
In-Reply-To: <YBf/1H/zZ2LNDf3U@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f91e73b-975f-4507-cd47-08d8c7051a9a
x-ms-traffictypediagnostic: SJ0PR05MB7689:
x-microsoft-antispam-prvs: <SJ0PR05MB76890E2DB0D0E8E27929CCBDD0B69@SJ0PR05MB7689.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X09MevybihPLSIcUeWOAVOll61rzJERvcUxgIVzX8137WdwXC+TJz0cOtaILaNhN3o/at04EkfLApI7kDn7s8BzyxGue4iKs9z+O0C4ga+x+FTyR/zruPaODHxtPL2G6E8KxxBYtW7U7VYNXnKQ+IGg6UtVmAael90y3sLoogKTNmemioDjb2gEmiVR2wD0F2sDOGgifGwovCkrj0pza/rjZwO/+fAzEZG0yu9GxgCxNQqqwjyRWNxIx9fym7d9UaZLd6uO7CZ4KYbrnPliEx+Z/lF65ztyksdy+ye5l+1kkaiCRe9jZIt9KOYsv2BVGYZjT5B5RAweXJTF9fbvMIkukR72KPp/D3Z5RvyJ6ME4bxsezOxD0csg3oEP5GsBrwLtURvfavyTn1fqT6Bc6sEZWVkbwN/qQXniF/HBEm1eT4K93evp9sQNQnDWVgVG+firbcZlnak54KOgRXfmTY6PeaTs6ah15rAy4hKwxBJvBZ64O/OdpfGx1YePKTEb7+M04vJd2r62vxrLreSWMethWHM7r3X5Mm0uSKOk0Do9syW2i8fNXf625y1YZtW9M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(86362001)(36756003)(2906002)(6506007)(7416002)(53546011)(83380400001)(8936002)(5660300002)(478600001)(66476007)(76116006)(64756008)(66946007)(66446008)(66556008)(33656002)(54906003)(71200400001)(6486002)(316002)(2616005)(186003)(6512007)(6916009)(4326008)(26005)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ekpqeFIwRXl4WHE4UWk3SDd3bUtIT0Y0dmlJSGpvbjNaRWV3OGtsNDNVakNz?=
 =?utf-8?B?UEFIWjJtaHg0WWFUQ3FDbmZRNXpyK3RyOXpuTEhzTi83L1FNeUgzS3FMTk1x?=
 =?utf-8?B?UzB5aG1Vb2R0WWFLOXYySWJOTUpmN09jZ3hNRmxhSUlnWVh5NnBjSXNRbmRn?=
 =?utf-8?B?RTI1VUcxcGFDNDdyb3ZjTEI2R2EzS3NXM2ppWUd3RlRuem93UEpseWNJZTgv?=
 =?utf-8?B?ZkdQeTBVYjM1UVNSRnRUeUU2YUhZUnpKZGwzNGlCa3pWQ3dyREh4Y0xpRURZ?=
 =?utf-8?B?L3RwL2ZnNDVvYkZBNms2M3Y4d1R6RU9lakdZTVpKc1hqUTNRWHJKbk1xTFVy?=
 =?utf-8?B?emFDYklyVy9uYk5PV2laOWdsQktoTWJvWkZIbFQrazZoTWlpQ29uNEhXbFZq?=
 =?utf-8?B?QUhOc3VVbDk1Y3Q3NFVSOEE2dmY5SmNLYmxXRk9TV1JkZWpLYVcwRDUyQ3d5?=
 =?utf-8?B?MnJuZGhMWU1XWUFVdzhUbS8yWDE3UElBRm8rMkZqUnhIeGY0WHhTWmlIUkFM?=
 =?utf-8?B?RU44UkRnbVhNL2tmSHc3WS9yODBYbVFhQ1V6UEthZGRSNFlVcllPRlYzdlVN?=
 =?utf-8?B?cDY4MzFlV2dUMXplMWxJRjJ5M1NmeUpiVGdOSjNSc3hZS29STm8yd3FDdjB5?=
 =?utf-8?B?ZTM1blo5WmduTWgxUmdDMlhqZ0Z0YkVsWCtJWllIQjdYTEUxVjBGa1U1ODdu?=
 =?utf-8?B?cEd4ckNqTXlZU3FiNnRSR3RkR2t4WG5RQk4waHlzY0hOU1JBTHA0V1hqemZw?=
 =?utf-8?B?N01XOFQyMFBEbTVrUkk4OHBKTWg0amhjeTdnNFBYOElnNGY3LzUxdzUyKzQz?=
 =?utf-8?B?SlBsZTJJSDMyQk5HMm9vYkduY2lNSk4zc2tvMktNeWMxeEtTclFnYWtJZkdE?=
 =?utf-8?B?YXIzaEczYld2UW5OMXBVazh4TTYxajJORWxiSXRMbmE3Qzl5M3BsTzJzVjJZ?=
 =?utf-8?B?UkZaNm1LckJ1OEE0dUp0V1BIemM3dURkU05va215Y0Q1T0JRN1lMSE00bytp?=
 =?utf-8?B?R1Z3d1dGc2lGQ0lLaDk5cmJhcEJjSWhlVjJlQzZ2cFRDSU82Y092TVVMWGVz?=
 =?utf-8?B?d1hMckJuVWVOaHRFRW1IdVQzc1UzN3RsdG1jWWVPVTZ1NG13bWtzMnhTQjBV?=
 =?utf-8?B?NTV3aHQ5c0J0OWhwYVJ1b1V4QnZEdEtHbUdRbGMzUm12V2tZVDEvWTJjQzVl?=
 =?utf-8?B?VS9zaEJvMUR2WlhnSGttNUFYWlhkbUFvUGRuaHFLZFhEUUFDRWlldkMyek56?=
 =?utf-8?B?K3BLNXNMRXpjZER2T2l6dFRkeXQ5QXNSb0k5S1d5NHRKSzFoaVc2WmphQUc4?=
 =?utf-8?B?YzdLMUhybUkzQXp6T2VwRUFHZmIxdzZKdWovcktjUzZQa2piWTNTU0puakZl?=
 =?utf-8?B?RkwvWFA3RzJBeW9FK3N2SlNoVUlkZHBKTFd1V29ERHdReFYyUU0xemhudFZF?=
 =?utf-8?B?M0xyWGQzK1RJUnB4Y3FCNFVOeFV1WHA2KzlHb3oyOGRDV3RJaTJYbmp1ZWhr?=
 =?utf-8?B?VlBzSkkvOEd4WjQ3KzNXcElTR2dUU1BaRTFGL2E5K3RmY3BwSU1JYkpDRVkz?=
 =?utf-8?B?SEtONFUrSUFZV00xWFU0bnpaT0kzNnduM0xpSXcrMjJkbU1Ec2wzS0dna29V?=
 =?utf-8?B?WER3ZGljR2NnWnU2d25uZEQ1OGRMY2E0RytCZ1RCaU41cDloY1FPK3Bob3Fi?=
 =?utf-8?B?UVRyY2J2SFJzTjVsR2c1cXpRb1dWN0k3c3c0ZFhBVXFzelFsM0RDQXZGOFR1?=
 =?utf-8?Q?NqOdHUIngqrPEoIcegEXYBDkOP+fJkn7zt9MlSJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C487836F7DDCC4E8B0E4A5EFE183EC9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f91e73b-975f-4507-cd47-08d8c7051a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 23:00:00.7162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jgD36+YFGaq3cZMDTFSlz5ZUnQAQ8mf+o8ymdnN3hirWrPvARFZEVl7hNcvwcu2l1qFnmGd4vqlr7uCeiK/YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7689
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMSwgMjAyMSwgYXQgNToxOSBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgSmFuIDMwLCAyMDIxIGF0IDA0OjExOjI1
UE0gLTA4MDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiArI2RlZmluZSB0bGJfc3RhcnRfcHRlcyh0
bGIpCQkJCQkJXA0KPj4gKwlkbyB7CQkJCQkJCQlcDQo+PiArCQlzdHJ1Y3QgbW11X2dhdGhlciAq
X3RsYiA9ICh0bGIpOwkJCVwNCj4+ICsJCQkJCQkJCQlcDQo+PiArCQlmbHVzaF90bGJfYmF0Y2hl
ZF9wZW5kaW5nKF90bGItPm1tKTsJCQlcDQo+PiArCX0gd2hpbGUgKDApDQo+PiArDQo+PiArc3Rh
dGljIGlubGluZSB2b2lkIHRsYl9lbmRfcHRlcyhzdHJ1Y3QgbW11X2dhdGhlciAqdGxiKSB7IH0N
Cj4gDQo+PiAJdGxiX2NoYW5nZV9wYWdlX3NpemUodGxiLCBQQUdFX1NJWkUpOw0KPj4gCW9yaWdf
cHRlID0gcHRlID0gcHRlX29mZnNldF9tYXBfbG9jayh2bWEtPnZtX21tLCBwbWQsIGFkZHIsICZw
dGwpOw0KPj4gLQlmbHVzaF90bGJfYmF0Y2hlZF9wZW5kaW5nKG1tKTsNCj4+ICsJdGxiX3N0YXJ0
X3B0ZXModGxiKTsNCj4+IAlhcmNoX2VudGVyX2xhenlfbW11X21vZGUoKTsNCj4+IAlmb3IgKDsg
YWRkciA8IGVuZDsgcHRlKyssIGFkZHIgKz0gUEFHRV9TSVpFKSB7DQo+PiAJCXB0ZW50ID0gKnB0
ZTsNCj4+IEBAIC00NjgsNiArNDY4LDcgQEAgc3RhdGljIGludCBtYWR2aXNlX2NvbGRfb3JfcGFn
ZW91dF9wdGVfcmFuZ2UocG1kX3QgKnBtZCwNCj4+IAl9DQo+PiANCj4+IAlhcmNoX2xlYXZlX2xh
enlfbW11X21vZGUoKTsNCj4+ICsJdGxiX2VuZF9wdGVzKHRsYik7DQo+PiAJcHRlX3VubWFwX3Vu
bG9jayhvcmlnX3B0ZSwgcHRsKTsNCj4+IAlpZiAocGFnZW91dCkNCj4+IAkJcmVjbGFpbV9wYWdl
cygmcGFnZV9saXN0KTsNCj4gDQo+IEkgZG9uJ3QgbGlrZSBob3cgeW91J3JlIGR1YmJsaW5nIHVw
IG9uIGFyY2hfKl9sYXp5X21tdV9tb2RlKCkuIEl0IHNlZW1zDQo+IHRvIG1lIHRob3NlIHNob3Vs
ZCBiZSBmb2xkZWQgaW50byB0bGJfe3N0YXJ0LGVuZH1fcHRlcygpLg0KPiANCj4gQWx0ZXJuYXRp
dmVseSwgdGhlIGV2ZW4gbW9yZSB3b3JrIGFwcHJvYWNoIHdvdWxkIGJlIHRvLCBhZGQgYW4gb3B0
aW9uYWwNCj4gQHRsYiBhcmd1bWVudCB0byBwdGVfb2Zmc2V0X21hcF9sb2NrKCkvcHRlX3VubWFw
X3VubG9jaygpIGFuZCBmcmllbmRzLg0KDQpOb3QgdG9vIGZ1bmQgb2YgdGhlIOKAnGV2ZW4gbW9y
ZSBhcHByb2FjaOKAnS4gSSBzdGlsbCBoYXZlIGRlYnRzIEkgbmVlZCB0bw0KcGF5IHRvIHRoZSBr
ZXJuZWwgY29tbXVuaXR5IG9uIG9sZCBwYXRjaGVzIHRoYXQgZGlkbuKAmXQgbWFrZSBpdCB0aHJv
dWdoLg0KDQpJIHdpbGwgZm9sZCBhcmNoXypfbGF6eV9tbXVfbW9kZSgpIGFzIHlvdSBzdWdnZXN0
ZWQuIEFkbWl0dGVkbHksIEkgZG8gbm90DQp1bmRlcnN0YW5kIHRoaXMgYXJjaF8qX2xhenlfbW11
X21vZGUoKSB2ZXJ5IHdlbGwgLSBJIHdvdWxkIGhhdmUgYXNzdW1lZA0KdGhleSB3b3VsZCBiZSBu
ZWVkZWQgb25seSB3aGVuIFBURXMgYXJlIGVzdGFibGlzaGVkLCBhbmQgaW4gb3RoZXIgY2FzZXMN
CnRoZSBhcmNoIGNvZGUgd2lsbCBob29rIGRpcmVjdGx5IHRvIHRoZSBUTEIgZmx1c2hpbmcgaW50
ZXJmYWNlLg0KDQpIb3dldmVyLCBiYXNlZCBvbiB0aGUgY29kZSwgaXQgc2VlbXMgdGhhdCBwb3dl
cnBjIGRvZXMgbm90IGV2ZW4gZmx1c2ggUFRFcw0KdGhhdCBhcmUgZXN0YWJsaXNoZWQgKG9ubHkg
cmVtb3ZlZC9kZW1vdGVkKS4gUHJvYmFibHkgSSBhbSBtaXNzaW5nDQpzb21ldGhpbmcuIEkgd2ls
bCBqdXN0IGJsaW5kbHkgZm9sZCBpdC4=
