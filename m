Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C048B4291F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbhJKOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:35:56 -0400
Received: from pv50p00im-ztdg10021201.me.com ([17.58.6.45]:51945 "EHLO
        pv50p00im-ztdg10021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238894AbhJKOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1633962833; bh=S/rO3t5kGrdWm1xhXFL4TLxjsZk3v/TPzAq6dFPoZlM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=CKlxGcHgRPUv3QJCU04YubemLAoYo8cGqUO2mftxV14cixjb/P25peyNfRLktV9xl
         EUNXrOHa7oLDH4kL5f465Nrm7bXqrJHWFe9KjCv804CNHeKuovhEM2wuTqxLgrrWFH
         SnTkFdZiIYWF93IhiY4ouSJviLesODab2k6YXXk6Nkl6puTV/+pBvxfzXD6j71ITs3
         nXSANPrLDGu5Hr7tzYqaB9i5F2z4X6LBhTnxSH7fRMa5hmN8jHz39i7L62vf95g65u
         gxNZ/dIM8dH72qNs0bggbS4pD8bVSvJW0D2x734nPpNcJXYlpOquGJAs6enNpjNM6W
         7y+4pnQmQgdag==
Received: from xiongwei.. (unknown [120.245.2.114])
        by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 71442A405F4;
        Mon, 11 Oct 2021 14:33:45 +0000 (UTC)
From:   sxwjean@me.com
To:     linux-mm@kvack.org, x86@kernel.org
Cc:     Xiongwei Song <sxwjean@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Huang Rui <ray.huang@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Balbir Singh <sblbir@amazon.com>,
        "David S. Miller" <davem@davemloft.net>, sxwjean@me.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] mm/util: Assign a meaningful value to mmap_legacy_base
Date:   Mon, 11 Oct 2021 22:31:45 +0800
Message-Id: <20211011143150.318239-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011143150.318239-1-sxwjean@me.com>
References: <20211011143150.318239-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-11_05:2021-10-07,2021-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=660 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110110085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Let's assign a value to mmap_legacy_base in case the mmap() of some
archs needs mmap_legacy_base, like x86.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 mm/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index e58151a61255..40b1a8837c0b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -414,7 +414,8 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 		random_factor = arch_mmap_rnd();
 
 	if (mmap_is_legacy(rlim_stack)) {
-		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
+		mm->mmap_legacy_base = TASK_UNMAPPED_BASE + random_factor;
+		mm->mmap_base = mm->mmap_legacy_base;
 		mm->get_unmapped_area = arch_get_unmapped_area;
 	} else {
 		mm->mmap_base = mmap_base(random_factor, rlim_stack);
-- 
2.30.2

