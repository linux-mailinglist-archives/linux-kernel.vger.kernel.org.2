Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9E4291FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhJKOhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:37:00 -0400
Received: from pv50p00im-ztdg10021201.me.com ([17.58.6.45]:54907 "EHLO
        pv50p00im-ztdg10021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238218AbhJKOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1633962897; bh=rMjqF8p2H8lUjZ2VlYFQ5hXfZXc5FGmYjLg2tXh24fE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=1jVIgJJ+tdFal/9Zs6V3JlJf+4SooXhYBY406CJoFdyCr5gcOh7Eivf5lmdvX9kpn
         kQMD6EkUU6CISQrvISa45LEB3ECOkXUSrGxCPCVuneWZDtUuo5LAiRLyM2v7T2enT/
         GWY3+dvR6J21GfngLP/CCboQfXOu5zT7rBaRoLJFPU5b/vDrPP8Wu1kOkzUWQXVuIl
         4nyl6k5FWXhp97NifmxhRz7clQHuYReRnY8FPnmKC01/RdxIXOMXMFzhm7SMgcPuq7
         Dcq+FGYRBnm2m8YqcTIfq0MfagGo0gCAmZwNHxH6PSDObW0ZMoAVKGb3k3WzavJu0u
         7/HkFEqZgpu6Q==
Received: from xiongwei.. (unknown [120.245.2.114])
        by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id 7CC13A402CE;
        Mon, 11 Oct 2021 14:34:47 +0000 (UTC)
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
Subject: [PATCH v2 6/6] x86/elf: Discard ARCH_HAS_ELF_RANDOMIZE selection
Date:   Mon, 11 Oct 2021 22:31:50 +0800
Message-Id: <20211011143150.318239-7-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011143150.318239-1-sxwjean@me.com>
References: <20211011143150.318239-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-11_05:2021-10-07,2021-10-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=679 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110110085
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

We've enabled ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT, which always selects
ARCH_HAS_ELF_RANDOMIZE at the same time, so no need to select this config
again.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 01a40b710103..2f7fbe06e6b4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -72,7 +72,6 @@ config X86
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
-	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
-- 
2.30.2

