Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF14603FD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 05:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhK1EiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 23:38:02 -0500
Received: from smtpbg511.qq.com ([203.205.250.109]:40641 "EHLO
        smtpbg515.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344373AbhK1EgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 23:36:00 -0500
X-QQ-mid: bizesmtp42t1638071331tlejl57q
Received: from kali.lan (unknown [182.148.14.187])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 28 Nov 2021 11:48:50 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: lzF2rc3yiXUKJqz69H5sGeB+vsB0ngWtnRweRIvOWr47fdSr12MLNKP0bgQ9x
        hgsWnbJQV/Zle48c06ylLN19pORU99zUp1oUJHpm+vE7/iPafaTv6GiER7SckIVIt32wb28
        JWb+g9ifs/QVBY1BFtooVQRzsbXbXcU/Zxiijo9hsIgSyzB4HIevE9JCqkEHlgzNmsi3g2f
        FOD60PVx31Fm2gxHBB7bb3Sr4OVE8cntE9aBmsJiFb+laLW4OpUCPzaomcU7AI50n81RtGS
        ajrzSBzY7ARFNOBWRq4GsBphFDXXwsFYqN+j0vAzecFK3kmdS+fxKrgXfLMlgU+e7qUVNdE
        0/Ct1S8onpuiANaDlaocIbXEUEFnCHkIV5lgai0
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     monstr@monstr.eu
Cc:     wangborong@cdjrlc.com, linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: fix typo in a comment
Date:   Sun, 28 Nov 2021 11:48:23 +0800
Message-Id: <20211128034823.6930-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `was' is repeated in a comment. Consequently, remove one
`was' from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/microblaze/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index fc61eb0eb8dd..59f0af5ee042 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -11,7 +11,7 @@
  *
  * 1997-11-28 Modified for POSIX.1b signals by Richard Henderson
  *
- * This file was was derived from the sh version, arch/sh/kernel/signal.c
+ * This file was derived from the sh version, arch/sh/kernel/signal.c
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License. See the file COPYING in the main directory of this
-- 
2.33.0

