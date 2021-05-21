Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBAA38CC95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbhEURth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:49:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41946 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbhEURtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHUsGi083408;
        Fri, 21 May 2021 17:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=+mrX+mPqT7y0iI0q1z6qSiHH2tvc5hWnORfkI3X6GhA=;
 b=EN8XAi5DGfvi9UkfmALzu+orB56phfLzjL6bZ/rXYNQdiJQfvag2PB4HTm/Hs8FUZPQs
 uMfsi2PMtyjzg1h4LwO13qrN3vRa9vx4zkZ26L3crVlWm6ZdwyfpoW7xqEZbxQ32p8GG
 GORuVt/qTwxfs3r1X9WjVLH+F2bOTmCtmcT0Pc/hl2jHr2+jFwH0N7tfuy8lVT3qgNZe
 meHb479NWEb0S6B+g+Znwrtj82iWEhKYCnuhjE8OA37d4LVkpMc2pV5I/5AhyBrmMIWl
 c9sLaiPMc6xAOOxNry4uqi1EqXqxCeoaYXf3+wEaIOxWcvQylkDOSC5BmYN+69s+OdEc kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38j3tbrf2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHkZKV095728;
        Fri, 21 May 2021 17:47:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 38megnsk78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMiuwyqZ9z4VD4wZxqAR+dn9k4TqzvnSpfydR6IdVAEmEXwZSTmMyxLmPRo+JYcgStrc20GwnMGMraG8cfWKdhwJUStUwJBdXBQPJXNIzItnBXUZ9gzb7bhYVbGYuDI7CBMfgG20L/TYC+frFAicHNHwtnXQFbbg0IpQYSbSyyleY1u1MMZEUJ4l1Cv52YlHbxcy3r13tAPwo5v+UknY6HrexI1+wBpgsgMUNE4luvJHDxEeM+gIqpGT6PAvUZAFq2Rn9bOKyvge1TpoEXHjwJceMKIu5XIbb598rQThis7oGrP/9VhA6vNHB9xxTrqD5DAgHqLVki7i4kgyy0HDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mrX+mPqT7y0iI0q1z6qSiHH2tvc5hWnORfkI3X6GhA=;
 b=RkjAuEtE7kR1KJcK/4aRuBy12AgGav5u2EOP7knwJoACJd/N4lLG4xYbQrmxfjI9BJ7zSlwE6N7uIkl3F5PUENFhZTijcn5mi4nmKnaqkx7StF3pXVpnc71Rb3id5X30zV/Rbf8dIww0gJ8ZTlEDBJF3OOsQUsLf5ddgHZWchKgi/wiy+Q6cFWoGPeti1sKMiFoA1Jj4jGjfCFz4xx2eBiNCrpwM0u6XSm358iIfzA08etvM84oUCbvNYvxcjYwv/Ag7QJ4IuEv11Qyjp8Gjl7WW3+Ixiph/bAN69GDAevm1TQ2ZQzyUwC21lyaT/xEfPAF7KbYmeeZfSIhNiTMmaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mrX+mPqT7y0iI0q1z6qSiHH2tvc5hWnORfkI3X6GhA=;
 b=zUxvV/fh69bqLJy+D7CLoqQxJfz/1G73NIScEk+mJnlzApYXdGraKbvzimg2LtfsPb58Ayl5fv0vBtG9drkL6d3LqHl2d6LmaD/fcq+91E7ZYVuuOzBXMUSVrRxXOXOm9kVmxzRyCvMOrQz4K1tc48fVQf8UDbDxWivZZhj9pMA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1791.namprd10.prod.outlook.com (2603:10b6:301:9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 17:47:56 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:47:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 00/22] mm: Add vma_lookup()
