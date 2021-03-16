Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9BE33D1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbhCPKmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:42:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:14757 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbhCPKl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:41:59 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210316104156epoutp0304616637d03d7dcfac231e384c14c4a2~szJdZpksS1978119781epoutp03C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:41:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210316104156epoutp0304616637d03d7dcfac231e384c14c4a2~szJdZpksS1978119781epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615891316;
        bh=AZBqEzrIJ+EQPsQY82SYKnUwBKM6tjji8hOw6zf6MF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbFOrMSbNQSShyflQOAE9fNoD7r9gP0WYOEQ3GcH49m2kOQmjz4OZafjqhvIVfAsl
         9EgUWZSNJ7QyzMBEopE9b1YDgutba8JVSVuMh+D6YZH8vEHeMSlK0tODi7Oili2d9Z
         csxnHycTZaOGHWHAgbrf5sZVX1EVRS26a5UMurRg=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210316104155epcas5p1cfe2f45e4abb74afd0c0f32bcc3f23cf~szJcS9_If1128311283epcas5p1S;
        Tue, 16 Mar 2021 10:41:55 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.86.50652.37B80506; Tue, 16 Mar 2021 19:41:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210316103736epcas5p3758de57b57c732074acc0989e563cc2e~szFrQSoU90709807098epcas5p3h;
        Tue, 16 Mar 2021 10:37:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210316103736epsmtrp2f433189e0f4e53fde840273718138b3c~szFrOVmg62017920179epsmtrp2Y;
        Tue, 16 Mar 2021 10:37:36 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-78-60508b736409
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.06.13470.07A80506; Tue, 16 Mar 2021 19:37:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210316103733epsmtip1dce460b74720998e9947118fad745ffa~szFoZg0_83001630016epsmtip1V;
        Tue, 16 Mar 2021 10:37:33 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     paulmck@kernel.org, linux@armlinux.org.uk, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, 0x7f454c46@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, a.sahrawat@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH 2/3] mm/slub: Add Support for free path information of an
 object.
