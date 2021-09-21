Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A56413569
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhIUOgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:36:24 -0400
Received: from pv50p00im-ztdg10021801.me.com ([17.58.6.56]:36877 "EHLO
        pv50p00im-ztdg10021801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233598AbhIUOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1632234894; bh=mt5z+MTvIXfkfJHGwkXCnjTCaO1yXPjuyx+vnuzqbpY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=dZtu7zQjb8UDJQ6/fAx52qpNf0Eo/pPzoKYPxNYvhwF7NuySopjA2HmpyGd/dvAyB
         XgkhwVQGM4mFHBHtscAG8NvC1vG1SrVB8467IVQqdvuvqaaF/B6cbtOxknKoxXAP/h
         VpJ7uNCE8RRSgHWRSib02SqXuc0xw7gkEgOcmdFTJtrpvePq6dgBlvJLZvluYZLMCk
         X1NgGiXW6D9Y+K3K2MEhLzFAYjVb0sV9dpjEg1nZMFeDh+BaHMhf4fzc6pdS7Yu00I
         AswAK9LVmadh8zxDkIdMhwgoOVlZK80xh2R66uKUBoMQLoNIzecQcaNNLWicuOVII6
         W6i6GKFEPF/pw==
Received: from xiongwei.. (unknown [120.245.3.37])
        by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 3D93C360390;
        Tue, 21 Sep 2021 14:34:36 +0000 (UTC)
From:   sxwjean@me.com
To:     x86@kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@kernel.org, krisman@collabora.com, chang.seok.bae@intel.com,
        viro@zeniv.linux.org.uk, nivedita@alum.mit.edu,
        adobriyan@gmail.com, oleg@redhat.com, sblbir@amazon.com,
        axboe@kernel.dk, laijs@linux.alibaba.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        akpm@linux-foundation.org, arnd@arndb.de, davem@davemloft.net,
        keescook@chromium.org, kim.phillips@amd.com, yazen.ghannam@amd.com,
        dave@stgolabs.net, metze@samba.org, elver@google.com,
        ebiederm@xmission.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH RESEND 0/2] Use generic code for randomization of virtual address of x86
Date:   Tue, 21 Sep 2021 22:34:12 +0800
Message-Id: <20210921143414.70723-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-21_04:2021-09-20,2021-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=233 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2109210090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Hello,

The two patches are to use generic code for randomization of virtual
address of x86. Since the basic code logic of x86 is same as generic
code, so no need to implement these functions on x86, please see the
details in comments of patch 2.

Please review it.

Why resend?
Because I missed email addresses for patch 1 and 2, so resend the patches.
Sorry for the inconvenience.

Xiongwei Song (2):
  x86: Rename TIF_ADDR32 to TIF_32BIT
  x86/mm: Randomize va with generic arch_pick_mmap_layout()

 arch/x86/Kconfig                     |   2 +-
 arch/x86/include/asm/compat.h        |   7 +-
 arch/x86/include/asm/elf.h           |   2 +-
 arch/x86/include/asm/page_64_types.h |   6 +-
 arch/x86/include/asm/processor.h     |   4 +-
 arch/x86/include/asm/thread_info.h   |   4 +-
 arch/x86/kernel/process.c            |   5 --
 arch/x86/kernel/process_64.c         |   4 +-
 arch/x86/mm/mmap.c                   | 112 ---------------------------
 include/linux/compat.h               |   4 +
 mm/util.c                            |  18 ++++-
 11 files changed, 37 insertions(+), 131 deletions(-)

-- 
2.30.2

