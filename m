Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1969443B78A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhJZQuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:50:25 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:26081
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236433AbhJZQuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5fpDmfJfL1lj+aN2meyMQIDfJGnhGA5MYiH8XE3XQs5IpyoTf70nFB4fcCijXAphcSYHC6MwP1ueduqupjCr2+9WSy+rqFouYY8OXhnQKyhp9FNAkDHA5JmH7u+a7rXmSySoJkzcSl8w91W32Pa1Iv0z7aWT63AC43hy/94A4xJBE0ipVtsyZXBQBnDGuCkePXg9yI6zcAEGLNw2lSGWL44/53EdoVlllDjWE1QbFuHTku/SNKDppbb3evOZNhdpfd5XC4MS92yg9iAYmcxRFk93b1YxgGpaTYiXjZ7Idv46MWo1kBXeiv2/NL1V8ZoMHqexb80QOfri7WLG4Sx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JGk9cq+H3Pl1dHysFHhd3U//mUm4a9kitiEZOjgBe4=;
 b=f5uo4rTk2ReurG/6Z1+xyTkCFnOFGXdqPRzO2llbE4JH57OzjHl07albGalWUM8JhD0lHzggUEEZmb1myzCG511v7zE8YQQUrIYO4h2etj4oNDx3iuiC98dcoDVPs6W4zkGjSuxMFBhdT6Jtq+3wiA0FYbtf9Yq4zTI+6HmffZ2X6Bi2tLe96thYQFuLHD8PrA6E9uUxNcmQ2/cE2ZjDkPkM+V/VJ9a0Ir2MLrtCugVhvbM0gbRBX/BNBa9MUvTTJyNgXNhFPgu4ZKPY/DDrB9dA6+TAdudRBMZj6D+TnNzjEN0FatUoKiiW7/LwALBo+fedeRL12cHXQXsjE6C9uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JGk9cq+H3Pl1dHysFHhd3U//mUm4a9kitiEZOjgBe4=;
 b=y8pOlyGlETvXp5vBCEWJvvxAFds7+cLxLIHT7k8skeDv4MYZNnbKwSSoT/kUvyIBVdjH4rMRo5s19kuKmbMEtDA+MPQeey0kwN4msYRU7UFowlGuVW46JuePB/621H1XsqmPI/DFDniomzmhRqGcDsXrgrnBkeqNg2nZMToeG3w=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SJ0PR05MB7756.namprd05.prod.outlook.com (2603:10b6:a03:2e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.12; Tue, 26 Oct
 2021 16:47:56 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::fd9a:e92c:5d9e:9f6d]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::fd9a:e92c:5d9e:9f6d%9]) with mapi id 15.20.4649.014; Tue, 26 Oct 2021
 16:47:56 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/5] mm: avoid unnecessary flush on change_huge_pmd()
Thread-Topic: [PATCH v2 2/5] mm: avoid unnecessary flush on change_huge_pmd()
Thread-Index: AQHXyoPdr2060q99kU260UDK4yiy6KvlfWsA
Date:   Tue, 26 Oct 2021 16:47:56 +0000
Message-ID: <E38AEB97-DE1B-4C91-A959-132EC24812AE@vmware.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-3-namit@vmware.com>
 <c415820a-aebb-265c-7f47-e048ee429102@intel.com>