Date:   Tue, 16 Mar 2021 16:07:11 +0530
Message-Id: <1615891032-29160-2-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUxTVxjHPffetpeaLieFbQfYcGMgygRFpp4hmfuwlxuyGLaZJepIafCI
        ZrTU3sKYX1bty0YJDBQELWx1a4grzmqLeimQsdYXXKaToSBWeY9DlAlla8IIupQL2bffef7P
        //k/5+SwtPKiJI7drzUQvVZdlCiVMxcCa1PS+Irc/A1dTfG4+tgEg3vaCW50n5bi/vBjgH+s
        MEmxZ6xPgnt9jVI8ePqZBPvrOgEOfGdlcMgZZrB19qkEW53nKOy/1gSw/VAVwL8vXJW8Dbne
        vh6aaztxX8Y5PCWcx1Uu5TyhIzLONnWL4rob5hlu/FY9xXmdX3JVrS7A/ea4JONmPQmcZ3yK
        ylXskmfvIUX7S4l+/Vv58n2Tged1llVlNY5OmREMIxuIYhF8A/X0HZbagJxVwnaA/nxqZiKC
        EoYAOnJ5oyiEARoJnqGWHYM+gRKFToCGzpslouNvgLpCOMJSmI5cvo7FSTHwHkCjhwwRAw2v
        ADR3/edFIRp+jBqCArABlmVgMpr7mkTKCvg+clQ2LYUloIEb5XSEoyCHGnxuJjIHwW4Weese
        LDW9gx4++R6IHI0mr7bKRI5Ds391SkVDBUDHG3tp8dACkGeiXyJ2bUOPTEYqsgUN1yK3b71Y
        fhnV/SpemYbPocr58aUwBRK+XeZkZB44uzQmHs3OzDAic+hxeR8Qn8gOUEtgiK4GCSf+j3AA
        4AKxRMdrCgm/SbdRSz5P59UavkRbmF5QrPGAxb+VmiOAkeHpdD+gWOAHiKUTYxSbtLn5SsUe
        9RcHib5YpS8pIrwfxLNM4osKYcOwSgkL1QbyGSE6ol9WKTYqzkiteslpLb1+RWW/88+7Krs6
        a00BXYZMb67bwi8EjfWfZk66UrJfq755Zos3tjaPBHHjL4K+e3A16d/8UZvmrq7UZLF8qM4p
        Tjo6nxqNVq5oqPtKPp+WmZOp+MPtndtpxtdamtq4yVrbiMH9zJI0AE9p6HMFXPHCYLhmOjrq
        sOvh0PZtXV3G9550/HCpYgiOZ9w+O5rcPPNKbNa6zZVHk7em1eTlWmFh9iP65lRz2VbC0q/u
        zjo4ajo1cSH4gARa4UhtVeXrtpMv/DuQ0n4giRpr+8Zwca8QXGEmcZaOoh3TH3gzPjl29yfV
        gWaJcFyZNze2EgvOGXv8jVB9zK6wLJHh96kzUmk9r/4PhkxqX8oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnG5BV0CCwYc3ShYTpr1gsbi4O9Vi
        zvo1bBbXv71htFjZ3cxmsenxNVaLy7vmsFncW/Of1eLQ1L2MFofnt7FYfFryjcWi7fM/Vou2
        JRuZLA6dnMtoMbuxj9Hi/N/jrA4CHpevXWT22DnrLrvHgk2lHptWdbJ5bPo0id2j6+0VJo8T
        M36zeDy5Mp3JY/OSeo++LasYPc4sOMLu8XmTnMemJ2+ZAnijuGxSUnMyy1KL9O0SuDJeHRYt
        aJWvmLhgL3sD4wOJLkZODgkBE4l7u3YwdTFycQgJ7GaUWNX4nxEiIS3x8997FghbWGLlv+fs
        EEWfGCXa2i6CJdgE9CRW7drDApIQEXjBKLFmz0qwUcwCZxgl3l2dywRSJSwQKNE97yxbFyMH
        B4uAqsTPjlSQMK+Au8SCXogSCQE5iZvnOplBbE4BD4kZu9aDLRACqpn3+jfbBEa+BYwMqxgl
        UwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNDS3MH4/ZVH/QOMTJxMB5ilOBgVhLhNc0L
        SBDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBKemI8ZZd
        Bp0Cc1X07L6wyKRPV3sWdbVV9+1yxlsJ4UvcW/5aRe1zdT+Uz7L4zcoJ5gfunFyjVfDWv1eC
        d+Opjrl7A3imbm6Uf/KkLmVpQfQxNwOpn6KJ04SDXCc8D3y4VorfN/PBUXdRhv5ptjMvmGfu
        un1nmdf+LAvl+aExs+5s+fdLWHvzimbh1n8dK/smMEu9MzmcHFAt5bb2itO/Wy/C5J6lnrp0
        ZvLOH98lIqJ/cjX6BRYtvCSj8XqDtEzUw0sRf+bYzle8kbz6j0DWNX+bu07r1mvdWrFkr5vc
        U7dU4Y8XTrxQWKPHJFPqdDBgScryxBU/fEXLFK5xybNP9m09den7yidrfd83TbEUuqDEUpyR
        aKjFXFScCACxHnsJ/AIAAA==
X-CMS-MailID: 20210316103736epcas5p3758de57b57c732074acc0989e563cc2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210316103736epcas5p3758de57b57c732074acc0989e563cc2e
References: <1615891032-29160-1-git-send-email-maninder1.s@samsung.com>
        <CGME20210316103736epcas5p3758de57b57c732074acc0989e563cc2e@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for inforamtion of free path along with allocation
path of an object:

