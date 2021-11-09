Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C98444B27E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 19:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbhKISNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 13:13:02 -0500
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:9280
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230383AbhKISM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:12:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdoDegRv4Stx0bUw737tvavquzFkojsJBp90pTQjGTazBc2stjkzXYqLB7m7T/vsaxcTwgD/gyLGih7v+HiLJQ7jAQ4sSFiRr+4K0HNf4Nq6TtJS5U6Vh3JIOiy4EfDZzezIvSDkx6os7oQNmvEn2HFGgFUcSMvo7VZDuvMDtwRFMxLihTfRvq0H2DDinudCr8VlaPi/TGE1HxUncnnDkzOYv/8qnBoyFrB5oer2LEV6aofZa/AZmMxG6dpzUb7VcqFSFgw11UIGUdmKR8bBCQ1NmEEfJrh2GO354Jel3Vytbw79vQv8d/G8W07JKUPmdljkwJdrQmwbJk3clRpddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQduVk1jW9z5lWC7Ns/Nfqfkovg9w7f5zov7IM+Cz2o=;
 b=HB5RG4ePbGDvuEx3bIAsdra5IRxGOTB00OET/v0Ix7hp4BASGkGs1I6nT3iO88cApSecVX09m6NekCoIvnjGVVYzg6VqAmHdoHZOe2eG2w1maGQfoRslPA+F+RiS4HAOViz1v891w5gEos/CQc9HomhZRIHWPkspZ/5ihJ1StB6FxM9cEZTvrGS8+QdTSQ5QSrhT7IuPMnlLSwIxIRNW29iDBRUUu/pqT+3hWaXLfyjJ2BqIhROwwSOv/SQVBUzIgD1QrXg/eJsTqpU+5fXBmA0NHgHPcTJzoTgBccJuWHUIQs3kv5VTDFjz7HHiW2WTU5x0yB7qFJ/CI1Gb3cxAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQduVk1jW9z5lWC7Ns/Nfqfkovg9w7f5zov7IM+Cz2o=;
 b=O5TtonVuWyvBdqWbiozwImVZ8t5G4zydMdYmlsb6M+GNUYalwIgbjKHPEKh3uv/kfDwis+QfemtLZYOxaTdTiMwhxRjGZVTesv1wNYbDZyFFBwwmzowTjNBmadwqDXbaNQuC3IlhuFzFYLPUxuWdkI1GNs2XyuHJb6BQNdbH9ybWwj6fIG/XFjgaYxkjY8vvLWNCcq5KqJaKJwU1F3tuygh5OJdQ02pMcf/u8+/vdIQJHdPT/vL+rzLzQ+0e3mqm3tTdmaiTE7HT1xkVDOCPYbNsLwpXdeUcbkH0BHUCrSib14iEbHMuPQc6Mvhr4irh2pCggCVX4X/dDerqEzX/cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB2337.namprd12.prod.outlook.com (2603:10b6:207:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 18:10:09 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::dc47:e67:877f:f19e%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 18:10:09 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: migrate: Fix the return value of migrate_pages()
Date:   Tue, 09 Nov 2021 13:10:04 -0500
X-Mailer: MailMate (1.14r5844)
Message-ID: <4A56EBD2-A839-44F2-8C7A-11C8058AD685@nvidia.com>
In-Reply-To: <6486fabc3e8c66ff613e150af25e89b3147977a6.1636275127.git.baolin.wang@linux.alibaba.com>
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
 <6486fabc3e8c66ff613e150af25e89b3147977a6.1636275127.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C5B8A2F1-1E00-4D0A-BF3F-BE6B09D50CD1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::22) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
