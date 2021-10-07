Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DB242577E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242579AbhJGQSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:18:00 -0400
Received: from mail-co1nam11on2089.outbound.protection.outlook.com ([40.107.220.89]:18784
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233479AbhJGQR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:17:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdVhnHzu47tWvULIt5BFljxKARG/47snCG/Dlk6tvs8wvTc0Ao1YWy1zD+7yxGFW/QEeYCW3iUoEkU+zkl9wca2yvmrYY7JZwmALNkv3Q4/rxnAFktBz4URPVSM9YvY3eVj5216O4cT5I3WoS+azYTfD44zHk5NN6F6oUMBfszsy2Df+REQB3K6BYsY2Mdd3R0C2fUpbv/wFqca3euvbcnF55EjM1VE6+pcv42nrmReuKbVHhPSwcz6YdN/oJavr/7zaXwaJKuAb5xkAmSYL5Y+AuUsyg/w5g8IXGb8TuzHB5mzwnNyre7p+N3QOgF7NqfxU8fYDDT3NbQ7rFnrzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KspE8Hqko6BXL0SHws8pJpPGqzp+Y556fZpKB0cKGw=;
 b=Ow1PTLcQbiyn5eG2iPWRfoc9hvohgLfl4UurUCz1jQWiyvEDNFcjXso3Wf1I4lCk3T9q1DMQaOLlRFMzuNcKBmJA6jOBDhY+TKPd5mtZp+uQtJM3Y9mWKTnxxNyAe/S9aMGAY+h5iyw+9iqguIo81aTsHz3dOxF9JTlb6dg4filfaIQ0EzDQ1OctDF2rTE/2ydP7o/YiDWyPRLp6GdShdGndgVg6dPWhOlidR5AyjftPwwIvpXmBGC+wJhzuzvUypmr/ym/RD9Z7VzHXqyH/r4KEsEQ+10Gtz9Nb/vD2/T/ltG6+0PHWiUYdrdGP69eLeehvj67QGa3NcNgd3JD2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KspE8Hqko6BXL0SHws8pJpPGqzp+Y556fZpKB0cKGw=;
 b=yiY6RVw7EKuRGBVX8iIfVY6p8LV6M4lwiTPrmtyRVtUvxlLTIIIWoGzM+79jdGEztIrYhwJXl7FrcX5WeEcA+2QQ2osLuGdu7jCJtgbeeWU8gU4NuO/BCHYtvN0pRWOj3BuqBKg/rZ8iMe03qP/ZcgJ3Ki9q0mgRsiPBB+QGB7w=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SJ0PR05MB7391.namprd05.prod.outlook.com (2603:10b6:a03:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9; Thu, 7 Oct
 2021 16:16:01 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::fd9a:e92c:5d9e:9f6d]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::fd9a:e92c:5d9e:9f6d%7]) with mapi id 15.20.4587.019; Thu, 7 Oct 2021
 16:16:01 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] mm/mprotect: do not flush on permission promotion
Thread-Topic: [PATCH 2/2] mm/mprotect: do not flush on permission promotion
Thread-Index: AQHXu3S78aiUxqowA0eKkUItBU98VavHtlGA
Date:   Thu, 7 Oct 2021 16:16:01 +0000
Message-ID: <5356D62E-1900-4E92-AF23-AA5625EFFD92@vmware.com>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-3-namit@vmware.com>
 <5485fae5-3cd6-9dc3-0579-dc8aab8a3de1@redhat.com>
