Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ECD3794E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhEJRDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:03:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51830 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhEJRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:01:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGs1dv073801;
        Mon, 10 May 2021 16:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=i9QXy4vDdTfcaide81omD0TJMqGMV6q4Vqpmcz2CYnA=;
 b=vqOdRU3/ImSeFIJD7Dh9TgMRKwiE/7YtHJESDa7H/lRl8bDML509sQAZrJr8oYAH6FbE
 v7EaLHXCDtO/QaF23mmzzaiCpz89Z3dFxzTceVsQBxHvvH+CVr8TdJmH97dFuAENtigJ
 YChD55Fp+3dm/lu9Gt3xIncPbxnqSMYW+WvOsrsiWjSKlzX34SsmW7SwlCg7Xn1+id9a
 xU1L7eE9D0GQYuCxscs+1pFQ0B9jj1xxmrf+6aJJoIOuYk3uSc8JVOLJ0xPzkqW9MtG1
 lkkOY1vCv5TKaTMp7tHQk5bHdkEWY80JdIzqNyTjR5m0MYHb8IYwKZkxwNbhAaxKVttb Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38e285b76r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucH9109288;
        Mon, 10 May 2021 16:58:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFsf6JSUHuUFtkiX7Xfjirio1qEYeV2r53SsyTkimFRmhbnNBDzCJIDUUMYIB3+cDOcQ8GIgdjow0rXpHqamXOX6YUZE/lRisHY4KSqrY6ZWYVJGZGem5GCMyCtHcdEHo25BiYPOSWWwD5RDSqVUpbBxQ/VjSuzEkuJ4+GCU+jNUyMb0tnAQl8munxxfrNlFsXuxc/ag/uM/a0OS8tlEFQR/Ze0VXeVYq6Oaf2JsGywS68E71zYUYcsuvUM1vb+CXelDvKxJntDqYPDk8XsK6Lk3Xf3dIc2F//9C9B7Fvjs3jeO7VQj1ys67Y1aUyGtrPbUN6KI56XvfLzy6N0RUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9QXy4vDdTfcaide81omD0TJMqGMV6q4Vqpmcz2CYnA=;
 b=kJsmBCndeUaQNNM2Fdv0XZp4rrwVFELk0+ZMmlsESctBst6H8n24UHJ+7GZUeTM8rRGJJVS+AjTmvaDn9VADcb6wyHonEBUGNvOnXSN8wmWmGopEKnDWrsHWiMtrRQ4k91zCmnJXJfgXTG+V+sKxkDngXZHJui87eK6YXvClR8+Q9lAyJet41k6XVcSg4Z3+rvIakZihkaGYUYEgCmZsELc9L5NvXeNKguFfzW8klv8GF6HGOCFtn0Dtedc3SuxjvbBCp1aYC4idhKyqhdpX6GCUAkhjQNcp9J2WoHSXiYXH/sp7cohMGI2Q18Kp4XjdN3pyiZBDP45xGp6wtjeZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9QXy4vDdTfcaide81omD0TJMqGMV6q4Vqpmcz2CYnA=;
 b=XFSooOzy/hLOjZkRq0xDAczi5sX2rTKxuGyBimiKwuWV1+w5Aq87wB0EsJKATB7bOTewd7vKoT72wEUFYbGGOa2PImiAvuL9wZbxjP+oFQtsDnSGuyGloUQJZQVHcB6Yd7C6yxrrcFIZjsoObSgvKeupTQ2e7g54pW6CqdidJRU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:48 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 00/21] mm: Add vma_lookup()
