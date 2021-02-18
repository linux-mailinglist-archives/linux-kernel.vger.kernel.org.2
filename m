Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1840D31E842
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBRJfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:35:44 -0500
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com ([40.107.223.81]:1249
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230400AbhBRIZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:25:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWRhrNx1BBWk8A7pjtNVZcJ7Vxy2yYvn2IK6SpRmgqa75FTjfva8y792CCrd38cFQFDBx/YCL8+Q72k0Lemc8sXXdiimefcOoXLg0Sm9pc7sXjkMbnJgN2TFIZrvA+ZLmU+Mr/5Rw9a/m2sDahpbdpZ39V/VSBgSL0jXW7AerErmCI+L195+TzxOkWpEaI3oz1iCFYaiRM2rG+qr0/5L/tGHoUzRHUuycg2VkBBtjcL7f84AJA8OX3ldEd0G7yEP1RESB7fY5I19qs75lYif/qREr56n62F5qoosJqfGanLYGwIvJXxQHimvi73cv8AjSp7e4uJ3VZGLyQtPxqaZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZk1E2frr46d2lzK2hkOAF6/IxCh2i6TOddY4EpHRQU=;
 b=Nhd954VhVDRsCfJvUO4gtmd4YbbL84zBTSWu4c8DkpNsMZylSNu+kc2PuG8H54aIovSNOG4hT5ly9YWE+UPkq9jQlc8EQy+T+UMnDaRTMSr+jZOG2zWrvY7WViWKC8dBhxi0fA64MEaR/6fRW7S57eO1U4GkTvwDgWwAmwNrG5+lG2dIM207/RKGyt6tujGwdSv7P7/Ma5LbbXjqgKuvZcqfflk7476haFLZMvDiUPj9AwhmKD84xtgvgDY/J5jA2EnAY6vhiSmFPDwDDOZCFXi1rszvTjyL6KA3pzb9loQJGp9lsiV5Tdnci9GE7SnLKuyEzX8F2787zoi+skZ2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZk1E2frr46d2lzK2hkOAF6/IxCh2i6TOddY4EpHRQU=;
 b=w4F3e8cYX450u2gF0Kfd0pyA/sPQnNPpoY8TtMIvHO+KySNdPnwFMl2SNlDy2J84c3RdPGK0wCRvSbxM4DlkUZb1g9rjF4/gkJXc07rd9eg2DnWJhL4l/I5b2Pzl6vRNE+hV0eNvG1+2em6Ls09Z8/wQL6dUxyEkIalcRiEvZaE=
Received: from (2603:10b6:a03:4a::18) by
 BYAPR05MB4774.namprd05.prod.outlook.com (2603:10b6:a03:52::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.10; Thu, 18 Feb 2021 08:24:24 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3846.039; Thu, 18 Feb 2021
 08:24:23 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 3/8] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Thread-Topic: [PATCH v5 3/8] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Thread-Index: AQHXBc5hRSxY6/ejY0q9imwfUQNXWapdk0+A
Date:   Thu, 18 Feb 2021 08:24:23 +0000
Message-ID: <29878BDA-1B02-4EAB-A7D3-5FEFCC73B2BE@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-4-namit@vmware.com>
 <20210218081624.GA337128@infradead.org>
In-Reply-To: <20210218081624.GA337128@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6dbe808-4673-42fc-c3f2-08d8d3e69938
x-ms-traffictypediagnostic: BYAPR05MB4774:
x-microsoft-antispam-prvs: <BYAPR05MB4774E9BE3DE93EC19F43353FD0859@BYAPR05MB4774.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2zi7bz7VtNC6nBFC41oWzCt7SaxYOYWAUPeed2NIH5wpyKnuDN94+DjK9A4XTmNtA+dBWpAPcfbwa4csIRpDLIfDnIu3MyBXCm4yt1mC14OdOR726wl5UkKjPu1W7J7AFwOW+IumOqlJ3y0ejtBAGvTZBqi7M8hmUNsxNRJnuL9ZSCzn3o5PX7mGLLbuKEbiiKuDV+xC4kHs3wteaLMY5VhGcaIQzn+/fy0vJ4/Jw7q6c/74K0BBZ9ggmFNQJLm1yj78HxNKZWEboN7WycTdIb0Z4i/9yVcd2s+zYDXTJoJ41tilcjyRI7kRRcdo7PRpTkYEFN6TLMQSBNxE2xtf0wQkEAAkZI89/89Y2OXOzuExeag7c5XteL56+gGFQB14vmYksznPE1hUCTWI3SzxJVthjP76lITL86rmfxNU0m8x9e683NrQrtgSn9elj0IWMAbEsjsGZ0nVzyXo5ZZuS86ECIPu/WyTnQTjBo3mDp+QUDZZqi+wSbCBKVCvhPTfGhqUSkxC0yTG7FlrrIXln7IIaafR90iHbvOoaxrqGYptLmzzU0pOjQ+gQAW0pbO/VQYeVQw4UUGPIgULxYSww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(26005)(33656002)(83380400001)(66946007)(64756008)(53546011)(6506007)(54906003)(6916009)(71200400001)(478600001)(86362001)(4326008)(66446008)(66556008)(8936002)(2906002)(76116006)(36756003)(186003)(316002)(2616005)(6486002)(5660300002)(8676002)(6512007)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YmlTMkEwTWFiemVjQjVSWjdOVDdrVDg0UFhxaThLSG9CZUpvL0cyUjcwaHZW?=
 =?utf-8?B?QlVvcUhBTCtMYWxZT08wZ3FZVTZ4dE9LYVhRdmdKL1ZSaDZIZWdhM1UxQXNQ?=
 =?utf-8?B?eG5URDBHdGIySWJlbUFUbUI0NnBZZDRIUzQzTmFoaWx1QTdFWTdHcnBXRWM1?=
 =?utf-8?B?YzhJMlVDRGdrQVh3NmZBbFczOFp6VHVpQXM0aFdNdWxIY0JDcEdlNktXY1FR?=
 =?utf-8?B?Y3R3NkhJZEd1cy84UHp2NXBLM3huWFlWYkJmTG8wODFKaXRENnh3cEVGRWVl?=
 =?utf-8?B?TjJ3SXBKU2dVVUNGYm5nTU52NGVRWHdHOWlwTmMrbjlEbFBRL0lOL3NwTGJS?=
 =?utf-8?B?UENZNEMyeEF6bi9lMkJVMDcrdmtiRldQbmdlQkRGTm1ITE5TekgzRXpWOGwr?=
 =?utf-8?B?NjRKcGdVdXJWQVAyWlIwa29NQTE2VUdjVHN1T0t4V1pPcW5GRExXdUw1bENR?=
 =?utf-8?B?VXhQYWxwU3JMQk15WlBaZnh3RWFlQUFYQjE1SExMdUhnaU15NXkzUXBwQVVh?=
 =?utf-8?B?VTlReHYyTWVKbHg4djNUM3ZzN1RLUWo2WEFOUi9CNVlrM3U5UEhVMHRhRHBs?=
 =?utf-8?B?M2FOLzZZVTBZbkRGMmpId2owaEc1NldqOUJaeGszQnJZUjNGR0dEUmRPMCtE?=
 =?utf-8?B?MEhwRTVyckdEVVlTL0NzUWRBaHFqeEJvcmIzcTIvWW5TbWlLQXlkcmtNN0Vq?=
 =?utf-8?B?RDRCQ3ozTE84M1I3ZTEzdVkvcTZjWXNKS0FRd3dQU3F6bklqbTlFalRMMC9U?=
 =?utf-8?B?dHh0RVlXY2pKUWlVS2xnM3l5UndHVUlldFluejRZYkJnNVgwMGE5Nml2L21r?=
 =?utf-8?B?ejd0aHoreEFnSkVNbzlrSU00c1NLOWZ1bStZVU14cUU3SGxINzl5V3dncDQw?=
 =?utf-8?B?NEw2TlJIbzFLRUlqWXIwaEpZd1hJOVFPSzJXZkpwV0lnZG9EQ3hkQzh4UUNF?=
 =?utf-8?B?blBHNmh1aGtVNnF0QVlBUVM4OXU2cFBJUHpudGRjUHdJN2JiVVArdVk2L0Fk?=
 =?utf-8?B?M1RaYnpNbHBoTUNjdWZqTmYweWljam51OTBhU3RMTXBCUlIva1kyZWt1VzFr?=
 =?utf-8?B?NXg1L2ZEY1BSeGYzT0RRRURHRlB2TzQwMC91dUFXbzJrNzN5ckVYak1kUkR0?=
 =?utf-8?B?bVk3djJrMENQNGpVKzZ5N0tvbGUvNDJ0VXU3b29CekE3RlhQQjQvS0YyYjlS?=
 =?utf-8?B?OWRQOVdYVVdmSXV3OVZkaE9RcU5kZm1OWjhIYjlVak5meEJGYW1NM01SeklN?=
 =?utf-8?B?MTNVWU1EbzJnQkQxTmw5OVVUUkRIWTIvL1Avbms4RTg2MkgvdWljTytIelhn?=
 =?utf-8?B?VWZaN2dXRVNDaTZGSFNHY3dLdnQ4K3V0OUFSbHpnbVpuWVZuYXZ1SWNWa3Yv?=
 =?utf-8?B?SUd0UXRwbmE2T0tqRCtwdU5BdjhTTTZJaEZ3SkxoRmlIcVMvY2VzTVQ0ZVB0?=
 =?utf-8?B?ZDR3dVN3NEI2RkFtL2o0SitDeCthQzZtRDdlVldOZ3ZxRVltR09KNmdrWS9K?=
 =?utf-8?B?dVIzUGRaengwN2RrRi95bFRZSmlES1V5M0djZlZLV3ZwNGRDaGxPeldrWG41?=
 =?utf-8?B?aXlJWXpnVkZYdUE4U1p5WDA2VWE0WThZUllpUmI3SjJ6bjVWeC9CRjd6WThu?=
 =?utf-8?B?QlUxL0prWEdnaVp6TDUxQkFOQWZ5bm1QaHdEeVdhbGFPMmtvWXNwc0RoeWp4?=
 =?utf-8?B?VS9kS3U3dm5QQysvR1R0MFdGekMxM21XMTZ5bGwvbUpnMDk3bGVtamlKVHB1?=
 =?utf-8?Q?74ZcgFc7PbhJhWs0JZm88UPFk9Z1VHzCmjal3Kl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A2E98222F8F4D47B9D9CC4CF842C0DD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dbe808-4673-42fc-c3f2-08d8d3e69938
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 08:24:23.7991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljmpZoVUCek0AsWhbj8AG6jcW4JVaUa3adu/QJn0g0j0qO7A/EWzkGn/IsKK6996wMRvbmneXfxFTlxGWYBG8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4774
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMTgsIDIwMjEsIGF0IDEyOjE2IEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMDI6MTY6
NDhQTSAtMDgwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+ICsJCS8qDQo+PiArCQkgKiBBbHRob3Vn
aCB3ZSBjb3VsZCBoYXZlIHVzZWQgb25fZWFjaF9jcHVfY29uZF9tYXNrKCksDQo+PiArCQkgKiBv
cGVuLWNvZGluZyBpdCBoYXMgcGVyZm9ybWFuY2UgYWR2YW50YWdlcywgYXMgaXQgZWxpbWluYXRl
cw0KPj4gKwkJICogdGhlIG5lZWQgZm9yIGluZGlyZWN0IGNhbGxzIG9yIHJldHBvbGluZXMuIElu
IGFkZGl0aW9uLCBpdA0KPj4gKwkJICogYWxsb3dzIHRvIHVzZSBhIGRlc2lnbmF0ZWQgY3B1bWFz
ayBmb3IgZXZhbHVhdGluZyB0aGUNCj4+ICsJCSAqIGNvbmRpdGlvbiwgaW5zdGVhZCBvZiBhbGxv
Y2F0aW5nIG9uZS4NCj4+ICsJCSAqDQo+PiArCQkgKiBUaGlzIGNvZGUgd29ya3MgdW5kZXIgdGhl
IGFzc3VtcHRpb24gdGhhdCB0aGVyZSBhcmUgbm8gbmVzdGVkDQo+PiArCQkgKiBUTEIgZmx1c2hl
cywgYW4gYXNzdW1wdGlvbiB0aGF0IGlzIGFscmVhZHkgbWFkZSBpbg0KPj4gKwkJICogZmx1c2hf
dGxiX21tX3JhbmdlKCkuDQo+PiArCQkgKg0KPj4gKwkJICogY29uZF9jcHVtYXNrIGlzIGxvZ2lj
YWxseSBhIHN0YWNrLWxvY2FsIHZhcmlhYmxlLCBidXQgaXQgaXMNCj4+ICsJCSAqIG1vcmUgZWZm
aWNpZW50IHRvIGhhdmUgaXQgb2ZmIHRoZSBzdGFjayBhbmQgbm90IHRvIGFsbG9jYXRlDQo+PiAr
CQkgKiBpdCBvbiBkZW1hbmQuIFByZWVtcHRpb24gaXMgZGlzYWJsZWQgYW5kIHRoaXMgY29kZSBp
cw0KPj4gKwkJICogbm9uLXJlZW50cmFudC4NCj4+ICsJCSAqLw0KPj4gKwkJc3RydWN0IGNwdW1h
c2sgKmNvbmRfY3B1bWFzayA9IHRoaXNfY3B1X3B0cigmZmx1c2hfdGxiX21hc2spOw0KPj4gKwkJ
aW50IGNwdTsNCj4+ICsNCj4+ICsJCWNwdW1hc2tfY2xlYXIoY29uZF9jcHVtYXNrKTsNCj4+ICsN
Cj4+ICsJCWZvcl9lYWNoX2NwdShjcHUsIGNwdW1hc2spIHsNCj4+ICsJCQlpZiAodGxiX2lzX25v
dF9sYXp5KGNwdSkpDQo+PiArCQkJCV9fY3B1bWFza19zZXRfY3B1KGNwdSwgY29uZF9jcHVtYXNr
KTsNCj4+ICsJCX0NCj4+ICsJCXNtcF9jYWxsX2Z1bmN0aW9uX21hbnkoY29uZF9jcHVtYXNrLCBm
bHVzaF90bGJfZnVuYywgKHZvaWQgKilpbmZvLCAxKTsNCj4gDQo+IE5vIG5lZWQgZm9yIHRoZSBj
YXN0IGhlcmUsIHdoaWNoIHdvdWxkIGFsc28gYXZvaWQgdGhlIHBvaW50bGVzc2x5DQo+IG92ZXJs
eSBsb25nIGxpbmUuDQoNCkFjdHVhbGx5LCB0aGVyZSBpcyAtIHRvIHJlbW92ZSB0aGUgY29uc3Qg
cXVhbGlmaWVyLiBZb3UgbWlnaHQgYXJndWUgaXQgaXMNCnVnbHksIGJ1dCB0aGF04oCZcyB0aGUg
d2F5IGl0IGlzIGFsc28gaG93IGl0IGlzIGRvbmUgcmlnaHQgbm93Lg0KDQpJbiBnZW5lcmFsLCB0
aGFua3MgZm9yIHRoZSBmZWVkYmFjayAoSSB3aWxsIHJlcGx5IGFmdGVyIEkgZm9sbG93IHlvdXIN
CmZlZWRiYWNrKS4gSSBkbyBoYXZlIGEgZ2VuZXJhbCBxdWVzdGlvbiAtIEkgdGhvdWdodCBpdCB3
YXMgZGVjaWRlZCB0aGF0DQpjbGFyaXR5IHNob3VsZCBiZSBwcmVmZXJyZWQgb3ZlciBmb2xsb3dp
bmcgdGhlIDgwLWNvbHVtbiBsaW1pdC4gUGxlYXNlIGxldA0KbWUga25vdyBpZiBJIG1pc3VuZGVy
c3Rvb2Qu
