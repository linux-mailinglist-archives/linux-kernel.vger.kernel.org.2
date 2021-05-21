Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78E238CCF6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbhEUSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:10:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52138 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbhEUSKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:10:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHtaJd141319;
        Fri, 21 May 2021 18:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kyAQIKPhqxYfhSOCvx3Wsw02fV26KWmtoE21zkJb+y4=;
 b=sLuZ+fz3AggX4/Ji8CsvufKf2mXdLEBWQQZaKxDuwZpIFos2nvSwe0ySz8y1gHBLEu8y
 QBoY2Y5pMdL6vgBUImusQLVq7GetlB51Z+o/fc7kCgGrztogNvJpLI3xShrdSguz8IXN
 NnJx3auyEr74iAXCl11oDrk36PzEqQlJ0Wy27sRv8cptjC1aKwnfn+AUFBBmliAhe7ca
 nIo4d8pONzRHUOrfWpb+UA0xlMm240pUDLJLrJFgOY3Y0mT8bIx/JGSyMy21r4j4qO4S
 lktzFyJBnx8Vk9MmVSTh0ap5DbWNi6crBevfwa3C5qZmRA3f1yxzxsXUwmR9uhwuNBs5 lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38j5qrge29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 18:08:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHuZZt114930;
        Fri, 21 May 2021 18:08:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3030.oracle.com with ESMTP id 38megnt32y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 18:08:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ2L5V1merjYqy7fIo3hLBY+2KnXJYo1FENnI9ZsdLMuNs9NT7sz15yIlQsNPt00QaRuin6oYUMvyblIm3swvjXrJGLz4NpcFwoy6swFGDFtbBEi3LFHYlPMKwhaLpp+YtuqgNeINa8G8b7pc4OYA9Jge2jXiGJtFP0k24sQXC8RxlUK4Vv6/dpf0XwclON99Vqq/F5fuQ8ah9BnQ2FleqDSrM+9kqPbT5436E85NPQwXtdokZCGxeP9M0LfZndJjesaQ/pIP3nvcMsVJxE3MJVwwkuq7zZ77TP78vhXAkDbbtHEM45VoonZxpZge0MBJktwPCVnyv8fVPe4Z0sXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyAQIKPhqxYfhSOCvx3Wsw02fV26KWmtoE21zkJb+y4=;
 b=NZjs4OGOXyFDWFrDuVV6U8chPm7Efi+6aBs1oemop7Aqzk3y4mNTCpwtOteHx1edg2THA9vpUtH91f06v316pOLVfmGEpJqSo3CGQgYLERGImonOqc5vo/JhKkBDm9iZWgDuLiyDmCqlqZubeUvfChTKF9zwmQZLlO7q81oHBS4GmOH2GG/uTFSTk8717No22UvH9dUXcm9HZuhRCMTfnqynewoHwBYJ1bfTeRSmagclLDGYXZ32lnSbUunV9Hc0OPXU6smz73DAtq8TY3R6Q1vfB9ajDwxIEGbhJATTT03wm4/9oh/acK0/3zJ4a1uwAsYjKZ7ll4ZhMD/HztDREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyAQIKPhqxYfhSOCvx3Wsw02fV26KWmtoE21zkJb+y4=;
 b=XW2TElED+H5BnziSkHtlCEPyv3Nk9pQBeLiqFeVJjBumqFuvKX6JpsyBQsVcuQYlU/m8p3l4/bi2L+ZtVWxw2UKQ5H+hgygyTexEyoIgXuQlJx4xp3WUPmWl2ca7KmETxjgMvgJyAA+S7L+0z5sqmhD/MKiuGM0DlPcmpwwTYYA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR1001MB2224.namprd10.prod.outlook.com (2603:10b6:301:2e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 21 May
 2021 18:08:31 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 18:08:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v2 00/22] mm: Add vma_lookup()