Thread-Topic: [PATCH 00/21] mm: Add vma_lookup()
Thread-Index: AQHXRb2+7Ato7Wx8EEWBa8yHr71RGg==
Date:   Mon, 10 May 2021 16:58:48 +0000
Message-ID: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6728f13-b6f5-4e65-8ed5-08d913d4e17b
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB476979D608B9B11E7CBC5510FD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kntu4Ba5N18eFxhuVm4i6v9IL26b2KyfK2VsII46wRdbc0LMHqFJMSzp+/un7gm8RnTQFu0DGMIOnEJmBm9zOs/L4taIuYQJmrwnZk5iQSuifdnpbA9hLKyzq/kxx3Xri9DPxA97FKvDJehHCjEV94VHk1h+V+FJHXrjjDM5P4cFvjLtXI5d36S30coxwQn0Hz3tIiM851PG1H/hj1GL5u9kxroP50Kpe9xvo3EHL6ZWgUvicsf0b623LSNRK2NJmoBm6ruUxGABQ1QN9HwAwxtfTTwPHu0nvJYkbh/MR+i9/Vi6lB3TD1bNrHKf3cLqDMT1nyfm8ycymyfyghv2oLLqpfUf4drMwikOHXRkO9SxJJs514ijRYeOnbxbUmO4y1ZU1lka60R1WB6fDPnJmiLy0mC36Gfu1rpiJ3jCGf1nQ8sM2qs5tbJjzp7eofsaPfb49wvm+Df0tLD8ANy78ywPIkrLVWd/3cB+GL1m/11p1/1eqP9P/EKioKQJ9ifEjsuhwfBF2Et8FR4RBUihWgdN+/yzW9vwnCHX0QqPvR0EPfRJ+sfF292BPaQRBCXd0ZIH6At7lyhnz/LKx0rqTfIZxxsV9iRnyagn237eLgE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?SKoDY51HEEpYC14zqUbgJSBwniLxMhtd39PhsonrjooXXvrVtBZyK4mz1E?=
 =?iso-8859-1?Q?M6wAqjdYN4nFkvyEP76AezO+9cL+Hmb1/q1vSSj22SW9C3IO9z9I1WOhd9?=
 =?iso-8859-1?Q?7Gy9RAZp40c+91+5Wz8fXBNnwna1FOkk6ltq7u52R9X3l0BMyQpmIDCOWH?=
 =?iso-8859-1?Q?GiqNwzFwP3G22jYriVlDvSJ4JMCD4jNcwFacu64ecPIVReW2Jeg2A8SYKK?=
 =?iso-8859-1?Q?c0Ibn6tB7LMnpeJWZEIX47/xL/da5tSf/O8VsBCIayezC2neRk0kW+i5EY?=
 =?iso-8859-1?Q?+YxhCZkVHNtJsuGFkXgHMuGyjMY2YV+LTeB8uGf03rdoQYKrc9n4GUNKO/?=
 =?iso-8859-1?Q?MUcIRmQe8ikDNGv5MaEEIrCgBj/Ft1NAjURWA5rHoBfXtZobwSXqYKSRbi?=
 =?iso-8859-1?Q?rT+QdmIN1CaDjImPUzRZWSAAXBmRaNI6rQKPhGglIXtCus4uEt+DThv+NO?=
 =?iso-8859-1?Q?lOIdix+AhKy/vJ4eOlWG/kFdCfUiQL/E6pLSZSTM/N67iTRdM/4y2i/eDW?=
 =?iso-8859-1?Q?fHCWy8ui+iOp+hPYfB/FjMZYTGX9/2EI2NErzufDOM/x0GUVl6U2sgJrRz?=
 =?iso-8859-1?Q?JAcOSMo7pbusRVEyAPj6/MWe/Pf+GCH180WQy6KJuf+c0aXtxYGOP3LsV+?=
 =?iso-8859-1?Q?qEf3HdwG06kqDMQFfLdnQVJujTLZJ8RLljLTSc7X+RuMXEEx/wu/NHosW+?=
 =?iso-8859-1?Q?vsbiLNFSPiZ+pElbnVQ0xC/4Qkk7PTcte4VEfpt7iw7pyHrKrAVwBrynEj?=
 =?iso-8859-1?Q?RULXZtFGLVN/fv6QigeiLT2S5akV7WNmzYQboYmmfoc2uJNe7yufFI57RA?=
 =?iso-8859-1?Q?0exIKjM7UJ3b6r7xRm3zdFr0XXQycqRXmjRoA/2VFVm0cJkiYalEDYl801?=
 =?iso-8859-1?Q?wsadbi/q08Jr6LkuQUGCwc7Dmrs67fAnY8Wq+06QQ4IGdDVjR8r8brLbdH?=
 =?iso-8859-1?Q?HNopBpNFL46pGFGwKvfZR5EutueXz9EkcI3g+AjDdwPJgPUOPpAP6Pqba0?=
 =?iso-8859-1?Q?h4BjsgitfwzvEDUuPTIHbbgLp6/JFWqGd4fr8svjmB2YWflK9JgCQBo9Ck?=
 =?iso-8859-1?Q?Q2sokzlsbqrgIbBVt+Fu6+wg0SvL6+2bp0Ty/K0IduKespk7OH3igsjBKk?=
 =?iso-8859-1?Q?fyGjqsYa75IvbEqsy6oht+K+FIzq3KrJTvU8muQ/hvy2yQ6cmV6ypfr+Yu?=
 =?iso-8859-1?Q?qb4VZZXdB2ok9eZyHs4MSVlxefdVG73aWwuo1OpYvZjIL0l/FWCRybS7TK?=
 =?iso-8859-1?Q?SForHuRgtgVk+9uOBQTNas1LaYgsG90XjeCnL33d+r1cA9tBP6WFYirSVW?=
 =?iso-8859-1?Q?DGOyCcANaW5P1pfMhGaWor4/IelHrhe9PGJMOYc4PG8gy73I+zLUZIH495?=
 =?iso-8859-1?Q?1WLrLZqSrp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6728f13-b6f5-4e65-8ed5-08d913d4e17b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:48.5032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZcngce8r7KF6Mw8OIGUpRSG0Ou426nWataG7IeKa8kTwxcb/TvVD5OOIlFQU9QSAGaigvkUbmCkEszxxvRD7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-GUID: ALvXgEB3d3bzDV-YLEVfTg-aEztUNjoE
