Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB7742DA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJNNaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:30:07 -0400
Received: from pv50p00im-ztdg10012101.me.com ([17.58.6.49]:55678 "EHLO
        pv50p00im-ztdg10012101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230205AbhJNNaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1634218079; bh=ioeyMh1fVUj2FYx8w3KntYnoV4hKPLsAV3hhLziJXG4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=TzWa8C4cJrwugglBVAX7RyCCL8yWcXxekkOrouDoYVd/EdLZLuLrtzkIhFfXdMby3
         5PY85vEY8f9UavsWEFuPm4w2lXcy9VFgtyVgLRcjsRKXKkLEgCfSG8rw2axmtt9MWO
         HjatUEuTHrWTSvoXFIeIvhvN6p7lfSIDUzD8zxyayNoTZod3SzxJFtScaY3O7j5zcW
         NLDlJCd1SHYIuMzm/gd/8cvpcXr46CxV3k8cvKUUHsX4dsEMeNjPUFbf89+EwN4kyz
         9ToCqaENvsq0CxWADJQrmaQ8Z68xfVghYKbjs4FzAI3onFzFJV8kPtF3fdGE7lDYMk
         KF3bK9LK0rIAw==
Received: from xiongwei.. (unknown [120.245.2.212])
        by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 20707840794;
        Thu, 14 Oct 2021 13:27:54 +0000 (UTC)
From:   sxwjean@me.com
To:     x86@kernel.org
Cc:     Xiongwei Song <sxwjean@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] x86/elf: Fix incorrect STACK_RND_MASK for x86_64
Date:   Thu, 14 Oct 2021 21:27:36 +0800
Message-Id: <20211014132736.266553-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-10-14_05:2021-10-14,2021-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2110140086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

According to the comment for stack randomization of x86, the range of
randomization is 1GB, which occupies 30 valid bits in binary. And in
x86_64, PAGE_SHIFT occupies 12 bits, then the STACK_RND_MASK should
occupy 18 bits for 1GB.

The current range of randomization is :
	0x3fffff << PAGE_SHIFT
, which occupies 34 bits.

This patch changed 0x3fffff to 0x3ffff, which makes the range of stack
randomization is real 1GB.

Before this patch(bit0 ~ bit33 randomized):
	root@qemux86-64:~# for i in {1..20};do cat /proc/self/maps | grep stack;done
	7ffddf971000-7ffddf992000 rw-p 00000000 00:00 0                          [stack]
	7ffc4e0d4000-7ffc4e0f5000 rw-p 00000000 00:00 0                          [stack]
	7fff5898e000-7fff589af000 rw-p 00000000 00:00 0                          [stack]
	7ffcf910b000-7ffcf912c000 rw-p 00000000 00:00 0                          [stack]
	7ffce829d000-7ffce82be000 rw-p 00000000 00:00 0                          [stack]
	7ffec72d9000-7ffec72fa000 rw-p 00000000 00:00 0                          [stack]
	7ffd6e256000-7ffd6e277000 rw-p 00000000 00:00 0                          [stack]
	7ffe14120000-7ffe14141000 rw-p 00000000 00:00 0                          [stack]
	7ffe21549000-7ffe2156a000 rw-p 00000000 00:00 0                          [stack]
	7ffdc9d33000-7ffdc9d54000 rw-p 00000000 00:00 0                          [stack]
	7ffe1ced4000-7ffe1cef5000 rw-p 00000000 00:00 0                          [stack]
	7ffcb0440000-7ffcb0461000 rw-p 00000000 00:00 0                          [stack]
	7ffc84515000-7ffc84536000 rw-p 00000000 00:00 0                          [stack]
	7ffe557dd000-7ffe557fe000 rw-p 00000000 00:00 0                          [stack]
	7ffdcb7e4000-7ffdcb805000 rw-p 00000000 00:00 0                          [stack]
	7ffc6f989000-7ffc6f9aa000 rw-p 00000000 00:00 0                          [stack]
	7ffd9322a000-7ffd9324b000 rw-p 00000000 00:00 0                          [stack]
	7ffea8e34000-7ffea8e55000 rw-p 00000000 00:00 0                          [stack]
	7ffc594ff000-7ffc59520000 rw-p 00000000 00:00 0                          [stack]
	7ffe8db65000-7ffe8db86000 rw-p 00000000 00:00 0                          [stack]

After this patch(bit0 ~ bit29 randomized):
	root@qemux86-64:~# for i in {1..20};do cat /proc/self/maps | grep stack;done
	7fffd0ed2000-7fffd0ef3000 rw-p 00000000 00:00 0                          [stack]
	7fffdf555000-7fffdf576000 rw-p 00000000 00:00 0                          [stack]
	7ffffec0e000-7ffffec2f000 rw-p 00000000 00:00 0                          [stack]
	7fffcfa0f000-7fffcfa30000 rw-p 00000000 00:00 0                          [stack]
	7fffff75d000-7fffff77e000 rw-p 00000000 00:00 0                          [stack]
	7fffd1d11000-7fffd1d32000 rw-p 00000000 00:00 0                          [stack]
	7fffc7850000-7fffc7871000 rw-p 00000000 00:00 0                          [stack]
	7fffc956e000-7fffc958f000 rw-p 00000000 00:00 0                          [stack]
	7fffdf7be000-7fffdf7df000 rw-p 00000000 00:00 0                          [stack]
	7fffeffdf000-7ffff0000000 rw-p 00000000 00:00 0                          [stack]
	7fffd7d7f000-7fffd7da0000 rw-p 00000000 00:00 0                          [stack]
	7fffe3d23000-7fffe3d44000 rw-p 00000000 00:00 0                          [stack]
	7fffde4b7000-7fffde4d8000 rw-p 00000000 00:00 0                          [stack]
	7fffd477a000-7fffd479b000 rw-p 00000000 00:00 0                          [stack]
	7fffc0e95000-7fffc0eb6000 rw-p 00000000 00:00 0                          [stack]
	7fffdbdda000-7fffdbdfb000 rw-p 00000000 00:00 0                          [stack]
	7fffec737000-7fffec758000 rw-p 00000000 00:00 0                          [stack]
	7fffed163000-7fffed184000 rw-p 00000000 00:00 0                          [stack]
	7ffff9a9c000-7ffff9abd000 rw-p 00000000 00:00 0                          [stack]
	7fffff945000-7fffff966000 rw-p 00000000 00:00 0                          [stack]

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/x86/include/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 29fea180a665..0b7a5510ebd5 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -343,7 +343,7 @@ extern unsigned long get_sigframe_size(void);
 #else /* CONFIG_X86_32 */
 
 /* 1GB for 64bit, 8MB for 32bit */
-#define __STACK_RND_MASK(is32bit) ((is32bit) ? 0x7ff : 0x3fffff)
+#define __STACK_RND_MASK(is32bit) ((is32bit) ? 0x7ff : 0x3ffff)
 #define STACK_RND_MASK __STACK_RND_MASK(mmap_is_ia32())
 
 #define ARCH_DLINFO							\
-- 
2.30.2