In-Reply-To: <5485fae5-3cd6-9dc3-0579-dc8aab8a3de1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1007fb75-c8ba-4356-14c0-08d989adc11c
x-ms-traffictypediagnostic: SJ0PR05MB7391:
x-microsoft-antispam-prvs: <SJ0PR05MB7391943D19B0FA6B5C17D52BD0B19@SJ0PR05MB7391.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LA7BAdJ0lJ4lsrBmUR51VlTz5EnDAGEGEymfpdvYzyOx4m2DrGP41YHu2gpptt6j2K/RZ38aVWVk5fMxratgnFxPNXXDLQa1AKwcxzklesWizLynowzMI5+yTU4HlGWjA6gYaagcjMWql9LS9EB70yXQ9nerLCUa9cFYfYdgn+r/QBWMxE+0GEzzDJ30j9lzXAjmHrnvU2hju3ZeHs6wt5JiooDBVR3SlZfNrcpIe5j3H5l24iGlbAY1eUvXkmkgVS7O+HM2xh95xUo6Peki9UyM080Q4xTyateBeZ1QndoANCFe+zx3G8GjUeqLCOGqVYk1ztqD3hX6bng1HhG1CBPJURwnh9qgLYYnUi2gf5g8CJnRE4pomWQgHbmie+off4QvyrQGs+kw2aNSmVVMSi69c7LpIHAqAjZNJBeVJ8Lm8Jathc3wXB/g5QJG89RSIPQdU+8AeNorKvfQdFKUjyutx1LwxK/5fS6GpUf2qWWIUVAPjFc3++Glb8ChNhBmZ3Cc/ER2pMAhO+r8tUlh2KESCMCbr2tI7DXhqb37Q0GfRTDsOyO4QF0iW6eycOcDvBWeBUsGG3xYwAnJxN++JCQm5QqLpAg6fjDFv763SMHwyEYUAQ6Z7G8imFgWYIBfbe9M8cG2Ex09zCKD9DsBSjfsnVz2NVyG9qawd9bmmSGYTO1WHxAq6ykjwXAUFf7Oj+HFs06337n5sSzsY+K8c4PYJkFBYf1Bg23RiWGA1kk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(2906002)(53546011)(5660300002)(54906003)(508600001)(83380400001)(6486002)(66556008)(64756008)(66476007)(66446008)(316002)(8676002)(8936002)(76116006)(86362001)(6512007)(7416002)(38100700002)(122000001)(38070700005)(6916009)(33656002)(4326008)(71200400001)(36756003)(66946007)(26005)(186003)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmFsMGk1YWI1Vno0YkVMc01qWllJbzFQa2lBWHVMM29oTlBVZUt2WVhPYW1j?=
 =?utf-8?B?dE9GTlgzbDNyL2pHWnBtTzR1UE1BaXgzVno1VzBucGhpQmRTZEZjM2g0TXZn?=
 =?utf-8?B?RXFRLzVrd3Eyd1lOQ0hQUitLcWVEWGo4WVBXOEVicFBieUhMSlBRWkwwbllo?=
 =?utf-8?B?OGl2K3UrdStMY0JOKzE4a0paYW9XU0dkYmFyS1R3OU9vN1lwdGhmclcxWGZt?=
 =?utf-8?B?bEd2L3Jnem5PS3dnRndabWZSNkQ3M2ZMQnVtU2FYK1RWdEY3UDN1VXBrYVdo?=
 =?utf-8?B?Um1RQVFzb0JFWURNb0RhTWJ2Qld3b1lwL0ZmZUh3VUtZdjZld2FCSlptaVZO?=
 =?utf-8?B?RWNnS2xKN0VGS3V5T0R4VnlpMjZvMkc0cXJtK0QvYTMxYVBXK0lrL0JNUkZO?=
 =?utf-8?B?bnZ4Wlh6U25xNmNPR0l1K3lIdWZMcW1ieldNb1dQWU03NHN2c3hxTVIwZTlV?=
 =?utf-8?B?ZlJxTzlBN0ZoZS9mOXFOdk5EeWJndFBTMFlEY2YvY1NNMWRSUGJRUWxyWXFT?=
 =?utf-8?B?U2k0Zi8vZTczUDFHY0toZkpZYmUvb0hReDEwWWRlQXU1a3BMY3dMRTZTVm43?=
 =?utf-8?B?Yk1PMXdCMlFydExUY2xTaEdkSGgvVktrd29QRHRGQWE0OGJUTjNSNGJBV2ty?=
 =?utf-8?B?eCtEMzFrcy9EK0RRZTVxOHBBY082R2lOd3BaZU91MERjY3ErWGVycElmT011?=
 =?utf-8?B?VjJiUTlYMkhZd1hXeEpDYlh3eEcyWHpQeUpHM0hYejlDMFJ4SVUxL25OdkV4?=
 =?utf-8?B?V2ZSYUlJWk5QaHNOalE1WWRuc1kySUlvNlhsdXMyVEFQQzhwdVQvMmwzelZB?=
 =?utf-8?B?eXpmZURUNk8yaE1pbGdwQjhnQzEwRHA4ZkhYZTNJUElYQlpqTUVDd2pjZXRG?=
 =?utf-8?B?L1FhWU4rdWxDSDdkS3VyNlRvU1ZIVUluNVJ1VHZQSklhQXVpYXJ1NEp3bVh1?=
 =?utf-8?B?NG4zaXlnQ0lKZzF6bUtET2xSLzcwVjZUbE5oY0FRcFNBa0t0eXozQzJ3U3BV?=
 =?utf-8?B?VWhJUkNNL2ZrblIxZStFRER2dXNnUFRhZFg3c1YySGxyNlhmdW15eVJIWGVT?=
 =?utf-8?B?YjM2NmV6UHJlczc0R2RlMWpGNXRrdFhwZStRbVpqMG1oMFNUaVhNbWdWTUZV?=
 =?utf-8?B?ZStIallkcG1mRW1nUklCb05Eb2k3S0JZOFZnak9XQmxNR2VxTlo1c3FGUU9E?=
 =?utf-8?B?Uk1ObU1HeWU2QTJOR2oxVEcrc2s4clBxeHkxK21rTCtsb0t6eDhLSHlHd0wr?=
 =?utf-8?B?bHBTWnV6aWgva1BtTUovZFhyTys5VjBFT1JQeXI1WThFOGJhUWo5Q1FIVllK?=
 =?utf-8?B?aHRRbVpWb3diZlROY1ZaSFp1NlVFQXBmOFg2TStQU0ZpOEk2T25rN2lQVWtB?=
 =?utf-8?B?NjBDMkYvSXJoZGM4Qm5UOHhJQ0gwd1pKMVQxeTllQm00YWI1T2pBUmdNQnpa?=
 =?utf-8?B?cmR2NlZ4ZFllay82SEhVUDBqLzZtc3prWSsxSjNpczZhbURnR1FJYU1tSk4z?=
 =?utf-8?B?V2htTm9QQkIwbFdCbDYvUmlXYnBpTmQvQ1lzeU9YS2RNZGhSL3BwenRJYWtX?=
 =?utf-8?B?V2RRTDBlcTJ3SGlwVHVtUlJESFBQTHdlcjhUYVNKN09EdjZXY3lVZHNqeWlY?=
 =?utf-8?B?ZG5ua0JMK1hQckI0RUJFTm5pNWJVUDgwamtrY2JrRTE1Rkh0TjRUTDZEbGhn?=
 =?utf-8?B?M04wUk9qMUdKTUJtZGs1dGRSVGh0T3hjUUk5cXhqNE1NdjhkT25TcTgvRHh1?=
 =?utf-8?Q?krXbLzaiTXSVx3lw0j3Ha08cdtbBBFa4TUTmgYo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C61779617EFBB4AA9F244FD75926365@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1007fb75-c8ba-4356-14c0-08d989adc11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 16:16:01.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xs25cuTrKjoezkmm4b/3YyjWO3OcgNU0PfqJvIbIBO4U3H2OmWNLDXEq8YrztS3cQNlwwOZtTZBqqeSg72q+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7391
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE9jdCA3LCAyMDIxLCBhdCA1OjEzIEFNLCBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAyNS4wOS4yMSAyMjo1NCwgTmFkYXYgQW1pdCB3
cm90ZToNCj4+IEZyb206IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+PiBDdXJyZW50
bHksIHVzaW5nIG1wcm90ZWN0KCkgdG8gdW5wcm90ZWN0IGEgbWVtb3J5IHJlZ2lvbiBvciB1ZmZk
IHRvDQo+PiB1bnByb3RlY3QgYSBtZW1vcnkgcmVnaW9uIGNhdXNlcyBhIFRMQiBmbHVzaC4gQXQg
bGVhc3Qgb24geDg2LCBhcw0KPj4gcHJvdGVjdGlvbiBpcyBwcm9tb3RlZCwgbm8gVExCIGZsdXNo
IGlzIG5lZWRlZC4NCj4+IEFkZCBhbiBhcmNoLXNwZWNpZmljIHB0ZV9tYXlfbmVlZF9mbHVzaCgp
IHdoaWNoIHRlbGxzIHdoZXRoZXIgYSBUTEINCj4+IGZsdXNoIGlzIG5lZWRlZCBiYXNlZCBvbiB0
aGUgb2xkIFBURSBhbmQgdGhlIG5ldyBvbmUuIEltcGxlbWVudCBhbiB4ODYNCj4+IHB0ZV9tYXlf
bmVlZF9mbHVzaCgpLg0KPj4gRm9yIHg4NiwgUFRFIHByb3RlY3Rpb24gcHJvbW90aW9uIG9yIGNo
YW5nZXMgb2Ygc29mdHdhcmUgYml0cyBkb2VzDQo+PiByZXF1aXJlIGEgZmx1c2gsIGFsc28gYWRk
IGxvZ2ljIHRoYXQgY29uc2lkZXJzIHRoZSBkaXJ0eS1iaXQuIENoYW5nZXMgdG8NCj4+IHRoZSBh
Y2Nlc3MtYml0IGRvIG5vdCB0cmlnZ2VyIGEgVExCIGZsdXNoLCBhbHRob3VnaCBhcmNoaXRlY3R1
cmFsbHkgdGhleQ0KPj4gc2hvdWxkLCBhcyBMaW51eCBjb25zaWRlcnMgdGhlIGFjY2Vzcy1iaXQg
YXMgYSBoaW50Lg0KPiANCj4gSXMgdGhlIGFkZGVkIExPQyB3b3J0aCB0aGUgYmVuZWZpdD8gSU9X
LCBkbyB3ZSBoYXZlIHNvbWUgYmVuY2htYXJrIHRoYXQgcmVhbGx5IGJlbmVmaXRzIGZyb20gdGhh
dD8NCg0KU28geW91IGFzayB3aGV0aGVyIHRoZSBhZGRlZCB+MTAgTE9DIChuZXQpIHdvcnRoIHRo
ZSBiZW5lZml0Pw0KDQpMZXTigJlzIHN0YXJ0IHdpdGggdGhlIGNvc3Qgb2YgdGhpcyBwYXRjaC4N
Cg0KSWYgeW91IGFzayBhYm91dCBjb21wbGV4aXR5LCBJIHRoaW5rIHRoYXQgaXQgaXMgYSByYXRo
ZXIgc2ltcGxlDQpwYXRjaCBhbmQgZG9jdW1lbnRlZCBhcyBuZWVkZWQuIFBsZWFzZSBiZSBtb3Jl
IGNvbmNyZXRlIGlmIHlvdQ0KdGhpbmsgb3RoZXJ3aXNlLg0KDQpJZiB5b3UgYXNrIGFib3V0IHRo
ZSBydW50aW1lIG92ZXJoZWFkLCBteSBleHBlcmllbmNlIGlzIHRoYXQNCnN1Y2ggY29kZSwgd2hp
Y2ggbW9zdGx5IGRvZXMgYml0IG9wZXJhdGlvbnMsIGhhcyBuZWdsaWdpYmxlIGNvc3QuDQpUaGUg
ZXhlY3V0aW9uIHRpbWUgb2YgbXByb3RlY3QgY29kZSwgYW5kIG90aGVyIHNpbWlsYXIgcGllY2Vz
IG9mDQpjb2RlLCBpcyBtb3N0bHkgZG9taW5hdGVkIGJ5IHdhbGtpbmcgdGhlIHBhZ2UtdGFibGVz
ICYgZ2V0dGluZw0KdGhlIHBhZ2VzICh3aGljaCBtaWdodCByZXF1aXJlIGNvbGQgb3IgcmFuZG9t
IG1lbW9yeSBhY2Nlc3NlcyksDQphY3F1aXJpbmcgdGhlIGxvY2tzLCBhbmQgb2YgY291cnNlIHRo
ZSBUTEIgZmx1c2hlcyB0aGF0IHRoaXMNCnBhdGNoIHRyaWVzIHRvIGVsaW1pbmF0ZS4NCg0KQXMg
Zm9yIHRoZSBiZW5lZml0OiBUTEIgZmx1c2ggb24geDg2IG9mIGEgc2luZ2xlIFBURSBoYXMgYW4N
Cm92ZXJoZWFkIG9mIH4yMDAgY3ljbGVzLiBJZiBhIFRMQiBzaG9vdGRvd24gaXMgbmVlZGVkLCBm
b3IgaW5zdGFuY2UNCm9uIG11bHRpdGhyZWFkZWQgYXBwbGljYXRpb25zLCB0aGlzIG92ZXJoZWFk
IGNhbiBncm93IHRvIGZldw0KbWljcm9zZWNvbmRzIG9yIGV2ZW4gbW9yZSwgZGVwZW5kaW5nIG9u
IHRoZSBudW1iZXIgb2Ygc29ja2V0cywNCndoZXRoZXIgdGhlIHdvcmtsb2FkIHJ1bnMgaW4gYSBW
TSAoYW5kIHdvcnNlIGlmIENQVXMgYXJlDQpvdmVyY29tbWl0dGVkKSBhbmQgc28gb24uDQoNClRo
aXMgb3ZlcmhlYWQgaXMgY29tcGxldGVseSB1bm5lY2Vzc2FyeSBvbiBtYW55IG9jY2FzaW9ucy4g
SWYNCnlvdSBydW4gbXByb3RlY3QoKSB0byBhZGQgcGVybWlzc2lvbnMsIG9yIGFzIEkgbm90ZWQg
aW4gbXkgY2FzZSwNCnRvIGRvIHNvbWV0aGluZyBzaW1pbGFyIHVzaW5nIHVzZXJmYXVsdGZkLiBO
b3RlIHRoYXQgdGhlDQpwb3RlbnRpYWxseSB1bm5lY2Vzc2FyeSBUTEIgZmx1c2gvc2hvb3Rkb3du
IHRha2VzIHBsYWNlIHdoaWxlDQp5b3UgaG9sZCB0aGUgbW1hcC1sb2NrIGZvciB3cml0ZSBpbiB0
aGUgY2FzZSBvZiBtcHJvdGVjdCgpLA0KdGhlcmVieSBwb3RlbnRpYWxseSBwcmV2ZW50aW5nIG90
aGVyIHRocmVhZHMgZnJvbSBtYWtpbmcNCnByb2dyZXNzIGR1cmluZyB0aGF0IHRpbWUuDQoNCk9u
IG15IGluLWRldmVsb3BtZW50IHdvcmtsb2FkIGl0IHdhcyBhIGNvbnNpZGVyYWJsZSBvdmVyaGVh
ZA0KKEkgZGlkbuKAmXQgY29sbGVjdCBudW1iZXJzIHRob3VnaCkuIEJhc2ljYWxseSwgSSB0cmFj
ayBkaXJ0eQ0KcGFnZXMgdXNpbmcgdWZmZCwgYW5kIGV2ZXJ5IHBhZ2UtZmF1bHQgdGhhdCBjYW4g
YmUgZWFzaWx5DQpyZXNvbHZlZCBieSB1bnByb3RlY3RpbmcgY2F1c2UgYSBUTEIgZmx1c2gvc2hv
b3Rkb3duLg0KDQpJZiB5b3Ugd2FudCwgSSB3aWxsIHdyaXRlIGEgbWljcm9iZW5jaG1hcmtzIGFu
ZCBnaXZlIHlvdSBudW1iZXJzLg0KSWYgeW91IGxvb2sgZm9yIGZ1cnRoZXIgb3B0aW1pemF0aW9u
cyAoYWx0aG91Z2ggeW91IGRpZCBub3QgaW5kaWNhdGUNCnNvKSwgc3VjaCBhcyBkb2luZyB0aGUg
VExCIGJhdGNoaW5nIGZyb20gZG9fbXByb3RlY3Rfa2V5KCksDQooaS5lLiBiYXRjaGluZyBhY3Jv
c3MgVk1BcyksIHdlIGNhbiBkaXNjdXNzIGl0IGFuZCBhcHBseSBpdCBvbg0KdG9wIG9mIHRoZXNl
IHBhdGNoZXMuDQoNCg==
