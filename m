Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C676D309993
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhAaBJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:09:10 -0500
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:7136
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232426AbhAaBJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:09:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5KE2pd6bV866idVs07G15LHUVpMpIKqeV0E9x+mygmIhrjKJouWKOFI9VcHo6f8hXKqpX0KH2gPHCZO+cJwSeF1eXokh1e0uy2LD++zzg/4ahZtlB3V1ah5k83fyKoLj1urtxRweXPtXraOAS0spwJgc+QaRrN41IqTqMy2+UJ57f/IBWNAXV9jfX9XSlCqwE0r0mSPaT+2WD+x9+UW3A2nppJLz8p8i3TGIMNa59zkiv8X97msiopTLiasf57EhmVGCSLVG+EPKNMyVDGdXHHX9E/IMhaknMRUP84sSPi25VqB76rX2hM7gN5+g7iMvMcBDG1OpCHy/1L41nzQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeJkiYDSgrlbBThNhYBCElOsz2nOzxSlUWMGJsv0CXg=;
 b=YiD4IIvWcXQ169bKTBQJIhOQ01Swvm5x3rVMTvSeqqqOan4urSHvaNzIOXrdJMCdi7pTl93Isy60X7WCLDKtS4UvIgfRs+tfGNdXBqyyMcWmyUVJ4Vy9tevpqaK+UbnPbCcMEGC/HNCiZlSEeCuZUHPYvijrr5TvEGzZ2DjfzaGyDK2eZwe0o99A1LzkYuvGCYsyQH5JJevjn7AmKfqXEAGYrwxr1cSoXDEuptZR4ga3x/pIvHuQElVtOJ1w59rogWam0c/G50fbtvp0a/mxtMlYEHRxljoloj7hBY37/A27jT40S0FC0BUEgPL17DfPX9U3jU6D8LQ8YiuMRniRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeJkiYDSgrlbBThNhYBCElOsz2nOzxSlUWMGJsv0CXg=;
 b=hHkpPl+UrIzirqsxPohzLZaOT7Js5wlbs+0XyofHdrVI0k+z2d8HgkZ7AqjsE+ve4aFY4ZzqO559WaNVuUF/A8a7qT65kbms7E+9FthmLZllHf83K3Qm+WC8RppLRgXUzAbBuigXTNnYRuatOUo1prwMUmR77YKlMRwPns0D1Wg=
Received: from (2603:10b6:a03:4a::18) by
 BY5PR05MB6946.namprd05.prod.outlook.com (2603:10b6:a03:1b9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8; Sun, 31 Jan
 2021 01:08:09 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::ddba:e1e9:fde7:3b31%3]) with mapi id 15.20.3825.013; Sun, 31 Jan 2021
 01:08:08 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
