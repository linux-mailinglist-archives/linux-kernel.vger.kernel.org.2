Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5851E352AEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhDBNFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:05:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59698 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhDBNFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:05:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132D5Oar027190;
        Fri, 2 Apr 2021 13:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=buoOZVgPAS+QE4iOfrPemfh6nUyFohK8vWwhlhyjESM=;
 b=iPXXS56wY45SXQEmOorph+jWz4DTrqW5sv2IPLTgEXCVCfhIHWGiBQaQ/4v3oPUFoqzz
 BdfQLyLU/BoEUXNvUkvHYJC9mwMO5fgYZVZO6YZP9pkvyBvmHoWaMX7JvaXdpDXK7ZWN
 rtyMlYLruk9KYJlG4LE7LX6vpuOSW+YQEBISJr9GUKrMWAyUBIH+zkhhymE4qrm8li/o
 l2anuRr27tFpuDCTIBLodWn4s8WG4Dd4RyIwUWpGQz903AnIPe/lwqhu9gnY+40+4zVl
 gzCXOi5kCAoUjuldoui5x6buUUEkMO4P8eQqPV2n8dqWcnJ87V9qMnNpLTWO5YlS8IyH uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37n33dvjfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 13:05:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132Ctd1j026081;
        Fri, 2 Apr 2021 13:05:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 37n2au1grj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 13:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccJaz2iMvml/Rjtk5CCuMZLQvEOnUUTRcH2X2bvURzjy5md7EE2b9aGPlvHzPIQRuFOOXX+NuEIRAgxS/cvcmkoWeJhQE/ckYUDSIQ6z+rQjCFlVvb2A5DMMHIRAi6yGnyvMPQIczWhYeZnzoeQKsZ3jwTLzJbQ+TnQ06abYx4xzJnIiJz0MbPGktZYRkol0xXMnqfCG2ktK3juK0qzTn6W1EdEprlf8vlUGxNsqUJcVGT+0OSt0+5Cj9UGMa99qUCXVq3tOmWn10lzExKST3Y80E+oGD1rgH7o7NyOavvSvero+dvvn/3I9pVkx9eKxUeIyM/K2CLPKCjISPjBAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buoOZVgPAS+QE4iOfrPemfh6nUyFohK8vWwhlhyjESM=;
 b=ZDGFJxJZUZZZtPSnnYRsNOE43b7t/rCU5kZk4ElrOrCFUspIdMRSP5Fk06yh4K2Fgmp3m0JGK8dNtzRY+3L/zpXFyBeUBJcrCH8S4/BiZRjn/BhGB1+KO7ZLpeOOzkezzP533AX71z3Q9ixdA0FdR53YyWzqsy/JEhcvf2K/9T/brEoeRSp+XqZN02GUj4juTQXBD1QINBTAU3/dDg9nuZIu424uFZcceuCK/sQ+XM9IHiNkpjPh6cC+j3k7RdGAaB4wtcX/qOZm38kI1XXQnbFvB4e98Y3izd8S24A8/GdKKYcMaNAonr+KAl/UUZIfcMpn78c4/3xn8QD2AwNz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buoOZVgPAS+QE4iOfrPemfh6nUyFohK8vWwhlhyjESM=;
 b=QpYlbVchUZqqUFwrEG/zzJVYcZdzSV/fZc0HT3FoRVdGG5LecSWWpMjCxuLKzlLx7Le+xW2RFEbp9gVRx/0UzI5hFurIUvED7MYNU15WsgjdrOG8y60yPBVxWe7FQU4d+bSb+vha7JjiNn/BNYnpCBSjmNaINPQQhfEOSpbabho=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1405.namprd10.prod.outlook.com (2603:10b6:300:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 2 Apr
 2021 13:05:20 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::1ce7:260b:b004:c82c]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::1ce7:260b:b004:c82c%11]) with mapi id 15.20.3999.028; Fri, 2 Apr 2021
 13:05:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Michel Lespinasse <walken@google.com>
CC:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] alpha/kernel/traps: Use find_vma_intersection() in traps
 for setting si_code
Thread-Topic: [PATCH] alpha/kernel/traps: Use find_vma_intersection() in traps
 for setting si_code
Thread-Index: AQHXJzBzAo0LIIQ3IkiycclLKpCw2qqgG+qAgAEXVgA=
Date:   Fri, 2 Apr 2021 13:05:19 +0000
Message-ID: <20210402130512.h7vkbxdwn7errxmh@revolver>
References: <20210401195138.2895285-1-Liam.Howlett@Oracle.com>
 <CANN689GC8jXbzFb_HL-vpoBxuD4-By029=PMsi4Vs9ufik4RhQ@mail.gmail.com>
