Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA9343B641
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhJZQAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:00:18 -0400
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:9440
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237196AbhJZQAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:00:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyRllUw0876ZjxGvDLQi7RssJaph8B515Oaqy8J7d3uv9S4L8JTEXUiLCv9cI/GDHsL6xIZ2sXyRePZd6zMnR/SR3PO80RT5H/lQwrNQ7PewJaF36p8yq/h+4wn0wP65C+CK5rm3a/zNRHIuuYfb+Yfff3PQr+d4Det5LGF3cZFjfJAeR3drDbf4sk/U6PSG7Lh/ji98IGKd+zUL9w7hhqFK0LsEn6BMm6VB/Ynu39olbWOvKxwMROsxxvJWWmW67ltbGJkm0ny28RcaUgvpEWpkB+roM5wv43SNcZaDTqpPPDWzHeSwo6SlOxii3zcHGTK+1pY2mWaSRJGBjO3j9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23qfFQj9hFShj9mOZT6hLsMmnV1icoL3z3g5C2k3Vug=;
 b=S9QG7QQlmeIvTDLeBeWMkDMhC/61FFV//nXvKTk2V0f9XbnrtFu5hcfkpm2k0Rs6cPxFm3GArhWOtGqV6JiX0hM5lS8cJWpCzBefaoCvLgD6ptq/FNgLV5LbuZuZSM3OGfbx8ZM0Q1AOZchDrF/GJ2e0OQpUelrnlcmhaT1APSJz9K4DwwIFkoOy47w5mralhAylRsOXz3KEaVwDqFcnr/3XjYbB7oYGs4AXr2bu5CkuOiO9pZjU22sXK4Rz5u57kNNSIJMPO5zrqI4U/ScfgnXdkzVnLPJC/xx9uVS5QglKt35pWwRmjZDYYTOQdobLVXxfxLJdKdjmxd9+kkzT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23qfFQj9hFShj9mOZT6hLsMmnV1icoL3z3g5C2k3Vug=;
 b=z9Lba1FjcXKUCt/zcSPeMz4JMIKqgEUGYu/H40yreoWAxW7U3NiEW+xa16yfhpntoIEhSZfEThX6GdGE2UHVffZCfz/Lx5phenIK1X3Ox9pdXuU5E9D12zzoM7JUoTwTJGyBVdKOQ74+1kzBedRKIwkJHpThnFVKJ0tSrVMoyTw=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB6245.namprd05.prod.outlook.com (2603:10b6:a03:d9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.12; Tue, 26 Oct
 2021 15:57:48 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::fd9a:e92c:5d9e:9f6d]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::fd9a:e92c:5d9e:9f6d%9]) with mapi id 15.20.4649.014; Tue, 26 Oct 2021
 15:57:47 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
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
Subject: Re: [PATCH v2 1/5] x86: Detection of Knights Landing A/D leak
Thread-Topic: [PATCH v2 1/5] x86: Detection of Knights Landing A/D leak
Thread-Index: AQHXyoHTKV5cndx/40ue7a6T6JW+havlb2yA
Date:   Tue, 26 Oct 2021 15:57:47 +0000
Message-ID: <670B2DF9-204C-4A56-92C0-EC52CBF160E3@vmware.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-2-namit@vmware.com>
 <e96dc19c-b289-7e5d-4a0a-4609214a9818@intel.com>
