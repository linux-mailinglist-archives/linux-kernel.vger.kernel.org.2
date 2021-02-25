Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D543325426
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhBYQ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:58:04 -0500
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:29657
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233571AbhBYQ5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:57:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+LJ9zBqebHFnkylsGfQpXQCcVNircrS4IMO+MZU9GrqOwEOVrJnMQ7Ml5CLE/S01YU4yENpV+eQmSEKVVZWuLh7zSXotKWPP3Z59cqMMeImP8sRtWMWt5x0P/AP0yo/wVqUtNlrDZu3cLQnGLHbvSiAEnAzh3YA9F052GISHMcVELFVPDW2M8lUjGWjlQ+L/KiPFNiXIxCLbUK930yTLejdV6oGyLg7/7RSHdHkE1VRif+8BCBQrV7zyugrUM001Xn7bR8v2ZGEfBroAoTWbIyZxMMoI5e1Ysv94Yi9D0haPtRzidrx1FmNqhf6SGcklGiIIc9j8OrqoHXrV7TKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiDfDjVJJo5i/qCCmbZ4Iq39ZBFCrc0U0/0wUgqMw9M=;
 b=KUZ/2bKP4gRfd5Hz+Wz+HQa/LTa1XRtU5X4RwWtDlqJZic5r6KHD7MFnJBj2XNLnRxwdw3twq8zy5tqBcIWFSn68QjKcbKC5nUhYmoNlQdLW2Gatov1rv+077x8xXfP3uJ0fjGLhNsBj28Ye3Hnx3IIGe1vXjKH/ZxoOboYi09K0mS7x4d/exSFvyvK0/hvohwEXCTHc8rjQB1Ruogge4avbnsi0HmP+MAjkj3L0bLu9p+F2kQfbQ5nmzRLDlUXZCkKJSiSIc8MHacCPkBR4QlFbkRM++6l4BiVvjfuRfbuVJDHneqghrXjhveT1Mh9uik9KdF735+eCfzNpu/oazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiDfDjVJJo5i/qCCmbZ4Iq39ZBFCrc0U0/0wUgqMw9M=;
 b=Ocoz3uNLYvPOfG/87xgjZEdixzeAnBqZRHemEGod0NzkjkhTY30wvgqOZ95R6cUVqnJ5woTqjHvI3h3eV6SL/YJCgXYEQYa87WpPMDNXvdU1jgSK1axi2VfrUJaIDndef8B6qH+FkBOuocHAOBWzSY+PAdEo7q8XZHJ2b9/HW6o=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BY3PR05MB7924.namprd05.prod.outlook.com (2603:10b6:a03:36a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9; Thu, 25 Feb
 2021 16:56:50 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5905:ca03:9fa3:ab50]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5905:ca03:9fa3:ab50%6]) with mapi id 15.20.3890.013; Thu, 25 Feb 2021
 16:56:50 +0000
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
Thread-Index: AQHXC3A3AKdXDDevAkSbJ7drCRkvXKppF4sA
Date:   Thu, 25 Feb 2021 16:56:50 +0000
Message-ID: <0EFCDB0B-DB73-4866-9C0B-7192737CA372@vmware.com>
References: <20210225072910.2811795-1-namit@vmware.com>
 <20210225121645.GZ2858050@casper.infradead.org>
