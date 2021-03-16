Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C633D1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhCPKjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:39:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46792 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbhCPKhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:37:41 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210316103738epoutp02e099c7bece7ca96e6970fbbdab4e5113~szFs4xybw1036610366epoutp02I
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:37:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210316103738epoutp02e099c7bece7ca96e6970fbbdab4e5113~szFs4xybw1036610366epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615891058;
        bh=zVp1lULJSzJzWkT0nt/+4XoH7dIWFg42lLkd8R1wp5M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UmX7utGZIqoKX+lXX9IpyfIpF5Qu4jXli/tYl3Pl0SZJgdSdnaCrrPU1bAfmADi3X
         kelCgVH4zocRHv1p+NLj4ZQlXE2rlW8lSnDCLvZA4Ya/dAC8lZAutEA6FdtX01CC9G
         UDmsf9kOL06mSOO4S/m1t6WoGSt6PHK3qJRvV6ak=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210316103737epcas5p357826eb7590176980dd7ac29ddd09223~szFsI7qKb0250502505epcas5p3N;
        Tue, 16 Mar 2021 10:37:37 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.75.50652.17A80506; Tue, 16 Mar 2021 19:37:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210316103723epcas5p1f750d5cfe029fa69aea8d88f0bd408f3~szFfVwOEq2891628916epcas5p1p;
        Tue, 16 Mar 2021 10:37:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210316103723epsmtrp27a6724ac6f9dfdeed34fceba9b3a48fd~szFfUDvU12017920179epsmtrp2M;
        Tue, 16 Mar 2021 10:37:23 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-d7-60508a718347
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.07.08745.36A80506; Tue, 16 Mar 2021 19:37:23 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210316103720epsmtip11d45f7ad1d964ea47973eb8b3682fff1~szFceVOpc3148731487epsmtip1p;
        Tue, 16 Mar 2021 10:37:20 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     paulmck@kernel.org, linux@armlinux.org.uk, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, 0x7f454c46@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 1/3] mm/slub: fixing backtrace of objects because of redzone
 adjustment
Date:   Tue, 16 Mar 2021 16:07:10 +0530
Message-Id: <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7bCmum5hV0CCwb3jihYTpr1gsbi4O9Vi
        zvo1bBbXv71htFjZ3cxmsenxNVaLy7vmsFncW/Of1eLQ1L2MFofnt7FYfFryjcWi7fM/Vou2
        JRuZLA6dnMtoMbuxj9Hi/N/jrA4CHpevXWT22DnrLrvHgk2lHptWdbJ5bPo0id2j6+0VJo8T
        M36zeDy5Mp3JY/OSeo++LasYPc4sOMLu8XmTnMemJ2+ZAnijuGxSUnMyy1KL9O0SuDL+9b9k
        L2gUrHi3YTFbA+NK3i5GTg4JAROJDRN3MXUxcnEICexmlNjVdJUZwvnEKHH9YSuU85lR4svW
        ViaYlt0vD7FAJHYxSnTu3Q5V9QXIufqMEaSKTUBPYtWuPSwgtojAHUaJR40lIEXMAscYJX6e
        3Q+WEBaIlHhy/DWYzSKgKvHgxwZmEJtXwF1i040nrBDr5CRunusE2yAhsJJDoqFrITNEwkXi
        cNc/qJuEJV4d38IOYUtJfH63lw2ioZtRYuacy1DdqxklNr24DjXWXuJ1cwNQNwfQTZoS63fp
        Q4RlJaaeWgc2lFmAT6L39xOoBbwSO+bB2KoSLTc3QI2Rlvj88SMLhO0h8X/9PbDjhARiJS6u
        usoygVF2FsKGBYyMqxglUwuKc9NTi00LjPJSy/WKE3OLS/PS9ZLzczcxgpOUltcOxocPPugd
        YmTiYDzEKMHBrCTCa5oXkCDEm5JYWZValB9fVJqTWnyIUZqDRUmcd4fBg3ghgfTEktTs1NSC
        1CKYLBMHp1QD0z62SjO/OK7P8ml2X6NCJpTe+HLB7Yx0DPMcla4y7xn8qx0Nwt4qz5pwM+Np
        ghZn3t57Z08a9J93W5ouaGgZwbneYP29+tvrZpa3VRRM359XUKd0zPAAs7RBFdenjzKrn3f8
        jpv7uXHPiT33OMWM3ZcIXOo6xeEVVm+n6v5u/luD5IPbNnC+yJ/w6r5T8rtHlm7XOw3LHBtT
        8hPlgkJVHi0tn3RNm3/7i4PLZDudFnXd7hM/HcI4tWtfk0vnhQq72n3iau6y+YlbC8KPsN2L
        y3ryRPxq/x8nzv0Hy086Mx82e++4hOuIT17BmoKSyXk5xpzTp8uuLozw3NH5Rbhmg53v5Ab5
        t1xZyzIy8yYpsRRnJBpqMRcVJwIADJC1xMEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnG5yV0CCQcMLPYsJ016wWFzcnWox
        Z/0aNovr394wWqzsbmaz2PT4GqvF5V1z2CzurfnPanFo6l5Gi8Pz21gsPi35xmLR9vkfq0Xb
        ko1MFodOzmW0mN3Yx2hx/u9xVgcBj8vXLjJ77Jx1l91jwaZSj02rOtk8Nn2axO7R9fYKk8eJ
        Gb9ZPJ5cmc7ksXlJvUffllWMHmcWHGH3+LxJzmPTk7dMAbxRXDYpqTmZZalF+nYJXBn/+l+y
        FzQKVrzbsJitgXElbxcjJ4eEgInE7peHWLoYuTiEBHYwSvx7fZwNIiEt8fPfexYIW1hi5b/n
        7BBFnxgl5s3fyg6SYBPQk1i1aw9Yt4jAC0aJNXtWMoE4zAJnGCXeXZ0L5HBwCAuES/TciwZp
        YBFQlXjwYwMziM0r4C6x6cYTVogNchI3z3UyT2DkWcDIsIpRMrWgODc9t9iwwCgvtVyvODG3
        uDQvXS85P3cTIzjYtbR2MO5Z9UHvECMTB+MhRgkOZiURXtO8gAQh3pTEyqrUovz4otKc1OJD
        jNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamM62rbm5JmtiOI9TecMbvc5nL42dxYx7
        OUJrBFTuOLzJzNM7L2/szz5rd29RfPVcN9cZ/vavVfQCVq5ZXPhifroyU31f3Ynw4w+4c9uv
        yu+e4OhWMoP5TuIU/w0TVzL+nM6/o85h5/EHM2cKWGx5UbPJ7PFtkSe3upZoz5spdtH09/Gs
        vv8tgW/KXH2bFjHcZPA9cF6nqrrb/LjosxURx/ht7N4u/xN295XxDv6DcRriNaL/s7gqHjL2
        FjJ7yXr8Pv2ZIXPvxtOT62eut4kReJzJpB1WrXXq/pwAW6a/PSt3+d85o3O+eePFOu3rPt/m
        mdRJ33D7e8FKzK351GbLh7O2xM09kaO7Jn6t5a5l6UosxRmJhlrMRcWJAIOIKurlAgAA