In-Reply-To: <e96dc19c-b289-7e5d-4a0a-4609214a9818@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ada08494-eaaf-4f1a-2d8c-08d998995b5d
x-ms-traffictypediagnostic: BYAPR05MB6245:
x-microsoft-antispam-prvs: <BYAPR05MB62458D79DAEFD03C697EFA49D0849@BYAPR05MB6245.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RU6fl2bAstFHv8BsNYAwCz4G+PEoq0XpBWOP0rsjRZ/vpMRqGo/hAI5auSRr+Gt6l5E/u8cgty0rLbkSxnCSuHy5KcCsFPZ4u/0wItPW2szQ1Qrz6MJjg/VlT7tY7YUX2MNGDOgjzQC2Uift11HzLxoyxhQKnkxXStq4P/IGqsnkU7Yty+GNP30/kRRtwhdcrPYKJGHx6ZpFR975IhLW3w8FpE5jqvRVAuG4c4HL3r222eTZIAEKAr4ljr6mP2CfjAGix5e/7OFGktgdXq61zRnlNV5JlZ50Fa/jYjEyUVw/HBqZ2c/011DrtwbhOwefd6XcM+1MF/HPY5EGAVy1E/tUzziJfRWah/pr9CiwEbb6yy7hGFxdh2nQSyR8eO1cqVuKU43WjSHZvqm8/5ZYVfrQ3gxtRzfioUGykdb1usEfvpiRXXQ3T5fYK2T/qxPuc3/CTZbatVd/NQ7KASgqoE06ZOfYmdi9MrtyuZR8GAfub7GvEfXGtMyWEJqwFJAs94dvBU5E/LsxdkIW9z6rdDGpdixhp9w35IrPSbAsywe88ZpXj0RC/XniLRUsvXnLa6jAi0/v6+Rvnh9ujC3URe/HVfiEPaNYCL3r7BS8eSsyQ++0jemLaF3v6FpofLMI09B3QI03llK1UR88CQ4R1YjRHNCNgU834vsoAEBHjMTFPNi9kfPW9TAOCJgeqtJKPzBf9q1A11npK1ckJJBZHqhHOXHStgG3CFfddXz/b3AOj6qWZwAxNmfUw6g3O551
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(122000001)(508600001)(186003)(4326008)(8676002)(38100700002)(4744005)(6506007)(53546011)(6512007)(8936002)(6486002)(7416002)(26005)(33656002)(5660300002)(2906002)(66556008)(316002)(54906003)(66446008)(71200400001)(6916009)(76116006)(66946007)(38070700005)(86362001)(66476007)(2616005)(64756008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGJzYlBqUWE4SGpRekVaKzduekdFYjloMUJLQ20yMXlVZWxJaXFVVG1SNUlH?=
 =?utf-8?B?dVlRZHFYMG1CYWFvQ0JQMk94R082cjVvWUFGYlc4dmpmYTRlRFZHOWFJNUp5?=
 =?utf-8?B?MU05bVJzUU9iYjR4T3RDVm9HVHltajFqbTlhbXljQUFyMk01UXBTQUh1VnZ6?=
 =?utf-8?B?alkyVUtJYlRqZWpEQ3N0ck9qOC8wR0R1QUpERTFpMkcxSVRCaG5Zd1htTUJN?=
 =?utf-8?B?Q05EK0NXSDhDWjJUOVdQRHNhY0gxbWo1QTAwdytHT1dybVhRdkFOazhTYjF3?=
 =?utf-8?B?b0txQWNFMW9LNTQwZXBjUWR0VGZoWXRrT2R2QWtnVVUwc0llVGZNcmMwMVgr?=
 =?utf-8?B?MDdtSkpGNFRPbGk3OTA1eGIvQWtldjVCUFd2a3Q0M3RBcEhpaUh3amNyc1Mr?=
 =?utf-8?B?MW9sME1TQi9VS2xLUXlpVzY0MFlWTnRWVHc5V1pMZkpGa0VMUWZzRGsyTlIv?=
 =?utf-8?B?QjYrS0dTQkdEZWFkMEU5NUNiaTRrbVNkYXV3MzIwN1ovcjR5MWNZbStqYUlI?=
 =?utf-8?B?ZnloaVBJOU5LUWFqOUpsSmMwQ1c5WkZlNXdYSkk3VUdtOVVRNUE3OEIwNmdS?=
 =?utf-8?B?UGpYblNwUDUrR1VTcFZ0V3JhVU1IOEVZS2dJZG5IeDg5dkJ4RFBVcHhIU0hF?=
 =?utf-8?B?MzVwQnl4dzk1N3VpUTBHbWlwTWtpSXVDR1ZqdVZTQlR0Q2FZOFBwVUV2THdy?=
 =?utf-8?B?RlpKNmlVcmhUNHRVWTVSTUlYeXJ2Zi9NZy9kcUlCZ1ZENWtQWFRwdHpSa0Iz?=
 =?utf-8?B?OExXV1pKRk0vZ1hhbE9DaXI3SzRDT0V3TmFLS0VCd2VBUnBhdDFRUTlVcFg3?=
 =?utf-8?B?ckdXaHdOQmNMQnN0OGVFTUJ4cC9saVpNdnpOOGpCeHRSWTljMXFEaTZJUHh0?=
 =?utf-8?B?N2swdUZ0M2sxWkRISjhNTTQ3Y2RDN2RnMDVhZ1lLam5BSzNaWnFXVit0eW0r?=
 =?utf-8?B?Z2FPajRLaUkvM1VVbjhiSEliUjQxZWpKU0laNHRKZXI2SlMxZ3hmYmRxeHVP?=
 =?utf-8?B?YS8rWno0RlRZd2FGOGh6Ulp5M0IrdlZzcCtSRkVGaHJpakdFQmlhdU1jMmVj?=
 =?utf-8?B?V1JNbkc3eVZKajBJbEZYWVdId0Nrai8zejkvbVNnNUQ1R0JseWRrclk3VnZy?=
 =?utf-8?B?aytJdGpRS2pRZFFPY29Rd1BDbWt1V1J6SXJrR1pXRUN6Tk56L3ovcEt6Q3JT?=
 =?utf-8?B?SjM0REVJUWVKK1ZJMExwRlJXWDhUcmtQd3NRMU1OUWp4ZFhOaWJnb1RkbWdE?=
 =?utf-8?B?Vk9ucy9nWkMxN3poRW0rNG90SW8xYkc3eXNMeFZRQlJiWW9SY25SL0Mva3hL?=
 =?utf-8?B?TVRFak1RbGl5RXY2QVI2ZEZJc3FPaE9RYUtCSkdmR3Vua3pORThET2VJMTR0?=
 =?utf-8?B?YUtMM05qdFI4ZmFQc3UxbTRCSHNyTDJTM1EzODZ0NWhyWU5DRnBIZVNiT0xF?=
 =?utf-8?B?UEdxbGJEdlNvSFhZY0hUYmc2ZG4xMi9SNTF1aC9KUkNBekVvK0kxYVRuamlS?=
 =?utf-8?B?WVlleDh3eG5La0ZjT1NBdVF4UXBFM1F6ZkMzMXBISjl3dFlyS1RkYS9qclcx?=
 =?utf-8?B?dUg2TmxteDlzMVd3ZThpVS84c25tblcxK1UvK0phZmF3WlBBcUVHQnJwMG1r?=
 =?utf-8?B?UFBPb0YrVlBWQ3FHc2ZhLzJRL2N4Z1FENXlkbHlDbjNlcmlNMWJqd2pMdDFX?=
 =?utf-8?B?ZlI4TGFqdHkwWk1PVit1WHlpSVgxQ2Q4VUVNWkVXOThTWnd4K0pUMEQ5TnJ4?=
 =?utf-8?B?L0s3c0Y4a1dFUWpYbmJuYTQ5VHN3d0QxUmpidHl6U2hGaGlyZmdiYUFiT3lG?=
 =?utf-8?B?eE9ScXc4NmNnQnlCaHNndDhKZDNldXc3bVVnTVhVZjE1dVFmeWJQbHpUNFFN?=
 =?utf-8?B?RHVtNUlabEV5ZGNydUdoRU1aTkJUWHpLVmFhVHZ5Tkgxc1BobTRlMXVpTGlL?=
 =?utf-8?B?eFp0Q3lBVVdyOWtmcGxNTTJ0YW1HTlAzSVZlSExXNFdRVUozSm5GWkhJek1m?=
 =?utf-8?B?NUx4SWJGT0dwNSt4bkphMU84d3VUbXJsb2prWUxDbXYyVnpMbUcyM244VTR6?=
 =?utf-8?B?dDNrb2p0ZWhtQWtzeWh1QjZEbjBxUVZ4SWhCZnJYV3N2amppUHJXYlVvUmtT?=
 =?utf-8?B?NnVBZW5xNGwzakZINERGZ0RlMzczZEdiRmN3R09ySm5uSHVtNFVnQmNwOURH?=
 =?utf-8?Q?kF/oUkX3zHTrGOOQBxZfyyQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B3FED1B17B4E04A9CA4C2D450817FA4@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada08494-eaaf-4f1a-2d8c-08d998995b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 15:57:47.8234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0ItRZuiy/fKxK6tkf5XKyXdJKAPcrqcoraZF0yRy+EUZ+vOvgPGHCdAuAn04EdkuPvT6A79O9nTPpfvA1Rx3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6245
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDI2LCAyMDIxLCBhdCA4OjU0IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5z
ZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDEwLzIxLzIxIDU6MjEgQU0sIE5hZGF2IEFt
aXQgd3JvdGU6DQo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2ludGVsLmMNCj4+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvaW50ZWwuYw0KPj4gQEAgLTI5Niw2ICsyOTYsMTEgQEAgc3Rh
dGljIHZvaWQgZWFybHlfaW5pdF9pbnRlbChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQo+PiAJCX0N
Cj4+IAl9DQo+PiANCj4+ICsJaWYgKGMtPng4Nl9tb2RlbCA9PSA4Nykgew0KPj4gKwkJcHJfaW5m
b19vbmNlKCJFbmFibGluZyBQVEUgbGVha2luZyB3b3JrYXJvdW5kXG4iKTsNCj4+ICsJCXNldF9j
cHVfYnVnKGMsIFg4Nl9CVUdfUFRFX0xFQUspOw0KPj4gKwl9DQo+IA0KPiBQbGVhc2UgdGFrZSBh
IGxvb2sgYXQ6DQo+IA0KPiAJYXJjaC94ODYvaW5jbHVkZS9hc20vaW50ZWwtZmFtaWx5LmgNCj4g
DQo+IHNwZWNpZmljYWxseToNCj4gDQo+ICNkZWZpbmUgSU5URUxfRkFNNl9YRU9OX1BISV9LTkwg
ICAgICAgICAweDU3IC8qIEtuaWdodHMgTGFuZGluZyAqLw0KDQpUaGFua3MsIEkgd2lsbCBmaXgg
aXQuIEkgcmVhbGx5IGp1c3QgY29weSBwYXN0ZWQgZnJvbSBBbmRp4oCZcyBwYXRjaA0KKGZvciBi
ZXR0ZXIgYW5kIHdvcnNlKS4NCg0K