X-Proofpoint-ORIG-GUID: ALvXgEB3d3bzDV-YLEVfTg-aEztUNjoE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many places in the kernel use find_vma() to get a vma and then check the
start address of the vma to ensure the next vma was not returned.

Other places use the find_vma_intersection() call with add, addr + 1 as
the range; looking for just the vma at a specific address.

The third use of find_vma() is by developers who do not know that the
function starts searching at the provided address upwards for the next
vma.  This results in a bug that is often overlooked for a long time.

Adding the new vma_lookup() function will allow for cleaner code by
removing the find_vma() calls which check limits, making
find_vma_intersection() calls of a single address to be shorter, and
potentially reduce the incorrect uses of find_vma().

This patch set was originally part of the maple tree patch set.
Changes since being broken out on its own:
- Changed initial implementation of vma_lookup() to use find_vma() as reque=
sted
  by Michel Lespinasse.
- Updated commit comments to be more descriptive

These patches are based on next-20210506

Liam R. Howlett (22):
  mm: Add vma_lookup()
  drm/i915/selftests: Use vma_lookup() in __igt_mmap()
  arch/arc/kernel/troubleshoot: use vma_lookup() instead of find_vma()
  arch/arm64/kvm: Use vma_lookup() instead of find_vma_intersection()
  arch/powerpc/kvm/book3s_hv_uvmem: Use vma_lookup() instead of
    find_vma_intersection()
  arch/powerpc/kvm/book3s: Use vma_lookup() in
    kvmppc_hv_setup_htab_rma()
  arch/mips/kernel/traps: Use vma_lookup() instead of find_vma()
  arch/m68k/kernel/sys_m68k: Use vma_lookup() in sys_cacheflush()
  x86/sgx: Use vma_lookup() in sgx_encl_find()
  virt/kvm: Use vma_lookup() instead of find_vma_intersection()
  vfio: Use vma_lookup() instead of find_vma_intersection()
  net/ipv5/tcp: Use vma_lookup() in tcp_zerocopy_receive()
  drm/amdgpu: Use vma_lookup() in amdgpu_ttm_tt_get_user_pages()
  media: videobuf2: Use vma_lookup() in get_vaddr_frames()
  misc/sgi-gru/grufault: Use vma_lookup() in gru_find_vma()
  kernel/events/uprobes: Use vma_lookup() in find_active_uprobe()
  lib/test_hmm: Use vma_lookup() in dmirror_migrate()
  mm/ksm: Use vma_lookup() in find_mergeable_vma()
  mm/migrate: Use vma_lookup() in do_pages_stat_array()
  mm/mremap: Use vma_lookup() in vma_to_resize()
  mm/memory.c: Use vma_lookup() in __access_remote_vm()
  mm/mempolicy: Use vma_lookup() in __access_remote_vm()

 arch/arc/kernel/troubleshoot.c                 |  8 ++++----
 arch/arm64/kvm/mmu.c                           |  2 +-
 arch/m68k/kernel/sys_m68k.c                    |  4 ++--
 arch/mips/kernel/traps.c                       |  4 +---
 arch/powerpc/kvm/book3s_hv.c                   |  4 ++--
 arch/powerpc/kvm/book3s_hv_uvmem.c             |  2 +-
 arch/x86/kernel/cpu/sgx/encl.h                 |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c        |  4 ++--
 .../gpu/drm/i915/gem/selftests/i915_gem_mman.c |  2 +-
 drivers/media/common/videobuf2/frame_vector.c  |  2 +-
 drivers/misc/sgi-gru/grufault.c                |  4 ++--
 drivers/vfio/vfio_iommu_type1.c                |  2 +-
 include/linux/mm.h                             | 18 ++++++++++++++++++
 kernel/events/uprobes.c                        |  4 ++--
 lib/test_hmm.c                                 |  5 ++---
 mm/ksm.c                                       |  6 ++----
 mm/memory.c                                    |  4 ++--
 mm/mempolicy.c                                 |  2 +-
 mm/migrate.c                                   |  4 ++--
 mm/mremap.c                                    |  4 ++--
 net/ipv4/tcp.c                                 |  4 ++--
 virt/kvm/kvm_main.c                            |  2 +-
 22 files changed, 54 insertions(+), 41 deletions(-)

--=20
2.30.2
