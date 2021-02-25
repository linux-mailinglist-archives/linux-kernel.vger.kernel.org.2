Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16F2325511
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhBYSBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:01:51 -0500
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:26017
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231445AbhBYRyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:54:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4yNRcCci6uoLSg9lJ54xgsJlUCob8SB3+gkEhpW63z9baovC3eMFzRZtnYw1CKV96e34yJiWWqndC4BxIROcMvGd4ZM6MoZssnFF9+Mc5cr1RXKCHxRScNWqq+tBSJhJd5qNe6XEEdIKB5kEvU2Zw81hrpaaQj5b/XZe2XYPFoTGwkixWe9BvqDNjtrORNzhEHKazGotfOO04Fcxoip3hXCTiuK1zJdW3xVwTpyIQhyaAgJqrkxYVdSTf28kdIGpa/taF7eIRX7yRm2IyQOqdlAYZz8ZSWpu2dW2n2prFlxks493LNeLp9MOwBbKkPjJ0bGVc5eijacke45yf6t4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPUs2RQkBKnSWt3tfO90vmdfytlepOortjCD6+Dfa8g=;
 b=RXb3iqe+uUvmUEWBBXxyBvH7pgZ0beiuoXX8m6TjeLGSPnQ+Km/BgI/HaB9MculTATx3L6CTbFIKTR6HGm5906/l43XhkiGXwrqg6jEqrgdpn+YeUh4DJSD98iACG/Pafes8AKwSImpiRM7cXRzkzMkoI23dqOhhIOkX9LY//d2ZIpD5GAN3WJ9alEkg9BG0/h1LVoBp0/47960VSF3eCcbB3PskXtk7zJPCzdqvE/8H2uEkZXSkrZn2KOjOBbWEFgrUlACrgP3gf75RsXAT79yR8aEIcl3n8BsJq68usV7yL0D8AtXLABFKHByEShud6weRX2H4RjLXW/8TMXmDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPUs2RQkBKnSWt3tfO90vmdfytlepOortjCD6+Dfa8g=;
 b=Axuf1lKvtsHgMI8PNkNENFI2VdXP42AsMvORTfDHJjX6siWJAqIJYRsFHdEwq7Ulutqp5iLqMltBbx9d9HGO6Y+7aSLGZoktNLTsTa0aGx8U69DJTENNCcQWKqIpF/Ujy5i07EYA1g90fp2opXw9OnGPFvRli+wgormK/x++7z0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by SJ0PR05MB7644.namprd05.prod.outlook.com (2603:10b6:a03:2eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.18; Thu, 25 Feb
 2021 17:53:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5905:ca03:9fa3:ab50]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5905:ca03:9fa3:ab50%6]) with mapi id 15.20.3890.013; Thu, 25 Feb 2021
 17:53:12 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 0/6] x86: prefetch_page() vDSO call
Thread-Topic: [RFC 0/6] x86: prefetch_page() vDSO call
Thread-Index: AQHXC3A3AKdXDDevAkSbJ7drCRkvXKppF4sAgAAKEoCAAAWsgA==
Date:   Thu, 25 Feb 2021 17:53:12 +0000
Message-ID: <C47CFA1A-2183-4EC8-B201-C95BB1C7F882@vmware.com>
References: <20210225072910.2811795-1-namit@vmware.com>
 <20210225121645.GZ2858050@casper.infradead.org>
 <0EFCDB0B-DB73-4866-9C0B-7192737CA372@vmware.com>
 <20210225173253.GB2858050@casper.infradead.org>