Thread-Topic: [RFC 00/20] TLB batching consolidation and enhancements
Thread-Index: AQHW92mbkHab1jM8X0i2qMdyfVtqSqpA7D6A
Date:   Sun, 31 Jan 2021 01:08:08 +0000
Message-ID: <34961389-0BFD-4F30-84AF-FB2FE5B07949@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <CALCETrUUe_iijSoTYMjibqxUveaYrG3sVTWawbi3HWCjx_ySYg@mail.gmail.com>
In-Reply-To: <CALCETrUUe_iijSoTYMjibqxUveaYrG3sVTWawbi3HWCjx_ySYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 743af646-e537-4a42-89fc-08d8c584ac3d
x-ms-traffictypediagnostic: BY5PR05MB6946:
x-microsoft-antispam-prvs: <BY5PR05MB6946125A7DB1DE9DB7E51EAED0B79@BY5PR05MB6946.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 91w9ftgxKCU54XlggM6fwG+Mdj4vg+KshClDoPk37Rsspvalr7RNADWPRv4lBTws4IWxA47RYt4hJOaKmA+zbuveVrD+CFzbmtbRnR4EK110Ek5A978837HrZgWfiDoFGB3jtOQqi8QNfXt2GUluplutl/ExBfgTWI15gsFa8fuPtbdJnKfpmKGpsOpMA7hWGWglC60q9LyPUZAspOcTgjEU+DBhT425PNOiw73VbA+plm5+7Il2cAV2x9ul1hD5gmb5/FmJRfdpVuJDB5MBtZuKdyN5IiKHP76RYsrPnDSO6JOHzOC9KW+2AVT3BOKnZjOwjhu9phjUU8lWRWXLDHnnnUDxZGYJxtiOg5roXVMtrheD8Bem2n7Am/KoQv/6itr+D7wlkLTCebJBzpJsqQwz8LmzwNGeZOfTehSZcgnxjPfqc3QWh0UZgIz+B2rXEQ/hWTHizKnc/JYEQHqeq4Zo2Ilcu6LZLAplVEV3T/Wtj0zSsNzukURb8Uuv+qX8oHftkwy6lJ6B/yMzQkUPluSSS8kM8c35CLwZukanT4XZKiQNiz89J3aZco3ISrvEuPT/H38ISgJlhVegJbZnsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(346002)(366004)(376002)(86362001)(26005)(71200400001)(53546011)(2906002)(4326008)(186003)(76116006)(66476007)(8936002)(64756008)(66556008)(478600001)(66946007)(66446008)(83380400001)(6486002)(36756003)(33656002)(2616005)(316002)(54906003)(7416002)(5660300002)(6916009)(8676002)(6506007)(4744005)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dsO5J0O1HHYlXhfooRraUkTGqeF4IL5HRlw5dY4InhLHhCweArnXdWNjAdc3?=
 =?us-ascii?Q?i51wL4ZSUxFtznSGzficp7TbtqQYIRr/PgiYSOHTMfpYYhbKH32r3Ahji0dX?=
 =?us-ascii?Q?xhpxamz8n3haOAIVQFN/VoxaQ256H/b+upwz9qZjHi5DK/Hv29Ns9l26yJ3s?=
 =?us-ascii?Q?boFCTlxXyio5A6VDdphIr4tfRJhRWDlwZTMkgRHMgnHAkASMYvuAHFUNwmaz?=
 =?us-ascii?Q?wQ97qK1ipalTrwoTs3ZwgUYu610AyP3kuzBKdQBtdCvX/ODxehW8xZ7L/Gdn?=
 =?us-ascii?Q?fIXooKklRTLObqHEbmPWdtpRUqUYihTXauwWLXD8OF5DLxL4sjpTEJUs+eIe?=
 =?us-ascii?Q?eStfFAoC3mUEBNX8vKFslYPa0XakJwQIyTf98Dt6VDnQjRK40rLKdGCB0MVL?=
 =?us-ascii?Q?qSWbomrh5lzCdQ1D6zb5c+rrudOZ7hJQKgjiav/ZErrCJTZ4wqh4DqwuxPdi?=
 =?us-ascii?Q?MY3h8UqUPgNUmXay6vLeKhv2CZ1Qivciaect7u8KLijHtBsjKUYlR04apZa5?=
 =?us-ascii?Q?AsjminrFpbaDRrq+gWcllnTVqXdQi+1QmO/qPlXr2I194LEz/b+sN0U0++ZU?=
 =?us-ascii?Q?sthnNsVP8M89bv4e7lrMulGNN75KKez8+i1500AhvHff14WD4zQG2OysGjMz?=
 =?us-ascii?Q?IpckKNpUUdmArk2YB2lygYWbCPh/NWS5S14YPtY+pW/m/IPEG6b1Ctx4zqXm?=
 =?us-ascii?Q?p76yRoGv+Rk8MLmeFbw4BybcZF8C97RyEXWrEief86DrTQ7j6VlY6lR8JbJz?=
 =?us-ascii?Q?Fyyxxm4lM9TPlu321td3B8whZz9ybA2H+sIUKIxyG0HRAWmrhylkuOormrh9?=
 =?us-ascii?Q?fEji08V1fqLtYTkkEVCbiFc9Ru5aZTcvUlGKrS1BvQUEjMHSEIEoIKkLvCry?=
 =?us-ascii?Q?BaJI27FM9E3lXsxR5iFkjXdXb3mkumwpQvChzxcyUeUy0Xcn7mRkRmt0HAu/?=
 =?us-ascii?Q?92ZkvU3/DiS6PIGLathVIEGb5+d9XU062BoAGbFNp6RvgAShMC+YXHUISdSr?=
 =?us-ascii?Q?GNhGPJx+PdCiOqR+IHDlIX8I3JSNcNzG6TNnsoKVC0aEpJrFQNk8quAdue1O?=
 =?us-ascii?Q?n601Q0a8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1C9C8C367CECB4EB7C409D0F1B224C1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743af646-e537-4a42-89fc-08d8c584ac3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2021 01:08:08.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7pTJh0NE5BMBqhV7JlNTeh/zZORpfn+UBaDJV00utz1Es3CRfu9f+OCscqjmk7BuewCXgkd+KGTOL/wb1fRTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB6946
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 30, 2021, at 4:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Sat, Jan 30, 2021 at 4:16 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> There are currently (at least?) 5 different TLB batching schemes in the
>> kernel:
>>=20
>> 1. Using mmu_gather (e.g., zap_page_range()).
>>=20
>> 2. Using {inc|dec}_tlb_flush_pending() to inform other threads on the
>>   ongoing deferred TLB flush and flushing the entire range eventually
>>   (e.g., change_protection_range()).
>>=20
>> 3. arch_{enter|leave}_lazy_mmu_mode() for sparc and powerpc (and Xen?).
>>=20
>> 4. Batching per-table flushes (move_ptes()).
>>=20
>> 5. By setting a flag on that a deferred TLB flush operation takes place,
>>   flushing when (try_to_unmap_one() on x86).
>=20
> Are you referring to the arch_tlbbatch_add_mm/flush mechanism?

Yes.