Thread-Topic: [PATCH v2 00/22] mm: Add vma_lookup()
Thread-Index: AQHXTmluYSrMy6HbDkibm6PMrCypiKruO8KA
Date:   Fri, 21 May 2021 18:08:30 +0000
Message-ID: <20210521180825.nsndxsgg52tca3ct@revolver>
References: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 893b0e43-6637-4307-d26f-08d91c8370ef
x-ms-traffictypediagnostic: MWHPR1001MB2224:
x-microsoft-antispam-prvs: <MWHPR1001MB2224BF7A56BBD104E76A4843FD299@MWHPR1001MB2224.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gf/fnX6Won+PtAnxMBqP7Dxk+Pw/u8hBsrNpFtoOhZIJzQ5Zhc0m3Ho3jsqaQRa4I1iMC5z14ug2TuUXAbstoXx3x2p9HmJ1UYqyd2mn0sfepQD2slsUOty+e2FKCVRbvZnfpp6gkVIV35afksaWEjmcFjkEa29P7QdRelT2qz3GhoyXIP0ajn83oC7coZgXqIjIyqGnapaIk2qctJ+HoOoLMJqAeba1kL/YcZiMHKm9eOcDd1BEUB5zKm6ZFRDgdTvqXxZpArIT00JznZV0MDy6kG+mLPZckFtwNnmeWni7RaBWq4wdweMw4cNegZhNGithp1yBJ8S4SG2Xav5iwOKslUcviLGen/hL9w1BYNPrM43bcxVL3OQAbbNIwUymURZU2QA+2Zt2L6AdXYhcG7n3WjOy36UiWPS4wea46i9ETjOuKrBedaQd6omPYEu1P3NTDgSPwPrUOoSnirqR6arDyyrWZrO+7ZfsaRJLCb9C8V89Bj03svyHuLxup/0xez5jzDujoYCfEuTx08hTR+q2MLY3Z94xNFYGX0XKSUro+zDeS0aQ0anlAW9DHf0UCFqsEOaRtvlsUBjnmMYCdZ1VyFvw1Dv/KPwep1RRMKY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(346002)(136003)(366004)(376002)(39860400002)(66946007)(66446008)(33716001)(76116006)(64756008)(4326008)(316002)(54906003)(66556008)(66476007)(91956017)(186003)(9686003)(6512007)(71200400001)(1076003)(8936002)(38100700002)(86362001)(5660300002)(2906002)(122000001)(83380400001)(26005)(8676002)(44832011)(110136005)(6506007)(478600001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KzxXhV+TdzufAU0A4kHyE93HR0GYii7wzs5qrKNVF1H6jfORmsuUzTd9o9lw?=
 =?us-ascii?Q?8EeVpzDA4wHELe/19DkTODl2r5SSX/awpTCcFfB0VjsJ/LOKIy0WM+NzQpUm?=
 =?us-ascii?Q?GM+9Gzm3dVIQJrE2Gdnozh6mRkaZFcMni8kigp6ch4+Fm/cG4aohCO9JhEeF?=
 =?us-ascii?Q?icp9XZU8pKr5HhOfKejikdG/HKaMnJpoqKW0VenrCSdxwElpCTGM4RMWiQaK?=
 =?us-ascii?Q?XaKZkAvUI0FI61eWZfgSbJrEZOzJ7XnpIGW1/lVyThl02tSXg/oG8tV3NI3m?=
 =?us-ascii?Q?uyGqBv49YaG0lZVHLo7HwqaeKShT+ph5l4SdpV+oUmOte5QzU6R79KxyyklF?=
 =?us-ascii?Q?u9hdocAu+varHi3Y+QTYhZBae/qVkhOp334PaJefrVRZIAdSU/zDBjgZG8Ga?=
 =?us-ascii?Q?41MjreyTrrznvDcrJxq5r83zBnOasbMJRD+ZqmoweGXlqz2t6ZPWao5Y3xET?=
 =?us-ascii?Q?SZzfNkCktU+ogYcXcG6+R3XQs/vXyqj4rGpLkUnfiqz5UuH905z/+WB6zPCZ?=
 =?us-ascii?Q?PszxzAGT8I5U7ulWdUAJPz2RqlNdWDhbEAkrPyNfCDZ4s5cVe7bSjle88n2X?=
 =?us-ascii?Q?AONilTUfqYezRgzBM7+8NzlC5CWZMHZUxEaBng6wFxh5WeHHdPl2T3sX9LWV?=
 =?us-ascii?Q?ilXzoCYQBbxUQZxnaoloSrQkk67PQiaT9qXulRLBrHA7nS5CvpxKns9uLi89?=
 =?us-ascii?Q?O6Q3w9c3LmFlQ3URBuWfqEXTaHVXoJjz1rgxR+OOS7DDnYXc2Vb1o9QLXSEu?=
 =?us-ascii?Q?seM+Elfib2+8/1Mmh6hUFsDN78n2ce9asZ+5Sy5jjKghFHQYwWBkDplY9Uha?=
 =?us-ascii?Q?NpqLIg01RSVtCHwBPf73HwEg6E5NVFxaKxrPXmMTXXGvgQ3N8rQ3YxWWjPA1?=
 =?us-ascii?Q?JycwdIW5i30yF3PHwP9nMJ/RDlbQI5u5v19GdzGp9P9ec7wtZp4sZjbY1tUL?=
 =?us-ascii?Q?ZtmR8lKXu/wiA415PEo9rDxa3+/oPj4kiiFm9KwbW78hVluux+PUfaJgwPmY?=
 =?us-ascii?Q?OLgYUgDfBcBpLqLTtlFRq0xRWrAdohJL7kVXLuIzbA6vlseQXKQ/+HrbPgw4?=
 =?us-ascii?Q?tQ22oXDQz7JaIpqvtMBO81WVqd7vN2B2jXvkS9JhK1HFWQaxQtbsGog0fs2n?=
 =?us-ascii?Q?hNbxjkuuy1GBCavRMyx9pXCjU0obJSFJKWgFRDtAAIyD4WjYT+NPbejhKPaf?=
 =?us-ascii?Q?VnijCEmLPJH6tlxGXdHT27rSH/w1fu30ppTlYrLTu74D0Lho/SM/fuF8fsvC?=
 =?us-ascii?Q?2B0fO3szssdTolzyjj4IKZgc35JYCag9RSEhrv5jo/Y51pnKLwB2AHGNC7Ed?=
 =?us-ascii?Q?mhVojhnI6QkLYVpZ8ghlUWnc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F44C06BFE2DF3448FFD520B6FA03FBA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893b0e43-6637-4307-d26f-08d91c8370ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 18:08:30.9604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjYt4wW6wVtkVqCKCADQzgghCFIQO1sBBSpJCUVZPO3yenetFdzNGrLdmfBTF8VkW9Lv7IohWdJZf5vfuTaB3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2224
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210094
X-Proofpoint-GUID: 1FPddY6C3qkj2kxe_t78IlufGylTfhqh
X-Proofpoint-ORIG-GUID: 1FPddY6C3qkj2kxe_t78IlufGylTfhqh
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I missed David Hildenbrand on the CC list and in the v2 change log.

I added David Hildenbrand <david@redhat.com> to the Acked-By for the
series as well.

Sorry for the oversight.

Thank you,
Liam

* Liam Howlett <liam.howlett@oracle.com> [210521 13:47]:
> Many places in the kernel use find_vma() to get a vma and then check the
> start address of the vma to ensure the next vma was not returned.
>=20
> Other places use the find_vma_intersection() call with add, addr + 1 as
> the range; looking for just the vma at a specific address.
>=20
> The third use of find_vma() is by developers who do not know that the
> function starts searching at the provided address upwards for the next
> vma.  This results in a bug that is often overlooked for a long time.
>=20
> Adding the new vma_lookup() function will allow for cleaner code by
> removing the find_vma() calls which check limits, making
> find_vma_intersection() calls of a single address to be shorter, and
> potentially reduce the incorrect uses of find_vma().
>=20
> v2:
>  - Changed find_vma_intersection() comments and whitespace to be
>    compliant.  Thanks Davidlohr Bueso
>  - Moved vma_lookup() call in vma_to_resize() to be separate from the
>    declaration as requested by Davidlohr Bueso
>  - Added Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> for 08/22
>    "arch/m68k/kernel/sys_m68k: Use vma_lookup() in sys_cacheflush()"
>  - Added Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
>  - Added Acked-by: Davidlohr Bueso <dbueso@suse.de>
>=20
> This patch set was originally part of the maple tree patch set.
> Changes since being broken out on its own:
> - Changed initial implementation of vma_lookup() to use find_vma() as req=
uested
>   by Michel Lespinasse.
> - Updated commit comments to be more descriptive
>=20
> These patches are based on next-20210506
>=20
> Liam R. Howlett (22):
>   mm: Add vma_lookup(), update find_vma_intersection() comments
>   drm/i915/selftests: Use vma_lookup() in __igt_mmap()
>   arch/arc/kernel/troubleshoot: use vma_lookup() instead of find_vma()
>   arch/arm64/kvm: Use vma_lookup() instead of find_vma_intersection()
>   arch/powerpc/kvm/book3s_hv_uvmem: Use vma_lookup() instead of
>     find_vma_intersection()
>   arch/powerpc/kvm/book3s: Use vma_lookup() in
>     kvmppc_hv_setup_htab_rma()
>   arch/mips/kernel/traps: Use vma_lookup() instead of find_vma()
>   arch/m68k/kernel/sys_m68k: Use vma_lookup() in sys_cacheflush()
>   x86/sgx: Use vma_lookup() in sgx_encl_find()
>   virt/kvm: Use vma_lookup() instead of find_vma_intersection()
>   vfio: Use vma_lookup() instead of find_vma_intersection()
>   net/ipv5/tcp: Use vma_lookup() in tcp_zerocopy_receive()
>   drm/amdgpu: Use vma_lookup() in amdgpu_ttm_tt_get_user_pages()
>   media: videobuf2: Use vma_lookup() in get_vaddr_frames()
>   misc/sgi-gru/grufault: Use vma_lookup() in gru_find_vma()
>   kernel/events/uprobes: Use vma_lookup() in find_active_uprobe()
>   lib/test_hmm: Use vma_lookup() in dmirror_migrate()
>   mm/ksm: Use vma_lookup() in find_mergeable_vma()
>   mm/migrate: Use vma_lookup() in do_pages_stat_array()
>   mm/mremap: Use vma_lookup() in vma_to_resize()
>   mm/memory.c: Use vma_lookup() in __access_remote_vm()
>   mm/mempolicy: Use vma_lookup() in __access_remote_vm()
>=20
>  arch/arc/kernel/troubleshoot.c                |  8 ++---
>  arch/arm64/kvm/mmu.c                          |  2 +-
>  arch/m68k/kernel/sys_m68k.c                   |  4 +--
>  arch/mips/kernel/traps.c                      |  4 +--
>  arch/powerpc/kvm/book3s_hv.c                  |  4 +--
>  arch/powerpc/kvm/book3s_hv_uvmem.c            |  2 +-
>  arch/x86/kernel/cpu/sgx/encl.h                |  4 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  4 +--
>  .../drm/i915/gem/selftests/i915_gem_mman.c    |  2 +-
>  drivers/media/common/videobuf2/frame_vector.c |  2 +-
>  drivers/misc/sgi-gru/grufault.c               |  4 +--
>  drivers/vfio/vfio_iommu_type1.c               |  2 +-
>  include/linux/mm.h                            | 36 ++++++++++++++++---
>  kernel/events/uprobes.c                       |  4 +--
>  lib/test_hmm.c                                |  5 ++-
>  mm/ksm.c                                      |  6 ++--
>  mm/memory.c                                   |  4 +--
>  mm/mempolicy.c                                |  2 +-
>  mm/migrate.c                                  |  4 +--
>  mm/mremap.c                                   |  5 +--
>  net/ipv4/tcp.c                                |  4 +--
>  virt/kvm/kvm_main.c                           |  2 +-
>  22 files changed, 69 insertions(+), 45 deletions(-)
>=20
> --=20
> 2.30.2=