slab kmalloc-64 start c8ab0140 data offset 64 pointer offset 0 size 64 allocated at meminfo_proc_show+0x40/0x4fc
[   20.192078]     meminfo_proc_show+0x40/0x4fc
[   20.192263]     seq_read_iter+0x18c/0x4c4
[   20.192430]     proc_reg_read_iter+0x84/0xac
[   20.192617]     generic_file_splice_read+0xe8/0x17c
[   20.192816]     splice_direct_to_actor+0xb8/0x290
[   20.193008]     do_splice_direct+0xa0/0xe0
[   20.193185]     do_sendfile+0x2d0/0x438
[   20.193345]     sys_sendfile64+0x12c/0x140
[   20.193523]     ret_fast_syscall+0x0/0x58
[   20.193695]     0xbeeacde4
[   20.193822]  Free path:
[   20.193935]     meminfo_proc_show+0x5c/0x4fc
[   20.194115]     seq_read_iter+0x18c/0x4c4
[   20.194285]     proc_reg_read_iter+0x84/0xac
[   20.194475]     generic_file_splice_read+0xe8/0x17c
[   20.194685]     splice_direct_to_actor+0xb8/0x290
[   20.194870]     do_splice_direct+0xa0/0xe0
[   20.195014]     do_sendfile+0x2d0/0x438
[   20.195174]     sys_sendfile64+0x12c/0x140
[   20.195336]     ret_fast_syscall+0x0/0x58
[   20.195491]     0xbeeacde4

Co-developed-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 mm/slab.h        |  1 +
 mm/slab_common.c | 12 +++++++++++-
 mm/slub.c        |  7 +++++++
 mm/util.c        |  2 +-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index c96bca9825d9..e360e3326232 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -644,6 +644,7 @@ struct kmem_obj_info {
 	struct kmem_cache *kp_slab_cache;
 	void *kp_ret;
 	void *kp_stack[KS_ADDRS_COUNT];
+	void *kp_free_stack[KS_ADDRS_COUNT];
 };
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page);
 #endif
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4c6107e39f9a..42288db97a52 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -556,7 +556,7 @@ EXPORT_SYMBOL_GPL(kmem_valid_obj);
  * depends on the type of object and on how much debugging is enabled.
  * For a slab-cache object, the fact that it is a slab object is printed,
  * and, if available, the slab name, return address, and stack trace from
- * the allocation of that object.
+ * the allocation and last free path of that object.
  *
  * This function will splat if passed a pointer to a non-slab object.
  * If you are not sure what type of object you have, you should instead
@@ -601,6 +601,16 @@ void kmem_dump_obj(void *object)
 			break;
 		pr_info("    %pS\n", kp.kp_stack[i]);
 	}
+
+	if (kp.kp_free_stack[0])
+		pr_cont(" Free path:\n");
+
+	for (i = 0; i < ARRAY_SIZE(kp.kp_free_stack); i++) {
+		if (!kp.kp_free_stack[i])
+			break;
+		pr_info("    %pS\n", kp.kp_free_stack[i]);
+	}
+
 }
 EXPORT_SYMBOL_GPL(kmem_dump_obj);
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index 9d13f0117ae6..a0cb90487b1a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4061,6 +4061,13 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 		if (!kpp->kp_stack[i])
 			break;
 	}
+
+	trackp = get_track(s, objp, TRACK_FREE);
+	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
+		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
+		if (!kpp->kp_free_stack[i])
+			break;
+	}
 #endif
 #endif
 }
diff --git a/mm/util.c b/mm/util.c
index 143c627fb3e8..9d69ca30514a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -993,7 +993,7 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
  * depends on the type of object and on how much debugging is enabled.
  * For example, for a slab-cache object, the slab name is printed, and,
  * if available, the return address and stack trace from the allocation
- * of that object.
+ * and last free path of that object.
  */
 void mem_dump_obj(void *object)
 {
-- 
2.17.1