Thread-Topic: [PATCH v2 00/22] mm: Add vma_lookup()
Thread-Index: AQHXTmluYSrMy6HbDkibm6PMrCypiA==
Date:   Fri, 21 May 2021 17:47:56 +0000
Message-ID: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8266321-0f22-4789-8753-08d91c809129
x-ms-traffictypediagnostic: MWHPR10MB1791:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1791C84441067183EBD10029FD299@MWHPR10MB1791.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cNzHbsDEVOcsWUlZO1/9fLp9u7mPISy4ERdhnDMbzDdArCf0kGjXZ0quzgBeVrKHNkPO5JHx0QVPkG4OkAg0meHAOBony51TOAU4AQW6WNXs5ZDlUEknEmlM1Jllh79lUMx3fnCdy0RbUoUsEPkqUcoCByzB4wIkEwTbpEjgiS6NVw7G8yW7BzmRldyOHEmM60a3btRQC+Ph955gYOoM82QSIjj/ARjjRrpADgyFvv4V1HbOtxnVjYp140tbogbqkcGvLsUipTkAhn7btb/eXUvXHVi+Gyu3YfiNT9NYrW/C2hVlvFMEOXRbn4bkuA08xmzqt240RksqveGt19guSakuwZVCXPRzKhYyK2NTlTm88UrFv2H0q+kmuHPRl4gwDwG9710Cls3guxSppgtHR/KhgxBMPw5w+OpY/BuC/wLQ30Rr40K6nS42ThWOGTQdROE7MxSz+8Tdl8tO71d0cxLdgmAgy51CLNvOy8GbOMTZEJxWZidMOv0/0BAMLB59pAKnSSXiyD6KXIi2rCWr3vTipEYkdp21wD2Sm/f32Fgc8saEDaWZ1x8iM7HzBqhUivdjiR4+MlRT7HtNCYNJMKdsnYrLdEAd6HlgeBgU2sI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(396003)(136003)(366004)(6512007)(36756003)(83380400001)(110136005)(54906003)(44832011)(66476007)(38100700002)(91956017)(66946007)(478600001)(76116006)(107886003)(6506007)(8676002)(316002)(5660300002)(66556008)(66446008)(64756008)(86362001)(26005)(2906002)(71200400001)(1076003)(8936002)(186003)(4326008)(2616005)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?nloYaO6AGS42Wt/Rpbgw3QX5yF4UNGoBAtYxzKRvkXZBA1qGwx7h3sSGDM?=
 =?iso-8859-1?Q?CNarMva/eCbbabR7jSwhtTr/WqwCJs6qpIywhqPbu8bPDP62kM9hU1sJLd?=
 =?iso-8859-1?Q?kr++Lh659yBYS6quTut5fJF9qzhWjVJ+IMBxNHyH8XW0yTW9MHvzk6OOTt?=
 =?iso-8859-1?Q?t6lc5KSKwsp96yLfLCUmJh08EfFh5XYwJ7WiKFKi4YuOoThzCPtH/EsxHM?=
 =?iso-8859-1?Q?GHwfRFf7jW6SbVzxA1aSbltcu7RWdzPAqWxZ4zUzzj2/itEa+Ya0XF7dvr?=
 =?iso-8859-1?Q?cy6nAAq/APqVzQ3dhwWcdndsr3hs3N4YtOcT3facY3wfXOo6hxJzvzpi2T?=
 =?iso-8859-1?Q?Qd8Q53VADBoobfyBMXPEovwqfBvlpRw18R7CDKrTnD8ssUXbIwKhh94GUQ?=
 =?iso-8859-1?Q?ZxsjKYU2IBnD3fr+en6wVvIfn8Gz/y16LmrmWI2aDz4W+xvJRFKDWaOdyy?=
 =?iso-8859-1?Q?pF3eiNWtUEY+4a1PriRltN4pgQ3tTOgH3Mb87ro15VLCGCHGCR90L4Jmj5?=
 =?iso-8859-1?Q?whmhJ2B68jCpyptOGQE7qgg2AgMer9moccaY9ebrJTYRfoAx97P6O9hjD3?=
 =?iso-8859-1?Q?CYl1nC5Av1QvRbni7n7sQwl61ojy+ILzYl3ZBavT5I7jIJ3LwdvsvRen7H?=
 =?iso-8859-1?Q?vqNCGNLmS7u+bZQ9pbYjsxOdifPxGBBcyjkG2/NEyIyuEWaZbnNLPWPMIH?=
 =?iso-8859-1?Q?NU73HGoppMth+1uvj5ZQYFEWIXKpgCHwEZOJsN/zFzEsdDswu1tnK+ReJ0?=
 =?iso-8859-1?Q?4d3/oH1jBRvzKZZh1hD9SgY+8ubDkppeO22HFiIcdWIe6rDzXKQzi/jK2h?=
 =?iso-8859-1?Q?Ps8cd/TE+BkYtrbaVifICkCc6W9cOGIhAkSdbK+PJpMCQgwGiLiv31iyEi?=
 =?iso-8859-1?Q?JmYvEgaCSaQntOhoe0LIGfsqP5dGx9tbXkHS6tHHyerVUu/4el440RXy8J?=
 =?iso-8859-1?Q?cQRn902vdrp7BN6afpUQI2poFZ1NYZbcR1fFgnMKzBF1T1O4BXFlf2zvPs?=
 =?iso-8859-1?Q?c90jV0Z6avAR5WZdVDbk5fwxJ/zalH+ZtacWegZoZB3ffkfyFqjCPaKY/W?=
 =?iso-8859-1?Q?rL9lgynjLmFxj5JvM1X/nuAiAieaB+mN7GlW7myc/yIiCRo0qlFkfl4skC?=
 =?iso-8859-1?Q?LjNHInv9Xgg7HRPGt9jdFic3LM0bV8HMedkYnomnG97MyTrCe3HBAfJS91?=
 =?iso-8859-1?Q?e9k6lML88PQiTz9r9xMikeqs6FZPOFF7Wn1wmZqnR+y9aNgGMIy3dc0w4T?=
 =?iso-8859-1?Q?fNzjPeAy06vS4xr2jPTvgxNmRzbdub2ZTJIbOELMCKz/X2jgF3MjEDNRGk?=
 =?iso-8859-1?Q?whG4Ay/G7MDT9mqbciUMUTsVwaMjpVs1ry1DaV8Gu7U75VEWi+Sreu8jIz?=
 =?iso-8859-1?Q?8ZxWOY1MU1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8266321-0f22-4789-8753-08d91c809129
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:47:56.5016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVjU28jZmTPeIG1RqOmEJk5d9eRgNz2HFULEA1mTCeZq4U307+8JFI2YUXaeVgBCc5QyWxdXtVjf8C9TxlPp/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1791
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: lMxX_2Beem91mHip2ZcID2pjHB1diSYQ
X-Proofpoint-GUID: lMxX_2Beem91mHip2ZcID2pjHB1diSYQ
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210092
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