In-Reply-To: <20210225121645.GZ2858050@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be9c9736-9933-4cfa-fb67-08d8d9ae58b5
x-ms-traffictypediagnostic: BY3PR05MB7924:
x-microsoft-antispam-prvs: <BY3PR05MB7924015E29AC83CB9AEB745AD09E9@BY3PR05MB7924.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /JUsXlDF9jIwydoVYHMDTtOwEWTFXL+icvozYDjAf3eBPrCL54AvQW5RxdUW8sArbY0sjrTgA9zTHo/DPCUBnmltLe/PSUJDEjvZDJu3gLxucDLDsqAYcsna24MDGdUDvpH/E5t9OmmPJxCMjSM0y/snlx5CgsyAvDg0MTZjGKuP8b1aQ5QZgR+D7u7wbN3Di8QgmG0oXw1y5LK8el/YLsmPu/PzvHNGZV0PCsJAkeq7ghbEEQzSKGqQVTb6QTN5QQpvlBrlLqy3OJyxy2toqg3diqShtYeGknn4P1jPWCEcLaZABy10Y/LGUQ+hziUBln3b5YICJ48/rKLm7VBaxQaYjbILckVOCUb9OnlOJgQPeeZ+vourzeYVJmakQrVMGONvlCZ133dHhQvm851dyMoyJno9d/rQB9wfveD1Kdy6abi0/sUFk+zcSLQBGV+NtjnSVIe9WJ5mJC10ffR0bhfleuCPrL5Dxc6YPVGmmdbTtznnCoQnXUUUEot3Ulyga/dp7c7KS7T/rd1cijl++BSoGOUIRbugFUzV43I7A7rj36vxq/6GQbx7bJVmqG+crT9w5Arzcif4SxzDquNsUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(64756008)(6486002)(316002)(54906003)(76116006)(36756003)(7416002)(66556008)(2616005)(66476007)(86362001)(66946007)(83380400001)(8676002)(478600001)(66446008)(33656002)(2906002)(8936002)(186003)(6506007)(53546011)(71200400001)(26005)(4326008)(6916009)(6512007)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6OJpPyBboeAuiY5AT4vDhWr3hGXfZXt9raBfMNBX0fX0xGQsZBwJLG4p0EFz?=
 =?us-ascii?Q?vh7wefMQ2D3TjrN715iTqO2Qkd5QuOpqXCGCM8ri4FQGT4zZksOOX2vQw22Q?=
 =?us-ascii?Q?eVdTUenys1k/FQ1D+qWgWdU1Eky4j8tFXh7x4dDSZmop3ZP25STRLynAruMB?=
 =?us-ascii?Q?c4LTOLazRM3D26MvEIEPUvhizCwMFGanWYrQ/gvrYucy3niuAGRJasKDvA1u?=
 =?us-ascii?Q?L3Ua6ozcPBaEagA8A+gDBQi09WcxzW0tPaviO/7cBQv02ORUQGvxapwcv84n?=
 =?us-ascii?Q?R1BlQhtBTv6Qg0iE2IX7tZ1IxZvhCBuLnhvzq/1Vr70lUEgRC3AJp6i47APW?=
 =?us-ascii?Q?Cj3774G3UOlzOYQmTM779R5lomJ4X/bZGxNaZvZrwHgEGow5MLQb1OMhqknj?=
 =?us-ascii?Q?PauxpHHBD54VSxaiOKxVH5TM9JzaHpnSwIQsubnscSUB/SDo5BEr1jE9Sxjk?=
 =?us-ascii?Q?iPs/CwUmV3poDQ6hWaO9XsAIgJJi4kpNjOoROTmj5Q7Fnv+JxtaHtdcB0x2l?=
 =?us-ascii?Q?8dyFPA1aXbhz49KFcioI2k8XhcZQBS99Cxs6MOjvuAuACHEZTIZZW3EExDUj?=
 =?us-ascii?Q?Tvv0eTXIAt+rTDAucSer6T0IU44pJiVvK5XU/nVOYeZ53+fPRBqdzL4WehWH?=
 =?us-ascii?Q?WBUGdrLgz3kolFqHbZpAaZYl0EsXSekO4YgsNWYWf90Q4uVqqD/srQKXxD/3?=
 =?us-ascii?Q?3osK96EhXZ8+CD0boNFieLBbNILvmoGAh+JAwuB2SCy0H6wjT4Ea4mMSGUO9?=
 =?us-ascii?Q?xEG6MneIG0DkjQjI8XHLmtaiQ9noXT9bRJ9+uR+UbzZrBuUAE3vMkQQ7+SQC?=
 =?us-ascii?Q?nRfe88hFXukwQzkzdo38GMyRAo8E583OQLHXjSUuNduQ4KqoxotiOgeQCsob?=
 =?us-ascii?Q?98p5Gh5kU2L2BGLqJqdpS8xlPRlk5tskAOI2ZHAX10w/SrXXsiC93PdYy9eY?=
 =?us-ascii?Q?WlJmLeRWU5/jdenFBa4gaybPjacH3x9KY/MOln+GFOnf9Ozk9NhGQ5M7OW3R?=
 =?us-ascii?Q?gjh/5XeUWfDLxzO3Ul2yCNpZVWs2layvgzkRWLm+qTVYPL/RjxkhJqhB+Epo?=
 =?us-ascii?Q?FQLVEPQ06sEUNkDMPvrHbJiTgIg4M+n4+Sn/yYM2GekLNcBQG2ddXeVnOfaC?=
 =?us-ascii?Q?4tTa/BX05BxyfaLnYi7MOkbtIstpDtQuBcEICNI4DfL2nXYeQZ9XaJxtJCG2?=
 =?us-ascii?Q?DGP69TCu4gMv30efmoJsd999lHdvyLkA1nwl4YcuYC1aTWFBZfgRtJL3YQJo?=
 =?us-ascii?Q?cGpKuFFbWR9s4E6gPDlzMCiXIk0FPGsdh4YhbBhZd7YAMlwiztLBMkOJJlSx?=
 =?us-ascii?Q?/BtYoJoi30IMDKcn3z9arb+7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F743D2DEF9C354A8862524DF44CAAC7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9c9736-9933-4cfa-fb67-08d8d9ae58b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 16:56:50.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n41uTDbcHptRe3g58icljdoWFdGyqMnCfyFKBSvhs46tUt4By7x75nlq2I3imd5DyP+lYR+gb2wdE9Knt8r4Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB7924
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 25, 2021, at 4:16 AM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Wed, Feb 24, 2021 at 11:29:04PM -0800, Nadav Amit wrote:
>> Just as applications can use prefetch instructions to overlap
>> computations and memory accesses, applications may want to overlap the
>> page-faults and compute or overlap the I/O accesses that are required
>> for page-faults of different pages.
>=20
> Isn't this madvise(MADV_WILLNEED)?

Good point that I should have mentioned. In a way prefetch_page() a
combination of mincore() and MADV_WILLNEED.

There are 4 main differences from MADV_WILLNEED:

1. Much lower invocation cost if the readahead is not needed: this allows
to prefetch pages more abundantly.

2. Return value: return value tells you whether the page is accessible.
This makes it usable for coroutines, for instance. In this regard the
call is more similar to mincore() than MADV_WILLNEED.

3. The PTEs are mapped if the pages are already present in the
swap/page-cache, preventing an additional page-fault just to map them.

4. Avoiding heavy-weight reclamation on low memory (this may need to
be selective, and can be integrated with MADV_WILLNEED).