In-Reply-To: <20210225173253.GB2858050@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 944e52f7-cc78-483b-8e14-08d8d9b63830
x-ms-traffictypediagnostic: SJ0PR05MB7644:
x-microsoft-antispam-prvs: <SJ0PR05MB7644773DF2F85877F54C32CFD09E9@SJ0PR05MB7644.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blubTBW0sjrTW9gpeUCqAeaS9KplSJ+fBuJaZn++KeY4sYAstpNJioLGy034qUG9E3nF4DXXcfeNMtFWVZnBkEphWfcEsTxzoavk7lvoUbbPpk1DfXW4Olpq7Dp7DoPrqlmvZeOKexWYmRlj8jQZpEOWUNzpJ/dWFJR4sXwnpeeT9kyJkm32gmtks6IBRXIgjLztfq/aXRvcdpjRkIk5Lsed+tFXb+airCYPpGMJH9Yc8m10ORO5K0FNIWokOVJA5cKKaa5/y448YSBznt/w7PRQdSogwUY/NyTr86pHrkHO7JwoKKvgbfUpmvMNZGI0FhFq/sVUkAaWd3xzRi7Y35SPxfGN5iJvYsHO0Q4AiwWG1nmGyVoSO/75WG7VuZif3qKrnsnLTPxFXZpZrnfMQkKglpaCA2ppeTwFMl+F31GpEW60INFZ8pFm1STtf+vFGnWdPTy9K1uZ3fljTTaoNJOxmRROGtvaW6fowWGOVz3i/74KuRl8+dWKhRFq5ysmoL802QGqLZHhMXL0O/z/s1zd9lyzk14Bc9r8NKu2OYXIs5sdmNdHLI6cAUhW6cKOccGRDyIP6kb75Cu5Nl9Kcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(66556008)(64756008)(186003)(66476007)(83380400001)(2906002)(33656002)(6506007)(66446008)(8936002)(76116006)(5660300002)(8676002)(66946007)(54906003)(36756003)(6512007)(86362001)(316002)(6486002)(478600001)(6916009)(53546011)(7416002)(71200400001)(26005)(4326008)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XSN9fTm1j3CijfkYgxRuqiIVEP1tOiW7K4sfZIfCcaddAfar5tWmlmuWkspM?=
 =?us-ascii?Q?OhvY950reFPuvRMVHTcKQGCOmOnaBy0+zIyDTCJW5w8MdodURdSV4Twinfkt?=
 =?us-ascii?Q?oRzZyAFrBBU8uUqs7nvx2F8Occ65tPN/u6PbyJvIhUCQCuMFzarjsQZYDY/o?=
 =?us-ascii?Q?D0q37YsprGA5P04YBhGocA1QHd5MKTEm6+K0atOG9sQciho30qCGOAx/WQ0R?=
 =?us-ascii?Q?IePGR5ihHjuCB/5aqlXYx5JGxnJkWrLaeZFER/dqEY0ZLJPWHUBdx7VCxMe+?=
 =?us-ascii?Q?HoDJLzWmlQlltfyWXz3lObLGSWw8PO9To8N/x0fTYEIfQ13BVaqJ0zNOXR7Q?=
 =?us-ascii?Q?5IFxvxvOX0hBpHAD5OeizxbqnKsdyhsMpfHQhp6F9TKrlhKy0p55UkXPaTO4?=
 =?us-ascii?Q?8of8fODY7rNNzfXGjylwbzIG8itSH+swO9xMCdQUwVCBixbYJMoqZd6rBH14?=
 =?us-ascii?Q?cW8femgoAwHD7c132w8tYN/9VANNQtgF9iMA07xNwC19HJnvhttNottV7uEs?=
 =?us-ascii?Q?jQvC4P2F72cP5ijD14S2fpg4KRU5I8Y7ZciHJs3jKitruELALre1/FQOksvI?=
 =?us-ascii?Q?C8JsewrYZOTcu71k8RyE7bw/8d0HWRUiu7fn2uKg8Fs+Z4ax6DEqwFJ9S9sP?=
 =?us-ascii?Q?VGel3ATk96WmuKZKRDkmWCBnFb52/yGjm+XxLXvTJr4x911HU2ONcWopzf7X?=
 =?us-ascii?Q?iekGWModH+r/Ax/SORJc5Qn60YPOJX3eXKO+e4atOvPxz0v1m2k6wIDsefLQ?=
 =?us-ascii?Q?HRyYWOzWs5rIzUJNdO6yRSkzazPxpf8P1jR8ArQpj1UvGLZ5r9W8eCGfG2Gu?=
 =?us-ascii?Q?VsgkgOAltoaEiu7bSrjWYLeMqYqi66F8VJzzuyWE1VcqZftlQcHv06yY1W37?=
 =?us-ascii?Q?JaTIWCInXvaU8WMu+6wg6MXzjluDogV2tOf2mduxERP2y4RauhsmAa43T1/6?=
 =?us-ascii?Q?93hZAsfcVT4X7tkEKXb1zqD+wcIFpyecmF01QrlHGSXISArdyrtb5QZh207k?=
 =?us-ascii?Q?G+2V83igCyb7GqTymwiP8g1W2T4Hz4LF7vQ/OPgvimjWJeHfyo3sMF3/lG9U?=
 =?us-ascii?Q?unCC9CwqtZSa3NN1tJX7Jc8+IHQwRTxD9l3/WhyF92bU6f8qywjb+XCA+aRL?=
 =?us-ascii?Q?t4gLZJ5tPdMT9eD3oNdgGP+fnJkvL5v72WEw/8B5O8C3x1QZBvrckftilCvU?=
 =?us-ascii?Q?1gVP8O2e4oEXlOnZUQNCNLrgmnLpJw03QocbY9JYpZr0JfDbi1K+cNFvGTZZ?=
 =?us-ascii?Q?aiw8QDXh2WO6GIFLQiNKlql8d8AGJoF6S+TfV/TGTfh50/F5LWg4KqFIhD+/?=
 =?us-ascii?Q?KhIyN/3V6HtwU7QhduG8YMcO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AFDF8ECAA403AD40AC358C22B7D2F7B8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944e52f7-cc78-483b-8e14-08d8d9b63830
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 17:53:12.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWWw1zKQVADCtNFopUOq2umYPIvazN0o8EGb1X4LkR0CgVQLEy0w8LtsD68uIUmYgw4JwTcrh6k+5nkqGAn9DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7644
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 25, 2021, at 9:32 AM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Thu, Feb 25, 2021 at 04:56:50PM +0000, Nadav Amit wrote:
>>=20
>>> On Feb 25, 2021, at 4:16 AM, Matthew Wilcox <willy@infradead.org> wrote=
:
>>>=20
>>> On Wed, Feb 24, 2021 at 11:29:04PM -0800, Nadav Amit wrote:
>>>> Just as applications can use prefetch instructions to overlap
>>>> computations and memory accesses, applications may want to overlap the
>>>> page-faults and compute or overlap the I/O accesses that are required
>>>> for page-faults of different pages.
>>>=20
>>> Isn't this madvise(MADV_WILLNEED)?
>>=20
>> Good point that I should have mentioned. In a way prefetch_page() a
>> combination of mincore() and MADV_WILLNEED.
>>=20
>> There are 4 main differences from MADV_WILLNEED:
>>=20
>> 1. Much lower invocation cost if the readahead is not needed: this allow=
s
>> to prefetch pages more abundantly.
>=20
> That seems like something that could be fixed in libc -- if we add a
> page prefetch vdso call, an application calling posix_madvise() could
> be implemented by calling this fast path.  Assuming the performance
> increase justifies this extra complexity.
>=20
>> 2. Return value: return value tells you whether the page is accessible.
>> This makes it usable for coroutines, for instance. In this regard the
>> call is more similar to mincore() than MADV_WILLNEED.
>=20
> I don't quite understand the programming model you're describing here.
>=20
>> 3. The PTEs are mapped if the pages are already present in the
>> swap/page-cache, preventing an additional page-fault just to map them.
>=20
> We could enhance madvise() to do this, no?
>=20
>> 4. Avoiding heavy-weight reclamation on low memory (this may need to
>> be selective, and can be integrated with MADV_WILLNEED).
>=20
> Likewise.
>=20
> I don't want to add a new Linux-specific call when there's already a
> POSIX interface that communicates the exact same thing.  The return
> value seems like the only problem.

I agree that this call does not have to be exposed to the application.

I am not sure there is a lot of extra complexity now, but obviously
some evaluations are needed.