v2:
 - Changed find_vma_intersection() comments and whitespace to be
   compliant.  Thanks Davidlohr Bueso
 - Moved vma_lookup() call in vma_to_resize() to be separate from the
   declaration as requested by Davidlohr Bueso
 - Added Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> for 08/22
   "arch/m68k/kernel/sys_m68k: Use vma_lookup() in sys_cacheflush()"
 - Added Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
 - Added Acked-by: Davidlohr Bueso <dbueso@suse.de>

This patch set was originally part of the maple tree patch set.
Changes since being broken out on its own:
- Changed initial implementation of vma_lookup() to use find_vma() as reque=
sted
  by Michel Lespinasse.
- Updated commit comments to be more descriptive

These patches are based on next-20210506

Liam R. Howlett (22):
  mm: Add vma_lookup(), update find_vma_intersection() comments
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

 arch/arc/kernel/troubleshoot.c                |  8 ++---
 arch/arm64/kvm/mmu.c                          |  2 +-
 arch/m68k/kernel/sys_m68k.c                   |  4 +--
 arch/mips/kernel/traps.c                      |  4 +--
 arch/powerpc/kvm/book3s_hv.c                  |  4 +--
 arch/powerpc/kvm/book3s_hv_uvmem.c            |  2 +-
 arch/x86/kernel/cpu/sgx/encl.h                |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  4 +--
 .../drm/i915/gem/selftests/i915_gem_mman.c    |  2 +-
 drivers/media/common/videobuf2/frame_vector.c |  2 +-
 drivers/misc/sgi-gru/grufault.c               |  4 +--
 drivers/vfio/vfio_iommu_type1.c               |  2 +-
 include/linux/mm.h                            | 36 ++++++++++++++++---
 kernel/events/uprobes.c                       |  4 +--
 lib/test_hmm.c                                |  5 ++-
 mm/ksm.c                                      |  6 ++--
 mm/memory.c                                   |  4 +--
 mm/mempolicy.c                                |  2 +-
 mm/migrate.c                                  |  4 +--
 mm/mremap.c                                   |  5 +--
 net/ipv4/tcp.c                                |  4 +--
 virt/kvm/kvm_main.c                           |  2 +-
 22 files changed, 69 insertions(+), 45 deletions(-)

--=20
2.30.2
