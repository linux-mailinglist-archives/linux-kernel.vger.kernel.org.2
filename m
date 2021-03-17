Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EDA33FA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCQVt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:49:28 -0400
Received: from mail-eopbgr660061.outbound.protection.outlook.com ([40.107.66.61]:35616
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229460AbhCQVtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:49:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3YPh29nrDCSt57fhsM5zCVZ7yGxwnodI2ZWzUApGMBqaWOCI7+nfzstks32HHUBPrICFM2RC/q7ySi0E4TKVl/MYnZNMJDqz3DT+mFlPLmOHmN1ZO0Uf/xA3yi+Xr8i4LHTaA4T7niebSzKCdRzODqj2haW3XG1LHdeu+w69FIGGiChrl5aNotBRhbXNXiLexOrIXD0NW7oKU6c21mppSz8zszOAxQWMzZLTEc1yVfzfehAndlqkXsckYiERgTaO4/hUy5t9Dtf3HpyP4qBeD4yTuy7nyj13vXpzxCTezhDwVmjEjLVA2Q/sWC08yvKc+IZXJJ6D4ol7VAOIi2hCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7QE0VcVMgzUdyIRIIlZbt6cQHPfkTwt+EL1pSyL60E=;
 b=U5CyJvQ9WLYtruy+yMCQTSjTcEIEnbgQJ8CwkxtzJLxn6r9eKsRXgoDiu45IfaMLnwNKCPYWwbVeA1LiqZ5uuRWTTjyBUJ2kIC8e/miOta44oKkaeyOlDWXIwrRS2saGWIgfyPdTi3nuIeYIoOqxN8tArGqCPPQHwUFU5o2653dTsMHk6gDP6HbBtM3oOJjDGSVXJ9sAp2vyEk9OGzYmj+X6ibR6OArLj6HFOmKCwGkLLw1oSFsSf/zZ2GEZF7t/LoC2hoNMymOMXLZLCX3cSp7+0T+eYTrBFhm/n5A0BP0xYNK3HlUhLDrOs2QvZnzHzSqRTLc3/FNBhlFBn0HxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=stfx.ca; dmarc=pass action=none header.from=stfx.ca; dkim=pass
 header.d=stfx.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stfxca.onmicrosoft.com; s=selector2-stfxca-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7QE0VcVMgzUdyIRIIlZbt6cQHPfkTwt+EL1pSyL60E=;
 b=GHHKAqrSVz5Fh0+xResFefuGpJ/kxQEe3C4e/54ia0UqL2TjZ6MzL1Q5fHBwqk81ymNq4vkXT5CS1pvvxhiLLdsI2utJIm5qwoRU3VPP6eEEWm5gHd3Brtf7t5+xXN2yOq7+uhvCSZ3HOtMWh5qty4gddJ0YRM9mDFvNPkrBoF0=
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:17::19)
 by YT2PR01MB4254.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 21:49:10 +0000
Received: from YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3]) by YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c087:282b:4ebb:81b3%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 21:49:10 +0000
From:   "Zhou Ti (x2019cwm)" <x2019cwm@stfx.ca>
To:     Peter Zijlstra <peterz@infradead.org>,
        "g@hirez.programming.kicks-ass.net" 
        <g@hirez.programming.kicks-ass.net>
CC:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: =?big5?B?UmU6IKZezmA6IFtQQVRDSCAwMS8xMF0gdGljay9ub2h6OiBQcmV2ZW50IHRpY2tf?=
 =?big5?B?bm9oel9nZXRfc2xlZXBfbGVuZ3RoKCkgZnJvbSByZXR1cm5pbmcgbmVnYXRpdmUg?=
 =?big5?Q?value?=
Thread-Topic: =?big5?B?pl7OYDogW1BBVENIIDAxLzEwXSB0aWNrL25vaHo6IFByZXZlbnQgdGlja19ub2h6?=
 =?big5?B?X2dldF9zbGVlcF9sZW5ndGgoKSBmcm9tIHJldHVybmluZyBuZWdhdGl2ZSB2YWx1?=
 =?big5?Q?e?=
Thread-Index: AQHXFnNGiA2JtEhS2EiDRBkCbpwkF6qGkOKAgAAVHICAABBdgIAABRoAgAAI/QCAAAjRv4AAAXDTgAAGUACAAeviNA==
Date:   Wed, 17 Mar 2021 21:49:09 +0000
Message-ID: <YTBPR01MB32621AFB126B85EBA00FECC5C46A9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-2-frederic@kernel.org>
 <YFCiycIaViYCy3GH@hirez.programming.kicks-ass.net>
 <20210316133703.GC639918@lothringen>
 <YFDCOYstnDWPSWRU@hirez.programming.kicks-ass.net>
 <20210316145352.GE639918@lothringen>
 <ab753f1f-b03d-2a26-a552-b91f98708353@intel.com>
 <YTBPR01MB32623E6AC71C9F7670469A47C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>
 <YTBPR01MB3262D78448BD2FB3AD5EB4F9C46B9@YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM>,<YFDb8AzfajvlZ6iS@hirez.programming.kicks-ass.net>