In-Reply-To: <CANN689GC8jXbzFb_HL-vpoBxuD4-By029=PMsi4Vs9ufik4RhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5599f55c-fccd-490c-2e8c-08d8f5d7f82a
x-ms-traffictypediagnostic: MWHPR10MB1405:
x-microsoft-antispam-prvs: <MWHPR10MB1405E2B975163DF4F2833D8CFD7A9@MWHPR10MB1405.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FvKhTreLDfwRfZVtDpdx7/XSQdy7kF40lBwDJ0CO+A4pQl64S1bxfoJjVhzrr8Is/e1QTWAwMtsZggmGw3Z9b8iv2SunDd3bLBZm5ovvaA1ZhZiQjgGiErEClXSCVQS4ggr3oSMBqm/cNXBbvYCYZcLhCvN8cqJ3HoE7BiSHTG6dpNn/BWGjIik0buIq1HaYir/neRBzyC1cDF52geSzkon2Ll/rYoX/HZDnXpQUno1Y3zEgpG7sKvC1lRvHbMXcEd2Zimz2Of4rCZDhUb6K/FRf5pNdxt0JhCETSYg1hyGuiy32qPhDXed111Lt6BTQg4X35lphyH7Up23ruuD1v17Dg0Wf7f6iwY0o7SWhAw7plVsF4ltaT0MWvsMjQQNsweINDWg6Pc2wO46/fvQKoWh84cJbqnsHI7iPxLiqll+DZ2Geyvvs+an8E3VWFgZu89f9TSTstGa6H67RGX8xpdvYNpi3vf7I6+DUMf3U2h+eGIKpsapMtWpqHrVk3H8qR+6xNwniO/l8dtMczxgt7kywQVLV0AjtJkhbAw8DwcuFCtRHukeqlxnmhZane1GSjyc/PCApYxc9I2Yv002S2sQk/RbNh0XjZprlukyTuNruCTAyt7uNICTWKuJpRcw8q4uQdFxzQX7c1DTOJYOoPKAqBapSkMSbHksnz44Z8Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(346002)(39860400002)(366004)(136003)(376002)(66446008)(8936002)(64756008)(6916009)(2906002)(8676002)(83380400001)(33716001)(1076003)(71200400001)(6486002)(91956017)(76116006)(44832011)(478600001)(66556008)(316002)(6506007)(26005)(66946007)(4326008)(186003)(38100700001)(6512007)(53546011)(9686003)(66476007)(54906003)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?X3osWBnabuAQz81gevoDwbCmStQz61bjYeT0W4k2LzmiX/o3ZB2bFaeqBFkW?=
 =?us-ascii?Q?s6N6ML5uI435pk4gS5Enn8a+onDLbdvEcSQOskvraAemq7J6jxp4duiSERja?=
 =?us-ascii?Q?s/GBbjMdpO16T6JnPb1biJ8HfSMCMEAOruer1VpLCPYwfLPtDJLGJHnvF2Xr?=
 =?us-ascii?Q?Y0zVyR47YURfhVO2F4M1BIaSchKKRX324MIJ8fm37Iw/uKUiFul+1/AuR2uM?=
 =?us-ascii?Q?ydhTbFD7lcCVWXkmXniLVXVolQofgx2m5EnkRrkiih8mg7U5qxGMH31JIyKm?=
 =?us-ascii?Q?ZT7AlKEMOXBHq5NJJQ946RA3RAcZVscvpITqvMLpi/GbkJTGchb1MhH5fMV6?=
 =?us-ascii?Q?RN370BuvC9G7BTXYAPsPXk9pnTOqClYGEWefe+kfuF/hbvbtv61LAXWUrbLU?=
 =?us-ascii?Q?DLCd6JodX8t2PUp63RktKQxJOVAWVe2Q4MDkLXrI0TxfNyA95XDKRu1SQ8vS?=
 =?us-ascii?Q?BKE1ETUruhRkx8TivgqZbwrr97F37QytzBK4cWBc8It/rrZjGPRSz/M5O68h?=
 =?us-ascii?Q?Bbfa2LO+U0AMekGUCKG7vQLjgsgW+6+yYabFpG6vfEG46Wjk9IJsrxBCnvfP?=
 =?us-ascii?Q?gFen5F9tidxBno9SP0s03AIaWp6T6du6esT14BeSdWSBDQMFHS3ewadCd+FO?=
 =?us-ascii?Q?OGoU5I1xZ+O8zuV5IfTD4NOmsL9ISGDUKcgLTZCY8PY2omEqbRXQmEWm8Lbc?=
 =?us-ascii?Q?NR7CFvuW14j3EmHoBNPpZcZrgqSakvMGOtmbR0RrbZtgoXINu4ScybxawNju?=
 =?us-ascii?Q?uR+Gwl4j70dkmoXakmo0Ddvd3zJcP+hhoEMErUJVnLipboxJiQwDjhf36lOW?=
 =?us-ascii?Q?YiU9h0pmNWNtbhkpbx2QsQuSd3VNMZBQT0G+OoHPV533b7lZaSStDKYWWwMk?=
 =?us-ascii?Q?yhBjm0fj6F+3vABD/bTwYNYRwzUuG5cS27giZg5Vda8NyNHxbdoUqb4SeQL3?=
 =?us-ascii?Q?ab1hqGwAAGdswKi+lHVVO8AzrT+BdTuyWwVOUb0tAQYDFlHuJY5bUvpqtkue?=
 =?us-ascii?Q?kYVzl/D/6zWvAKW+1Rj55ftsyRpzF67Ie530Z3IH8DOGPdjPzPeOaIRNghtN?=
 =?us-ascii?Q?FZiBjj0nfDhF89P261n6/YQC7MiE3oDvJKGd03jU9zYTmfh9Q9RqM1mSXGsv?=
 =?us-ascii?Q?nzGaAvwYWkg/kJc96az4Nis8cEGNy2Sb21aXuY5Zno4NUPt1XLlrg6JOBOXM?=
 =?us-ascii?Q?EwLKXVwGWSoPscX/BvJUJy6pJtjy1NGiAGpd4OJsbTQ3GkzI7ItH5ws1RVJ4?=
 =?us-ascii?Q?qyqpMsnxjQsxlUDfEauxPnyAU1Xi56DD0vtWWCqpNlYL0gjFroTYwaGeQfsY?=
 =?us-ascii?Q?hL3bAIzANlPxrNHu5+ycC6ty?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3BBC585AEB34A42B7676F9713D36C54@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5599f55c-fccd-490c-2e8c-08d8f5d7f82a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 13:05:20.1603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2z1rDcWeEOJdsTMOLLcnTGSJoiWxgQAHYWQTNBplVZa/xsw7SGJy2AC1zISWJZv7Zv6gnn8f+kMzs5avQZ0UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1405
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020094
X-Proofpoint-GUID: iACzCPP-LU7RORRBX_ox3vHk-DNRICO8
X-Proofpoint-ORIG-GUID: iACzCPP-LU7RORRBX_ox3vHk-DNRICO8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michel Lespinasse <walken@google.com> [210401 16:25]:
> You are correct that find_vma is insufficient for what's intended
> here, and that find_vma_intersection fixes it.
>=20
> I'll let the arch maintainers speak of what the consequences of the
> changed si_code would be - the bug has been here so long, that I would
> worry some userspace might have come to depend on it (the old "common
> law feature" issue).

Fair point.  Is this a valid concern given the result will vary,
although uncommon, based on the address passed in?  A user would see
different behaviour based on where the address lands in the virtual
address space.

>  Just a concern I have, with 0 evidence behind it, so I hope it turns
> out not to be an actual issue.
>=20
> Acked-by: Michel Lespinasse <walken@google.com>
>=20
> On Thu, Apr 1, 2021 at 12:51 PM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > find_vma() will continue to search upwards until the end of the virtual
> > memory space.  This means the si_code would almost never be set to
> > SEGV_MAPERR even when the address falls outside of any VMA.
> >
> > Using find_vma_intersection() allows for what is intended by only
> > returning a VMA if it falls within the range provided, in this case a
> > window of 1.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  arch/alpha/kernel/traps.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
> > index 921d4b6e4d95..7f51386c06d0 100644
> > --- a/arch/alpha/kernel/traps.c
> > +++ b/arch/alpha/kernel/traps.c
> > @@ -957,8 +957,10 @@ do_entUnaUser(void __user * va, unsigned long opco=
de,
> >                 si_code =3D SEGV_ACCERR;
> >         else {
> >                 struct mm_struct *mm =3D current->mm;
> > +               unsigned long addr =3D (unsigned long)va;
> > +
> >                 mmap_read_lock(mm);
> > -               if (find_vma(mm, (unsigned long)va))
> > +               if (find_vma_intersection(mm, addr, addr + 1))
> >                         si_code =3D SEGV_ACCERR;
> >                 else
> >                         si_code =3D SEGV_MAPERR;
> > --
> > 2.30.0
>=20
>=20
>=20
> --=20
> Michel "Walken" Lespinasse
> A program is never fully debugged until the last user dies.=
