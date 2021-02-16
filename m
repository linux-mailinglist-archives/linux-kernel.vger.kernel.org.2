Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D0231D0A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhBPTFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:05:08 -0500
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:17984
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230500AbhBPTFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:05:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STRuO0Pkt4VlmjRIo4ZeNKtBD28Lukxm4bPxJrifHqRwdKxz79C7ARxfEiD4sA3W8tIBWNEIsDdh7vurtid/vojo7wo4nuoMotB+5h+J5oOiyWc8b2ISTQqn0bBkOu2Rs5JcvpJnFpV28TXhazVrZ8Y4TZf2C6Fj4FFbbKCGTNsdLoubyH8Ykh4h4mICUfEMvSSWNUd+aDhYslYFMkTGh2/+kBwXmvDXq1pga/5AahMdrY1f5GHwAsosZnZGTjT0yhBMfgSzl/LhhUrl9aYlznC3Eh1/8dULhMP2m2AQdXj+nhdNgecmBpWPJPGYFrGWGCci5O4UiH1GTKL4iWZ5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbDJ0PpykFJyilyL1AgyKVgRhSXzeiUd4+VgHbCsy90=;
 b=KESWfnxiqitCAnR+xebjZNBHd5rKex7XwFoJ1pAQfafrmbAEoeaE6UaOv9AfrtiHKaY9BelX0iHkVK7f9wpar19RS+pvufJ6r/viU56lrvRKTqjrONP5SdJWsn0cOZAkXZxWQ/Vr5wKV0bpGghmcgbrI5wergI8ksh+OfU8Y4l7Y8X+1ki7+e23iy9z+1K2fMZETZCSo9Lo7wYxqIHyeB+5FATIiV+MgoQlb+Kb5+oKXizvxyd3EXbrXoQfXF2oreuTJ7G7UaLHXM00pMVRq1m0S52z3mcZbQcOXapIQVS3U61aUn3aZ1voKAlynqPugPaVcLmW+DD847VcCEOHQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbDJ0PpykFJyilyL1AgyKVgRhSXzeiUd4+VgHbCsy90=;
 b=NdNJ7RCC+OPJstAzHS5Kr80p2Jiyc7uGyTTbYTaU30uGgapaV/SHimn3DwlSc/dNgRT9VS7ICG/UPggUEosw6u0pSjDxiyGpEQp7ruFcwRV8XkgHHOqd41N/8i8e4PeWWL5kBHKykEmIVKZB+XEDkfZYV8JE8NihHQQj5zSiNcs=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB6150.namprd05.prod.outlook.com (2603:10b6:a03:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12; Tue, 16 Feb
 2021 19:04:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3846.039; Tue, 16 Feb 2021
 19:04:12 +0000
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
Thread-Index: AQHXBIFqKsC+lRA3wUC6VAD48B2JFqpbIOyAgAAB54CAAAEugA==
Date:   Tue, 16 Feb 2021 19:04:12 +0000
Message-ID: <83371B79-02DE-4183-BDD7-E5DDAC8EAA83@vmware.com>
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
x-ms-office365-filtering-correlation-id: 10729acc-6369-4398-0562-08d8d2ada58e
x-ms-traffictypediagnostic: BYAPR05MB6150:
x-microsoft-antispam-prvs: <BYAPR05MB615006F07B6A362A4C4CCD7BD0879@BYAPR05MB6150.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZYzN7mfim7CRogQ7BBMWLyHgn9mVb2YkcQE1sb04BPOQDwnPJw9owj31OUOwy/JYgldJ3mL8r1CR6VV9Hsb2/HZmF/hHUiT1JzoTB/aBW8TeqvZHI94kLTjebnG9tRc8bwtyq2P3eRRMI5fzkiFZYIarPMGBUBhSzQKOwEkwnsWa7kLiduZ6+kBJiAAIraMhr9QaIIIthGSvS2WhuzZA2IItIqtUPGBTSoE1ziyhkai9GMyrK7mKRqIhH9Ip98MODBeWtsX/e166CaEla08345bVorPddEtuQnmSW4BNEpYoOLLCxdPW1PePzNx1kNjKiPm1+h/CJaO3Sx/gsMLK6h0nTShatkReWLhy+eqDMXiYMpIm9QURtiWue0t1cu3neqmG0YszBf8R84+7xymuqUTvh4Fj0KqoDND6ciqIx5LYfnGER1YwVbhhZH0Fiu/ua8vYrR5EoHkcGT1Dk7eE1cAsqyVXGSE3168ldv68UD86bP8kWkgnrLCZVie/cOsgfE8vRg7eoxZb4yJPgyWGjQM/eTEeWsn3dM8BZ79EGPreM/ZX+9h7ihjE2XMAVAKVs8H64I7YoW8q5fVms4aGXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(2906002)(5660300002)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(2616005)(4744005)(54906003)(71200400001)(33656002)(36756003)(83380400001)(8936002)(6512007)(6486002)(86362001)(6916009)(316002)(4326008)(53546011)(478600001)(186003)(6506007)(26005)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QkFHVGZWd05seVF5amU1QXNUQWZuTHJSQmpXOFlSdEVBdnd3VGxTVGVUQ2Zm?=
 =?utf-8?B?V2V2L3NNM2IyZFFwblpId2ZkNS9xWStjaytkNWFIWlhrV0FjUTNKaG9BZ2NR?=
 =?utf-8?B?YTdCMENDVnpaVVVjTTYva1FTN1ZneVJuV0hWb2ZDaldJVGV1NEVPRGNkMVUw?=
 =?utf-8?B?YVJ1OGxXY1VVOFdqcEhJdlY1Ry9mc1huZnhJQmxNSlozVU44NjNSK01OeDBr?=
 =?utf-8?B?R2o1S1pvQkR4eERvWG5LNUtVM1NzV3g3dm9NZkRSV1NuSjY0ZGlxOUdJSVFF?=
 =?utf-8?B?Y2ZuRS9QaStad2srTmtid25kTFNsbFlGWVhNZXFmbU5uVWh0RURxYnRPUWlq?=
 =?utf-8?B?c1V4NjZLbWxLeEhNbjBtRlJqUVdBU1NNb0xuL25jVXEzeVhLUlZmaUJqMUpr?=
 =?utf-8?B?c1BjaHdNYjlyOWVVWFZzUy9TUGcwdlljMThQbWUrS1g2d3N5MEl5aFlYa3do?=
 =?utf-8?B?N2ZLZDJsckF1UStNbGRzUTZtbWQ2VU5zYzF3azlKQ3Uvb21qYjhKQjlCdjJ6?=
 =?utf-8?B?dUF6TVZDa3p2ZThkUHRkRGVqUjcyY2JOWTdHZGFPRG84OUtTenBSajdaR2RY?=
 =?utf-8?B?ZGgvTkJkWFBuMlZ6NU5wb21uUFpWWlFsSnZiMXh4VkNheS9IRWhXMlRWSDlK?=
 =?utf-8?B?SC9Ta0FUSVowU3dXNnlodXBmZGl1c2RReXBlVTVnanQ5N1V5bGRDcjUyNXFV?=
 =?utf-8?B?TjFQSGU1NmN5ZjRHQzkxc2JpVk94RUJBdzljRmVhekRUaGpOMXlPK3QzRmVi?=
 =?utf-8?B?Nm5MWnlVRnRIMmpRaEF3ajRUVzZORm5mc0JKTGVsVTF4MUxKNStFVGZDZXZt?=
 =?utf-8?B?VTJLSFR0UU9SMzI1MFBuc1MzcjNNM0dJOFRualE4SHRqZ1ZDdkRzbUhBM1Zh?=
 =?utf-8?B?bHFMdHpsUFZndXhoUUp5K0Z5S2hBNnRxbVpOSGZRMGlia1d4K2NXMFhCK3VP?=
 =?utf-8?B?SEx0TXM1RlBXeG5SYlYrSHJyOXd2UDVpTnV0anZvaW56WE4xNjZLOWtFeXhF?=
 =?utf-8?B?MUtaaFM3blVOTmVtSTR1TytwWnVaZ3ZyRlBsUVZ4K0xRaUljNVFTbXZLclNi?=
 =?utf-8?B?ODZKc3MxLytVb2l3OWJFKzUwT2JpMmJVMVYyREtadllJT3crQ3pWM1VJeVlG?=
 =?utf-8?B?c0xzVUlhRG1GenhDNGVYdm1VKzhKQWhMT1QybjNLRXRudnh5QkcxWEVyeS9D?=
 =?utf-8?B?aWxVYTF5SDZmM0ZSSG5LWW1xSGc1VUpmOEF2cTRrcndvbTFvUmV2ZDBPdjhk?=
 =?utf-8?B?ajQrUXZiUXgxOUkrRStQbmpNbU5LQXloU0xncTJTTlpLOTFVOURsejA1cnJl?=
 =?utf-8?B?aDA1eXVrME1Tajkydi9Ra3J1NS9Tdk1OOGJtRy9oT1hGYUNXU2hhZGo3ZFBO?=
 =?utf-8?B?WW53dVk4cnAzVy9reGRlejBoOFpqY1E0dlJ5N3BhZkJoY0llbVVOekpLeUlY?=
 =?utf-8?B?RjV5QW5wbHNzdlZ4SnRuM09lbGh6eXhQOXF3N0VpdkllLzJPZmNteG5rRktZ?=
 =?utf-8?B?elNBV2F2eWdYbE5sc3dMa3hnc1l0bSt0YjhkTHpRd1luMTYyM2N6TzhtRzB4?=
 =?utf-8?B?UFFJRytjaktDN3dLM3VlaW8vSy9pbzN2aEZTZVNPRE1kQm1mTFlDVytDRnJU?=
 =?utf-8?B?MFdqeGl5YXQrdWE2VGw4M3JkaGZpNnhPb3ZibkFJSEt6QU4ydktrM1FqMWtB?=
 =?utf-8?B?YVc0a2FtZTA0K2d2VEZMenNRQXdLYXVWOXFwL1NxclIrd1Y5N2lUSXVQV2Yv?=
 =?utf-8?Q?oJMciZXkrQFxSYLQrxohVkvfM84FmpFDi6zl7Xd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9D44DB50569044D83FB098A975BE7E8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10729acc-6369-4398-0562-08d8d2ada58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 19:04:12.0685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2r0m87NH51VkFxjWfpfrfUUgejoh1+m7i86X6snsALLcl/MF5kaxEvCZl32TzaGHnFPOcQaEz9wgAConOd2z+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6150
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
Cj4gDQo+IFllYWgsIG1lIG5laXRoZXIuIEJpdCBvZiBhIG15c3Rlcnkgc28gZmFyLg0KDQpJ4oCZ
bGwgdHJ5IHRvIHNlZSB3aGV0aGVyIEkgY2FuIGZpZ3VyZSBvdXQgYWJvdXQgaXQuIFBlcmhhcHMg
dGhlcmUgaXMNCnNvbWV3aGVyZSBhbiBhc3N1bXB0aW9uIG9mIG9yZGVyaW5nIGJldHdlZW4gdGhl
IGxvY2FsIGFuZCByZW1vdGUgZnVuY3Rpb24NCmludm9jYXRpb25zLg0KDQpSZWdhcmRsZXNzLCB3
b3VsZCB5b3Ugd2FudCBtZSB0byBoYXZlIG9uX2VhY2hfY3B1KCkgYXMgaW5saW5lIG9yIHRvIGtl
ZXAgaXQNCmluIHNtcC5jPw==