In-Reply-To: <c415820a-aebb-265c-7f47-e048ee429102@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5daa9b12-573f-4b70-31ad-08d998a05cb9
x-ms-traffictypediagnostic: SJ0PR05MB7756:
x-microsoft-antispam-prvs: <SJ0PR05MB775605AB53AF72D22D20F71BD0849@SJ0PR05MB7756.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZ0EHxm+jy26ofPnfHxL+sP/CBXqgnY2inBF90vkQIux1qDo/vxmapyTi44weM8epOGmAKz23Za6m6AHQNTJWxtLPuaV6hx59AtvCoYVraW5Hgnt3vxaCupb2dChT5HjoayaP+0jcegGk+u+IHiVrzlzXwKhK+NciOnAEYE6q8yGUqJlHFd+rFgkYm1eAJVfSrU9avgO1C4eWAC2HDMjBxBU1E8FLZro1dbYjdqIbiyuFc9C/tcVmgMJa6rl/WAVAvYo5s+rqIS3ESR49ZfLsWM3A48SBd6YiWXblYqfuiCBzYHOLV9H82W7VsESXJ+Q+NPZ4k/Y9wgjDihAh6F/n8BMYuuE1abVxveprx2AaPmHTL4nbMxho+xukCfx222SdKnBt6OKznyAwJCnJf7Y9RZ7K6WOviDYGmlbNaMimLaqdaYNxnhGP8VJGymTtDOfqqOcdtrSKCw2J6yVQ3MbyyVlPVMD1Ez+tkkz+kjPs6blGfwJwqqg1GFkoxSV9nABVCl7+cb4f7iJ3uev+szLn7Su0ceXhu3ulf/xltoX2dSzdqK5JUrQPNSjR4skkmMPe1LBQkbIh0hsl/ONNOXZwxeWuSTikliJ/E1D87e1TjGKKZ9TXMWmw76LiVVC+a6QSdN3V4zEI5LDbYvbAiXwxIDWZJViq8M4v+CCS4/wK7vPw2b/3PRT65bGZ/XViUMaXxayDbYY4bvgdVvXUe0qEEYvyAegcv4NaQgFa45TNNCqDHM43X+mfGEv3OV9ki7rMbwoJOBq1wg37ZsSxAXzxrblQgBo4lAsYJMraUxCvQogJQP643TaqaE0q9zdJ88QEnrN6axsinLOomVj//9g2SkVhrnWLI26YOR8lIC2NiI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(186003)(966005)(6486002)(36756003)(2906002)(7416002)(122000001)(8676002)(83380400001)(38070700005)(45080400002)(6916009)(508600001)(71200400001)(53546011)(6506007)(8936002)(76116006)(66946007)(2616005)(6512007)(86362001)(33656002)(54906003)(5660300002)(64756008)(66476007)(316002)(66446008)(66556008)(38100700002)(4326008)(14583001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm5jZGQrQk55Q3Fqamo5cm9xNm1GWTlOYlY2aTA0NUJ5ZjJmTzBGckpuZUtu?=
 =?utf-8?B?RmFnWDZsa1VUUjJRRC9RRWc4NzQvdEJhQkRKRmFSa3o1NjJrVWtoZHdRMkhm?=
 =?utf-8?B?dytLSkM1cTVPMlRFaTdyMjNVL2NOdElQS0NYOHJDYmVNVHVrRjU2cEJrdldC?=
 =?utf-8?B?bkptY05DSldIc01YbU9WbE1IUzNXOFZQZ25OR0NzS09CMk02Z0RLc1BxVnIz?=
 =?utf-8?B?cXVTdi9iN2d5QU4yT3hUdW00V3Q4Wk9EREdDeU4zWmprR1FhVW9MWGZMREZo?=
 =?utf-8?B?UE15bzRjRkpRY3ErOUtTODRDU1hRcHcwenZITytONlV2cVREdXMyVzgrZmk1?=
 =?utf-8?B?Uks5akk2UTArWnJyb2JCbUpLVmpRUmNOVStaVkpMTHhTOWowNWhmOHFOaExn?=
 =?utf-8?B?bzdWMHNvL3dOODcrVXJZUUhCNTNzZThyS0o3azFuMU5nR0E3RkxTM3kyelU5?=
 =?utf-8?B?b3JTVVpON2JUQ1pNL2w5MTVHSVNPUktYN1Y4bHNqUUhLNkRQU1o4cVJrRUFL?=
 =?utf-8?B?VXhHdXQ5dkl2ZkIzcDZvd05kZ0ZxSncrZm9uUUJOaUdYWHVKWG5xejFCRnNJ?=
 =?utf-8?B?K3VBcG1tY2lPajBMUllqK0Z5bXpOUXlpTkJJUWVvekxjZFVhVklkNWVReHdT?=
 =?utf-8?B?TXliZDZad3JuTXRKNHlvRHZoemQyMDhiejAvQlExQXk4NXN2WDBveDFhTU5O?=
 =?utf-8?B?eVpVSTdaS2o5UEtTd2pMQ3ZOZElYcFArUWZ1ZEZFMXM1azNtUVB3NFAyT2g3?=
 =?utf-8?B?Vk04aURKSU1oeTVyd2dVaFo3Z2kwb3RObEl2NWQwdG1JYVFMSHAxa3RobXpS?=
 =?utf-8?B?VndRM0oySzk3YlZzbFptL1ppM2pJNTBxZ0RvSTlsWnhFb1VSeHFrWG8xWklY?=
 =?utf-8?B?NGNvQ2R3MVRacERNb2lmZTdxajNaUDNiUFFVdVdiNXB1d1IvVkF6Y0QwUUsz?=
 =?utf-8?B?WSs5R1BFdnIydk8rVnE1S21tOG83WjB4bXVwOHBOUmxKTE9BRFBFWVB0VVFn?=
 =?utf-8?B?WDlpZk05cUZmK3ZEMUV4S1B4VzFHbGF5emZXeE1sOXlEc3BXYWV6Q2YzRXpB?=
 =?utf-8?B?RDJoNldDanlJSlhuaTZPeDE1MWpDL0I4OGpXV242aXRHVE9ncGpyTW0xL0RV?=
 =?utf-8?B?clM4TmdxWk5kY0xIVTR3SU9JSXVRV3N3ckJ3VmdmNjgzbWQ2L1RUYW9pSzFy?=
 =?utf-8?B?MVVhbzR4RFpBaEd1Tk1IYTZvY3drUS9pMnVwZlRYRXlIY0NuNDhncHJ3b3JB?=
 =?utf-8?B?b1dmOWd2dE9jMk0zdzBqMHdYZ3RNRHR3R0ZtSDFFWmZrSHJHMnpVZzh3WW5G?=
 =?utf-8?B?aVdoRFFqT05ZYXkzbjUxOWNHSDlFZVRmazNqWHB1QlE5VTBLd0E4aVdOSjZu?=
 =?utf-8?B?TC9YZG91TmpyQVdldkMrSnRrQ1BxR01xY1VzT29MNGdJd0JnelVGQjVtdWli?=
 =?utf-8?B?blFXbTZiUEc0NGhlNSsyMnZTc2hoYU11UkZJdGRFUWlwRUhBNGtVRVloSHhC?=
 =?utf-8?B?bWR2VlorMk5ldGhIZlRrOUlZR1BSZ3JtWjlUTXptc3dRRTVtZ2dlRmRidkdL?=
 =?utf-8?B?TFQrTTRzeGs1UnB3aSs3R05MOTNnSDhPNjlvNVZqSFo2eXFYQmhkeGxVLzEv?=
 =?utf-8?B?b05iMUlTMnN3Rll4bzE5dEdKL1lySTdLeTFSUFF6VTNDU0UreTNBOVU4RkR0?=
 =?utf-8?B?eWxRbEo0a1Nia3hYSThxWlRnUm5GTzZ1dkhHSklQaHBLZDNnd1p4MVFUVDFH?=
 =?utf-8?B?WmVpdGNYbXRTdXZpVElmVkl2UFdSYUxELzZ2QnlrVFpWdnF4c0Y0bEdTWHdM?=
 =?utf-8?B?ZlJQNnJVUlJXVmM4b0RKUDZxVkdldHhiMkxsNTBZNy9LZlZ1VktPRFYrK2JY?=
 =?utf-8?B?QzJCbHVlQ0lDdU1NNFRTbFphN1J0a3RCSE9EYVU0VHlSLzJGbEFFWi9hY1ds?=
 =?utf-8?B?RlhFcm1XZEs5SHFnNjBJeXBqS0hUUXo3TDZ5UnFGcmEzY2diVHJ6M3NDYk5C?=
 =?utf-8?B?dmRQdXIxTEdZcDVxbS8zdTZLM3I1eTZRNGxFY05BZGdwQmlBSjJudHZlZDNp?=
 =?utf-8?B?ckRSeVlidFBBMTQrZXNJSmFqV1gxZjE0eDlnZTJRWEhqb2VTRHJPcUt3RUdG?=
 =?utf-8?B?WW1yM3gyYXd5aHpGcmUxMWVMa3VSSFB6M0RSTytwODljM3I5RHNONnhUeWFh?=
 =?utf-8?Q?Aq9KpO9+sI5MpcdN1WoNVFg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AE6655C6AE2CB4BA840631E72234B80@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daa9b12-573f-4b70-31ad-08d998a05cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 16:47:56.6480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdUFQqyqtxJSAN8lvfMzgYpEvmQOvVngTIKG1Ia54CSvgnrId4NT4xyH0gZTnJjesmzVZ1hG0xBFiuPmwhb9uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7756
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDI2LCAyMDIxLCBhdCA5OjA2IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5z
ZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDEwLzIxLzIxIDU6MjEgQU0sIE5hZGF2IEFt
aXQgd3JvdGU6DQo+PiBUaGUgZmlyc3QgVExCIGZsdXNoIGlzIG9ubHkgbmVjZXNzYXJ5IHRvIHBy
ZXZlbnQgdGhlIGRpcnR5IGJpdCAoYW5kIHdpdGgNCj4+IGEgbGVzc2VyIGltcG9ydGFuY2UgdGhl
IGFjY2VzcyBiaXQpIGZyb20gY2hhbmdpbmcgd2hpbGUgdGhlIFBURSBpcw0KPj4gbW9kaWZpZWQu
IEhvd2V2ZXIsIHRoaXMgaXMgbm90IG5lY2Vzc2FyeSBhcyB0aGUgeDg2IENQVXMgc2V0IHRoZQ0K
Pj4gZGlydHktYml0IGF0b21pY2FsbHkgd2l0aCBhbiBhZGRpdGlvbmFsIGNoZWNrIHRoYXQgdGhl
IFBURSBpcyAoc3RpbGwpDQo+PiBwcmVzZW50LiBPbmUgY2F2ZWF0IGlzIEludGVsJ3MgS25pZ2h0
cyBMYW5kaW5nIHRoYXQgaGFzIGEgYnVnIGFuZCBkb2VzDQo+PiBub3QgZG8gc28uDQo+IA0KPiBG
aXJzdCwgZGlkIEkgbWlzcyB0aGUgY2hlY2sgaW4gdGhpcyBwYXRjaCBmb3IgWDg2X0JVR19QVEVf
TEVBSz8gIEkgZG9uJ3QNCj4gc2VlIGl0IGFueXdoZXJlLg0KDQpObywgaXQgaXMgbWUgd2hvIG1p
c3NlZCBpdC4gSXQgc2hvdWxkIGhhdmUgYmVlbiBpbiBwbWRwX2ludmFsaWRhdGVfYWQoKToNCg0K
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3BndGFibGUuYyBiL2FyY2gveDg2L21tL3BndGFibGUu
Yw0KaW5kZXggMzQ4MWIzNWNiNGVjLi5mMTRmNjRjYzE3YjUgMTAwNjQ0DQotLS0gYS9hcmNoL3g4
Ni9tbS9wZ3RhYmxlLmMNCisrKyBiL2FyY2gveDg2L21tL3BndGFibGUuYw0KQEAgLTc4MCw2ICs3
ODAsMzAgQEAgaW50IHBtZF9jbGVhcl9odWdlKHBtZF90ICpwbWQpDQogCXJldHVybiAwOw0KIH0N
CiANCisvKg0KKyAqIHBtZHBfaW52YWxpZGF0ZV9hZCgpIC0gcHJldmVudHMgdGhlIGFjY2VzcyBh
bmQgZGlydHkgYml0cyBmcm9tIGJlaW5nIGZ1cnRoZXINCisgKiB1cGRhdGVkIGJ5IHRoZSBDUFUu
DQorICoNCisgKiBSZXR1cm5zIHRoZSBvcmlnaW5hbCBQVEUuDQorICoNCisgKiBEdXJpbmcgYW4g
YWNjZXNzIHRvIGEgcGFnZSwgeDg2IENQVXMgc2V0IHRoZSBkaXJ0eSBhbmQgYWNjZXNzIGJpdCBh
dG9taWNhbGx5DQorICogd2l0aCBhbiBhZGRpdGlvbmFsIGNoZWNrIG9mIHRoZSBwcmVzZW50LWJp
dC4gVGhlcmVmb3JlLCBpdCBpcyBwb3NzaWJsZSB0bw0KKyAqIGF2b2lkIHRoZSBUTEIgZmx1c2gg
aWYgd2UgY2hhbmdlIHRoZSBQVEUgYXRvbWljYWxseSwgYXMgcG1kcF9lc3RhYmxpc2ggZG9lcy4N
CisgKg0KKyAqIFdlIGRvIG5vdCBtYWtlIHRoaXMgb3B0aW1pemF0aW9uIG9uIGNlcnRhaW4gQ1BV
cyB0aGF0IGhhcyBhIGJ1ZyB0aGF0IHZpb2xhdGVzDQorICogdGhpcyBiZWhhdmlvciAoc3BlY2lm
aWNhbGx5IEtuaWdodHMgTGFuZGluZykuDQorICovDQorcG1kX3QgcG1kcF9pbnZhbGlkYXRlX2Fk
KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsDQorCQkJ
IHBtZF90ICpwbWRwKQ0KK3sNCisJcG1kX3Qgb2xkID0gcG1kcF9lc3RhYmxpc2godm1hLCBhZGRy
ZXNzLCBwbWRwLCBwbWRfbWtpbnZhbGlkKCpwbWRwKSk7DQorDQorCWlmIChjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9CVUdfUFRFX0xFQUspKQ0KKwkJZmx1c2hfcG1kX3RsYl9yYW5nZSh2bWEsIGFk
ZHJlc3MsIGFkZHJlc3MgKyBIUEFHRV9QTURfU0laRSk7DQorCXJldHVybiBvbGQ7DQorfQ0KDQo+
IA0KPj4gLQkgKiBwbWRwX2ludmFsaWRhdGUoKSBpcyByZXF1aXJlZCB0byBtYWtlIHN1cmUgd2Ug
ZG9uJ3QgbWlzcw0KPj4gLQkgKiBkaXJ0eS95b3VuZyBmbGFncyBzZXQgYnkgaGFyZHdhcmUuDQo+
IA0KPiBUaGlzIGdvdCBtZSB0aGlua2luZy4uLiAgSW4gaGVyZToNCj4gDQo+PiBodHRwczovL25h
bTA0LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZs
b3JlLmtlcm5lbC5vcmclMkZsa21sJTJGMjAxNjA3MDgwMDE5MDkuRkIyNDQzRTIlNDB2aWdnby5q
Zi5pbnRlbC5jb20lMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q25hbWl0JTQwdm13YXJlLmNvbSU3Q2Y2
YTJhNjllZWMwOTRiMTI2MzgxMDhkOTk4OWFmYjYwJTdDYjM5MTM4Y2EzY2VlNGI0YWE0ZDZjZDgz
ZDlkZDYyZjAlN0MwJTdDMCU3QzYzNzcwODYxMzczNTc3MjIxMyU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1vOGZZYm04QktIdld4WUM5YU81ZTNNRkxr
YU9uUXh2RE15JTJCRW5ZeHo1NkklM0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+IEkgd3JvdGU6DQo+
IA0KPj4gVGhlc2UgYml0cyBhcmUgdHJ1bHkgInN0cmF5Ii4gIEluIHRoZSBjYXNlIG9mIHRoZSBE
aXJ0eSBiaXQsIHRoZQ0KPj4gdGhyZWFkIGFzc29jaWF0ZWQgd2l0aCB0aGUgc3RyYXkgc2V0IHdh
cyAqbm90KiBhbGxvd2VkIHRvIHdyaXRlIHRvDQo+PiB0aGUgcGFnZS4gIFRoaXMgbWVhbnMgdGhh
dCB3ZSBkbyBub3QgaGF2ZSB0byBsYXVuZGVyIHRoZSBiaXQocyk7IHdlDQo+PiBjYW4gc2ltcGx5
IGlnbm9yZSB0aGVtLg0KPiANCj4gSXMgdGhlIGdvYWwgb2YgeW91ciBwcm9wb3NlZCBwYXRjaCBo
ZXJlIHRvIGVuc3VyZSB0aGF0IHRoZSBkaXJ0eSBiaXQgaXMNCj4gbm90IHNldCBhdCAqYWxsKj8g
IE9yLCBpcyBpdCB0byBlbnN1cmUgdGhhdCBhIGRpcnR5IGJpdCB3aGljaCB3ZSBuZWVkIHRvDQo+
ICpsYXVuZGVyKiBpcyBuZXZlciBzZXQ/DQoNCkF0ICphbGwqLg0KDQpFcnLigKYgSSByZW1lbWJl
cmVkIGZyb20gb3VyIHByZXZpb3VzIGRpc2N1c3Npb25zIHRoYXQgdGhlIGRpcnR5IGJpdCBjYW5u
b3QNCmJlIHNldCBvbmNlIHRoZSBSL1cgYml0IGlzIGNsZWFyZWQgYXRvbWljYWxseS4gQnV0IGdv
aW5nIGJhY2sgdG8gdGhlIFNETSwNCkkgc2VlIHRoZSAocmVsYXRpdmVseSBuZXc/KSBub3RlOg0K
DQoiSWYgc29mdHdhcmUgb24gb25lIGxvZ2ljYWwgcHJvY2Vzc29yIHdyaXRlcyB0byBhIHBhZ2Ug
d2hpbGUgc29mdHdhcmUgb24NCiBhbm90aGVyIGxvZ2ljYWwgcHJvY2Vzc29yIGNvbmN1cnJlbnRs
eSBjbGVhcnMgdGhlIFIvVyBmbGFnIGluIHRoZQ0KIHBhZ2luZy1zdHJ1Y3R1cmUgZW50cnkgdGhh
dCBtYXBzIHRoZSBwYWdlLCBleGVjdXRpb24gb24gc29tZSBwcm9jZXNzb3JzIG1heQ0KIHJlc3Vs
dCBpbiB0aGUgZW50cnnigJlzIGRpcnR5IGZsYWcgYmVpbmcgc2V0IChkdWUgdG8gdGhlIHdyaXRl
IG9uIHRoZSBmaXJzdA0KIGxvZ2ljYWwgcHJvY2Vzc29yKSBhbmQgdGhlIGVudHJ54oCZcyBSL1cg
ZmxhZyBiZWluZyBjbGVhciAoZHVlIHRvIHRoZSB1cGRhdGUNCiB0byB0aGUgZW50cnkgb24gdGhl
IHNlY29uZCBsb2dpY2FsIHByb2Nlc3NvcikuIFRoaXMgd2lsbCBuZXZlciBvY2N1ciBvbiBhDQog
cHJvY2Vzc29yIHRoYXQgc3VwcG9ydHMgY29udHJvbC1mbG93IGVuZm9yY2VtZW50IHRlY2hub2xv
Z3kgKENFVCnigJ0NCg0KU28gSSBndWVzcyB0aGF0IHRoaXMgb3B0aW1pemF0aW9uIGNhbiBvbmx5
IGJlIGVuYWJsZWQgd2hlbiBDRVQgaXMgZW5hYmxlZC4NCg0KOigNCg0KDQo=
