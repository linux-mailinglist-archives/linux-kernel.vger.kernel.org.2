Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D1441324A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhIULNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:13:47 -0400
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:41095 "EHLO
        pv50p00im-ztdg10011301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232268AbhIULNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:13:45 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2021 07:13:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1632222252; bh=qKQEOuLkz9rupJ8tm470ugxnMVFuW3h1Tk7tw22voKM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=NViApuCru0vMSJB5RPBpcMC2Of1EMzEt7tUr73/fopKQysEDa1rGjH+qDwo0Mr3xM
         1Y2J1HUWF1ASGWnUiWElYzMS8mNYiqaywWCUdNSKvlYGibc/8vqdhoynixtETOa0Em
         88AORBjmVXyihSXh741XG/yLZZ/LQcEXNfL8rSWo8A+9mOeKwt55qK60jOxG5+ZCPn
         BbxW7bEBWoLm7NZ1FgqBjuUeRwP2bTMzNc0yPzeqMkIzBhW02Bjy/fMtqGjFcsnjCs
         1XgVTq9JmYGb3iw2veLo4G8yQUkY2XMVFuSJQfhkAUSor+YgZ4hpmagt4eD3DjchEE
         LqkwxhGFyzr8Q==
Received: from xiongwei.. (unknown [120.245.3.37])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id B2FD276035E;
        Tue, 21 Sep 2021 11:03:55 +0000 (UTC)
From:   sxwjean@me.com
To:     x86@kernel.org, linux-mm@kvack.org
Cc:     sxwjean@me.com, Xiongwei Song <sxwjean@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Balbir Singh <sblbir@amazon.com>, Jens Axboe <axboe@kernel.dk>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Metzmacher <metze@samba.org>,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Use generic code for virtual address of randomization of x86
Date:   Tue, 21 Sep 2021 19:02:50 +0800
Message-Id: <20210921110252.2593542-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-21_01:2021-09-20,2021-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2109210070
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Balbir Singh <sblbir@amazon.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Lai Jiangshan <laijs@linux.alibaba.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Stefan Metzmacher <metze@samba.org>
Cc: Marco Elver <elver@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org

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

