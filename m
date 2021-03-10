Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FDE333592
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCJFvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:51:10 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:26840 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCJFut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:50:49 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210310055047epoutp03ead9701a4c436a371aa86a06bc1faa8f~q5TiGhPj20729507295epoutp03I
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:50:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210310055047epoutp03ead9701a4c436a371aa86a06bc1faa8f~q5TiGhPj20729507295epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615355447;
        bh=F6yiK3eZ5ZuvXhGR+yvTsN5lbrwcylNRqemOzFd7w64=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=c8nC9iiDqg5oxA/XyxKUMzZpeUKt5LarBnAZ3y+QTk46fSB1wVGvO1gVG9RTQwVt2
         eQ0zlTRqmdlbOd5jDYJwjrDmntz6jztA2/ama9XHT7qY0Aut0KR9FUNThL391JJROl
         i8tg3dXKe+L0Lc5OnWgUpahVA+a7Jr98A4sk89mI=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210310055046epcas5p1a72bf00c8765de71d1a14e21eb42f1fd~q5ThgK8e33090830908epcas5p1x;
        Wed, 10 Mar 2021 05:50:46 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-75-60485e3683e8
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.6A.15682.63E58406; Wed, 10 Mar 2021 14:50:46 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v2] arm: print alloc free paths for address in registers
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>
CC:     Maninder Singh <maninder1.s@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1614239800-27549-1-git-send-email-maninder1.s@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210310055035epcms5p230de287f0daec198eb334b3348d07924@epcms5p2>
Date:   Wed, 10 Mar 2021 11:20:35 +0530
X-CMS-MailID: 20210310055035epcms5p230de287f0daec198eb334b3348d07924
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7bCmhq5ZnEeCwbfTyhYXd6dazFm/hs3i
        +rc3jBYru5vZLDY9vsZqcXnXHDaLe2v+s1ocmrqX0eLw/DYWi7bP/1gt2pZsZLI4dHIuo8Xs
        xj5GB16Py9cuMnss2FTqsWlVJ5vHpk+T2D263l5h8jgx4zeLx5Mr05k8Ni+p9+jbsorR48yC
        I+wenzfJBXBHcdmkpOZklqUW6dslcGWc6X/DVHBVrOL//jNsDYw7hLoYOTkkBEwkJrw4zA5i
        CwnsZpR43e7ZxcjBwSsgKPF3hzBIWFjAR+LAzBeMECWKEhdmrGEEKREWMJD4tVUDJMwmoCex
        atceli5GLg4RgYNMErMuPANzmAV2M0nsPj+dFWIXr8SM9qcsELa0xPblW8GGcgp4SHx6M4UR
        Ii4qcXP1W3YY+/2x+VBxEYnWe2eZIWxBiQc/d0PFZSRWb+4FWyYh0M0o8fhHM1TzHEaJH0t8
        IGxzid0b5oEt5hXwlfje3Q12EIuAqsTyE4+hDnKReLfoGNhQZgF5ie1v5zCDfMksoCmxfpc+
        RImsxNRT65ggSvgken8/YYL5a8c8GFtVouXmBlaYHz9//Ag13kPiTcs2RpA7hQT6GSXW/ZjL
        PoFRYRYirGch2TwLYfMCRuZVjJKpBcW56anFpgWGeanlesWJucWleel6yfm5mxjBqU3Lcwfj
        3Qcf9A4xMnEwHmKU4GBWEuH1O+6WIMSbklhZlVqUH19UmpNafIhRmoNFSZx3h8GDeCGB9MSS
        1OzU1ILUIpgsEwenVAMTp8XDdwkFzJ9CE49a+syYKTlj1v93C29FXxWx0wr8t7tU78XjhHdv
        OzXvzj2xIUJ6k7VVX9UJgdNnop50rHgs3JlsyRPu++bLH3MbxXk1zAe7Es9V/Ztw2lazVuPu
        I6Pz4uufNJ99+d+k+5L01gMfLv562LNU9OLWs72XtDZb+K5YXpL255xgZeD/5H3Per84zZBK
        //F6x7d506eVdKeKrVp080bB7W1ux1/pxmvX33WfIBKrxrPTrYaHgTd42duk6iUhE17vuWUh
        YBua9F3lwJtKHy6jgEvHze8dK9Fgjt703rWAbW2E5fZfijvTyjc83BicuLaRXSD7DDf7ZtcG
        oe4zVeeS1OsKvrj6v56sqMRSnJFoqMVcVJwIAJkNKTfcAwAA
