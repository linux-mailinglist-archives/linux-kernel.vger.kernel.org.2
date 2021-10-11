Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4454291F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbhJKOgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:36:46 -0400
Received: from pv50p00im-ztdg10021201.me.com ([17.58.6.45]:54349 "EHLO
        pv50p00im-ztdg10021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237681AbhJKOgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1633962884; bh=zndHJQMckuIsuSAxefaz/RuLzDT/zZs8QBH0iDHV99s=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=rzkYzsShBt1lpFWKMBxjeKqME+bJ0Ypsf4nH2nS0EJRfT8JdWrNqhG37h5243qrXV
         zIf1RWwCAwtGyYM9IdyL+5cxX7baJw99pYkHTMOnRN2XKvnltd2lWTscgKRZSXeHbD
         6QFxW/+EcmJgw2Q7ApCkpSVQeV3RoirSDgpYuTezm3QsyZgj4bbmSskgwSilvIf60U
         tDaFYT5Gj54Z3SDvlkdLiBqzPn8SHnKxCbVoF66YKPCZzIEla2kUbId7YkQqu33eXy
         q7ptHrxtYiqXvpxY8GZgiOkveoZXdAEf0Q3RHsg76iYOe3F1xTd3p20Om5C07uTk/6
         viQgZmwky7tLg==
Received: from xiongwei.. (unknown [120.245.2.114])
        by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 0A887A4058C;
        Mon, 11 Oct 2021 14:34:35 +0000 (UTC)
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
Subject: [PATCH v2 5/6] x86/mm: Discard the defination of HAVE_ARCH_PICK_MMAP_LAYOUT
Date:   Mon, 11 Oct 2021 22:31:49 +0800
Message-Id: <20211011143150.318239-6-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011143150.318239-1-sxwjean@me.com>
References: <20211011143150.318239-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-11_05:2021-10-07,2021-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=753 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110110085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

We've enabled ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT, we will always use
generic arch_pick_mmap_layout(), therefore don't need
HAVE_ARCH_PICK_MMAP_LAYOUT any more.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/x86/include/asm/processor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index fb7a4f21d412..2360366ad328 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -709,7 +709,6 @@ extern int			bootloader_version;
 
 extern char			ignore_fpu_irq;
 
-#define HAVE_ARCH_PICK_MMAP_LAYOUT 1
 #define ARCH_HAS_PREFETCHW
 #define ARCH_HAS_SPINLOCK_PREFETCH
 
-- 
2.30.2