Received: from [10.2.61.62] (216.228.112.21) by MN2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:208:1a0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 18:10:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79c05c1d-5099-4238-0410-08d9a3ac2a79
X-MS-TrafficTypeDiagnostic: BL0PR12MB2337:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2337BEA9EAF128F72F4CB1C3C2929@BL0PR12MB2337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QrpI6Ic3ibSvphSQ71gfKMcQ6gbNSGq1e94Q9fSVXZsXPct96KxYzDsmHLM72QbKHQ38Q8WAvgqQr5BAQWXEJcB6P6kV0GlRXRF2JUasOA9MSK2dRroJjrtYXES8XOvdWgK1NsbKpN/a2lp0BeAlw4WCVg+2izCGA5+S4mhM7+YRHSKkRVADzz9BtEvMgLLLt8cGKT/Mjt8qjWM+/BTfm+IihWsLPtuZDhpw6Y5LHxnpfKRvz5XQ5ZgoETYS5f+SJcO22Y5dJ5Xo5I2udhTE4xzv4JifM+qqf20fMe5kjcl7GU0WOcz6qfaf3HxWvMQI6McWfrHEFIVTeZyFgO2fAQs7sbqRu7dVZspTmq6BNzi0387SevsZsG7O6pV5ZgqppO2QF1PpDsGIybe24oALZMXa1/CkkrU2yL+Llkr0L1t+mnDm2pFlDHzoP0WQQwmeAccSP6MGNiVJoUd+ayxTUs166e0tjFUwH84RxxVv+CO3+MfGHiIh6qe6rtRgvxsrinmU/X12k59hN/v2rWuI0lPsJV/RAeT8MCAxcUghpTVFeZFk7IE7WfHv447KVS29zOzwqRm0ad7BfcODPXEjedcN0Nz3YDbkLHt5tbiWqPFCJheKAEHJLJjPNpzcA0YU+Cnvc5O/DoMYEPK/jj5ohfDJCdIQHG67HOL902G95q4VK1tBBq0fCRpRn8X8g3EZJa6wD5PDVnF7je7RD/aGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(66556008)(21480400003)(2906002)(316002)(6666004)(16576012)(86362001)(66476007)(38100700002)(2616005)(956004)(66946007)(8936002)(235185007)(5660300002)(186003)(26005)(8676002)(53546011)(36756003)(33656002)(6916009)(508600001)(4326008)(6486002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNBDZQllKeOs5VgbwDl6y64M3ZrTpNqgll8ajIR0pveIfl+BTqM1mduht3Kw?=
 =?us-ascii?Q?NaYchxSgrPILQbIL59kexcbLDlKXfl02u7kvB6eUgB3u0VRUFT80Cd3IUMCA?=
 =?us-ascii?Q?yId0y9S429aD4/NwEQ85SqkJhi5tiPZKWfG28PLj5GBe6iNBZit5rg8ugALx?=
 =?us-ascii?Q?PSsKDNEi5BsjnMIiWh5cP03LT137gjfxbHbQc3OCz4hzDWoBJYGZegxw8zXn?=
 =?us-ascii?Q?G0wHFeOQmVCpZGw4YUsNC8+zWyq9XHLHwLaFSpR+itKszFQa9eDKJq5/hyMX?=
 =?us-ascii?Q?iuvOAY/YC7TCOtP00SiDz4cRXlEYeEfgSBq96CtTBMsZ16L1W2Owknx6JDlW?=
 =?us-ascii?Q?CpuwZiG3fy9vVvhhXceX/yiyTdRPBwcQqgGQaBLT1TI5/T+1aZrvSUyMdNen?=
 =?us-ascii?Q?TDYlxUB00unzZSVcQC0pGx+dm3Zy/+6fa4dZV7QpV6UM73J9WLviq5goo8gi?=
 =?us-ascii?Q?g+UgxX2I7HoqBsuPv9bFJQbDBWYp/jTG2+2YtF3y1AKG1DLKrJMOjMVI5GKX?=
 =?us-ascii?Q?Rw5WjMy9crmeUslQWqLTwJzYULzM9VU8Dm42AaSFrBbkCv+LLA9yFiyCtmFa?=
 =?us-ascii?Q?wpC7n5mTCOuAklwK+U+JMrMM1YvSxwmxJ63fi7ptXPWixTCBCLC/WsvGQeF6?=
 =?us-ascii?Q?8Vsd9O3wxXI42J+Xfn55q3pVawQIBnovMqDMziuNT066hbLt8u1XkkR0X7fs?=
 =?us-ascii?Q?tArMv/ziDk7URiYDDbpNwe0UQFsg3cBRWK0/QEhDLfML++yP3ZxNwm3PIiMG?=
 =?us-ascii?Q?OCR3msJCFTtelnO5OOi6NK8ErncgrmZ3AzCjl+CXdrNEKxFx2RlSKncIkg4L?=
 =?us-ascii?Q?JwX/ymRo6dGrO64+SqRJ3pZLW1NAh2AQPrJpZHq6kqGRpY0hSHHJU86qMyq1?=
 =?us-ascii?Q?hHjTMQEHt+OeMa2ZcPJZapmIxcUr1Ls/fwNdqueVaZgXKO40i+Hv5L1qfSt4?=
 =?us-ascii?Q?gXajyOD2nhkGuHZOxR+6sdAgDaoaVJtxqaZ/69GCH1XhqiIYzdK3cOE1/ChG?=
 =?us-ascii?Q?xakHn2bJFBUEsKLPgPBRTZfL/h58SFNXpxmm/ImKQG3vBMP+rhzmHj7YsTE4?=
 =?us-ascii?Q?UVGP57R4J0EhnmBKlXOy4AoC2foSOXMCxYEOGLHsmly4YdOQoYpuAz2G8l4j?=
 =?us-ascii?Q?GmqYSE9A8tefu3Z0cyjSJJTt8+q5W9VAP3jIyLPauWAL5TB793YgwomVmeOt?=
 =?us-ascii?Q?lyX/vDTydF/ALsjJg/Mr4dDQmfPsiFr/M1SDh+hM4KHnQlk/Ke9qaEG505J5?=
 =?us-ascii?Q?EKnnHklFrMysBnBWlNROameDxc3tg+WJn5xMz9+zPTlq3i+XTgO5B5rvTM9F?=
 =?us-ascii?Q?05VzgTlo5rlcMdNz/TJwypz2RI96x1myAV66+g5fsjuNUI5N48nWD6reJdhN?=
 =?us-ascii?Q?gzbx7BHryQAuBbopd8nrvgOpUlv/WpxI1u1MtQor0ekNemFeKgtdKhy77Pu8?=
 =?us-ascii?Q?GqQPcdNrsx5oyzH+jxuax12kKJGgc1nPv0u2UzVhPLZcOk6l0OXQqP8RcRsr?=
 =?us-ascii?Q?/lO3F9a4B2KUoPkWAlcl3ZWgDYOnc1UCN+mXBU5AgAc29Fjj4KJvhWwN7u6e?=
 =?us-ascii?Q?M1nMVNQcteyfqN7TP3M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c05c1d-5099-4238-0410-08d9a3ac2a79
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 18:10:09.3501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtwO1OZ358jQ+R+DKqPK5La4k96wni/LzOgAzvjOmo8h0t77bDa3DzzbsWNVzbbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2337
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C5B8A2F1-1E00-4D0A-BF3F-BE6B09D50CD1_=
Content-Type: text/plain

On 7 Nov 2021, at 3:57, Baolin Wang wrote:

> As Zi Yan pointed out, the syscall move_pages() can return a non-migrated
> number larger than the number of pages the users tried to migrate, when a
> THP page is failed to migrate. This is confusing for users.
>
> Since other migration scenarios do not care about the actual non-migrated
> number of pages except the memory compaction migration which will fix in
> following patch. Thus we can change the return value to return the number
> of {normal page, THP, hugetlb} instead to avoid this issue, and the number
> of THP splits will be considered as the number of non-migrated THP, no matter
> how many subpages of the THP are migrated successfully. Meanwhile we should
> still keep the migration counters using the number of normal pages.
>
> Co-developed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/migrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 16 deletions(-)

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_C5B8A2F1-1E00-4D0A-BF3F-BE6B09D50CD1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmGKuXwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK870QAKZ1bePaxzWpQPw2jrlNO2+XyBaKP4c7uZX4
Ji1m5+GD9Ko5971WtcFZiHC4tQvqKnKBHt00IjvN3buxXRJYflXCrW7YUbsPRq4d
2Th2RB1ipxcCDkIiKuzlVa1BLAJ0/FihmT6qQKnXDnKjPS4Nj6AY9/shQpOoc7rL
Rfs6pN89N/skNGpraUn/Cs1N6P3Qa+SimlcbUluVosuP0v+aHCwQdMkoklhWPw54
GcIvCduTlIb1eWg6JhaR1FKOhw0BtyW046VWAA78h82gq03ohk9QYdsUk4aw3170
g2IPWvsyHB1TcBIzT85liQCBxRlmY+dUyDtYrtWpTLoeVVRnzw0mVUC5h4gyVitz
p2OjOIifAS6ra3UN1skA3I71xlZs6Aq5oslz0s/lVD+JHJRfvROdRIQkWEJSi4d6
HDLkOt4+m2CGKspadSCIhoIEz0oPLIuhQ9UenDgpZpxcRbsrh/MMQE4MBnSJStTT
rKKjva3VWAW5lbKjTnYv1jQu5kwreC50kLsSNWoQW65d0EOP+CPrfzbLp8LZYcNm
VX2kruV9wYS+k98hp2pXqfIkeTi7tMLz9bJ2VAtKNnxonh6TcOQ5NW0nLWyV4Wz1
ZpcQqCgcwi/a3riwc58srxysZ8uaoYB6oJlKsDvCqS0ZoESaaKagFQaRVLYNUmv1
oZQ1do5q
=IzCt
-----END PGP SIGNATURE-----

--=_MailMate_C5B8A2F1-1E00-4D0A-BF3F-BE6B09D50CD1_=--