X-CMS-MailID: 20210316103723epcas5p1f750d5cfe029fa69aea8d88f0bd408f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210316103723epcas5p1f750d5cfe029fa69aea8d88f0bd408f3
References: <CGME20210316103723epcas5p1f750d5cfe029fa69aea8d88f0bd408f3@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixing commit 8e7f37f2aaa5 ("mm: Add mem_dump_obj() to print source
of memory block")

with current code, Backtrace of allocated object is coming wrong:
/ # cat /proc/meminfo
[   14.969843]  slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 0 size 64 allocated at 0x6b6b6b6b
[   14.970635]     0x6b6b6b6b
[   14.970794]     0x6b6b6b6b
[   14.970932]     0x6b6b6b6b
[   14.971077]     0x6b6b6b6b
[   14.971202]     0x6b6b6b6b
[   14.971317]     0x6b6b6b6b
[   14.971423]     0x6b6b6b6b
[   14.971635]     0x6b6b6b6b
[   14.971740]     0x6b6b6b6b
[   14.971871]     0x6b6b6b6b
[   14.972229]     0x6b6b6b6b
[   14.972363]     0x6b6b6b6b
[   14.972505]     0xa56b6b6b
[   14.972631]     0xbbbbbbbb
[   14.972734]     0xc8ab0400
[   14.972891]     meminfo_proc_show+0x40/0x4fc

And reason is red zone was not adjusted from object address.
after adding fixup for redzone, backtrace is coming correct:
/ # cat /proc/meminfo
[   14.870782]  slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 128 size 64 allocated at meminfo_proc_show+0x40/0x4f4
[   14.871817]     meminfo_proc_show+0x40/0x4f4
[   14.872035]     seq_read_iter+0x18c/0x4c4
[   14.872229]     proc_reg_read_iter+0x84/0xac
[   14.872433]     generic_file_splice_read+0xe8/0x17c
[   14.872621]     splice_direct_to_actor+0xb8/0x290
[   14.872747]     do_splice_direct+0xa0/0xe0
[   14.872896]     do_sendfile+0x2d0/0x438
[   14.873044]     sys_sendfile64+0x12c/0x140
[   14.873229]     ret_fast_syscall+0x0/0x58
[   14.873372]     0xbe861de4

Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index 1912c4614248..9d13f0117ae6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4052,6 +4052,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 	    !(s->flags & SLAB_STORE_USER))
 		return;
 #ifdef CONFIG_SLUB_DEBUG
+	objp = fixup_red_left(s, objp);
 	trackp = get_track(s, objp, TRACK_ALLOC);
 	kpp->kp_ret = (void *)trackp->addr;
 #ifdef CONFIG_STACKTRACE
-- 
2.17.1