In-Reply-To: <YFDb8AzfajvlZ6iS@hirez.programming.kicks-ass.net>
Accept-Language: en-CA, zh-CN, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=stfx.ca;
x-originating-ip: [141.109.104.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f942a40-dfd3-45db-bb50-08d8e98e7f24
x-ms-traffictypediagnostic: YT2PR01MB4254:
x-microsoft-antispam-prvs: <YT2PR01MB4254D87DAEE34FDED6168DCEC46A9@YT2PR01MB4254.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HDd9sFo6SjzPMnZWFnrndK2ibNnDPm9NB0tp68ZpJCe5urt/weMQenO2TRV/lCwKVcaC3/qQ04H6UjhVK/RoXy6Z1SiCEgYHE8intNBIfKO/DXPbhrhXiwHAw+FOS9meJy5gVPx42mHznKDMvHUotvEdDChA/NCviRBsOnGGOCY6EGvuammY78jzL+fdvxUKTYS8770QDUVYS08Nly6ZOoZuJguWXZbw71VNBvdYe4PkQk26DXF7btERMR1X4f9MSX5w01XPIhICvVSUonjAycEXT84gK/H4ZT7xwr6MXjuv9lmN++E4kOTojFU3zNRfu3Yv2EKUz4QPyc6n9V6Qdp1sIwVixT3BKYxPlxWmi2d/KwSo4GyN3blaX9xDHDFKXj2HZvO8IwHDBH41GdKBA7sVbOL5Nid+qCu4zpZGh/YkB+wxDLt+/k630X0Rs0DRV9CtgXKlHocIMpnkYO7h0cHbsL7XXw4Tkh1kFZq2WN3qiTuXguLXg+dGxYzuxTvL560/XZfYTNCP4uKQ3Op95VTS1xHMkvAUg3bCy9If+nXqUPrXOPH7VzkmsEMmzgGY2Lr9N6T3MMIILbT9bwPHtNkTrL3LpUXVqp2BiPQQPZ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(9686003)(26005)(86362001)(52536014)(186003)(7416002)(8936002)(7696005)(66946007)(4744005)(2906002)(55016002)(4326008)(316002)(110136005)(6506007)(66446008)(64756008)(5660300002)(71200400001)(786003)(66476007)(83380400001)(224303003)(478600001)(76116006)(66556008)(54906003)(33656002)(781001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?big5?B?RlpBbGt2aWhBSnZ2bFV6ZlE3RTEycm5TamRQRVBOd2dCQVo2N296QlpSZ1BMUmlF?=
 =?big5?B?cDNNckhhYkJXa21xZmJKOE1BWWRqOGtxZVdmZU9nVEF2ZWlrZndjZDg0UjVmWDlP?=
 =?big5?B?L2lSSUpSNVFyOFh1cHBBb3kwRGthQkhMN0hLME1aSE8yT211cEdwR0tISGNlQ3FE?=
 =?big5?B?eEwrL2wwY25xUnB0S3BsSjZ2WXVuWi9hUk13QVg5Q3hYMHB2WDZrNUtiZGQ2bUVu?=
 =?big5?B?YmZmTXlwOGdoNXg3NUFyNU9Idi9QUzNqUXB1M21ScEtoUjBXREg5cEE2Y3BYMk0z?=
 =?big5?B?M0JJb25MSEkrTXRNdVNyVGtNYXZYZ1RIc1R5UGtNekVob1BlYmZVd3ZTR3poMElr?=
 =?big5?B?ajhDUzVDcWVQVUc4bFNxYUxSc0VQN0pGOUJ1UWk2NGFFOEZkNWFPbEhCM3Jkcm51?=
 =?big5?B?aGxGWUxxOHRLM2dpWjB6Q042cEg5MWNzeXBWenJBZWN6cmliQjlFS25Nc1VEVDZZ?=
 =?big5?B?T0ZlT0xWb0NLNy9DWHhaUDJ5K1VmcW5QRmFnUkNZY1ZibXBxTW5ndHpYUktRTXdv?=
 =?big5?B?dnRvS1lIekJxSnVQVG9YcjI4bEN2SWpvZjRndy9KWXlMRy9EM1I4NVBObytuSnI4?=
 =?big5?B?TVdFSGx2eFRzMEZHYVZja2ZtRlVpa0IwSHdnRk1ZaXZGNzNNZitWeE1UMG14bXZh?=
 =?big5?B?Vjg0b3JJNWFRcHFxcW5pRk5VZHB4UHpUTkRqSi9VNkw0N2REQ201OXVDRzlaRS9B?=
 =?big5?B?SFpKcUVzUlF4OHA5NlZ5ZlUxV05XME84T1oxaEg0OWxyVlo3UUx2Ukx2amlTVmcv?=
 =?big5?B?QXFZaFdicFRZbmNxZjRITXFtZmFLZTdqQnViNVpVOVVnbml2NnQyQzUvRDJBWFJV?=
 =?big5?B?L1JVblNGdmx3VWJMUlgwdlI1Qm83V1Vpc2tpaEQyWXlJdXJQUHkrSkhWS3BOWFRP?=
 =?big5?B?VG9NV1lTUDRINyt5aUtzbC91Z3BmSzdnQkkzT05uZldsVE02SHlKNVdCK0F1Mlc0?=
 =?big5?B?alhjU2h4WGtUbHFJRlp1YTF4WkxZeFloSk9ITlBWMEo1Szh0YXdNdWg5cjBGbVdr?=
 =?big5?B?NVIrUHQzTjNpMjhkRTg1N3Z5ZkhSeG1kNk9nQmI2WHJZSjBQUmlDL1NjQzR1RGlW?=
 =?big5?B?c1lvNER3WVJLU2FsK1BaMVd5YmJqajdpclhpNXlRT3R0RXZwRkduRERDTllhYUlH?=
 =?big5?B?NmxOOWRrc0FaWERXcEtLVTZTbW5KOEJBV0YzUGpMbEEydFZyWW9JOXcrN2lIby9H?=
 =?big5?B?aFZhWGNHNDh2UlZTNnl1WGU5b1k0SXVjd2FlUFFudWg3SHptWHkwQXJMbEQrK0Nu?=
 =?big5?B?djJsNHJmeGVGZnpEM0JMUHNjNUZrQ1dHK0Rjd0hpZUloNmw3bERuWDVNdzkySVJL?=
 =?big5?B?SCthUklZcXBJcEpZZThGM3hLU0hISG5JY1VLZXZLRzk4aGdIaXdlTzdhdXVBZUtU?=
 =?big5?B?T0hiZ1Y5ajhwWStMOFVFWHExb0JkT21BcDl0Mk13Vm5MTDdZMWx1ZzhxNENaaUhF?=
 =?big5?B?L05DZ1l0KytGem04TmtrTWdCNCtHTVk4cFAyeUp5WjlCTHlDUW5MT1BVL0dyVTcv?=
 =?big5?B?dXo5L1VRR29sNXcvSXdCVHZnUHIwR2dFRmRnU1JUWDl4RlF1MnNUK3lqL1NmaWVn?=
 =?big5?B?QUhyRGsyZU9OVXh2bDBmM1BLcEFNRVlDUzcxSkNvZEprK3plK3F0NDZkYXc3ME5k?=
 =?big5?Q?ageIxfAzMZlUb/xziaWOfCTX91eWSQ9fq3YJGeVdGHfKhNmi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: stfx.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YTBPR01MB3262.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f942a40-dfd3-45db-bb50-08d8e98e7f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 21:49:09.9887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c46abc7-960b-4124-8950-1628b2b192f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdPC5jEUMH0IqynK7Ix8PZTEMj4MDcmo0PiDxNWo6hu3O+iaDrpBZlyQw/8VArA2eIHqLvGaPkGck8p1FgVUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB4254
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTWFyY2ggMTYsIDIwMjEgMTI6MjUsIFBldGVyIFppamxzdHJhIHdyb3RlOgo+T24gVHVlLCBN
YXIgMTYsIDIwMjEgYXQgMDQ6MDg6MDhQTSArMDAwMCwgWmhvdSBUaSAoeDIwMTljd20pIHdyb3Rl
Ogo+PiBCdXQgSSBkb24ndCB0aGluayBpdCdzIGEgZ29vZCBpZGVhIHRvIGhhbmRsZSB0aGlzIGlu
IGNhbGxlcnMsIGJlY2F1c2UKPj4gbG9naWNhbGx5IHRoZSBmdW5jdGlvbiBzaG91bGRuJ3QgcmV0
dXJuIG5lZ2F0aXZlIHZhbHVlcy4gUmV0dXJuaW5nIDAKPj4gZGlyZWN0bHkgd291bGQgYWxsb3cg
aWRsZSBnb3Zlcm5vcnMgdG8gZ2V0IGFub3RoZXIgY2hhbmNlIHRvIHNlbGVjdAo+PiBhZ2Fpbi4K
Cgo+QTogQmVjYXVzZSBpdCBtZXNzZXMgdXAgdGhlIG9yZGVyIGluIHdoaWNoIHBlb3BsZSBub3Jt
YWxseSByZWFkIHRleHQuCj5ROiBXaHkgaXMgdG9wLXBvc3Rpbmcgc3VjaCBhIGJhZCB0aGluZz8K
PkE6IFRvcC1wb3N0aW5nLgo+UTogV2hhdCBpcyB0aGUgbW9zdCBhbm5veWluZyB0aGluZyBpbiBl
LW1haWw/CgpTb3JyeSBhYm91dCBpdCwgSSBhbSBhIG5ld2JpZSwgSSB3b24ndCBkbyBpdCBhZ2Fp
bi4=