X-CMS-RootMailID: 20210225075653epcas5p3d9551f01177d0c851c9c37f6ae84f38d
References: <1614239800-27549-1-git-send-email-maninder1.s@samsung.com>
        <CGME20210225075653epcas5p3d9551f01177d0c851c9c37f6ae84f38d@epcms5p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any comments or updates?

>Sender : Maninder Singh <maninder1.s@samsung.com> Engineer/Platform S/W Group /SRI-Delhi/Samsung Electronics 
>Date : 2021-02-25 13:57 (GMT+5:30)
>Title : [PATCH v2] arm: print alloc free paths for address in registers
> 
>In case of "Use After Free" kernel OOPs, free path of object
>is required to debug futher.
>And in most of cases object address is present in one of registers.
> 
>Thus check for register address and if it belongs to slab,
>print its alloc and free path.
> 
>e.g. in below issue  register r6 belongs to slab, and use after free issue
>occurred on one of its derefer values:
> 
>[  124.310386] (ptrval)
>[  124.312647] 8<--- cut here ---
>[  124.313761] Unable to handle kernel paging request at virtual address 6b6b6b6f
>[  124.315972] pgd = (ptrval)
>...
>[  124.328290] pc : [<c052fc0c>]    lr : [<c052fc00>]    psr: 60000013
>[  124.330349] sp : c8993d28  ip : 0000bff4  fp : c8ae2020
>[  124.332071] r10: 00000000  r9 : 00000001  r8 : c1804cc8
>[  124.333803] r7 : 00000000  r6 : c8ae9180  r5 : c1804a80  r4 : c8ae2008
>[  124.335936] r3 : 6b6b6b6b  r2 : 315049d6  r1 : 2d867000  r0 : c1396584
>..
>[  124.365233] register r6: c8ae9180 belongs to slab object
>[  124.366364] INFO: Allocated in meminfo_proc_show+0x3c/0x500 age=1 cpu=0 pid=69
>[  124.367545]  meminfo_proc_show+0x3c/0x500
>[  124.368271]  seq_read_iter+0x10c/0x4bc
>[  124.368994]  proc_reg_read_iter+0x74/0xa8
>[  124.369712]  generic_file_splice_read+0xe8/0x178
>[  124.370496]  splice_direct_to_actor+0xe0/0x2b8
>[  124.371261]  do_splice_direct+0xa4/0xdc
>[  124.371917]  do_sendfile+0x1c4/0x3ec
>[  124.372550]  sys_sendfile64+0x128/0x130
>[  124.373109]  ret_fast_syscall+0x0/0x54
>[  124.373664]  0xbe9a2de4
>[  124.374081] INFO: Freed in meminfo_proc_show+0x5c/0x500 age=1 cpu=0 pid=69
>[  124.374933]  meminfo_proc_show+0x5c/0x500
>[  124.375485]  seq_read_iter+0x10c/0x4bc
>[  124.376020]  proc_reg_read_iter+0x74/0xa8
>[  124.376643]  generic_file_splice_read+0xe8/0x178
>[  124.377331]  splice_direct_to_actor+0xe0/0x2b8
>[  124.378022]  do_splice_direct+0xa4/0xdc
>[  124.378633]  do_sendfile+0x1c4/0x3ec
>[  124.379220]  sys_sendfile64+0x128/0x130
>[  124.379822]  ret_fast_syscall+0x0/0x54
>[  124.380421]  0xbe9a2de4
> 
>Co-developed-by: Vaneet Narang <v.narang@samsung.com>
>Signed-off-by: Vaneet Narang <v.narang@samsung.com>
>Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
>---
>v1 -> v2: do address sanity with virt_addr_valid
> 
> arch/arm/include/asm/bug.h |  1 +
> arch/arm/kernel/process.c  | 18 ++++++++++++++++++
> arch/arm/kernel/traps.c    |  1 +
> include/linux/slab.h       | 14 ++++++++++++++
> mm/slab.h                  |  7 -------
> mm/slub.c                  | 18 ++++++++++++++++++
> 6 files changed, 52 insertions(+), 7 deletions(-)
 

Thanks,
Maninder Singh
